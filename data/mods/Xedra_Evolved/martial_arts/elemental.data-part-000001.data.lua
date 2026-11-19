local ccb = require("ccb")

ccb.content.define_technique {
    id = "TECH_XE_MA_ARVORE_DISARM",
    name = ccb.content.text("Curling Fronds"),
    messages = {
        ccb.content.text("You reach out toward %s and pull their weapon away"),
        ccb.content.text("<npcname> reaches towards %s and pulls their weapon away"),
    },
    skills = { { id = "unarmed", level = 4 }, { id = "gramarye", level = 4 } },
    unarmed_allowed = true,
    crit_ok = true,
    melee_allowed = true,
    attack_vectors = { "vector_punch", "vector_knee", "vector_shin", "vector_foot_toes", "vector_null" },
    disarms = true,
    flat_bonuses = {
        { stat = "movecost", scaling_stat = "melee", scale = -1.25 },
        { stat = "movecost", scaling_stat = "dex", scale = -0.5 },
    },
    when = "allow_tech_xe_ma_arvore_disarm",
    condition_description = ccb.content.text("Must have Writhing Vines active or be wielding a heartvine whip"),
}
