import random
import datetime

from mosaik.util import connect_randomly, connect_many_to_one
import mosaik



sim_config = {
    'CSV': {
        'python': 'mosaik_csv:CSV',
    },
    'DB': {
        'cmd': 'mosaik-hdf5 %(addr)s',
    },
    'ActivitySimulator': {
        'python': 'simulator_mosaik_household:ActivitySimulator',
    },
    'ApplianceSimulator':{
        'python': 'simulator_mosaik_household:AppliancesSimulator',
    },
    'LightingSimulator':{
        'python': 'simulator_mosaik_household:LightingSimulator',
    },
    'IrradianceSimulator':{
        'python': 'simulator_mosaik_household:IrradianceSimulator',
    },
    'PyPower': {
        'python': 'mosaik_pypower.mosaik:PyPower',
        # 'cmd': 'mosaik-pypower %(addr)s',
    },
    'WebVis': {
        'cmd': 'mosaik-web -s 0.0.0.0:8000 %(addr)s',
    },
}

START = '2014-01-01 00:00:00'
END = 31 * 24 * 3600  # 1 day
PV_DATA = 'data/pv_10kw.csv'
PROFILE_FILE = 'data/profiles.data.gz'
GRID_NAME = 'demo_lv_grid'
GRID_FILE = 'data/%s.json' % GRID_NAME


def main():
    random.seed(23)
    world = mosaik.World(sim_config)
    create_scenario(world)
    world.run(until=END)  # As fast as possilbe
    # world.run(until=END, rt_factor=1/60)  # Real-time 1min -> 1sec


def create_scenario(world):
    # Start simulators
    pypower = world.start('PyPower', step_size=15*60)

    appsim = world.start('ApplianceSimulator')
    lightsim = world.start('LightingSimulator')
    irrsim = world.start('IrradianceSimulator')
    actsim = world.start('ActivitySimulator')

    pvsim = world.start('CSV', sim_start=START, datafile=PV_DATA)

    n_households = 40
    # Instantiate models
    grid = pypower.Grid(gridfile=GRID_FILE).children
    activity = actsim.HouseholdsGroupActivity(
        inputs_params={
            'n_households': n_households, 'day_type': 'd'
        })
    appliances = appsim.HouseholdsGroupAppliances(
        inputs_params={
            'subgroup_kwargs_list': [{'n_residents': 2}],
            'n_hh_list': [n_households]
        }
    )
    ligthing = lightsim.HouseholdsGroupLighting(inputs_params={'n_households': n_households,})
    irradiance = irrsim.Irradiance(inputs_params={'longitude':32.1, 'latitude':21.3, 'meridian':17.4,
            'date_time': datetime.datetime.now(),})
    pvs = pvsim.PV.create(20)

    # Connect entities
    connect_randomly(world, appliances.children, [e for e in grid if 'node' in e.eid], ('power', 'P') )
    connect_randomly(world, pvs, [e for e in grid if 'node' in e.eid], 'P')
    world.connect(activity, appliances, 'active_occupancy')
    world.connect(activity, ligthing, 'active_occupancy')
    world.connect(irradiance, ligthing, 'irradiance')
    # Database
    db = world.start('DB', step_size=60, duration=END)
    hdf5 = db.Database(filename='demo.hdf5')
    connect_many_to_one(world, appliances.children, hdf5, 'power')
    connect_many_to_one(world, pvs, hdf5, 'P')

    nodes = [e for e in grid if e.type in ('RefBus, PQBus')]
    connect_many_to_one(world, nodes, hdf5, 'P', 'Q', 'Vl', 'Vm', 'Va')

    branches = [e for e in grid if e.type in ('Transformer', 'Branch')]
    connect_many_to_one(world, branches, hdf5,
                        'P_from', 'Q_from', 'P_to', 'P_from')

    # Web visualization
    webvis = world.start('WebVis', start_date=START, step_size=60)
    webvis.set_config(ignore_types=['Topology', 'HouseholdsGroup', 'Grid',
                                    'Database'])
    vis_topo = webvis.Topology()

    connect_many_to_one(world, nodes, vis_topo, 'P', 'Vm')
    webvis.set_etypes({
        'RefBus': {
            'cls': 'refbus',
            'attr': 'P',
            'unit': 'P [W]',
            'default': 0,
            'min': 0,
            'max': 30000,
        },
        'PQBus': {
            'cls': 'pqbus',
            'attr': 'Vm',
            'unit': 'U [V]',
            'default': 230,
            'min': 0.99 * 230,
            'max': 1.01 * 230,
        },
    })

    connect_many_to_one(world, activity.children, vis_topo, 'active_occupancy')
    webvis.set_etypes({
        'HouseholdActivity': {
            'cls': 'act',
            'attr': 'active_occupancy',
            'unit': 'Active Occupants',
            'default': 0,
            'min': 0,
            'max': 10,
        },
    })
    connect_many_to_one(world, ligthing.children, vis_topo, 'power')
    webvis.set_etypes({
        'HouseholdLighting': {
            'cls': 'load',
            'attr': 'power',
            'unit': 'P [W]',
            'default': 0,
            'min': 0,
            'max': 1000,
        },
    })
    connect_many_to_one(world, appliances.children, vis_topo, 'power')
    webvis.set_etypes({
        'HouseholdAppliances': {
            'cls': 'load',
            'attr': 'power',
            'unit': 'P [W]',
            'default': 0,
            'min': 0,
            'max': 3000,
        },
    })

    connect_many_to_one(world, pvs, vis_topo, 'P')
    webvis.set_etypes({
        'PV': {
            'cls': 'gen',
            'attr': 'P',
            'unit': 'P [W]',
            'default': 0,
            'min': -10000,
            'max': 0,
        },
    })


def connect_buildings_to_grid(world, houses, grid):
    buses = filter(lambda e: e.type == 'PQBus', grid)
    buses = {b.eid.split('-')[1]: b for b in buses}
    #house_data = world.get_data(houses, 'node_id')
    for house in houses:
        # node_id = house_data[house]['node_id']
        # print(buses.keys())
        #dict_keys(['node_a1', 'node_a2', 'node_a3', 'node_b1', 'node_b10', 'node_b2', 'node_b3', 'node_b4', 'node_b5', 'node_b6', 'node_b7', 'node_b8', 'node_b9', 'node_c1', 'node_c10', 'node_c11', 'node_c12', 'node_c2', 'node_c3', 'node_c4', 'node_c5', 'node_c6', 'node_c7', 'node_c8', 'node_c9', 'node_d1', 'node_d10', 'node_d11', 'node_d12', 'node_d2', 'node_d3', 'node_d4', 'node_d5', 'node_d6', 'node_d7', 'node_d8', 'node_d9', 'tr_sec'])
        #node_b7  on bus  Entity('PyPower-0', '0-node_b7', 'PyPower', PQBus) 
        
        #print(node_id,' on bus ', buses[node_id] )
        world.connect(house, buses['node_a1'], ('P_out', 'P'))



if __name__ == '__main__':
    main()
