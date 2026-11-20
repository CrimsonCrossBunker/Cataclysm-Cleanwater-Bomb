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
