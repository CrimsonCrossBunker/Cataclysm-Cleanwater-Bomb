local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hedge_blessed_weapon_nether_damage",
    name = ccb.content.text_without_extraction("Blessed Weapon Nether Damage"),
    description = ccb.content.text_without_extraction("This is the extra damage a blessed weapon does to Nether creatures.  It's a bug if you have it directly."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE" },
    magic_type = "xe_hedge_magick",
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    min_damage = 5,
    max_damage = 25,
    min_range = 1,
    max_range = 1,
    targeted_species = { "NETHER", "ABERRATION", "HORROR", "NETHER_EMANATION" },
}

ccb.content.define_spell {
    id = "hedge_turn_into_bear",
    skill = "survival",
    components = "spell_components_hedge_turn_into_bear",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Walk the Forests with the Brown One",
    description = "Over the freshly-slain and butchered corpse of a bear, recite a paean to its spirit while using its fur and sinew and skull to create a garment.  Putting the garment on will take the spirit of the bear into yourself, allowing you to assume its form until the garment is removed.",
    message = "As you recite the words of the charm, you sew the bits of fur together into a rough mantle with the bear skull at the top.",
    flags = { "VERBAL", "SOMATIC", "NO_FAIL" },
    valid_targets = { "self" },
    difficulty = 90,
    max_level = 1,
    base_casting_time = 720000,
    impact_handler = "w16b_sp_imp_xedra_evolved_f0b87f421398",
}

ccb.content.define_spell {
    id = "hedge_walk_on_water",
    skill = "survival",
    components = "spell_components_hedge_walk_on_water",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Walk Across the Flowing Waters",
    description = "While standing with your feet in the water, recite this charm to have the water bear you up.  You must keep moving at a steady pace, without running or stopping for more than a few moments, or the charm will fade.",
    message = "",
    flags = { "VERBAL", "SOMATIC", "NO_FAIL" },
    valid_targets = { "self" },
    difficulty = 70,
    max_level = 1,
    base_casting_time = 6000,
    impact_handler = "w16b_sp_imp_xedra_evolved_f32d5f8818da",
}

ccb.content.define_spell {
    id = "hedge_bless_steel_weapon",
    skill = "survival",
    components = "spell_components_hedge_bless_steel_weapon",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Bless the Sacred Weapon",
    description = "Ensorcell an iron or steel weapon that you are holding so it does additional damage to unholy creatures when used in melee combat.  If the weapon is too damaged, the charm will cease to function.",
    message = "",
    flags = { "VERBAL", "SOMATIC", "NO_FAIL", "NO_HANDS" },
    valid_targets = { "self" },
    difficulty = 120,
    max_level = 1,
    base_casting_time = 2880000,
    impact_handler = "w16b_sp_imp_xedra_evolved_5511f6126c72",
}
