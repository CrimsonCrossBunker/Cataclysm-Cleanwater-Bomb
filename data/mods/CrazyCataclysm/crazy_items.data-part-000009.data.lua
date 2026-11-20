local ccb = require("ccb")

ccb.content.define_item {
    id = "ceramic_plate",
    copy_from = "ceramic_plate",
    category = "armor",
    name = ccb.content.text("ceramic plate"),
    length = "20 cm",
    description = ccb.content.text("A ceramic dinner plate, unremarkable in every way."),
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "ABLATIVE_MEDIUM", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 1,
        broken_item = "destroyed_ceramic_plate",
        damage_verb = ccb.content.text("makes a crunch, something has shifted"),
        portions = { { encumbrance = 0, coverage = 45, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "destroyed_ceramic_plate",
    copy_from = "ceramic_plate",
    name = ccb.content.text("compromised ceramic plate"),
    description = ccb.content.text("A ceramic dinner plate that's been shattered."),
    looks_like = "esapi_plate",
    materials = { "damaged_ceramic" },
    armor = {},
}
