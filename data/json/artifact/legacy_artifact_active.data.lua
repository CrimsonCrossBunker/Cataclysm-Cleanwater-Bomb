local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- duration is randomly selected from the below values
ccb.content.define_spell {
    id = "AEA_ADRENALINE",
    name = ccb.content.text_without_extraction("Artifact Adrenaline"),
    description = ccb.content.text_without_extraction("Causes a surge of adrenaline to flow throughout your body."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "adrenaline",
    shape = "blast",
    base_casting_time = 100,
    flags = { "RANDOM_DURATION", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_duration = 120000,
    max_duration = 150000,
    message = ccb.content.text("You're filled with a roaring energy!"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_BLOOD",
    name = ccb.content.text_without_extraction("Artifact Blood"),
    description = ccb.content.text_without_extraction("Causes blood to leak from nearby terrain."),
    valid_targets = { "ground", "self", "hostile", "ally" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    base_casting_time = 100,
    min_aoe = 4,
    max_aoe = 4,
    field = "fd_blood",
    field_chance = 4,
    min_field_intensity = 3,
    max_field_intensity = 3,
    message = ccb.content.text("Blood soaks out of the ground and walls."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_HEAL",
    name = ccb.content.text_without_extraction("Artifact Heal"),
    description = ccb.content.text_without_extraction("Will heal injuries all over your body."),
    valid_targets = { "self" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    base_casting_time = 100,
    min_damage = -2,
    max_damage = -2,
    message = ccb.content.text("You feel healed."),
}

-- NO_I18N
-- NO_I18N
-- duration is randomly selected from the below values
ccb.content.define_spell {
    id = "AEA_CONFUSED",
    name = ccb.content.text_without_extraction("Artifact Confused"),
    description = ccb.content.text_without_extraction("Causes nearby enemies to become confused."),
    valid_targets = { "hostile" },
    effect = "attack",
    effect_data = "stunned",
    message = "",
    shape = "blast",
    base_casting_time = 100,
    min_aoe = 8,
    max_aoe = 8,
    flags = { "RANDOM_DURATION", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_duration = 500,
    max_duration = 1500,
}

-- NO_I18N
-- NO_I18N
-- Damage is randomly selected from the below values
ccb.content.define_spell {
    id = "AEA_PAIN",
    name = ccb.content.text_without_extraction("Artifact Pain"),
    description = ccb.content.text_without_extraction("Owchie, that hurts."),
    valid_targets = { "self" },
    effect = "recover_energy",
    effect_data = "PAIN",
    shape = "blast",
    base_casting_time = 100,
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = -5,
    max_damage = -15,
    message = ccb.content.text("You're wracked with pain!"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_TELEPORT",
    name = ccb.content.text_without_extraction("Artifact Teleport"),
    description = ccb.content.text_without_extraction("Randomly teleports you a short distance."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "NO_HANDS", "SILENT", "NO_LEGS", "UNSAFE_TELEPORT", "NO_EXPLOSION_SFX" },
    min_range = 2,
    max_range = 12,
    message = ccb.content.text("You teleport!"),
}

-- NO_I18N
-- NO_I18N
-- duration is randomly selected from the below values
ccb.content.define_spell {
    id = "AEA_ATTENTION",
    name = ccb.content.text_without_extraction("Artifact Attention"),
    description = ccb.content.text_without_extraction("You're not quite sure what you did, but something is watching you for it."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "attention",
    shape = "blast",
    base_casting_time = 100,
    flags = { "RANDOM_DURATION", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_duration = 360000,
    max_duration = 1080000,
    message = ccb.content.text("You feel like your action has attracted attention."),
}

-- NO_I18N
-- NO_I18N
-- duration is randomly selected from the below values
ccb.content.define_spell {
    id = "AEA_TELEGLOW",
    name = ccb.content.text_without_extraction("Artifact Teleglow"),
    description = ccb.content.text_without_extraction("DO YOU HEAR THE VOICES TOO?"),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "teleglow",
    shape = "blast",
    base_casting_time = 100,
    flags = { "RANDOM_DURATION", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_duration = 180000,
    max_duration = 720000,
    message = ccb.content.text("You feel unhinged."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_VOMIT",
    name = ccb.content.text_without_extraction("Artifact Vomit"),
    description = ccb.content.text_without_extraction("Causes the caster to vomit."),
    valid_targets = { "self" },
    effect = "vomit",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    message = ccb.content.text("A wave of nausea passes through you!"),
}

-- NO_I18N
-- NO_I18N
-- duration is only because the shadow needs to disappear upon death
ccb.content.define_spell {
    id = "AEA_SHADOWS",
    name = ccb.content.text_without_extraction("Artifact Shadows"),
    description = ccb.content.text_without_extraction("Summons shadows."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_shadow",
    shape = "blast",
    base_casting_time = 100,
    message = ccb.content.text("Shadows form around you."),
    min_damage = 2,
    max_damage = 4,
    min_aoe = 5,
    max_aoe = 5,
    min_duration = 8640000,
    max_duration = 8640000,
    flags = { "RANDOM_DAMAGE", "HOSTILE_SUMMON", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_STAMINA_EMPTY",
    name = ccb.content.text_without_extraction("Artifact Stamina Empty"),
    description = ccb.content.text_without_extraction("Does a variable amount of stamina damage."),
    min_damage = -1500,
    max_damage = -5500,
    base_casting_time = 100,
    valid_targets = { "self" },
    flags = { "RANDOM_DAMAGE", "NO_EXPLOSION_SFX" },
    message = ccb.content.text("Your body feels like jelly."),
    shape = "blast",
    effect = "recover_energy",
    effect_data = "STAMINA",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_RADIATION",
    name = ccb.content.text_without_extraction("Artifact Radiation"),
    description = ccb.content.text_without_extraction("Causes radiation."),
    message = ccb.content.text("Horrible gases are emitted!"),
    valid_targets = { "self", "ground" },
    effect = "attack",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    field = "fd_nuke_gas",
    min_aoe = 2,
    max_aoe = 2,
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_HURTALL",
    name = ccb.content.text_without_extraction("Artifact Hurtall"),
    description = ccb.content.text_without_extraction("Hurts all monsters within your view distance."),
    message = "",
    min_damage = 0,
    max_damage = 5,
    min_aoe = 40,
    max_aoe = 40,
    damage_type = "pure",
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE", "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_ACIDBALL",
    name = ccb.content.text_without_extraction("Artifact Acidball"),
    description = ccb.content.text_without_extraction("Fires an acidball."),
    effect = "attack",
    shape = "blast",
    message = "",
    min_range = 40,
    max_range = 40,
    min_aoe = 1,
    max_aoe = 1,
    damage_type = "acid",
    field = "fd_acid",
    min_field_intensity = 2,
    max_field_intensity = 2,
    valid_targets = { "self", "hostile", "ally", "ground" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    field_chance = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "art_eff_pet",
    name = ccb.content.text_without_extraction("Pet"),
    description = ccb.content.text_without_extraction("Makes the target a pet."),
    valid_targets = { "ally", "hostile" },
    effect = "attack",
    effect_data = "pet",
    shape = "blast",
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 100,
    max_duration = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "art_flies_buzz",
    name = ccb.content.text_without_extraction("Artifact Flies Buzz"),
    description = ccb.content.text_without_extraction("Flies buzz around you."),
    valid_targets = { "self", "ground" },
    message = ccb.content.text("Flies buzz around you."),
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "art_summon_flies",
    name = ccb.content.text_without_extraction("Artifact Summon Flies"),
    description = ccb.content.text_without_extraction("Summons some flies."),
    valid_targets = { "ground" },
    message = ccb.content.text("Giant flies appear!"),
    effect = "summon",
    effect_data = "mon_fly",
    shape = "blast",
    min_damage = 2,
    max_damage = 4,
    min_aoe = 2,
    max_aoe = 2,
    extra_spells = { { spell = "art_eff_pet" } },
    flags = { "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "art_summon_bees",
    name = ccb.content.text_without_extraction("Artifact Summon Bees"),
    description = ccb.content.text_without_extraction("Giant bees appear!"),
    valid_targets = { "ground" },
    message = ccb.content.text("Giant bees appear!"),
    effect = "summon",
    effect_data = "mon_bee",
    shape = "blast",
    min_damage = 1,
    max_damage = 3,
    min_aoe = 2,
    max_aoe = 2,
    extra_spells = { { spell = "art_eff_pet" } },
    flags = { "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "art_summon_wasps",
    name = ccb.content.text_without_extraction("Artifact Summon Wasps"),
    description = ccb.content.text_without_extraction("Summons some wasps."),
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 2,
    flags = { "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    effect = "summon",
    effect_data = "mon_wasp",
    shape = "blast",
    min_aoe = 2,
    max_aoe = 2,
    extra_spells = { { spell = "art_eff_pet" } },
    message = ccb.content.text("Giant wasps appear!"),
}

-- NO_I18N
-- NO_I18N
-- This is a shell for the spell that actually gets cast.
ccb.content.define_spell {
    id = "AEA_BUGS",
    name = ccb.content.text_without_extraction("Artifact Bugs"),
    description = ccb.content.text_without_extraction("Summons some bugs."),
    valid_targets = { "ground", "self" },
    effect = "none",
    shape = "blast",
    base_casting_time = 100,
    flags = { "WONDER", "NO_EXPLOSION_SFX" },
    min_damage = 1,
    max_damage = 1,
    message = "",
    extra_spells = {
        { spell = "art_flies_buzz" },
        { spell = "art_flies_buzz" },
        { spell = "art_flies_buzz" },
        { spell = "art_flies_buzz" },
        { spell = "art_summon_flies" },
        { spell = "art_summon_flies" },
        { spell = "art_summon_flies" },
        { spell = "art_summon_bees" },
        { spell = "art_summon_bees" },
        { spell = "art_summon_wasps" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_NOISE",
    name = ccb.content.text_without_extraction("Artifact Noise"),
    description = ccb.content.text_without_extraction("Makes a noise at your location."),
    message = ccb.content.text("You hear a deafening boom from your location!"),
    sound_description = ccb.content.text("a deafening boom"),
    sound_type = "combat",
    sound_ambient = true,
    sound_id = "misc",
    sound_variant = "shockwave",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 100,
    max_damage = 100,
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_LIGHT",
    name = ccb.content.text_without_extraction("Artifact Light"),
    description = ccb.content.text_without_extraction("Makes some light."),
    valid_targets = { "self" },
    effect = "timed_event",
    effect_data = "artifact_light",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 18000,
    max_duration = 18000,
    message = ccb.content.text("You glow brightly!"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_DIM",
    name = ccb.content.text_without_extraction("Artifact Dim"),
    description = ccb.content.text_without_extraction("Darkens the sky."),
    valid_targets = { "self" },
    effect = "timed_event",
    effect_data = "dim",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    min_duration = 30000,
    max_duration = 30000,
    message = ccb.content.text("The sky starts to dim."),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_SLEEPINESS",
    name = ccb.content.text_without_extraction("Artifact Dimensional Fatigue"),
    description = ccb.content.text_without_extraction("Creates some dimensional fatigue at a random point within range."),
    valid_targets = { "ground", "self", "ally", "hostile" },
    effect = "attack",
    message = "",
    shape = "blast",
    field = "fd_fatigue",
    field_chance = 1,
    min_field_intensity = 2,
    max_field_intensity = 2,
    field_intensity_variance = 0.5,
    min_range = 3,
    max_range = 3,
    flags = { "RANDOM_TARGET", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
}

-- Currently disabled from appearing on procgen artifacts as it always casts on the player's position.
-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_FIREBALL",
    name = ccb.content.text_without_extraction("Artifact Fireball"),
    description = ccb.content.text_without_extraction("Causes an explosion at the target."),
    valid_targets = { "hostile", "ground", "ally" },
    effect = "explosion",
    shape = "blast",
    base_casting_time = 100,
    min_damage = 180,
    max_damage = 180,
    min_aoe = 5,
    max_aoe = 5,
    message = "",
    min_range = 40,
    max_range = 40,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_FLASH",
    name = ccb.content.text_without_extraction("Artifact Flash"),
    description = ccb.content.text_without_extraction("Causes a flashbang at the target."),
    valid_targets = { "hostile", "ground", "self" },
    effect = "flashbang",
    shape = "blast",
    base_casting_time = 100,
    message = "",
    min_range = 40,
    max_range = 40,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_PARALYZE",
    name = ccb.content.text_without_extraction("Artifact Paralyze"),
    description = ccb.content.text_without_extraction("Paralyzes you for a second or two."),
    message = ccb.content.text("You're paralyzed!"),
    valid_targets = { "self" },
    min_damage = -50,
    max_damage = -200,
    effect = "mod_moves",
    shape = "blast",
    flags = { "RANDOM_DAMAGE", "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_MAP",
    effect = "map",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact Map"),
    description = ccb.content.text_without_extraction("Reveals an area around you on the overmap."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_aoe = 20,
    max_aoe = 20,
    message = ccb.content.text("You have a vision of the surrounding area…"),
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_FIRESTORM",
    name = ccb.content.text_without_extraction("Artifact Firestorm"),
    description = ccb.content.text_without_extraction("Calls a firestorm around you."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ground", "self", "ally", "hostile" },
    min_aoe = 3,
    max_aoe = 3,
    message = ccb.content.text("Fire rains down around you!"),
    field = "fd_fire",
    field_chance = 2,
    field_intensity_variance = 0.6,
    min_field_intensity = 2,
    max_field_intensity = 2,
    min_duration = 18000,
    max_duration = 18000,
    flags = { "LOUD", "NO_PROJECTILE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_FUN",
    name = ccb.content.text_without_extraction("Artifact Fun"),
    description = ccb.content.text_without_extraction("Makes you feel pretty good."),
    effect = "morale",
    effect_data = "morale_feeling_good",
    shape = "blast",
    message = ccb.content.text("You're filled with euphoria!"),
    min_damage = 20,
    max_damage = 50,
    valid_targets = { "self" },
    min_duration = 30000,
    max_duration = 30000,
    flags = { "RANDOM_DAMAGE", "SILENT", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_STORM_bolt",
    name = ccb.content.text_without_extraction("Bolt"),
    description = ccb.content.text_without_extraction("One of the bolts thrown by Artifact Storm."),
    effect = "attack",
    shape = "line",
    valid_targets = { "ground", "hostile", "ally" },
    sound_ambient = true,
    sound_description = ccb.content.text("Ka-BOOM!"),
    sound_id = "thunder_near",
    sound_variant = "environment",
    sound_type = "alarm",
    message = "",
    field = "fd_electricity",
    field_chance = 1,
    field_intensity_variance = 0.5,
    min_field_intensity = 2,
    max_field_intensity = 2,
    min_range = 12,
    max_range = 12,
    min_aoe = 2,
    max_aoe = 2,
    flags = { "RANDOM_TARGET", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_STORM",
    name = ccb.content.text_without_extraction("Artifact Storm"),
    description = ccb.content.text_without_extraction("Calls down a storm near you."),
    valid_targets = { "self" },
    message = "",
    effect = "attack",
    shape = "blast",
    min_damage = 2,
    max_damage = 4,
    flags = { "WONDER", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    extra_spells = { { spell = "AEA_STORM_bolt" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_SCREAM_morale",
    name = ccb.content.text_without_extraction("Morale Scream"),
    description = ccb.content.text_without_extraction("Morale effect from Artifact Scream."),
    effect = "morale",
    effect_data = "morale_scream",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = -10,
    max_damage = -10,
    min_duration = 180000,
    max_duration = 180000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_ENTRANCE",
    name = ccb.content.text_without_extraction("Artifact Entrance"),
    description = ccb.content.text_without_extraction("Entrances surrounding monsters."),
    effect = "charm_monster",
    shape = "blast",
    message = "",
    min_damage = 0,
    max_damage = 600,
    min_duration = 500,
    max_duration = 5000,
    min_aoe = 8,
    max_aoe = 8,
    valid_targets = { "self", "hostile" },
    flags = { "RANDOM_DAMAGE", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_SCREAM",
    name = ccb.content.text_without_extraction("Artifact Scream"),
    description = ccb.content.text_without_extraction("An ethereal scream."),
    message = "",
    effect = "noise",
    shape = "blast",
    sound_ambient = true,
    sound_id = "shout",
    sound_description = ccb.content.text("an ethereal scream"),
    sound_type = "alert",
    sound_variant = "scream",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 40,
    max_damage = 40,
    valid_targets = { "self" },
    extra_spells = { { spell = "AEA_SCREAM_morale" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_PULSE_bash_terrain",
    name = ccb.content.text_without_extraction("Bash Terrain"),
    description = ccb.content.text_without_extraction("Damages the terrain."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    effect = "bash",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 40,
    max_damage = 40,
    min_aoe = 2,
    max_aoe = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AEA_PULSE",
    name = ccb.content.text_without_extraction("Artifact Pulse"),
    description = ccb.content.text_without_extraction("Damages the terrain."),
    message = "",
    sound_description = ccb.content.text("the earth shaking!"),
    sound_id = "misc",
    sound_variant = "earthquake",
    sound_ambient = true,
    sound_type = "alarm",
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 30,
    max_damage = 30,
    effect = "noise",
    shape = "blast",
    extra_spells = {
        { spell = "AEA_PULSE_bash_terrain" },
        { spell = "AEA_PULSE_bash_terrain" },
        { spell = "AEA_PULSE_bash_terrain" },
    },
}
