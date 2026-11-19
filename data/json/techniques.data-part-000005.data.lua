local ccb = require("ccb")

-- Similar size, no wrapping tiny or very nonstandard targets
ccb.content.define_technique {
    id = "WRAP",
    name = ccb.content.text("Wrap Attack"),
    melee_allowed = true,
    skills = { { id = "melee", level = 4 } },
    stun_dur = 2,
    messages = { ccb.content.text("You wrap up %s"), ccb.content.text("<npcname> wraps up %s") },
    description = ccb.content.text("Stun 2 turns, min 4 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_wrap",
    condition_description = ccb.content.text("* Only works on a target of <info>similar size</info> with limbs to catch"),
}

-- Humanoids of similar size
ccb.content.define_technique {
    id = "SWEEP",
    name = ccb.content.text("Sweep Attack"),
    melee_allowed = true,
    skills = { { id = "melee", level = 3 } },
    down_dur = 2,
    messages = { ccb.content.text("You sweep %s"), ccb.content.text("<npcname> sweeps %s") },
    description = ccb.content.text("Down 2 turns, min 3 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_sweep",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size"),
}
