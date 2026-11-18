local content = require("ccb").content

content.add(content.Dimension {
    id = "dimension_perk_closetland",
    region_layout = "dimension_perk_closetland",
})

content.add(content.DimensionRegionLayout {
    id = "dimension_perk_closetland",
    generation_mode = "UNIFORM",
    uniform_region = "dimension_perk_closetland_settings",
})
