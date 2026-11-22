local ccb = require("ccb")

ccb.content.define_spell {
    id = "soul_afterburner",
    shape = "blast",
    spell_class = "SOULFIRE",
    name = "Soul Afterburner",
    description = "You burn a small portion of your soul to gain a large burst of speed.  You will have to wait until your soul has healed before burning a part of it again.",
    flags = { "ENHANCEMENT_SPELL", "VERBAL", "SILENT", "MUST_HAVE_CLASS_TO_LEARN" },
    valid_targets = { "self" },
    difficulty = 6,
    max_level = 35,
    impact_handler = "w16b_sp_imp_magiclysm_9c91c0357a44",
}
