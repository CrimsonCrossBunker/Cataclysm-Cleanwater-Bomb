local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_FRIENDLY_VORTEX",
    name = ccb.content.text_without_extraction("Artifact Vortex"),
    description = ccb.content.text_without_extraction("Summon vortexes."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_vortex",
    shape = "blast",
    base_casting_time = 100,
    message = ccb.content.text("Space twists and deforms around you."),
    min_damage = 1,
    max_damage = 3,
    min_aoe = 5,
    max_aoe = 5,
    flags = { "RANDOM_DAMAGE", "HOSTILE_50", "NO_EXPLOSION_SFX" },
    min_duration = 40000,
    max_duration = 40000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_CALL_OF_TINDALOS",
    name = ccb.content.text_without_extraction("Artifact Call of Tindalos"),
    description = ccb.content.text_without_extraction("Summon hostile hounds of Tindalos."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_hound_tindalos",
    shape = "blast",
    base_casting_time = 100,
    message = ccb.content.text("The world unravels into geometric shapes, and between the chaos you spot a horrid prowling beast."),
    min_damage = 1,
    max_damage = 1,
    min_aoe = 15,
    max_aoe = 15,
    min_duration = 40000,
    max_duration = 40000,
    flags = { "HOSTILE_SUMMON", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_FORCE_PULL",
    name = ccb.content.text_without_extraction("Artifact Force Pull"),
    description = ccb.content.text_without_extraction("Pull objects."),
    effect = "area_pull",
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground", "item", "field" },
    message = ccb.content.text("An unnatural implosion sends objects flying."),
    flags = { "NO_EXPLOSION_SFX" },
    min_range = 15,
    max_range = 15,
    min_aoe = 7,
    max_aoe = 7,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TELEPORTITIS",
    name = ccb.content.text_without_extraction("Artifact Teleportitis"),
    description = ccb.content.text_without_extraction("Causes you to teleport uncontrollably."),
    message = ccb.content.text("The world loses coherence, with images of nearby places forming and disappearing around you."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "artifact_teleportitis_aura",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 4000,
    max_duration = 4000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_SLOW",
    name = ccb.content.text_without_extraction("Artifact Slow"),
    description = ccb.content.text_without_extraction("Slows you for a few turns."),
    message = ccb.content.text("The world shifts blue, and reality accelerates around you."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "artifact_slow_aura",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 900,
    max_duration = 900,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TIME_STOP",
    name = ccb.content.text_without_extraction("Artifact Time Stop"),
    description = ccb.content.text_without_extraction("Grants you a few turns of super speed."),
    message = ccb.content.text("Stale golden light floods the world, and reality stands still."),
    valid_targets = { "self" },
    effect = "mod_moves",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 500,
    max_damage = 500,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_RESONANCE_BARRIER",
    name = ccb.content.text_without_extraction("Artifact resonance barrier"),
    description = ccb.content.text_without_extraction("Creates a low hp energy shield around you."),
    message = ccb.content.text("Your surroundings start shimmering."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "artifact_energy_shield",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 1200,
    max_duration = 1200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_BOOK_SNAP_PUSH",
    name = ccb.content.text_without_extraction("Grimorie Snap Push"),
    description = ccb.content.text_without_extraction("The push portion of the rock blast spell."),
    valid_targets = { "hostile", "ground", "ally", "item" },
    flags = { "RANDOM_DAMAGE", "SILENT" },
    effect = "area_push",
    shape = "blast",
    min_aoe = 4,
    max_aoe = 4,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_GOOD",
    name = ccb.content.text_without_extraction("Artifact fast reader"),
    description = ccb.content.text_without_extraction("Makes you a fast reader."),
    message = ccb.content.text("You don't understand the book yet, but you feel like you are making progress."),
    effect = "mutate",
    shape = "blast",
    effect_data = "FASTREADER",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_BAD",
    name = ccb.content.text_without_extraction("Artifact Nearsighted"),
    description = ccb.content.text_without_extraction("Makes you nearsighted."),
    message = ccb.content.text("Your eyes hurt after focusing on the strange tome."),
    effect = "mutate",
    shape = "blast",
    effect_data = "MYOPIC",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_READ_VERY_BAD",
    name = ccb.content.text_without_extraction("Artifact Illiterate"),
    description = ccb.content.text_without_extraction("Makes you illiterate."),
    message = ccb.content.text("You realize that staring at the scratches within is pointless, you don't know how to read."),
    effect = "mutate",
    shape = "blast",
    effect_data = "ILLITERATE",
    min_damage = 10000,
    max_damage = 10000,
    flags = { "SILENT", "MUTATE_TRAIT" },
    valid_targets = { "self", "ally" },
}

ccb.content.define_spell {
    id = "AO_BOOK_SNAP",
    sound_type = "combat",
    sound_id = "thunder_near",
    sound_variant = "environment",
    shape = "blast",
    effect = "attack",
    field = "fd_plasma",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Grimoire Snap"),
    description = ccb.content.text_without_extraction("Creates a shockwave that damages nearby enemies."),
    message = "The tome snaps shut with tremendous force.",
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
    valid_targets = { "hostile", "ally", "ground" },
    field_chance = 4,
    min_field_intensity = 1,
    max_field_intensity = 2,
    min_damage = { handler = "wave14a_dda_stat_1", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_2", fallback = 0 },
    min_aoe = 5,
    max_aoe = 5,
    extra_spells = {
        { spell = "AO_BOOK_SNAP_PUSH", self = true },
        { spell = "AO_BOOK_SNAP_PUSH", self = true },
    },
}

ccb.content.define_spell {
    id = "AO_SURFACE",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact surfacing"),
    description = ccb.content.text_without_extraction("Sends you to the surface."),
    message = "You reel as your sense of balance falters, but you didn't fall anywhere.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    max_range = 1,
    impact_handler = "w16b_sp_imp_dda_dc45c4be89fa",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_BOOK_BLAST",
    name = ccb.content.text_without_extraction("Book blast Attack"),
    description = ccb.content.text_without_extraction("A cone AOE cut damage attack."),
    message = ccb.content.text("Razor sharp pages shoot out from the book when you open it."),
    valid_targets = { "self" },
    extra_spells = { { spell = "AO_BOOK_BLAST_ATTACK" } },
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "AO_BOOK_FAR_TP",
    shape = "blast",
    name = ccb.content.text_without_extraction("Book far tp"),
    description = ccb.content.text_without_extraction("Teleports you to a distant location."),
    message = "You find the description of a distant place.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    impact_handler = "w16b_sp_imp_dda_19f00d256aea",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "MAGIC_CASCADE",
    name = ccb.content.text_without_extraction("Artifact magic cascade"),
    description = ccb.content.text_without_extraction("Fires bursts of low damage ranged attacks."),
    message = ccb.content.text("Burning ash whirls around you."),
    valid_targets = { "self" },
    extra_spells = {
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
    },
    effect = "attack",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "AO_BOOK_BLAST_ATTACK",
    shape = "cone",
    effect = "attack",
    damage_type = "cut",
    name = ccb.content.text_without_extraction("Book blast Attack"),
    description = ccb.content.text_without_extraction("A cone AOE cut damage attack."),
    message = "Razor sharp pages shoot out from the book when you open it.",
    flags = { "SILENT", "RANDOM_TARGET", "RANDOM_CRITTER", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    valid_targets = { "hostile", "ground", "ally" },
    min_damage = { handler = "wave14a_dda_stat_3", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_4", fallback = 0 },
    min_range = 10,
    max_range = 10,
    min_aoe = 15,
    max_aoe = 15,
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "AO_BOOK_COMBUSTION",
    shape = "blast",
    name = ccb.content.text_without_extraction("Book combustion"),
    description = ccb.content.text_without_extraction("Causes other nearby books to explode."),
    message = "The pages glint slightly as you flip through them.",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_dda_b31a4fb3e1d2",
}

ccb.content.define_spell {
    id = "AO_MAGIC_CASCADE_START",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact magic cascade"),
    description = ccb.content.text_without_extraction("Fires bursts of low damage ranged attacks."),
    message = "Burning ash whirls around you.",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_dda_0240443f212a",
}

ccb.content.define_spell {
    id = "MAGIC_CASCADE_MISSILE",
    shape = "blast",
    effect = "attack",
    field = "fd_plasma",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Magic cascade Missile"),
    description = ccb.content.text_without_extraction("A single attack from magic cascade."),
    message = "",
    flags = { "LOUD", "RANDOM_TARGET", "RANDOM_CRITTER", "RANDOM_DAMAGE" },
    valid_targets = { "hostile", "ally" },
    field_chance = 2,
    min_field_intensity = 3,
    max_field_intensity = 3,
    min_damage = { handler = "wave14a_dda_stat_5", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_6", fallback = 0 },
    min_range = 40,
    max_range = 6,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TRUESIGHT_EFFECT",
    name = ccb.content.text_without_extraction("Artifact Truesight"),
    description = ccb.content.text_without_extraction("Grants you the TRUE_SEEING flag."),
    message = ccb.content.text("You see movement in the corners of your vision."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_true_seeing",
    shape = "blast",
    min_duration = 6800,
    max_duration = 6800,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_DARKNESS_EFFECT",
    name = ccb.content.text_without_extraction("Artifact Darkness"),
    description = ccb.content.text_without_extraction("Grants you the Darkness effect."),
    message = ccb.content.text("Persistent shadows invade your field of view."),
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "darkness",
    shape = "blast",
    min_duration = 2400,
    max_duration = 2400,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_LIFE_DRAIN",
    name = ccb.content.text_without_extraction("Artifact Hurtall"),
    description = ccb.content.text_without_extraction("Hurts you for random damage."),
    message = ccb.content.text("You feel hollow inside."),
    min_damage = 0,
    max_damage = 10,
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_CLOSE_TEAR",
    name = ccb.content.text_without_extraction("Artifact Close Tear"),
    description = ccb.content.text_without_extraction("Closes a tear in reality and transfers strange energy to the artifact user."),
    message = "",
    min_aoe = 40,
    max_aoe = 40,
    valid_targets = { "field" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_field",
    effect_data = "fd_fatigue",
}

ccb.content.define_spell {
    id = "AO_SPATIAL_ANCHOR",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact anchor"),
    description = ccb.content.text_without_extraction("Return to the spot where you cast this spell after a random amount of time."),
    message = "You feel a deep sense of connection to this place.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    max_range = 1,
    impact_handler = "w16b_sp_imp_dda_e7276a100109",
}

ccb.content.define_spell {
    id = "AO_SPATIAL_ANCHOR_SLOW",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact anchor (SLOW)"),
    description = ccb.content.text_without_extraction("Return to the spot where you cast this spell after a random amount of time."),
    message = "You feel a deep sense of connection to this place.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    max_range = 1,
    impact_handler = "w16b_sp_imp_dda_3e3851b7d965",
}
