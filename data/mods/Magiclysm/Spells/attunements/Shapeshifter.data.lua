local ccb = require("ccb")

-- thats supposed to be a magikarp power - weak on the very beginning but op in the end of the path. also it has a cool feature - you can support it indefinitely, if you have enough mana (and thats the only problem for the user - it requires really ton of mana to support it)
ccb.content.define_spell {
    id = "biomechanic",
    name = ccb.content.text("Biomechanic"),
    description = ccb.content.text("Who said the human body is weak?  You just need to compress enough mana into your flesh and bones in order to show them who is the deadliest animal in the world."),
    message = "",
    valid_targets = { "self" },
    flags = { "TRANSFORMATION_SPELL", "SILENT", "NO_LEGS", "NO_HANDS" },
    extra_spells = { { spell = "eoc_transformation_setup", self = true } },
    effect = "attack",
    effect_data = "biomechanic",
    shape = "blast",
    magic_type = "magiclysm_transformation_magic",
    spell_class = "SHAPESHIFTER",
    difficulty = 8,
    min_duration = 1440,
    max_duration = 33000,
    duration_increment = 900,
    max_level = 35,
    base_casting_time = 1000,
    final_casting_time = 200,
    casting_time_increment = -35,
    base_energy_cost = 350,
    energy_increment = -10,
    final_energy_cost = 50,
}
