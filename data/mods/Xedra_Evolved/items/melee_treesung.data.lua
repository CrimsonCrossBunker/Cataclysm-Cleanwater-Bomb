local ccb = require("ccb")

ccb.content.define_item {
    id = "treesung_spear",
    copy_from = "spear_wood",
    name = "treesung spear",
    description = "A stout wooden pole sharpened on one end, all formed from a single piece of wood, with twists and curves like it grew in place rather than being made.",
    color = "green",
    looks_like = "spear_wood",
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR", "DURABLE_MELEE" },
        },
        scale = {
            melee_damage = { stab = 1.5 },
        },
    },
}

ccb.content.define_item {
    id = "treesung_pike",
    copy_from = "pike_wood",
    name = "treesung long spear",
    description = "A giant spear over three meters long, all formed from a single piece of wood, with twists and curves like it grew in place rather than being made.",
    color = "green",
    looks_like = "pike_wood",
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR" },
        },
        scale = {
            mass = 0.8,
            melee_damage = { stab = 1.5 },
        },
    },
}

ccb.content.define_item {
    id = "treesung_q_staff",
    copy_from = "q_staff",
    name = ccb.content.plural_text("treesung quarterstaff", "treesung quarterstaves"),
    description = "A sturdy staff all formed from a single piece of wood, with twists and curves like it grew in place rather than being carved.",
    color = "green",
    looks_like = "q_staff",
    materials = {
        { id = "wood", portions = 1 },
    },
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR", "DURABLE_MELEE" },
        },
        scale = {
            mass = 0.8,
            melee_damage = { bash = 1.1 },
        },
    },
}

ccb.content.define_item {
    id = "treesung_naginata",
    copy_from = "naginata",
    name = "treesung sword-spear",
    description = "A sturdy polearm with a curved blade, all formed from a single piece of wood, with twists and curves like it grew in place rather than being carved.  You're not sure how long it will hold its edge, but it's surprisingly sharp.",
    color = "green",
    looks_like = "naginata",
    materials = {
        { id = "wood", portions = 1 },
    },
    inheritance = {
        add = {
            flags = { "WOODEN_WEAPON", "NO_REPAIR" },
        },
        remove = {
            flags = { "DURABLE_MELEE" },
        },
        scale = {
            mass = 0.8,
            melee_damage = { cut = 0.9 },
        },
    },
}
