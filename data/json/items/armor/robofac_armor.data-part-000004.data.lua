local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_head_rig_ar_on",
    copy_from = "robofac_head_rig_ar",
    name = ccb.content.plural_text("Hub 01 visual augmentation headgear (on)", "Hub 01 visual augmentation headgear (on)"),
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts, and an integrated camera array.  A multi-faceted augmented reality headset rests of the forehead like a pair of slim, boxy ski goggles, with side plugs for auxiliary devices.  The AR lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  The AR system is currently turned on, and continually draining batteries.  Use it to turn it off."),
    revert_to = "robofac_head_rig_ar",
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
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                coverage = 95,
                encumbrance = 50,
                volume_encumbrance = 0,
            },
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 2 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
                rigid_only = true,
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your AR system turns off."),
            target = "robofac_head_rig_ar",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
