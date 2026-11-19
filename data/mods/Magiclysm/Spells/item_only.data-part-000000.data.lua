local ccb = require("ccb")

-- NO_I18N
-- Used for potion of Twisted Restoration, not castable
-- NO_I18N
ccb.content.define_spell {
    id = "twisted_restore",
    name = ccb.content.text_without_extraction("Twisted Restoration"),
    description = ccb.content.text_without_extraction("This spell overclocks your heart, generating new flesh and muscle.  It is unwise to use this in immediate danger, and may be fatal if done in critical condition."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_PROJECTILE" },
    max_level = 1,
    min_damage = 10,
    max_damage = 10,
    damage_increment = 0,
    damage_type = "poison",
    difficulty = 0,
    spell_class = "NONE",
    effect = "attack",
    shape = "blast",
    energy_source = "HP",
    base_casting_time = 30000,
    base_energy_cost = 2,
    extra_spells = {
        { spell = "light_healing" },
        { spell = "pain_damage" },
        { spell = "pain_damage" },
        { spell = "stamina_damage" },
        { spell = "stamina_damage" },
        { spell = "stamina_damage" },
    },
}

-- NO_I18N
-- Used for Animist-exclusive potion, not castable
-- NO_I18N
ccb.content.define_spell {
    id = "twisted_restore_improved",
    name = ccb.content.text_without_extraction("Improved Twisted Restoration"),
    description = ccb.content.text_without_extraction("This spell overclocks your heart, generating new flesh and muscle.  It is unwise to use this in immediate danger, and may be fatal if done in critical condition.  Improved brewing mitigates the strain of the spell."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_PROJECTILE" },
    max_level = 1,
    min_damage = 8,
    max_damage = 8,
    damage_increment = 0,
    damage_type = "poison",
    difficulty = 0,
    spell_class = "NONE",
    effect = "attack",
    shape = "blast",
    energy_source = "HP",
    base_casting_time = 12000,
    base_energy_cost = 2,
    extra_spells = {
        { spell = "light_healing" },
        { spell = "pain_damage" },
        { spell = "stamina_damage" },
        { spell = "stamina_damage" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_throwing_blade3",
    name = ccb.content.text_without_extraction("Conjure Throwing Blade I"),
    description = ccb.content.text_without_extraction("Conjures 3 throwing knives."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "throwing_knife",
    shape = "blast",
    message = ccb.content.text("You activate your ring and three throwing knives appear, ready to throw!"),
    spell_class = "NONE",
    max_level = 1,
    min_damage = 3,
    max_damage = 3,
    min_duration = 1500,
    max_duration = 1500,
    base_casting_time = 20,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_group",
    name = ccb.content.text_without_extraction("Conjure Random Magical Throwing Blade"),
    description = ccb.content.text_without_extraction("Conjures a magical throwing knife, one of the spells specified in extra effects."),
    valid_targets = { "self" },
    flags = { "WONDER" },
    effect = "none",
    message = "",
    shape = "blast",
    spell_class = "NONE",
    min_damage = 1,
    max_damage = 1,
    base_casting_time = 30,
    extra_spells = {
        { spell = "conj_mag_throw_blade_1" },
        { spell = "conj_mag_throw_blade_1" },
        { spell = "conj_mag_throw_blade_1" },
        { spell = "conj_mag_throw_blade_1" },
        { spell = "conj_mag_throw_blade_fire" },
        { spell = "conj_mag_throw_blade_fire" },
        { spell = "conj_mag_throw_blade_cold" },
        { spell = "conj_mag_throw_blade_cold" },
        { spell = "conj_mag_throw_blade_cut" },
        { spell = "conj_mag_throw_blade_cut" },
        { spell = "conj_mag_throw_blade_biological" },
        { spell = "conj_mag_throw_blade_biological" },
        { spell = "magical_throwing_knife_pure_special" },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_1",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade I"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife",
    shape = "blast",
    message = ccb.content.text("You activate your bag and a throwing knife appears, ready to throw!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 700,
    max_duration = 700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_fire",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade Fire"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife_fire",
    shape = "blast",
    message = ccb.content.text("You activate your bag and a throwing knife wrapped in ethereal flames appears, ready to throw!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 700,
    max_duration = 700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_cold",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade Cold"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife_cold",
    shape = "blast",
    message = ccb.content.text("You activate your bag and a throwing knife emanating cold appears, ready to throw!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 700,
    max_duration = 700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_cut",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade Cut"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife_cut",
    shape = "blast",
    message = ccb.content.text("You activate your bag and a throwing knife with unnaturally sharp edges appears, ready to throw!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 700,
    max_duration = 700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "conj_mag_throw_blade_biological",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade Biological"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife_biological",
    shape = "blast",
    message = ccb.content.text("You activate your bag and a throwing knife covered in dark ooze appears, ready to throw!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 700,
    max_duration = 700,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "magical_throwing_knife_pure_special",
    name = ccb.content.text_without_extraction("Conjure Magical Throwing Blade Pure"),
    description = ccb.content.text_without_extraction("Conjures 1 magical throwing knife."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "magical_throwing_knife_pure_special",
    shape = "blast",
    message = ccb.content.text("You activate your bag and with a flash magical energies coalescence in your hand into a shape of knife.  It seems vastly more powerful than other knives that appear from the bag!"),
    min_damage = 1,
    max_damage = 1,
    min_duration = 900000,
    max_duration = 900000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "potion_recover_mana",
    name = ccb.content.text_without_extraction("Recover Mana"),
    description = ccb.content.text_without_extraction("You regain mana."),
    valid_targets = { "self" },
    min_damage = 250,
    damage_increment = 50.0,
    max_damage = 2000,
    max_level = 35,
    effect = "recover_energy",
    effect_data = "MANA",
    shape = "blast",
    spell_class = "NONE",
    message = ccb.content.text("You start regenerating mana!"),
    energy_source = "MANA",
    base_energy_cost = 0,
    energy_increment = 0,
    final_energy_cost = 0,
    flags = { "SILENT", "NO_LEGS" },
    difficulty = 3,
}

-- NO_I18N
-- NO_I18N
-- Listed as a recover energy effect with a negative modifier that decreases with each level of the spell, which makes it cause damage instead.
ccb.content.define_spell {
    id = "mana_doping",
    name = ccb.content.text_without_extraction("Pain"),
    description = ccb.content.text_without_extraction("Increases pain."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
    min_damage = -25,
    max_damage = -225,
    damage_increment = -50.0,
    max_level = 10,
    effect = "recover_energy",
    effect_data = "PAIN",
    shape = "blast",
    spell_class = "NONE",
    message = ccb.content.text("Your veins feel like they are on fire!\nYou start regenerating mana!"),
    extra_spells = { { spell = "potion_recover_mana" } },
}

-- NO_I18N
-- Used for wolfshead cufflinks not castable
-- NO_I18N
ccb.content.define_spell {
    id = "lupercalia",
    name = ccb.content.text_without_extraction("Lupercalian Release"),
    description = ccb.content.text_without_extraction("This spell transforms you into a werewolf.  There may be some cons to this."),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_LEGS", "NO_HANDS" },
    effect = "spawn_item",
    effect_data = "aura_werewolf",
    shape = "blast",
    max_level = 1,
    min_damage = 1,
    max_damage = 1,
    damage_increment = 0,
    damage_type = "biological",
    difficulty = 0,
    spell_class = "NONE",
    base_casting_time = 300,
    base_energy_cost = 2,
    min_duration = 4320000,
    max_duration = 4320000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wolfsbane",
    name = ccb.content.text_without_extraction("Wolfsbane"),
    description = ccb.content.text_without_extraction("The tip of the spear glows white hot as you strike."),
    valid_targets = { "hostile" },
    flags = { "NO_HANDS", "NO_LEGS" },
    damage_type = "heat",
    min_damage = 35,
    min_range = 2,
    shape = "blast",
    effect = "attack",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mana_bolt_random",
    name = ccb.content.text_without_extraction("Mana Bolt"),
    description = ccb.content.text_without_extraction("Semi controlled mana rocket."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_TARGET", "RANDOM_DAMAGE", "SILENT" },
    effect = "attack",
    shape = "blast",
    min_damage = 60,
    max_damage = 90,
    damage_type = "nether",
    min_range = 7,
    max_range = 7,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "missile_volley",
    name = ccb.content.text_without_extraction("Missile volley"),
    description = ccb.content.text_without_extraction("Cast a swarm of mana bolts in random directions."),
    valid_targets = { "self" },
    flags = { "WONDER" },
    effect = "attack",
    shape = "blast",
    min_damage = 25,
    max_damage = 25,
    min_range = 0,
    max_range = 0,
    extra_spells = { { spell = "mana_bolt_random" } },
    energy_source = "MANA",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "gorgon_spell",
    name = ccb.content.text_without_extraction("Petrification"),
    description = ccb.content.text_without_extraction("Freeze!"),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_PROJECTILE", "IGNORE_WALLS" },
    effect = "mod_moves",
    shape = "cone",
    min_damage = -2200,
    max_damage = -2200,
    min_range = 9,
    max_range = 9,
    min_aoe = 120,
    max_aoe = 120,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "disorient_spell",
    name = ccb.content.text_without_extraction("Disorientation"),
    description = ccb.content.text_without_extraction("Mental sledgehammer strike."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_PROJECTILE", "IGNORE_WALLS" },
    effect = "attack",
    shape = "cone",
    effect_data = "stunned",
    damage_type = "psionic",
    min_range = 6,
    max_range = 6,
    min_aoe = 120,
    max_aoe = 120,
    min_duration = 1500,
    max_duration = 1500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "super_hot_spell",
    name = ccb.content.text_without_extraction("Propulsion"),
    description = ccb.content.text_without_extraction("Yep, you are fast."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "LOUD", "SOMATIC" },
    effect = "mod_moves",
    shape = "blast",
    min_damage = 2400,
    max_damage = 2400,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_clairvoyance",
    name = ccb.content.text_without_extraction("Omniscientia"),
    description = ccb.content.text_without_extraction("Connect the user to a few ethereal sensory organs, that allow the user to \"feel\" the territory nearby."),
    valid_targets = { "hostile", "ground" },
    flags = { "IGNORE_WALLS", "NO_LEGS", "SILENT", "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_aoe = 30,
    max_aoe = 30,
    field = "fd_clairvoyant",
    min_field_intensity = 1,
    max_field_intensity = 1,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_spear",
    name = ccb.content.text_without_extraction("Lancea"),
    description = ccb.content.text_without_extraction("Release a long, spear-like line of liquid, which punctures things on the path."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_LEGS", "SILENT", "RANDOM_DAMAGE" },
    min_aoe = 5,
    max_aoe = 5,
    effect = "attack",
    shape = "cone",
    min_damage = 150,
    max_damage = 250,
    damage_type = "stab",
    min_range = 15,
    max_range = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_confusion",
    name = ccb.content.text_without_extraction("Turbatio"),
    description = ccb.content.text_without_extraction("Mental sledgehammer strike."),
    valid_targets = { "hostile", "ground" },
    flags = { "NO_PROJECTILE", "IGNORE_WALLS" },
    effect = "attack",
    shape = "cone",
    effect_data = "stunned",
    min_range = 6,
    max_range = 6,
    min_aoe = 120,
    max_aoe = 120,
    min_duration = 1500,
    max_duration = 1500,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_teleport_rand",
    name = ccb.content.text_without_extraction("Effugium"),
    description = ccb.content.text_without_extraction("Teleport the caster to a random point nearby."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "ground" },
    flags = { "IGNORE_WALLS", "NO_LEGS", "SILENT", "RANDOM_TARGET" },
    min_aoe = 3,
    max_aoe = 3,
    min_range = 15,
    max_range = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_teleport",
    name = ccb.content.text_without_extraction("Ecfugium"),
    description = ccb.content.text_without_extraction("Teleport the caster to a selected point nearby."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "ground" },
    flags = { "IGNORE_WALLS", "NO_LEGS", "SILENT", "TARGET_TELEPORT" },
    min_aoe = 3,
    max_aoe = 3,
    min_range = 10,
    max_range = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_shadow_field",
    name = ccb.content.text_without_extraction("Umbra"),
    description = ccb.content.text_without_extraction("Shrouds the user in a field of darkness."),
    effect = "attack",
    field = "fd_darkness",
    min_field_intensity = 1,
    max_field_intensity = 1,
    shape = "blast",
    valid_targets = { "self", "ground" },
    min_duration = 36000,
    max_duration = 36000,
    min_range = 10,
    max_range = 10,
    min_aoe = 3,
    max_aoe = 3,
    flags = { "NO_LEGS", "SOMATIC", "CONCENTRATE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_fireball",
    name = ccb.content.text_without_extraction("Flamma"),
    description = ccb.content.text_without_extraction("Molotovs magic equivalent."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground" },
    flags = { "NO_LEGS", "SILENT", "RANDOM_DAMAGE", "IGNITE_FLAMMABLE", "SPLIT_DAMAGE" },
    min_damage = 68,
    max_damage = 88,
    min_aoe = 7,
    max_aoe = 7,
    min_range = 15,
    max_range = 15,
    field = "fd_fire",
    field_chance = 5,
    min_field_intensity = 1,
    max_field_intensity = 2,
    field_intensity_variance = 1,
    damage_type = "heat",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_invisibility",
    name = ccb.content.text_without_extraction("Caecitas"),
    description = ccb.content.text_without_extraction("You are invisible now, and no one can see you.  They still can hear or smell though."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "invisibility",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 36000,
    max_duration = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_feather",
    name = ccb.content.text_without_extraction("Pluma"),
    description = ccb.content.text_without_extraction("Allows you to decrease your inertia, which allows you to jump from the skyscraper's roof onto the pavement below, unharmed."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "feather_fall",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 36000,
    max_duration = 36000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_night_vision",
    name = ccb.content.text_without_extraction("Visio"),
    description = ccb.content.text_without_extraction("Grants you the ability to see in the dark."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "dark_sight",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 36000,
    max_duration = 36000,
}

-- NO_I18N
-- NO_I18N
-- now its 500 cause skeletal juggernaut has 480, but not sure isn't it too big?
ccb.content.define_spell {
    id = "flask_charm",
    name = ccb.content.text_without_extraction("Venuste"),
    description = ccb.content.text_without_extraction("Make a creature ignore their own thoughts and make them think more positively towards a user, temporarily turning them friendly."),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS" },
    effect = "charm_monster",
    shape = "blast",
    min_range = 9,
    max_range = 9,
    min_damage = 500,
    max_damage = 500,
    min_duration = 15000,
    max_duration = 15000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_sludge_field",
    name = ccb.content.text_without_extraction("Lutum"),
    description = ccb.content.text_without_extraction("Cover the ground with a thick, sticky mass."),
    effect = "attack",
    field = "fd_sludge",
    min_field_intensity = 1,
    max_field_intensity = 3,
    field_intensity_variance = 2,
    field_chance = 1,
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground" },
    min_duration = 180000,
    max_duration = 180000,
    min_range = 10,
    max_range = 10,
    min_aoe = 6,
    max_aoe = 6,
    flags = { "NO_LEGS", "SOMATIC", "CONCENTRATE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_speed",
    name = ccb.content.text_without_extraction("Velocitas"),
    description = ccb.content.text_without_extraction("Makes you faster for quite some time."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_speed_eff",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 360000,
    max_duration = 360000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_healing",
    name = ccb.content.text_without_extraction("Sanatio"),
    description = ccb.content.text_without_extraction("Makes you feel healthier."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_healing_eff",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 8640000,
    max_duration = 8640000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_stamina",
    name = ccb.content.text_without_extraction("Constantia"),
    description = ccb.content.text_without_extraction("You can't get tired."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_stamina_eff",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 1080000,
    max_duration = 1080000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_rebreather",
    name = ccb.content.text_without_extraction("Spiritus"),
    description = ccb.content.text_without_extraction("Allow you to breathe underwater."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "flask_ethereal_rebreather",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 360000,
    max_duration = 360000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_excitement",
    name = ccb.content.text_without_extraction("Motus"),
    description = ccb.content.text_without_extraction("Improve your reaction abilities, which makes you a better fighter."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_excitement",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 360000,
    max_duration = 360000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_resistance",
    name = ccb.content.text_without_extraction("Resistentia"),
    description = ccb.content.text_without_extraction("A thin layer of energy covers your body, and allows you to take more physical damage than before."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_resistance",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 1080000,
    max_duration = 1080000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_illumination",
    name = ccb.content.text_without_extraction("Illuminatio"),
    description = ccb.content.text_without_extraction("Emit a bright light from your body."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_illumination",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 4320000,
    max_duration = 4320000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_mana_regen",
    name = ccb.content.text_without_extraction("Recuperatio"),
    description = ccb.content.text_without_extraction("Increase the amount of ley-lines your body can process at once, making you restore your mana pool faster."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_mana_regen",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 4320000,
    max_duration = 4320000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_max_mana",
    name = ccb.content.text_without_extraction("Augere"),
    description = ccb.content.text_without_extraction("The capability to hold mana in you is increased - for a while."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_max_mana",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 4320000,
    max_duration = 4320000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_regeneration",
    name = ccb.content.text_without_extraction("Renovamen"),
    description = ccb.content.text_without_extraction("Slowly regenerate your damaged body."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "flask_regeneration",
    shape = "blast",
    flags = { "NO_LEGS", "SILENT" },
    min_duration = 60000,
    max_duration = 60000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_regeneration_effect",
    name = ccb.content.text_without_extraction("Renovamen Healing Effect"),
    description = ccb.content.text_without_extraction("Heals the target."),
    valid_targets = { "self" },
    min_damage = -1,
    max_damage = -1,
    effect = "attack",
    shape = "blast",
    message = ccb.content.text("You start regenerating!"),
    flags = { "SILENT" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_mood",
    name = ccb.content.text_without_extraction("Iocus"),
    description = ccb.content.text_without_extraction("Makes you fun."),
    effect = "morale",
    effect_data = "morale_iocus",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT", "RANDOM_DAMAGE", "RANDOM_DURATION" },
    min_damage = 50,
    max_damage = 80,
    min_duration = 8640000,
    max_duration = 25920000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_toxin",
    name = ccb.content.text_without_extraction("Toxicum"),
    description = ccb.content.text_without_extraction("Release a toxic gas which will poison everybody in range."),
    valid_targets = { "self", "ally", "hostile", "ground" },
    flags = { "NO_LEGS", "RANDOM_DURATION", "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "blast",
    min_dot = 1,
    max_dot = 1,
    min_aoe = 8,
    max_aoe = 8,
    field = "fd_toxic_gas",
    field_chance = 1,
    min_field_intensity = 1,
    max_field_intensity = 1,
    damage_type = "biological",
    min_duration = 2500,
    max_duration = 7500,
    min_range = 15,
    max_range = 15,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "flask_venom",
    name = ccb.content.text_without_extraction("Venenum"),
    description = ccb.content.text_without_extraction("Poison the targeted enemy."),
    min_dot = 5,
    max_dot = 5,
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "SILENT", "SPLIT_DAMAGE" },
    min_range = 15,
    max_range = 15,
    min_duration = 90000,
    max_duration = 90000,
    damage_type = "poison",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "alchemist_mine_pull",
    name = ccb.content.text_without_extraction("Mana explosion"),
    description = ccb.content.text_without_extraction("Pull all creatures nearby, except the Alchemist."),
    valid_targets = { "ally", "hostile", "ground", "item", "field" },
    effect = "area_pull",
    shape = "blast",
    max_level = 35,
    min_damage = 30,
    max_damage = 30,
    min_aoe = 11,
    max_aoe = 11,
    extra_spells = { { spell = "alchemist_mine_explosion" } },
    flags = { "LOUD" },
    sound_description = ccb.content.text("whoosh"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "alchemist_mine_explosion",
    name = ccb.content.text_without_extraction("Mana explosion damage"),
    description = ccb.content.text_without_extraction("Deal some damage to creatures, except the Alchemist."),
    valid_targets = { "ally", "hostile", "ground" },
    effect = "attack",
    shape = "blast",
    min_damage = 110,
    max_damage = 220,
    damage_type = "necrotic",
    min_aoe = 4,
    max_aoe = 4,
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_EXPLOSION_SFX", "SPLIT_DAMAGE" },
    message = "",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bramble_spear_slow",
    name = ccb.content.text_without_extraction("Bramble spear slow"),
    description = ccb.content.text_without_extraction("Sticky sap coats your enemies."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "mod_moves",
    min_damage = -25,
    max_damage = -75,
    min_range = 2,
    max_range = 2,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "druid_thorn_skin_attacked",
    name = ccb.content.text_without_extraction("Thorn skin aura"),
    description = ccb.content.text_without_extraction("Deal a small amount of damage to anything that attacks you."),
    valid_targets = { "hostile" },
    flags = { "RANDOM_DAMAGE" },
    shape = "blast",
    effect = "attack",
    damage_type = "stab",
    min_damage = 2,
    max_damage = 6,
    min_range = 1,
    max_range = 1,
}
