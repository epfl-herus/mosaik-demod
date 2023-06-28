"""Mosaik Simulators adaptation example.

It is possible to adapt any class from demod into mosaik
using the structure shown in this file.
"""
from mosaikdemod.adaptors import (
    AbstractHouseholdsModule, AbstractSingleValueModule
)

import sys
# insert at 1, 0 is the script path (or '' in REPL)
sys.path.insert(1, r'C:\Users\barsanti.INTRANET\Desktop\PhD\3_CODEs\demod-private-Matteo')

from demod.simulators.crest_simulators import Crest4StatesModel
from demod.simulators.appliance_simulators import SubgroupApplianceSimulator
from demod.simulators.lighting_simulators import CrestLightingSimulator
from demod.simulators.weather_simulators import CrestIrradianceSimulator
from demod.simulators.load_simulators import LoadSimulator

import numpy as np




class OccupancySimulator(AbstractHouseholdsModule):
    attributes_dict = {
        'active_occupancy': 'get_active_occupancy',
    }
    step_inputs_dict = {}
    def __init__(
        self,
        simulated_component='Activity',
        demod_simulator_class=Crest4StatesModel,
        step_size= 10*60  # 10 minutes
    ):
        super().__init__(simulated_component, demod_simulator_class, step_size)


class AppliancesSimulator(AbstractHouseholdsModule):
    attributes_dict = {
            'power': 'get_power_demand',
            'DHW': 'get_DHW_demand', # Power required for domestic hot water demand
        }
    step_inputs_dict = {
            'active_occupancy': 'active_occupancy'
        }
    def __init__(
        self,
        simulated_component='Appliances',
        demod_simulator_class=SubgroupApplianceSimulator,
        step_size=60  # minute step size
    ):
        super().__init__(simulated_component, demod_simulator_class, step_size)


class LightingSimulator(AbstractHouseholdsModule):
    attributes_dict = {
            'power': 'get_power_demand',
        }
    step_inputs_dict = {
            'active_occupancy': 'active_occupancy',
            'irradiance': 'irradiance'
        }
    def __init__(
        self,
        simulated_component='Lighting',
        demod_simulator_class=CrestLightingSimulator,
        step_size=60  # minute step size
    ):
        super().__init__(simulated_component, demod_simulator_class, step_size)

class IrradianceSimulator(AbstractSingleValueModule):
    attributes_dict = {
            'irradiance': 'get_irradiance',
        }
    step_inputs_dict = {
        }
    def __init__(
        self,
        simulated_component='Irradiance',
        default_simulator=CrestIrradianceSimulator,
        step_size=60  # minute step size
    ):
        super().__init__(simulated_component, default_simulator, step_size)


class MosaikLoadSimulator(AbstractHouseholdsModule):
    """Load simulator that could be used in Mosaik.

    Was used for the dfg tp2 integration.
    Should be cleaned if possible.
    """
    attributes_dict = {
        'P_out':            'get_power_demand',
        'P_demand':         'get_power_demand',
        'SH_demand':        'get_sh_heat_demand',
        'DHW_demand':       'get_dhw_heat_demand',
        'heat_demand':      'get_total_heat_demand',
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
            'heat_demand': 'heat_demand'},
        'external_SH_input': {
            'SH_demand': 'sh_demand'},
        'external_DHW_input': {
            'DHW_demand': 'dhw_demand'},
    }

    def __init__(
        self,
        simulated_component='',  # load is the full load, not a component
        demod_simulator_class=LoadSimulator,
        step_size=60  # 1 minute
    ):

        super().__init__(simulated_component, demod_simulator_class, step_size)
        self.sid = 'LoadSimulator'

    def step(self, time, inputs=None,  max_advance=None):
        """Special step methods that can handle asynch returns."""

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

                                method = getattr(self.simulators[sim_id], self.attributes_dict[dest_attr])

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
                elif attr in self.attributes_dict: # check if the attribute has a corresponding getter method
                    method = getattr(self.simulators[sim_id], self.attributes_dict[attr])
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
