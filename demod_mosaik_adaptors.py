import mosaik_api

import numpy as np

META_ABSTRACT = {
    'models': {},
}

class AbstractHouseholdsModule(mosaik_api.Simulator):
    """Abstract adaptor class for linking demod simulators to mosaik.

    Children classes of this class need to implement very few things to work:
    - what to implememnt

    Attributes:
        attributes_dict: A dictionary mapping the attr for mosaik
            to the name of
            the method to be called on demod simulators
            Must be of the form: {
                'attr1': 'get_attr1',
                'power': 'get_power_consumption_example',
                ...
            }
        step_inputs_dict: the dictionary mapping the attr for mosaik to the name of
            the arguments of the step method in our simulators.
            (step method in our simulators works differently from mosaik)
            Must be of the form: {
                'attr1': 'attr1',
                'power': 'power_consumption',
                ...
            }
    """

    attributes_dict = {}
    step_inputs_dict = {}

    def _generate_meta(self):
        """Generate the meta file of the simulator."""
        # copy the meta abstract file
        meta = META_ABSTRACT.copy()
        # add models that the simulator should create
        meta['models'][self.eid_prefix] = {}
        meta['models'][self.cid_prefix] = {}
        # makes the group public and the child private
        meta['models'][self.eid_prefix]['public'] = True
        meta['models'][self.cid_prefix]['public'] = False
        # set the parameters of creation for the mosaik entities
        meta['models'][self.eid_prefix]['params'] = ['inputs_params']
        meta['models'][self.cid_prefix]['params'] = []
        # give them the attributes corresponding to the type of simulator
        meta['models'][self.eid_prefix]['attrs'] = (
            list(self.attributes_dict.keys())
            + list(self.step_inputs_dict.keys())
        )
        meta['models'][self.cid_prefix]['attrs'] = (
            list(self.attributes_dict.keys())
            + list(self.step_inputs_dict.keys())
        )

        return meta

    def __init__(self, simulated_component, demod_simulator_class, step_size):
        """Create a mosaik simulator object.

        Args:
            simulated_component (str): The  name of the simulated component.
        """
        # empty list to store the simulators corresponding to the entities
        self.simulators = []
        # entity id
        self.eid_prefix = ''.join(['HouseholdsGroup', simulated_component])
        # child id
        self.cid_prefix = ''.join(['Household', simulated_component])
        # Maps EIDs to model indices in self.simulator
        self.entities = {}
        # Maps EIDs to model children indices in self.simulator
        self.children = {}
        # Remember what component is simulated
        self.demod_simulator_class = demod_simulator_class
        # Step size of the simulator
        self.step_size = step_size

        meta = self._generate_meta()
        super().__init__(meta)

    def init(self, sid, eid_prefix=None):
        if eid_prefix is not None:
            self.eid_prefix = eid_prefix
        return self.meta

    def create(
        self,
        num, model,
        inputs_params
    ):
        """Create a householdGroup entitiy corresponding to the inputs.

        Values for the args given here.

        Args:
            num (int): The number of group of households. Must be 1.
            model (str): The type of model to create.
            inputs_params: The inputs of the demod simulator related
                to the mosaik entities.

        Raises:
            ValueError: [description]

        Returns:
            list: List containing the entity created.
        """
        if num != 1:
            raise ValueError('Can only create one group of households at a time.')

        # get values for the next entities
        next_eid = len(self.simulators)
        next_hid = sum([sim.n_households for sim in self.simulators])


        # here we instantiate the new simulator given some input file parameters
        new_simulator = self.demod_simulator_class(**inputs_params)
        self.simulators.append(new_simulator)

        # creates the entitiy of the household groups, with the children being the households
        entity = {
            'eid': '%s_%d' % (self.eid_prefix, next_eid),
            'type': model,
            'children': [
                {
                    'eid': self.cid_prefix + '_%s' % hid,
                    'type': self.cid_prefix
                } for hid in
                range(next_hid, next_hid + new_simulator.n_households)
            ]
        }

        # create a mapping from the entity ID to the simulators
        self.entities[entity['eid']] = next_eid
        # creates a mapping for the entitiy ID to their corresponding simulator and place in it
        for i, child in enumerate(entity['children']):
            self.children[child['eid']] = (next_eid, i)

        return [entity]

    def step(self, time, inputs=None):
        # Assume time is in seconds

        # Perform simple simulation step
        if inputs is None:
            [sim.step() for sim in self.simulators]

        else: # must reconstruct vectorized inputs for each group of households
            # creates the arrays from the inputs
            inputs_dic = self.step_inputs_dict
            inputs_names = list(inputs_dic.values())

            # creates a dictionarry with the inputs for each simulator
            inputs_list = [{n: np.nan*np.empty(shape=s.n_households) for n in inputs_names} for s in self.simulators]


            for eid, attrs in inputs.items():
                for name, values in attrs.items():
                    # values are list for the whole household, use them directly
                    if len(values) > 1:
                        raise ValueError('An household group can recieve the same attribute only from a single group as input. Received ' + str(values))
                    elif len(values) < 1:
                        raise ValueError('No data received for ' + name)
                    else: # only a single input
                        val = list(values.values())[0] # extract the single value from values dict
                        # split whether the entity is group of household
                        if eid in self.entities:
                            sim_id = self.entities[eid]
                            inputs_list[sim_id][inputs_dic[name]] = np.array(val)
                        elif eid in self.children:
                            sim_id, hh_id = self.children[eid]
                            # reconstruut the arrays
                            inputs_list[sim_id][inputs_dic[name]][hh_id] = val
                        else:
                            raise ValueError('%s not registered in %s' % (eid, str(self)))

            # unpacks the inputs for the simulators step function
            # print(inputs_list)
            # print(type(inputs_list))
            [sim.step(**i) for sim, i in zip(self.simulators, inputs_list)]

        return time + self.step_size  # Step size

    def get_data(self, outputs):
        data = {}  # stores the data for the output
        # TODO imporove the implementation of this, to perform less calls uusing method()
        for eid, attrs in outputs.items():
            data[eid] = {}
            # check if accessing data for a group or a household
            if eid in self.entities:
                sim_id = self.entities[eid]
                hh_id = None
            elif eid in self.children:
                sim_id, hh_id = self.children[eid]
            else:
                raise ValueError('%s not registered in %s' % (eid, str(self)))

            for attr in attrs:
                if (attr not in self.meta['models'][self.eid_prefix]['attrs']) and (attr not in self.meta['models'][self.eid_prefix]['attrs']):
                    raise ValueError('Unknown output attribute: %s' % attr)
                elif attr in self.attributes_dict: # check if the attribute has a corresponding getter method
                    method = getattr(self.simulators[sim_id], self.attributes_dict[attr])
                    if hh_id == None:
                        out = [ int(i) for i in method() ]
                    else:
                        out = int(method()[hh_id])
                else:
                    raise NotImplementedError('No implementation corresponds to output attribute: %s' % attr)
                # set the value to the out data
                data[eid][attr] = out
        return data

class AbstractSingleValueModule(mosaik_api.Simulator):
    """Abstract adaptor class for linking demod simulators to mosaik.

    Children classes of this class need to implement very few things to work:
    - what to implememnt

    Attributes:
        attributes_dict: A dictionary mapping the attr for mosaik
            to the name of
            the method to be called on demod simulators
            Must be of the form: {
                'attr1': 'get_attr1',
                'power': 'get_power_consumption_example',
                ...
            }
        step_inputs_dict: the dictionary mapping the attr for mosaik to the name of
            the arguments of the step method in our simulators.
            (step method in our simulators works differently from mosaik)
            Must be of the form: {
                'attr1': 'attr1',
                'power': 'power_consumption',
                ...
            }
    """
    attributes_dict = {}
    step_inputs_dict = {}

    def _generate_meta(self):
        # generates the meta file

        # copy the meta abstract file
        meta = META_ABSTRACT.copy()
        # add models that the simulator should create
        meta['models'][self.eid_prefix] = {}
        meta['models'][self.eid_prefix]['public'] = True
        # set the parameters of creation for the simulator
        meta['models'][self.eid_prefix]['params'] = [
            'sim_start', # the beggining of the simulation
            'inputs_params',  # a dictionary with the inputs or an excell file containing the simulation parameters
            'simulator_class',  # the simulator class to instantiate
        ]
        # give them the attributes corresponding to the type of simulator
        meta['models'][self.eid_prefix]['attrs'] = list(self.attributes_dict.keys()) + list(self.step_inputs_dict.keys())

        return meta

    def __init__(self, simulated_component, demod_simulator_class, step_size):
        """Create a simulator object.

        Args:

            simulated_component (str): The  name of the simulated component.
        """

        self.simulators = []  # empty list to store the simulators corresponding to the entities
        self.eid_prefix = simulated_component
        self.entities = {}  # Maps EIDs to model indices in self.simulator
        self.demod_simulator_class = demod_simulator_class
        self.step_size = step_size

        meta = self._generate_meta()
        super().__init__(meta)

    def init(self, sid, eid_prefix=None):
        if eid_prefix is not None:
            self.eid_prefix = eid_prefix
        return self.meta

    def create(
        self,
        num, model,
        inputs_params
    ):
        """Create a householdGroup entitiy corresponding to the inputs.

        Values for the args given here.

        Args:
            num (int): The number of group of households. Must be 1.
            model (str): The type of model to create.
            inputs_params: The inputs of the demod simulator related
                to the mosaik entities.

        Raises:
            ValueError: [description]

        Returns:
            list: List containing the entity created.
        """
        if num != 1:
            raise ValueError('Can only create one group of households at a time.')

        # get values for the next entities
        next_eid = len(self.simulators)

        # Here we instantiate the new simulator given some input file parameters
        new_simulator = self.demod_simulator_class(**inputs_params)
        self.simulators.append(new_simulator)

        # creates the entitiy of the simulator
        entity = {
            'eid': '%s_%d' % (self.eid_prefix, next_eid),
            'type': model,
        }

        # create a mapping from the entity ID to the simulators
        self.entities[entity['eid']] = next_eid

        return [entity]

    def step(self, time, inputs=None):
        # Assume time is in seconds

        # Perform simple simulation step
        if inputs is None:
            [sim.step() for sim in self.simulators]

        else:
            inputs_dic = self.step_inputs_dict
            inputs_names = list(inputs_dic.values())

            # creates a dictionarry with the inputs for each simulator
            inputs_list = [{n: np.nan*np.empty(shape=s.n_households) for n in inputs_names} for s in self.simulators]


            for eid, attrs in inputs.items():
                for name, values in attrs.items():
                    # values are list for the whole household, use them directly
                    if len(values) > 1:
                        raise ValueError(name + ' can recieve the same attribute only from a single group as input. Received ' + str(values))
                    elif len(values) < 1:
                        raise ValueError('No data received for ' + name)
                    else: # only a single input
                        val = list(values.values())[0] # extract the single value from values dict
                        # split whether the entity is group of household
                        if eid in self.entities:
                            sim_id = self.entities[eid]
                            inputs_list[sim_id][inputs_dic[name]] = np.array(val)
                        else:
                            raise ValueError('%s not registered in %s' % (eid, str(self)))

            # unpacks the inputs for the simulators step function
            # print(inputs_list)
            # print(type(inputs_list))
            [sim.step(**i) for sim, i in zip(self.simulators, inputs_list)]

        return time + self.step_size  # Step size

    def get_data(self, outputs):
        data = {}  # stores the data for the output
        # TODO imporove the implementation of this, to perform less calls uusing method()
        for eid, attrs in outputs.items():
            data[eid] = {}
            # check if accessing data for a group or a household
            if eid in self.entities:
                sim_id = self.entities[eid]
            else:
                raise ValueError('%s not registered in %s' % (eid, str(self)))

            for attr in attrs:
                if (attr not in self.meta['models'][self.eid_prefix]['attrs']) and (attr not in self.meta['models'][self.eid_prefix]['attrs']):
                    raise ValueError('Unknown output attribute: %s' % attr)
                elif attr in self.attributes_dict: # check if the attribute has a corresponding getter method
                    method = getattr(self.simulators[sim_id], self.attributes_dict[attr])
                    out = [ int(i) for i in method() ]
                else:
                    raise NotImplementedError('No implementation corresponds to output attribute: %s' % attr)
                # set the value to the out data
                data[eid][attr] = out
        return data
