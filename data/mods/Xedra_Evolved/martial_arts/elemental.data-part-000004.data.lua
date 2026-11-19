local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_BENEATH_FALLING_TREE",
    name = ccb.content.text("Beneath the Falling Tree"),
    messages = {
        ccb.content.text("You punch through %s's armor with a mighty blow"),
        ccb.content.text("<npcname> punches through %s's armor with a mighty blow"),
    },
    skills = { { id = "unarmed", level = 5 }, { id = "gramarye", level = 5 } },
    weighting = 2,
    unarmed_allowed = true,
    crit_ok = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes" },
    required_buffs_any = { "xe_ma_buff_arvore_burrowing_ivy" },
    flat_bonuses = {
        { stat = "damage", damage_type = "bash", scaling_stat = "unarmed", scale = 1 },
        { stat = "damage", damage_type = "cut", scaling_stat = "unarmed", scale = 1 },
        { stat = "arpen", damage_type = "bash", scaling_stat = "gramarye", scale = 0.75 },
        { stat = "arpen", damage_type = "cut", scaling_stat = "gramarye", scale = 0.75 },
    },
    on_apply = "arvore_falling_tree_applied",
}
