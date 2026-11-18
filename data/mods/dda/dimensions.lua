local content = require("ccb").content

content.add(content.DimensionRegionLayout {
    id = "default",
    generation_mode = "UNIFORM",
    uniform_region = "default",
})

content.add(content.DimensionRegionLayout {
    id = "nether_abyss",
    generation_mode = "UNIFORM",
    uniform_region = "nether_abyss",
})

content.add(content.DimensionRegionLayout {
    id = "highlands",
    generation_mode = "UNIFORM",
    uniform_region = "highlands",
})

content.add(content.DimensionRegionLayout {
    id = "highland_imperial_road",
    generation_mode = "UNIFORM",
    uniform_region = "highland_imperial_road",
})

content.add(content.DimensionRegionLayout {
    id = "netherum_labyrinth",
    generation_mode = "UNIFORM",
    uniform_region = "netherum_labyrinth",
})

content.add(content.DimensionRegionLayout {
    id = "netherum_labyrinth2",
    generation_mode = "UNIFORM",
    uniform_region = "netherum_labyrinth2",
})

content.add(content.DimensionRegionLayout {
    id = "netherum_labyrinth_safehouse",
    generation_mode = "UNIFORM",
    uniform_region = "netherum_labyrinth_safehouse",
})

content.add(content.DimensionRegionLayout {
    id = "cabins",
    generation_mode = "UNIFORM",
    uniform_region = "cabins",
})

content.add(content.DimensionRegionLayout {
    id = "inner_cabins",
    generation_mode = "UNIFORM",
    uniform_region = "inner_cabins",
})

content.add(content.DimensionRegionLayout {
    id = "radiosphere",
    generation_mode = "UNIFORM",
    uniform_region = "radiosphere",
})

content.add(content.DimensionRegionLayout {
    id = "spider_dimension",
    generation_mode = "UNIFORM",
    uniform_region = "spider_dimension",
})

content.add(content.DimensionRegionLayout {
    id = "scarlet",
    generation_mode = "UNIFORM",
    uniform_region = "scarlet",
})

content.add(content.DimensionRegionLayout {
    id = "string_dimension",
    generation_mode = "UNIFORM",
    uniform_region = "string_dimension",
})

content.add(content.DimensionRegionLayout {
    id = "string_dimension_ka",
    generation_mode = "UNIFORM",
    uniform_region = "string_dimension_ka",
})

content.add(content.Dimension { id = "default", region_layout = "default" })

content.add(content.Dimension { id = "abyss", region_layout = "nether_abyss" })

content.add(content.Dimension { id = "highlands", region_layout = "highlands" })

content.add(content.Dimension { id = "imperial_road", region_layout = "highland_imperial_road" })

content.add(content.Dimension { id = "netherum_labyrinth", region_layout = "netherum_labyrinth" })

content.add(content.Dimension { id = "netherum_labyrinth2", region_layout = "netherum_labyrinth2" })

content.add(content.Dimension {
    id = "netherum_labyrinth_safehouse",
    region_layout = "netherum_labyrinth_safehouse",
})

content.add(content.Dimension { id = "radiosphere", region_layout = "radiosphere" })

content.add(content.Dimension { id = "cabins", region_layout = "cabins" })

content.add(content.Dimension { id = "inner_cabins", region_layout = "inner_cabins" })

content.add(content.Dimension { id = "spider_dimension", region_layout = "spider_dimension" })

content.add(content.Dimension { id = "scarlet", region_layout = "scarlet" })

content.add(content.Dimension { id = "string_dimension", region_layout = "string_dimension" })

content.add(content.Dimension { id = "string_dimension_ka", region_layout = "string_dimension_ka" })

content.add(content.Dimension {
    id = "portal_storm_dungeon_dimension",
    region_layout = "default_portal_storm_dungeon",
})

content.add(content.DimensionRegionLayout {
    id = "default_portal_storm_dungeon",
    generation_mode = "UNIFORM",
    uniform_region = "default_portal_storm_dungeon",
})
