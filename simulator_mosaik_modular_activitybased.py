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

from demod.simulators.load_simulators import LoadSimulator, LoadSimulatorMosaik
from demod.simulators.weather_simulators import CrestIrradianceSimulator

import numpy as np


        
class LoadSimulator(AbstractHouseholdsModule):
    attributes_dict = {
        'active_occupancy': 'get_active_occupancy',
        'activity_states':'get_activity_states',
        'power': 'get_power_demand',
    }
    step_inputs_dict = {}
    def __init__(
        self,
        simulated_component='Load',
        demod_simulator_class=LoadSimulatorMosaik,
        step_size= 60  # 10 minutes
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


