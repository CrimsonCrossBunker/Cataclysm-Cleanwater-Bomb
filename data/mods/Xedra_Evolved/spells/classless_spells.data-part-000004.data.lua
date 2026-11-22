local ccb = require("ccb")

ccb.content.define_spell {
    id = "boann_banish_monsters_check",
    skill = "deduction",
    shape = "blast",
    spell_class = "NONE",
    damage_type = "pure",
    name = ccb.content.text_without_extraction("Boann's retaliation against monsters check"),
    description = ccb.content.text_without_extraction("Boann's about to retaliate against monsters, deleting them as they are \"teleported\" away.  You shouldn't see this"),
    teachable = false,
    flags = { "SILENT", "NO_FAIL", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "ally", "hostile" },
    min_range = 60,
    max_range = 60,
    min_aoe = 60,
    max_aoe = 60,
    base_casting_time = 0,
    impact_handler = "w16b_sp_imp_xedra_evolved_16049a32de34",
}
