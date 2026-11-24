local ccb = require("ccb")

ccb.content.define_item {
    id = "mspider_box",
    name = ccb.content.plural_text("spider box", "spider boxes"),
    description = ccb.content.text("This is a small glass box that contains a spider that diligently works day and night to produce silk thread that it stores in a reservoir you can open and retrieve it from."),
    mass = "100 g",
    volume = "100 ml",
    price = "1 kUSD",
    survival_price = "1150 USD",
    materials = { "glass" },
    symbol = ";",
    color = "red",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { thread = 1000 } } },
    subtype_order = { "tool", "artifact" },
    tool = { ammo_types = { "thread" } },
    artifact = { charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true } },
}

ccb.content.define_item {
    id = "borealmosin_clip",
    looks_like = "762R_clip",
    name = ccb.content.text("91/30 Boreal clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load a bolt-action rifle."),
    mass = "40 g",
    volume = "50ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["308"] = 5 } } },
    magazine = { ammunition = { "308" }, capacity = 5 },
}

ccb.content.define_item {
    id = "heat_cube",
    name = "heat cube",
    description = "A smooth steel cube the size of your fist.  Several buttons on the sides activate the powers of the cube.",
    symbol = "#",
    color = "light_gray",
    mass = "500 g",
    volume = "450 ml",
    price = "2 kUSD",
    survival_price = "5 kUSD",
    flags = { "ALLOWS_REMOTE_USE", "FIRE", "NO_UNLOAD" },
    materials = { "steel" },
    melee_damage = { bash = 8 },
    pockets = {
        {
            kind = "MAGAZINE",
            holster = true,
            ammunition = { crystallized_mana = 60 },
        },
    },
    qualities = {
        { id = "HAMMER", level = 1 },
        { id = "HOTPLATE", level = 1 },
    },
    accuracy = -1,
    use_actions = {
        "HOTPLATE",
        "HEAT_FOOD",
        {
            kind = "transform",
            target = "heat_cube_torch_on",
            moves = 150,
            message = "You push the torch button and the cube emits a large flame from the top, one that does radiate heat, but won't burn anything.",
            menu_text = "Activate torch mode",
        },
        { kind = "firestarter" },
    },
    tool = { charges_per_use = 1, crafting_subtype = "hotplate" },
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true },
    },
    subtype_order = { "tool", "artifact" },
}

ccb.content.define_item {
    id = "mtailors_kit",
    copy_from = "tailors_kit",
    name = "enchanted tailor's kit",
    description = "This is a high quality, engraved steel kit with a variety of needles, some plastic spools for thread, some small scissors, even a small heating element for melting and joining plastic.  Use a tailor's kit to customize your clothing and armor.  This uses your tailoring skill.  It also contains one of those magic spiders that constantly, if slowly, makes new thread.",
    price = "1 kUSD",
    survival_price = "1700 USD",
    flags = { "ALLOWS_REMOTE_USE", "NO_UNLOAD" },
    materials = { "steel" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { thread = 1000 },
        },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            skill = "tailor",
            tool_quality = 1,
            move_cost = 500,
            cost_scaling = 0.1,
            materials = {
                "cotton",
                "leather",
                "lycra",
                "nylon",
                "wool",
                "fur",
                "faux_fur",
                "nomex",
                "kevlar",
                "kevlar_layered",
                "neoprene",
                "parabolan_wool",
                "gutskin",
                "canvas",
                "black_dragon_hide",
            },
        },
    },
    tool = { charges_per_use = 1, crafting_subtype = "sewing_kit" },
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true },
    },
    subtype_order = { "tool", "artifact" },
}
