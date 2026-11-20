local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "ravine_bottom",
    chance = 30,
}
definition:extra("mx_grove_ravine", 200)
definition:extra("mx_pond_ravine", 150)
definition:extra("mx_pond_forest_ravine", 100)
definition:extra("mx_pond_forest_2_ravine", 50)
definition:extra("mx_shrubbery_ravine", 100)
definition:extra("mx_blackberry_patch", 25)
definition:extra("mx_strawberry_patch", 25)
definition:extra("mx_blueberry_patch", 25)
definition:extra("mx_raspberry_patch", 25)
definition:extra("mx_huckleberry_patch", 25)
definition:extra("mx_hobblebush_patch", 25)
definition:extra("mx_autumn_olive_patch", 25)
definition:extra("mx_spider", 25)
content.add(definition)
end
