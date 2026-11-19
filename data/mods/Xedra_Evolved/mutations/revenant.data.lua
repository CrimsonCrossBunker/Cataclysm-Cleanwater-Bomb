local ccb = require("ccb")

ccb.content.define_mutation {
    id = "XE_REVENANT_TRAITS",
    name = ccb.content.text("Revenant"),
    description = ccb.content.text("You are a walking corpse, animated by a terrible thirst for vengeance."),
    points = 0,
    purifiable = false,
    valid = false,
    types = { "HERITAGE" },
    visibility = 30,
    ugliness = 30,
    chargen_allow_npc = false,
    species_anger = { FERAL = -120 },
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR", "VAMPIRE" },
    enchantments = {
        "INLINE_ENCH_XE_REVENANT_TRAITS_0",
        "INLINE_ENCH_XE_REVENANT_TRAITS_1",
        "INLINE_ENCH_XE_REVENANT_TRAITS_2",
    },
    flags = {
        "HERITAGE", "INHALED_TOXIN_IMMUNE ", "SUFFOCATION_IMMUNE", "GILLS", "IMMUNE_HEARING_DAMAGE",
        "IMMUNE_SPOIL", "GLARE_RESIST", "BLEED_IMMUNE", "MAGICAL_MIND_PROTECTION", "MYCUS_IMMUNE",
        "NO_BODY_HEAT", "NUMB", "PAIN_IMMUNE", "PRED4", "BARKY", "STOP_SLEEP_DEPRIVATION",
        "WALK_UNDERWATER", "BLOCK_SUPERNATURAL_HEALING", "CANNOT_CONSUME_DRUGS", "HUNGER_DISRUPTION",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "XE_REVENANT_SENSING_TRAIT",
    name = ccb.content.text_without_extraction("Revenant Sense"),
    description = ccb.content.text_without_extraction("This exists so the revenant can sense their target"),
    points = 0,
    purifiable = false,
    valid = false,
    player_display = false,
    chargen_allow_npc = false,
}
