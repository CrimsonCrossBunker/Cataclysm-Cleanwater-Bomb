local content = require("ccb").content

content.add(content.DimensionRegionLayout {
    id = "default_aftershock",
    generation_mode = "UNIFORM",
    uniform_region = "default_aftershock",
})

content.replace(content.Dimension { id = "default", region_layout = "default_aftershock" })
