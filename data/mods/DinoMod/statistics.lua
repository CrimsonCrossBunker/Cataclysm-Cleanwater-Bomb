local ccb = require("ccb")
local content = ccb.content

-- Native event transformations and event statistics
do
local definition = content.EventTransformation { id = "avatar_dino_kills", event_transformation = "avatar_species_kills" }
definition:where_equals("species", "species_id", "DINOSAUR")
content.add(definition)
end
do
local definition = content.EventStatistic {
    id = "num_avatar_dino_kills",
    statistic_type = "count",
    event_transformation = "avatar_dino_kills",
    description = "dino killed",
    description_plural = "dinos killed",
}
content.add(definition)
end
