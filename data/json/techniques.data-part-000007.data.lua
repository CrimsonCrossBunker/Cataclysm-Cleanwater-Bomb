local ccb = require("ccb")

-- Humanoids of similar size
ccb.content.define_technique {
    id = "PRECISE",
    name = ccb.content.text("Precise Strike"),
    skills = { { id = "melee", level = 3 } },
    melee_allowed = true,
    crit_tec = true,
    messages = { ccb.content.text("You precisely hit %s"), ccb.content.text("<npcname> precisely hits %s") },
    stun_dur = 2,
    description = ccb.content.text("Stun 2 turns, crit only, min 3 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_precise",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned humanoid</info> target of <info>similar or smaller</info> size"),
}
