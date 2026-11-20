local ccb = require("ccb")
local content = ccb.content

-- Native weighted fault groups
do
local definition = content.FaultGroup {
    id = "plate_lc",
}
definition:fault("fault_armor_lc_dented", 100)
definition:fault("fault_armor_lc_punctured", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "plate_mc",
}
definition:fault("fault_armor_mc_dented", 100)
definition:fault("fault_armor_mc_punctured", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "plate_hc",
}
definition:fault("fault_armor_hc_dented", 100)
definition:fault("fault_armor_hc_punctured", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "plate_ch",
}
definition:fault("fault_armor_ch_dented", 100)
definition:fault("fault_armor_ch_punctured", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "plate_qt",
}
definition:fault("fault_armor_qt_dented", 100)
definition:fault("fault_armor_qt_punctured", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "fabric_cotton",
}
definition:fault("fault_cotton_torn", 100)
definition:fault("fault_cotton_hole", 75)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "fabric_denim",
}
definition:fault("fault_denim_torn", 100)
definition:fault("fault_denim_hole", 75)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "electronic_general",
}
definition:fault("fault_electronic_blown_fuse", 100)
definition:fault("fault_electronic_blown_capacitor", 100)
definition:fault("fault_electronic_shorted_circuit", 100)
definition:fault("fault_emp_reboot", 100)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "handle_short",
}
definition:fault("fault_handle_chipping", 100)
definition:fault("fault_handle_cracked", 50)
definition:fault("fault_handle_broken", 5)
definition:fault("fault_handle_off", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "handle_long",
}
definition:fault("fault_handle_long_chipping", 100)
definition:fault("fault_handle_long_cracked", 50)
definition:fault("fault_handle_long_broken_half", 25)
definition:fault("fault_handle_long_broken", 5)
definition:fault("fault_handle_long_off", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "steel_pipe_short",
}
definition:fault("fault_steel_pipe_bent", 100)
definition:fault("fault_steel_pipe_bent_heavy", 10)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "steel_pipe_long",
}
definition:fault("fault_steel_pipe_staff_bent", 100)
definition:fault("fault_steel_pipe_staff_bent_heavy", 10)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "bladed_weapon_craft_failures",
}
definition:fault("interior_cracks", 100)
definition:fault("limp_edge", 1)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "blade_general",
}
definition:fault("fault_blade_rolled_edge", 100)
definition:fault("fault_blade_chipped", 100)
definition:fault("fault_blade_cracked", 50)
definition:fault("fault_blade_broken", 3)
definition:fault("fault_blade_broken_half", 8)
definition:fault("fault_blade_broken_tip", 50)
definition:fault("fault_blade_bent_tip", 80)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "blade_general_no_tip",
}
definition:fault("fault_blade_rolled_edge", 100)
definition:fault("fault_blade_chipped", 100)
definition:fault("fault_blade_cracked", 50)
definition:fault("fault_blade_broken", 3)
definition:fault("fault_blade_broken_half", 8)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "spearhead",
}
definition:fault("fault_spearhead_fracture", 100)
definition:fault("fault_spearhead_warped", 100)
definition:fault("fault_spearhead_chipping", 100)
definition:fault("fault_spearhead_bent_socket", 100)
definition:fault("fault_spearhead_broken", 2)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "staff_short",
}
definition:fault("fault_staff_short_chipping", 100)
definition:fault("fault_staff_short_cracked", 50)
definition:fault("fault_staff_short_broken", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "staff_long",
}
definition:fault("fault_staff_long_chipping", 100)
definition:fault("fault_staff_long_cracked", 50)
definition:fault("fault_staff_long_broken_half", 25)
definition:fault("fault_staff_long_broken", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "aluminum_bat",
}
definition:fault("fault_aluminum_bat_bent", 100)
definition:fault("fault_aluminum_bat_bent_heavy", 50)
definition:fault("fault_aluminum_bat_handle_broken", 20)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "batons",
}
definition:fault("fault_baton_bent_tip", 100)
definition:fault("fault_baton_bent", 60)
definition:fault("fault_baton_broken_tip", 30)
definition:fault("fault_baton_handle_broken", 10)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "tonfas",
}
definition:fault("fault_tonfa_handle_broken", 70)
definition:fault("fault_tonfa_broken", 30)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "ax_sheets",
}
definition:fault("fault_blade_rolled_edge", 100)
definition:fault("fault_steel_pipe_bent", 60)
definition:fault("fault_steel_pipe_bent_heavy", 50)
definition:fault("fault_pipe_shaft_broken", 40)
definition:fault("fault_sheets_detached", 20)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "whips",
}
definition:fault("fault_ripped_tip", 100)
definition:fault("fault_ripped_thong", 10)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "bladed_whips",
}
definition:fault("fault_blade_rolled_edge", 100)
definition:fault("fault_ripped_tip", 50)
definition:fault("fault_ripped_thong", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "knuckles",
}
definition:fault("fault_cracked", 100)
definition:fault("fault_shattered", 30)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "knuckles_bladed",
}
definition:fault("fault_blade_rolled_edge", 100)
definition:fault("fault_cracked", 50)
definition:fault("fault_shattered", 15)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "any_ICE_engine_maintenance",
}
definition:fault("fault_engine_belt_drive", 100)
definition:fault("fault_engine_filter_air", 100)
definition:fault("fault_engine_filter_fuel", 100)
definition:fault("fault_engine_starter", 100)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "diesel_engine_maintenance",
}
definition:fault("fault_engine_glow_plug", 100)
definition:fault("fault_engine_pump_diesel", 100)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "gasoline_engine_maintenance",
}
definition:fault("fault_engine_pump_fuel", 100)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "any_ICE_defect",
}
definition:fault("fault_engine_immobiliser", 20)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "steam_engine_maintenance",
}
definition:fault("fault_engine_belt_drive", 100)
definition:fault("fault_engine_filter_air", 100)
definition:fault("fault_engine_starter", 100)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "tire_defects",
}
definition:fault("fault_tire_treads", 75)
definition:fault("fault_punctured_tires", 20)
definition:fault("fault_flat_tire_riding_on_rims", 5)
content.add(definition)
end
