local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleporter_breach_monster",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "TELEPORTER",
    name = ccb.content.text_without_extraction("[Ψ]Breach Monster"),
    description = ccb.content.text_without_extraction("Open a portal to the Nether and summon monsters, if you're also a monster.  This will probably end badly for you but who cares, you're a monster."),
    message = "",
    teachable = false,
    flags = { "PSIONIC", "CONCENTRATE", "SILENT", "NO_HANDS", "NO_LEGS" },
    valid_targets = { "self", "hostile" },
    min_damage = 1,
    min_range = 5,
    range_increment = 1,
    max_range = 80,
    max_level = 30,
    impact_handler = "w16b_sp_imp_mindovermatter_aea82c11ed05",
}
