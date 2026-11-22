local ccb = require("ccb")

ccb.content.define_spell {
    id = "hedge_protect_the_mind",
    name = ccb.content.text("To Shield the Mind from Assault"),
    description = ccb.content.text("The first principle of psychic self-defense is to make sure your mind is in proper order so there is no foothold an assault can take advantage of.  While in effect, your mind is protected against psychic attack.  <color_red>Too much pain</color> will disrupt your concentration."),
    message = ccb.content.text("You settle down and begin ordering your mind."),
    flags = { "NO_FAIL" },
    magic_type = "xe_hedge_magick",
    valid_targets = { "self" },
    difficulty = 60,
    spell_class = "HEDGE_MAGIC",
    skill = "survival",
    effect = "attack",
    effect_data = "effect_hedge_protect_the_mind",
    shape = "blast",
    max_level = 1,
    base_casting_time = 360000,
    min_duration = 8640000,
    max_duration = 8640000,
}

ccb.content.define_spell {
    id = "hedge_astral_projection",
    skill = "survival",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Project the Etheric Form",
    description = "After a period of trance and meditation, send out your disembodied spirit to wander the world.  Use of this ritual is <color_yellow>very tiring</color> and you will become increasingly more weary the longer you remain out of your body.",
    message = "You settle down and slip into a trance.",
    flags = { "NO_FAIL" },
    valid_targets = { "self" },
    difficulty = 90,
    max_level = 1,
    base_casting_time = 180000,
    impact_handler = "w16b_sp_imp_xedra_evolved_f0daa2394cbc",
}
