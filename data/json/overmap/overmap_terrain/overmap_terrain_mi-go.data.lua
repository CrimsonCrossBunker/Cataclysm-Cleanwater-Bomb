local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "mi-go_camp1", "mi-go_camp1-1" },
    vision_levels = "alien_tower",
    see_cost = "high",
    name = ccb.content.text("mi-go encampment"),
    symbol = "<",
    color = "dark_gray",
    monster_density = 2,
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "mi-go_camp2",
    symbol = ">",
    color = "light_gray",
    copy_from = "mi-go_camp1",
}

ccb.content.define_overmap_terrain {
    id = "mi-go_camp2-1",
    name = ccb.content.text("mi-go spire"),
    symbol = ">",
    color = "light_gray",
    copy_from = "mi-go_camp1",
}

ccb.content.define_overmap_terrain {
    id = "mi-go_camp2-2",
    name = ccb.content.text("mi-go landing platform"),
    see_cost = "none",
    symbol = "_",
    color = "light_gray",
    copy_from = "mi-go_camp1",
}

ccb.content.define_overmap_terrain {
    id = "mi-go_camp2-3",
    name = ccb.content.text("mi-go landing roof"),
    see_cost = "none",
    symbol = "_",
    color = "light_gray",
    copy_from = "mi-go_camp1",
}

ccb.content.define_overmap_terrain {
    id = {
        "barry_mi-go_scout_tower_1", "barry_mi-go_scout_tower_2", "barry_mi-go_scout_tower_3",
        "barry_mi-go_scout_tower_4", "mi-go_scout_tower_1", "mi-go_scout_tower_2",
        "mi-go_scout_tower_3", "mi-go_scout_tower_4",
    },
    name = ccb.content.text("mi-go scout tower"),
    copy_from = "mi-go_camp1",
}

ccb.content.define_overmap_terrain {
    id = "mi-go_portal",
    name = ccb.content.text("mi-go structure"),
    symbol = "=",
    vision_levels = "blends_till_details",
    see_cost = "high",
    color = "dark_gray",
    monster_density = 2,
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "mi-go_portal_roof",
    name = ccb.content.text("mi-go structure roof"),
    vision_levels = "roof_or_air",
    see_cost = "none",
    symbol = "=",
    color = "dark_gray",
    monster_density = 2,
    flags = { "RISK_EXTREME" },
}
