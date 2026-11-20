local ccb = require("ccb")

-- Full tank lasts a bit under three hours (166.66 minutes). Has less carry bonus than the battery one since the weight of the fuel will drop over time.
ccb.content.define_item {
    id = "ice_utility_exoskeleton_on",
    copy_from = "ice_utility_exoskeleton_off",
    looks_like = "power_armor_light",
    name = ccb.content.plural_text("ICE utility exoskeleton (on)", "ICE utility exoskeletons (on)"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body.  This model uses a compact internal combustion engine for power.  It is turned on and continually draining gasoline.  Use it to turn it off."),
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "TRADER_AVOID", "SPAWN_ACTIVE" },
    revert_to = "ice_utility_exoskeleton_off",
    qualities = { { id = "LIFT", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = { turns_per_charge = 1 },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s disengages."),
            target = "ice_utility_exoskeleton_off",
        },
    },
}
