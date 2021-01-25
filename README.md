# spaceflight-autopilot
🚀  A series of scripted spaceflight maneuvers for a rocket simulator

This repository contains code which attempts to automate and visualize various spaceflight maneuvers such as launching, orbiting, de-orbiting, hovering and landing.

## Automated flight maneuvers 

The spaceflight control code is written in the [KerboScript Language](https://ksp-kos.github.io/KOS/language.html).

Within the spaceflight simulator application, the flight control code is interpreted by a virtual flight controller on-board the spacecraft.

## Visualizer

The visualizer provides the ability to view these spaceflight maneuvers outside of the simulator application.

The GPS flight control code is responsible for recording the simulated spacecraft's GPS location and altitude data.
The simulator consumes this data to accurately render the SOI and the flight path of the spacecraft.

**Demonstration of the visualizer rendering a sub-orbital flight:**
![Demo of visualizer with sub-orbital flight recording](https://github.com/trentrand/spaceflight-autopilot/blob/master/visualizer/assets/demo.mov?raw=true)
