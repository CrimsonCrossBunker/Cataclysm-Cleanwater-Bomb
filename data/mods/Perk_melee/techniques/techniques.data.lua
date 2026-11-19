local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_perk_poise_parry",
    name = ccb.content.text("Perfect Parry"),
    required_char_flags_all = { "MELEE_PERK_POISE_PARRY" },
    melee_allowed = true,
    block_counter = true,
    weighting = 10000,
    mult_bonuses = {
        { stat = "movecost", scale = 0.1 },
        { stat = "damage", damage_type = "bash", scale = 0.02 },
        { stat = "damage", damage_type = "cut", scale = 0.02 },
        { stat = "damage", damage_type = "stab", scale = 0.02 },
    },
    description = ccb.content.text("A quick stunning counter-attack that triggers on blocks or parries."),
    messages = {
        ccb.content.text("You throw %s off balance with a perfect parry"),
        ccb.content.text("<npcname> throws %s off balance with a parry"),
    },
    attack_vectors = { "vector_null" },
    on_apply = "perk_stagger_attacker",
    when = "allow_perk_poise_parry",
    condition_description = ccb.content.text("* Requires a full <info>stance meter</info> to trigger on a successful block or parry"),
}
