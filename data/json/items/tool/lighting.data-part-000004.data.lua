local ccb = require("ccb")

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
