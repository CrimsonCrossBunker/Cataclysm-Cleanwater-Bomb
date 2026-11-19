local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_make_way",
    name = ccb.content.text("Make Way"),
    required_char_flags_all = { "MELEE_PERK_MAKE_WAY" },
    weapon_categories = { "QUARTERSTAVES", "SPEARS", "POLEARMS" },
    melee_allowed = true,
    weighting = 2,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 0.5 },
        { stat = "damage", damage_type = "cut", scale = 0.25 },
        { stat = "damage", damage_type = "stab", scale = 0.01 },
    },
    messages = {
        ccb.content.text("You swing through %s and everything nearby with an overhead attack"),
        ccb.content.text("<npcname> swings at %s and everything nearby with an overhead attack"),
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_make_way_applied",
    when = "allow_perk_make_way",
}
