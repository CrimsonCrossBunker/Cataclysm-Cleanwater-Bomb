local ccb = require("ccb")

ccb.content.define_item {
    id = "sling-ready_molotov",
    name = "sling-ready Molotov cocktail",
    description = "A bottle of flammable liquid with a long fuse inserted, ready to be used in a staff sling.  To throw this item without a sling, use it to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  After lighting it, throw it to cause fires.",
    symbol = "*",
    color = "light_gray",
    ascii_picture = "sling-ready_molotov",
    mass = "1000 g",
    volume = "960 ml",
    length = "276 mm",
    price = "5 USD",
    survival_price = "5 USD",
    flags = { "SLING_AMMO", "SLING_PROJECTILE", "NPC_ACTIVATE", "NO_REPAIR" },
    materials = { "glass", "cotton" },
    melee_damage = { bash = 5 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    use_actions = {
        {
            kind = "transform",
            target = "molotov_lit",
            target_charges = 1,
            moves = 1200,
            need_fire = 1,
            need_wielding = true,
            message = "You light the Molotov cocktail!",
            menu_text = "Light rag",
        },
    },
    ammunition = {
        type = "sling-ready_grenade",
        range = 11,
        dispersion = 14,
        effects = { "COOKOFF", "NON_FOULING", "FLAME" },
        damage = { type = "bash", amount = 5 },
    },
}

ccb.content.define_item {
    id = "sling-ready_grenade",
    name = "sling-ready grenade",
    description = "A military-grade fragmentary hand grenade, modified with a retaining fuse for use in a staff sling.  To throw this item without a sling, use it to snap the fuse and activate the grenade.  You will then have five seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    ascii_picture = "sling-ready_grenade",
    mass = "397 g",
    volume = "540 ml",
    price = "15 USD",
    survival_price = "10 USD",
    flags = { "SLING_AMMO", "SLING_PROJECTILE", "BOMB", "GRENADE" },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 6 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    use_actions = {
        {
            kind = "transform",
            target = "grenade_act",
            target_timer = "5 seconds",
            need_wielding = true,
            message = "You snap the retaining fuse on the grenade.",
            menu_text = "Activate",
        },
    },
    ammunition = {
        type = "sling-ready_grenade",
        range = 25,
        dispersion = 14,
        effects = { "COOKOFF", "NON_FOULING", "EXPLOSIVE_GRENADE" },
        damage = { type = "bash", amount = 6 },
    },
}

ccb.content.define_item {
    id = "sling-ready_small_homemade_grenade",
    copy_from = "sling-ready_grenade",
    name = "sling-ready small homemade grenade",
    description = "An improvised explosive device cobbled together from spare parts and modified with a retaining fuse for use in a staff sling.  To throw this item without a sling, use it to snap the fuse and activate the grenade.  You will then have 5 seconds before it explodes; throwing it would be a good idea.",
    looks_like = "homemade_grenade",
    ascii_picture = "sling-ready_small_homemade_grenade",
    mass = "460 g",
    volume = "270 ml",
    price = "7 USD 50 cent",
    explode_in_fire = true,
    flags = {
        "SLING_AMMO",
        "SLING_PROJECTILE",
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "NPC_ACTIVATE",
    },
    materials = { "aluminum", "iron" },
    blast = {
        power = 150,
        shrapnel = { casing_mass = 200, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "small_homemade_grenade_act",
            target_timer = "5 seconds",
            need_fire = 1,
            need_wielding = true,
            message = "You light the retaining fuse on the improvised grenade.  Throw it before it blows in your face!",
            menu_text = "Light fuse",
        },
    },
    ammunition = {
        type = "rock",
        effects = { "COOKOFF", "NON_FOULING", "EXPLOSIVE_SMALL_HOMEMADE_GRENADE_1" },
    },
}

ccb.content.define_item {
    id = "sling-ready_homemade_grenade",
    copy_from = "sling-ready_grenade",
    name = "sling-ready homemade grenade",
    description = "An improvised explosive device cobbled together from spare parts and modified with a retaining fuse for use in a staff sling.  To throw this item without a sling, use it to snap the fuse and activate the grenade.  You will then have 5 seconds before it explodes; throwing it would be a good idea.",
    ascii_picture = "sling-ready_homemade_grenade",
    mass = "900 g",
    price = "15 USD",
    explode_in_fire = true,
    flags = {
        "SLING_AMMO",
        "SLING_PROJECTILE",
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "NPC_ACTIVATE",
    },
    materials = { "aluminum", "iron" },
    blast = {
        power = 300,
        shrapnel = { casing_mass = 400, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_grenade_act",
            target_timer = "5 seconds",
            need_fire = 1,
            need_wielding = true,
            message = "You light the retaining fuse on the improvised grenade.  Throw it before it blows in your face!",
            menu_text = "Light fuse",
        },
    },
    ammunition = {
        effects = { "COOKOFF", "NON_FOULING", "EXPLOSIVE_HOMEMADE_GRENADE_1" },
    },
}

ccb.content.define_item {
    id = "sling-ready_small_homemade_grenade_2",
    copy_from = "sling-ready_grenade",
    name = "sling-ready military explosive small homemade grenade",
    description = "An improvised explosive device cobbled together from parts and modified with a retaining fuse for use in a staff sling.  To throw this item without a sling, use it to snap the fuse and activate the grenade.  You will then have some amount of time before it explodes; throwing it would be a good idea.",
    ascii_picture = "sling-ready_small_homemade_grenade_2",
    mass = "600 g",
    volume = "270 ml",
    price = "15 USD",
    explode_in_fire = true,
    flags = {
        "SLING_AMMO",
        "SLING_PROJECTILE",
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "NPC_ACTIVATE",
    },
    materials = { "aluminum", "iron" },
    blast = {
        power = 460,
        shrapnel = { casing_mass = 200, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_small_grenade_act",
            target_timer = "5 seconds",
            need_fire = 1,
            need_wielding = true,
            message = "You light the retaining fuse on the improvised grenade.  Throw it before it blows in your face!",
            menu_text = "Light fuse",
        },
    },
    ammunition = {
        type = "rock",
        effects = { "COOKOFF", "NON_FOULING", "EXPLOSIVE_SMALL_HOMEMADE_GRENADE_2" },
    },
}

ccb.content.define_item {
    id = "sling-ready_homemade_grenade_2",
    copy_from = "sling-ready_grenade",
    name = "sling-ready military explosive homemade grenade",
    description = "An improvised explosive device cobbled together from parts and modified with a retaining fuse for use in a staff sling.  To throw this item without a sling, use it to snap the fuse and activate the grenade.  You will then have some amount of time before it explodes; throwing it would be a good idea.",
    ascii_picture = "sling-ready_homemade_grenade_2",
    mass = "1200 g",
    price = "30 USD",
    explode_in_fire = true,
    flags = {
        "SLING_AMMO",
        "SLING_PROJECTILE",
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "NPC_ACTIVATE",
    },
    materials = { "aluminum", "iron" },
    blast = {
        power = 920,
        shrapnel = { casing_mass = 400, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_grenade_act",
            target_timer = "5 seconds",
            need_fire = 1,
            need_wielding = true,
            message = "You light the retaining fuse on the improvised grenade.  Throw it before it blows in your face!",
            menu_text = "Light fuse",
        },
    },
    ammunition = {
        effects = { "COOKOFF", "NON_FOULING", "EXPLOSIVE_HOMEMADE_GRENADE_2" },
    },
}
