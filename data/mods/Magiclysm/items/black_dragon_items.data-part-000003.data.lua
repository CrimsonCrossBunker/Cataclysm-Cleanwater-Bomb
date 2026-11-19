local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_xlblack_dragon_scale",
    copy_from = "helmet_black_dragon_scale",
    name = ccb.content.plural_text("black dragonscale helmet", "black dragonscale helmets"),
    description = ccb.content.text("A massive helmet made from incredibly durable black dragonscale, held together with black dragonhide.  It comes equipped with a full face visor you can raise and is large enough to fit even the strangest of heads."),
    mass = "1256 g",
    volume = "4500 ml",
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 42 },
            { covers = { "eyes", "mouth" }, coverage = 100, encumbrance = 20 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise visor"),
            target = "helmet_xlblack_dragon_scale_raised",
            message = ccb.content.text("You raise the helm's visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_xlblack_dragon_scale_raised",
    copy_from = "helmet_black_dragon_scale_raised",
    name = ccb.content.plural_text("black dragonscale helmet (raised visor)", "black dragonscale helmets (raised visor)"),
    description = ccb.content.text("A massive helmet made from incredibly durable black dragonscale, held together with black dragonhide.  It is large enough to fit even the strangest of heads.  The visor is raised"),
    mass = "1256 g",
    volume = "4500 ml",
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = { { covers = { "head" }, coverage = 100, encumbrance = 42 } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower visor"),
            target = "helmet_xlblack_dragon_scale",
            message = ccb.content.text("You lower the helm's visor."),
        },
    },
}
