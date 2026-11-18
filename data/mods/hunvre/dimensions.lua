local content = require("ccb").content

content.replace(content.Dimension { id = "default", region_layout = "default_hunvre" })

content.add(content.DimensionRegionLayout {
    id = "default_hunvre",
    generation_mode = "UNIFORM",
    uniform_region = "hunvre",
})
