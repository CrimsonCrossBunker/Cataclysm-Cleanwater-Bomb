local content = require("ccb").content

-- obsoletion_and_migration_0.I/migration_items.json
content.add(content.ItemMigration { from = "depowered_armor", to = "combat_exoskeleton_light_salvaged" })
content.add(content.ItemMigration { from = "dinosuit", to = "fursuit", variant = "dinosuit" })
content.add(content.ItemMigration { from = "wolfsuit", to = "fursuit", variant = "wolfsuit" })
content.add(content.ItemMigration { from = "felinesuit", to = "fursuit", variant = "felinesuit" })
content.add(content.ItemMigration { from = "dragonsuit", to = "fursuit", variant = "dragonsuit" })
content.add(content.ItemMigration { from = "sharksuit", to = "fursuit", variant = "sharksuit" })
content.add(content.ItemMigration { from = "depowered_helmet", to = "combat_exoskeleton_armor_head_light" })
content.add(content.ItemMigration { from = "streetsweeper", to = "dp_12" })
content.add(content.ItemMigration { from = "power_armor_frame", to = "qt_steel_chunk" })
content.add(content.ItemMigration { from = "fake_anvil_crude", to = "fake_anvil" })
content.add(content.ItemMigration { from = "power_armor_generator", to = "qt_steel_chunk" })
content.add(content.ItemMigration { from = "plasma_gun", to = "exodii_plasma_projectile" })
content.add(content.ItemMigration { from = "plasma_rifle", to = "exodii_plasma_projectile" })
content.add(content.ItemMigration {
    from = "power_armor_helmet_basic",
    to = "combat_exoskeleton_armor_head_medium",
})
content.add(content.ItemMigration {
    from = "power_armor_helmet_basic_on",
    to = "combat_exoskeleton_armor_head_medium",
})
content.add(content.ItemMigration {
    from = "power_armor_helmet_light",
    to = "combat_exoskeleton_armor_head_light",
})
content.add(content.ItemMigration {
    from = "power_armor_helmet_light_on",
    to = "combat_exoskeleton_armor_head_light",
})
content.add(content.ItemMigration {
    from = "power_armor_helmet_heavy",
    to = "combat_exoskeleton_armor_head_heavy",
})
content.add(content.ItemMigration {
    from = "power_armor_helmet_heavy_on",
    to = "combat_exoskeleton_armor_head_heavy",
})
content.add(content.ItemMigration { from = "power_armor_basic", to = "combat_exoskeleton_medium" })
content.add(content.ItemMigration { from = "power_armor_basic_on", to = "combat_exoskeleton_medium_on" })
content.add(content.ItemMigration { from = "power_armor_light", to = "combat_exoskeleton_light" })
content.add(content.ItemMigration { from = "power_armor_light_on", to = "combat_exoskeleton_light_on" })
content.add(content.ItemMigration { from = "power_armor_heavy", to = "combat_exoskeleton_heavy" })
content.add(content.ItemMigration { from = "power_armor_heavy_on", to = "combat_exoskeleton_heavy_on" })
content.add(content.ItemMigration {
    from = "lobotomizer",
    to = "box_medium_wood",
    contents = { { id = "lc_steel_lump", count = 6 } },
})
content.add(content.ItemMigration { from = "tshirt_text", to = "tshirt" })
content.add(content.ItemMigration { from = "flag_shirt", to = "tshirt", variant = "flag_shirt" })
content.add(content.ItemMigration { from = "linuxtshirt", to = "tshirt" })
content.add(content.ItemMigration { from = "tshirt_tour", to = "tshirt", variant = "death" })
content.add(content.ItemMigration { from = "fridge", to = "apartment_fridge" })
content.add(content.ItemMigration { from = "freezer", to = "apartment_freezer" })
content.add(content.ItemMigration { from = "mold_plastic", to = "vac_mold" })
content.add(content.ItemMigration { from = "gambeson_loose", to = "gambeson" })
content.add(content.ItemMigration {
    from = "miner_hat",
    to = "hat_hard",
    contents = { { id = "flashlight", count = 1 } },
})
content.add(content.ItemMigration {
    from = "miner_hat_on",
    to = "hat_hard",
    contents = { { id = "flashlight", count = 1 } },
})
content.add(content.ItemMigration { from = "ts12_aux_shotgun", to = "m26_mass" })
content.add(content.ItemMigration { from = "ts12_aux_shotgun2", to = "m26_mass" })
content.add(content.ItemMigration { from = "gambeson_loose_vest", to = "gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "k_gambeson", to = "gambeson_nylon" })
content.add(content.ItemMigration { from = "egg_lady_bug_giant", to = "egg_lady_bug" })
content.add(content.ItemMigration { from = "spider_egg", to = "egg_spider_web" })
content.add(content.ItemMigration { from = "spider_egg", to = "egg_spider_web" })
content.add(content.ItemMigration { from = "egg_frog", to = "egg_gray_frog" })
content.add(content.ItemMigration { from = "egg_toad", to = "egg_freedom_toad" })
content.add(content.ItemMigration { from = "superalloy_harness_dog", to = "kevlar_harness" })
content.add(content.ItemMigration { from = "k_gambeson_vest", to = "gambeson_vest" })
content.add(content.ItemMigration { from = "l-stick", to = "flashlight" })
content.add(content.ItemMigration { from = "k_gambeson_loose", to = "gambeson_nylon" })
content.add(content.ItemMigration { from = "k_gambeson_vest_loose", to = "gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "k_gambeson_pants", to = "gambeson_pants_nylon" })
content.add(content.ItemMigration { from = "gambeson_xs_loose", to = "gambeson_xs" })
content.add(content.ItemMigration { from = "gambeson_vest_xs_loose", to = "gambeson_vest_xs" })
content.add(content.ItemMigration { from = "xl_gambeson_loose", to = "xl_gambeson" })
content.add(content.ItemMigration { from = "xl_gambeson_vest_loose", to = "xl_gambeson_vest" })
content.add(content.ItemMigration { from = "xl_k_gambeson", to = "xl_gambeson_nylon" })
content.add(content.ItemMigration { from = "xl_k_gambeson_vest", to = "xl_gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "k_gambeson_xs", to = "xs_gambeson_nylon" })
content.add(content.ItemMigration { from = "k_gambeson_vest_xs", to = "xs_gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "xl_k_gambeson_pants", to = "xl_gambeson_pants_nylon" })
content.add(content.ItemMigration { from = "xl_k_gambeson_loose", to = "xl_gambeson_pants_nylon" })
content.add(content.ItemMigration { from = "xl_k_gambeson_vest_loose", to = "xl_gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "k_gambeson_vest_xs_loose", to = "xl_gambeson_nylon_vest" })
content.add(content.ItemMigration { from = "k_gambeson_hood", to = "gambeson_hood" })
content.add(content.ItemMigration { from = "xl_k_gambeson_hood", to = "xl_gambeson_hood" })
content.add(content.ItemMigration { from = "xs_k_gambeson_hood", to = "xs_gambeson_hood" })
content.add(content.ItemMigration { from = "l-stick_on", to = "flashlight" })
content.add(content.ItemMigration { from = "mil_mess_kit", to = "mess_kit" })
content.add(content.ItemMigration { from = "5x50dart", to = "50match" })
content.add(content.ItemMigration { from = "5x50heavy", to = "50match" })
content.add(content.ItemMigration { from = "reloaded_5x50dart", to = "reloaded_50bmg" })
content.add(content.ItemMigration { from = "5x50_100_mag", to = "stanag100" })
content.add(content.ItemMigration { from = "5x50_50_mag", to = "stanag50" })
content.add(content.ItemMigration { from = "needlegun", to = "nailgun" })
content.add(content.ItemMigration { from = "needlepistol", to = "nailgun" })
content.add(content.ItemMigration { from = "5x50_hull", to = "shot_hull" })
content.add(content.ItemMigration { from = "AID_bio_alarm", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_tattoo_led", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_power_armor_interface", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_power_storage", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_power_storage_mkII", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_watch", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_syringe", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_blood_anal", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_flashlight", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_magnet", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_soporific", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_armor_arms", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_armor_legs", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_shotgun", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_blood_filter", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_climate", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_geiger", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_heatsink", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_meteorologist", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_ups", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_weight", to = "letter" })
content.add(content.ItemMigration { from = "AID_bio_trickle", to = "bio_betavoltaic" })
content.add(content.ItemMigration { from = "AID_bio_pitch_perfect", to = "letter" })
content.add(content.ItemMigration {
    from = "waterproof_smart_phone_case_migration",
    to = "waterproof_smart_phone_case",
})
content.add(content.ItemMigration { from = "schematics_eyebot", to = "novel_scifi" })
content.add(content.ItemMigration { from = "schematics_copbot", to = "novel_scifi" })
content.add(content.ItemMigration { from = "schematics_riotbot", to = "novel_scifi" })
content.add(content.ItemMigration { from = "bot_copbot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "bot_eyebot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "bot_riotbot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "broken_eyebot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "broken_copbot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "broken_riotbot", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "RPG", to = "m3_carlgustav" })
content.add(content.ItemMigration { from = "RPG-7_ammo", to = "84x246mm_he" })
content.add(content.ItemMigration { from = "RPG-7_pg7vr", to = "84x246mm_he" })
content.add(content.ItemMigration { from = "RPG-7_tbg7v", to = "84x246mm_he" })
content.add(content.ItemMigration { from = "RPG-7_og7v", to = "84x246mm_he" })
content.add(content.ItemMigration { from = "broken_mininuke_hack", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "mininuke_payload", to = "broken_science_bot" })
content.add(content.ItemMigration { from = "rm802", to = "m203" })
content.add(content.ItemMigration { from = "aux_pressurized_tank", to = "pressurized_tank" })
content.add(content.ItemMigration { from = "skorpion_61", to = "hk_mp5" })
content.add(content.ItemMigration { from = "skorpion61mag", to = "mp5mag" })
content.add(content.ItemMigration { from = "skorpion_82", to = "hk_mp5" })
content.add(content.ItemMigration { from = "skorpion82mag", to = "mp5mag" })
content.add(content.ItemMigration { from = "8mm_civilian", to = "8mm_caseless" })
content.add(content.ItemMigration { from = "8mm_fmj", to = "8mm_caseless" })
content.add(content.ItemMigration { from = "8mm_hvp", to = "8mm_caseless" })
content.add(content.ItemMigration { from = "8mm_inc", to = "8mm_caseless" })
content.add(content.ItemMigration { from = "rm298", to = "m240" })
content.add(content.ItemMigration { from = "mask_wsurvivor_nofur", to = "scarf_faux_fur" })
content.add(content.ItemMigration { from = "mask_wsurvivorxl_nofur", to = "scarf_faux_fur" })
content.add(content.ItemMigration { from = "mask_wsurvivor_nofur_xs", to = "scarf_faux_fur" })
content.add(content.ItemMigration { from = "mask_wsurvivor", to = "balclava" })
content.add(content.ItemMigration { from = "mask_wsurvivorxl", to = "balclava" })
content.add(content.ItemMigration { from = "mask_wsurvivorxs", to = "balclava" })
content.add(content.ItemMigration { from = "chainmail_hauberk", to = "lc_chainmail_hauberk" })
content.add(content.ItemMigration { from = "chainmail_suit", to = "mc_chainmail_suit" })
content.add(content.ItemMigration { from = "armor_plate", to = "armor_lc_plate" })
content.add(content.ItemMigration { from = "armor_lightplate", to = "armor_mc_lightplate" })
content.add(content.ItemMigration { from = "xl_armor_lightplate", to = "xl_armor_mc_plate" })
content.add(content.ItemMigration { from = "xs_armor_lightplate", to = "xs_hsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "chainmail_hood", to = "lc_chainmail_hood" })
content.add(content.ItemMigration { from = "chainmail_vest", to = "lc_chainmail_vest" })
content.add(content.ItemMigration { from = "chainmail_arms", to = "mc_chainmail_arms" })
content.add(content.ItemMigration { from = "chainmail_hands", to = "mc_chainmail_hands" })
content.add(content.ItemMigration { from = "chainmail_legs", to = "mc_chainmail_legs" })
content.add(content.ItemMigration { from = "chainmail_feet", to = "mc_chainmail_feet" })
content.add(content.ItemMigration { from = "m2browning_sawn", to = "m2browning" })
content.add(content.ItemMigration { from = "contacts", to = "bifocal_contacts_weekly" })
content.add(content.ItemMigration { from = "transition_contacts", to = "bifocal_transition_contacts_weekly" })
content.add(content.ItemMigration {
    from = "mean_mug",
    to = "ceramic_mug",
    variant = "mean_mug",
    reset_item_vars = true,
})
content.add(content.ItemMigration {
    from = "nice_mug",
    to = "ceramic_mug",
    variant = "mean_mug2",
    reset_item_vars = true,
})
content.add(content.ItemMigration {
    from = "hk_ump45",
    to = "modular_ump",
    contents = { { id = "retool_ump_45", count = 1 } },
})
content.add(content.ItemMigration { from = "bio_trickle", to = "bio_betavoltaic" })
content.add(content.ItemMigration {
    from = "ballistic_vest_heavy_arms",
    to = "ballistic_vest_heavy",
    contents = { { id = "iotv_shoulder_plate", count = 1 }, { id = "iotv_neck_plate", count = 1 } },
})
content.add(content.ItemMigration {
    from = "ballistic_vest_heavy_legs",
    to = "ballistic_vest_heavy",
    contents = { { id = "iotv_groin_plate", count = 1 }, { id = "iotv_neck_plate", count = 1 } },
})
content.add(content.ItemMigration { from = "conical_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "plumber_cap", to = "hat_ball" })
content.add(content.ItemMigration { from = "leather_hatball", to = "hat_ball" })
content.add(content.ItemMigration { from = "vizor_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "lvizor_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "trucker_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "ltrucker_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "flatbread_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "bread_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "brown_bread_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "buttered_toast_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "jam_toast_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "peanut_butter_toast_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "toad_in_a_hole_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "PBJ_Toast_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "toast_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_fairy_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "soup_blood_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "fried_egg_sandwich_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "deluxe_fried_egg_sandwich_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "chilidogs_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "hotdogs_newyork_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "cheeseburger_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "hamburger_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sloppyjoe_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "blood_pancakes_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_cheese_grilled_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_deluxe_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_reuben_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_cucumber_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_cheese_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_jam_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_jam_cheese_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_jam_butter_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_honey_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_veggy_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_t_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_pb_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_pbj_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_pbh_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_pbm_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "fish_sandwich_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "blt_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "chicken_sandwich_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "hotdogs_cooked_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_egg_salad_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_sauce_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "chicken_sandwich_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "sandwich_veggy_cheese_wheat_free", to = "bread" })
content.add(content.ItemMigration { from = "light_minus_atomic_battery_cell", to = "light_minus_disposable_cell" })
content.add(content.ItemMigration { from = "light_plus_battery_cell", to = "light_battery_cell" })
content.add(content.ItemMigration { from = "light_atomic_battery_cell", to = "light_battery_cell" })
content.add(content.ItemMigration { from = "light_disposable_cell", to = "light_battery_cell" })
content.add(content.ItemMigration { from = "light_dry_cell", to = "light_battery_cell" })
content.add(content.ItemMigration { from = "medium_disposable_cell", to = "medium_battery_cell" })
content.add(content.ItemMigration { from = "medium_plus_battery_cell", to = "medium_battery_cell" })
content.add(content.ItemMigration { from = "medium_atomic_battery_cell", to = "medium_battery_cell" })
content.add(content.ItemMigration { from = "medium_dry_cell", to = "medium_battery_cell" })
content.add(content.ItemMigration { from = "heavy_disposable_cell", to = "heavy_plus_battery_cell" })
content.add(content.ItemMigration { from = "heavy_dry_cell", to = "heavy_plus_battery_cell" })
content.add(content.ItemMigration { from = "scrap_cap1", to = "hat_ball" })
content.add(content.ItemMigration { from = "scrap_cap2", to = "hat_ball" })
content.add(content.ItemMigration { from = "ushanka", to = "hat_fur" })
content.add(content.ItemMigration { from = "coonskin", to = "hat_fur" })
content.add(content.ItemMigration { from = "astrakhan", to = "hat_fur" })
content.add(content.ItemMigration { from = "fushanka", to = "hat_faux_fur" })
content.add(content.ItemMigration { from = "fcoonskin", to = "hat_faux_fur" })
content.add(content.ItemMigration { from = "fastrakhan", to = "hat_faux_fur" })
content.add(content.ItemMigration { from = "propeller_hat", to = "hat_ball" })
content.add(content.ItemMigration { from = "deerstalker", to = "hat_fur" })
content.add(content.ItemMigration { from = "beanie_hat", to = "hat_cotton" })
content.add(content.ItemMigration { from = "k_beanie", to = "hat_knit" })
content.add(content.ItemMigration { from = "chullo_hat", to = "hat_knit" })
content.add(content.ItemMigration { from = "fez", to = "eboshi" })
content.add(content.ItemMigration { from = "homburg_hat", to = "fedora" })
content.add(content.ItemMigration { from = "neckwarmer", to = "scarf" })
content.add(content.ItemMigration { from = "neckwarmer_head", to = "scarf" })
content.add(content.ItemMigration { from = "hat_floppy", to = "10gal_hat" })
content.add(content.ItemMigration { from = "hat_cart", to = "10gal_hat" })
content.add(content.ItemMigration { from = "trilby_hat", to = "porkpie" })
content.add(content.ItemMigration { from = "tyrolean_hat", to = "porkpie" })
content.add(content.ItemMigration { from = "panama_hat", to = "straw_hat" })
content.add(content.ItemMigration { from = "boater_hat", to = "straw_hat" })
content.add(content.ItemMigration { from = "tinfoil_boat", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "tinfoil_hat1", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "tinfoil_fedora", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "tinfoil_hatball", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "paper_boat", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "news_boat", to = "tinfoil_hat" })
content.add(content.ItemMigration { from = "hat_cloche", to = "hat_boonie" })
content.add(content.ItemMigration { from = "hat_bucket", to = "hat_boonie" })
content.add(content.ItemMigration { from = "rag", to = "sheet_cotton" })
content.add(content.ItemMigration { from = "holybook_odin", to = "poetic_edda" })
content.add(content.ItemMigration { from = "holybook_asatru", to = "poetic_edda" })
content.add(content.ItemMigration { from = "wcheckers_man", to = "splinter" })
content.add(content.ItemMigration { from = "bcheckers_man", to = "splinter" })
content.add(content.ItemMigration { from = "rcheckers_man", to = "splinter" })
content.add(content.ItemMigration { from = "becheckers_man", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_pawn", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_knight", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_bishop", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_rook", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_queen", to = "splinter" })
content.add(content.ItemMigration { from = "wchess_king", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_pawn", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_knight", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_bishop", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_rook", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_queen", to = "splinter" })
content.add(content.ItemMigration { from = "bchess_king", to = "splinter" })
content.add(content.ItemMigration { from = "checkpaper", to = "paper" })
content.add(content.ItemMigration { from = "small_checkboard", to = "tinder" })
content.add(content.ItemMigration { from = "checkboard", to = "tinder" })
content.add(content.ItemMigration { from = "handmade_chess", to = "chess" })
content.add(content.ItemMigration { from = "makeshift_chess", to = "chess" })
content.add(content.ItemMigration { from = "handmade_checkers", to = "makeshift_checkers" })
content.add(content.ItemMigration { from = "terraforming_mars", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_venus", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_jupiter", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_saturn", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_uranus", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_neptune", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_pluto", to = "terraforming_mercury" })
content.add(content.ItemMigration { from = "terraforming_earth", to = "terraforming_mercury" })
content.add(content.ItemMigration {
    from = "ammo_can_30_9mm_fmj_1000",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_9mm_fmj_1000",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_9mm_jhp_1000",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_9mm_jhp_1000",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_300jhp_240",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_300jhp_240",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_300AAC_otmss_720",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_300AAC_otmss_720",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_308_1tracer4ap_200",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_308_1tracer4ap_200",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_308ap_240",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_308ap_240",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_308fmj_460",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_308fmj_460",
})
content.add(content.ItemMigration {
    from = "ammo_can_30_308_4fmj1tracer_200",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_308_4fmj1tracer_200",
})
content.add(content.ItemMigration { from = "ammo_can_30_338fmjbt_200", to = "ammunition_can_30" })
content.add(content.ItemMigration {
    from = "ammo_can_30_shot_120",
    to = "ammunition_can_30",
    variant = "ammunition_can_30_shot_120",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_556tracer_820",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_556tracer_820",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_50bmg_4fmj1tracer_100",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_50bmg_4fmj1tracer_100",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_50bmg_1tracer4mk211_100",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_50bmg_1tracer4mk211_100",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_50bmg_fmj_120",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_50bmg_fmj_120",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_556_m855a1_clipped_840",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_556_m855a1_clipped_840",
})
content.add(content.ItemMigration { from = "ammo_can_50_300AAC_otm_840", to = "ammunition_can_50" })
content.add(content.ItemMigration {
    from = "ammo_can_50_308_600",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_308_600",
})
content.add(content.ItemMigration { from = "ammo_can_50_338fmjbt_400", to = "ammunition_can_50" })
content.add(content.ItemMigration {
    from = "ammo_can_50_shot_160",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_shot_160",
})
content.add(content.ItemMigration {
    from = "ammo_can_50_beanbag_160",
    to = "ammunition_can_50",
    variant = "ammunition_can_50_beanbag_160",
})
content.add(content.ItemMigration {
    from = "ammo_can_fat_50_223_1tracer4ball_800",
    to = "ammunition_can_fat_50",
    variant = "ammunition_can_fat_50_223_1tracer4ball_800",
})
content.add(content.ItemMigration {
    from = "ammo_can_fat_50_223_1tracer4ap_800",
    to = "ammunition_can_fat_50",
    variant = "ammunition_can_fat_50_223_1tracer4ap_800",
})
content.add(content.ItemMigration {
    from = "ammo_can_fat_50_223ap_800",
    to = "ammunition_can_fat_50",
    variant = "ammunition_can_fat_50_223ap_800",
})
content.add(content.ItemMigration {
    from = "ammo_can_fat_50_223fmj_800",
    to = "ammunition_can_fat_50",
    variant = "ammunition_can_fat_50_223fmj_800",
})
content.add(content.ItemMigration {
    from = "ammo_can_fat_50_308_1tracer4ap_600",
    to = "ammunition_can_fat_50",
    variant = "ammunition_can_fat_50_308_1tracer4ap_600",
})
content.add(content.ItemMigration {
    from = "ammo_can_pa120_40x53_32",
    to = "ammunition_can_pa120",
    variant = "ammunition_can_pa120_40x53_32",
})
content.add(content.ItemMigration {
    from = "ammunition_can_carlgustav_hedp",
    to = "ammunition_can_carlgustav",
    variant = "ammunition_can_carlgustav_hedp",
})
content.add(content.ItemMigration {
    from = "ammunition_can_carlgustav_he",
    to = "ammunition_can_carlgustav",
    variant = "ammunition_can_carlgustav_he",
})
content.add(content.ItemMigration {
    from = "ammunition_box_carlgustav_he",
    to = "ammunition_box_carlgustav",
    variant = "ammunition_box_carlgustav_he",
})
content.add(content.ItemMigration {
    from = "ammunition_box_carlgustav_hedp",
    to = "ammunition_box_carlgustav",
    variant = "ammunition_box_carlgustav_hedp",
})
content.add(content.ItemMigration { from = "ak74", to = "ak74_semi" })
content.add(content.ItemMigration { from = "bh_m89", to = "henry_big_boy" })
content.add(content.ItemMigration { from = "rifle_9mm", to = "rifle_38" })
content.add(content.ItemMigration { from = "rifle_9x18", to = "rifle_38" })
content.add(content.ItemMigration { from = "rifle_45", to = "rifle_38" })
content.add(content.ItemMigration { from = "rifle_40", to = "rifle_38" })
content.add(content.ItemMigration { from = "rifle_380", to = "rifle_38" })
content.add(content.ItemMigration { from = "rifle_32", to = "rifle_38" })
content.add(content.ItemMigration { from = "lemat_revolver", to = "colt_saa" })
content.add(content.ItemMigration { from = "lemat_revolver_shotgun", to = "u_shotgun" })
content.add(content.ItemMigration { from = "shot_paper_slug", to = "44army" })
content.add(content.ItemMigration { from = "shot_paper_bird", to = "44army" })
content.add(content.ItemMigration { from = "shot_paper_00", to = "44army" })
content.add(content.ItemMigration { from = "shot_paper_dragon", to = "44army" })
content.add(content.ItemMigration { from = "lever_shotgun", to = "remington_870" })
content.add(content.ItemMigration { from = "famas", to = "rdb_223" })
content.add(content.ItemMigration { from = "famasmag", to = "stanag30" })
content.add(content.ItemMigration { from = "cz75mag_12rd", to = "cz75mag_16rd" })
content.add(content.ItemMigration { from = "bottle_suppressor", to = "filter_suppressor" })
content.add(content.ItemMigration { from = "riv_suppressor", to = "suppressor" })
content.add(content.ItemMigration { from = "surv_six_shooter", to = "hptjcpmag" })
content.add(content.ItemMigration { from = "surv_hand_cannon", to = "hptjhpmag" })
content.add(content.ItemMigration { from = "con_mix", to = "con_mix_foldable", reset_item_vars = true })
content.add(content.ItemMigration { from = "raw_lentils", to = "dry_lentils" })
content.add(content.ItemMigration { from = "uno", to = "deck_of_cards", variant = "uno" })
content.add(content.ItemMigration { from = "onirim", to = "deck_of_cards", variant = "onirim" })
content.add(content.ItemMigration { from = "cards_magic", to = "deck_of_cards", variant = "cards_magic" })
content.add(content.ItemMigration {
    from = "deck_of_cards_makeshift",
    to = "deck_of_cards",
    variant = "deck_of_cards_makeshift",
})
content.add(content.ItemMigration { from = "mp18", to = "p08" })
content.add(content.ItemMigration { from = "plr16", to = "rdb_223" })
content.add(content.ItemMigration { from = "oa93", to = "rdb_223" })
content.add(content.ItemMigration { from = "m231pfw", to = "rdb_223" })
content.add(content.ItemMigration { from = "moss_brownie", to = "ruger_lcr_22" })
content.add(content.ItemMigration { from = "vz58_p", to = "ak47" })
content.add(content.ItemMigration { from = "vz58ts", to = "aksemi" })
content.add(content.ItemMigration { from = "vz58mag10", to = "akmag10" })
content.add(content.ItemMigration { from = "vz58mag30", to = "akmag30" })
content.add(content.ItemMigration { from = "stowed_fridge", to = "apartment_fridge" })
content.add(content.ItemMigration { from = "stowed_freezer", to = "apartment_freezer" })
content.add(content.ItemMigration { from = "stowed_glass_fridge", to = "glass_fridge" })
content.add(content.ItemMigration { from = "knife_steak", to = "knife_small", variant = "knife_steak" })
content.add(content.ItemMigration { from = "knife_paring", to = "knife_small", variant = "knife_paring" })
content.add(content.ItemMigration { from = "knife_chef", to = "knife_large", variant = "knife_chef" })
content.add(content.ItemMigration { from = "knife_carving", to = "knife_large", variant = "knife_carving" })
content.add(content.ItemMigration { from = "knife_bread", to = "knife_large", variant = "knife_bread" })
content.add(content.ItemMigration { from = "knife_butcher", to = "knife_huge", variant = "knife_butcher" })
content.add(content.ItemMigration {
    from = "knife_meat_cleaver",
    to = "knife_cleaver",
    variant = "knife_meat_cleaver",
})
content.add(content.ItemMigration {
    from = "knife_vegetable_cleaver",
    to = "knife_cleaver",
    variant = "knife_vegetable_cleaver",
})
content.add(content.ItemMigration { from = "spear_survivor", to = "naginata" })
content.add(content.ItemMigration { from = "j22", to = "ruger_mk4" })
content.add(content.ItemMigration { from = "j22mag", to = "ruger_mk4_mag" })
content.add(content.ItemMigration { from = "sw_22", to = "ruger_mk4" })
content.add(content.ItemMigration { from = "sw22mag", to = "ruger_mk4_mag" })
content.add(content.ItemMigration { from = "cop_38", to = "sw_619" })
content.add(content.ItemMigration { from = "fs2000", to = "rdb_223" })
content.add(content.ItemMigration { from = "factory_handguard", to = "grip" })
content.add(content.ItemMigration { from = "mr73", to = "sw_619" })
content.add(content.ItemMigration { from = "acidbomb", to = "sling-ready_molotov" })
content.add(content.ItemMigration { from = "triple_launcher_simple", to = "mgl" })
content.add(content.ItemMigration { from = "launcher_simple", to = "m79" })
content.add(content.ItemMigration { from = "pipe_launcher40mm", to = "m203" })
content.add(content.ItemMigration { from = "hk_g36", to = "sig_assault_rifle" })
content.add(content.ItemMigration { from = "g36mag_30rd", to = "stanag30" })
content.add(content.ItemMigration { from = "g36mag_100rd", to = "stanag100drum" })
content.add(content.ItemMigration {
    from = "superglue",
    to = "small_squeeze_tube",
    contents = { { id = "glue_strong", count = 40 } },
})
content.add(content.ItemMigration { from = "egg_goose_golden", to = "egg_goose" })
content.add(content.ItemMigration { from = "egg_reptile", to = "egg_turtle_painted" })
content.add(content.ItemMigration { from = "ar_pistol", to = "rdb_223" })
content.add(content.ItemMigration { from = "stabilizer", to = "rail_laser_sight" })
content.add(content.ItemMigration { from = "stabilizer_mod", to = "rail_laser_sight" })
content.add(content.ItemMigration { from = "wire", to = "lc_wire" })
content.add(content.ItemMigration { from = "piano_wire", to = "qt_wire" })
content.add(content.ItemMigration { from = "link_sheet", to = "lc_link_sheet" })
content.add(content.ItemMigration { from = "acr_300blk", to = "sig_mcx_rattler_sbr" })
content.add(content.ItemMigration { from = "egg_pattern_frog", to = "egg_leo_frog" })
content.add(content.ItemMigration { from = "egg_strange_frog", to = "egg_bullfrog_frog" })
content.add(content.ItemMigration { from = "egg_foul_toad", to = "egg_fowler_toad" })
content.add(content.ItemMigration { from = "egg_odd_toad", to = "egg_freedom_toad" })
content.add(content.ItemMigration { from = "egg_vocal_frog", to = "egg_peeper_frog" })
content.add(content.ItemMigration { from = "egg_shift_frog", to = "egg_gray_frog" })
content.add(content.ItemMigration { from = "egg_palette_frog", to = "egg_pickerel_frog" })
content.add(content.ItemMigration { from = "egg_vocal_frog", to = "egg_vocal_bigfrog" })
content.add(content.ItemMigration { from = "egg_shift_frog", to = "egg_shift_bigfrog" })
content.add(content.ItemMigration { from = "wire_barbed_baseball", to = "baseball" })
content.add(content.ItemMigration { from = "cx4", to = "m9" })
content.add(content.ItemMigration { from = "STI_DS_10", to = "glock_20" })
content.add(content.ItemMigration { from = "2011_22_mag", to = "tdi_10mm_mag" })
content.add(content.ItemMigration { from = "2011_17_mag", to = "tdi_10mm_mag" })
content.add(content.ItemMigration { from = "kp3at", to = "rugerlcp" })
content.add(content.ItemMigration { from = "kp3atmag", to = "rugerlcpmag" })
content.add(content.ItemMigration { from = "fn1910mag", to = "hptcf380mag_8rd" })
content.add(content.ItemMigration { from = "kpf9", to = "glock_19" })
content.add(content.ItemMigration { from = "kpf9mag", to = "glockmag" })
content.add(content.ItemMigration { from = "kpf9mag_8rd", to = "glockmag" })
content.add(content.ItemMigration { from = "mauser_m714", to = "glock_19" })
content.add(content.ItemMigration { from = "mausermag_20rd", to = "glock17_22" })
content.add(content.ItemMigration { from = "mausermag_10rd", to = "glockmag" })
content.add(content.ItemMigration { from = "taurus_spectrum", to = "rugerlcp" })
content.add(content.ItemMigration { from = "taurus_spectrum_mag", to = "rugerlcpmag" })
content.add(content.ItemMigration { from = "minidraco556", to = "ak556" })
content.add(content.ItemMigration { from = "arx160", to = "ak47" })
content.add(content.ItemMigration { from = "walther_ppq_40", to = "glock_22" })
content.add(content.ItemMigration { from = "ppq40mag_10rd", to = "glock40mag" })
content.add(content.ItemMigration { from = "ppq40mag_12rd", to = "glock40mag" })
content.add(content.ItemMigration { from = "ppq40mag_14rd", to = "glock40mag" })
content.add(content.ItemMigration { from = "90two40", to = "glock_22" })
content.add(content.ItemMigration { from = "90two40mag", to = "glock40mag" })
content.add(content.ItemMigration { from = "sig_p230", to = "walther_ppk" })
content.add(content.ItemMigration { from = "generator_7500w", to = "diesel_generator" })
content.add(content.ItemMigration { from = "active_backup_generator", to = "diesel_generator" })
content.add(content.ItemMigration { from = "sigp230mag", to = "ppkmag" })
content.add(content.ItemMigration { from = "ammo_box_army_20_338", to = "338_ammo_box_20" })
content.add(content.ItemMigration { from = "peanutbutter_imitation", to = "peanutbutter" })
content.add(content.ItemMigration { from = "dragonskin", to = "ballistic_vest_esapi" })
content.add(content.ItemMigration { from = "stillsuit", to = "wetsuit" })
content.add(content.ItemMigration { from = "m1911-460", to = "m1911" })
content.add(content.ItemMigration { from = "460_rowland", to = "45_super" })
content.add(content.ItemMigration { from = "bp_460_fmj", to = "45_super" })
content.add(content.ItemMigration { from = "reloaded_460_fmj", to = "45_super" })
content.add(content.ItemMigration { from = "460_fmj", to = "45_super" })
content.add(content.ItemMigration { from = "bp_460_rowland", to = "45_super" })
content.add(content.ItemMigration { from = "reloaded_460_rowland", to = "45_super" })
content.add(content.ItemMigration { from = "460_casing", to = "45_casing" })
content.add(content.ItemMigration { from = "kiln_full", to = "char_kiln" })
content.add(content.ItemMigration { from = "kiln_lit", to = "char_kiln" })
content.add(content.ItemMigration { from = "kiln_done", to = "char_kiln" })
content.add(content.ItemMigration { from = "40x46mm_buckshot_m118", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_buckshot_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_buckshot_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_slug_m118", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_slug_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_flechette_m118", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "40x46mm_flechette_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "bp_40x46mm_buckshot_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "bp_40x46mm_slug_m118", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "bp_40x46mm_slug_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "bp_40x46mm_flechette_m118", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "bp_40x46mm_flechette_m199", to = "40x46mm_m576" })
content.add(content.ItemMigration { from = "ammo_box_2", to = "box_small" })
content.add(content.ItemMigration {
    from = "ammo_box_army_100_9mm_fmj",
    to = "9mm_ammo_box_100",
    variant = "ammo_box_army_100_9mm_fmj",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_100_9mm_jhp",
    to = "9mm_ammo_box_100",
    variant = "ammo_box_army_100_9mm_jhp",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_20_300wm",
    to = "300_ammo_box_20",
    variant = "ammo_box_army_20_300wm",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_30_300blk",
    to = "223_ammo_box_20",
    variant = "300blk_ammo_box_20",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_10_338",
    to = "4570_ammo_box_20",
    variant = "ammo_box_army_10_338",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_20_223",
    to = "223_ammo_box_20",
    variant = "ammo_box_army_20_223",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_5_shot",
    to = "12_ammo_box_5",
    variant = "ammo_box_army_5_shot",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_5_slug",
    to = "12_ammo_box_5",
    variant = "ammo_box_army_5_slug",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_5_beanbag",
    to = "12_ammo_box_5",
    variant = "ammo_box_army_5_beanbag",
})
content.add(content.ItemMigration {
    from = "ammo_box_army_10_50bmg",
    to = "12_ammo_box_25",
    variant = "ammo_box_army_10_50bmg",
})
content.add(content.ItemMigration { from = "ammo_box_4", to = "12_ammo_box_25" })
content.add(content.ItemMigration { from = "gosling_jacket", to = "jacket_leather" })
content.add(content.ItemMigration {
    from = "jacket_leather_red",
    to = "jacket_leather",
    variant = "jacket_leather_red",
})
content.add(content.ItemMigration { from = "fancy_sunglasses", to = "sunglasses" })
content.add(content.ItemMigration { from = "fancy_sunglasses_eye", to = "sunglasses_eye" })
content.add(content.ItemMigration { from = "fancy_sunglasses_reading", to = "sunglasses_reading" })
content.add(content.ItemMigration { from = "fancy_sunglasses_bifocal", to = "sunglasses_bifocal" })
content.add(content.ItemMigration { from = "fancy_glasses_bifocal", to = "glasses_bifocal" })
content.add(content.ItemMigration { from = "fancy_glasses_reading", to = "glasses_reading" })
content.add(content.ItemMigration { from = "fancy_glasses_eye", to = "glasses_eye" })
content.add(content.ItemMigration { from = "fancy_transition_glasses_reading", to = "sunglasses_reading" })
content.add(content.ItemMigration { from = "fancy_transition_glasses_bifocal", to = "sunglasses_bifocal" })
content.add(content.ItemMigration { from = "fancy_transition_glasses_eye", to = "sunglasses_eye" })
content.add(content.ItemMigration {
    from = "transition_glasses_bifocal",
    to = "sunglasses_bifocal",
    variant = "transition_bifocal_square",
})
content.add(content.ItemMigration {
    from = "transition_glasses_eye",
    to = "sunglasses_eye",
    variant = "transition_corrective_round",
})
content.add(content.ItemMigration {
    from = "transition_glasses_reading",
    to = "sunglasses_reading",
    variant = "transition_reading_aviator",
})
content.add(content.ItemMigration { from = "jeans_red", to = "jeans" })
content.add(content.ItemMigration { from = "muzzle_brake_mod", to = "muzzle_brake" })
content.add(content.ItemMigration { from = "offset_sights_mod", to = "offset_sights" })
content.add(content.ItemMigration { from = "offset_sight_rail_mod", to = "offset_sight_rail" })
content.add(content.ItemMigration { from = "rifle_scope_mod", to = "rifle_scope" })
content.add(content.ItemMigration { from = "acog_scope_mod", to = "acog_scope" })
content.add(content.ItemMigration { from = "bipod_mod", to = "bipod" })
content.add(content.ItemMigration { from = "u_shotgun_mod", to = "u_shotgun" })
content.add(content.ItemMigration { from = "internal_mp3", to = "manual_swimming" })
content.add(content.ItemMigration { from = "suit_bostonchan", to = "blazer", variant = "bostonchan" })
content.add(content.ItemMigration { from = "light_grip", to = "grip" })
content.add(content.ItemMigration { from = "pistol_grip", to = "grip" })
content.add(content.ItemMigration { from = "breacher_grip", to = "grip" })
content.add(content.ItemMigration {
    from = "sheriffshirt",
    to = "postman_shirt",
    from_variant = "sheriff",
    variant = "sheriff",
})
content.add(content.ItemMigration {
    from = "sheriffshirt",
    to = "postman_shirt",
    from_variant = "swat_shirt",
    variant = "swat",
})
content.add(content.ItemMigration { from = "subsuit_xl", to = "jumpsuit_pocketless", variant = "orange" })
content.add(content.ItemMigration { from = "striped_shirt", to = "buttonshirt", variant = "striped" })
content.add(content.ItemMigration { from = "dress", to = "long_dress" })
content.add(content.ItemMigration {
    from = "witch_dress_short",
    to = "short_dress_sleeved",
    variant = "witch_black",
})
content.add(content.ItemMigration {
    from = "witch_dress_long",
    to = "long_dress_sleeved",
    variant = "witch_black",
})
content.add(content.ItemMigration { from = "witch_dress", to = "dress_sleeved", variant = "witch_black" })
content.add(content.ItemMigration { from = "sinister_gown", to = "gown_sleeved", variant = "sinister" })
content.add(content.ItemMigration {
    from = "sinister_dress_short",
    to = "short_dress_sleeved",
    variant = "sinister",
})
content.add(content.ItemMigration { from = "long_dress", to = "gown", from_variant = "gown" })
content.add(content.ItemMigration { from = "robofac_jumpsuit", to = "jumpsuit", variant = "robofac" })
content.add(content.ItemMigration { from = "balaclava_skull", to = "balclava", variant = "skull" })
content.add(content.ItemMigration { from = "mask_guy_fawkes", to = "mask_skull", variant = "guy_fawkes" })
content.add(content.ItemMigration { from = "robofac_head_rig_ir", to = "robofac_head_rig_nv" })
content.add(content.ItemMigration { from = "exodii_ingot_steel", to = "exodii_ingot_lc_steel" })
content.add(content.ItemMigration { from = "clay_quern", to = "rock_quern" })
content.add(content.ItemMigration { from = "bowling_axe", to = "hatchet" })
content.add(content.ItemMigration { from = "spear_forked", to = "spear_spike" })
content.add(content.ItemMigration { from = "draco", to = "aksemi" })
content.add(content.ItemMigration { from = "draco_mini", to = "aksemi" })
content.add(content.ItemMigration { from = "draco_micro", to = "aksemi" })
content.add(content.ItemMigration { from = "draco_9mm", to = "rugerpcc" })
content.add(content.ItemMigration { from = "ruger_charger", to = "ruger_1022" })
content.add(content.ItemMigration { from = "ruger_charger_auto", to = "ruger_1022_auto" })
content.add(content.ItemMigration { from = "hk_mp7", to = "fn_p90" })
content.add(content.ItemMigration { from = "hk46bigmag", to = "fnp90mag" })
content.add(content.ItemMigration { from = "hk46mag", to = "fnp90mag" })
content.add(content.ItemMigration { from = "reloaded_46mm", to = "reloaded_57mm" })
content.add(content.ItemMigration { from = "46mm", to = "57mm" })
content.add(content.ItemMigration { from = "bp_46mm", to = "bp_57mm" })
content.add(content.ItemMigration { from = "robofac_gun_46", to = "robofac_gun_57" })
content.add(content.ItemMigration { from = "unprimed_46mm_casing", to = "unprimed_57mm_casing" })
content.add(content.ItemMigration { from = "46mm_casing", to = "57mm_casing" })
content.add(content.ItemMigration { from = "solarpack", to = "folding_solar_panel_v2" })
content.add(content.ItemMigration { from = "solarpack_on", to = "folding_solar_panel_v2" })
content.add(content.ItemMigration { from = { "bone_glue", "rubber_cement" }, to = "glue_weak" })
content.add(content.ItemMigration { from = "super_glue", to = "glue_strong" })
content.add(content.ItemMigration { from = "fresh_fries_j", to = "fries" })
content.add(content.ItemMigration { from = "fresh_fries", to = "fries" })
content.add(content.ItemMigration { from = "crude_bronze_nail", to = "bronze_nail" })
content.add(content.ItemMigration { from = "chips2", to = "chips" })
content.add(content.ItemMigration { from = "chips3", to = "chips" })
content.add(content.ItemMigration { from = "lard", to = "tallow" })
content.add(content.ItemMigration { from = "mutant_human_lard", to = "mutant_human_tallow" })
content.add(content.ItemMigration { from = "mutant_lard", to = "mutant_tallow" })
content.add(content.ItemMigration { from = "demihuman_lard", to = "demihuman_tallow" })
content.add(content.ItemMigration { from = "human_lard", to = "human_tallow" })
content.add(content.ItemMigration { from = "cooking_oil2", to = "cooking_oil" })
content.add(content.ItemMigration { from = "tail_bunny_playboy", to = "scrap_cotton" })
content.add(content.ItemMigration { from = "sinister_dress", to = "long_dress_sleeved", variant = "sinister" })
content.add(content.ItemMigration { from = "broken_molebot", to = "pickaxe" })
content.add(content.ItemMigration { from = "schematics_molebot", to = "textbook_electronics" })
content.add(content.ItemMigration { from = "bot_molebot", to = "pickaxe" })
content.add(content.ItemMigration { from = "mc_warhammer", to = "warhammer" })
content.add(content.ItemMigration { from = "mc_mace", to = "mace" })
content.add(content.ItemMigration { from = "mc_knife_rambo", to = "knife_rambo" })
content.add(content.ItemMigration { from = "mc_knife_trench", to = "knife_trench" })

-- obsoletion_and_migration_0.I/prosthetics.json
content.add(content.ItemMigration { from = "right_arm_prosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "left_arm_prosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "right_arm_neuroprosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "left_arm_neuroprosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "right_arm_prosthetic_wood", to = "2x4" })
content.add(content.ItemMigration { from = "left_arm_prosthetic_wood", to = "2x4" })
content.add(content.ItemMigration { from = "right_arm_prosthetic_steel", to = "2x4" })
content.add(content.ItemMigration { from = "left_arm_prosthetic_steel", to = "2x4" })
content.add(content.ItemMigration { from = "right_leg_prosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "left_leg_prosthetic", to = "2x4" })
content.add(content.ItemMigration { from = "right_leg_prosthetic_steel", to = "2x4" })
content.add(content.ItemMigration { from = "left_leg_prosthetic_steel", to = "2x4" })
content.add(content.ItemMigration { from = "right_peg_leg", to = "2x4" })
content.add(content.ItemMigration { from = "left_peg_leg", to = "2x4" })

-- obsoletion_and_migration_0.J/migration_items.json
content.add(content.ItemMigration { from = "mounted_lance", to = "spear_steel" })
content.add(content.ItemMigration { from = "mounted_saber", to = "mc_cavalry_sabre" })
-- 撤销 PR #86581 #86067 #86231 — 移除迁移条目，恢复原始物品
content.add(content.ItemMigration { from = "shot_he", to = "shot_dragon" })
content.add(content.ItemMigration { from = "hk_mp7", to = "fn_p90" })
content.add(content.ItemMigration { from = "hk46bigmag", to = "fnp90mag" })
content.add(content.ItemMigration { from = "hk46mag", to = "fnp90mag" })
content.add(content.ItemMigration { from = "reloaded_46mm", to = "reloaded_57mm" })
content.add(content.ItemMigration { from = "46mm", to = "57mm" })
content.add(content.ItemMigration { from = "bp_46mm", to = "bp_57mm" })
content.add(content.ItemMigration { from = "robofac_gun_46", to = "robofac_gun_57" })
content.add(content.ItemMigration { from = "unprimed_46mm_casing", to = "unprimed_57mm_casing" })
content.add(content.ItemMigration { from = "46mm_casing", to = "57mm_casing" })
content.add(content.ItemMigration { from = "combatsaw_off", to = "chainsaw_off" })
content.add(content.ItemMigration { from = "combatsaw_on", to = "chainsaw_on" })
content.add(content.ItemMigration { from = "e_combatsaw_off", to = "elec_chainsaw_off" })
content.add(content.ItemMigration { from = "e_combatsaw_on", to = "elec_chainsaw_on" })
content.add(content.ItemMigration { from = "long_duffelbag", to = "duffelbag" })
content.add(content.ItemMigration { from = "helmet_chitin_light", to = "helmet_chitin" })
content.add(content.ItemMigration { from = "xl_helmet_chitin_light", to = "xl_helmet_chitin" })
content.add(content.ItemMigration { from = "helmet_chitin_light_xs", to = "helmet_chitin_xs" })
content.add(content.ItemMigration { from = "helmet_acidchitin_light", to = "helmet_acidchitin" })
content.add(content.ItemMigration { from = "xl_helmet_acidchitin_light", to = "xl_helmet_acidchitin" })
content.add(content.ItemMigration { from = "helmet_acidchitin_light_xs", to = "helmet_acidchitin_xs" })
content.add(content.ItemMigration { from = "atomic_lamp", to = "reading_light_on" })
content.add(content.ItemMigration { from = "atomic_lamp_off", to = "electric_lantern" })
content.add(content.ItemMigration { from = "atomic_light", to = "reading_light_on" })
content.add(content.ItemMigration { from = "atomic_light_off", to = "reading_light" })
content.add(content.ItemMigration { from = "wearable_atomic_light", to = "wearable_big_light" })
content.add(content.ItemMigration { from = "wearable_atomic_light_off", to = "wearable_big_light" })
content.add(content.ItemMigration { from = "atomic_coffeepot", to = "coffeemaker" })
content.add(content.ItemMigration { from = "cape_catholic", to = "cloak_vampire_red" })
content.add(content.ItemMigration { from = "zucchetto", to = "kippah" })
content.add(content.ItemMigration { from = "homewrecker", to = "hammer_sledge" })
content.add(content.ItemMigration { from = "tec9", to = "glock_17" })
content.add(content.ItemMigration { from = "tec9mag", to = "glockbigmag" })
content.add(content.ItemMigration { from = "tec9mag_10rd", to = "glock17_10" })
content.add(content.ItemMigration { from = "tec9mag_20rd", to = "glock17_22" })
content.add(content.ItemMigration { from = "tec9mag_30rd", to = "glockbigmag" })
content.add(content.ItemMigration { from = "tec9mag_36rd", to = "glock_drum_50rd" })
content.add(content.ItemMigration { from = "tec9mag_50rd", to = "glock_drum_50rd" })
content.add(content.ItemMigration { from = "tec9mag_72rd", to = "glock_drum_100rd" })
content.add(content.ItemMigration { from = "tec9_auto_parts", to = "glocksear" })
content.add(content.ItemMigration { from = "kp32", to = "walther_ppk" })
content.add(content.ItemMigration { from = "kp32mag", to = "ppkmag" })
content.add(content.ItemMigration { from = "calico", to = "rugerpcc" })
content.add(content.ItemMigration { from = "calicomag", to = "glock_drum_50rd" })
content.add(content.ItemMigration { from = "calicomag_100rd", to = "glock_drum_100rd" })
content.add(content.ItemMigration { from = "hk_mp5_10_semi", to = "glock_40" })
content.add(content.ItemMigration { from = "mp5_10_mag", to = "tdi_10mm_mag" })
content.add(content.ItemMigration { from = "TDI_10", to = "glock_40" })
content.add(content.ItemMigration { from = "cp33", to = "ruger_1022" })
content.add(content.ItemMigration { from = "cp33_mag", to = "ruger1022mag_55" })
content.add(content.ItemMigration { from = "cp33_mag_50", to = "ruger1022mag_55" })
content.add(content.ItemMigration { from = "p50", to = "fn_ps90" })
content.add(content.ItemMigration { from = "M6_shotgun", to = "u_shotgun" })
content.add(content.ItemMigration { from = "savage_111f", to = "remington_700_308" })
content.add(content.ItemMigration { from = "shotgun_410", to = "mossberg_500_410" })
content.add(content.ItemMigration { from = "winchester_1887", to = "winchester_1897" })
content.add(content.ItemMigration { from = "remington_870_breacher", to = "mossberg_590_shockwave" })
content.add(content.ItemMigration { from = "bren2_762", to = "aksemi" })
content.add(content.ItemMigration { from = "bren2_762mag10", to = "akmag10" })
content.add(content.ItemMigration { from = "bren2_762mag30", to = "akmag30" })
content.add(content.ItemMigration { from = { "integrated_hooves", "integrated_rabbit_feet" }, to = "wristwatch" })
content.add(content.ItemMigration { from = "armguard_lightplate", to = "armor_lc_armguard" })
content.add(content.ItemMigration { from = "xl_armguard_lightplate", to = "xl_armor_lc_armguard" })
content.add(content.ItemMigration { from = "xs_armguard_lightplate", to = "armor_lc_armguard" })
content.add(content.ItemMigration { from = "legguard_lightplate", to = "armor_lc_leg_guard" })
content.add(content.ItemMigration { from = "xl_legguard_lightplate", to = "xl_armor_lc_leg_guard" })
content.add(content.ItemMigration { from = "xs_legguard_lightplate", to = "armor_lc_leg_guard" })
content.add(content.ItemMigration { from = "weather_reader", to = "geiger_off" })
content.add(content.ItemMigration { from = "survivor_machete", to = "machete" })
content.add(content.ItemMigration { from = "toastem2", to = "toastem" })
content.add(content.ItemMigration { from = "toastem3", to = "toastem" })
content.add(content.ItemMigration { from = "toastem4", to = "toastem" })
content.add(content.ItemMigration { from = "sewage", to = "water_sewage" })
content.add(content.ItemMigration { from = "brick_kiln", to = "kiln" })
content.add(content.ItemMigration { from = "water_purifying_active", to = "water_clean" })
content.add(content.ItemMigration { from = "water_purifying", to = "water_clean" })
content.add(content.ItemMigration { from = "mre_strawberry_cake", to = "mre_chocolate_cake" })
content.add(content.ItemMigration { from = "cereal_fp7", to = "cereal_fp1", variant = "foodios" })
content.add(content.ItemMigration { from = "cereal_fp6", to = "cereal_fp1", variant = "fructose" })
content.add(content.ItemMigration { from = "cereal_fp5", to = "cereal_fp1", variant = "honey" })
content.add(content.ItemMigration { from = "cereal_fp3", to = "cereal_fp1", variant = "brantastic" })
content.add(content.ItemMigration { from = "strawberries_cooked", to = "strawberries" })
content.add(content.ItemMigration { from = "blueberries_cooked", to = "blueberries" })
content.add(content.ItemMigration { from = "fruit_cooked", to = "apple" })
content.add(content.ItemMigration { from = "duster_survivor", to = "duster" })
content.add(content.ItemMigration { from = "xl_duster_survivor", to = "xl_duster" })
content.add(content.ItemMigration { from = "xs_duster_survivor", to = "xs_duster" })
content.add(content.ItemMigration { from = "sleeveless_duster_survivor", to = "sleeveless_duster" })
content.add(content.ItemMigration { from = "trenchcoat_survivor", to = "trenchcoat" })
content.add(content.ItemMigration { from = "sleeveless_trenchcoat_survivor", to = "sleeveless_trenchcoat" })
content.add(content.ItemMigration { from = "lsurvivor_pants", to = "aketon_pants_canvas" })
content.add(content.ItemMigration { from = "xs_lsurvivor_pants", to = "xs_aketon_pants_canvas" })
content.add(content.ItemMigration { from = "xl_lsurvivor_pants", to = "xl_aketon_pants_canvas" })
content.add(content.ItemMigration { from = "pants_survivor", to = "gambeson_pants_canvas" })
content.add(content.ItemMigration { from = "xl_pants_survivor", to = "xl_gambeson_pants_canvas" })
content.add(content.ItemMigration { from = "xs_pants_survivor", to = "xs_gambeson_pants_canvas" })
content.add(content.ItemMigration { from = "washboard", to = "wash_kit" })
content.add(content.ItemMigration { from = "fsurvivor_jumpsuit", to = "lsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xl_fsurvivor_jumpsuit", to = "xl_lsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xs_fsurvivor_jumpsuit", to = "xs_lsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "h20survivor_jumpsuit", to = "survivor_jumpsuit" })
content.add(content.ItemMigration { from = "xl_h20survivor_jumpsuit", to = "xlsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xs_h20survivor_jumpsuit", to = "xssurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "thick_h20survivor_jumpsuit", to = "hsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xl_thick_h20survivor_jumpsuit", to = "xl_hsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xs_thick_h20survivor_jumpsuit", to = "xs_hsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "h20survivor_jumpsuit_light", to = "survivor_jumpsuit" })
content.add(content.ItemMigration { from = "xl_h20survivor_jumpsuit_light", to = "xlsurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "xs_h20survivor_jumpsuit_light", to = "xssurvivor_jumpsuit" })
content.add(content.ItemMigration { from = "gloves_h20survivor", to = "wetsuit_gloves" })
content.add(content.ItemMigration { from = "xl_gloves_h20survivor", to = "xl_wetsuit_gloves" })
content.add(content.ItemMigration { from = "xs_gloves_h20survivor", to = "xs_wetsuit_gloves" })
content.add(content.ItemMigration { from = "gloves_h20survivor_thick", to = "wetsuit_gloves_thick" })
content.add(content.ItemMigration { from = "xl_gloves_h20survivor_thick", to = "xl_wetsuit_gloves_thick" })
content.add(content.ItemMigration { from = "xs_gloves_h20survivor_thick", to = "xs_wetsuit_gloves_thick" })
content.add(content.ItemMigration { from = "boots_h20survivor_light", to = "wetsuit_gloves" })
content.add(content.ItemMigration { from = "xl_gloves_h20survivor_light", to = "xl_wetsuit_gloves" })
content.add(content.ItemMigration { from = "xs_gloves_h20survivor_light", to = "xs_wetsuit_gloves" })
content.add(content.ItemMigration { from = "boots_h20survivor", to = "wetsuit_booties" })
content.add(content.ItemMigration { from = "xl_boots_h20survivor", to = "xl_wetsuit_booties" })
content.add(content.ItemMigration { from = "xs_boots_h20survivor", to = "xs_wetsuit_booties" })
content.add(content.ItemMigration { from = "boots_h20survivor_thick", to = "wetsuit_booties_thick" })
content.add(content.ItemMigration { from = "xl_boots_h20survivor_thick", to = "xl_wetsuit_booties_thick" })
content.add(content.ItemMigration { from = "xs_boots_h20survivor_thick", to = "xs_wetsuit_booties_thick" })
content.add(content.ItemMigration { from = "boots_h20survivor_light", to = "wetsuit_booties" })
content.add(content.ItemMigration { from = "xl_boots_h20survivor_light", to = "xl_wetsuit_booties" })
content.add(content.ItemMigration { from = "xs_boots_h20survivor_light", to = "xs_wetsuit_booties" })
content.add(content.ItemMigration { from = "hood_h20survivor", to = "wetsuit_hood" })
content.add(content.ItemMigration { from = "xl_hood_h20survivor", to = "xl_wetsuit_hood" })
content.add(content.ItemMigration { from = "bundle_rag", to = "cotton_patchwork" })
content.add(content.ItemMigration { from = "bundle_cotton", to = "sheet_cotton" })
content.add(content.ItemMigration { from = "bundle_leather", to = "leather" })
content.add(content.ItemMigration { from = "bundle_wool", to = "felt_patch" })
content.add(content.ItemMigration { from = "bundle_nylon", to = "nylon" })
content.add(content.ItemMigration { from = "bundle_plank", to = "2x4" })
content.add(content.ItemMigration { from = "bundle_rebar", to = "rebar" })
content.add(content.ItemMigration { from = "bundle_pipe", to = "pipe" })
content.add(content.ItemMigration { from = "bundle_copper_pipe", to = "cu_pipe" })
content.add(content.ItemMigration { from = "bundle_branch", to = "stick" })
content.add(content.ItemMigration { from = "bundle_branch_long", to = "stick_long" })
content.add(content.ItemMigration { from = "bundle_javelin", to = "javelin" })
content.add(content.ItemMigration { from = "xs_hood_h20survivor", to = "xs_wetsuit_hood" })
content.add(content.ItemMigration { from = "hood_h20survivor_thick", to = "wetsuit_hood_thick" })
content.add(content.ItemMigration { from = "xl_hood_h20survivor_thick", to = "xl_wetsuit_hood_thick" })
content.add(content.ItemMigration { from = "xs_hood_h20survivor_thick", to = "xs_wetsuit_gloves_thick" })
content.add(content.ItemMigration { from = "hood_h20survivor_light", to = "wetsuit_hood" })
content.add(content.ItemMigration { from = "xl_hood_h20survivor_light", to = "xl_wetsuit_hood" })
content.add(content.ItemMigration { from = "xs_hood_h20survivor_light", to = "xs_wetsuit_hood" })
content.add(content.ItemMigration { from = "hood_lsurvivor", to = "hood_survivor" })
content.add(content.ItemMigration { from = "xl_hood_lsurvivor", to = "hood_xlsurvivor" })
content.add(content.ItemMigration { from = "xs_hood_lsurvivor", to = "hood_xssurvivor" })
content.add(content.ItemMigration { from = "hood_fsurvivor", to = "wetsuit_hood_thick" })
content.add(content.ItemMigration { from = "xl_hood_fsurvivor", to = "hood_xlsurvivor" })
content.add(content.ItemMigration { from = "xs_hood_fsurvivor", to = "hood_xssurvivor" })
content.add(content.ItemMigration { from = "boots_fsurvivor", to = "boots_survivor" })
content.add(content.ItemMigration { from = "xl_boots_fsurvivor", to = "boots_xlsurvivor" })
content.add(content.ItemMigration { from = "xs_boots_fsurvivor", to = "boots_xssurvivor" })
content.add(content.ItemMigration { from = "gloves_fsurvivor", to = "boots_survivor" })
content.add(content.ItemMigration { from = "xl_gloves_fsurvivor", to = "xl_gloves_survivor" })
content.add(content.ItemMigration { from = "xs_gloves_fsurvivor", to = "xs_gloves_survivor" })
content.add(content.ItemMigration { from = "boots_lsurvivor", to = "boots_survivor" })
content.add(content.ItemMigration { from = "xl_boots_lsurvivor", to = "boots_xlsurvivor" })
content.add(content.ItemMigration { from = "xs_boots_lsurvivor", to = "boots_xssurvivor" })
content.add(content.ItemMigration { from = "gloves_lsurvivor", to = "gloves_survivor" })
content.add(content.ItemMigration { from = "xl_gloves_lsurvivor", to = "xl_gloves_survivor" })
content.add(content.ItemMigration { from = "xs_gloves_lsurvivor", to = "xs_gloves_survivor" })
content.add(content.ItemMigration { from = "button_steel", to = "button_plastic", variant = "steel" })
content.add(content.ItemMigration { from = "button_bronze", to = "button_plastic", variant = "bronze" })
content.add(content.ItemMigration { from = "button_bone", to = "button_plastic", variant = "bone" })
content.add(content.ItemMigration { from = "button_wood", to = "button_plastic", variant = "wood" })
content.add(content.ItemMigration { from = "gloves_bag", to = "plastic_shopping_bag" })
content.add(content.ItemMigration { from = "gobag", to = "duffelbag" })
content.add(content.ItemMigration { from = "personal_gobag", to = "duffelbag" })
content.add(content.ItemMigration { from = "mc_kukri", to = "kukri" })
content.add(content.ItemMigration { from = "mc_broadsword", to = "broadsword" })
content.add(content.ItemMigration { from = "mc_rapier", to = "rapier" })
content.add(content.ItemMigration { from = "staff_sling_grenade_cradle", to = "sling" })

-- items/comestibles/irradiated_fruit_migration.json
content.add(content.ItemMigration { from = "irradiated_rose_hips", to = "rose_hips", flags = { "IRRADIATED" } })
content.add(content.ItemMigration {
    from = "irradiated_elderberries",
    to = "elderberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration { from = "irradiated_mulberries", to = "mulberries", flags = { "IRRADIATED" } })
content.add(content.ItemMigration {
    from = "irradiated_huckleberries",
    to = "huckleberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration {
    from = "irradiated_raspberries",
    to = "raspberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration {
    from = "irradiated_cranberries",
    to = "cranberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration {
    from = "irradiated_strawberries",
    to = "strawberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration {
    from = "irradiated_blueberries",
    to = "blueberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration { from = "irradiated_apple", to = "apple", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_banana", to = "banana", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_orange", to = "orange", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_lemon", to = "lemon", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_grapefruit", to = "grapefruit", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_pear", to = "pear", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_guayaba", to = "guayaba", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_maracuya", to = "maracuya", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_lulo", to = "lulo", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_cherries", to = "cherries", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_plums", to = "plums", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_grapes", to = "grapes", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_pineapple", to = "pineapple", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_peach", to = "peach", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_watermelon", to = "watermelon", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_melon", to = "melon", flags = { "IRRADIATED" } })
content.add(content.ItemMigration {
    from = "irradiated_blackberries",
    to = "blackberries",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration { from = "irradiated_mango", to = "mango", flags = { "IRRADIATED" } })
content.add(content.ItemMigration {
    from = "irradiated_pomegranate",
    to = "pomegranate",
    flags = { "IRRADIATED" },
})
content.add(content.ItemMigration { from = "irradiated_papaya", to = "papaya", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_kiwi", to = "kiwi", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_apricot", to = "apricot", flags = { "IRRADIATED" } })

-- items/comestibles/irradiated_veggy_migration.json
content.add(content.ItemMigration { from = "irradiated_lettuce", to = "lettuce", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_cabbage", to = "cabbage", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_tomato", to = "tomato", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_broccoli", to = "broccoli", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_zucchini", to = "zucchini", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_onion", to = "onion", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_carrot", to = "carrot", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_corn", to = "corn", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_pumpkin", to = "pumpkin", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_potato", to = "potato", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_plantain", to = "plantain", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_cucumber", to = "cucumber", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_celery", to = "celery", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_rhubarb", to = "rhubarb", flags = { "IRRADIATED" } })
content.add(content.ItemMigration { from = "irradiated_eggplant", to = "eggplant", flags = { "IRRADIATED" } })
