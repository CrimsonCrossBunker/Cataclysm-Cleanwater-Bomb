local ccb = require("ccb")

ccb.content.define_item {
    id = "corpse_generic_deep_one",
    copy_from = "corpse",
    symbol = "%",
    color = "light_gray",
    volume = "92500 ml",
    mass = "120 kg",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("The dead body of a deep one."),
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_generic_male_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("A dead body of a male deep one."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_generic_female_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("A dead body of a female deep one."),
    looks_like = "corpse_generic_deep_one",
    volume = "70 L",
    mass = "90 kg",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_bloody_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("The dead body of a deep one, coated in congealed blood."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_scorched_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("An awful, almost unidentifiable mass of charred flesh."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_stabbed_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("A dead body of a deep one with a gaping stab wound in its back."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_gunned_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("The dead body of a deep one.  Its forehead bears a large bullet entrance wound.  An even larger exit wound is present on the back of its head."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}

-- Former volume: 46250 L. Adjusted to 1000L so it can actually be placed. TODO(?): Re-add old volume with some sort of flag
ccb.content.define_item {
    id = "corpse_halved_upper_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("The upper half of a dead deep one body, as if torn apart with enormous force.  Some organs are hanging out."),
    looks_like = "corpse_generic_deep_one",
    volume = "1000 L",
    mass = "60 kg",
    materials = { "flesh" },
}

ccb.content.define_item {
    id = "corpse_half_beheaded_deep_one",
    copy_from = "corpse_generic_deep_one",
    name = ccb.content.plural_text("deep one corpse", "deep one corpses"),
    description = ccb.content.text("A half-decapitated dead body.  It is unclear what could have caused such a wound."),
    looks_like = "corpse_generic_deep_one",
    materials = { "flesh" },
}
