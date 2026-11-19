local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "robot_disabler",
    name = ccb.content.text_without_extraction("Surge mod moves"),
    description = ccb.content.text_without_extraction("Subtract some moves from targeted_monster_ids monsters.  Subspell; you aren't allowed to see it except in debug mode."),
    valid_targets = { "hostile" },
    targeted_species = { "ROBOT", "CYBORG" },
    effect = "mod_moves",
    shape = "blast",
    max_level = 35,
    min_damage = -1500,
    max_damage = -12000,
    damage_increment = -300,
    min_aoe = 3,
    aoe_increment = 0.17,
    max_aoe = 15,
}
