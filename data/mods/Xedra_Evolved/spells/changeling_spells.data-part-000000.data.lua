local ccb = require("ccb")

ccb.content.add(ccb.content.Spell {
    id = "changeling_gain_new_traits",
    name = ccb.content.text("Unlock Your Fae Heritage"),
    description = ccb.content.text("Using the power of human dreams, unlock the secrets of your fey heritage.  It requires <color_pink><u_val:changeling_new_trait_dreamdross_research_cost></color> scraps of dreamdross and a large amount of time to perform this research."),
    message = "",
    flags = { "NO_FAIL", "VERBAL", "SOMATIC" },
    valid_targets = { "self" },
    spell_class = "CHANGELING_MAGIC",
    difficulty = 4,
    skill = "gramarye",
    max_level = 1,
    magic_type = "xe_fey_magick",
    shape = "blast",
    base_energy_cost = 1000,
    base_casting_time = 50,
}:caster_when("has_changeling_research_dreamdross", ccb.content.text("You do not have enough dreamdross."))
    :lua_impact("begin_changeling_heritage_research"))
