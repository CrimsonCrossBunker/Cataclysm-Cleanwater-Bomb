local ccb = require("ccb")

ccb.content.define_item {
    id = "multi_cooker_filled",
    copy_from = "multi_cooker",
    name = ccb.content.plural_text("micro-cooker - cooking", "micro-cookers - cooking"),
    description = "This micro-cooker is currently cooking a dish.",
    tool = {},
    inheritance = {
        remove = {
            qualities = { "CONTAIN" },
        },
    },
}

ccb.content.define_item {
    id = "afs_survival_battery",
    copy_from = "storage_battery",
    name = ccb.content.plural_text("portable survival battery", "portable survival batteries"),
    description = "A storage battery fit for improvised shelters.",
    looks_like = "small_storage_battery",
    ascii_picture = "small_storage_battery",
    mass = "15 kg",
    volume = "5 L",
    price = "300 USD",
    survival_price = "300 USD",
    melee_damage = { bash = 7 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 10000 },
        },
    },
    use_actions = {
        { kind = "deploy_appliance", base = "afs_survival_battery" },
    },
    magazine = { capacity = 1000 },
}
