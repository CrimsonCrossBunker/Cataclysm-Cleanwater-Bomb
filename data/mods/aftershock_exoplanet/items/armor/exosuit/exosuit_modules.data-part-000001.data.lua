local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_asrg",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit ASRG", "exosuit ASRGs"),
    description = ccb.content.text("This is a prototype Compact Advanced Sterling Radioisotope Generator, intended to power an exosuit indefinitely.  The layered shielding saves space but is quite heavy, and while labeled 'Compact', this only just fits on the exosuit frame.  Due to the complexities of manufacturing, it cannot be repaired, only replaced."),
    mass = "50 kg",
    volume = "25 L",
    materials = { "qt_steel", "plastic", "graphene_weave", "nanoprinted_alloy" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "dark_gray",
    flags = {
        "FRAGILE", "CANT_WEAR", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "WATERPROOF", "IS_UPS", "USE_UPS",
        "EXO_PSU", "LEAK_DAM", "RADIOACTIVE", "NO_REPAIR",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 10000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "8 s" } },
}
