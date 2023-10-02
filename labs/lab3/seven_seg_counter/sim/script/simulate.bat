@REM *****************************************************************************
@REM   This file do some cleanup of the simulation directory and call the
@REM   ModelSim simulator. 
@REM *****************************************************************************

@REM ---------------------------------------------------------------------
@REM   Before we start, lets remove any old files and directories
@REM ---------------------------------------------------------------------
@echo off
if exist work (
    rmdir /s /q work 
) 

if exist transcript (
    del /f /q transcript 
) 

if exist transcript (
    del /f /q vsim.wlf 
) 

echo on

vsim -do sim.do

@echo off

@REM ---------------------------------------------------------------------
@REM   Before we stop, lets clean the files and directories
@REM ---------------------------------------------------------------------
rmdir work   /s /q
del transcript
del vsim.wlf