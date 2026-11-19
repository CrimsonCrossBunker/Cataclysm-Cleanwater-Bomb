local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "lizardfolk_javelin_gun",
    copy_from = "fake_item",
    name = ccb.content.text("barbed javelin"),
    description = ccb.content.text_without_extraction("Fake gun that fires barbed javelins."),
    flags = {
        "NEVER_JAMS",
        "NONCONDUCTIVE",
        "NO_REPAIR",
        "WATERPROOF_GUN",
        "NO_SALVAGE",
        "NO_UNLOAD",
        "NO_TURRET",
    },
    gun = {
        skill = "rifle",
        durability = 10,
        range = 10,
        dispersion = 10,
        damage = { { type = "stab", amount = 5 } },
    },
}
