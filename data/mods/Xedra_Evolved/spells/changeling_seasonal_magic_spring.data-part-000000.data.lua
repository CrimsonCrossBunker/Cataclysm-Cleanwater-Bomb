local ccb = require("ccb")

ccb.content.add(ccb.content.Spell {
    id = "changeling_spring_turn_target_into_tree_spell",
    name = ccb.content.text("Branch of Yggdrasil"),
    description = ccb.content.text("Transform yourself or an ally into a tree, greatly speeding their healing and allowing them to mend even serious wounds or broken bones with no other treatment, as well as attempting to cure more esoteric afflictions.  If necessary, you can reweave the glamour to return the target to their normal form.  The glamour will automatically fade when the target has fully healed.  The glamour has a <color_yellow>lower duration</color> in autumn."),
    message = ccb.content.text("You chant the words of the glamour and the target's legs sink into the soil, their arms spread and begin to branch out, and they slowly turn into a tree."),
    flags = { "VERBAL", "SOMATIC", "RANDOM_DURATION", "NO_LEGS" },
    magic_type = "xe_fey_seasonal_magick_spring",
    spell_class = "CHANGELING_SEASONAL_MAGIC_SPRING",
    valid_targets = { "self", "ally" },
    teachable = false,
    skill = "gramarye",
    max_level = 1,
    shape = "blast",
    difficulty = 9,
    components = "spell_components_changeling_dreamsparks_5",
    min_range = 1,
    max_range = 1,
    min_duration = 17284861,
    max_duration = 48384489,
    base_energy_cost = 1800,
    base_casting_time = 30000,
}:caster_when("changeling_tree_can_cast", ccb.content.text("You must be outside to weave this glamour."))
    :dynamic_stat("min_duration", "changeling_tree_min_duration")
    :dynamic_stat("max_duration", "changeling_tree_max_duration")
    :dynamic_stat("base_energy_cost", "changeling_tree_energy")
    :dynamic_stat("base_casting_time", "changeling_tree_casting_time")
    :lua_impact("changeling_tree_impact"))
