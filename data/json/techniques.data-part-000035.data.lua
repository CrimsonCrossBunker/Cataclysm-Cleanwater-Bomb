local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_karate_staff_crit",
    name = ccb.content.text("Heavy Staff Strike"),
    messages = {
        ccb.content.text("You swing your staff hard at %s"),
        ccb.content.text("<npcname> swings their staff hard at %s"),
    },
    skills = { { id = "melee", level = 4 } },
    melee_allowed = true,
    weapon_categories = { "QUARTERSTAVES" },
    crit_tec = true,
    down_dur = 1,
    mult_bonuses = {
        { stat = "damage", damage_type = "bash", scale = 1.1 },
        { stat = "damage", damage_type = "cut", scale = 1.1 },
        { stat = "damage", damage_type = "stab", scale = 1.1 },
    },
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
