import random

from mosaik.util import connect_randomly, connect_many_to_one
import mosaik


sim_config = {
    'CSV': {
        'python': 'mosaik_csv:CSV',
    },
    'DB': {
        'cmd': 'mosaik-hdf5 %(addr)s',
    },
    'HouseholdSim': {
        #'python': 'simulator_mosaik:LoadSimulator',
        'cmd': 'python simulator_mosaik.py %(addr)s',
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
    hhsim = world.start('HouseholdSim')
    pvsim = world.start('CSV', sim_start=START, datafile=PV_DATA)

    # Instantiate models
    grid = pypower.Grid(gridfile=GRID_FILE).children
    houses = hhsim.HouseholdsGroup(
        sim_start=START,
        input_excell_file_path='inputs.xlsx',
        number_households=40).children
    pvs = pvsim.PV.create(20)

    # Connect entities
    connect_randomly(world, houses, [e for e in grid if 'node' in e.eid], ('P_out', 'P') )
    connect_randomly(world, pvs, [e for e in grid if 'node' in e.eid], 'P')

    # Database
    db = world.start('DB', step_size=60, duration=END)
    hdf5 = db.Database(filename='demo.hdf5')
    connect_many_to_one(world, houses, hdf5, 'P_out')
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

    connect_many_to_one(world, houses, vis_topo, 'P_out')
    webvis.set_etypes({
        'Household': {
            'cls': 'load',
            'attr': 'P_out',
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
