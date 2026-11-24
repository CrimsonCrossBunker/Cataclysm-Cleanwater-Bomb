local ccb = require("ccb")

-- https://www.nightstick.com/collections/fire/products/xpp-5564rxa
-- volume is a 159 mm * 70 mm * 64 mm rectangle
ccb.content.define_item {
    id = "heavy_flashlight",
    name = ccb.content.plural_text("heavy-duty flashlight (off)", "heavy-duty flashlights (off)"),
    description = ccb.content.text("A heavy-duty LED flashlight with a durable polymer housing.  It's impact-resistant, chemical-resistant, waterproof and certified for use in hazardous environments.  Designed for firefighters, rescue personnel and miners but it can also be used for smacking hooligans.  It has a spring-loaded clip that can be attached to your torso."),
    mass = "290 g",
    volume = "712 ml",
    length = "16 cm",
    price = "65 USD",
    survival_price = "2 USD",
    materials = { "thermo_resin", "aluminum" },
    symbol = ";",
    color = "blue",
    flags = { "BELT_CLIP", "BELTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    melee_damage = { bash = 8 },
    subtype_order = { "armor", "tool" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 2,
                subparts = { "torso_hanging_front" },
            },
        },
    },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the heavy-duty flashlight on."),
            target = "heavy_flashlight_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
}

ccb.content.define_item {
    id = "oil_lamp",
    name = ccb.content.plural_text("kerosene lamp (off)", "kerosene lamps (off)"),
    description = ccb.content.text("A kerosene-fueled lamp.  It does not provide much light, but it lasts a long time.  Use it to turn it on."),
    mass = "1720 g",
    volume = "1 L",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "glass", "iron" },
    symbol = ";",
    color = "yellow",
    pockets = { { kind = "MAGAZINE", watertight = true, ammunition = { lamp_oil = 750 } } },
    flags = { "ALLOWS_REMOTE_USE" },
    melee_damage = { bash = 1 },
    tool = { charges_per_use = 1, ammo_types = { "lamp_oil" } },
    use_actions = {
        {
            kind = "transform",
            target = "oil_lamp_on",
            menu_text = ccb.content.text("Light", "verb"),
            message = ccb.content.text("You light the lamp."),
            need_fire = 1,
            need_charges = 1,
            need_charges_message = ccb.content.text("The lamp is empty."),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "oil_lamp_on",
    copy_from = "oil_lamp",
    name = ccb.content.plural_text("kerosene lamp", "kerosene lamps"),
    description = ccb.content.text("A kerosene-fueled lamp.  It does not provide much light, but it lasts a long time.  It is turned on.  Use it to turn it off."),
    revert_to = "oil_lamp",
    light = 10,
    flags = {
        "TRADER_AVOID",
        "FIRE",
        "ALLOWS_REMOTE_USE",
        "WATER_EXTINGUISH",
        "FIRESTARTER",
        "SPAWN_ACTIVE",
    },
    tool = { turns_per_charge = 240 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "oil_lamp",
            message = ccb.content.text("The lamp is extinguished."),
            menu_text = ccb.content.text("Turn off"),
        },
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
    },
}

ccb.content.define_item {
    id = "oil_lamp_clay",
    name = ccb.content.plural_text("clay oil lamp (off)", "clay oil lamps (off)"),
    description = ccb.content.text("A specialized small clay container with a wick, an ancient form of oil lamp.  Unlike newer designs, it isn't windproof, so the flame is likely to be extinguished if exposed to wind; better use it indoors.  It does not provide much light, but it lasts a long time.  Use it to light it."),
    mass = "620 g",
    volume = "300 ml",
    price = "8 USD",
    survival_price = "1 USD",
    materials = { "clay" },
    symbol = ";",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE",
            watertight = true,
            ammunition = { crude_lamp_oil = 250, lamp_oil = 250 },
        },
    },
    flags = { "ALLOWS_REMOTE_USE" },
    melee_damage = { bash = 1 },
    tool = { charges_per_use = 1, ammo_types = { "crude_lamp_oil", "lamp_oil" } },
    use_actions = {
        {
            kind = "transform",
            target = "oil_lamp_clay_on",
            menu_text = ccb.content.text("Light", "verb"),
            message = ccb.content.text("You light the lamp."),
            need_fire = 1,
            need_charges = 1,
            need_charges_message = ccb.content.text("The lamp is empty."),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "oil_lamp_clay_on",
    copy_from = "oil_lamp_clay",
    looks_like = "oil_lamp_on",
    name = ccb.content.plural_text("clay oil lamp", "clay oil lamps"),
    description = ccb.content.text("A specialized small clay container with a wick, an ancient form of oil lamp.  Unlike newer designs, it isn't windproof, so the flame is likely to be extinguished if exposed to wind; better use it indoors.  It does not provide much light, but lasts a long time.  It is lit, consuming oil and providing light.  Use it to extinguish the flame."),
    revert_to = "oil_lamp_clay",
    light = 10,
    flags = {
        "TRADER_AVOID", "FIRE", "ALLOWS_REMOTE_USE", "WATER_EXTINGUISH", "WIND_EXTINGUISH",
        "FIRESTARTER", "SPAWN_ACTIVE",
    },
    tool = { crafting_subtype = "oil_lamp_on", turns_per_charge = 240 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "oil_lamp_clay",
            message = ccb.content.text("The lamp is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
    },
}

-- dimensions from pool_cue as least heavy ingredient from all
ccb.content.define_item {
    id = "torch",
    name = ccb.content.plural_text("torch", "torches"),
    description = ccb.content.text("A large stick wrapped in rags that are soaked with flammable material.  When lit, it produces a fair amount of light.  You'll need a lighter or matches to light it."),
    mass = "623 g",
    volume = "1089 ml",
    length = "122 cm",
    price = "0 cent",
    survival_price = "50 cent",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    materials = {
        { id = "wood", portions = 14 },
        { id = "cotton", portions = 1 },
        { id = "gasoline", portions = 1 },
    },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "BURNOUT" },
    melee_damage = { bash = 8 },
    tool = { initial_charges = 20, max_charges = 20 },
    use_actions = {
        {
            kind = "transform",
            target = "torch_lit",
            message = ccb.content.text("You light the torch."),
            need_fire = 1,
            menu_text = ccb.content.text("Light", "verb"),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "torch_lit",
    name = ccb.content.plural_text("torch", "torches"),
    description = ccb.content.text("A large stick wrapped in rags that are soaked with flammable material.  It is burning, producing plenty of light."),
    mass = "623 g",
    volume = "1089 ml",
    length = "122 cm",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    materials = {
        { id = "wood", portions = 14 },
        { id = "cotton", portions = 1 },
        { id = "gasoline", portions = 1 },
    },
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
    tool = { initial_charges = 20, max_charges = 20, turns_per_charge = 60, crafting_subtype = "fire" },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "torch",
            message = ccb.content.text("The torch is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}
