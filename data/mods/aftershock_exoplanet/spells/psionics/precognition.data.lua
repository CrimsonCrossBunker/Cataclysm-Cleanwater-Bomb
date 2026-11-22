local ccb = require("ccb")

ccb.content.define_spell {
    id = "afs_precog_damage_foresee",
    skill = "metaphysics",
    shape = "blast",
    effect = "attack",
    effect_data = "effect_afs_precog_damage_foresee",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Forewarned (C)",
    description = "By taking a moment to peer through possible futures, you can determine if any harm may come to you in the near future and therefore avoid it.  This requires a moment in trance to sift through the visions.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = { handler = "wave14a_aftershock_exoplanet_stat_10", fallback = 0 },
    max_duration = { handler = "wave14a_aftershock_exoplanet_stat_11", fallback = 0 },
    base_energy_cost = 5000,
    difficulty = 3,
    max_level = { handler = "wave14a_aftershock_exoplanet_stat_3", fallback = 0 },
    base_casting_time = 6000,
    final_casting_time = 3000,
    casting_time_increment = -100,
}

ccb.content.define_spell {
    id = "afs_precog_danger_sense",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Premonition (C)",
    description = "You can sense nearby movement and sometimes gain an advance warning of dangerous events.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_2abb638e76ae",
        fallback = 0,
    },
    max_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_bbc90a79a641",
        fallback = 0,
    },
    base_energy_cost = {
        handler = "w16b_sp_stat_aftershock_exoplanet_a66e10dcaaa9",
        fallback = 0,
    },
    difficulty = 2,
    max_level = {
        handler = "w16b_sp_stat_aftershock_exoplanet_47a6ac95789b",
        fallback = 0,
    },
    base_casting_time = {
        handler = "w16b_sp_stat_aftershock_exoplanet_2b14926816b9",
        fallback = 0,
    },
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_7afa1d362bd0",
}

ccb.content.define_spell {
    id = "afs_precog_ranged_enhance",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Marksman's Eye (C)",
    description = "By predicting your opponent's position and the conditions affecting your weapon, you can increase the effective range and accuracy of your ranged attacks.  The shifting futures and focus required will slow your movem and reduce your chance to avoid any close-combat attacks, however.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.  You may only have <color_red>one</color> of Marksman's Eye, Prescient Evasion, and Martial Trance active at once.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_fe8fe05d1a8f",
        fallback = 0,
    },
    max_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_d3111342fc43",
        fallback = 0,
    },
    base_energy_cost = {
        handler = "w16b_sp_stat_aftershock_exoplanet_057516fa93ee",
        fallback = 0,
    },
    difficulty = 4,
    max_level = {
        handler = "w16b_sp_stat_aftershock_exoplanet_47a6ac95789b",
        fallback = 0,
    },
    base_casting_time = {
        handler = "w16b_sp_stat_aftershock_exoplanet_65a3a5e8d24a",
        fallback = 0,
    },
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_a0db8d2848e5",
}

ccb.content.define_spell {
    id = "afs_precog_craft_bonus",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Intuitive Artisan (C)",
    description = "Opening yourself up to the immediate future, you can see the best option to take when crafting or working on a task.  However, due to the intensity of the visions you will be <color_red>blind</color> to the outside world while crafting anything.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.  It is <color_red>canceled by engaging in combat</color>.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_945db23938c5",
        fallback = 0,
    },
    max_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_dc09eab32a66",
        fallback = 0,
    },
    base_energy_cost = {
        handler = "w16b_sp_stat_aftershock_exoplanet_9b20e8af13c8",
        fallback = 0,
    },
    difficulty = 6,
    max_level = {
        handler = "w16b_sp_stat_aftershock_exoplanet_47a6ac95789b",
        fallback = 0,
    },
    base_casting_time = {
        handler = "w16b_sp_stat_aftershock_exoplanet_167d8a81a9b8",
        fallback = 0,
    },
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_96d46cf4e0b1",
}

ccb.content.define_spell {
    id = "afs_precog_dodge_bonus",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Prescient Evasion (C)",
    description = "By gazing into the near future, you can be wherever your enemies are not attacking.  You can even \"dodge\" bullets or lasers by simply not being in the line of fire.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.  You may only have <color_red>one</color> of Marksman's Eye, Prescient Evasion, and Martial Trance active at once.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_fb031577589d",
        fallback = 0,
    },
    max_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_c59b0dd95721",
        fallback = 0,
    },
    base_energy_cost = {
        handler = "w16b_sp_stat_aftershock_exoplanet_470ed5857222",
        fallback = 0,
    },
    difficulty = 6,
    max_level = {
        handler = "w16b_sp_stat_aftershock_exoplanet_47a6ac95789b",
        fallback = 0,
    },
    base_casting_time = {
        handler = "w16b_sp_stat_aftershock_exoplanet_479766dd3a22",
        fallback = 0,
    },
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_7ed511703cbf",
}

ccb.content.define_spell {
    id = "afs_precog_melee_enhance",
    skill = "metaphysics",
    shape = "blast",
    spell_class = "AFS_PRECOG",
    magic_type = "aftershock_psionics",
    name = "[Ψ]Martial Trance (C)",
    description = "By opening yourself up to possible futures, you can predict your opponent's movements, striking at the place where they will be and avoiding their attacks before they happen.  Focusing on the shifting futures will narrow your vision to only the nearby melee, however.\n\nThis power <color_yellow>is maintained by concentration</color> and <color_red>may fail</color> if <color_yellow>concentration is interrupted</color>.  You may only have <color_red>one</color> of Marksman's Eye, Prescient Evasion, and Martial Trance active at once.",
    message = "",
    teachable = false,
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "RANDOM_DURATION", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_d620491205a7",
        fallback = 0,
    },
    max_duration = {
        handler = "w16b_sp_stat_aftershock_exoplanet_17082b27794b",
        fallback = 0,
    },
    base_energy_cost = {
        handler = "w16b_sp_stat_aftershock_exoplanet_4c73374d5a2a",
        fallback = 0,
    },
    difficulty = 7,
    max_level = {
        handler = "w16b_sp_stat_aftershock_exoplanet_47a6ac95789b",
        fallback = 0,
    },
    base_casting_time = {
        handler = "w16b_sp_stat_aftershock_exoplanet_5b5f3025d37a",
        fallback = 0,
    },
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_e8980a31643f",
}
