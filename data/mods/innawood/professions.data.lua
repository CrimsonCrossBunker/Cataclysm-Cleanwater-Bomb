local ccb = require("ccb")

ccb.content.define_profession {
    id = "goat_man",
    name = { male = "Goat Man", female = "Goat Lady" },
    description = "Nobody around?  Oh well, it doesn't matter.  Your beloved goats are all you need!",
    points = 2,
    skills = { { level = 2, id = "cooking" } },
    pets = { { monster = "mon_goat", count = 2 } },
    items = {
        both = {
            entries = {
                { item = "loincloth_leather" },
                { item = "leather_belt" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "shirt_straw" },
                { item = "rope_makeshift_6", count = 2 },
                { item = "sheath_birchbark", contents_items = "primitive_knife" },
                { item = "bucket_wood", custom_flags = { "auto_wield" } },
            },
        },
    },
}

ccb.content.define_profession {
    id = "lost_tribal",
    name = "Lost Tribal",
    description = "You were out gathering for the tribe when the sky broke and the gods called to you, then you collapsed.  When you woke up, you were in an unfamiliar place with new memories crowding your thoughts.",
    points = 2,
    skills = { { level = 2, id = "survival" }, { level = 2, id = "cooking" } },
    proficiencies = { "prof_fibers", "prof_knapping" },
    items = {
        both = {
            entries = {
                { item = "cloak_leather" },
                { item = "footrags_leather" },
                { item = "chestwrap_leather" },
                { item = "loincloth_fur" },
                { item = "stone_chopper" },
                { item = "straw_basket" },
            },
        },
    },
}

ccb.content.define_profession {
    id = "shaman",
    name = "Shaman",
    description = "You've trained in the medical arts, refining natural remedies into real cures for disease.  Your tribe would have lived long and healthy lives, were they still here.",
    points = 3,
    skills = {
        { level = 3, id = "firstaid" },
        { level = 2, id = "chemistry" },
        { level = 1, id = "survival" },
    },
    proficiencies = {
        "prof_wound_care",
        "prof_wound_care_expert",
        "prof_intro_biology",
        "prof_physiology",
        "prof_gross_anatomy",
        "prof_burn_care",
    },
    items = {
        both = {
            entries = {
                { item = "straw_basket" },
                { item = "grass_cloak" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "footrags_leather" },
                { item = "grass_keffiyeh" },
                { item = "primitive_knife" },
                { item = "tourniquet_upper" },
                { item = "arm_splint" },
                { item = "bandages_birchbark_adv", count = 10 },
                { item = "cattail_jelly", charges = 7, container_item = "bowl_clay" },
            },
        },
    },
}

ccb.content.define_profession {
    id = "backpacker",
    name = "Backpacker",
    description = "For the past few years you've been traveling the world, sightseeing and living off tribal donations.  You came home to find your home abandoned, and the only thing between you and death is the open fields and your pack.",
    points = 2,
    skills = { { level = 1, id = "survival" } },
    items = {
        both = {
            entries = {
                { item = "wicker_backpack" },
                { item = "mocassins" },
                { item = "tunic" },
                { item = "footrags_leather" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
            },
        },
    },
}

ccb.content.define_profession {
    id = "miner",
    name = "Miner",
    description = "You're a miner, not a minor!  Your waterskin is dry, you lost your haul, and you're on your last torch…",
    points = 5,
    items = {
        both = {
            entries = {
                { item = "primitive_shovel" },
                { item = "bronze_pickaxe" },
                { item = "mocassins" },
                { item = "torch" },
                { item = "waterskin" },
                { item = "tunic" },
                { item = "helmet_larmor" },
                { item = "gloves_wraps_leather" },
                { item = "bigtrapper_pack" },
                { item = "fire_drill", ammo_item = "notch", charges = 24 },
            },
        },
    },
}

ccb.content.define_profession {
    id = "bow_hunter",
    name = "Bow Hunter",
    description = "Ever since you were a child you loved hunting, and quickly developed a talent for archery.  Why, if the world ended, there's nothing you'd want at your side more than your trusty bow.  So, when it did, you made sure to bring it along.",
    points = 3,
    proficiencies = {
        "prof_bow_basic",
        "prof_bow_expert",
        "prof_fletching",
        "prof_knives_familiar",
        "prof_butchering_basic",
        "prof_skinning_basic",
        "prof_gross_anatomy",
        "prof_wp_ungulate",
    },
    skills = {
        { level = 2, id = "archery" },
        { level = 1, id = "gun" },
        { level = 1, id = "swimming" },
        { level = 1, id = "survival" },
    },
    items = {
        both = {
            entries = {
                { item = "mocassins" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "longbow" },
                { item = "quiver_birchbark", contents_groups = "quiver_bow_hunter" },
                { item = "sheath_birchbark", contents_items = "primitive_knife" },
            },
        },
    },
    missions = { "MISSION_HUNTER" },
}

ccb.content.define_profession {
    id = "spear_hunter",
    name = "Spear Hunter",
    description = "Ever since you were a child you loved hunting, and quickly developed a talent for chasing down your prey with a spear.  Why, if the world ended, there's nothing you'd want at your side more than your trusty spear.  So, when it did, you made sure to bring it along.",
    points = 3,
    skills = {
        { level = 2, id = "stabbing" },
        { level = 2, id = "melee" },
        { level = 1, id = "swimming" },
        { level = 1, id = "dodge" },
        { level = 1, id = "survival" },
    },
    proficiencies = {
        "prof_spears_familiar",
        "prof_knives_familiar",
        "prof_butchering_basic",
        "prof_skinning_basic",
        "prof_gross_anatomy",
        "prof_wp_ungulate",
    },
    items = {
        both = {
            entries = {
                { item = "footrags_leather" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "sheath_birchbark", contents_items = "primitive_knife" },
                { item = "spear_stone", custom_flags = { "auto_wield" } },
            },
        },
    },
    missions = { "MISSION_HUNTER" },
}

ccb.content.define_profession {
    id = "javelin_hunter",
    name = "Javelin Hunter",
    description = "Ever since you were a child you loved hunting, and quickly developed a talent for javelin throwing.  Why, if the world ended, there's nothing you'd want at your side more than your trusty javelins.  So, when it did, you made sure to bring them along.",
    points = 3,
    skills = {
        { level = 2, id = "throw" },
        { level = 1, id = "stabbing" },
        { level = 1, id = "swimming" },
        { level = 1, id = "survival" },
    },
    proficiencies = {
        "prof_spears_familiar",
        "prof_knives_familiar",
        "prof_butchering_basic",
        "prof_skinning_basic",
        "prof_gross_anatomy",
        "prof_wp_ungulate",
    },
    items = {
        both = {
            entries = {
                { item = "footrags_leather" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "sheath_birchbark", contents_items = "primitive_knife" },
                { item = "javelin_bag", contents_groups = "bag_javelin_hunter" },
            },
        },
    },
    missions = { "MISSION_HUNTER" },
}

ccb.content.define_profession {
    id = "crossbow_hunter",
    name = "Crossbow Hunter",
    description = "Ever since you were a child you loved hunting, and crossbow hunting was always your favorite.  Why, if the world ended, there's nothing you'd want at your side more than your trusty crossbow.  So, when it did, you made sure to bring it along, though most of your bolts were lost during the escape.",
    points = 3,
    proficiencies = {
        "prof_bow_basic",
        "prof_fletching",
        "prof_knives_familiar",
        "prof_butchering_basic",
        "prof_skinning_basic",
        "prof_gross_anatomy",
        "prof_wp_ungulate",
    },
    skills = {
        { level = 2, id = "rifle" },
        { level = 1, id = "gun" },
        { level = 1, id = "swimming" },
        { level = 1, id = "survival" },
    },
    items = {
        both = {
            entries = {
                { item = "mocassins" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                {
                    item = "compositecrossbow",
                    ammo_item = "bolt_simple_wood",
                    charges = 1,
                    contents_items = "shoulder_strap",
                    custom_flags = { "no_auto_equip" },
                },
                { item = "quiver_birchbark", contents_groups = "quiver_crossbow_hunter" },
                { item = "sheath_birchbark", contents_items = "primitive_knife" },
            },
        },
    },
    missions = { "MISSION_HUNTER" },
}

ccb.content.define_profession {
    id = "fisher",
    name = "Fisher",
    description = "You spent most of your days fishing in the swamp, getting by quietly on your catch.  You found the buzzing of insects enjoyable, but recently they've gotten bigger and meaner.  Now their horrible noises have you spooked - you just hope the fish aren't as nasty.",
    points = 3,
    skills = { { level = 2, id = "swimming" }, { level = 2, id = "survival" } },
    traits = { "OUTDOORSMAN" },
    proficiencies = { "prof_fibers", "prof_knives_familiar", "prof_butchering_basic" },
    items = {
        both = {
            entries = {
                { item = "wicker_backpack" },
                { item = "footrags_leather" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "straw_hat" },
                { item = "primitive_knife", container_item = "sheath_birchbark" },
                { item = "fishing_rod_basic", custom_flags = { "auto_wield" } },
                { item = "fire_drill", ammo_item = "notch", charges = 24 },
            },
        },
    },
}

ccb.content.define_profession {
    id = "fisher_canoe",
    name = { male = "Canoe Fisherman", female = "Canoe Fisherwoman" },
    description = "You spent most of your days fishing in lakes and swamps, getting by quietly on your catch.  While you've wandered from your canoe, you can't resist coming back for another catch.",
    points = 4,
    vehicle = "canoe",
    skills = { { level = 2, id = "swimming" }, { level = 2, id = "survival" }, { level = 1, id = "driving" } },
    traits = { "OUTDOORSMAN" },
    proficiencies = { "prof_fibers", "prof_knives_familiar" },
    items = {
        both = {
            entries = {
                { item = "wicker_backpack" },
                { item = "footrags_leather" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "straw_hat" },
                { item = "primitive_knife", container_item = "sheath_birchbark" },
                { item = "fishing_rod_basic", custom_flags = { "auto_wield" } },
                { item = "fire_drill", ammo_item = "notch", charges = 24 },
            },
        },
    },
}

ccb.content.define_profession {
    id = "redsmith",
    name = "Redsmith",
    description = "You ran into trouble coming out from your forge, but despite the havoc you've managed to keep some of your equipment along with your latest project.",
    points = 3,
    skills = { { level = 3, id = "fabrication" }, { level = 1, id = "swimming" } },
    proficiencies = { "prof_metalworking", "prof_redsmithing", "prof_redsmithing_adv" },
    items = {
        both = {
            entries = {
                { item = "pants" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "longshirt" },
                { item = "apron_leather" },
                { item = "gloves_leather" },
                { item = "primitive_hammer" },
                { item = "copper_knife" },
                { item = "wicker_backpack" },
                { item = "crucible_clay" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "unemployed",
    name = "Survivor",
    description = "Some would say that there's nothing particularly notable about you, but you've survived, and that's more than most could say right now.",
    points = 0,
    items = {
        both = {
            entries = {
                { item = "skirt_grass" },
                { item = "shirt_straw" },
                { item = "footrags" },
                { item = "straw_basket" },
                { item = "primitive_knife" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
                { item = "fire_drill", ammo_item = "notch", charges = 24 },
            },
        },
    },
}

ccb.content.define_profession {
    id = "trapper",
    name = "Trapper",
    description = "You spent most of your life trapping with your father.  Both of you made a decent living selling your catches and running trapping tutorials.  Hopefully, your skills will come in useful against less conventional game.",
    points = 2,
    skills = { { level = 4, id = "traps" }, { level = 2, id = "survival" } },
    proficiencies = {
        "prof_fibers",
        "prof_carving",
        "prof_traps",
        "prof_trapsetting",
        "prof_knives_familiar",
        "prof_butchering_basic",
        "prof_skinning_basic",
    },
    items = {
        both = {
            entries = {
                { item = "pants" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "hat_fur" },
                { item = "shirt_straw" },
                { item = "cloak_leather" },
                { item = "patchwork_scarf" },
                { item = "light_snare_kit" },
                { item = "wicker_backpack" },
                { item = "copper_knife", container_item = "sheath" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "tailor",
    name = "Tailor",
    description = "Tailoring may not seem like the most useful skill when the world has ended.  Most people wouldn't expect a simple tailor to live very long.  This is your opportunity to prove them wrong.",
    points = 3,
    skills = { { level = 3, id = "tailor" }, { level = 1, id = "survival" } },
    proficiencies = {
        "prof_fibers",
        "prof_fibers_rope",
        "prof_leatherworking_basic",
        "prof_leatherworking",
        "prof_furriery",
        "prof_closures",
        "prof_closures_waterproofing",
        "prof_cobbling",
        "prof_millinery",
    },
    items = {
        both = {
            entries = {
                { item = "straw_basket" },
                { item = "straw_fedora" },
                { item = "longshirt" },
                { item = "pants" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "patchwork_scarf" },
                { item = "awl_bone" },
                { item = "bronze_shears" },
                { item = "needle_bone", ammo_item = "plant_fibre", charges = 200 },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "lumberjack",
    name = "Lumberjack",
    description = "You're a lumberjack, and you're okay.  You felled trees before the world ended, and you suspect the undead aren't nearly as tough.",
    points = 0,
    skills = {
        { level = 2, id = "swimming" },
        { level = 2, id = "cutting" },
        { level = 2, id = "bashing" },
        { level = 2, id = "melee" },
    },
    proficiencies = { "prof_great_axes_familiar", "prof_hand_axes_familiar", "prof_hand_axes_pro" },
    items = {
        both = {
            entries = {
                { item = "pants" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "straw_hat" },
                { item = "longshirt" },
                { item = "patchwork_scarf" },
                { item = "vest_leather" },
                { item = "rope_makeshift_6" },
                { item = "copper_ax", custom_flags = { "auto_wield" } },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "musician",
    name = "Musician",
    description = "You nailed your solo, but the audience erupted into screams instead of applause.  You weren't able to grab much during the panic, but at least you have your flute in your basket.",
    points = 0,
    skills = { { level = 2, id = "speech" } },
    items = {
        both = {
            entries = {
                { item = "straw_basket" },
                { item = "shirt_straw" },
                { item = "skirt_grass" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "bone_flute" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "recruit",
    name = "Tribal Warrior Recruit",
    description = "Joining the tribal guard has been your dream for years.  You finally got in, just in time for your training to get interrupted by some sort of emergency.  As far as you can tell, the elders abandoned you in this hellhole when you missed the emergency evac.",
    points = 4,
    proficiencies = { "prof_bow_basic", "prof_bow_expert", "prof_knives_familiar", "prof_spears_familiar" },
    skills = {
        { level = 2, id = "gun" },
        { level = 2, id = "archery" },
        { level = 2, id = "stabbing" },
        { level = 2, id = "melee" },
        { level = 1, id = "dodge" },
        { level = 1, id = "swimming" },
    },
    items = {
        both = {
            entries = {
                { item = "helmet_larmor" },
                { item = "armor_larmor" },
                { item = "socks" },
                { item = "boots_larmor" },
                { item = "gauntlets_larmor" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
                { item = "quiver_birchbark", contents_groups = "quiver_bow_hunter" },
                { item = "spear_copper", container_item = "spearsling" },
                { item = "copper_knife", container_item = "sheath_birchbark" },
                { item = "longbow", contents_items = { "primitive_bow_silencer" } },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "tribal_swordsman",
    name = { male = "Tribal Swordsman", female = "Tribal Swordswoman" },
    description = "As a member of your tribe's elite guard, you sharpened your swordsmanship to the best that you could.  Now, you're a rōnin of the woods.",
    points = 4,
    skills = {
        { level = 3, id = "cutting" },
        { level = 3, id = "melee" },
        { level = 2, id = "dodge" },
        { level = 2, id = "swimming" },
    },
    proficiencies = {
        "prof_short_swords_familiar",
        "prof_short_swords_pro",
        "prof_knives_familiar",
        "prof_gross_anatomy",
    },
    items = {
        both = {
            entries = {
                { item = "helmet_larmor" },
                { item = "armor_larmor" },
                { item = "socks" },
                { item = "boots_larmor" },
                { item = "gauntlets_larmor" },
                { item = "water_clean", charges = 6, container_item = "waterskin" },
                { item = "sword_bronze", container_item = "scabbard" },
                { item = "copper_knife", container_item = "sheath_birchbark" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "tribal_arbalist",
    name = "Tribal Arbalist",
    description = "From your first hunt, you showed talent with a crossbow.  While the tribe was well guarded by your aim, you're all alone now.",
    points = 3,
    proficiencies = {
        "prof_bow_basic",
        "prof_bow_expert",
        "prof_fletching",
        "prof_knives_familiar",
        "prof_gross_anatomy",
    },
    skills = {
        { level = 3, id = "rifle" },
        { level = 3, id = "gun" },
        { level = 2, id = "swimming" },
        { level = 2, id = "survival" },
    },
    items = {
        both = {
            entries = {
                { item = "leathersandals" },
                { item = "helmet_larmor" },
                { item = "vambrace_larmor" },
                { item = "socks" },
                { item = "skirt_grass" },
                { item = "vest_leather" },
                { item = "legguard_larmor" },
                {
                    item = "compositecrossbow",
                    ammo_item = "bolt_simple_wood",
                    charges = 1,
                    contents_items = { "shoulder_strap", "primitive_bow_silencer", "wooden_grip" },
                    custom_flags = { "no_auto_equip" },
                },
                { item = "quiver_large_birchbark", contents_groups = "quiver_arbalist" },
                { item = "copper_knife", container_item = "sheath_birchbark" },
            },
        },
        male = { entries = { { item = "briefs" } } },
        female = { entries = { { item = "bra" }, { item = "panties" } } },
    },
}

ccb.content.define_profession {
    id = "farmer",
    name = "Farmer",
    description = "A patch of soil, some water, and sunlight were all you ever needed; why should things be any different now?  With a handful of seeds and your trusty hoe, it's time to rebuild the Earth, one plant at a time.",
    points = 1,
    items = {
        both = {
            entries = {
                { item = "loincloth_leather" },
                { item = "wicker_backpack" },
                { item = "patchwork_scarf" },
                { item = "straw_hat" },
                { item = "socks" },
                { item = "mocassins" },
                { item = "seed_blueberries" },
                { item = "seed_strawberries" },
                { item = "seed_wheat" },
                { item = "seed_hops" },
                { item = "seed_barley" },
                { item = "seed_sugar_beet" },
                { item = "seed_tomato" },
                { item = "bronze_hoe", custom_flags = { "auto_wield" } },
            },
        },
    },
}

ccb.content.define_profession {
    id = "native_settler",
    name = "Native Settler",
    description = "You were on the road with friends from your tribe to search for a new settlement spot when you seemed to be yanked somewhere completely different.  You see no sign of your friends, but at least you got your equipment and some seeds with you.",
    points = 3,
    skills = { { level = 4, id = "survival" }, { level = 2, id = "archery" } },
    proficiencies = { "prof_basketweaving", "prof_pottery", "prof_knives_familiar" },
    items = {
        both = {
            entries = {
                { item = "wicker_backpack" },
                { item = "tunic" },
                { item = "mocassins" },
                { item = "cloak" },
                { item = "chaps_leather" },
                { item = "bandana_head" },
                { item = "copper_knife" },
                { item = "shortbow" },
                { item = "loincloth" },
                { item = "seed_pumpkin", count = 5 },
                { item = "seed_beans", count = 5 },
                { item = "seed_corn", count = 5 },
                { item = "seed_wild_rice", count = 5 },
                { item = "seed_bottle_gourd", count = 1 },
                { item = "water_clean", charges = 8, container_item = "bottle_gourd" },
                {
                    item = "arrow_heavy_fire_hardened_fletched",
                    charges = 10,
                    container_item = "quiver_birchbark",
                },
            },
        },
    },
}

ccb.content.define_profession {
    id = "carpenter",
    name = "Carpenter",
    points = 4,
    description = "Living under your craftsmanship, the tribe was no longer bound to caves lest they freeze in the night.  You won't have to work nearly as hard for just yourself.",
    skills = { { level = 4, id = "fabrication" } },
    proficiencies = { "prof_carving", "prof_carpentry_basic", "prof_hand_axes_familiar" },
    items = {
        both = {
            entries = {
                { item = "wicker_backpack" },
                { item = "tunic" },
                { item = "clogs" },
                { item = "socks" },
                { item = "helmet_larmor" },
                { item = "copper_knife" },
                { item = "primitive_hammer" },
                { item = "loincloth" },
                { item = "copper_ax", container_item = "axe_ring" },
                { item = "primitive_adze", container_item = "rope_makeshift_6" },
                { item = "primitive_shovel", custom_flags = { "auto_wield" } },
            },
        },
    },
}

ccb.content.define_profession {
    id = "bricklayer",
    name = "Bricklayer",
    points = 4,
    description = "Using the earth and organic material to create durable, insulated adobe kept your trade in high demand in your tribe.  Now alone, you only need to look out for yourself.",
    skills = { { level = 3, id = "fabrication" }, { level = 1, id = "survival" } },
    items = {
        both = {
            entries = {
                { item = "trapper_pack" },
                { item = "tunic" },
                { item = "mocassins" },
                { item = "socks" },
                { item = "helmet_larmor" },
                { item = "primitive_hammer" },
                { item = "loincloth" },
                { item = "frame_wood_light" },
                { item = "adobe_brick", count = 10 },
                { item = "primitive_knife", container_item = "sheath_birchbark" },
                { item = "wood_smoother", custom_flags = { "auto_wield" } },
            },
        },
    },
}
