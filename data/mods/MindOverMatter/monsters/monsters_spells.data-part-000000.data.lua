local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_banish_monster",
    name = ccb.content.text_without_extraction("[Ψ]Nether Banish Monster"),
    description = ccb.content.text_without_extraction("A spell for the zombie null to try to banish nether monsters.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "hostile" },
    targeted_species = { "NETHER" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "banishment",
    shape = "blast",
    min_damage = 100,
    max_damage = 600,
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "nether_banish_monster_greater",
    name = ccb.content.text_without_extraction("[Ψ]Greater Nether Banish Monster"),
    description = ccb.content.text_without_extraction("A spell for the nether-void to try to banish nether monsters.  It's a bug if you have it."),
    teachable = false,
    valid_targets = { "hostile" },
    targeted_species = { "NETHER", "NETHER_EMANATION", "NETHER_BURROWING" },
    flags = { "SILENT", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    effect = "banishment",
    shape = "blast",
    min_damage = 300,
    max_damage = 1000,
    min_range = 10,
    max_range = 10,
}
