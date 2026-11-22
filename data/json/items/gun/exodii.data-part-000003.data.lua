local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_plasma_fan",
    name = ccb.content.text_without_extraction("Plasma fan"),
    description = ccb.content.text_without_extraction("Your weapon releases a searing fan of plasma."),
    effect = "attack",
    shape = "cone",
    field = "fd_plasma",
    min_field_intensity = 1,
    max_field_intensity = 3,
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "LOUD", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE", "IGNITE_FLAMMABLE", "IGNORE_WALLS", "SPLIT_DAMAGE" },
    min_damage = 20,
    max_damage = 30,
    min_bash_scaling = 6,
    max_bash_scaling = 6,
    min_aoe = 15,
    max_aoe = 15,
    min_range = 10,
    max_range = 10,
    difficulty = 1,
    sound_description = ccb.content.text("fzzzt"),
    damage_type = "heat",
}

ccb.content.define_item {
    id = "exodii_plasma_projectile",
    name = ccb.content.plural_text("Caotel Sr2.2 (Projectile)", "Caotel Sr2.2 (Projectile)"),
    description = "Nothing but ruins and ash-choked skies remained in the world where this exotic weapon was manufactured, and the Exodii, ever pragmatic, choose not to explore beyond what was necessary to perform a second, emergency escape.  A single discharge from the Caotel easily melts through conventional armor and flash-incinerates anything behind it, but its state of disrepair limits the number of shots it can fire in quick succession.",
    symbol = "(",
    color = "cyan",
    looks_like = "plasma_gun",
    mass = "8500 g",
    volume = "4 L",
    length = "100 cm",
    price = "100 USD",
    survival_price = "100 USD",
    flags = { "NEVER_JAMS", "NON_FOULING", "OVERHEATS" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "120 ml",
            holster = true,
            allowed_items = { "caotel_plasma_ring" },
        },
    },
    faults = {
        { fault = "fault_overheat_explosion" },
        { fault = "fault_overheat_venting" },
        { fault = "fault_overheat_safety" },
    },
    use_actions = {
        {
            kind = "transform",
            target = "exodii_plasma_fan",
            ammo_scale = 0,
            message = "A cacophony of symbols flash across the weapon's display, but it seems to stabilize nonetheless.",
            menu_text = "Switch Firing Mode",
        },
    },
    gun = {
        skill = "rifle",
        ammunition = { "caotel_cell" },
        range = 20,
        dispersion = 200,
        recoil = 30,
        durability = 4,
        loudness = 5,
        reload_time = 300,
        effects = { "PLASMA", "EXPLOSIVE_SMALL" },
        heat_per_shot = 20,
        cooling = 1,
        overheat_threshold = 59,
        damage = {
            { type = "bullet", amount = 120, penetration = 60 },
            { type = "biological", amount = 60 },
        },
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "condenser", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "exodii_plasma_fan",
    copy_from = "exodii_plasma_projectile",
    name = ccb.content.plural_text("Caotel Sr2.2 (FAN)", "Caotel Sr2.2 (FAN)"),
    description = "Nothing but ruins and ash-choked skies remained in the world where this exotic weapon was manufactured, and the Exodii, ever pragmatic, choose not to explore beyond what was necessary to perform a second, emergency escape.  Even a second of exposure to the Caotel's plasma fan is enough to flash-incinerate anything, but its state of disrepair limits the amount of time its destructive power can be sustained.",
    looks_like = "plasma_gun",
    use_actions = {
        {
            kind = "transform",
            target = "exodii_plasma_projectile",
            ammo_scale = 0,
            message = "A cacophony of symbols flash across the weapon's display, but it seems to stabilize nonetheless.",
            menu_text = "Switch Firing Mode",
        },
    },
    gun = {
        skill = "launcher",
        range = 12,
        effects = { "PLASMA", "PLASMA_FAN" },
        heat_per_shot = 15,
        damage = {
            { type = "heat", amount = 50, penetration = 60 },
        },
    },
}
