local ccb = require("ccb")

ccb.content.define_item {
    id = "military_vis_aug_system_on",
    copy_from = "military_vis_aug_system",
    name = ccb.content.plural_text("military visual augmentation system (on)", "military visual augmentation system (on)"),
    description = ccb.content.text("An experimental and cumbersome augmented reality headset developed for the military.  It consists of a broad eyepiece, a rugged multi-camera array, and a puck computer, all designed to be strapped over a helmet.  The lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  It has a few small connectors for external devices.  The AR system is currently turned on, and is continually draining batteries.  Use it to turn it off."),
    revert_to = "military_vis_aug_system",
    inheritance = {
        add = {
            flags = {
                "SPAWN_ACTIVE", "ZOOM", "THERMOMETER", "HYGROMETER", "BAROMETER", "TWO_WAY_RADIO",
                "WATCH", "ALARMCLOCK", "SUN_GLASSES",
            },
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 5, rigid_only = true },
            { covers = { "head" }, encumbrance = 20, coverage = 80, subparts = { "head_forehead" } },
            { covers = { "head" }, encumbrance = 5, coverage = 40, subparts = { "head_crown" } },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your AR system turns off."),
            target = "military_vis_aug_system",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
