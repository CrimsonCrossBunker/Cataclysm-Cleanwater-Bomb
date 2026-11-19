local ccb = require("ccb")

-- Basic size filtering, if the target is grabbing you contested roll of strength vs grab strength
ccb.content.define_technique {
    id = "BRUTAL",
    name = ccb.content.text("Brutal Strike"),
    melee_allowed = true,
    crit_tec = true,
    skills = { { id = "melee", level = 2 } },
    stun_dur = 1,
    knockback_dist = 1,
    messages = { ccb.content.text("You send %s reeling"), ccb.content.text("<npcname> sends %s reeling") },
    description = ccb.content.text("Stun 1 turn, knockback 1 tile, crit only, min 2 melee"),
    attack_vectors = { "vector_null" },
    when = "allow_brutal",
    condition_description = ccb.content.text("* Only works on a <info>non-stunned mundane</info> target of <info>similar or smaller</info> size, may fail on enemies grabbing you"),
}
