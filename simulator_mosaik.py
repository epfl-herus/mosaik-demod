"""
Mosaik interface for demod load simulator.

"""
import numpy as np
import arrow
import mosaik_api

# need to specify the path of the simulator package
import sys
sys.path += ['C:\\Users\\Lio\\Documents\\Activity-based-demand-modelling']
from demod import simulators
from demod.datasets.Germany.loader import GermanDataHerus


META = {
    'models': {
        'HouseholdsGroup': {
            'public': True,
            'params': [
                'sim_start',
                'number_households',
                'include_climate',  # Wheter the load simulator should use the climate
                'data',
                'input_excell_file_path', # an excell file that will be converted to a dataset
            ],
            'attrs': [
                'n_hh',             # the number of households in the group
                'outside_temperature',
                'outside_irradiance',
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
                'external_SH_input',
                'external_DHW_input',
                'SH_demand',
                'DHW_demand',
                'external_cylinder_T'
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
        'P_out':            'get_power_demand',
        'P_demand':         'get_power_demand',
        'SH_demand':        'get_sh_heat_demand',
        'DHW_demand':       'get_dhw_heat_demand',
        'heat_demand':      'get_total_heat_demand',
        'num_res':          'get_n_res',
        'subgroup':         'get_subgroup_dict',
    }
    # Dictionary converting the inputs to load model step function
    step_inputs_dict = {
        'outside_temperature': 'external_outside_temperature',
        'outside_irradiance': 'external_irradiance',
        'external_heat_input': 'external_heat_outputs',
        'external_DHW_input': 'external_dhw_outputs',
        'external_SH_input': 'external_sh_outputs',
        'external_cylinder_T': 'external_cylinder_temperature',
    }
    # if the input attribute is given, will return the mapped attributes
    _asynch_returns = {
        'external_heat_input': {  # for external heating system control
            'heat_demand':  'heat_demand'},
        'external_SH_input': {
            'SH_demand': 'sh_demand'},
        'external_DHW_input': {
            'DHW_demand': 'dhw_demand'},

        # 'input_attr': {
        #       'attr_to_pass1': 'name_of_attr_in_target1',
        #       'attr_to_pass2': 'name_of_attr_in_target2',
        #       ...
        # }
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
        self.sid = sid
        # Can override the load model prefix
        if eid_prefix is not None:
            self.eid_prefix = eid_prefix
        return self.meta

    def create(
        self, num, model, sim_start,
        input_excell_file_path=None,
        number_households=None,
        include_climate=True,
        date_format='YYYY-MM-DD HH:mm:ss',
        data=GermanDataHerus('v0.1'),
        ):
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
        # Make sure we use naive datetime
        arrow_sim_start = arrow.get(sim_start, date_format)
        start_datetime = arrow_sim_start.datetime.replace(tzinfo=None)

        if input_excell_file_path is not None:
            raise NotImplementedError(
                'Mosaik Demod adaptor does not support excell input files yet'
                )
            from demod.datasets.ExcellInputFile.loader import InputFileLoader
            data = InputFileLoader(input_excell_file_path)


        # Creates the load simulator corresponding to the  HouseholdsGroup entity
        if model == 'HouseholdsGroup':
            # Instantiate the new load simulator given the specified inputs. (kwargs will override the excell values)
            new_load_simulator = simulators.load_simulators.LoadSimulator(
                n_households    =number_households,
                start_datetime  =start_datetime,
                data            =data,
                include_climate =include_climate
            )
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
            # remove from inputs_list the attr not specified in inputs ==> they are not included anymore


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
                                inputs_list[sim_id][inputs_dic[name]] = np.full(self.simulators[sim_id].n_households, np.nan)
                            # fill the array
                            inputs_list[sim_id][inputs_dic[name]][hh_id] = val
                        else:
                            raise ValueError('%s not registered in %s' % (eid, str(self)))

            # unpacks the inputs for the simulators step function
            #print(inputs)
            #print(inputs_list)
            #print(type(inputs_list))
            [sim.step(**i) for sim, i in zip(self.simulators, inputs_list)]

            # now check for asynch requests

            # stores the asynch commands of an external heating system
            commands = {}
            # print(' Input received', inputs)
            for eid, attrs in inputs.items():
                eid_fullname = ''.join((self.sid, '.', eid))
                for attr, values in attrs.items():
                    # check which variables require asynchronous reutrns
                    if attr in self._asynch_returns:
                        # will need todo asynch set_data

                        # check if it is a household or hh
                        sim_id, hh_id = self._get_entity_sim_and_hh(eid)
                        for input_eid, value in values.items():
                            if eid_fullname not in commands:
                                commands[eid_fullname] = {}
                            if input_eid not in commands[eid_fullname]:
                                commands[eid_fullname][input_eid] = {}
                            for dest_attr, dest_attr_name in self._asynch_returns[attr].items():

                                method = getattr(self.simulators[sim_id], self._attr_to_getter[dest_attr])

                                if hh_id is not None: # pass the household
                                    commands[eid_fullname][input_eid][dest_attr_name] = method(hh_id)
                                else: # pass the household group
                                    commands[eid_fullname][input_eid][dest_attr_name] = list(method())
            # print('Commands sent: ', commands)
            yield self.mosaik.set_data(commands)

        return time + 60  # Step size is 1 minute, assume time is in seconds


    def _get_entity_sim_and_hh(self, eid):
        """Maps the entitiy id to its positions in internal simulators and households groups.
        The household id refers to the position in the simulator.
        household id is None if the entity is a HouseholdGroup.

        Args:
            eid (entity): A mosaik entity

        Raises:
            ValueError: If the entity is not known

        Returns:
            tuple: (simulator_id, household_id)
        """

        if eid in self.entities:
            # Gets an HouseholdsGroup
            sim_id = self.entities[eid]
            hh_id = None
        elif eid in self.children:
            # Gets an Household
            sim_id, hh_id = self.children[eid]
        else:
            raise ValueError('%s not registered in %s' % (eid, str(self)))

        return sim_id, hh_id

    def get_data(self, outputs):
        """ get_data method for mosaik.
        Accesses the load simulator getter functions to retrieve the data and pass it in mosaik format.
        """
        data = {}  # storage for the data requested for the output
        for eid, attrs in outputs.items():

            # Get the requested entity simulator and household
            sim_id, hh_id = self._get_entity_sim_and_hh(eid)

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