local content = require("ccb").content

content.add(content.DimensionRegionLayout {
    id = "default_isolation",
    generation_mode = "UNIFORM",
    uniform_region = "default_isolation",
})

content.replace(content.Dimension { id = "default", region_layout = "default_isolation" })
