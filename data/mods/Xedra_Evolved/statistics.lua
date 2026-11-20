local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventTransformation { id = "avatar_changeling_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "CHANGELING")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_changeling_kills",
    statistic_type = "count",
    event_transformation = "avatar_changeling_kills",
    description = "changeling killed",
    description_plural = "changelings killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_vampire_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "VAMPIRE")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_vampire_kills",
    statistic_type = "count",
    event_transformation = "avatar_vampire_kills",
    description = "vampire killed",
    description_plural = "vampires killed",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_deduction_level_1", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "deduction")
definition:where_equals("new_level", "int", "1")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_deduction_level_1",
    statistic_type = "count",
    event_transformation = "avatar_gains_deduction_level_1",
    description = "Investigation skill level 1 gained",
    description_plural = "Investigation skill level 1 gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_deduction_level_5", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "deduction")
definition:where_equals("new_level", "int", "5")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_deduction_level_5",
    statistic_type = "count",
    event_transformation = "avatar_gains_deduction_level_5",
    description = "Investigation skill level 5 gained",
    description_plural = "Investigation skill level 5 gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_deduction_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "deduction")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_deduction_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_deduction_level_10",
    description = "Investigation skill level 10 gained",
    description_plural = "Investigation skill level 10 gained",
}
content.add(definition)
end
