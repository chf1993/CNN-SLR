# README #
MATLAB library to interface with LPMS Sensors. 
This library uses com port to communicated with LPMS sensors. 
LPMS Sensors's usb virtual com port(VCP) functionality is disabled by default. 
Please use LpVCPConversionTool to enable VCP support.


### Known Issues:
- Serial Interrupt routine blocks main processing thread when transferring at data rate > 100Hz 
- 16bit data parsing is not yet implemented


### LpVCPConversionTool:
https://bitbucket.org/lpresearch/openmat/downloads/LpVCPConversionTool-1.0.0-Setup.exe
