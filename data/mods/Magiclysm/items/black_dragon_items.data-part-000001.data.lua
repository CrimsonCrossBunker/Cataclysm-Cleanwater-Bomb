local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_black_dragon_scale",
    category = "armor",
    name = ccb.content.plural_text("black dragonscale helmet", "black dragonscale helmets"),
    description = ccb.content.text("A helmet made from black incredibly durable dragonscale, held together with black dragonhide.  It comes equipped with a full face visor with only a thin slit to see out of.  Activate to raise the visor."),
    mass = "856 g",
    volume = "2500 ml",
    price = "580 USD",
    accuracy = -1,
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "SUN_GLASSES" },
    melee_damage = { bash = 10 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 32 },
            { covers = { "eyes", "mouth" }, coverage = 100, encumbrance = 20 },
        },
        warmth = 25,
        thickness = 5,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise visor"),
            target = "helmet_black_dragon_scale_raised",
            message = ccb.content.text("You raise the helm's visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_black_dragon_scale_raised",
    category = "armor",
    copy_from = "helmet_black_dragon_scale",
    name = ccb.content.plural_text("black dragonscale helmet (raised visor)", "black dragonscale helmets (raised visor)"),
    description = ccb.content.text("A helmet made from incredibly durable black dragonscale, held together with black dragonhide.  The visor is raised."),
    symbol = "[",
    inheritance = { remove = { flags = { "SUN_GLASSES" } } },
    armor = {
        portions = { { covers = { "head" }, coverage = 100, encumbrance = 32 } },
        thickness = 5,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower visor"),
            target = "helmet_black_dragon_scale",
            message = ccb.content.text("You lower the helm's visor."),
        },
    },
}
