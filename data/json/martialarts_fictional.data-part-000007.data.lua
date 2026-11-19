local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_toad_grab",
    name = ccb.content.text("Toad's Tongue"),
    messages = {
        ccb.content.text("You snatch and slug %s"),
        ccb.content.text("<npcname> snatches and slug %s"),
    },
    skills = { { id = "unarmed", level = 1 } },
    unarmed_allowed = true,
    required_buffs_all = { "buff_toad_ongethit" },
    crit_ok = true,
    down_dur = 2,
    mult_bonuses = { { stat = "movecost", scale = 0.5 } },
    attack_vectors = { "vector_grasp" },
    when = "allow_tec_biojutsu_takedown",
    condition_description = ccb.content.text("* Only works on a <info>non-downed</info> target"),
}
