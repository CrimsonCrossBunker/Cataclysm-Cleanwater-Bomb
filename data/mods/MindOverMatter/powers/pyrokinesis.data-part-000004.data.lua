local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "pyrokin_banish_thermogenesis",
    name = ccb.content.text_without_extraction("[Ψ]Banish Thermogenesis"),
    description = ccb.content.text_without_extraction("The spell to banish existing thermogenesis nodes.  It's a bug if you have it directly."),
    teachable = false,
    valid_targets = { "ally" },
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "IGNORE_WALLS" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    min_damage = 100,
    max_damage = 100,
    min_aoe = 60,
    max_aoe = 60,
    targeted_monsters = {
        "mon_pyrokin_hotair_1",
        "mon_pyrokin_hotair_2",
        "mon_pyrokin_hotair_3",
        "mon_pyrokin_hotair_4",
    },
}
