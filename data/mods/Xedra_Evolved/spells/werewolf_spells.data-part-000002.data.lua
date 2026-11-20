local ccb = require("ccb")

ccb.content.define_spell {
    id = "xe_werewolf_close_tear_in_reality_spell",
    name = ccb.content.text("Mending Rent Veils"),
    description = ccb.content.text("The world is falling apart but that is no reason to cease the hunt.  You can close a tear in reality, if you can get close enough to it and have enough time."),
    message = "",
    teachable = false,
    valid_targets = { "ground" },
    spell_class = "WEREWOLF_SPELLS",
    magic_type = "xe_werewolf_powers",
    skill = "deduction",
    effect = "ter_transform",
    effect_data = "ter_werewolf_close_reality_tear",
    shape = "blast",
    flags = { "VERBAL", "NO_HANDS" },
    difficulty = 10,
    min_range = 1,
    max_range = 1,
    base_energy_cost = 1000,
    base_casting_time = 3000,
}
