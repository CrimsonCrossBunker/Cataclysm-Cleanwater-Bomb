local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_pit_shallow",
    name = ccb.content.text("shallow pit"),
    description = ccb.content.text("A pit that could be dug even deeper or filled up.  Also useful as a starting foundation for some constructions.  You can also use it to contain a fire."),
    symbol = "0",
    color = "yellow",
    move_cost = 8,
    flags = { "TRANSPARENT", "DIGGABLE", "DIGGABLE_CAN_DEEPEN", "FIRE_CONTAINER" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "fireplace",
}

ccb.content.define_terrain {
    id = "t_pit",
    name = ccb.content.text("pit"),
    description = ccb.content.text("A steep hole that could seriously injure something if it fell in, potentially fatal if it was filled with sharp and dangerous things.  Deep enough for more advanced construction projects, and possibly to reach groundwater if constructed properly."),
    symbol = "0",
    color = "brown",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 10,
    trap = "tr_pit",
    flags = { "TRANSPARENT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit",
}

-- left diggable to clean out corpses-KA101
ccb.content.define_terrain {
    id = "t_pit_corpsed",
    name = ccb.content.text("corpse filled pit"),
    description = ccb.content.text("A giant trench full of corpses, maybe even a mass graveyard.  The bodies could be dug out, but nothing in here looks remotely usable."),
    symbol = "#",
    color = "green",
    move_cost = 5,
    flags = { "TRANSPARENT", "DIGGABLE", "PIT_FILLABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_pit_covered",
    name = ccb.content.text("covered pit"),
    description = ccb.content.text("A deep pit with a plank placed across it, looks sturdy enough to cross safely.  The plank could be removed to make it dangerous again."),
    symbol = "#",
    color = "light_red",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit_covered",
}

ccb.content.define_terrain {
    id = "t_pit_spiked",
    name = ccb.content.text("spiked pit"),
    description = ccb.content.text("A narrow trench full of very pointy things that would easily puncture a body."),
    symbol = "0",
    color = "light_red",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 10,
    trap = "tr_spike_pit",
    flags = { "TRANSPARENT", "PIT_FILLABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit",
}

ccb.content.define_terrain {
    id = "t_pit_spiked_covered",
    name = ccb.content.text("covered spiked pit"),
    description = ccb.content.text("Menacing with sharp spears along the bottom, this pit has a plank across it to allow someone or something to cross safely.  The plank could be removed to make it dangerous again."),
    symbol = "#",
    color = "light_red",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit_covered",
}

ccb.content.define_terrain {
    id = "t_pit_glass",
    name = ccb.content.text("glass pit"),
    description = ccb.content.text("Looks like a ton of broken glass was dumped into this pit.  Might not fatal to fall in, but it wouldn't be pleasant to try to crawl out."),
    symbol = "0",
    color = "light_cyan",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 10,
    trap = "tr_glass_pit",
    flags = { "TRANSPARENT", "PIT_FILLABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit",
}

ccb.content.define_terrain {
    id = "t_pit_glass_covered",
    name = ccb.content.text("covered glass pit"),
    description = ccb.content.text("A plank has been placed carefully to allow traversal over this ditch full of large glass shards.  The plank could be removed to make it dangerous again."),
    symbol = "#",
    color = "light_cyan",
    connect_groups = "PIT_DEEP",
    connects_to = "PIT_DEEP",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
    builtin_examine = "pit_covered",
}
