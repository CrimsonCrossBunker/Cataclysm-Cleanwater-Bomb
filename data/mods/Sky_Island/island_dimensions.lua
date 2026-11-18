local content = require("ccb").content

content.add(content.Dimension {
    id = "dimension_sky_island_region",
    region_layout = "dimension_sky_island_region",
})

content.add(content.DimensionRegionLayout {
    id = "dimension_sky_island_region",
    generation_mode = "UNIFORM",
    uniform_region = "dimension_sky_island_region",
})

content.add(content.Dimension {
    id = "sky_island_raid_region_hot",
    region_layout = "sky_island_raid_region_hot",
})

content.add(content.DimensionRegionLayout {
    id = "sky_island_raid_region_hot",
    generation_mode = "UNIFORM",
    uniform_region = "sky_island_raid_region_hot",
})

content.add(content.Dimension {
    id = "sky_island_raid_region_cold",
    region_layout = "sky_island_raid_region_cold",
})

content.add(content.DimensionRegionLayout {
    id = "sky_island_raid_region_cold",
    generation_mode = "UNIFORM",
    uniform_region = "sky_island_raid_region_cold",
})

content.add(content.Dimension {
    id = "sky_island_raid_region_mega_city",
    region_layout = "sky_island_raid_region_mega_city",
})

content.add(content.DimensionRegionLayout {
    id = "sky_island_raid_region_mega_city",
    generation_mode = "UNIFORM",
    uniform_region = "sky_island_raid_region_mega_city",
})

content.add(content.DimensionRegionLayout {
    id = "default_skyisland",
    generation_mode = "UNIFORM",
    uniform_region = "default_skyisland",
})

content.replace(content.Dimension { id = "default", region_layout = "default_skyisland" })
