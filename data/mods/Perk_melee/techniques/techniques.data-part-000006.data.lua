local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_coiling_strike",
    name = ccb.content.text("Coiling strike"),
    weapon_categories = { "QUARTERSTAVES", "SPEARS", "POLEARMS" },
    required_buffs_any = { "buff_perk_momentum" },
    melee_allowed = true,
    reach_tec = true,
    required_char_flags_all = { "MELEE_PERK_COILING_STRIKE" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "per", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scaling_stat = "per", scale = 0.5 },
        { stat = "damage", damage_type = "stab", scaling_stat = "per", scale = 0.5 },
    },
    mult_bonuses = {
        { stat = "movecost", scale = 0.5 },
        { stat = "damage", damage_type = "bash", scale = 0.25 },
        { stat = "damage", damage_type = "cut", scale = 0.66 },
        { stat = "damage", damage_type = "stab", scale = 0.66 },
    },
    messages = {
        ccb.content.text("You quickly stab %s with a sideways thrust"),
        ccb.content.text("<npcname> stabs %s with a quick thrust"),
    },
    description = ccb.content.text("A quick reach attack that scales heavily with perception."),
    attack_vectors = { "vector_null" },
}
