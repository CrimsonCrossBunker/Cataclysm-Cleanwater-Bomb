local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventStatistic {
    id = "num_gains_metaphysics_level_4",
    statistic_type = "count",
    event_transformation = "avatar_gains_metaphysics_level_4",
    description = "Metaphysics skill level 4 gained",
    description_plural = "Metaphysics skill level 4 gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_metaphysics_level_4", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "metaphysics")
definition:where_equals("new_level", "int", "4")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_metaphysics_level_7",
    statistic_type = "count",
    event_transformation = "avatar_gains_metaphysics_level_7",
    description = "Metaphysics skill level 7 gained",
    description_plural = "Metaphysics skill level 7 gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_metaphysics_level_7", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "metaphysics")
definition:where_equals("new_level", "int", "7")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_gains_metaphysics_level_10",
    statistic_type = "count",
    event_transformation = "avatar_gains_metaphysics_level_10",
    description = "Metaphysics skill level 10 gained",
    description_plural = "Metaphysics skill level 10 gained",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_gains_metaphysics_level_10", event_type = "gains_skill_level" }
definition:where_statistic("character", "avatar_id")
definition:where_equals("skill", "skill_id", "metaphysics")
definition:where_equals("new_level", "int", "10")
definition:drop("character")
definition:drop("skill")
definition:drop("new_level")
content.add(definition)
end
