local ccb = require("ccb")

ccb.content.define_spell {
    id = "hedge_scare_shabriri",
    skill = "survival",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Repel the Light-Breaker",
    description = "Quickly recite a warding phrase to scare away nearby Shabriri and keep them from blinding you.",
    message = "\"So-and-so, son of so-and-so, your mother told you to beware of the Shabriri bariri riri iri ri in your white cup.\".",
    flags = { "VERBAL", "NO_FAIL", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self" },
    min_aoe = 50,
    max_aoe = 50,
    difficulty = 70,
    max_level = 1,
    base_casting_time = 500,
    impact_handler = "w16b_sp_imp_xedra_evolved_f2d6965926c8",
}
