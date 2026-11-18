local ccb = require("ccb")
local content = ccb.content

content.add(content.ItemGroup { id = "sky_island_autodoc_bash_parts", kind = "collection" }
    :entry { item = "processor", probability = 25 }
    :entry { item = "RAM", count = { 0, 2 }, probability = 50 }
    :entry { item = "cable", count = { 1, 2 }, probability = 50 }
    :entry { item = "small_lcd_screen", probability = 25 }
    :entry { item = "e_scrap", count = { 1, 4 }, probability = 50 }
    :entry { item = "circuit", count = { 0, 2 }, probability = 50 }
    :entry { item = "power_supply", probability = 25 }
    :entry { item = "amplifier", probability = 25 }
    :entry { item = "plastic_chunk", count = { 4, 10 }, probability = 50 }
    :entry { item = "scrap", count = { 2, 6 }, probability = 50 })

content.add(content.ItemGroup { id = "sky_island_autodoc_deconstruct_parts", kind = "collection" }
    :entry { item = "processor", count = { 1, 2 } }
    :entry { item = "RAM", count = { 4, 8 } }
    :entry { item = "cable", count = { 1, 2 } }
    :entry { item = "small_lcd_screen", count = { 1, 2 } }
    :entry { item = "e_scrap", count = { 10, 16 } }
    :entry { item = "circuit", count = { 6, 10 } }
    :entry { item = "power_supply", count = { 2, 4 } }
    :entry { item = "amplifier", count = { 2, 4 } }
    :entry { item = "plastic_chunk", count = { 10, 12 } }
    :entry { item = "scrap", count = { 6, 8 } })

-- The island boundary prevents the warp obelisk from being pushed over the edge.
content.add(content.Terrain {
    id = "t_fake_air",
    name = ccb.content.text("open air"),
    description = ccb.content.text("This is the edge of the island.  A metaphysical border stops you from going over the edge yourself, but anything you drop here will be gone forever."),
    looks_like = "t_open_air",
    symbol = " ",
    color = "i_cyan",
    move_cost = 0,
}
    :flag("TRANSPARENT")
    :flag("DESTROY_ITEM")
    :flag("NO_SHOOT")
    :flag("BLOCK_WIND")
    :flag("TRANSPARENT_FLOOR"))

content.add(content.Terrain {
    id = "t_traderwall",
    name = ccb.content.text("warpglass wall"),
    description = ccb.content.text("A shimmering translucent barrier that almost yields to the touch, but adamantly refuses entry."),
    looks_like = "t_wall_glass",
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    roof = "t_flat_roof",
    connect_groups = { "WALL" },
    connects_to = { "WALL" },
    shoot = {
        reduce_damage = { 3800, 4000 },
        reduce_damage_laser = { 3800, 4000 },
        destroy_damage = { 4000, 5000 },
        no_laser_destroy = true,
    },
}
    :flag("TRANSPARENT")
    :flag("NOITEM")
    :flag("WALL")
    :flag("NO_SCENT")
    :flag("AUTO_WALL_SYMBOL")
    :flag("BLOCK_WIND"))

content.add(content.Terrain {
    id = "t_traderwall_stone",
    name = ccb.content.text("masonry wall"),
    description = ccb.content.text("A wall of carefully cut and laid stones, joined with mortar.  The exterior has been finished with plaster and whitewashed.  You notice that it seems to have no scratches on it whatsoever."),
    looks_like = "t_stone_masonry_wall_whitewashed",
    symbol = "#",
    color = "white",
    move_cost = 0,
    coverage = 100,
    roof = "t_rock_roof",
    connect_groups = { "WALL" },
    connects_to = { "WALL" },
    bash = {
        minimum_strength = 4000,
        maximum_strength = 5000,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("glzt!"),
        result = "t_traderwall_stone",
    },
}
    :flag("NOITEM")
    :flag("SUPPORTS_ROOF")
    :flag("WALL")
    :flag("NO_SCENT")
    :flag("AUTO_WALL_SYMBOL")
    :flag("BLOCK_WIND"))

content.add(content.Terrain {
    id = "t_trader_thatch_roof",
    name = ccb.content.text("thatched roof"),
    description = ccb.content.text("A section of roof made out of straw.  It seems extraordinarily thickly woven together."),
    looks_like = "t_thatch_roof",
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    bash = {
        minimum_strength = 4000,
        maximum_strength = 5000,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("glzt!"),
        result = "t_trader_thatch_roof",
    },
}
    :flag("TRANSPARENT")
    :flag("FLAMMABLE"))

content.add(content.Terrain {
    id = "t_wall_r_glow",
    name = ccb.content.text("red glowing wall"),
    description = ccb.content.text("A red wall emitting otherworldly glow, enough to be noticeable at night."),
    looks_like = "t_wall_r",
    color = "red",
    light_emitted = 120,
    light_color = { 149, 36, 20 },
    copy_from = "t_wall_color",
})

content.add(content.Terrain {
    id = "t_warprock",
    name = ccb.content.text("warped rock"),
    description = ccb.content.text("A sparkly-black stone that's glassy smooth to the touch.  Seems indestructible by normal means."),
    looks_like = "t_rock",
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_rock_roof",
    connect_groups = { "WALL" },
    connects_to = { "WALL" },
    bash = {
        minimum_strength = 4000,
        maximum_strength = 5000,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("glzt!"),
        result = "t_warprock",
    },
}
    :flag("NOITEM")
    :flag("SUPPORTS_ROOF")
    :flag("WALL")
    :flag("NO_SCENT")
    :flag("AUTO_WALL_SYMBOL")
    :flag("BLOCK_WIND"))

content.add(content.Furniture {
    id = "f_si_autodoc_2",
    name = ccb.content.text("Warped Autodoc Mk. XXII"),
    description = ccb.content.text("A surgical apparatus used for the installation and removal of bionics.  The term name 'Autodoc' is something of a misnomer, as it can only operate if programmed beforehand, something that a plethora of labels warn against doing without expertise.  Bluish-purple sparks occasionally emit from some of the mechanisms."),
    looks_like = "f_autodoc",
    symbol = "&",
    color = "light_cyan",
    move_cost_mod = -1,
    coverage = 35,
    required_str = -1,
    surgery_skill_multiplier = 2.5,
    builtin_examine = "autodoc",
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = "sky_island_autodoc_bash_parts",
    },
    deconstruct_drops = "sky_island_autodoc_deconstruct_parts",
    mass_grams = 1000000,
}
    :flag("TRANSPARENT")
    :flag("AUTODOC")
    :flag("CONTAINER")
    :flag("NO_PICKUP_ON_EXAMINE"))

content.add(content.Furniture {
    id = "f_si_autodoc_3",
    name = ccb.content.text("Warped Autodoc Mk. XXXIII"),
    description = ccb.content.text("A surgical apparatus used for the installation and removal of bionics.  The term name 'Autodoc' is something of a misnomer, as it can only operate if programmed beforehand, something that a plethora of labels warn against doing without expertise.  Bluish-purple sparks frequently emit from some of the mechanisms, and the entire machine has a faint violet glow."),
    looks_like = "f_autodoc",
    symbol = "&",
    color = "light_cyan",
    move_cost_mod = -1,
    coverage = 35,
    required_str = -1,
    light_emitted = 3,
    surgery_skill_multiplier = 8,
    builtin_examine = "autodoc",
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = "sky_island_autodoc_bash_parts",
    },
    deconstruct_drops = "sky_island_autodoc_deconstruct_parts",
    mass_grams = 1000000,
}
    :flag("TRANSPARENT")
    :flag("AUTODOC")
    :flag("CONTAINER")
    :flag("NO_PICKUP_ON_EXAMINE"))
