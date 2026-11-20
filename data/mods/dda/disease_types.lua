local ccb = require("ccb")
local content = ccb.content

-- Native disease types
do
local definition = content.DiseaseType {
    id = "bad_food",
    symptoms = "foodpoison",
    minimum_duration_turns = 360,
    maximum_duration_turns = 3600,
    minimum_intensity = 1,
    maximum_intensity = 1,
    health_threshold = 100,
}
content.add(definition)
end
do
local definition = content.DiseaseType {
    id = "highly_contaminated_food",
    symptoms = "foodpoison",
    minimum_duration_turns = 21600,
    maximum_duration_turns = 86400,
    minimum_intensity = 1,
    maximum_intensity = 5,
    health_threshold = 210,
}
content.add(definition)
end
