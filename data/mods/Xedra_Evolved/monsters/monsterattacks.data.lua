local ccb = require("ccb")

ccb.content.define_item {
    id = "changeling_thrown_knife",
    symbol = "%",
    color = "red",
    name = ccb.content.text("thrown knife"),
    description = ccb.content.text("Shiny reflective throwing knife at the ready."),
    materials = { "stone" },
    flags = {
        "PRIMITIVE_RANGED_WEAPON", "NEVER_JAMS", "NONCONDUCTIVE", "NO_REPAIR", "WATERPROOF_GUN",
        "NO_SALVAGE", "NO_UNLOAD", "NO_TURRET",
    },
    mass = "540 g",
    volume = "210 ml",
    length = "75 mm",
    accuracy = { grip = "weapon", length = "hand", surface = "point", balance = "good" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            capacity = "200 L",
            mass_limit = "400 kg",
            max_item_length = "2000 m",
            ammunition = { throwing_knives = 3 },
        },
    },
    melee_damage = { bash = 2 },
    gun = {
        skill = "throw",
        ammunition = { "throwing_knives" },
        effects = { "NO_PENETRATE_OBSTACLES" },
        damage = { type = "cut", amount = -1 },
        clip_size = 1,
        loudness = 2,
        range = 6,
        dispersion = 150,
        durability = 8,
    },
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "sharp_objects",
    cooldown = 25,
    move_cost = 150,
    damage = { { type = "stab", amount = 10, penetration = 8, armor_multiplier = 0.5 } },
    minimum_hit_size = 4,
    effects = { { id = "bleed", duration = 100, affect_hit_body_part = true } },
    avatar_hit = ccb.content.text("%1$s impales your %2$s!"),
    npc_hit = ccb.content.text("%1$s impales <npcname>!"),
    avatar_miss = ccb.content.text("%1$s tries to impale your %2$s, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to impale <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s tries to impale your %2$s, but fails to penetrate your armor."),
    npc_no_damage = ccb.content.text("%1$s tries to impale <npcname>, but fails to penetrate their armor."),
    dodgeable = true,
    blockable = true,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "renfield_glock",
    copy_from = "gun_base_9mm_semi_pistol",
    looks_like = "glock_19",
    name = ccb.content.text_without_extraction("Glock 19", "Glock 19"),
    description = ccb.content.text_without_extraction("A poorly maintained and inaccurate version of the Glock 19 for renfields."),
    ascii_picture = "glock_19",
    mass = "600 g",
    volume = "386 ml",
    length = "211 mm",
    price = "650 USD",
    survival_price = "25 USD",
    materials = { "steel", "aluminum" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "glockmag",
                "glockbigmag",
                "glock17_17",
                "glock17_22",
                "glock_drum_50rd",
                "glock_drum_100rd",
            },
        },
    },
    gun = { damage = { type = "bullet", amount = -4 }, range = 1, dispersion = 4800, durability = 7 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "renfield_remington",
    symbol = "R",
    color = "dark_gray",
    name = ccb.content.text_without_extraction("renfield Remington", "renfield Remington"),
    description = ccb.content.text_without_extraction("A fake shotgun for renfields (because monster aiming is too lethal)."),
    materials = { "steel", "aluminum", "plastic" },
    flags = { "NONCONDUCTIVE", "NO_REPAIR", "NO_SALVAGE", "NO_UNLOAD", "RELOAD_AND_SHOOT" },
    mass = "3400 g",
    volume = "2487 ml",
    length = "1234 mm",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 5 } } },
    melee_damage = { bash = 3 },
    gun = {
        skill = "shotgun",
        ammunition = { "shot" },
        clip_size = 5,
        dispersion = 3250,
        range = 65,
        durability = 9,
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "feral_57",
    copy_from = "gun_base_57_semi_pistol",
    looks_like = "fn57",
    name = ccb.content.text_without_extraction("FN Five-seveN", "FN Five-seveN"),
    description = ccb.content.text_without_extraction("A poorly maintained and inaccurate version of the Five-seveN for feral agents."),
    ascii_picture = "FN_five_seven",
    mass = "600 g",
    volume = "551 ml",
    length = "164 mm",
    price = "650 USD",
    survival_price = "25 USD",
    materials = { "steel", "aluminum" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "fn57mag" } } },
    gun = { damage = { type = "bullet", amount = -5 }, range = 1, dispersion = 4800, durability = 7 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "feral_p90",
    looks_like = "hk_mp5",
    name = ccb.content.text_without_extraction("P90 automatic PDW"),
    description = ccb.content.text_without_extraction("A late 90s manufactured personal defense weapon (PDW), this automatic firearm fires the high-velocity, proprietary 5.7x28mm cartridge.  Making use of top-mounted 50-round custom magazines which lock into the receiver of the weapon behind the grip, this little submachine gun packs quite the nasty payload.  Its small, high-speed caliber makes it excellent at both defeating armored opponents and firing short bursts manageably."),
    mass = "2640 g",
    volume = "3817 ml",
    length = "511 mm",
    price = "3 kUSD 500 USD",
    survival_price = "35 USD",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "light_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    pockets = { { magazine_well = "500 ml", kind = "MAGAZINE_WELL", allowed_items = { "fnp90mag" } } },
    melee_damage = { bash = 10 },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "264 mm",
        damage = { type = "bullet", amount = -5 },
        range = 4,
        ammunition = { "57" },
        skill = "smg",
        dispersion = 4800,
        durability = 8,
        min_cycle_recoil = 81,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 900 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "shifting",
    name = ccb.content.text_without_extraction("Duplicator Shifting"),
    description = ccb.content.text_without_extraction("Constantly teleports you around."),
    message = "",
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "self", "ground", "none" },
    flags = { "SILENT", "RANDOM_TARGET" },
    min_aoe = 4,
    max_aoe = 4,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "duplicate_shifter",
    name = ccb.content.text_without_extraction("Summon Shifter (Monster Version)"),
    description = ccb.content.text_without_extraction("Summon a shifter.  Monster version, the creature exists for 1-2 seconds.  Mostly decorative effect to show 'glitchiness'."),
    message = "",
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    effect = "summon",
    effect_data = "mon_shifter",
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    flags = { "NO_EXPLOSION_SFX", "RANDOM_DURATION" },
    min_duration = 100,
    max_duration = 200,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sapient_light_damage",
    name = ccb.content.text_without_extraction("Sapient Damage"),
    description = ccb.content.text_without_extraction("Deal some damage.  You can't see it except in debug mode."),
    message = "",
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground", "item" },
    flags = { "SILENT", "IGNORE_WALLS", "RANDOM_AOE", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    min_damage = 60,
    max_damage = 150,
    min_bash_scaling = 3,
    max_bash_scaling = 4,
    min_range = 9,
    max_range = 9,
    min_aoe = 25,
    max_aoe = 50,
    damage_type = "pure",
    sound_description = ccb.content.text("a loud whisper"),
    extra_spells = { { spell = "sapient_light_damage_player" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "sapient_light_damage_player",
    name = ccb.content.text_without_extraction("Sapient Player Damage"),
    description = ccb.content.text_without_extraction("Deal 34% of player's HP damage to player.  You can't see it except in debug mode."),
    message = "",
    effect = "attack",
    shape = "cone",
    valid_targets = { "ally" },
    flags = { "SILENT", "IGNORE_WALLS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = 34,
    max_damage = 34,
    min_bash_scaling = 5.3,
    max_bash_scaling = 17.6,
    min_range = 9,
    max_range = 9,
    min_aoe = 50,
    max_aoe = 50,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "duplicator_spawn_pawn",
    name = ccb.content.text_without_extraction("Summon Duplicator Pawn"),
    description = ccb.content.text_without_extraction("Summon 1 short life pawn."),
    message = "",
    flags = { "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground" },
    min_damage = 1,
    max_damage = 1,
    min_aoe = 3,
    max_aoe = 3,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_duplicator_pawn",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ophanim_death",
    name = ccb.content.text_without_extraction("Ophanim Death"),
    description = ccb.content.text_without_extraction("AoE cut damage, when ophanim dies."),
    message = "",
    valid_targets = { "self", "hostile", "ground" },
    effect = "attack",
    shape = "blast",
    min_damage = 45,
    max_damage = 99,
    damage_type = "cut",
    flags = { "SILENT", "RANDOM_DAMAGE", "RANDOM_AOE" },
    min_aoe = 7,
    max_aoe = 10,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "zombie_monochrome_reset_hp",
    name = ccb.content.text_without_extraction("Reset HP"),
    description = ccb.content.text_without_extraction("Heals 100% of health.  Players should not have this spell."),
    message = "",
    effect = "attack",
    shape = "blast",
    valid_targets = { "ally", "self" },
    flags = { "SILENT", "IGNORE_WALLS", "PERCENTAGE_DAMAGE", "NO_EXPLOSION_SFX" },
    min_damage = -200,
    max_damage = -200,
    min_range = 0,
    max_range = 0,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_monster_erosion_attack",
    name = ccb.content.text_without_extraction("Monster Erosion - Attack"),
    description = ccb.content.text_without_extraction("This causes the dot when attacking targets with the erosion buff.  Having the spell is a bug.  Monster version"),
    valid_targets = { "hostile", "ground", "none" },
    flags = {
        "SILENT",
        "NO_PROJECTILE",
        "NO_EXPLOSION_SFX",
        "RANDOM_DAMAGE",
        "RANDOM_DURATION",
        "SPLIT_DAMAGE",
    },
    message = ccb.content.text("monster erosion attack"),
    effect = "attack",
    shape = "blast",
    min_dot = 5,
    max_dot = 5,
    min_range = 10,
    max_range = 10,
    min_duration = 1000,
    max_duration = 1000,
    damage_type = "pure",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_monster_erosion_buff",
    name = ccb.content.text_without_extraction("Monster Erosion - Buff"),
    description = ccb.content.text_without_extraction("This gives the monster the erosion buff.  Having the spell is a bug.  Monster version"),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    effect = "attack",
    effect_data = "effect_xedra_monster_erosion",
    shape = "blast",
    min_duration = 100000,
    max_duration = 100000,
    min_range = 0,
    max_range = 0,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xedra_death_boomer_monochrome",
    name = ccb.content.text_without_extraction("Monochrome Boomer Death"),
    description = ccb.content.text_without_extraction("Time explosion."),
    valid_targets = { "ground", "hostile", "ally", "self" },
    flags = { "NO_EXPLOSION_SFX" },
    min_aoe = 1,
    max_aoe = 2,
    aoe_increment = 1,
    max_level = 1,
    min_duration = 180000,
    max_duration = 180000,
    shape = "blast",
    effect = "attack",
    effect_data = "effect_xedra_time_freeze",
    field_chance = 1,
    field = "fd_frozen_time",
    min_field_intensity = 10,
    max_field_intensity = 10,
    extra_spells = { { spell = "death_explosion", self = true } },
}
