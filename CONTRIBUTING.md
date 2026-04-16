# Contributing

## Setup

1. Open MATLAB in the project root.
2. Run `run("main/run_bms_demo.m")`.
3. Run `run("tests/smoke_test.m")` after making changes.
4. If you touch the generated model flow, also run `run("main/build_simulink_model.m")`.

## Guidelines

- Keep MATLAB files ASCII unless there is a strong reason not to.
- Prefer small, testable functions under `src/`.
- Update `README.md` when adding major subsystems or outputs.
- Do not commit generated temporary folders such as `slprj/`.

## Suggested Areas

- Charging logic and charger state machine
- Multi-cell pack balancing
- State estimation upgrades such as EKF/UKF
- Pack fault diagnostics and communication stacks
