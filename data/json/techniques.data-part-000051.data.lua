local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "tec_pankration_kick",
    name = ccb.content.text("Kick"),
    messages = { ccb.content.text("You kick %s hard"), ccb.content.text("<npcname> kicks %s hard") },
    skills = { { id = "unarmed", level = 2 } },
    unarmed_allowed = true,
    crit_tec = true,
    down_dur = 2,
    attack_vectors = { "vector_foot_sole" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
