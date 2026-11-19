local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_lens_helmet_on",
    copy_from = "robofac_lens_helmet",
    name = ccb.content.plural_text("Hub 01 LENS helmet (on)", "Hub 01 LENS helmet (on)"),
    flags = {
        "OVERSIZE", "STURDY", "WATERPROOF", "SUN_GLASSES", "PADDED", "MODULE_HOLDER", "CAN_USE_IN_DARK",
        "MUNDANE", "ELECTRONIC", "RAINPROOF", "SPAWN_ACTIVE", "ZOOM", "THERMOMETER", "HYGROMETER",
        "BAROMETER", "TWO_WAY_RADIO", "WATCH", "ALARMCLOCK", "PARTIAL_DEAF", "FIX_NEARSIGHT",
        "FIX_FARSIGHT", "FLASH_PROTECTION", "SWIM_GOGGLES", "NO_TAKEOFF", "ROBOFAC_LENS_HELMET",
    },
    revert_to = "robofac_lens_helmet",
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "1 W" },
    armor = {
        environmental_protection = 16,
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 0 },
        },
    },
    artifact = { enchantments = { "nvg_great", "THERMAL_VISION_GOOD", "AR_targeting_system" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Your LENS system and cybernetic HUD switch off, leaving you in darkness."),
            target = "robofac_lens_helmet",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
