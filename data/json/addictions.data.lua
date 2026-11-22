local ccb = require("ccb")

ccb.content.define_addiction_type {
    id = "nicotine",
    name = "Nicotine Withdrawal",
    type_name = "nicotine",
    description = "Intelligence - 1;   Occasional cravings.",
    sated = "4 hours",
    satisfying_effects = { "cig" },
    craving_morale = "morale_craving_nicotine",
    builtin = "nicotine_effect",
}

ccb.content.define_addiction_type {
    id = "alcohol",
    name = "Alcohol Withdrawal",
    type_name = "alcohol",
    description = "Perception - 1;   Intelligence - 1;   Occasional Cravings;\nRisk of delirium tremens.",
    sated = "6 hours",
    satisfying_effects = { "drunk" },
    craving_morale = "morale_craving_alcohol",
    builtin = "alcohol_effect",
}

ccb.content.define_addiction_type {
    id = "opiate",
    name = "Opiate Withdrawal",
    type_name = "opiates",
    description = "Strength - 1;   Perception - 1;   Dexterity - 1;\nDepression and physical pain to some degree.  Frequent cravings.  Vomiting.",
    sated = "6 hours",
    craving_morale = "morale_craving_opiate",
    builtin = "opiate_effect",
}

ccb.content.define_addiction_type {
    id = "amphetamine",
    name = "Amphetamine Withdrawal",
    type_name = "amphetamine",
    description = "Strength - 1;   Intelligence - 1;\nMovement rate reduction.  Depression.  Weak immune system.  Frequent cravings.",
    sated = "6 hours",
    craving_morale = "morale_craving_speed",
    builtin = "amphetamine_effect",
}

ccb.content.define_addiction_type {
    id = "cocaine",
    name = "Cocaine Withdrawal",
    type_name = "cocaine",
    description = "Perception - 1;   Intelligence - 1;   Frequent cravings.",
    sated = "4 hours",
    craving_morale = "morale_craving_cocaine",
    builtin = "cocaine_effect",
}

ccb.content.define_addiction_type {
    id = "crack",
    name = "Crack Cocaine Withdrawal",
    type_name = "crack cocaine",
    description = "Perception - 2;   Intelligence - 2;   Frequent cravings.",
    sated = "45 minutes",
    craving_morale = "morale_craving_crack",
    builtin = "crack_effect",
}

ccb.content.define_addiction_type {
    id = "cannabis",
    name = "Craving Cannabis",
    type_name = "cannabis",
    description = "You could use some herb right now.",
    sated = "8 hours",
    satisfying_effects = { "weed_high" },
    craving_morale = "morale_craving_cannabis",
    builtin = "cannabis_effect",
}

ccb.content.define_addiction_type {
    id = "diazepam",
    name = "Diazepam Withdrawal",
    type_name = "diazepam",
    description = "Perception - 1;   Intelligence - 1;\nAnxiety, nausea, hallucinations, and general malaise.",
    sated = "6 hours",
    satisfying_effects = { "valium", "took_xanax" },
    craving_morale = "morale_craving_diazepam",
    builtin = "diazepam_effect",
}
