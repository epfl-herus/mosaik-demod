"""
Mosaik interface for the example simulator.

"""
from datetime import datetime
import numpy as np
import arrow
import mosaik_api

# need to specify the path of the simulator package
import sys
sys.path += ['C:\\Users\\Lio\\Documents\\Activity-based-demand-modelling']
import simulators


META = {
    'models': {
        'HouseholdsGroup': {
            'public': True,
            'params': [
                'sim_start',
                'number_households',
                'input_excell_file_path' # an excell file containing the informations on the group of households
            ],
            'attrs': [
                'n_hh',             # the number of households in the group
                'outside_temperature'
            ],
        },
        'Household': {
            'public': False,
            'params': [],
            'attrs': [
                'P_out',                # Total power required from the house [W]
                'P_demand',             # Same as P_out
                'SH',                   # Heat load required for Space Heating [W]
                'DHW',                  # Heat load required for Domestic Hot Water demand [W]
                'heat_demand',          # Total heat load require (DHW + SH) [W]
                'num',                  # Household number starting from 0
                'num_res',              # Number of residents in the household
                'subgroup',             # A string determining the social subgroup simulated in the household
                'external_heat_input',  # Heat received from an external heating system [W]
                'heating_system_T',     # The temperature of the water input from an external heating system
            ],
        },
    },
}


class LoadSimulator(mosaik_api.Simulator):
    """Load simulator adaptor for Mosaik.

    Can simulate different HouseholdsGroup.
    HouseholdsGroup have children objects Household.
    """
    # Dictionary converting the mosaik attributes to the load model functions
    _attr_to_getter = {
        'P_out':    'get_power_demand',
        'P_demand': 'get_power_demand',        
        'SH':       'get_target_space_heating', 
        'DHW':      'get_DHW_demand',       
        'num_res':  'get_n_res',
        'subgroup': 'get_subgroup_dict',    
    }
    # Dictionary converting the inputs to load model step function
    step_inputs_dict = {
        'outside_temperature': 'external_outside_temperature',
        'external_heat_input': 'external_heat_outputs',
    }
    def __init__(self):
        super().__init__(META)
        self.simulators = []  # Storage of the load simulators
        self.eid_prefix = 'LoadModel_'
        self.entities = {}  # Maps EIDs to load simulators indices in self.simulator
        self.children = {}  # Maps EIDs to simulators and corresponding household in self.simulator

    def init(self, sid, eid_prefix=None):
        """Initialize a Mosaik Load Simulator.
        """
        # Can override the load model prefix
        if eid_prefix is not None:
            self.eid_prefix = eid_prefix
        return self.meta

    def create(
        self, num, model, sim_start,
        input_excell_file_path, number_households=None, date_format='YYYY-MM-DD HH:mm:ss'):
        """Creates a group of households. Each household can be individually accessed using
        the children property of the HouseholdGroup.

        Args:
            num (int): Number of household Groups to create. Must be 1.
            model (model): The model to create. Must be 'HouseholdsGroup'
            sim_start (str): The beggining of the simulation.
            input_excell_file_path (str): Access path for the model inputs.
            number_households (int, optional): The number of households to create. If not given, will read the number from the input_excell_file. Defaults to None.

        Raises:
            ValueError: [description]

        Returns:
            [type]: [description]
        """
        if num != 1:
            raise ValueError('Can only create one set of households at a time.')

        # Get id values for the new entities to create
        next_eid = len(self.simulators)
        next_hid = sum([sim.n_households for sim in self.simulators])

        # Parse the date
        # TODO: check if there is a better way of getting the date.
        arrow_sim_start = arrow.get(sim_start, date_format)
        start_datetime = arrow_sim_start.datetime

        # Creates the load simulator corresponding to the  HouseholdsGroup entity
        if model == 'HouseholdsGroup':
            # Instantiate the new load simulator given the specified inputs. (kwargs will override the excell values)
            new_load_simulator = simulators.load_simulators.LoadSimulator(
                model_params    =input_excell_file_path,
                n_households    =number_households,
                start_date      =start_datetime)
            self.simulators.append(new_load_simulator)
        elif model == 'Household':
            raise TypeError('Cannot create a single Household. Try creating a HouseholdGroup with 1 household instead.')
        else:
            raise TypeError('Only HouseholdsGroup model type can be created.')
        

        # Creates the entity of the HouseholdsGroup, with the children being the Household
        entity = {
            'eid': '%s%d' % (self.eid_prefix, next_eid),
            'type': model,
            'children': [{'eid': 'Household_%s' % hid, 'type': 'Household'} for hid in range(next_hid, next_hid + new_load_simulator.n_households)]
        }

        # Create a mapping from the entity ID to the simulators 
        self.entities[entity['eid']] = next_eid
        # Creates a mapping for the entitiy ID to their corresponding load simulator and their position in it
        for i, child in enumerate(entity['children']):
            self.children[child['eid']] = (next_eid, i) 

        return [entity]

    def step(self, time, inputs=None):

        # Perform simple simulation step
        if inputs is None:
            [sim.step() for sim in self.simulators]

        else:
            # must reconstruct vectorized inputs for each group of households
            # creates the arrays from the inputs
            inputs_dic = self.step_inputs_dict
            inputs_names = list(inputs_dic.values())

            # creates a dictionary with the inputs for each load simulator
            inputs_list = [
                {} for s in self.simulators]
            #inputs_list = [
            #    {n: np.nan*np.empty(shape=s.n_households) for n in inputs_names}
            #    for s in self.simulators]

            # remove from inputs_list the attr not specified in inputs


            for eid, attrs in inputs.items():
                for name, values in attrs.items():
                    # values are list for the whole household, use them directly
                    if len(values) > 1:
                        raise ValueError('An HouseholdsGroup can recieve the same attribute only from a single group as input. Received ' + str(values))
                    elif len(values) < 1:
                        raise ValueError('No data received for ' + name)
                    else: # only a single input source
                        val = list(values.values())[0] # extract the single value from values dict
                        # split whether the entity is group of household
                        if eid in self.entities:  # householdgroup => list or int input
                            sim_id = self.entities[eid]
                            inputs_list[sim_id][inputs_dic[name]] = np.array(val)
                        elif eid in self.children:  # household => reconstruct the arrays
                            sim_id, hh_id = self.children[eid]
                            if not (inputs_dic[name] in inputs_list[sim_id]):
                                # assign the array
                                inputs_list[sim_id][inputs_dic[name]] = np.empty(self.simulators[sim_id].n_households)
                            inputs_list[sim_id][inputs_dic[name]][hh_id] = val
                        else:
                            raise ValueError('%s not registered in %s' % (eid, str(self)))
            
            # unpacks the inputs for the simulators step function
            #print(inputs)
            #print(inputs_list)
            #print(type(inputs_list))
            [sim.step(**i) for sim, i in zip(self.simulators, inputs_list)]  


        return time + 60  # Step size is 1 minute, assume time is in seconds

    def get_data(self, outputs):
        """ get_data method for mosaik.
        Accesses the load simulator getter functions to retrieve the data and pass it in mosaik format.
        """
        data = {}  # storage for the data requested for the output
        for eid, attrs in outputs.items():
            
            # Get the requested entity
            if eid in self.entities:
                # Gets an HouseholdsGroup
                sim_id = self.entities[eid]
                hh_id = None
            elif eid in self.children:
                # Gets an Household
                sim_id, hh_id = self.children[eid]
            else:
                raise ValueError('%s not registered in %s' % (eid, str(self)))

            data[eid] = {}
            # Handles the attributes with different methods
            for attr in attrs:
                # Check the attribute is a known attribute
                if attr not in self.meta['models']['Household']['attrs']:
                    raise ValueError('Unknown output attribute: %s' % attr)
                # Case: a mapping exists between the households and the attributes
                elif attr in self._attr_to_getter: # check if the attribute has a corresponding getter method             
                    method = getattr(self.simulators[sim_id], self._attr_to_getter[attr])
                    out = method(hh_id)
                elif attr == 'heating_system_T':  # id number
                    raise NotImplementedError('Must choose a temperature.')
                elif attr == 'num':  # id number
                    out = int(eid[10:])  # remove the beggining of the str
                elif attr == 'external_heat_input':
                    raise ValueError('external_heat_input cannot be access, but only used as input for the LoadSimulator.')
                # If we have not implemented this attribute
                else:
                    raise NotImplementedError('No implementation corresponds to output attribute: %s' % attr)
                # Set the value to the out data
                data[eid][attr] = out

        return data


def main():
    return mosaik_api.start_simulation(LoadSimulator())


if __name__ == '__main__':
    main()