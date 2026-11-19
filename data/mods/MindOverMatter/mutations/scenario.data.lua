local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_1",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 1"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_2",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 2"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_3",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 3"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_4",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 4"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_5",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 5"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "PSYCHIC_KNACK_WILD_TALENT_6",
    name = ccb.content.text_without_extraction("Psychic Knack Wild Talent 6"),
    points = 0,
    description = ccb.content.text_without_extraction("This exists to run an EoC."),
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "SCEN_HEART_OF_FIRE",
    name = ccb.content.text("Heart of Fire"),
    points = 0,
    description = ccb.content.text("The fire in your soul rises and falls, but never truly goes out."),
    valid = false,
    player_display = true,
    purifiable = false,
    mixed_effect = true,
    enchantments = { "INLINE_ENCH_SCEN_HEART_OF_FIRE_0", "INLINE_ENCH_SCEN_HEART_OF_FIRE_1" },
}
