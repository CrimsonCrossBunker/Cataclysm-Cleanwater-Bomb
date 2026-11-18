local content = require("ccb").content

content.add(content.OvermapLocation {
    id = "source_of_anything",
    flags = { "GENERIC_LOOT" },
})

content.add(content.OvermapLocation {
    id = "source_of_ammo",
    flags = { "SOURCE_AMMO" },
})

content.add(content.OvermapLocation {
    id = "source_of_guns",
    flags = { "SOURCE_GUN" },
})

content.add(content.OvermapLocation {
    id = "source_of_weapons",
    flags = { "SOURCE_WEAPON", "SOURCE_GUN" },
})

content.add(content.OvermapLocation {
    id = "source_of_drink",
    flags = { "SOURCE_DRINK" },
})

content.add(content.OvermapLocation {
    id = "source_of_food",
    flags = { "SOURCE_FOOD" },
})

content.add(content.OvermapLocation {
    id = "source_of_fuel",
    flags = { "SOURCE_FUEL" },
})

content.add(content.OvermapLocation {
    id = "source_of_farming",
    flags = { "SOURCE_FARMING" },
})

content.add(content.OvermapLocation {
    id = "source_of_fabrication",
    flags = { "SOURCE_FABRICATION" },
})

content.add(content.OvermapLocation {
    id = "source_of_books",
    flags = { "SOURCE_BOOKS" },
})

content.add(content.OvermapLocation {
    id = "source_of_forage",
    flags = { "SOURCE_FORAGE" },
})

content.add(content.OvermapLocation {
    id = "source_of_cooking",
    flags = { "SOURCE_COOKING" },
})

content.add(content.OvermapLocation {
    id = "source_of_tailoring",
    flags = { "SOURCE_TAILORING" },
})

content.add(content.OvermapLocation {
    id = "source_of_vehicles",
    flags = { "SOURCE_VEHICLES" },
})

content.add(content.OvermapLocation {
    id = "source_of_electronics",
    flags = { "SOURCE_ELECTRONICS" },
})

content.add(content.OvermapLocation {
    id = "source_of_construction",
    flags = { "SOURCE_CONSTRUCTION" },
})

content.add(content.OvermapLocation {
    id = "source_of_chemistry",
    flags = { "SOURCE_CHEMISTRY" },
})

content.add(content.OvermapLocation {
    id = "source_of_clothing",
    flags = { "SOURCE_CLOTHING" },
})

content.add(content.OvermapLocation {
    id = "source_of_safety",
    flags = { "SOURCE_SAFETY" },
})

content.add(content.OvermapLocation {
    id = "source_of_animals",
    flags = { "SOURCE_ANIMALS" },
})

content.add(content.OvermapLocation {
    id = "source_of_medicine",
    flags = { "SOURCE_MEDICINE" },
})

content.add(content.OvermapLocation {
    id = "source_of_luxuries",
    flags = { "SOURCE_LUXURY" },
})

content.add(content.OvermapLocation {
    id = "source_of_people",
    flags = { "SOURCE_PEOPLE" },
})

content.add(content.OvermapLocation {
    id = "risk_extreme",
    flags = { "RISK_EXTREME" },
})

content.add(content.OvermapLocation {
    id = "risk_high",
    flags = { "RISK_HIGH" },
})

content.add(content.OvermapLocation {
    id = "risk_low",
    flags = { "RISK_LOW" },
})

content.add(content.OvermapLocation {
    id = "netherum_labyrinth_sparkling_chasm",
    terrains = { "netherum_labyrinth_sparkling_chasm" },
})

content.add(content.OvermapLocation {
    id = "labyrinth2",
    terrains = { "labyrinth2" },
})

content.add(content.OvermapLocation {
    id = "inner_cabins",
    terrains = { "inner_cabins" },
})

content.add(content.OvermapLocation {
    id = "scarlet_sea_reverberation",
    terrains = { "scarlet_sea_reverberation" },
})

content.add(content.OvermapLocation {
    id = "string_dimension_crossroads",
    terrains = { "string_dimension_crossroads" },
})

content.add(content.OvermapLocation {
    id = "string_dimension_true_void",
    terrains = { "string_dimension_true_void" },
})

content.add(content.OvermapLocation {
    id = "field",
    terrains = { "field", "meadow_core", "meadow_end", "highlands" },
})

content.add(content.OvermapLocation {
    id = "field_no_meadow",
    terrains = { "field" },
})

content.add(content.OvermapLocation {
    id = "stream",
    terrains = { "stream" },
})

content.add(content.OvermapLocation {
    id = "forest_without_trail",
    terrains = { "forest", "forest_thick" },
})

content.add(content.OvermapLocation {
    id = "forest_with_swamp",
    terrains = { "forest", "forest_thick", "forest_water" },
})

content.add(content.OvermapLocation {
    id = "forest",
    terrains = { "forest", "forest_thick", "forest_trail" },
})

content.add(content.OvermapLocation {
    id = "swamp",
    terrains = { "forest_water" },
})

content.add(content.OvermapLocation {
    id = "land",
    terrains = {
        "field",
        "meadow_core",
        "meadow_end",
        "forest",
        "forest_thick",
        "forest_water",
        "forest_trail",
        "highlands",
    },
})

content.add(content.OvermapLocation {
    id = "crater",
    terrains = { "crater" },
})

content.add(content.OvermapLocation {
    id = "special_field",
    terrains = { "special_field" },
})

content.add(content.OvermapLocation {
    id = "special_forest",
    terrains = { "special_forest", "special_forest_thick" },
})

content.add(content.OvermapLocation {
    id = "water",
    terrains = {
        "river",
        "river_center",
        "river_c_not_ne",
        "river_c_not_nw",
        "river_c_not_se",
        "river_c_not_sw",
        "river_ne",
        "river_se",
        "river_sw",
        "river_nw",
    },
})

content.add(content.OvermapLocation {
    id = "wilderness",
    terrains = { "forest", "forest_thick", "field", "forest_trail" },
})

content.add(content.OvermapLocation {
    id = "subterranean",
    terrains = { "empty_rock", "sewer", "solid_earth" },
})

content.add(content.OvermapLocation {
    id = "subterranean_empty",
    terrains = { "deep_rock", "empty_rock", "solid_earth" },
})

content.add(content.OvermapLocation {
    id = "subterranean_subway",
    terrains = { "empty_rock", "subway" },
})

content.add(content.OvermapLocation {
    id = "lab_subway",
    terrains = { "deep_rock" },
})

content.add(content.OvermapLocation {
    id = "road",
    terrains = { "ranch_camp_77", "road", "road_nesw_manhole" },
})

content.add(content.OvermapLocation {
    id = "highway",
    terrains = { "hw_reserved" },
})

content.add(content.OvermapLocation {
    id = "highway_water",
    terrains = { "hw_reserved_water" },
})

content.add(content.OvermapLocation {
    id = "forest_trail",
    terrains = { "forest_trail" },
})

content.add(content.OvermapLocation {
    id = "forest_edge",
    terrains = { "forest" },
})

content.add(content.OvermapLocation {
    id = "forest_center",
    terrains = { "forest_thick" },
})

content.add(content.OvermapLocation {
    id = "lake_surface",
    terrains = { "lake_surface" },
})

content.add(content.OvermapLocation {
    id = "lake_water_cube",
    terrains = { "lake_water_cube" },
})

content.add(content.OvermapLocation {
    id = "lake_bed",
    terrains = { "lake_bed" },
})

content.add(content.OvermapLocation {
    id = "lake_shore",
    terrains = { "lake_shore" },
})

content.add(content.OvermapLocation {
    id = "ocean_surface",
    terrains = { "ocean_surface" },
})

content.add(content.OvermapLocation {
    id = "ocean_water_cube",
    terrains = { "ocean_water_cube" },
})

content.add(content.OvermapLocation {
    id = "ocean_bed",
    terrains = { "ocean_bed" },
})

content.add(content.OvermapLocation {
    id = "ocean_shore",
    terrains = { "ocean_shore" },
})

content.add(content.OvermapLocation {
    id = "open_air",
    terrains = { "open_air" },
})

content.add(content.OvermapLocation {
    id = "special_isherwood",
    terrains = { "special_forest_isherwood", "special_forest_thick_isherwood" },
})

content.add(content.OvermapLocation {
    id = "agricultural",
    terrains = {
        "rural_road",
        "rural_road_forest",
        "farmland_straight",
        "farmland_turn",
        "farmland_turn_inside",
        "farmland_U",
        "hayfield_straight",
        "hayfield_turnL",
        "hayfield_turnR",
        "hayfield_end",
    },
})

content.add(content.OvermapLocation {
    id = "nether",
    terrains = { "nether_glass_impassable", "nether_glass", "nether_glass_deep", "nether_glass_imperial_road" },
})

content.add(content.OvermapLocation {
    id = "string_dimension_field_core",
    terrains = { "string_dimension_field_core" },
})

content.add(content.OvermapLocation {
    id = "string_dimension_plane_core",
    terrains = { "string_dimension_plane_core" },
})

content.add(content.OvermapLocation {
    id = "portal_storm_dungeon",
    terrains = { "default_portal_storm_dungeon_overmap" },
})
