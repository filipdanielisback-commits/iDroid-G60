# Driver status matrix

All entries begin as **not-started**. This matrix must be updated with source links, exact hardware identity, implementation references and test evidence. Do not mark a subsystem working merely because code compiles.

| Subsystem | Hardware identity | Status | Evidence required for `working` |
|---|---|---|---|
| Display / panel | Unknown | not-started | Correct panel initialization, modes, backlight and stable image on target |
| Touchscreen | Unknown | not-started | Actual touch controller communication and verified multitouch input |
| Buttons | Unknown | not-started | Physical power/volume events correctly reported |
| Storage | Unknown | not-started | Controller initialization and safe read/write tests on a disposable test target |
| GPU | Adreno 618 reported; verify | not-started | Hardware command submission and validated rendering, not software fallback |
| Wi-Fi | Chipset unknown | not-started | Firmware/interface identified and real network scan/connection tests |
| Audio | Codec/DSP unknown | not-started | Real playback and capture paths tested |
| Camera | Sensors/ISP unknown | not-started | Sensor detection, capture pipeline and saved image validation |
| Battery / charging | Fuel gauge/charger unknown | not-started | Correct telemetry and charging-state reporting |
| Thermal | Sensors unknown | not-started | Sensor readings and safe thermal policy behavior |
| USB | Controller/PHY unknown | not-started | Enumerate and transfer data through supported USB modes |
| Haptics | Actuator/controller unknown | not-started | Controlled vibration request verified on hardware |
| Bluetooth | Not in initial scope | disabled | Must remain disabled unless project scope changes |

## Required evidence per driver

1. Exact component name, revision and bus.
2. Device-tree or other device-specific source evidence.
3. Register/interface documentation and licensing provenance.
4. Required clocks, regulators, interrupts, DMA and firmware.
5. Native implementation and reviewable source.
6. Build logs and test procedure.
7. Physical-device test results, including limitations.

Emulator-only tests may validate portable logic, but do not prove Moto G60 hardware support.
