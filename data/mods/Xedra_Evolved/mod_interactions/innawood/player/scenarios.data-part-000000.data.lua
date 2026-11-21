local ccb = require("ccb")

ccb.content.define_scenario {
    id = "paraclesian_birth_naked_afraid",
    name = "Paraclesian Birth, Lost and Alone",
    flags = { "LONE_START" },
    points = 0,
    description = "Your first moments of life, born of the elements, alone.  An elemental fae on a dying world, lost in the wilderness.",
    start_name = "Paraclesian Birth",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island", "sloc_river" },
    professions = {
        "paraclesian_ierde_naked_afraid",
        "paraclesian_undine_naked_afraid",
        "paraclesian_salamander_naked_afraid",
        "paraclesian_sylph_naked_afraid",
        "paraclesian_arvore_naked_afraid",
        "paraclesian_homullus_naked_afraid",
    },
    traits = { "ELEMENTAL_MANA1", "ELEMENTAL_MANA2" },
    reveal_locale = false,
}

ccb.content.define_scenario {
    id = "werewolf_native",
    name = "Werewolf, Natural-born",
    flags = { "LONE_START" },
    points = 0,
    description = "You had no idea what was going on the first time it happened, when you woke up with mud on your bare feet and a sour taste in your mouth, but you were soon found.  The People of the Moon, they called themselves, and they said you were one of them.  A werewolf.  You lived out in the wilderness for a while with them.  Maybe some of the People are still out there.",
    start_name = "Alone",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island", "sloc_river" },
    forced_traits = { "NATIVE_SHAPESHIFTER", "WEREWOLF_ANIMAL_FORM", "WEREWOLF_HYBRID_FORM" },
    reveal_locale = false,
}

ccb.content.define_scenario {
    id = "werewolf_native_naked_unafraid",
    name = "Werewolf, Naked and Unafraid",
    flags = { "LONE_START" },
    points = 0,
    description = "You have no idea what happened, but you're alone in the unspoiled wilderness.  You have mud on your feet, none of your clothes or possessions, and you don't know where you are.  But you have learned there's a beast inside you, and anyone who crosses you had best beware.",
    start_name = "Alone",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island", "sloc_river" },
    professions = { "naked" },
    forced_traits = { "NATIVE_SHAPESHIFTER", "WEREWOLF_ANIMAL_FORM", "WEREWOLF_HYBRID_FORM" },
    reveal_locale = false,
}
