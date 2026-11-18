local content = require("ccb").content

content.add(content.DimensionRegionLayout {
    id = "default_nohope",
    generation_mode = "UNIFORM",
    uniform_region = "default_nohope",
})

content.replace(content.Dimension { id = "default", region_layout = "default_nohope" })
