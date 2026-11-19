local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_vulgar_opening",
    name = ccb.content.text("Vulgar Opening"),
    messages = {
        ccb.content.text("You cleave into %s with a mighty strike"),
        ccb.content.text("<npcname> cleaves into %s with a powerful blow"),
    },
    required_char_flags_all = { "MELEE_PERK_JUST_HIT_IT" },
    melee_allowed = true,
    crit_ok = true,
    weapon_categories = {
        "GREAT_AXES",
        "GREAT_SWORDS",
        "GREAT_HAMMERS",
        "AXE",
        "MEDIUM-SWORDS",
        "LONG_SWORDS",
        "MACES",
        "AXES",
        "FLAILS",
    },
    weighting = 100,
    flat_bonuses = {
        { stat = "arpen", damage_type = "bash", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "str", scale = 2.25 },
        { stat = "arpen", damage_type = "stab", scaling_stat = "str", scale = 2.25 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_tec_perk_vulgar_opening",
}
