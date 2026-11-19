local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "warg_food",
    copy_from = "cattlefodder_medium",
    name = ccb.content.text_without_extraction("warg food"),
    description = ccb.content.text_without_extraction("A food that doesn't exist but is necessary for technical reasons."),
    flags = { "INEDIBLE" },
    comestible = { kind = "FOOD", pet_food = { "WARG_FOOD" } },
    use_actions = { "PETFOOD" },
}
