local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventTransformation { id = "avatar_levels_spell", event_type = "player_levels_spell" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_learns_spell", event_type = "character_learns_spell" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_spells_learned",
    statistic_type = "count",
    event_transformation = "avatar_learns_spell",
    description = "spell learned",
    description_plural = "spells learned",
}
content.add(definition)
end
do
local definition = content.EventTransformation { id = "avatar_forgets_spell", event_type = "character_forgets_spell" }
definition:where_statistic("character", "avatar_id")
definition:drop("character")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_spells_forgotten",
    statistic_type = "count",
    event_transformation = "avatar_forgets_spell",
    description = "spell forgotten",
    description_plural = "spells forgotten",
}
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "avatar_max_spell_level",
    statistic_type = "maximum",
    event_transformation = "avatar_levels_spell",
    field = "new_level",
    description = "maximum spell level earned",
    description_plural = "maximum spell level earned",
}
content.add(definition)
end
