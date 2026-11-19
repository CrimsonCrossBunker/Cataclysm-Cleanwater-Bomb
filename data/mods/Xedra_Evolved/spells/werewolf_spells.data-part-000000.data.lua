local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xe_werewolf_argent_claws_damage",
    name = ccb.content.text_without_extraction("Argent Claws Damage"),
    description = ccb.content.text_without_extraction("The damage to Nether beings from argent claws.  Should not be visible"),
    spell_class = "WEREWOLF_SPELLS",
    magic_type = "xe_werewolf_powers",
    skill = "deduction",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    valid_targets = { "ally", "hostile" },
    difficulty = 0,
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    min_damage = 3,
    max_damage = 12,
    min_range = 1,
    max_range = 2,
    targeted_species = { "NETHER", "NETHER_EMANATION", "NETHER_BURROWING" },
}
