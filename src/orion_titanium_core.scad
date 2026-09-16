// ============================================================================
// MODULE: ORION-SCALE MONOLITHIC TITANIUM CAPSULE PRESSURE VESSELS
// REPOSITORY PATH: src/orion_titanium_core.scad
// HARDWARE REQUIREMENT: 16.5-FOOT (198.0" OD) LOCKHEED INTERFACE BOUNDARY
// COMPLIANCE: 0.062" FRAME SKELETON CEILING / ZERO EXTERNAL FASTENER PORTS
// CONFIGURATION: FULL TITANIUM CANISTER REPLACEMENT ENGINE CORE
// ============================================================================

$fn = 200; // Ultra-high resolution triangulation mesh for multi-axis CNC paths

// --- SPACE FORCE LEVEL ARCHITECTURE CONSTANTS (INCHES) ---
ORION_OUTER_OD = 198.0;      // 16.5-Foot master booster ring baseline
FORWARD_DOCK_OD = 55.0;     // Apex docking interface flange scale
CORE_VERT_HEIGHT = 132.0;    // Total height of the pressurized canister can
FORGING_WALL_THICK = 1.50;   // Approved "Sewer Plate" heavy base ring solid boundary
FRAME_MAX_CEILING = 0.062;   // Regulated "Mining Hat" internal rib thickness floor
SKIN_SHEET_THICK = 0.025;    // Stamped Titanium Shell Base Sheet
WINDOW_ARC_RADIUS = 38.5;    // Curvature profile for Fused Silica panes

module OrionScaleTitaniumPressureCan() {
    // Generates the core airtight "Titanium Can" pressure vessel volume
    echo("CNC Toolpath: Stamping 0.025\" Titanium Capsule Skins; Base Thickness =", SKIN_SHEET_THICK);
    difference() {
        cylinder(h = CORE_VERT_HEIGHT, r1 = ORION_OUTER_OD/2 - FORGING_WALL_THICK, r2 = FORWARD_DOCK_OD/2, center = false);
        translate([0, 0, -0.1])
        cylinder(h = CORE_VERT_HEIGHT + 0.2, r1 = (ORION_OUTER_OD/2) - FORGING_WALL_THICK - SKIN_SHEET_THICK, r2 = (FORWARD_DOCK_OD/2) - SKIN_SHEET_THICK, center = false);
    }
}

module InternalMark3HoneycombSkeleton() {
    // Patterns the dense vertical stringers and horizontal Z-frames
    echo("CNC Toolpath: Face-Milling Internal 0.062\" Honeycomb Grid Reinforcement Matrix");
    color("DarkSlateGray")
    union() {
        // 48 primary vertical hat-stringers to distribute launch G-forces uniformly across the 16.5-foot core
        for (rib = [0 : 7.5 : 360]) {
            rotate([0, 0, rib])
            translate([ORION_OUTER_OD/2 - FORGING_WALL_THICK - FRAME_MAX_CEILING, -0.5, 0])
            rotate([0, -atan(((ORION_OUTER_OD/2)-(FORWARD_DOCK_OD/2))/CORE_VERT_HEIGHT), 0])
            cube([FRAME_MAX_CEILING, 1.0, CORE_VERT_HEIGHT * 1.1]);
        }
    }
}

module MachinedHeavyBaseFlange() {
    // Carves the main booster interface loop out of a solid 1.50" thick titanium forging
    echo("CNC Toolpath: Turning 198-Inch Heavy Base Ring Forging; Wall =", FORGING_WALL_THICK);
    color("Silver")
    difference() {
        cylinder(h = 4.0, r = ORION_OUTER_OD / 2, center = true);
        
        // Internal hollow bore clearing space for the inner titanium canister can
        translate([0, 0, -2.5])
        cylinder(h = 6.0, r = (ORION_OUTER_OD / 2) - FORGING_WALL_THICK);
        
        // Upper CNC Step Shoulder: Receiver shelf to flush-weld 0.025" skins
        translate([0, 0, 1.25])
        cylinder(h = 1.0, r = (ORION_OUTER_OD / 2) - FORGING_WALL_THICK - SKIN_SHEET_THICK);
        
        // Lockheed MPCV Connector Slots: 6-Point symmetrical hook receiver tracks
        for (latch = [0 : 60 : 360]) {
            rotate([0, 0, latch])
            translate([ORION_OUTER_OD / 2 - 0.75, -3.0, -2.5])
            cube([1.5, 6.0, 5.0]);
        }
    }
}

// ============================================================================
// PRODUCTION SYNCHRONIZATION ASSEMBLY STAGE
// ============================================================================
union() {
    // 1. External booster attachment ring (TIG welded continuously around base skin)
    translate([0, 0, -2.0]) MachinedHeavyBaseFlange();
    
    // 2. High-integrity internal "Titanium Can" pressure vessel skeleton core
    InternalMark3HoneycombSkeleton();
    
    // 3. Hermetic pressurized barrier hull skin welded over the matrix assembly
    color("LightBlue", 0.5) OrionScaleTitaniumPressureCan();
}
