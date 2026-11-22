local ccb = require("ccb")

ccb.content.define_item {
    id = "corpse",
    name = "corpse",
    description = "A dead body.",
    symbol = "%",
    color = "white",
    category = "corpses",
    volume = "0 ml",
    price = "0 cent",
    flags = { "TRADER_AVOID", "CORPSE", "TARDIS", "PUNCTURE_VEHICLE_WHEELS" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1650 L",
            mass_limit = "2000 kg",
            max_item_length = "60 meter",
            max_item_volume = "150 L",
            moves = 100,
            transparent = true,
            rigid = false,
            forbidden = true,
        },
    },
    conditional_names = {
        {
            kind = "FLAG",
            key = "FIELD_DRESS",
            name = ccb.content.plural_text("carcass", "carcasses"),
        },
        {
            kind = "FLAG",
            key = "FIELD_DRESS_FAILED",
            name = ccb.content.plural_text("carcass", "carcasses"),
        },
        {
            kind = "FLAG",
            key = "SKINNED",
            name = ccb.content.plural_text("skinned %s", "skinned %s"),
        },
        { kind = "FLAG", key = "QUARTERED", name = "carcass quarter" },
    },
}
