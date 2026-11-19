local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_kevlard_obese",
    name = ccb.content.text_without_extraction("Kevlard I"),
    points = 0,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You shouldn't see this; provides integrated armor while Obese for kevlard perk."),
    integrated_armor = { "integrated_kevlard_obese" },
}

ccb.content.define_mutation {
    id = "perk_kevlard_veryobese",
    name = ccb.content.text_without_extraction("Kevlard II"),
    points = 0,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You shouldn't see this; provides integrated armor while Very Obese for kevlard perk."),
    integrated_armor = { "integrated_kevlard_veryobese" },
}

ccb.content.define_mutation {
    id = "perk_kevlard_morbidlyobese",
    name = ccb.content.text_without_extraction("Kevlard III"),
    points = 0,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You shouldn't see this; provides integrated armor while Morbidly Obese for kevlard perk."),
    integrated_armor = { "integrated_kevlard_morbidlyobese" },
}
