# Demod mosaik adapter

This repository contains adapter classes for all
demod classes into mosaik.

### demod

Demod is a Python library for assembling bottom-up domestic energy demand models.

[github](https://github.com/epfl-herus/demod)
[read the docs](https://demod.readthedocs.io/)

### mosaik

Mosaik’s main goal is to use existing simulators in a common context in order
to perform a coordinated simulation of a given (Smart Grid) scenario.

[read the docs](https://mosaik.readthedocs.io/)

## Usage

demo.py show usage example inside a mosaik simulation script.

## Adapting a new simulator

If you want to adapt a new demod simulator, you can follow this
instruction.

1. Import the abstract adapter.
If the demod simulator simulates various households,
use the Household module.
For a single value simulated (ex. climate), use The SingleValue module.

```python
from mosaikdemod.adaptors import AbstractHouseholdsModule
from mosaikdemod.adaptors import AbstractSingleValueModule
```

2. import demod library
```python
import demod
```

3. Inherit from the abstract module

```python
class ComponentSimulator(AbstractHouseholdsModule):
```

4. Specify the attributes of the simulator that can be accessed
```python
    attributes_dict = {
        'attr_name_in_mosaik': 'get_demod_getter',
        'other__attr': 'get_smth_else',
        ...
    }
```
5. Specify the inputs of the simulator that can be accessed
```python
    step_inputs_dict = {
        'attr_name_in_mosaik': 'step_input_demod',
        'other_input': 'input_other',
        ...
    }
```
6. Override the `__init__()` method
```python
    def __init__(
        self,
        simulated_component='CompName',  # Name of what is simulated used for mosaik instances
        default_simulator=demod.simulators.example_simulators.ExampleSimulator,  # The simulator class you want to simulate
        step_size=60  # The mosaik step size (depend on your definition)
    ):
        super().__init__(simulated_component, default_simulator, step_size)
```

7. Import your simulator to your mosaik scenario script.

```python
# Define the Simulator
sim_config = {
    ...
    'CompNameSimulator': {
        'python': 'python_file_of_the_sim:ComponentSimulator',
    },
    ...
}

# Instantiate the simulator
sim = world.start('CompNameSimulator')


# Instantiate the households with parameters
component = actsim.HouseholdsGroupCompName(
    inputs_params={  # demod init params of sim
        'n_households': n_households,
        'start_datetime': START_DATETIME,
        ...
    }
)
# OR instantiate a  SingleValue simulator (remove HouseholdsGroup)
component = actsim.CompName(
    inputs_params={  # demod init params of sim
        'start_datetime': START_DATETIME,
        ...
    }
)
```

8. Connect the simulators. You can connect a whole household group to another one if you use 2 demod components.
Or you can also connect all the households individually
by calling the children method
```python
# Connect 2 demod components
# comp1 passes attr to comp2
world.connect(component1, component2, 'attr_name_in_mosaik')

# Connect 2 demod components with single value
# component_single_value passes attr to comp2
world.connect(component_single_value, component2, 'attr_name_in_mosaik')

# Connect a single household using the children
world.connect(component.children[42], other_mosaik_comp, 'attr_name_in_mosaik')

```

## Examples

Some examples can be found in simulator_mosaik_modular.py.


