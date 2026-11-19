local ccb = require("ccb")

-- So fae NPCs show up on special_vision effects.
ccb.content.define_mutation {
    id = "FAERIECREATURE",
    name = ccb.content.text_without_extraction("Fae creature"),
    points = 0,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You are a creature of Faerie."),
    species_anger = { CHANGELING = -150 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "VAMPIRE_REASON_UNWILLING",
    name = ccb.content.text_without_extraction("Unwilling vampire"),
    points = 0,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You never wanted to be a vampire, yet you are one now."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "VAMPIRE_REASON_POWER_HUNGRY",
    name = ccb.content.text_without_extraction("Power-hungry vampire"),
    points = 0,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You want the powers granted by vampirism."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "VAMPIRE_REASON_VENGEFUL",
    name = ccb.content.text_without_extraction("Vengeful vampire"),
    points = 0,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("After almost being killed by someone because you were a vampire, you decided to become a stronger vampire so none will be able to kill you."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "VAMPIRE_REASON_DELUDED",
    name = ccb.content.text_without_extraction("Deluded vampire"),
    points = 0,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You are fascinated by vampires, and decided to become one."),
}
