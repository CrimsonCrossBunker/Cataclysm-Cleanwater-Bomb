local content = require("ccb").content

content.add(content.Dimension {
    id = "backrooms_level_0",
    region_layout = "backrooms_level_0",
})

content.add(content.DimensionRegionLayout {
    id = "backrooms_level_0",
    generation_mode = "UNIFORM",
    uniform_region = "default_backrooms",
})
