local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "necro_boomer_revive",
    name = ccb.content.text_without_extraction("Necro Boomer Revive"),
    description = ccb.content.text_without_extraction("Revives zombies in a large AoE."),
    valid_targets = { "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_aoe = 10,
    max_aoe = 10,
    shape = "blast",
    effect = "revive",
    effect_data = "ZOMBIE",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "necro_boomer_upgrade",
    name = ccb.content.text_without_extraction("Necro Boomer Upgrade"),
    description = ccb.content.text_without_extraction("Upgrades zombies in a large AoE."),
    valid_targets = { "ally" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_aoe = 10,
    max_aoe = 10,
    min_damage = 1000,
    max_damage = 1000,
    shape = "blast",
    effect = "upgrade",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "necro_boomer_death",
    name = ccb.content.text_without_extraction("Necro Boomer Death"),
    description = ccb.content.text_without_extraction("Revives and then upgrades zombies in a large area."),
    valid_targets = { "ground", "ally" },
    shape = "blast",
    effect = "noise",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 24,
    max_damage = 24,
    sound_type = "combat",
    sound_id = "explosion",
    sound_variant = "small",
    extra_spells = {
        { spell = "necro_boomer_revive", self = true },
        { spell = "necro_boomer_upgrade", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_guilt",
    name = ccb.content.text_without_extraction("Death Guilt"),
    description = ccb.content.text_without_extraction("Feeling guilty over killing a monster."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "guilt",
    effect_data = "NULL",
    min_damage = 50,
    max_damage = 50,
    min_duration = 4320000,
    max_duration = 4320000,
    min_range = 5,
    max_range = 5,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_portal",
    name = ccb.content.text_without_extraction("Death Portal"),
    description = ccb.content.text_without_extraction("Spawns a tear in reality, field intensity depends on spell level."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    shape = "blast",
    effect = "attack",
    max_level = 2,
    field = "fd_fatigue",
    field_chance = 1,
    min_field_intensity = 1,
    field_intensity_increment = 1,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_acid",
    name = ccb.content.text_without_extraction("Acid Death"),
    description = ccb.content.text_without_extraction("Acid sprays out of a dead acid zombie or some such."),
    valid_targets = { "ground", "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    field = "fd_acid",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_sludge",
    name = ccb.content.text_without_extraction("Sludge Death"),
    description = ccb.content.text_without_extraction("Sludge sprays out of a dead monster."),
    valid_targets = { "ground", "self", "hostile", "ally" },
    flags = { "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    min_duration = 2400,
    max_duration = 2400,
    effect_data = "sludged",
    field = "fd_sludge",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    max_level = 1,
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_sludge_mega",
    name = ccb.content.text_without_extraction("Mega Sludge Death"),
    description = ccb.content.text_without_extraction("A large amount of sludge sprays out of a dead monster."),
    valid_targets = { "ground", "self", "hostile", "ally" },
    flags = { "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
    min_duration = 2400,
    max_duration = 2400,
    effect_data = "sludged",
    field = "fd_sludge",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
    min_aoe = 3,
    max_aoe = 3,
    aoe_increment = 1,
    max_level = 1,
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blood",
    name = ccb.content.text_without_extraction("Blood Death"),
    description = ccb.content.text_without_extraction("Explode in a shower of gore.  Metal!"),
    valid_targets = { "ground", "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "RANDOM_AOE" },
    shape = "blast",
    max_level = 3,
    min_aoe = 0,
    max_aoe = 3,
    aoe_increment = 1,
    effect = "attack",
    field = "fd_blood",
    min_field_intensity = 3,
    max_field_intensity = 3,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_halfworm",
    name = ccb.content.text_without_extraction("Half Worm Death"),
    description = ccb.content.text_without_extraction("Spawns one or two half worms."),
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    flags = {
        "SILENT",
        "HOSTILE_SUMMON",
        "PERMANENT",
        "SPAWN_WITH_DEATH_DROPS",
        "NO_EXPLOSION_SFX",
        "RANDOM_DAMAGE",
    },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_halfworm",
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_halfworm_small",
    name = ccb.content.text_without_extraction("Small Half Worm Death"),
    description = ccb.content.text_without_extraction("Spawns one or two small half worms."),
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    flags = {
        "SILENT",
        "HOSTILE_SUMMON",
        "PERMANENT",
        "SPAWN_WITH_DEATH_DROPS",
        "NO_EXPLOSION_SFX",
        "RANDOM_DAMAGE",
    },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_halfworm_small",
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_halfworm_graboid",
    name = ccb.content.text_without_extraction("Graboid Half Worm Death"),
    description = ccb.content.text_without_extraction("Spawns one or two graboid half worms."),
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 2,
    flags = {
        "SILENT",
        "HOSTILE_SUMMON",
        "PERMANENT",
        "SPAWN_WITH_DEATH_DROPS",
        "NO_EXPLOSION_SFX",
        "RANDOM_DAMAGE",
    },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_halfworm_graboid",
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blobsplit_large",
    name = ccb.content.text_without_extraction("Large Blob Death - Split"),
    description = ccb.content.text_without_extraction("A large blob splits in half."),
    valid_targets = { "ground", "self" },
    flags = { "SILENT", "HOSTILE_SUMMON", "PERMANENT", "SPAWN_WITH_DEATH_DROPS", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "slime_split",
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blobsplit",
    name = ccb.content.text_without_extraction("Blob Death - Split"),
    description = ccb.content.text_without_extraction("A blob splits in half."),
    valid_targets = { "ground", "self" },
    flags = { "SILENT", "HOSTILE_SUMMON", "PERMANENT", "SPAWN_WITH_DEATH_DROPS", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "slime_split",
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blobsplit_brain",
    name = ccb.content.text_without_extraction("Blob Brain Death - Split"),
    description = ccb.content.text_without_extraction("A blob brain splits in half."),
    valid_targets = { "ground", "self" },
    flags = { "SILENT", "HOSTILE_SUMMON", "PERMANENT", "SPAWN_WITH_DEATH_DROPS", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "slime_split",
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_blob_brain",
    name = ccb.content.text_without_extraction("Blob Brain Death"),
    description = ccb.content.text_without_extraction("A blob brain dies."),
    valid_targets = { "ally" },
    min_aoe = 48,
    max_aoe = 48,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_effect",
    effect_data = "controlled",
    targeted_monsters = { "mon_blob_small", "mon_blob", "mon_blob_large" },
    extra_spells = { { spell = "death_blobsplit_brain", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion",
    name = ccb.content.text_without_extraction("Death Explosion Sound"),
    description = ccb.content.text_without_extraction("Boom."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
    min_damage = 24,
    max_damage = 24,
    sound_id = "explosion",
    sound_type = "combat",
    sound_variant = "small",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_gas",
    name = ccb.content.text_without_extraction("Gas Explosion"),
    description = ccb.content.text_without_extraction("Causes a small explosion of toxic gas."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_toxic_blast",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_smokeburst",
    name = ccb.content.text_without_extraction("Smoke Explosion"),
    description = ccb.content.text_without_extraction("Causes a small explosion of smoke."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_smoke_blast",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_smokeburst_tiny",
    name = ccb.content.text_without_extraction("Tiny Smoke Explosion"),
    description = ccb.content.text_without_extraction("Causes a tiny explosion of smoke."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_smoke_plume",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_tearburst",
    name = ccb.content.text_without_extraction("Teargas Explosion"),
    description = ccb.content.text_without_extraction("Causes a small explosion of teargas."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_tear_gas_blast",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_relax_gas",
    name = ccb.content.text_without_extraction("Relaxation Gas Explosion"),
    description = ccb.content.text_without_extraction("Causes a small explosion of relaxation gas."),
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_relax_gas_blast",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
-- TODO: Add the ability to check if there's anti-fungal gas here to negate this effect.
ccb.content.define_spell {
    id = "death_fungalburst",
    name = ccb.content.text_without_extraction("Fungal Explosion"),
    description = ccb.content.text_without_extraction("Causes a small explosion of fungus."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "emit",
    effect_data = "emit_fungal_blast",
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_pouf",
    name = ccb.content.text_without_extraction("Death Pouf Sound"),
    description = ccb.content.text_without_extraction("Pouf."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX" },
    effect = "noise",
    min_damage = 10,
    max_damage = 10,
    shape = "blast",
    sound_id = "misc",
    sound_variant = "puff",
    sound_type = "combat",
    message = ccb.content.text("Pouf!"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_fungus",
    name = ccb.content.text_without_extraction("Pouf"),
    description = ccb.content.text_without_extraction("Fungal pouf."),
    valid_targets = { "ground", "self" },
    effect = "fungalize",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 2500,
    max_damage = 2500,
    min_aoe = 1,
    max_aoe = 1,
    shape = "blast",
    extra_spells = { { spell = "death_pouf", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_darkman",
    name = ccb.content.text_without_extraction("Darkman Death"),
    description = ccb.content.text_without_extraction("Removes the darkness effect."),
    valid_targets = { "ally", "hostile" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_range = 48,
    max_range = 48,
    shape = "blast",
    effect = "remove_effect",
    effect_data = "darkness",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_fakespell",
    name = ccb.content.text_without_extraction("Fake Spell"),
    description = ccb.content.text_without_extraction("A spell that doesn't do anything."),
    valid_targets = { "hostile", "ally", "ground" },
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    min_damage = 1,
    max_damage = 1,
    effect = "noise",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_shock_blast",
    name = ccb.content.text_without_extraction("Shock Death"),
    description = ccb.content.text_without_extraction("1/5 chance to burst into electric clouds."),
    valid_targets = { "ally", "ground", "hostile" },
    flags = { "WONDER" },
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    shape = "blast",
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "shock_blast", self = true, min_level = 2 },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_fireball",
    name = ccb.content.text_without_extraction("Fireball Death"),
    description = ccb.content.text_without_extraction("1/10 chance to burst into flames."),
    valid_targets = { "ally", "ground", "hostile" },
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    effect = "noise",
    min_damage = 1,
    max_damage = 1,
    shape = "blast",
    extra_spells = {
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_fakespell" },
        { spell = "death_conflagration", self = true },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_conflagration",
    name = ccb.content.text_without_extraction("Conflagration Death"),
    description = ccb.content.text_without_extraction("A fireball.  Hits with mild shrapnel, but the main effect is fire."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    effect = "attack",
    field = "fd_fire",
    field_chance = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
    min_aoe = 3,
    max_aoe = 3,
    min_damage = 2,
    max_damage = 2,
    min_duration = 1000,
    max_duration = 1000,
    damage_type = "cut",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion_mon_spider_jumping_mega",
    name = ccb.content.text_without_extraction("Death Explosion - Huge"),
    description = ccb.content.text_without_extraction("Big boom."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    effect = "explosion",
    min_aoe = 8,
    max_aoe = 8,
    min_damage = 26,
    max_damage = 26,
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion_mon_spawn_raptor_unstable",
    name = ccb.content.text_without_extraction("Death Explosion - Tiny"),
    description = ccb.content.text_without_extraction("Tiny boom."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    min_aoe = 8,
    max_aoe = 8,
    min_damage = 4,
    max_damage = 4,
    effect = "explosion",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_explosion_mon_hazmatbot",
    name = ccb.content.text_without_extraction("Death Explosion - Large"),
    description = ccb.content.text_without_extraction("Large boom."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    min_aoe = 8,
    max_aoe = 8,
    min_damage = 20,
    max_damage = 20,
    effect = "explosion",
    shape = "blast",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_thing",
    name = ccb.content.text_without_extraction("Thing Death"),
    description = ccb.content.text_without_extraction("Spawns a thing."),
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 1,
    flags = { "SILENT", "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_thing",
    min_aoe = 1,
    max_aoe = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_preg_roach",
    name = ccb.content.text_without_extraction("Pregnant Roach Death"),
    description = ccb.content.text_without_extraction("Spawns roach nymph."),
    valid_targets = { "ground", "self" },
    min_damage = 1,
    max_damage = 3,
    flags = { "RANDOM_DAMAGE", "HOSTILE_SUMMON", "PERMANENT", "SPAWN_WITH_DEATH_DROPS", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_giant_cockroach_nymph",
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_spider_cellar_mom",
    name = ccb.content.text_without_extraction("Mommy Long Legs Death"),
    description = ccb.content.text_without_extraction("Spawns a bunch of small spiders."),
    valid_targets = { "self", "ground" },
    min_damage = 3,
    max_damage = 8,
    flags = {
        "RANDOM_DAMAGE",
        "HOSTILE_SUMMON",
        "PERMANENT",
        "SPAWN_WITH_DEATH_DROPS",
        "SILENT",
        "NO_EXPLOSION_SFX",
        "SPAWN_GROUP",
    },
    shape = "blast",
    effect = "summon",
    effect_data = "GROUP_SPIDER_MOM_SUMMON",
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_boomer",
    name = ccb.content.text_without_extraction("Boomer Death"),
    description = ccb.content.text_without_extraction("Vomitous explosion."),
    valid_targets = { "ground", "hostile", "ally", "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    max_level = 1,
    min_duration = 2400,
    max_duration = 2400,
    shape = "blast",
    effect = "attack",
    effect_data = "boomered",
    field_chance = 1,
    field = "fd_bile",
    max_field_intensity = 2,
    min_field_intensity = 2,
    affected_bodyparts = { "eyes" },
    extra_spells = { { spell = "death_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_boomer_glow",
    name = ccb.content.text_without_extraction("Boomer Death - Glow"),
    description = ccb.content.text_without_extraction("Boomers and glow."),
    valid_targets = { "ground", "hostile", "ally", "self" },
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "glowing",
    max_level = 1,
    affected_bodyparts = { "torso", "arm_r", "arm_l", "leg_r", "leg_l" },
    extra_spells = { { spell = "death_boomer", self = true } },
    min_duration = 24000,
    max_duration = 24000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ratking_summon_rats",
    name = ccb.content.text_without_extraction("Death Summon Rats"),
    description = ccb.content.text_without_extraction("Makes some rats."),
    valid_targets = { "ground" },
    shape = "blast",
    effect = "summon",
    effect_data = "mon_sewer_rat",
    flags = { "HOSTILE_SUMMON", "PERMANENT", "SPAWN_WITH_DEATH_DROPS", "NO_EXPLOSION_SFX" },
    min_damage = 7,
    max_damage = 7,
    min_aoe = 3,
    max_aoe = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_focused_beam_explosion",
    name = ccb.content.text_without_extraction("Focused Beam Explosion Death"),
    description = ccb.content.text_without_extraction("Give 'em the old flim flam flummox."),
    valid_targets = { "self" },
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    effect = "explosion",
    min_damage = 8,
    max_damage = 8,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_focused_beam",
    name = ccb.content.text_without_extraction("Focused Beam Death"),
    description = ccb.content.text_without_extraction("Give 'em the old razzle dazzle."),
    valid_targets = { "hostile", "ally", "ground" },
    effect = "attack",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX", "RANDOM_AOE" },
    field = "fd_dazzling",
    min_aoe = 1,
    max_aoe = 2,
    field_chance = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
    min_range = 2,
    max_range = 2,
    extra_spells = { { spell = "death_focused_beam_explosion", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_kill_vines",
    name = ccb.content.text_without_extraction("Kill Vines Death"),
    description = ccb.content.text_without_extraction("Kill all vines."),
    valid_targets = { "hostile", "ally" },
    effect = "attack",
    shape = "blast",
    targeted_monsters = { "mon_creeper_vine" },
    damage_type = "pure",
    min_damage = 1000,
    max_damage = 1000,
    min_aoe = 1,
    max_aoe = 48,
    aoe_increment = 48,
    max_level = 1,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_kill_breathers",
    name = ccb.content.text_without_extraction("Kill Breathers Death"),
    description = ccb.content.text_without_extraction("Kill all breathers."),
    valid_targets = { "hostile", "ally" },
    effect = "attack",
    shape = "blast",
    targeted_monsters = {
        "mon_breather",
        "mon_breather_hub",
        "mon_amalgamation_breather",
        "mon_amalgamation_breather_hub",
    },
    damage_type = "pure",
    min_damage = 1000,
    max_damage = 1000,
    min_aoe = 5,
    max_aoe = 5,
    aoe_increment = 5,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_gameover",
    name = ccb.content.text_without_extraction("Gameover Death"),
    description = ccb.content.text_without_extraction("You Died."),
    message = ccb.content.text("Game over, man!"),
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_damage = 1000,
    max_damage = 1000,
    min_aoe = 48,
    max_aoe = 48,
    damage_type = "pure",
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "hostile" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_triffid_heart",
    name = ccb.content.text_without_extraction("Triffid Heart Death"),
    description = ccb.content.text_without_extraction("Kills roots."),
    effect = "timed_event",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_duration = 60000,
    max_duration = 60000,
    min_range = 48,
    max_range = 48,
    effect_data = "ROOTS_DIE",
    shape = "blast",
    valid_targets = { "ally", "hostile" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_yrax_sphenocorona",
    name = ccb.content.text_without_extraction("Sphenocorona Death?"),
    description = ccb.content.text_without_extraction("Spawns a golden monolith."),
    flags = { "HOSTILE_SUMMON", "PERMANENT", "NO_EXPLOSION_SFX", "SILENT", "NO_PROJECTILE" },
    valid_targets = { "ground", "self" },
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    min_range = 0,
    max_range = 0,
    min_aoe = 1,
    max_aoe = 1,
    base_casting_time = 1,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_golden_monolith",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_slimespring",
    name = ccb.content.text_without_extraction("Slime Microbian Death"),
    description = ccb.content.text_without_extraction("Slime microbian dies."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "guilt",
    effect_data = "MUTANT",
    min_damage = 100,
    max_damage = 100,
    min_duration = 180000,
    max_duration = 180000,
    min_range = 5,
    max_range = 5,
    extra_spells = { { spell = "death_acid", self = true } },
}
