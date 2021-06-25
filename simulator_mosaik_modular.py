"""Mosaik Simulators adaptation example.

It is possible to adapt any class from demod into mosaik
using the structure shown in this file.
"""
from mosaikdemod.adaptors import (
    AbstractHouseholdsModule, AbstractSingleValueModule
)

import demod




class OccupancySimulator(AbstractHouseholdsModule):
    attributes_dict = {
            'active_occupancy': 'get_active_occupancy',
            'space_heating': 'get_target_space_heating', # Power required for space heating [W]
            'DHW': 'get_DHW_demand', # Power required for domestic hot water demand
            'num_res': 'get_n_res',  # Number of residents per household
            'subgroup': 'get_subgroup_dict',  # A string determining the social subgroup simulated in the house
        }
    step_inputs_dict = {}
    def __init__(
        self,
        simulated_component='Activity',
        demod_simulator_class=demod.simulators.crest_simulators.Crest4StatesModel,
        step_size= 10*60  # 10 minutes
    ):
        super().__init__(simulated_component, demod_simulator_class, step_size)


class AppliancesSimulator(AbstractHouseholdsModule):
    attributes_dict = {
            'power': 'get_power_demand',
        }
    step_inputs_dict = {
            'active_occupancy': 'active_occupancy'
        }
    def __init__(
        self,
        simulated_component='Appliances',
        demod_simulator_class=demod.simulators.appliance_simulators.SubgroupApplianceSimulator,
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
        demod_simulator_class=demod.simulators.lighting_simulators.CrestLightingSimulator,
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
        default_simulator=demod.simulators.weather_simulators.CrestIrradianceSimulator,
        step_size=60  # minute step size
    ):
        super().__init__(simulated_component, default_simulator, step_size)
