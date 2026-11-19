local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "migo_enhance_flesh_monster",
    name = ccb.content.text_without_extraction("Enhance Flesh"),
    description = ccb.content.text_without_extraction("A spell for the mi-go fleshwarper to buff themselves with regeneration, armor, and speed."),
    valid_targets = { "self" },
    flags = { "SILENT", "RANDOM_DURATION" },
    shape = "blast",
    effect = "attack",
    effect_data = "effect_migo_enhance_flesh_monster",
    min_duration = 18000,
    max_duration = 72000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "migo_fleshwarper_block_healing",
    name = ccb.content.text_without_extraction("Block Healing"),
    description = ccb.content.text_without_extraction("Stops the target from healing.  Monster spell."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_HANDS", "RANDOM_DURATION", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_migo_fleshwarper_block_healing",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 2,
    max_range = 20,
    range_increment = 1.5,
    min_duration = 720000,
    max_duration = 8640000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "migo_nethermancer_summon_nether",
    name = ccb.content.text_without_extraction("Summon Nether Being"),
    description = ccb.content.text_without_extraction("A spell for the mi-go nethermancer to summon a nether being.  It's a bug if you have this."),
    valid_targets = { "ground" },
    flags = { "HOSTILE_SUMMON", "LOUD", "NO_PROJECTILE", "SPAWN_GROUP" },
    shape = "blast",
    effect = "summon",
    effect_data = "GROUP_NETHERMANCER_SUMMON",
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 30000,
    max_duration = 30000,
    sound_description = ccb.content.text("a high-pitched whine"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sorcerer_hand_monster",
    name = ccb.content.text_without_extraction("Sorcerer's Hand Monster"),
    description = ccb.content.text_without_extraction("Pull a target or set of items to you."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_HANDS", "NO_LEGS" },
    effect = "pull_target",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 2,
    max_range = 20,
    range_increment = 1.5,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teleport_anchor_monster",
    name = ccb.content.text_without_extraction("Teleport Anchor Monster"),
    description = ccb.content.text_without_extraction("Prevent the target from being able to teleport."),
    valid_targets = { "hostile" },
    flags = { "CONCENTRATE", "NO_HANDS", "NO_LEGS" },
    effect = "attack",
    effect_data = "effect_teleport_anchor",
    shape = "blast",
    difficulty = 1,
    max_level = 20,
    min_range = 2,
    max_range = 20,
    range_increment = 1.5,
    min_duration = 3000,
    max_duration = 30000,
    duration_increment = 1350,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "migo_nether_shield_monster",
    name = ccb.content.text_without_extraction("Mi-go Nether Shield"),
    description = ccb.content.text_without_extraction("Shield yourself from Nether damage, and secondarily from bullets, if you're a mi-go Nethermancer."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_migo_nether_shield_monster",
    shape = "blast",
    flags = { "SILENT", "NO_PROJECTILE" },
    max_level = 25,
    min_duration = 5000,
    max_duration = 5000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_brambles_arc",
    name = ccb.content.text_without_extraction("Triffid Summon Brambles"),
    description = ccb.content.text_without_extraction("Call up brambles to trap a pathetic mammal.  This is the triffid version with no math."),
    valid_targets = { "ground", "hostile" },
    effect = "ter_transform",
    effect_data = "druid_summoned_brambles",
    shape = "cone",
    flags = { "SILENT", "NO_PROJECTILE" },
    max_level = 15,
    min_range = 1,
    max_range = 15,
    range_increment = 1,
    min_aoe = 30,
    max_aoe = 60,
    aoe_increment = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_summon_tanglevine",
    name = ccb.content.text_without_extraction("Summon Tanglevine"),
    description = ccb.content.text_without_extraction("This spell causes an animated vine to burst from the ground and attempt to seize a nearby target and hold it fast."),
    valid_targets = { "ground" },
    flags = { "RANDOM_AOE", "RANDOM_DURATION", "HOSTILE_SUMMON" },
    effect = "summon",
    effect_data = "mon_tanglevine_triffid",
    shape = "blast",
    max_level = 15,
    min_damage = 1,
    max_damage = 1,
    min_range = 5,
    max_range = 15,
    range_increment = 0.8,
    min_aoe = 2,
    max_aoe = 3,
    min_duration = 12000,
    max_duration = 42000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_pollen_cone",
    name = ccb.content.text_without_extraction("Pollen Spray"),
    description = ccb.content.text_without_extraction("Spews pollen in a cone."),
    valid_targets = { "hostile", "ground" },
    max_level = 5,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "cone",
    min_aoe = 45,
    max_aoe = 45,
    min_range = 4,
    max_range = 8,
    range_increment = 1,
    field = "fd_pollen_triffid",
    field_chance = 1,
    min_field_intensity = 1,
    max_field_intensity = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_pollen_heal",
    name = ccb.content.text_without_extraction("Pollen Heal"),
    description = ccb.content.text_without_extraction("Heals other triffids."),
    valid_targets = { "ally" },
    max_level = 5,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DAMAGE" },
    effect = "attack",
    extra_spells = { { spell = "triffid_pollen_emit" } },
    shape = "blast",
    min_damage = -10,
    max_damage = -50,
    min_range = 4,
    max_range = 15,
    range_increment = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_pollen_speed",
    name = ccb.content.text_without_extraction("Pollen enhancement"),
    description = ccb.content.text_without_extraction("Increases the speed of other triffids."),
    valid_targets = { "ally" },
    max_level = 8,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    extra_spells = { { spell = "triffid_pollen_emit" } },
    effect = "attack",
    effect_data = "flask_speed_eff",
    shape = "blast",
    min_range = 4,
    max_range = 12,
    range_increment = 1,
    min_duration = 500,
    max_duration = 3000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_pollen_blind",
    name = ccb.content.text_without_extraction("Pollen blinding"),
    description = ccb.content.text_without_extraction("Blind target and emit pollen."),
    valid_targets = { "hostile" },
    max_level = 8,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION" },
    extra_spells = { { spell = "triffid_pollen_emit" } },
    effect = "attack",
    effect_data = "blind",
    shape = "blast",
    min_range = 4,
    max_range = 12,
    range_increment = 1,
    min_duration = 200,
    max_duration = 800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "triffid_pollen_emit",
    name = ccb.content.text_without_extraction("Pollen Emit Spell"),
    description = ccb.content.text_without_extraction("Causes a pollen emit when the triffid seedshaper uses other spells."),
    valid_targets = { "ally", "hostile", "ground" },
    max_level = 1,
    flags = { "SILENT", "NO_HANDS", "NO_LEGS" },
    effect = "emit",
    effect_data = "emit_pollen_stream",
    shape = "blast",
    min_range = 30,
}
