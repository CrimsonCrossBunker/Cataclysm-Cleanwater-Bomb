local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_ENTANGLING_STRIKE",
    name = ccb.content.text("Entangling Strike"),
    messages = {
        ccb.content.text("As you strike %s, roots burst from the ground around them"),
        ccb.content.text("<npcname> hits %s and roots burst from the ground around them"),
    },
    skills = { { id = "unarmed", level = 3 }, { id = "gramarye", level = 3 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    effects = { { id = "effect_hungry_roots", chance = 100, duration_turns = 10, on_damage = true } },
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_xe_ma_arvore_entangling_strike",
    condition_description = ccb.content.text("Must be outdoors and your opponent must be on diggable ground."),
}
