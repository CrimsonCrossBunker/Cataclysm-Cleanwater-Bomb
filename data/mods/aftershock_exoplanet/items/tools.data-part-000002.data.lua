local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_motion_sensor",
    name = ccb.content.plural_text("motion scanner", "motion scanners"),
    description = ccb.content.text("A handheld motion scanner normally used for pest control within spaceships.  This model features an integrated screen to highlight the location of detected motion.  It must be activated to function."),
    mass = "680 g",
    volume = "650 ml",
    price = "6 kUSD",
    length = "20 cm",
    materials = { "plastic", "steel" },
    symbol = "(",
    color = "yellow",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    flags = { "BELT_CLIP", "MUNDANE" },
    melee_damage = { bash = 6 },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1, ammo_types = { "battery" }, power_draw = "600 mW" },
    artifact = {
        enchantments = { "afs_motion_sensor_wield", "ITEM_ENCH_aftershock_exoplanet_afs_motion_sensor_1" },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Activate"),
            target = "afs_motion_sensor_on",
            need_charges = 1,
            message = ccb.content.text("The %s screen flashes on."),
        },
    },
}
