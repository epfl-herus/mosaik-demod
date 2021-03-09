"""
Mosaik interface for the example simulator.

"""
import mosaik_api


import sys

# need to specify the path of the simulator package
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
                'n_hh',  # the number of households in the group
            ],
        },
        'Household': {
            'public': False,
            'params': [],
            'attrs': [
                'P_out',
                'P_demand',  # Active power [W]
                'space_heating', # Power required for space heating [W]
                'DHW', # Power required for domestic hot water demand
                'num',  # Household number starting at 0
                'num_res',  # Number of residents per household
                'subgroup',  # A string determining the social subgroup simulated in the house
            ],
        },
    },
}


class LoadSimulator(mosaik_api.Simulator):
    _attr_to_getter = {
        'P_demand': 'get_power_demand',        
        'space_heating': 'get_target_space_heating', # Power required for space heating [W]
        'DHW': 'get_DHW_demand', # Power required for domestic hot water demand
        'num_res': 'get_n_res',  # Number of residents per household
        'subgroup': 'get_subgroup_dict',  # A string determining the social subgroup simulated in the house
        
    }
    def __init__(self):
        super().__init__(META)
        self.simulators = [] # should only instantiate once we know the inputs params in create method
        self.eid_prefix = 'LoadModel_'
        self.entities = {}  # Maps EIDs to model indices in self.simulator

    def init(self, sid, eid_prefix=None):
        if eid_prefix is not None:
            self.eid_prefix = eid_prefix
        return self.meta

    def create(self, num, model, sim_start, input_excell_file_path, number_households=None):
        if num != 1:
            raise ValueError('Can only create one set of households at a time.')

        # get values for the next entities
        next_eid = len(self.simulators)
        next_hid = sum([sim.n_households for sim in self.simulators])


        if model == 'HouseholdsGroup':
            # here we instantiate the new load simulator given some input file parameters
            new_load_simulator = simulators.load_simulators.LoadSimulator(
                input_excell_file_path, n_households=number_households)
            self.simulators.append(new_load_simulator)
        

        # creates the entitiy of the household groups, with the children being the households
        entity = {
            'eid': '%s%d' % (self.eid_prefix, next_eid),
            'type': model,
            'children': [{'eid': 'Household_%s' % hid, 'type': 'Household'} for hid in range(next_hid, next_hid + new_load_simulator.n_households)]
        }

        # create a mapping from the entity ID to the simulators 
        self.entities[entity['eid']] = next_eid
        # creates a mapping for the entitiy ID to their corresponding simulator and place in it
        for i, child in enumerate(entity['children']):
            self.entities[child['eid']] = (next_eid, i) 

        return [entity]

    def step(self, time, inputs=None):
        # Assume time is in seconds

        # TODO: get any necessary input and give them to the load simulator

        # Perform simulation step
        [sim.step() for sim in self.simulators]

        return time + 60  # Step size is 1 minute

    def get_data(self, outputs):
        data = {}  # stores the data for the output
        for eid, attrs in outputs.items():
            sim_id, hh_id = self.entities[eid]
            data[eid] = {}
            for attr in attrs:
                if attr not in self.meta['models']['Household']['attrs']:
                    raise ValueError('Unknown output attribute: %s' % attr)
                elif attr == 'P_out':
                    out = self.simulators[sim_id].get_power_demand()[hh_id]
                elif attr in self._attr_to_getter: # check if the attribute has a corresponding getter method             
                    method = getattr(self.simulators[sim_id], self._attr_to_getter[attr])
                    out = method()[hh_id]
                elif attr == 'num':  # id number
                    out = int(eid[10:])  # remove the beggining of the str
                else:
                    raise NotImplementedError('No implementation corresponds to output attribute: %s' % attr)
                # set the value to the out data
                data[eid][attr] = out
        return data


def main():
    return mosaik_api.start_simulation(LoadSimulator())


if __name__ == '__main__':
    main()