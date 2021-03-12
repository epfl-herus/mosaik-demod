

import mosaik
import datetime

# Sim config. and other parameters
SIM_CONFIG = {
    'LoadSimulator': {
        'python': 'simulator_mosaik:LoadSimulator',
    },
    'Collector': {
        'cmd': 'python collector.py %(addr)s',
    },
    'LoadSimulator2':{
        'cmd': '%(python)s simulator_mosaik.py %(addr)s'
    },
    'ActivitySimulator': {
        'python': 'simulator_mosaik_modular:ActivitySimulator',
    },
    'ApplianceSimulator':{
        'python': 'simulator_mosaik_modular:AppliancesSimulator',
    },
    'LightingSimulator':{
        'python': 'simulator_mosaik_modular:LightingSimulator',
    },
    'IrradianceSimulator':{
        'python': 'simulator_mosaik_modular:IrradianceSimulator',
    },
}
END = 1 * 60 * 60  # 1 = 1 second


world = mosaik.World(SIM_CONFIG)


examplesim = world.start('LoadSimulator')

collector = world.start('Collector', step_size=10*60) # every 10 minutes
load_sim = world.start('LoadSimulator2')
activity_sim = world.start('ActivitySimulator')
app_sim = world.start('ApplianceSimulator')
ligth_sim = world.start('LightingSimulator')
irradiance_sim = world.start('IrradianceSimulator')


n_households = 50

model = examplesim.HouseholdsGroup(input_excell_file_path='inputs.xlsx', sim_start='2010-01-01 00:00:00')
model2 = load_sim.HouseholdsGroup(input_excell_file_path='inputs.xlsx', sim_start='2009-01-01 00:00:00')

monitor = collector.Monitor()

activity = activity_sim.HouseholdsGroupActivity(inputs_params={
    'n_households': n_households, 'day_type': 'd'
}, sim_start=0)
appliances = app_sim.HouseholdsGroupAppliances(
    inputs_params={
        'subgroup_kwargs_list': [{'n_residents': 2}],
        'n_hh_list': [n_households]
    }
)
ligthing = ligth_sim.HouseholdsGroupLighting(inputs_params={'n_households': n_households,})
irradiance = irradiance_sim.Irradiance(inputs_params={'longitude':32.1, 'latitude':21.3, 'meridian':17.4,
        'date_time': datetime.datetime.now(),})

# world.connect(model, monitor, 'val', 'delta')

import mosaik.util

houses = model.children
print('*********************')

#world.connect(houses[0], monitor,('P_demand', 'delta'))

mosaik.util.connect_many_to_one(world, houses, monitor, 'P_demand')
mosaik.util.connect_many_to_one(world, model2.children, monitor, 'P_demand')
mosaik.util.connect_many_to_one(world, activity.children, monitor, 'active_occupancy')
world.connect(activity, monitor, 'active_occupancy')
world.connect(appliances, monitor, 'power')


mosaik.util.connect_randomly(world, activity.children, appliances.children, 'active_occupancy', evenly=True)

mosaik.util.connect_randomly(world, activity.children, ligthing.children, 'active_occupancy', evenly=True)
world.connect(irradiance, ligthing, 'irradiance')


world.run(until=END)