local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_quake",
    name = ccb.content.text_without_extraction("Artifact Earthquake"),
    description = ccb.content.text_without_extraction("Cause a localized earthquake, knocking down enemies and overturning the earth."),
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "IGNORE_WALLS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    effect_data = "downed",
    damage_type = "bash",
    min_damage = 160,
    max_damage = 224,
    min_aoe = 35,
    max_aoe = 35,
    min_duration = 500,
    max_duration = 1300,
    message = ccb.content.text("The earth around you rumbles, and in an instant everything seems to be upside down."),
    sound_description = ccb.content.text("a deep rumbling"),
    sound_id = "earth_spell",
    sound_variant = "strong",
    extra_spells = { { spell = "XE_quake_transform" }, { spell = "XE_quake_shake" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XE_quake_shake",
    name = ccb.content.text_without_extraction("Artifact Quake Earthquake"),
    description = ccb.content.text_without_extraction("Destroy furniture and terrain nearby."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS", "RANDOM_DAMAGE" },
    effect = "bash",
    shape = "blast",
    min_damage = 120,
    max_damage = 350,
    min_aoe = 35,
    max_aoe = 35,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XE_quake_transform",
    name = ccb.content.text_without_extraction("Artifact Quake Transform"),
    description = ccb.content.text_without_extraction("Causes rubble to be spawned occasionally."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS" },
    effect = "ter_transform",
    effect_data = "quake_transform",
    shape = "blast",
    min_damage = 150,
    max_damage = 150,
    min_aoe = 35,
    max_aoe = 35,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_teleport_rand",
    name = ccb.content.text_without_extraction("Artifact Teleport"),
    description = ccb.content.text_without_extraction("Teleport the caster to a random point nearby."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "ground" },
    flags = { "IGNORE_WALLS", "NO_LEGS", "SILENT", "RANDOM_TARGET" },
    message = ccb.content.text("It's not like you were teleported somewhere else, rather the whole world has shifted around you, and you are left in the same place."),
    sound_description = "",
    min_aoe = 20,
    max_aoe = 20,
    min_range = 40,
    max_range = 40,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_kill_spell",
    name = ccb.content.text_without_extraction("Artifact Kill"),
    description = ccb.content.text_without_extraction("Deal damage equal to 1000% of monster's HP."),
    valid_targets = { "hostile" },
    message = ccb.content.text("Something living nearby just exploded in a fountain of gore."),
    sound_description = "",
    min_damage = 1000,
    max_damage = 1000,
    min_range = 20,
    max_range = 20,
    effect = "attack",
    shape = "blast",
    damage_type = "pure",
    flags = { "SILENT", "PERCENTAGE_DAMAGE", "RANDOM_TARGET" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_heal",
    name = ccb.content.text_without_extraction("Artifact Heal"),
    description = ccb.content.text_without_extraction("Will heal injuries all over your body."),
    valid_targets = { "self" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX", "SILENT" },
    shape = "blast",
    base_casting_time = 100,
    min_damage = -30,
    max_damage = -30,
    message = ccb.content.text("Your flesh quickly rots and regenerates like in timelapse."),
    sound_description = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_pain",
    name = ccb.content.text_without_extraction("Artifact Pain"),
    description = ccb.content.text_without_extraction("Decrease some pain."),
    valid_targets = { "self" },
    effect = "recover_energy",
    effect_data = "PAIN",
    shape = "blast",
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
    min_damage = 150,
    max_damage = 150,
    message = ccb.content.text("All your feelings numb for a second, and all pain is gone now."),
    sound_description = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_stamina",
    name = ccb.content.text_without_extraction("Artifact Stamina"),
    description = ccb.content.text_without_extraction("Restore some stamina."),
    min_damage = 4000,
    max_damage = 6000,
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
    message = ccb.content.text("The energy streams into your muscles, and you feel you can run a marathon right now."),
    sound_description = "",
    shape = "blast",
    effect = "recover_energy",
    effect_data = "STAMINA",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_mana",
    name = ccb.content.text_without_extraction("Artifact Mana"),
    description = ccb.content.text_without_extraction("Restore some mana."),
    min_damage = 1000,
    max_damage = 2000,
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SILENT" },
    message = ccb.content.text("You feel your body become energized, and you are ready to change the world."),
    sound_description = "",
    shape = "blast",
    effect = "recover_energy",
    effect_data = "MANA",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_map",
    effect = "map",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact Map"),
    description = ccb.content.text_without_extraction("Reveals an area around you on the overmap."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "RANDOM_DAMAGE", "SILENT" },
    min_aoe = 40,
    max_aoe = 70,
    message = ccb.content.text("You feel like you know this place."),
    sound_description = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_str",
    name = ccb.content.text_without_extraction("Artifact Strength Boost"),
    description = ccb.content.text_without_extraction("Grant you powerful damage boost for 2 minutes."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    effect = "attack",
    shape = "blast",
    effect_data = "xe_str",
    min_duration = 12000,
    max_duration = 12000,
    sound_description = "",
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_int",
    name = ccb.content.text_without_extraction("Artifact Intelligence Boost"),
    description = ccb.content.text_without_extraction("Grant you huge int bonus for 1-2 hours."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "xe_int",
    min_duration = 360000,
    max_duration = 720000,
    sound_description = "",
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_electric_sight",
    name = ccb.content.text_without_extraction("Artifact Electric Sight"),
    description = ccb.content.text_without_extraction("Gives you an ability to see electric creatures for a whole week."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "xe_sight_elec",
    min_duration = 60480000,
    max_duration = 60480000,
    sound_description = "",
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_incorporeal",
    name = ccb.content.text_without_extraction("Artifact Incorporeal"),
    description = ccb.content.text_without_extraction("Gives incorporeal effect for 0,5-1 hour."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "incorporeal",
    min_duration = 180000,
    max_duration = 360000,
    sound_description = "",
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_line",
    name = ccb.content.text_without_extraction("Artifact Line"),
    description = ccb.content.text_without_extraction("Create a line of pure destruction."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "RANDOM_DAMAGE", "IGNORE_WALLS", "RANDOM_DURATION", "RANDOM_TARGET", "RANDOM_CRITTER" },
    effect = "attack",
    shape = "line",
    damage_type = "bash",
    min_range = 40,
    max_range = 40,
    min_damage = 160,
    max_damage = 224,
    min_aoe = 7,
    max_aoe = 7,
    message = ccb.content.text("Silently, a part of the world nearby just disappears."),
    sound_description = "",
    extra_spells = {
        { spell = "XE_line_bash" },
        { spell = "XE_line_bash" },
        { spell = "XE_line_bash" },
        { spell = "XE_line_bash" },
        { spell = "XE_line_bash" },
        { spell = "XE_line_bash" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XE_line_bash",
    name = ccb.content.text_without_extraction("Artifact Line Bash"),
    description = ccb.content.text_without_extraction("Destroy furniture and terrain nearby."),
    valid_targets = { "hostile", "ground" },
    flags = { "SILENT", "NO_EXPLOSION_SFX", "IGNORE_WALLS", "RANDOM_DAMAGE" },
    effect = "bash",
    shape = "line",
    min_damage = 120,
    max_damage = 350,
    min_aoe = 7,
    max_aoe = 7,
    min_range = 40,
    max_range = 40,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_hologram_summon",
    name = ccb.content.text_without_extraction("Artifact Hologram Summon"),
    description = ccb.content.text_without_extraction("Summon a lot of holograms around you, for 0,5 - 1 h."),
    valid_targets = { "ground" },
    flags = { "SILENT", "RANDOM_DAMAGE", "IGNORE_WALLS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_you",
    shape = "blast",
    damage_type = "bash",
    message = ccb.content.text("It is you.  And this is you.  And that is you.  You are everywhere."),
    sound_description = "",
    min_damage = 14,
    max_damage = 38,
    min_aoe = 26,
    max_aoe = 26,
    min_duration = 180000,
    max_duration = 360000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_electric_emit",
    name = ccb.content.text_without_extraction("Artifact Electric Emitter"),
    description = ccb.content.text_without_extraction("Emit giant electric clout for 5 - 15 m."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "xaea_electric_emit",
    min_duration = 30000,
    max_duration = 90000,
    sound_description = "",
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "XAEA_motion_vision",
    name = ccb.content.text_without_extraction("Artifact Super Senses"),
    description = ccb.content.text_without_extraction("You can feel any monster in range for a 0,5 - 2 h."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT", "RANDOM_DURATION" },
    effect = "attack",
    shape = "blast",
    effect_data = "xe_motion_vision",
    min_duration = 180000,
    max_duration = 720000,
    sound_description = "",
    message = "",
}

ccb.content.define_spell {
    id = "XAEA_mod_moves",
    shape = "blast",
    effect = "mod_moves",
    damage_type = "bash",
    name = ccb.content.text_without_extraction("Artifact Add Moves"),
    description = ccb.content.text_without_extraction("Gives roughly 15-25 seconds of free actions.  Inverse to current speed compared to 100."),
    message = "The world around you silently stops.",
    sound_description = "",
    flags = { "SILENT", "RANDOM_DAMAGE", "IGNORE_WALLS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_214", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_215", fallback = 0 },
}
