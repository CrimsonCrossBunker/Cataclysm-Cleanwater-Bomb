local content = require("ccb").content

-- ammo/gg_ammo_migration.json
content.add(content.ItemMigration { from = { "22_fmj", "32_acp" }, to = "tiny_pistol_ball" })
content.add(content.ItemMigration {
    from = { "reloaded_22_fmj", "reloaded_32_acp" },
    to = "reloaded_tiny_pistol_ball",
})
content.add(content.ItemMigration { from = { "bp_22_fmj", "bp_22_lr", "bp_32_acp" }, to = "bp_tiny_pistol_ball" })
content.add(content.ItemMigration {
    from = { "matchhead_22_fmj", "matchhead_32_acp" },
    to = "matchhead_tiny_pistol_ball",
})
content.add(content.ItemMigration {
    from = { "matchhead_22_lr", "matchhead_32_acp_jhp" },
    to = "matchhead_tiny_pistol_jhp",
})
content.add(content.ItemMigration {
    from = { "22_cb", "22_lr", "22_ratshot", "32_acp_jhp" },
    to = "tiny_pistol_jhp",
})
content.add(content.ItemMigration {
    from = { "reloaded_22_lr", "reloaded_32_acp_jhp" },
    to = "reloaded_tiny_pistol_jhp",
})
content.add(content.ItemMigration { from = { "bp_22_lr", "bp_32_acp_jhp" }, to = "bp_tiny_pistol_jhp" })
content.add(content.ItemMigration { from = { "22_blank" }, to = "small_powder_blank" })
content.add(content.ItemMigration {
    from = {
        "10mm_fmj",
        "10mmP",
        "357sig_fmj",
        "38_fmj",
        "38_special_p",
        "380_FMJ",
        "380_p",
        "38super_fmj",
        "40fmj",
        "45colt_cowboy",
        "45_acp",
        "57mm",
        "57mm_ss",
        "57mm_lf",
        "5x50dart",
        "762_25hot",
        "762_25typeP",
        "9mmfmj",
        "9mmP",
        "9mmP2",
        "9x18mmfmj",
        "9x18mmP2",
    },
    to = "pistol_ball",
})
content.add(content.ItemMigration {
    from = {
        "reloaded_10mm_fmj",
        "reloaded_10mmP",
        "reloaded_357sig_fmj",
        "reloaded_38_fmj",
        "reloaded_38_special_p",
        "reloaded_380_FMJ",
        "reloaded_380_p",
        "reloaded_38super_fmj",
        "reloaded_40fmj",
        "reloaded_45colt_fmj",
        "reloaded_45colt_cowboy",
        "reloaded_45_acp",
        "reloaded_57mm",
        "reloaded_5x50dart",
        "reloaded_9mmfmj",
        "reloaded_9mmP",
        "reloaded_9mmP2",
        "reloaded_9x18mmfmj",
        "reloaded_9x18mmP2",
    },
    to = "reloaded_pistol_ball",
})
content.add(content.ItemMigration {
    from = {
        "bp_10mm_fmj",
        "bp_357sig_fmj",
        "bp_38_fmj",
        "bp_38super_fmj",
        "bp_380_FMJ",
        "bp_40ball",
        "bp_40fmj",
        "bp_44ball",
        "bp_45colt_fmj",
        "bp_45colt_cowboy",
        "bp_45_acp",
        "bp_57mm",
        "bp_9mmfmj",
        "bp_9x18mmfmj",
    },
    to = "bp_pistol_ball",
})
content.add(content.ItemMigration {
    from = {
        "matchhead_10mm_fmj",
        "matchhead_357sig_fmj",
        "matchhead_38_fmj",
        "matchhead_38_super_fmj",
        "matchhead_380_FMJ",
        "matchhead_40ball",
        "matchhead_40fmj",
        "matchhead_45_acp",
        "matchhead_45colt_fmj",
        "matchhead_45colt_cowboy",
        "matchhead_9mmfmj",
        "matchhead_9x18mmfmj",
        "matchhead_357mag_fmj",
        "matchhead_50ae_fmj",
    },
    to = "matchhead_pistol_ball",
})
content.add(content.ItemMigration {
    from = {
        "357sig_jhp",
        "38_special",
        "38_super",
        "380_JHP",
        "40sw",
        "45_jhp",
        "45_super",
        "45colt_jhp",
        "5x50heavy",
        "762_25",
        "9mm",
        "9x18mm",
        "10mm_jhp",
    },
    to = "pistol_jhp",
})
content.add(content.ItemMigration {
    from = {
        "reloaded_357sig_jhp",
        "reloaded_38_special",
        "reloaded_38_super",
        "reloaded_380_JHP",
        "reloaded_40sw",
        "reloaded_45_jhp",
        "reloaded_45_super",
        "reloaded_45colt_jhp",
        "reloaded_762_25",
        "reloaded_9mm",
        "reloaded_9x18mm",
        "reloaded_10mm_jhp",
    },
    to = "reloaded_pistol_jhp",
})
content.add(content.ItemMigration {
    from = {
        "bp_357sig_jhp",
        "bp_38_special",
        "bp_38super",
        "bp_380_JHP",
        "bp_40sw",
        "bp_45_jhp",
        "bp_45colt_jhp",
        "bp_762_25",
        "bp_9mm",
        "bp_9x18mm",
        "bp_10mm_jhp",
    },
    to = "bp_pistol_jhp",
})
content.add(content.ItemMigration {
    from = {
        "matchhead_357sig_jhp",
        "matchhead_38_special",
        "matchhead_38_super",
        "matchhead_380_JHP",
        "matchhead_40sw",
        "matchhead_45_jhp",
        "matchhead_45colt_jhp",
        "matchhead_762_25",
        "matchhead_9mm",
        "matchhead_9x18mm",
        "matchhead_10mm_jhp",
        "matchhead_357mag_jhp",
        "matchhead_50ae_jhp",
    },
    to = "matchhead_pistol_jhp",
})
content.add(content.ItemMigration { from = { "357mag_fmj", "44fmj", "50ae_fmj" }, to = "pistol_magnum_ball" })
content.add(content.ItemMigration {
    from = { "reloaded_357mag_fmj", "reloaded_44magnum", "reloaded_50ae_fmj" },
    to = "reloaded_pistol_magnum_ball",
})
content.add(content.ItemMigration {
    from = { "bp_357mag_fmj", "bp_44fmj", "bp_50ae_fmj" },
    to = "bp_pistol_magnum_ball",
})
content.add(content.ItemMigration {
    from = {
        "357mag_jhp",
        "44magnum",
        "454_Casull",
        "500_Magnum",
        "50ae_jhp",
        "460sw",
        "460sw_jhp",
        "reloaded_460sw",
        "reloaded_460sw_jhp",
    },
    to = "pistol_magnum_jhp",
})
content.add(content.ItemMigration {
    from = {
        "reloaded_357mag_jhp",
        "reloaded_44fmj",
        "reloaded_454_Casull",
        "reloaded_500_Magnum",
        "reloaded_50ae_jhp",
    },
    to = "reloaded_pistol_magnum_jhp",
})
content.add(content.ItemMigration {
    from = { "bp_357mag_jhp", "bp_44magnum", "bp_454_Casull", "bp_500_Magnum", "bp_50ae_jhp" },
    to = "bp_pistol_magnum_jhp",
})
content.add(content.ItemMigration {
    from = {
        "223",
        "270win_jsp",
        "300_winmag",
        "3006",
        "3006_jsp",
        "50beowulf_xtp",
        "450_ftx",
        "338lapua_hpbt",
        "300blk",
        "300blk_ss",
        "303_bthp",
        "303_sp",
        "77mm_arisaka_jsp",
        "308",
        "4570_low",
        "4570_sp",
        "545",
        "762_54R",
        "762_m87",
        "762_jhp",
        "8mm_jhp",
        "30carbine",
        "30carbine_jsp",
        "3030",
    },
    to = "rifle_ball",
})
content.add(content.ItemMigration { from = { "123ln" }, to = "rifle_ball_foreign" })
content.add(content.ItemMigration { from = { "reloaded_123ln" }, to = "reloaded_rifle_ball_foreign" })
content.add(content.ItemMigration { from = { "bp_123ln" }, to = "bp_rifle_ball_foreign" })
content.add(content.ItemMigration { from = { "123ln_ap" }, to = "rifle_AP_foreign" })
content.add(content.ItemMigration { from = { "reloaded_123ln_ap" }, to = "reloaded_rifle_AP_foreign" })
content.add(content.ItemMigration { from = { "bp_123ln_ap" }, to = "bp_rifle_AP_foreign" })
content.add(content.ItemMigration {
    from = {
        "reloaded_223",
        "reloaded_270win_fmj",
        "reloaded_270win_jsp",
        "reloaded_300_winmag",
        "reloaded_3006",
        "reloaded_3006_jsp",
        "reloaded_50beowulf_xtp",
        "reloaded_450_ftx",
        "reloaded_338lapua_hpbt",
        "reloaded_300blk",
        "reloaded_300blk_ss",
        "reloaded_308",
        "reloaded_4570_bp",
        "reloaded_4570_low",
        "reloaded_4570_sp",
        "reloaded_545",
        "reloaded_303",
        "reloaded_303sp",
        "reloaded_77mm_arisaka_jsp",
        "reloaded_762_54R",
        "reloaded_762_jhp",
        "reloaded_762_m87",
        "reloaded_30carbine",
        "reloaded_30carbine_jsp",
        "reloaded_3030",
        "reloaded_3030_fmj",
    },
    to = "reloaded_rifle_ball",
})
content.add(content.ItemMigration {
    from = {
        "bp_223",
        "bp_270win_fmj",
        "bp_270win_jsp",
        "bp_300_winmag",
        "bp_3006",
        "bp_3006_jsp",
        "bp_50beowulf_xtp",
        "bp_450_ftx",
        "bp_338lapua_hpbt",
        "bp_300blk",
        "bp_300blk_ss",
        "bp_308",
        "bp_545",
        "bp_303",
        "bp_303sp",
        "bp_77mm_arisaka_jsp",
        "bp_762_54R",
        "bp_762_m87",
        "bp_762_jhp",
        "bp_30carbine",
        "bp_30carbine_jsp",
        "reloaded_3030_bp",
        "reloaded_3030_fmj_bp",
    },
    to = "bp_rifle_ball",
})
content.add(content.ItemMigration {
    from = {
        "3006_incendiary",
        "3006fmj",
        "50beowulf_penetrator",
        "450_penetrator",
        "338lapua_fmjbt",
        "338lapua_api",
        "303_fmjbt",
        "4570_pen",
        "545_ap",
        "556",
        "556_m855a1",
        "556_mk262",
        "556_mk318",
        "556_incendiary",
        "556_m995",
        "762_51",
        "762_51_incendiary",
        "762_51_m993",
        "8mm_caseless",
        "8mm_hvp",
    },
    to = "rifle_AP",
})
content.add(content.ItemMigration {
    from = {
        "reloaded_3006_incendiary",
        "reloaded_3006fmj",
        "reloaded_50beowulf_penetrator",
        "reloaded_450_penetrator",
        "reloaded_338lapua_fmjbt",
        "reloaded_338lapua_api",
        "reloaded_303fmj",
        "reloaded_4570_pen",
        "reloaded_545_ap",
        "reloaded_556",
        "reloaded_556_incendiary",
        "reloaded_762_51",
        "reloaded_762_51_incendiary",
    },
    to = "reloaded_rifle_AP",
})
content.add(content.ItemMigration {
    from = {
        "bp_3006_incendiary",
        "bp_3006fmj",
        "bp_50beowulf_penetrator",
        "bp_450_penetrator",
        "bp_338lapua_fmjbt",
        "bp_338lapua_api",
        "bp_303fmj",
        "bp_545_ap",
        "bp_556",
        "bp_556_incendiary",
        "bp_762_51",
        "bp_762_51_incendiary",
    },
    to = "bp_rifle_AP",
})
content.add(content.ItemMigration {
    from = { "50_incendiary", "50_mk211", "50bmg", "50match", "458wm" },
    to = "rifle_huge_ball",
})
content.add(content.ItemMigration { from = { "50ss" }, to = "rifle_huge_AP" })
content.add(content.ItemMigration { from = { "reloaded_50ss" }, to = "reloaded_rifle_huge_AP" })
content.add(content.ItemMigration { from = { "bp_50ss", "bp_700nx" }, to = "bp_rifle_huge_AP" })
content.add(content.ItemMigration { from = { "12mm" }, to = "rifle_rail_ammo" })
content.add(content.ItemMigration { from = { "36navy", "44army", "flintlock_ammo" }, to = "black_powder_ball" })
content.add(content.ItemMigration { from = { "flintlock_shot" }, to = "black_powder_shot" })
content.add(content.ItemMigration { from = { "40x46mm_m1006" }, to = "grenade_ammo_beanbag" })
content.add(content.ItemMigration { from = { "40mm_flare", "273x44flare" }, to = "grenade_ammo_flare" })
content.add(content.ItemMigration {
    from = {
        "40x46mm_m433",
        "40x46mm_m651",
        "40x53mm_m430a1",
        "273x110sluglight",
        "273x110slugmedium",
        "273x110slugheavy",
        "273x44thermobaric",
        "273x44HE",
        "273x44RG",
    },
    to = "grenade_ammo_hedp",
})
content.add(content.ItemMigration {
    from = {
        "40x46mm_m576",
        "40x53mm_m1001",
        "40x53mm_flechette_m169",
        "40x53mm_buckshot_m169",
        "bp_40x53mm_buckshot_m169",
        "bp_40x53mm_flechette_m169",
        "40x46mm_hornets_nest_410_slug",
        "40x46mm_hornets_nest_410_bird",
        "40x46mm_hornets_nest_410",
        "40x46mm_hornets_nest_22lr",
        "40x46mm_hornets_nest_410_scrap",
        "273x110flock",
        "273x110canister",
    },
    to = "grenade_ammo_shot",
})
content.add(content.ItemMigration {
    from = { "40x53mm_slug_m169", "bp_40x53mm_slug_m169", "273x44trainer" },
    to = "grenade_ammo_slug",
})
content.add(content.ItemMigration { from = { "40x46mm_m651" }, to = "grenade_ammo_teargas" })
content.add(content.ItemMigration {
    from = {
        "shot_00",
        "shot_paper_00",
        "410shot_000",
        "20x66_exp",
        "20x66_frag",
        "20x66_shot",
        "20x66_flare",
        "20shot_buck",
    },
    to = "shot_buck",
})
content.add(content.ItemMigration { from = { "shot_beanbag", "20x66_beanbag" }, to = "shot_bean" })
content.add(content.ItemMigration {
    from = { "shot_bird", "410shot_bird", "shot_paper_bird", "20shot_bird" },
    to = "shot_fowl",
})
content.add(content.ItemMigration {
    from = { "shot_slug", "shot_paper_slug", "410shot_slug", "20x66_slug", "20shot_slug" },
    to = "shot_foster",
})
content.add(content.ItemMigration { from = { "shot_dragon", "shot_paper_dragon" }, to = "shot_pyro" })
content.add(content.ItemMigration {
    from = { "reloaded_shot_00", "reloaded_410shot_000", "20x66_bootleg_shot", "shot_scrap", "410shot_scrap" },
    to = "reloaded_shot_buck",
})
content.add(content.ItemMigration {
    from = { "reloaded_shot_00", "reloaded_410shot_000" },
    to = "reloaded_shot_buck",
})
content.add(content.ItemMigration {
    from = { "reloaded_shot_bird", "reloaded_410shot_bird" },
    to = "reloaded_shot_fowl",
})
content.add(content.ItemMigration {
    from = { "reloaded_shot_slug", "reloaded_410shot_slug", "20x66_bootleg_slug" },
    to = "reloaded_shot_foster",
})
content.add(content.ItemMigration { from = { "reloaded_shot_dragon" }, to = "reloaded_shot_pyro" })
content.add(content.ItemMigration {
    from = { "shot_flechette", "reloaded_shot_flechette" },
    to = "reloaded_shot_dart",
})
content.add(content.ItemMigration {
    from = { "bp_shot_00", "bp_410shot_000", "bp_shot_scrap", "bp_410shot_scrap" },
    to = "bp_shot_buck",
})
content.add(content.ItemMigration { from = { "bp_shot_bird", "bp_410shot_bird" }, to = "bp_shot_fowl" })
content.add(content.ItemMigration { from = { "bp_shot_slug", "bp_410shot_slug" }, to = "bp_shot_foster" })
content.add(content.ItemMigration { from = { "bp_shot_dragon" }, to = "bp_shot_pyro" })
content.add(content.ItemMigration { from = { "bp_shot_flechette" }, to = "bp_shot_dart" })
content.add(content.ItemMigration { from = { "84x246mm_he", "RPG-7_ammo" }, to = "rocket_he" })
content.add(content.ItemMigration { from = { "caotel_cell" }, to = "gg_plasma_cell" })
content.add(content.ItemMigration { from = { "nl_chem_thrower_ammo" }, to = "gg_nl_chem_thrower_ammo" })
content.add(content.ItemMigration {
    from = {
        "84x246mm_hedp",
        "m235_tpa",
        "RPG-7_pg7vr",
        "RPG-7_tbg7v",
        "RPG-7_og7v",
        "khuunaofaai_ammo_incendiary",
        "khuunaofaai_ammo_corrosive",
    },
    to = "rocket_hedp",
})
content.add(content.ItemMigration { from = { "airgun_pellet_target" }, to = "rifle_pellet_target" })
content.add(content.ItemMigration { from = { "airgun_pellet_hunting" }, to = "rifle_pellet_hunting" })
content.add(content.ItemMigration {
    from = { "84x246mm_smoke", "khuunaofaai_ammo_firework", "khuunaofaai_ammo_foam" },
    to = "rocket_smoke",
})
content.add(content.ItemMigration { from = { "33naval_ball" }, to = "rifle_ball_cannon" })
content.add(content.ItemMigration {
    from = { "reloaded_50_incendiary", "reloaded_458wm", "reloaded_50bmg", "reloaded_50bmgfmj" },
    to = "reloaded_rifle_huge_ball",
})
content.add(content.ItemMigration {
    from = { "bp_50_incendiary", "bp_458wm", "bp_50match", "bp_50bmgfmj" },
    to = "bp_rifle_huge_ball",
})

-- ammo/gg_casings_migration.json
content.add(content.ItemMigration {
    from = {
        "40x46mm_m118_casing",
        "40x46mm_m199_casing",
        "40x46mm_m195_casing",
        "40x46mm_m212casing",
        "40x53mm_m169_casing",
        "40x46mm_hornets_nest_22lr_casing",
        "40x46mm_hornets_nest_410_casing",
    },
    to = "grenade_casing",
})
content.add(content.ItemMigration {
    from = { "357mag_casing", "44_casing", "454_casing", "500_casing", "460sw_casing" },
    to = "pistol_magnum_casing",
})
content.add(content.ItemMigration {
    from = {
        "10mm_casing",
        "357sig_casing",
        "38_casing",
        "380_casing",
        "38super_casing",
        "40_casing",
        "45_casing",
        "45colt_casing",
        "57mm_casing",
        "5x50_hull",
        "762_25_casing",
        "9mm_casing",
        "9x18mm_casing",
    },
    to = "pistol_casing",
})
content.add(content.ItemMigration { from = { "410shot_hull", "shot_hull", "20shot_hull" }, to = "shot_casing" })
content.add(content.ItemMigration {
    from = { "22_casing", "22_casing_new", "32_casing" },
    to = "pistol_tiny_casing",
})
content.add(content.ItemMigration {
    from = {
        "223_casing",
        "270win_casing",
        "303_casing",
        "77arisaka_casing",
        "300blk_casing",
        "3006_casing",
        "308_casing",
        "4570_casing",
        "50beowulf_casing",
        "450_casing",
        "338lapua_casing",
        "545_casing",
        "762_51_casing",
        "762_casing",
        "762R_casing",
        "300_casing",
        "30carbine_casing",
        "123ln_casing",
        "33_naval_casing",
        "3030_casing",
    },
    to = "rifle_casing",
})
content.add(content.ItemMigration {
    from = { "50_casing", "458wm_casing", "700nx_casing" },
    to = "rifle_huge_casing",
})
content.add(content.ItemMigration { from = { "ammolink308", "ammolink223" }, to = "ammolinkrifle" })
content.add(content.ItemMigration { from = "ammolink40mm", to = "ammolinkgrenade" })
content.add(content.ItemMigration { from = "ammolink50", to = "ammolinkrifle_huge" })

-- ammo/gg_core_migration.json
content.add(content.ItemMigration { from = { "3006_steel_core" }, to = "rifle_steel_core" })
content.add(content.ItemMigration { from = { "123_steel_core" }, to = "rifle_alien_steel_core" })
content.add(content.ItemMigration { from = { "50_steel_core" }, to = "rifle_huge_steel_core" })

-- firearms/gg_firearms_migration.json
content.add(content.ItemMigration { from = { "pistol_flintlock" }, to = "black_powder_pistol" })
content.add(content.ItemMigration { from = { "colt_navy", "colt_army" }, to = "black_powder_revolver" })
content.add(content.ItemMigration {
    from = { "rifle_flintlock", "carbine_flintlock", "carbine_flintlock_double", "longrifle_flintlock" },
    to = "black_powder_rifle",
})
content.add(content.ItemMigration { from = { "brogyaga", "m79" }, to = "grenade_blooper" })
content.add(content.ItemMigration { from = { "mark19" }, to = "grenade_hmg" })
content.add(content.ItemMigration { from = { "m320", "brogyeki" }, to = "grenade_pistol" })
content.add(content.ItemMigration {
    from = { "mgl", "sapra", "robofac_gun_40mm", "pseudo_m203" },
    to = "grenade_revolver",
})
content.add(content.ItemMigration { from = { "colt_lightning" }, to = "pistol_levergun" })
content.add(content.ItemMigration {
    from = {
        "skorpion_61",
        "mac_11",
        "mac_10",
        "needlepistol",
        "hk_mp5k",
        "briefcase_smg",
        "skorpion_82",
        "tec9",
        "glock_18c",
    },
    to = "pistol_machine",
})
content.add(content.ItemMigration {
    from = { "deagle_44", "modular_deagle", "modular_deagle_357", "modular_deagle_44", "modular_deagle_50" },
    to = "pistol_magnum_automag",
})
content.add(content.ItemMigration {
    from = { "henry_big_boy", "rossi_r92_44_20", "rossi_r92_44_16" },
    to = "pistol_magnum_levergun",
})
content.add(content.ItemMigration { from = { "rifle_44" }, to = "pistol_magnum_pipe" })
content.add(content.ItemMigration {
    from = {
        "sw_619",
        "sw629",
        "bfr",
        "sw_500",
        "raging_bull",
        "chiappa_rhino",
        "rp63",
        "colt_python",
        "colt_anaconda_8",
        "colt_anaconda_6",
        "colt_anaconda_4",
        "460_xvr",
    },
    to = "pistol_magnum_revolver",
})
content.add(content.ItemMigration {
    from = {
        "p320_357sig",
        "rugerlcp",
        "hptcf380",
        "sig_40",
        "hptjcp",
        "m1911",
        "walther_ppq_45",
        "hptjhp",
        "tokarev",
        "rm103a_pistol",
        "glock_19",
        "m9",
        "usp_9mm",
        "p08",
        "mauser_c96",
        "m17",
        "hi_power_9mm",
        "p226_357sig",
        "glock_31",
        "walther_p38",
        "walther_ccp",
        "makarov",
        "m1911a1_38super",
        "glock_22",
        "civilian_cop_glock22",
        "civilian_glock19",
        "civilian_AR-15",
        "hi_power_40",
        "tommygun",
        "usp_45",
        "fn57",
        "glock_17",
        "ruger_57",
        "walther_ppq_9mm",
        "hptc9",
        "cz75",
        "90two",
        "px4",
        "px4_40",
        "glock_29",
        "glock_20",
        "glock_40",
        "glock_21",
        "m1911_10",
        "witness_10",
        "p220_10",
        "xd_10",
        "m11",
        "m18",
        "p226_9mm",
        "sp2022",
        "ruger_charger",
        "hk_mp5_semi_pistol",
        "draco_9mm",
        "p365",
        "swbodyguard",
        "glock_42",
        "glock_23",
        "glock_27",
        "glock_30",
        "glock_36",
        "glock_43",
        "glock_43x",
        "glock_26",
        "glock_34",
        "glock_48",
    },
    to = "pistol_medium",
})
content.add(content.ItemMigration {
    from = {
        "ksub2000",
        "calico",
        "hk_mp5_10_semi",
        "mp40semi",
        "hpt3895",
        "uberti_1873",
        "rossi_r92_357_16",
        "rossi_r92_357_20",
        "rugerpcc",
    },
    to = "pistol_pcc",
})
content.add(content.ItemMigration {
    from = {
        "2_shot_special",
        "rifle_38",
        "smg_40",
        "surv_six_shooter",
        "smg_45",
        "surv_hand_cannon",
        "smg_9mm",
        "rifle_45_410",
    },
    to = "pistol_pipe_smg",
})
content.add(content.ItemMigration {
    from = {
        "model_10_revolver",
        "ruger_lcr_38",
        "sw_610",
        "bond_410",
        "colt_saa",
        "m47a1",
        "taurus_judge",
        "sw642",
    },
    to = "pistol_revolver",
})
content.add(content.ItemMigration {
    from = {
        "hk_mp5",
        "hk_mp5sd",
        "uzi",
        "TDI",
        "hk_ump45",
        "modular_ump",
        "modular_ump_9",
        "modular_ump_40",
        "modular_ump_45",
        "fn_p90",
        "fn_ps90",
        "needlegun",
        "sten",
        "bt_apc9k",
        "colt_ro635",
        "mp40",
        "greasegun",
    },
    to = "pistol_smg",
})
content.add(content.ItemMigration {
    from = {
        "ruger_1022",
        "ruger_1022_auto",
        "ruger_charger_auto",
        "rossi_gallery",
        "marlin60",
        "mp_15_22",
        "savage_rascal",
    },
    to = "pistol_tiny_rifle",
})
content.add(content.ItemMigration {
    from = {
        "marlin_9a",
        "kp32",
        "lws32",
        "ruger_lcr_22",
        "sig_mosquito",
        "walther_p22",
        "walther_ppk",
        "pressin",
        "ruger_mk4",
        "rough_rider_pistol",
        "rough_rider_pistol_9",
        "1911_22",
        "rio_bravo",
        "henry_golden_boy",
        "sw617",
        "sr22",
        "glock_44",
    },
    to = "pistol_tiny_target",
})
content.add(content.ItemMigration { from = { "rifle_22" }, to = "pistol_tiny_zip" })
content.add(content.ItemMigration {
    from = {
        "m1918",
        "hk417_13",
        "modular_m16a4",
        "m16a4",
        "nato_assault_rifle",
        "modular_m4_carbine",
        "m4_carbine",
        "modular_m27_assault_rifle",
        "m27_assault_rifle",
        "modular_m16_auto_rifle",
        "m16_auto_rifle",
        "scar_h",
        "scar_h_mk20",
        "scar_l",
        "sig_mcx_rattler_sbr",
        "rm51_assault_rifle",
        "rm2000_smg",
        "an94",
        "vz58_p",
        "vz58_v",
        "rm88_battle_rifle",
    },
    to = "rifle_assault",
})
content.add(content.ItemMigration { from = { "m107a1", "as50", "tac50" }, to = "rifle_huge_amr" })
content.add(content.ItemMigration { from = { "win70_458", "bfg50" }, to = "rifle_huge_double" })
content.add(content.ItemMigration { from = { "m2browning" }, to = "rifle_huge_hmg" })
content.add(content.ItemMigration { from = { "m134", "m249", "m240", "m60", "rm614_lmg" }, to = "rifle_lmg" })
content.add(content.ItemMigration {
    from = {
        "survivor_special_700",
        "remington_700_308",
        "m110a1",
        "mosin44_ebr",
        "mosin91_30_ebr",
        "boreal_mosin",
        "rm11b_sniper_rifle",
        "remington700_270",
        "ruger_m77",
        "ruger_arr",
        "ruger_pr",
        "cz600",
        "cz600_762",
        "axmc",
        "axmc_300",
        "axmc_308",
        "m2010",
        "savage112",
        "mrad_smr",
        "tac338",
        "weatherby_5",
        "win70",
        "browning_blr",
        "remington_700",
        "scar_17s",
        "steyr_scout",
        "M24",
        "sharps",
    },
    to = "rifle_sniper",
})
content.add(content.ItemMigration {
    from = {
        "sl8",
        "garand",
        "m1903",
        "hk_g3",
        "m14ebr",
        "smle_mk3",
        "number4_mki",
        "type99",
        "type99ld",
        "type99_sniper",
        "ar10",
        "1895sbl",
        "ak74",
        "ak74_semi",
        "vz58ts",
        "ruger_m77",
        "ruger_pr",
        "kord",
        "ak47",
        "mdrx",
        "mdrx_223",
        "mdrx_223short",
        "mdrx_300",
        "mdrx_308",
        "mdrx_308medium",
        "l_bak_223",
        "mosin91_30",
        "m249_semi",
        "m60_semi",
        "modular_ar15",
        "ar15",
        "ar15_223long",
        "ar15_223medium",
        "ar15_223short",
        "ar15_300",
        "ar15_300medium",
        "ar15_300short",
        "ar15_50",
        "ar15_50medium",
        "ar15_50short",
        "ar15_450",
        "ar15_450medium",
        "ar15_450short",
        "ar15_762",
        "rifle_223",
        "ruger_mini",
        "mp_15",
        "sig_assault_rifle",
        "steyr_aug",
        "iwi_tavor_x95_300blk",
        "fn_fal_semi",
        "m1a",
        "sks",
        "mosin44",
        "famas",
        "aksemi",
        "805_bren",
        "bren2_556",
        "robofac_gun",
        "psl",
        "xedra_gun",
        "obrez",
        "mk47",
        "hk_usc45",
        "m1carbine",
        "m2carbine",
        "ak556",
        "ak308",
        "papm77",
        "rfb_308",
        "rdb_223",
        "scar_16s",
        "winchester_94_3030",
        "marlin_336_3030",
        "modular_ar_pistol",
    },
    to = "rifle_sporter",
})
content.add(content.ItemMigration {
    from = { "pamd68", "pamd71z", "pamd68rubik", "pamd68mountable" },
    to = "rifle_assault_foreign",
})
content.add(content.ItemMigration { from = { "ree_33" }, to = "rifle_cannon_foreign" })
content.add(content.ItemMigration {
    from = { "combination_gun", "pipe_combination_gun" },
    to = "rifle_shotgun_combination",
})
content.add(content.ItemMigration { from = { "hk_g80" }, to = "rifle_rail" })
content.add(content.ItemMigration { from = { "AT4", "LAW_Packed", "LAW" }, to = "rocket_disposable" })
content.add(content.ItemMigration {
    from = { "m202_flash", "m3_carlgustav", "m4_carlgustav", "RPG", "surv_rocket_launcher", "khuunaofaai" },
    to = "rocket_recoilless",
})
content.add(content.ItemMigration {
    from = {
        "lever_shotgun",
        "shotgun_d",
        "shotgun_triple",
        "shotgun_s",
        "pipe_shotgun",
        "winchester_1897",
        "browning_citori_20",
    },
    to = "shot_double",
})
content.add(content.ItemMigration {
    from = { "pipe_double_shotgun", "revolver_shotgun", "afs_drotik_shotpistol", "ashot" },
    to = "shot_pipe_double",
})
content.add(content.ItemMigration {
    from = {
        "saiga_410",
        "rm120c",
        "rm228",
        "rm20",
        "saiga_12",
        "afs_raketa_shotgun",
        "tavor_12",
        "dp_12",
        "srm_1216",
        "shotgun_triple",
        "ar12_shotgun",
        "savage_model_220",
        "gfy_1",
        "aa_12",
        "benelli_tsa",
        "bigun",
        "mossberg_590m",
        "USAS_12",
        "m1014",
        "benelli_m4",
    },
    to = "shot_tactical",
})
content.add(content.ItemMigration {
    from = {
        "mossberg_500_410",
        "mossberg_500_20",
        "remington_870_20",
        "benelli_sa",
        "ksg",
        "mossberg_500",
        "mossberg_590",
        "mossberg_930",
        "remington_870",
        "remington_870_express",
        "ithaca37",
        "browning_a5",
        "remington_1100",
    },
    to = "shot_pump",
})
content.add(content.ItemMigration { from = { "mossberg_590_shockwave" }, to = "shot_short_pump" })
content.add(content.ItemMigration { from = { "exodii_plasma_projectile" }, to = "gg_plasma_projectile" })
content.add(content.ItemMigration { from = { "exodii_plasma_fan" }, to = "gg_plasma_fan" })
content.add(content.ItemMigration { from = { "varmint_airgun" }, to = "pellet_airgun" })
content.add(content.ItemMigration { from = { "m26_mass_standalone" }, to = "small_shotgun" })
content.add(content.ItemMigration { from = { "nl_chem_thrower" }, to = "gg_nl_chem_thrower" })

-- gunmods/gg_gunmods_migration.json
content.add(content.ItemMigration { from = { "m203", "m320_mod" }, to = "grenade_under" })
content.add(content.ItemMigration { from = { "m320_mod_mod", "m203_mod" }, to = "grenade_under_mod" })
content.add(content.ItemMigration { from = { "masterkey", "rm121aux", "u_shotgun" }, to = "shotgun_under" })
content.add(content.ItemMigration { from = { "masterkey_mod", "rm121aux_mod" }, to = "shotgun_under_mod" })
content.add(content.ItemMigration {
    from = { "combination_gun_shotgun" },
    to = "rifle_shotgun_combination_shotgun",
})

-- magazines/gg_magazines_migration.json
content.add(content.ItemMigration { from = { "belt40mm" }, to = "grenade_belt" })
content.add(content.ItemMigration {
    from = {
        "ppkmag",
        "p226mag_12rd_357sig",
        "p320mag_13rd_357sig",
        "rugerlcpmag",
        "hptcf380mag_8rd",
        "hptcf380mag_10rd",
        "m1911mag_10rd_38super",
        "m9mag",
        "m9mag_10rd",
        "m9mag_17rd",
        "m9mag_18rd",
        "m9mag_20rd",
        "makarovmag",
        "glock40mag",
        "glock40mag_10",
        "sig40mag",
        "bhp40mag",
        "hptjcpmag",
        "m1911mag",
        "usp45mag",
        "ppq45mag",
        "fn57mag",
        "fn57mag_10rd",
        "tokarevmag",
        "glockmag",
        "glockmag_10",
        "ruger_57mag",
        "ruger_57_10_round_mag",
        "glock17_17",
        "glock17_10",
        "usp9mag",
        "usp9mag_10rd",
        "usp9mag_18rd",
        "usp9mag_20rd",
        "usp9mag_32rd",
        "p320mag_10rd_9x19mm",
        "p320mag_17rd_9x19mm",
        "p320mag_21rd_9x19mm",
        "bhp9mag_13rd",
        "bhp9mag_15rd",
        "p38mag",
        "ppq9mag_10rd",
        "ppq9mag_15rd",
        "ppq9mag_17rd",
        "hptc9mag_8rd",
        "hptc9mag_10rd",
        "hptc9mag_15rd",
        "cz75mag_10rd",
        "cz75mag_16rd",
        "cz75mag_20rd",
        "p08mag_8rd",
        "clip9mm_10rd",
        "ccpmag",
        "ccpmag_9rd",
        "px4mag",
        "px4mag_10rd",
        "px4mag_15rd",
        "px4mag_20rd",
        "px4_40mag_10",
        "px4_40mag",
        "glock_20mag_10",
        "glock_20mag",
        "glock_21mag_10",
        "glock_21mag",
        "glock_21mag26",
        "glock_29mag",
        "m1911_10mag",
        "p220_10_mag",
        "xd_10_mag",
        "witness_mag_10",
        "btmp9mag_9x19mm_10rd",
        "btmp9mag_9x19mm_15",
        "btmp9mag_9x19mm_20",
        "btmp9mag_9x19mm_25",
        "btmp9mag_9x19mm_30",
        "btmp9mag_9x19mm_50rd",
        "p226mag_10rd_9x19mm",
        "p228mag_13rd_9x19mm",
        "p226mag_15rd_9x19mm",
        "p226mag_10rd_9mm",
        "p226mag_15rd_9mm",
        "sp2022mag_10rd_9mm",
        "sp2022mag_12rd_9mm",
        "sp2022mag_15rd_9mm",
        "hpt3895mag_10rd",
        "p365_mag",
        "swbodyguard_mag",
        "glock36_mag",
        "glock40mag_9",
        "glock43_mag",
        "glock43x/48_mag",
        "glock42_mag",
    },
    to = "pistol_mag",
})
content.add(content.ItemMigration {
    from = { "deaglemag", "deaglemag_357", "deaglemag_50", "hptjhpmag", "8x40_10_mag" },
    to = "pistol_magnum_mag",
})
content.add(content.ItemMigration {
    from = {
        "skorpion61mag",
        "mac11mag",
        "glock40bigmag",
        "smg_40_mag",
        "m1911bigmag",
        "mac10mag",
        "smg_45_mag",
        "tdi_mag",
        "thompson_bigmag",
        "thompson_drum",
        "thompson_mag",
        "thompson_makeshiftmag",
        "ump45mag",
        "ump45_makeshiftmag",
        "ump40mag",
        "ump9mag",
        "fnp90mag",
        "fnp90mag_10rd",
        "robofacmultimag",
        "5x50_100_mag",
        "5x50_50_mag",
        "ppshdrum",
        "ppshmag",
        "calicomag",
        "calicomag_100rd",
        "glockbigmag",
        "glock17_22",
        "glock_drum_50rd",
        "glock_drum_100rd",
        "m9bigmag",
        "m9mag_32rd",
        "m9mag_35rd",
        "mp5mag_100rd",
        "mp5bigmag",
        "mp5mag_40rd",
        "mp5mag_38rd",
        "mp5mag",
        "mp5mag_20rd",
        "mp5mag_15rd",
        "mp5mag_10rd",
        "p08mag_32rd",
        "mp40mag_32rd",
        "stenmag",
        "survivor9mm_mag",
        "tec9mag",
        "tec9mag_10rd",
        "tec9mag_20rd",
        "tec9mag_30rd",
        "tec9mag_36rd",
        "tec9mag_50rd",
        "tec9mag_72rd",
        "uzimag",
        "uzimag_20rd",
        "uzimag_25rd",
        "uzimag_40rd",
        "uzimag_50rd",
        "uzimag_100rd",
        "cz75mag_26rd",
        "skorpion82mag",
        "mp5_10_mag",
        "tdi_10mm_mag",
        "robofac60",
        "greasegun30mag",
        "greasegun32mag",
    },
    to = "pistol_smg_mag",
})
content.add(content.ItemMigration {
    from = {
        "22_speedloader8",
        "38_speedloader",
        "afs_8x40_speedloader5",
        "38_speedloader5",
        "38_speedloader6",
        "40_speedloader6",
        "44_speedloader6",
        "454_speedloader5",
        "454_speedloader6",
        "500_speedloader5",
        "8x40_speedloader5",
        "9mm_speedloader7",
        "marlin_tubeloader",
    },
    to = "pistol_speedloader",
})
content.add(content.ItemMigration {
    from = {
        "mosquitomag",
        "ruger1022bigmag",
        "ruger1022mag",
        "ruger1022mag_15",
        "ruger1022mag_30",
        "ruger1022mag_32",
        "ruger1022mag_55",
        "ruger1022mag_70",
        "ruger1022mag_110",
        "sw22mag",
        "j22mag",
        "wp22mag",
        "kp32mag",
        "lws32mag",
        "ruger_mk4_mag",
        "1911_22_mag",
        "sr22_mag",
        "glock44_mag",
        "mp1522_mag",
    },
    to = "pistol_tiny_mag",
})
content.add(content.ItemMigration { from = { "belt223", "belt308" }, to = "rifle_belt" })
content.add(content.ItemMigration { from = { "m107a1mag", "as50mag", "tac50mag" }, to = "rifle_huge_amr_mag" })
content.add(content.ItemMigration { from = { "belt50" }, to = "rifle_huge_belt" })
content.add(content.ItemMigration {
    from = {
        "augmag_10rd",
        "augmag_30rd",
        "augmag_42rd",
        "augmag_100rd",
        "stanag20",
        "stanag20ranger",
        "stanag30",
        "stanag30ranger",
        "stanag40",
        "stanag40ranger",
        "stanag50",
        "stanag60",
        "stanag60drum",
        "stanag90",
        "stanag100",
        "stanag100drum",
        "stanag150",
        "stanag20_beowulf",
        "stanag20ranger_beowulf",
        "stanag30_beowulf",
        "stanag30ranger_beowulf",
        "50beowulf_ar15mag",
        "450_ar15mag",
        "762_ar15mag_5rd",
        "762_ar15mag_10rd",
        "762_ar15mag_20rd",
        "762_ar15mag_30rd",
        "ruger_arr_mag",
        "sl8mag",
        "blrmag",
        "m1918bigmag",
        "m1918mag",
        "falbigmag",
        "falmag",
        "g3bigmag",
        "g3mag",
        "m14mag",
        "ruger20",
        "ruger30",
        "ruger90",
        "ruger100",
        "scarhbigmag",
        "scarhmag_30rd",
        "scarhmag",
        "scarhmag_10",
        "hk417mag_20rd",
        "ar10mag_20rd",
        "ar10mag_10rd",
        "ar10mag_25rd",
        "ar10mag_50rd",
        "ak74mag",
        "rpk74mag",
        "casket74mag",
        "akmag10",
        "akmag20",
        "akmag30",
        "akmag40",
        "akmag90",
        "akdrum75",
        "vz58mag30",
        "vz58mag10",
        "8x40_100_mag",
        "8x40_250_mag",
        "8x40_25_mag",
        "8x40_500_mag",
        "8x40_50_mag",
        "famasmag",
        "robofac40",
        "xedra40",
        "robofac100",
        "robofac50",
        "usc10mag",
        "usc15mag",
        "usc20mag",
        "m1carbinemag",
        "m1carbinebigmag",
        "zpap85mag",
        "zpap85mag_10rd",
        "papm77mag",
        "papm77mag_10rd",
        "22_ar15mag_10",
        "22_ar15mag_28",
    },
    to = "rifle_mag",
})
content.add(content.ItemMigration {
    from = {
        "m2010mag",
        "ruger5",
        "ruger10",
        "stanag5",
        "stanag5ranger",
        "stanag10",
        "stanag10ranger",
        "survivor223mag",
        "ruger_makeshiftmag",
        "3006_clip",
        "garandclip",
        "enfield_303mag",
        "clip303_5rd",
        "clip_77mm_arisaka",
        "fal_makeshiftmag",
        "g3_makeshiftmag",
        "m14smallmag",
        "m14_makeshiftmag",
        "scarh_makeshiftmag",
        "hk417mag_10rd",
        "hk417_makeshiftmag",
        "ar10_makeshiftmag",
        "762x39_clip",
        "pslmag5",
        "pslmag10",
        "762R_clip",
        "ai_338mag",
        "ai_338mag_10",
        "ai_308mag_10",
        "mrad_338lapua_mag",
        "ruger_pr_mag",
        "steyr_scout_mag",
        "steyr_scout_mag_makeshift",
        "borealmosin_clip",
        "robofac20",
    },
    to = "rifle_sniper_mag",
})
content.add(content.ItemMigration {
    from = { "exodiiBRmag", "exodiiBRmag_153", "exodiiBRmag_26", "robofac60_123ln" },
    to = "rifle_mag_foreign",
})
content.add(content.ItemMigration { from = { "exodiiminimag" }, to = "rifle_sniper_mag_foreign" })
content.add(content.ItemMigration { from = { "ree_33_4_mag" }, to = "rifle_mag_cannon" })
content.add(content.ItemMigration { from = { "ree_33_53_mag" }, to = "rifle_mag_cannon_big" })
content.add(content.ItemMigration { from = { "hk_g80mag" }, to = "rifle_rail_mag" })
content.add(content.ItemMigration { from = { "caotel_plasma_ring" }, to = "gg_plasma_mag" })
content.add(content.ItemMigration { from = { "nl_chem_thrower_mag" }, to = "gg_nl_chem_thrower_mag" })
content.add(content.ItemMigration { from = { "clip223_10rd" }, to = "rifle_clip" })
content.add(content.ItemMigration {
    from = {
        "saiga410mag_10rd",
        "saiga410mag_30rd",
        "saiga10mag",
        "saiga30mag",
        "srm_1216_mag_16",
        "mka_1919_5",
        "mka_1919_10",
        "mka_1919_20",
        "afs_raketa30mag",
        "afs_shot_speedloader8",
        "USAS10mag",
        "USAS20mag",
        "shotbelt_20",
        "20x66_10_mag",
        "20x66_20_mag",
        "20x66_40_mag",
        "savage_220_magazine",
        "robofac10",
        "xedra10",
        "robofac30",
        "aa12_box_mag",
        "aa12_drum_mag",
        "aa12_vehicle_drum",
        "mossberg_590m_mag_5",
        "mossberg_590m_mag_10",
        "mossberg_590m_mag_15",
        "mossberg_590m_mag_20",
        "m26_mass_mag_3",
        "m26_mass_mag_5",
    },
    to = "shot_mag",
})
content.add(content.ItemMigration { from = { "shot_speedloader6", "shot_speedloader8" }, to = "shot_speedloader" })
