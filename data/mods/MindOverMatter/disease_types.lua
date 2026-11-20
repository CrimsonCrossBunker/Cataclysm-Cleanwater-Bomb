local ccb = require("ccb")
local content = ccb.content

-- Native disease types
do
local definition = content.DiseaseType {
    id = "black_nether_water_disease",
    symptoms = "effect_black_nether_water_disease",
    minimum_duration_turns = 1800,
    maximum_duration_turns = 21600,
    minimum_intensity = 1,
    maximum_intensity = 1,
    health_threshold = 210,
}
content.add(definition)
end
do
local definition = content.DiseaseType {
    id = "black_nether_water_disease_masses",
    symptoms = "effect_black_nether_water_disease",
    minimum_duration_turns = 2,
    maximum_duration_turns = 2,
    minimum_intensity = 1,
    maximum_intensity = 1,
    health_threshold = 210,
}
content.add(definition)
end
do
local definition = content.DiseaseType {
    id = "fungal_contamination",
    symptoms = "fungus",
    minimum_duration_turns = 604800,
    maximum_duration_turns = 1814400,
    minimum_intensity = 1,
    maximum_intensity = 3,
    health_threshold = 210,
}
content.add(definition)
end
