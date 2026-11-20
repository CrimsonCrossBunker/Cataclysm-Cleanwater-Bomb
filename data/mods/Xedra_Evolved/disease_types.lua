local ccb = require("ccb")
local content = ccb.content

-- Native disease types
do
local definition = content.DiseaseType {
    id = "fae_food",
    symptoms = "foxfire_imbibed",
    minimum_duration_turns = 360,
    maximum_duration_turns = 3600,
    minimum_intensity = 1,
    maximum_intensity = 3,
    health_threshold = 100,
}
content.add(definition)
end
do
local definition = content.DiseaseType {
    id = "xe_hydrating_gout_incubation",
    symptoms = "xe_hydrating_gout_incubation",
    minimum_duration_turns = 79200,
    maximum_duration_turns = 93600,
    minimum_intensity = 1,
    maximum_intensity = 1,
}
content.add(definition)
end
