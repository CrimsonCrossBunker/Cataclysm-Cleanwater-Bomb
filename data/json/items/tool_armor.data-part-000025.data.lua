local ccb = require("ccb")

-- Battery should last two hours (02:00:07). Weight capacity bonus should include weight of item AND battery, plus 90kg.
ccb.content.define_item {
    id = "utility_exoskeleton_on",
    copy_from = "utility_exoskeleton_off",
    looks_like = "power_armor_light",
    name = ccb.content.plural_text("battery powered utility exoskeleton (on)", "battery powered utility exoskeletons (on)"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body.  It is turned on and continually drawing power.  Use it to turn it off."),
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "TRADER_AVOID", "SPAWN_ACTIVE" },
    qualities = { { id = "LIFT", level = 1 } },
    revert_to = "utility_exoskeleton_off",
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "972216 mW", ammo_types = "battery" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The %s disengages."),
            target = "utility_exoskeleton_off",
        },
    },
}
