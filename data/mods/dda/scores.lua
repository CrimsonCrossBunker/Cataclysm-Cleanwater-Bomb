local ccb = require("ccb")
local content = ccb.content

-- Native score definitions
do
local definition = content.Score {
    id = "score_kills",
    statistic = "num_avatar_monster_kills",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_moves",
    statistic = "num_moves",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_walked",
    statistic = "num_moves_walked",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_mounted",
    statistic = "num_moves_mounted",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_ran",
    statistic = "num_moves_ran",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_crouched",
    statistic = "num_moves_crouched",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_swam",
    statistic = "num_moves_swam",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_swam_underwater",
    statistic = "num_moves_swam_underwater",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_min_move_z",
    statistic = "min_move_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_move_z",
    statistic = "max_move_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_veh_onboard",
    statistic = "num_moves_veh_onboard",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_gndv_onboard",
    statistic = "num_moves_gndv_onboard",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_rail_onboard",
    statistic = "num_moves_rail_onboard",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_boat_onboard",
    statistic = "num_moves_boat_onboard",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_acft_onboard",
    statistic = "num_moves_acft_onboard",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_distance_veh_ctrl_remote",
    statistic = "num_moves_veh_ctrl_remote",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_velocity_gndv",
    statistic = "max_velocity_gndv",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_velocity_rail",
    statistic = "max_velocity_rail",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_velocity_boat",
    statistic = "max_velocity_boat",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_velocity_acft",
    statistic = "max_velocity_acft",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_min_veh_z",
    statistic = "min_move_veh_onboard_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_veh_z",
    statistic = "max_move_veh_onboard_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_gndv_z",
    statistic = "max_move_gndv_ctrl_direct_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_max_acft_z",
    statistic = "max_move_acft_ctrl_direct_z",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_damage_taken",
    statistic = "avatar_damage_taken",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_damage_healed",
    statistic = "avatar_damage_healed",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_headshots",
    statistic = "avatar_num_headshots",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_cut_trees",
    statistic = "num_cuts_tree",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_buried_corpses",
    statistic = "num_buried_corpses",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_exhumed_graves",
    statistic = "num_exhumed_graves",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_installs_cbm",
    statistic = "num_installs_cbm",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_installs_faulty_cbm",
    statistic = "num_installs_faulty_cbm",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_gains_mutation",
    statistic = "num_gains_mutation",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_crosses_mutation_threshold",
    statistic = "num_crosses_mutation_threshold",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_broken_bones",
    statistic = "num_broken_bone",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_broken_right_leg",
    statistic = "num_broken_right_leg",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_broken_left_leg",
    statistic = "num_broken_left_leg",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_broken_right_arm",
    statistic = "num_broken_right_arm",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_broken_left_arm",
    statistic = "num_broken_left_arm",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_skill_levels_gained",
    statistic = "num_gains_skill_level",
}
content.add(definition)
end
