local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventStatistic {
    id = "avatar_id",
    statistic_type = "last_value",
    event_type = "game_avatar_new",
    field = "avatar_id",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "last_words",
    statistic_type = "last_value",
    event_type = "game_avatar_death",
    field = "last_words",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wakes_up", event_type = "character_wakes_up" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wake_ups",
    statistic_type = "count",
    event_transformation = "avatar_wakes_up",
    description = "wake up",
    description_plural = "times woken up",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_kills_monster", event_type = "character_kills_monster" }
definition:where_statistic("killer", "avatar_id")
definition:drop("killer")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_kills_character", event_type = "character_kills_character" }
definition:where_statistic("killer", "avatar_id")
definition:drop("killer")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_species_kills", event_transformation = "avatar_kills_monster" }
definition:derive("species", "species_of_monster", "victim_type")
definition:drop("victim_type")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_zombie_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "ZOMBIE")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_cyborg_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "CYBORG")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_nether_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "NETHER")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_fungus_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "FUNGUS")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_insect_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "INSECT")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_robot_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "ROBOT")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_monster_kills",
    statistic_type = "count",
    event_transformation = "avatar_kills_monster",
    description = "monster killed",
    description_plural = "monsters killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_character_kills",
    statistic_type = "count",
    event_transformation = "avatar_kills_character",
    description = "NPC killed",
    description_plural = "NPCs killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_zombie_kills",
    statistic_type = "count",
    event_transformation = "avatar_zombie_kills",
    description = "zombie killed",
    description_plural = "zombies killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_cyborg_kills",
    statistic_type = "count",
    event_transformation = "avatar_cyborg_kills",
    description = "cyborg killed",
    description_plural = "cyborgs killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_nether_kills",
    statistic_type = "count",
    event_transformation = "avatar_nether_kills",
    description = "nether monster killed",
    description_plural = "nether monsters killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_fungus_kills",
    statistic_type = "count",
    event_transformation = "avatar_fungus_kills",
    description = "fungus monster killed",
    description_plural = "fungus monsters killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_insect_kills",
    statistic_type = "count",
    event_transformation = "avatar_insect_kills",
    description = "insect killed",
    description_plural = "insects killed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_robot_kills",
    statistic_type = "count",
    event_transformation = "avatar_robot_kills",
    description = "robot killed",
    description_plural = "robots killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_melee_attacks_monster", event_type = "character_melee_attacks_monster" }
definition:where_statistic("attacker", "avatar_id")
definition:drop("attacker")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_melee_attacks_monster",
    statistic_type = "count",
    event_transformation = "avatar_melee_attacks_monster",
    description = "melee attack made against monsters",
    description_plural = "melee attacks made against monsters",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_melee_attacks_character", event_type = "character_melee_attacks_character" }
definition:where_statistic("attacker", "avatar_id")
definition:drop("attacker")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_melee_attacks_character",
    statistic_type = "count",
    event_transformation = "avatar_melee_attacks_character",
    description = "melee attack made against characters",
    description_plural = "melee attacks made against characters",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_ranged_attacks_monster", event_type = "character_ranged_attacks_monster" }
definition:where_statistic("attacker", "avatar_id")
definition:drop("attacker")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_ranged_attacks_monster",
    statistic_type = "count",
    event_transformation = "avatar_ranged_attacks_monster",
    description = "ranged attack made against monsters",
    description_plural = "ranged attacks made against monsters",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_ranged_attacks_character", event_type = "character_ranged_attacks_character" }
definition:where_statistic("attacker", "avatar_id")
definition:drop("attacker")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_ranged_attacks_character",
    statistic_type = "count",
    event_transformation = "avatar_ranged_attacks_character",
    description = "ranged attack made against characters",
    description_plural = "ranged attacks made against characters",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_smashes_tile", event_type = "character_smashes_tile" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_smash",
    statistic_type = "count",
    event_transformation = "avatar_smashes_tile",
    description = "smash",
    description_plural = "smashes",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_takes_damage", event_type = "character_takes_damage" }
definition:where_statistic("character", "avatar_id")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_damage_taken",
    statistic_type = "total",
    event_transformation = "avatar_takes_damage",
    field = "damage",
    description = "damage taken",
    description_plural = "damage taken",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_heals_damage", event_type = "character_heals_damage" }
definition:where_statistic("character", "avatar_id")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_damage_healed",
    statistic_type = "total",
    event_transformation = "avatar_heals_damage",
    field = "damage",
    description = "damage healed",
    description_plural = "damage healed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_headshots", event_type = "character_gets_headshot" }
definition:where_statistic("character", "avatar_id")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_num_headshots",
    statistic_type = "count",
    event_transformation = "avatar_headshots",
    description = "headshot",
    description_plural = "headshots",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves",
    statistic_type = "count",
    event_type = "avatar_moves",
    description = "square moved",
    description_plural = "squares moved",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_with_terrain_flags", event_type = "avatar_moves" }
definition:derive("terrain_flag", "flags_of_terrain", "terrain")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_expand_pre_move_mode", event_type = "avatar_moves" }
definition:derive("swimming", "is_swimming_terrain", "terrain")
definition:derive("mounted", "is_mounted", "mount")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_walked", event_transformation = "moves_expand_pre_move_mode" }
definition:where_equals("movement_mode", "character_movemode", "walk")
definition:where_equals("mounted", "bool", false)
definition:where_equals("swimming", "bool", false)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_mounted", event_transformation = "moves_expand_pre_move_mode" }
definition:where_equals("mounted", "bool", true)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_ran", event_transformation = "moves_expand_pre_move_mode" }
definition:where_equals("movement_mode", "character_movemode", "run")
definition:where_equals("mounted", "bool", false)
definition:where_equals("swimming", "bool", false)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_crouched", event_transformation = "moves_expand_pre_move_mode" }
definition:where_equals("movement_mode", "character_movemode", "crouch")
definition:where_equals("mounted", "bool", false)
definition:where_equals("swimming", "bool", false)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_swam", event_transformation = "moves_expand_pre_move_mode" }
definition:where_equals("mounted", "bool", false)
definition:where_equals("swimming", "bool", true)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_swam_underwater", event_transformation = "moves_swam" }
definition:where_equals("underwater", "bool", true)
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_sharp_terrain", event_transformation = "moves_with_terrain_flags" }
definition:where_equals("terrain_flag", "string", "SHARP")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_walked",
    statistic_type = "count",
    event_transformation = "moves_walked",
    description = "square walked",
    description_plural = "squares walked",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_mounted",
    statistic_type = "count",
    event_transformation = "moves_mounted",
    description = "square ridden on a mount",
    description_plural = "squares ridden on a mount",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_ran",
    statistic_type = "count",
    event_transformation = "moves_ran",
    description = "square ran",
    description_plural = "squares ran",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_crouched",
    statistic_type = "count",
    event_transformation = "moves_crouched",
    description = "square crouched",
    description_plural = "squares crouched",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_swam",
    statistic_type = "count",
    event_transformation = "moves_swam",
    description = "square swam",
    description_plural = "squares swam",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_swam_underwater",
    statistic_type = "count",
    event_transformation = "moves_swam_underwater",
    description = "square swam underwater",
    description_plural = "squares swam underwater",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_sharp_terrain",
    statistic_type = "count",
    event_transformation = "moves_sharp_terrain",
    description = "move through sharp terrain",
    description_plural = "moves through sharp terrain",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "min_move_z",
    statistic_type = "minimum",
    event_type = "avatar_moves",
    field = "z",
    description = "minimum z level reached",
    description_plural = "minimum z level reached",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_move_z",
    statistic_type = "maximum",
    event_type = "avatar_moves",
    field = "z",
    description = "maximum z level reached",
    description_plural = "maximum z level reached",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "min_move_underwater_z",
    statistic_type = "minimum",
    event_transformation = "moves_swam_underwater",
    field = "z",
    description = "minimum z level reached underwater",
    description_plural = "minimum z level reached underwater",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "vehicle_moves_with_abs_velocity", event_type = "vehicle_moves" }
definition:derive("abs_velocity", "math_abs", "velocity")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_veh_onboard", event_transformation = "vehicle_moves_with_abs_velocity" }
definition:where_equals("avatar_on_board", "bool", true)
definition:drop("avatar_on_board")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_veh_onboard",
    statistic_type = "count",
    event_transformation = "moves_veh_onboard",
    description = "square traveled on board vehicles",
    description_plural = "squares traveled on board vehicles",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "min_move_veh_onboard_z",
    statistic_type = "minimum",
    event_transformation = "moves_veh_onboard",
    field = "z",
    description = "minimum z level reached in a vehicle",
    description_plural = "minimum z level reached in a vehicle",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_move_veh_onboard_z",
    statistic_type = "maximum",
    event_transformation = "moves_veh_onboard",
    field = "z",
    description = "maximum z level reached in a vehicle",
    description_plural = "maximum z level reached in a vehicle",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_veh_ctrl_direct", event_transformation = "vehicle_moves_with_abs_velocity" }
definition:where_equals("avatar_is_driving", "bool", true)
definition:drop("avatar_is_driving")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_veh_ctrl_direct",
    statistic_type = "count",
    event_transformation = "moves_veh_ctrl_direct",
    description = "square traveled while controlling vehicle",
    description_plural = "squares traveled while controlling vehicle",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_veh_ctrl_remote", event_transformation = "vehicle_moves_with_abs_velocity" }
definition:where_equals("avatar_remote_control", "bool", true)
definition:drop("avatar_remote_control")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_veh_ctrl_remote",
    statistic_type = "count",
    event_transformation = "moves_veh_ctrl_remote",
    description = "square traversed by remote controlled vehicles",
    description_plural = "squares traversed by remote controlled vehicles",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_veh_onboard_ctrl_remote", event_transformation = "moves_veh_onboard" }
definition:where_equals("avatar_remote_control", "bool", true)
definition:drop("avatar_remote_control")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_veh_onboard_ctrl_remote",
    statistic_type = "count",
    event_transformation = "moves_veh_onboard_ctrl_remote",
    description = "square traveled on board remote controlled vehicle",
    description_plural = "squares traveled on board remote controlled vehicle",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_veh_onboard_ctrl_none", event_transformation = "moves_veh_onboard" }
definition:where_equals("avatar_is_driving", "bool", false)
definition:where_equals("avatar_remote_control", "bool", false)
definition:drop("avatar_is_driving")
definition:drop("avatar_remote_control")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_veh_onboard_ctrl_none",
    statistic_type = "count",
    event_transformation = "moves_veh_onboard_ctrl_none",
    description = "square traveled as vehicle passenger",
    description_plural = "squares traveled as vehicle passenger",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_acft_onboard", event_transformation = "moves_veh_onboard" }
definition:where_equals("is_flying_aircraft", "bool", true)
definition:drop("is_flying_aircraft")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_acft_onboard",
    statistic_type = "count",
    event_transformation = "moves_acft_onboard",
    description = "square traveled on board aircraft",
    description_plural = "squares traveled on board aircraft",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_acft_ctrl_direct", event_transformation = "moves_veh_ctrl_direct" }
definition:where_equals("is_flying_aircraft", "bool", true)
definition:drop("is_flying_aircraft")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_acft_ctrl_direct",
    statistic_type = "count",
    event_transformation = "moves_acft_ctrl_direct",
    description = "square traveled while piloting aircraft",
    description_plural = "squares traveled while piloting aircraft",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_velocity_acft",
    statistic_type = "maximum",
    event_transformation = "moves_acft_ctrl_direct",
    field = "abs_velocity",
    description = "maximum velocity attained while piloting an aircraft",
    description_plural = "maximum velocity attained while piloting an aircraft",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_move_acft_ctrl_direct_z",
    statistic_type = "maximum",
    event_transformation = "moves_acft_ctrl_direct",
    field = "z",
    description = "maximum z level reached while piloting an aircraft",
    description_plural = "maximum z level reached while piloting an aircraft",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_boat_onboard", event_transformation = "moves_veh_onboard" }
definition:where_equals("is_floating_watercraft", "bool", true)
definition:drop("is_floating_watercraft")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_boat_onboard",
    statistic_type = "count",
    event_transformation = "moves_boat_onboard",
    description = "square traveled on board watercraft",
    description_plural = "squares traveled on board watercraft",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_boat_ctrl_direct", event_transformation = "moves_veh_ctrl_direct" }
definition:where_equals("is_floating_watercraft", "bool", true)
definition:drop("is_floating_watercraft")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_boat_ctrl_direct",
    statistic_type = "count",
    event_transformation = "moves_boat_ctrl_direct",
    description = "square traveled while sailing watercraft",
    description_plural = "squares traveled while sailing watercraft",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_velocity_boat",
    statistic_type = "maximum",
    event_transformation = "moves_boat_ctrl_direct",
    field = "abs_velocity",
    description = "maximum velocity attained while sailing a watercraft",
    description_plural = "maximum velocity attained while sailing a watercraft",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_rail_onboard", event_transformation = "moves_veh_onboard" }
definition:where_equals("is_on_rails", "bool", true)
definition:drop("is_on_rails")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_rail_onboard",
    statistic_type = "count",
    event_transformation = "moves_rail_onboard",
    description = "square traveled on board rail vehicles",
    description_plural = "squares traveled on board rail vehicles",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_rail_ctrl_direct", event_transformation = "moves_veh_ctrl_direct" }
definition:where_equals("is_on_rails", "bool", true)
definition:drop("is_on_rails")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_rail_ctrl_direct",
    statistic_type = "count",
    event_transformation = "moves_rail_ctrl_direct",
    description = "square traveled while driving rail vehicles",
    description_plural = "squares traveled while driving rail vehicles",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_velocity_rail",
    statistic_type = "maximum",
    event_transformation = "moves_rail_ctrl_direct",
    field = "abs_velocity",
    description = "maximum velocity attained while driving a rail vehicle",
    description_plural = "maximum velocity attained while driving a rail vehicle",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_gndv_onboard", event_transformation = "moves_veh_onboard" }
definition:where_equals("is_flying_aircraft", "bool", false)
definition:where_equals("is_floating_watercraft", "bool", false)
definition:where_equals("is_on_rails", "bool", false)
definition:drop("is_flying_aircraft")
definition:drop("is_floating_watercraft")
definition:drop("is_on_rails")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_gndv_onboard",
    statistic_type = "count",
    event_transformation = "moves_gndv_onboard",
    description = "square traveled on board land vehicles",
    description_plural = "squares traveled on board land vehicles",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_gndv_ctrl_direct", event_transformation = "moves_veh_ctrl_direct" }
definition:where_equals("is_flying_aircraft", "bool", false)
definition:where_equals("is_floating_watercraft", "bool", false)
definition:where_equals("is_on_rails", "bool", false)
definition:drop("is_flying_aircraft")
definition:drop("is_floating_watercraft")
definition:drop("is_on_rails")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_gndv_ctrl_direct",
    statistic_type = "count",
    event_transformation = "moves_gndv_ctrl_direct",
    description = "square traveled while driving land vehicles",
    description_plural = "squares traveled while driving land vehicles",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_velocity_gndv",
    statistic_type = "maximum",
    event_transformation = "moves_gndv_ctrl_direct",
    field = "abs_velocity",
    description = "maximum velocity attained while driving a land vehicle",
    description_plural = "maximum velocity attained while driving a land vehicle",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_move_gndv_ctrl_direct_z",
    statistic_type = "maximum",
    event_transformation = "moves_gndv_ctrl_direct",
    field = "z",
    description = "maximum z level reached while driving a land vehicle",
    description_plural = "maximum z level reached while driving a land vehicle",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "moves_gndv_skidding", event_transformation = "moves_gndv_ctrl_direct" }
definition:where_equals("is_skidding", "bool", true)
definition:drop("is_skidding")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_moves_gndv_skidding",
    statistic_type = "count",
    event_transformation = "moves_gndv_skidding",
    description = "square skidded while driving land vehicles",
    description_plural = "squares skidded while driving land vehicles",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "max_velocity_skidding",
    statistic_type = "maximum",
    event_transformation = "moves_gndv_skidding",
    field = "abs_velocity",
    description = "maximum velocity that a driven vehicle skidded at",
    description_plural = "maximum velocity that a driven vehicle skidded at",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wields_item", event_type = "character_wields_item" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_last_item_wielded",
    statistic_type = "last_value",
    event_transformation = "avatar_wields_item",
    field = "itype",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wields_crowbar", event_transformation = "avatar_wields_item" }
definition:where_equals("itype", "itype_id", "crowbar")
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wields_crowbar",
    statistic_type = "count",
    event_transformation = "avatar_wields_crowbar",
    description = "time wielded crowbar",
    description_plural = "times wielded crowbar",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wears_item", event_type = "character_wears_item" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wears_item",
    statistic_type = "count",
    event_transformation = "avatar_wears_item",
    description = "time worn an item",
    description_plural = "times worn an item",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wears_power_armor_heavy", event_transformation = "avatar_wears_item" }
definition:where_equals("itype", "itype_id", "combat_exoskeleton_heavy")
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wears_power_armor_heavy",
    statistic_type = "count",
    event_transformation = "avatar_wears_power_armor_heavy",
    description = "time worn tank suit",
    description_plural = "times worn tank suit",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_eats_item", event_type = "character_eats_item" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_eats_item",
    statistic_type = "count",
    event_transformation = "avatar_eats_item",
    description = "item consumed",
    description_plural = "items consumed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_consumes_item", event_type = "character_consumes_item" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_consumes_item_flag", event_transformation = "avatar_consumes_item" }
definition:derive("flag", "flags_of_itype", "itype")
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_consumes_allergen_milk", event_transformation = "avatar_consumes_item_flag" }
definition:where_equals("flag", "flag_id", "ALLERGEN_MILK")
definition:drop("flag")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_consumes_allergen_milk",
    statistic_type = "count",
    event_transformation = "avatar_consumes_allergen_milk",
    description = "dairy item consumed",
    description_plural = "dairy items consumed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_consumes_allergen_eggs", event_transformation = "avatar_consumes_item_flag" }
definition:where_equals("flag", "flag_id", "ALLERGEN_EGG")
definition:drop("flag")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_consumes_allergen_eggs",
    statistic_type = "count",
    event_transformation = "avatar_consumes_allergen_eggs",
    description = "egg-based item consumed",
    description_plural = "egg-based items consumed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_consumes_allergen_meat", event_transformation = "avatar_consumes_item_flag" }
definition:where_equals("flag", "flag_id", "ALLERGEN_MEAT")
definition:drop("flag")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_consumes_allergen_meat",
    statistic_type = "count",
    event_transformation = "avatar_consumes_allergen_meat",
    description = "meat item consumed",
    description_plural = "meat items consumed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "first_omt",
    statistic_type = "first_value",
    event_type = "avatar_enters_omt",
    field = "pos",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_first_omt", event_type = "avatar_enters_omt" }
definition:where_statistic("pos", "first_omt")
definition:drop("pos")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enter_first_omt",
    statistic_type = "count",
    event_transformation = "avatar_enters_first_omt",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_oter_type", event_type = "avatar_enters_omt" }
definition:derive("oter_type_id", "oter_type_of_oter", "oter_id")
definition:drop("oter_id")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "last_oter_type_avatar_entered",
    statistic_type = "last_value",
    event_transformation = "avatar_enters_oter_type",
    field = "oter_type_id",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_overmap_special", event_transformation = "avatar_enters_oter_type" }
definition:derive("overmap_special_id", "overmap_special_at", "pos")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "last_overmap_special_avatar_entered",
    statistic_type = "last_value",
    event_transformation = "avatar_enters_overmap_special",
    field = "overmap_special_id",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_lab_finale", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "microlab_portal_elevator" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_lab_finale",
    statistic_type = "count",
    event_transformation = "avatar_enters_lab_finale",
    description = "distorted lab entered",
    description_plural = "distorted labs entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_cuts_tree", event_type = "cuts_tree" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_cuts_tree",
    statistic_type = "count",
    event_transformation = "avatar_cuts_tree",
    description = "tree cut down",
    description_plural = "trees cut down",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_exhumes_grave", event_type = "exhumes_grave" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_exhumed_graves",
    statistic_type = "count",
    event_transformation = "avatar_exhumes_grave",
    description = "grave exhumed",
    description_plural = "graves exhumed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_buries_corpse", event_type = "buries_corpse" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("corpse_type")
definition:drop("corpse_name")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_buried_corpses",
    statistic_type = "count",
    event_transformation = "avatar_buries_corpse",
    description = "corpse buried",
    description_plural = "corpses buried",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_installs_cbm", event_type = "installs_cbm" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("bionic")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_installs_faulty_cbm", event_type = "installs_faulty_cbm" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("bionic")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_installs_cbm",
    statistic_type = "count",
    event_transformation = "avatar_installs_cbm",
    description = "bionic implant installed",
    description_plural = "bionic implants installed",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_installs_faulty_cbm",
    statistic_type = "count",
    event_transformation = "avatar_installs_faulty_cbm",
    description = "faulty bionic implant installed",
    description_plural = "faulty bionic implants installed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_mutation", event_type = "gains_mutation" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_last_gains_mutation",
    statistic_type = "last_value",
    event_transformation = "avatar_gains_mutation",
    field = "trait",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_mutation",
    statistic_type = "count",
    event_transformation = "avatar_gains_mutation",
    description = "mutation gained",
    description_plural = "mutations gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_crosses_mutation_threshold", event_type = "crosses_mutation_threshold" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_last_crosses_mutation_threshold",
    statistic_type = "last_value",
    event_transformation = "avatar_crosses_mutation_threshold",
    field = "category",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_crosses_mutation_threshold",
    statistic_type = "count",
    event_transformation = "avatar_crosses_mutation_threshold",
    description = "mutation threshold crossed",
    description_plural = "mutation thresholds crossed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_broken_bone", event_type = "broken_bone" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("part")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_broken_bone",
    statistic_type = "count",
    event_transformation = "avatar_broken_bone",
    description = "bone broken",
    description_plural = "bones broken",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_broken_right_leg", event_type = "broken_bone" }
definition:where_equals("part", "body_part", "leg_r")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_broken_left_leg", event_type = "broken_bone" }
definition:where_equals("part", "body_part", "leg_l")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_broken_right_arm", event_type = "broken_bone" }
definition:where_equals("part", "body_part", "arm_r")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_broken_left_arm", event_type = "broken_bone" }
definition:where_equals("part", "body_part", "arm_l")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_broken_right_leg",
    statistic_type = "count",
    event_transformation = "avatar_broken_right_leg",
    description = "broken right leg",
    description_plural = "broken right leg",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_broken_left_leg",
    statistic_type = "count",
    event_transformation = "avatar_broken_left_leg",
    description = "broken left leg",
    description_plural = "broken left leg",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_broken_right_arm",
    statistic_type = "count",
    event_transformation = "avatar_broken_right_arm",
    description = "broken right arm",
    description_plural = "broken right arm",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_broken_left_arm",
    statistic_type = "count",
    event_transformation = "avatar_broken_left_arm",
    description = "broken left arm",
    description_plural = "broken left arm",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_skill_level", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_skill_level",
    statistic_type = "count",
    event_transformation = "avatar_gains_skill_level",
    description = "skill level gained",
    description_plural = "skill levels gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_speech_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "speech")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_speech_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_speech_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_computer_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "computer")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_computer_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_computer_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_firstaid_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "firstaid")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_firstaid_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_firstaid_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_mechanics_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "mechanics")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_mechanics_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_mechanics_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_traps_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "traps")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_traps_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_traps_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_driving_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "driving")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_driving_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_driving_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_swimming_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "swimming")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_swimming_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_swimming_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_fabrication_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "fabrication")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_fabrication_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_fabrication_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cooking_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cooking")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cooking_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_cooking_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_tailor_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "tailor")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_tailor_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_tailor_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_survival_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "survival")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_survival_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_survival_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_electronics_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "electronics")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_electronics_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_electronics_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_archery_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "archery")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_archery_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_archery_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_gun_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "gun")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_gun_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_gun_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_launcher_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "launcher")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_launcher_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_launcher_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_pistol_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "pistol")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_pistol_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_pistol_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_rifle_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "rifle")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_rifle_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_rifle_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_shotgun_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "shotgun")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_shotgun_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_shotgun_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_smg_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "smg")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_smg_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_smg_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_throw_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "throw")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_throw_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_throw_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_melee_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "melee")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_melee_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_melee_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_bashing_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "bashing")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_bashing_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_bashing_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cutting_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cutting")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cutting_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_cutting_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_dodge_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "dodge")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_dodge_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_dodge_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_stabbing_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "stabbing")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_stabbing_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_stabbing_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_unarmed_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "unarmed")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_unarmed_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_unarmed_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_chemistry_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "chemistry")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_chemistry_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_chemistry_level_4",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_speech_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "speech")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_speech_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_speech_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_computer_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "computer")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_computer_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_computer_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_firstaid_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "firstaid")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_firstaid_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_firstaid_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_mechanics_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "mechanics")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_mechanics_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_mechanics_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_traps_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "traps")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_traps_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_traps_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_driving_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "driving")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_driving_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_driving_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_swimming_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "swimming")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_swimming_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_swimming_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_fabrication_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "fabrication")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_fabrication_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_fabrication_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cooking_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cooking")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cooking_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_cooking_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_tailor_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "tailor")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_tailor_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_tailor_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_survival_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "survival")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_survival_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_survival_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_electronics_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "electronics")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_electronics_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_electronics_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_archery_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "archery")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_archery_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_archery_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_gun_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "gun")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_gun_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_gun_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_launcher_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "launcher")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_launcher_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_launcher_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_pistol_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "pistol")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_pistol_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_pistol_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_rifle_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "rifle")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_rifle_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_rifle_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_shotgun_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "shotgun")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_shotgun_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_shotgun_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_smg_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "smg")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_smg_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_smg_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_throw_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "throw")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_throw_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_throw_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_melee_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "melee")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_melee_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_melee_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_bashing_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "bashing")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_bashing_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_bashing_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cutting_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cutting")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cutting_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_cutting_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_dodge_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "dodge")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_dodge_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_dodge_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_stabbing_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "stabbing")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_stabbing_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_stabbing_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_unarmed_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "unarmed")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_unarmed_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_unarmed_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_chemistry_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "chemistry")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_chemistry_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_chemistry_level_7",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_speech_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "speech")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_speech_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_speech_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_computer_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "computer")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_computer_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_computer_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_firstaid_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "firstaid")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_firstaid_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_firstaid_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_mechanics_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "mechanics")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_mechanics_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_mechanics_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_traps_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "traps")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_traps_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_traps_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_driving_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "driving")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_driving_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_driving_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_swimming_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "swimming")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_swimming_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_swimming_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_fabrication_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "fabrication")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_fabrication_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_fabrication_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cooking_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cooking")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cooking_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_cooking_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_tailor_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "tailor")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_tailor_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_tailor_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_survival_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "survival")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_survival_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_survival_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_electronics_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "electronics")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_electronics_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_electronics_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_archery_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "archery")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_archery_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_archery_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_gun_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "gun")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_gun_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_gun_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_launcher_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "launcher")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_launcher_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_launcher_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_pistol_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "pistol")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_pistol_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_pistol_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_rifle_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "rifle")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_rifle_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_rifle_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_shotgun_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "shotgun")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_shotgun_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_shotgun_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_smg_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "smg")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_smg_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_smg_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_throw_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "throw")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_throw_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_throw_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_melee_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "melee")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_melee_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_melee_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_bashing_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "bashing")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_bashing_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_bashing_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_cutting_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "cutting")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_cutting_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_cutting_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_dodge_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "dodge")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_dodge_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_dodge_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_stabbing_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "stabbing")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_stabbing_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_stabbing_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_unarmed_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "unarmed")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_unarmed_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_unarmed_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_chemistry_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "chemistry")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_chemistry_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_chemistry_level_10",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_reads_book", event_type = "reads_book" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_reads_book",
    statistic_type = "count",
    event_transformation = "avatar_reads_book",
    description = "read a book",
    description_plural = "read a book",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "portal_storm_happened", event_type = "u_var_changed" }
definition:where_equals("var", "string", "portal_storm_counter")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "witnessed_portal_storm",
    statistic_type = "count",
    event_transformation = "portal_storm_happened",
    description = "portal storms seen",
    description_plural = "portal storms seen",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_hospital", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "hospital_1", "hospital_2", "hospital_3", "hospital_4", "hospital_5", "hospital_6", "hospital_7", "hospital_8", "hospital_9", "hospital_1_roof", "hospital_2_roof", "hospital_3_roof", "hospital_4_roof", "hospital_5_roof", "hospital_6_roof", "hospital_7_roof", "hospital_8_roof", "hospital_9_roof", "urban_35_1", "urban_35_2", "urban_35_3", "urban_35_4", "urban_35_5", "urban_35_6", "urban_35_7", "urban_35_8", "urban_35_9", "urban_35_10", "urban_35_11", "urban_35_12", "urban_35_13", "urban_35_14", "urban_35_15", "urban_35_16", "urban_35_17", "urban_35_18", "urban_35_19", "urban_35_20", "urban_35_21", "urban_35_22", "urban_35_23", "urban_35_24", "urban_35_25", "urban_35_26", "urban_35_27", "urban_35_28", "urban_35_29", "urban_35_30", "urban_35_31", "urban_35_32", "urban_35_33", "urban_35_34", "urban_35_35" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_hospital",
    statistic_type = "count",
    event_transformation = "avatar_enters_hospital",
    description = "hospital entered",
    description_plural = "hospitals entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_mansion", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "mansion_+1", "mansion_+1d", "mansion_+1u", "mansion_+1_roof", "mansion_+2", "mansion_+2d", "mansion_+2u", "mansion_+2_roof", "mansion_+3", "mansion_+3u", "mansion_+3_roof", "mansion_+4", "mansion_+4d", "mansion_+4u", "mansion_+4_roof", "mansion_boarded_c1", "mansion_c1", "mansion_c1d", "mansion_boarded_c1u", "mansion_c1u", "mansion_c1_roof", "mansion_boarded_c2", "mansion_c2", "mansion_c2d", "mansion_boarded_c2u", "mansion_c2u", "mansion_c2_roof", "mansion_boarded_c3", "mansion_c3", "mansion_c3d", "mansion_boarded_c3u", "mansion_c3u", "mansion_c3_roof", "mansion_boarded_c4", "mansion_c4", "mansion_c4d", "mansion_boarded_c4u", "mansion_c4u", "mansion_c4_roof", "mansion_c5", "mansion_c5d", "mansion_c5u", "mansion_c5_roof", "mansion_e1d", "mansion_boarded_e1u", "mansion_e1u", "mansion_e1_roof", "mansion_e2d", "mansion_e2u", "mansion_e2_roof", "mansion_t1", "mansion_t1d", "mansion_t1u", "mansion_t1_roof", "mansion_boarded_t2", "mansion_boarded_t2_start", "mansion_t2", "mansion_boarded_t2d", "mansion_boarded_t2d_start", "mansion_t2d", "mansion_boarded_t2u", "mansion_t2u", "mansion_t2_roof", "mansion_boarded_t4", "mansion_t4", "mansion_t4d", "mansion_boarded_t4u", "mansion_t4u", "mansion_t4_roof", "mansion_t5", "mansion_t5d", "mansion_t5u", "mansion_t5_roof", "mansion_t6", "mansion_t6d", "mansion_t6u", "mansion_t6_roof", "mansion_t7", "mansion_t7d", "mansion_t7u", "mansion_t7_roof" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_mansion",
    statistic_type = "count",
    event_transformation = "avatar_enters_mansion",
    description = "mansion entered",
    description_plural = "mansions entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_mine", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "mine_entrance", "mine_entrance_loading_zone" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_mine",
    statistic_type = "count",
    event_transformation = "avatar_enters_mine",
    description = "mine entered",
    description_plural = "mines entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_police_station", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "police", "police_1", "police_2" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_police_station",
    statistic_type = "count",
    event_transformation = "avatar_enters_police_station",
    description = "Police Station entered",
    description_plural = "Police Stations entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_trans_lab", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "lab_surface_parking_blockA0", "lab_surface_parking_blockB0", "lab_surface_parking_blockC0", "lab_surface_parking_blockD0", "lab_surface_parking_blockE0", "lab_surface_parking_blockA1", "lab_surface_parking_blockB1", "lab_surface_parking_blockC1", "lab_surface_parking_blockD1", "lab_surface_parking_blockE1", "lab_surface_parking_blockA2", "lab_surface_parking_blockE2", "lab_security_z0", "lab_security_z0N", "lab_security_z0S", "lab_res_8_SWD_ground", "lab_res_8_SED_ground", "lab_res_8_SWU_ground", "lab_res_8_SEU_ground", "lab_CORE_2x1_SED_ground", "lab_CORE_2x1_SWD_ground", "lab_CORE_2x1_NED_ground", "lab_CORE_2x1_NWD_ground", "lab_CORE_2x1_WC_ground", "lab_CORE_2x1_EC_ground" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_trans_lab",
    statistic_type = "count",
    event_transformation = "avatar_enters_trans_lab",
    description = "Trans Coastal Lab entered",
    description_plural = "Trans Coastal Labs entered",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_LIXA", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "LIXA_surface_1a", "LIXA_surface_1b", "LIXA_surface_2a", "LIXA_surface_2b" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_LIXA",
    statistic_type = "count",
    event_transformation = "avatar_enters_LIXA",
    description = "LIXA entered",
    description_plural = "LIXAs entered",
}
content.add(definition)
end
