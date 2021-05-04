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
        'python': 'simulator_mosaik:LoadSimulator',
        #'cmd': 'python simulator_mosaik.py %(addr)s',
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
END =  12 * 31 * 24 * 3600  # 1 year

WEATHER_DATA = 'data/weather_data.csv'
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
    START_WEATHER_FORMAT = ''.join((START[:10], 'T', START[11:19], 'Z'))


    # Instantiate models
    grid = pypower.Grid(gridfile=GRID_FILE).children
    household_group= hhsim.HouseholdsGroup(
        sim_start=START,
        number_households=40,
    )
    houses = household_group.children

    weathersim = world.start('CSV', sim_start=START_WEATHER_FORMAT, datafile=WEATHER_DATA, date_format='YYYY-MM-DDTHH:mm:ssZ')
    temperature = weathersim.Weather()
    world.connect(temperature, household_group, ('DE_temperature', 'outside_temperature'))

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

    world.connect( temperature, vis_topo, 'DE_temperature')
    webvis.set_etypes({
        'Weather': {
            'cls': 'temp',
            'attr': 'DE_temperature',
            'unit': 'T [C]',
            'default': -20,
            'min': -20,
            'max': 40,
        },
    })

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


def connect_heating_system_to_households(world, heating_system, houses):
    # define connexion between the heat pumps and the houses
    raise NotImplementedError()


if __name__ == '__main__':
    main()
