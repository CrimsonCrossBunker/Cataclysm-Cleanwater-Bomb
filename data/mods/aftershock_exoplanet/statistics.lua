local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventTransformation { id = "avatar_moxie_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "MOXIE")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_crashed_ship", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "afs_crashed_cargo_shuttle", "afs_crashed_cargo_shuttle_wraitheon" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_crashed_ship",
    statistic_type = "count",
    event_transformation = "avatar_enters_crashed_ship",
    description = "crashed ship visited",
    description_plural = "crashed ships visited",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_enters_ruins", event_transformation = "avatar_enters_oter_type" }
definition:where_any("oter_type_id", "oter_type_str_id", { "afs_formless_ruins_dynamic", "afs_formless_ruins_aeolian", "afs_formless_ruins_industrial", "afs_formless_ruins_pipe" })
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_enters_ruins",
    statistic_type = "count",
    event_transformation = "avatar_enters_ruins",
    description = "ruin visited",
    description_plural = "ruins visited",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wields_archeotech_gun", event_transformation = "avatar_wields_item" }
definition:where_any("itype", "itype_id", { "afs_archeotech_laspistol", "afs_electro_anomaly_rifle" })
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wields_archeotech_gun",
    statistic_type = "count",
    event_transformation = "avatar_wields_archeotech_gun",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_kills_independent_merc", event_type = "character_kills_character" }
definition:where_statistic("killer", "avatar_id")
definition:where_any("victim_class", "string", { "NC_AFS_SOLO", "cryo_hacker" })
definition:drop("killer")
definition:drop("victim_class")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_independent_merc_kills",
    statistic_type = "count",
    event_transformation = "avatar_kills_independent_merc",
    description = "independent contractor killed",
    description_plural = "independent contractors killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_kills_uica_soldier", event_type = "character_kills_character" }
definition:where_statistic("killer", "avatar_id")
definition:where_any("victim_class", "string", { "augustmoon_security", "uica_ground_officer", "uica_ground_soldier" })
definition:drop("killer")
definition:drop("victim_class")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_uica_soldier_kills",
    statistic_type = "count",
    event_transformation = "avatar_kills_uica_soldier",
    description = "dead cop",
    description_plural = "dead cops",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_max_damage",
    statistic_type = "maximum",
    event_transformation = "avatar_takes_damage",
    field = "damage",
    description = "maximum damage taken in a single instant.",
    description_plural = "maximum damage taken in a single instant.",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wields_plasma_gun", event_transformation = "avatar_wields_item" }
definition:where_any("itype", "itype_id", { "afs_magnadrive_230k", "afs_pam-41", "afs_plasma_torch_gun", "afs_makeshift_fusion_gun" })
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_wields_plasma_gun",
    statistic_type = "count",
    event_transformation = "avatar_wields_plasma_gun",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_wields_prediscontinuity_weapon", event_transformation = "avatar_wields_item" }
definition:where_equals("itype", "itype_id", "crowbar")
definition:drop("itype")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_moxie_kills",
    statistic_type = "count",
    event_transformation = "avatar_moxie_kills",
    description = "moxie killed",
    description_plural = "moxies killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_uplift_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "UPLIFT")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_uplift_kills",
    statistic_type = "count",
    event_transformation = "avatar_uplift_kills",
    description = "uplift killed",
    description_plural = "uplifts killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_biomachine_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "BIOMACHINE")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_biomachine_kills",
    statistic_type = "count",
    event_transformation = "avatar_biomachine_kills",
    description = "biomachine killed",
    description_plural = "biomachines killed",
}
content.add(definition)
end
