local content = require("ccb").content

content.add(content.DimensionRegionLayout {
    id = "default_backrooms",
    generation_mode = "UNIFORM",
    uniform_region = "default_backrooms",
})

content.replace(content.Dimension { id = "default", region_layout = "default_backrooms" })
