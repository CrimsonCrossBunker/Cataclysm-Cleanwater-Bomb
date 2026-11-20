local ccb = require("ccb")

ccb.content.define_item {
    id = "oil_lamp_on",
    copy_from = "oil_lamp_on",
    name = ccb.content.plural_text("oil lamp", "oil lamps"),
    description = ccb.content.text("This is an oil fueled lamp.  It does not provide much light, but it lasts a long time.  It is turned on.  Use it to turn it off."),
    light = 30,
    tool = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "oil_lamp",
            message = ccb.content.text("The lamp is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
        { kind = "firestarter", moves = 100 },
    },
}

ccb.content.define_item {
    id = "oil_lamp_clay_on",
    copy_from = "oil_lamp_clay_on",
    looks_like = "oil_lamp_on",
    name = ccb.content.plural_text("clay oil lamp", "clay oil lamps"),
    description = ccb.content.text("This is a specialized small clay container with a wick, an ancient form of oil lamp.  Unlike newer designs, it isn't windproof, so the flame is likely to be extinguished if exposed to wind; better use it indoors.  It does not provide much light, but lasts a long time.  It is lit, consuming oil and providing light.  Use it to extinguish the flame."),
    light = 20,
    tool = { crafting_subtype = "oil_lamp_on" },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "oil_lamp_clay",
            message = ccb.content.text("The lamp is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
        { kind = "firestarter", moves = 100 },
    },
}

ccb.content.define_item {
    id = "torch_lit",
    name = ccb.content.plural_text("torch", "torches"),
    description = ccb.content.text("This is a large stick, wrapped in rags that are soaked with a flammable material.  It is burning, producing plenty of light."),
    mass = "831 g",
    volume = "750 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = 1,
    materials = { "wood" },
    symbol = "/",
    color = "brown",
    revert_to = "torch_done",
    techniques = { "WBLOCK_1" },
    light = 60,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "BURNOUT",
        "SPAWN_ACTIVE",
    },
    melee_damage = { bash = 8 },
    tool = { initial_charges = 20, max_charges = 20, turns_per_charge = 60 },
    use_actions = {
        { kind = "firestarter", moves = 30 },
        {
            kind = "transform",
            target = "torch",
            message = ccb.content.text("The torch is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}
