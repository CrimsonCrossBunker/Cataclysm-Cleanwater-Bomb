local ccb = require("ccb")
local content = ccb.content

-- Native gate definitions
do
local definition = content.Gate {
    id = "t_gates_mech_control",
    door = "t_door_metal_locked",
    floor = "t_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_control_concrete",
    door = "t_door_metal_locked",
    floor = "t_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_control_brick",
    door = "t_door_metal_locked",
    floor = "t_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_mech_control_lab",
    door = "t_door_metal_locked",
    floor = "t_thconc_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_control_concrete_lab",
    door = "t_door_metal_locked",
    floor = "t_thconc_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_control_brick_lab",
    door = "t_door_metal_locked",
    floor = "t_thconc_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the handle…",
    open_message = "The gate is opened!",
    close_message = "The gate is closed!",
    fail_message = "The gate can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_barndoor",
    door = "t_door_metal_locked",
    floor = "t_dirtfloor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You pull the rope…",
    open_message = "The barn doors opened!",
    close_message = "The barn doors closed!",
    fail_message = "The barn doors can't be closed!",
}
definition:wall("t_wall_wood")
definition:wall("t_wall_wood_chipped")
definition:wall("t_wall_wood_broken")
definition:wall("t_wall_wood_widened")
definition:wall("t_wood_wall_b")
definition:wall("t_wood_wall_black")
definition:wall("t_wood_wall_brown")
definition:wall("t_wood_wall_cyan")
definition:wall("t_wood_wall_g")
definition:wall("t_wood_wall_gray")
definition:wall("t_wood_wall_orange")
definition:wall("t_wood_wall_p")
definition:wall("t_wood_wall_P")
definition:wall("t_wood_wall_r")
definition:wall("t_wood_wall_w")
definition:wall("t_wood_wall_y")
definition:wall("t_wall_log")
definition:wall("t_wall_log_chipped")
definition:wall("t_wall_log_broken")
definition:wall("t_wall_log_widened")
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_palisade_pulley",
    door = "t_palisade_gate",
    floor = "t_palisade_gate_o",
    moves = 1800,
    bashing_damage = 30,
    pull_message = "You pull the rope…",
    open_message = "The palisade gate swings open!",
    close_message = "The palisade gate swings closed with a crash!",
    fail_message = "The palisade gate can't be closed!",
}
definition:wall("t_palisade")
definition:wall("t_palisade_embrasure")
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_palisade_pulley_wood",
    door = "t_palisade_gate",
    floor = "t_palisade_gate_o",
    moves = 1800,
    bashing_damage = 30,
    pull_message = "You pull the rope…",
    open_message = "The palisade gate swings open!",
    close_message = "The palisade gate swings closed with a crash!",
    fail_message = "The palisade gate can't be closed!",
}
definition:wall("t_palisade")
definition:wall("t_palisade_embrasure")
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_gates_control_metal",
    door = "t_door_metal_locked",
    floor = "t_metal_floor",
    moves = 1200,
    bashing_damage = 60,
    pull_message = "You throw the lever…",
    open_message = "The door rises!",
    close_message = "The door slams shut!",
    fail_message = "The door can't be closed!",
}
definition:wall("t_wall_metal")
definition:wall("t_wall_metal_corrugated")
definition:wall("t_wall_bulkhead")
definition:wall("t_scrap_wall")
definition:wall("t_junk_wall")
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_string_gates_mech_control",
    door = "t_door_metal_locked",
    floor = "t_metal_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the lever…",
    open_message = "The doors open, and a gust of air hisses by!",
    close_message = "The doors close while some distant machinery whirrs and thunks!",
    fail_message = "The doors can't be closed!",
}
content.add(definition)
end
do
local definition = content.Gate {
    id = "t_nl_gates_mech_control",
    door = "t_nl_door_l",
    floor = "t_nl_metal_floor",
    moves = 1800,
    bashing_damage = 40,
    pull_message = "You turn the lever…",
    open_message = "The doors open!",
    close_message = "The doors close and thunk!",
    fail_message = "The doors can't be closed!",
}
content.add(definition)
end
