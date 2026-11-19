local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_shoulder_tackle",
    name = ccb.content.text("Shoulder tackle"),
    messages = {
        ccb.content.text("You ground %s with a shoulder bash"),
        ccb.content.text("<npcname> drops %s with a shoulder bash"),
    },
    required_char_flags_all = { "MELEE_PERK_TACKLE" },
    required_buffs_any = { "buff_perk_momentum" },
    weighting = 100,
    crit_ok = true,
    melee_allowed = true,
    unarmed_allowed = true,
    mult_bonuses = {
        { stat = "movecost", scale = 0.75 },
        { stat = "damage", damage_type = "bash", scale = 0.8 },
    },
    down_dur = 2,
    attack_vectors = { "vector_shoulder" },
    on_apply = "perk_clear_momentum",
    when = "allow_perk_shoulder_tackle",
    condition_description = ccb.content.text("* Only works on a <info>non-downed humanoid</info> target of <info>similar or smaller</info> size incapable of flight.  Requires <info>momentum(3)</info> or higher to trigger."),
}
