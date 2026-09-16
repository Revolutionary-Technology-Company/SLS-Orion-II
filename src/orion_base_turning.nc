( ============================================================================ )
( CNC TOOLPATH: 16.5-FOOT ORION-INTERFACED BASE FORGING RING TURNING RUN       )
( REPOSITORY FILENAME: src/orion_base_turning.nc                               )
( OPERATION REQUISITE: MULTI-AXIS VERTICAL BORING MILL WITH TIALN TOOLING PATH )
( CONFIGURATION: COMPRESSION JOINT STEP FOR 0.025" FLANGED SKIN ROLLS          )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z5.0 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 01: 3.000" HEAVY FACING HEAD INTERLOCK WITH INDEXABLE COATED CARBIDE INSERTS )
T01 M06 ( Execute Automated Mechanical Tool Change Sequence )
S650 M03 ( Engage Spindle Drive: 650 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant System Pump Line Flow )

( --- ROUGHING FACING CUT DEPTH PROFILE PASSES --- )
G00 X99.000 Y-5.000 ( Rapid Drive to Outer 99-Inch Radius Forging Starting Edge )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.150 F8.5 ( Controlled Vertical Depth Plunge Move Into Solid 1.50" Titanium )
G02 X99.000 Y-5.000 I-99.000 J5.000 F5.0 ( Automated 360-Degree Face Turning Step Cut )

G01 Z-0.300 F8.5 ( Secondary Down-Feed Pass to Arrive at Flange Shoulder Height )
G02 X99.000 Y-5.000 I-99.000 J5.000 F5.0

( --- FINAL COMPLIANCE STEP SEAM RECEIVER FINISHING PASS --- )
G01 Z-0.450 F6.0 ( Reach Target Floor Thickness Baseline for Skin Overlap Joint )
G02 X99.000 Y-5.000 I-99.000 J5.000 F4.0 ( Ultra-Precision Surface Shaving Turn Pass )

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z5.000 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )
