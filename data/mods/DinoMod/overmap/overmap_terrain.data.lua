local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    color = "brown",
    id = "dinoexhibit",
    monster_density = 2,
    name = ccb.content.text("Dinosaur Exhibit"),
    see_cost = "high",
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    color = "red",
    id = "mass_grave_red",
    monster_density = 2,
    name = ccb.content.text("mass grave"),
    see_cost = "none",
    symbol = "R",
}

ccb.content.define_overmap_terrain {
    color = "brown",
    id = "dinoexhibit_roof",
    monster_density = 2,
    name = ccb.content.text("Dinosaur Exhibit roof"),
    see_cost = "none",
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab",
    name = ccb.content.text("science lab"),
    symbol = "L",
    color = "light_blue",
    spawns = { group = "GROUP_DINOLAB", population = { 40, 45 }, chance = 80 },
    see_cost = "high",
    flags = { "NO_ROTATE", "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab_edge",
    copy_from = "microlab_DinoLab",
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab_surface_connector",
    copy_from = "microlab_DinoLab",
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab_sub_entry",
    name = ccb.content.text("science lab"),
    symbol = "L",
    copy_from = "microlab_sub_connector",
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab_surface",
    name = ccb.content.text("lab"),
    symbol = "L",
    color = "blue",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "microlab_DinoLab_surface_roof",
    copy_from = "microlab_DinoLab_surface",
}

ccb.content.define_overmap_terrain {
    id = { "mi-go_scout_tower_dino_1", "mi-go_scout_tower_2", "mi-go_scout_tower_dino_3", "mi-go_scout_tower_4" },
    name = ccb.content.text("mi-go scout tower"),
    symbol = ">",
    color = "light_gray",
    monster_density = 2,
    see_cost = "high",
    flags = { "RISK_EXTREME" },
}
