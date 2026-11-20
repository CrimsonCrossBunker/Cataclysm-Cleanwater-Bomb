local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_kill_zombie",
    name = ccb.content.text("One down, billions to go…"),
    requirements = { { statistic = "num_avatar_zombie_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_cyborg",
    name = ccb.content.text("Resistance is not futile"),
    requirements = {
        {
            statistic = "num_avatar_cyborg_kills",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_nether",
    name = ccb.content.text("Silence your nightmares"),
    requirements = {
        {
            statistic = "num_avatar_nether_kills",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_fungus",
    name = ccb.content.text("Fungicide"),
    requirements = {
        {
            statistic = "num_avatar_fungus_kills",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_insect",
    name = ccb.content.text("DDT"),
    requirements = {
        {
            statistic = "num_avatar_insect_kills",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_robot",
    name = ccb.content.text("Disassemble Number Five!"),
    requirements = {
        {
            statistic = "num_avatar_robot_kills",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_in_first_minute",
    name = ccb.content.text("Rude awakening"),
    time_limit = { since = "game_start", comparison = "<=", duration = "1 minute" },
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_monsters",
    -- TRANSLATORS: Pun on 'deca-' prefix for 10 and 'decimate', with it's meaning for killing
    name = ccb.content.text("Decamate"),
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_monsters",
    -- TRANSLATORS: Pun on 'cent-' prefix for 100 and 'sentinel', as in its connection to guarding or protection that may involve killing
    name = ccb.content.text("Centinel"),
    hidden_by = { "achievement_kill_10_monsters" },
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_monsters",
    -- TRANSLATORS: Pun on 'kilo-' prefix for 1000 and 'kill'
    name = ccb.content.text("Killo"),
    hidden_by = { "achievement_kill_100_monsters" },
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_monsters",
    -- TRANSLATORS: Pun on 'myriad' derived from the Ancient Greek for 10000 and 'murder'
    name = ccb.content.text("Murdyriad"),
    hidden_by = { "achievement_kill_1000_monsters" },
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_monsters",
    -- TRANSLATORS: Pun on 'hetsy' meaning 100000 in Malagasy and 'hit' as the slang for kill
    name = ccb.content.text("Hitsy"),
    hidden_by = { "achievement_kill_10000_monsters" },
    requirements = { { statistic = "num_avatar_monster_kills", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_survive_one_day",
    name = ccb.content.text("The first day of the rest of their unlives"),
    description = ccb.content.text("Survive for a day and find a safe place to sleep"),
    time_limit = { since = "game_start", comparison = ">=", duration = "16 hours" },
    requirements = { { statistic = "num_avatar_wake_ups", comparison = "anything" } },
}

ccb.content.define_achievement {
    id = "achievement_survive_7_days",
    name = ccb.content.text("Thank God it's Friday"),
    description = ccb.content.text("Survive for a week"),
    hidden_by = { "achievement_survive_one_day" },
    time_limit = { since = "game_start", comparison = ">=", duration = "7 days" },
    requirements = { { statistic = "num_avatar_wake_ups", comparison = "anything" } },
}

ccb.content.define_achievement {
    id = "achievement_survive_28_days",
    name = ccb.content.text("28 days later"),
    description = ccb.content.text("Survive for a month"),
    hidden_by = { "achievement_survive_7_days" },
    time_limit = { since = "game_start", comparison = ">=", duration = "28 days" },
    requirements = { { statistic = "num_avatar_wake_ups", comparison = "anything" } },
}

ccb.content.define_achievement {
    id = "achievement_survive_91_days",
    name = ccb.content.text("A time to every purpose under heaven"),
    description = ccb.content.text("Survive for a season"),
    hidden_by = { "achievement_survive_28_days" },
    time_limit = { since = "game_start", comparison = ">=", duration = "91 days" },
    requirements = { { statistic = "num_avatar_wake_ups", comparison = "anything" } },
}

ccb.content.define_achievement {
    id = "achievement_survive_365_days",
    name = ccb.content.text("Brighter days ahead?"),
    description = ccb.content.text("Survive for a year"),
    hidden_by = { "achievement_survive_91_days" },
    time_limit = { since = "game_start", comparison = ">=", duration = "365 days" },
    requirements = { { statistic = "num_avatar_wake_ups", comparison = "anything" } },
}

ccb.content.define_achievement {
    id = "achievement_marathon",
    name = ccb.content.text("Pheidippides was a hack"),
    description = ccb.content.text("Run a marathon… plus a little more."),
    requirements = { { statistic = "num_moves_ran", comparison = ">=", target = 42196 } },
}

ccb.content.define_achievement {
    id = "achievement_walk_1000_miles",
    name = ccb.content.text("Please don't fall down at my door"),
    description = ccb.content.text("Walk 500 miles, then walk 500 more."),
    requirements = { { statistic = "num_moves_walked", comparison = ">=", target = 1609340 } },
}

ccb.content.define_achievement {
    id = "achievement_traverse_sharp_terrain",
    name = ccb.content.text("Every rose has its thorn"),
    requirements = { { statistic = "num_moves_sharp_terrain", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_swim_merit_badge",
    name = ccb.content.text("Swimming merit badge"),
    requirements = {
        { statistic = "num_moves_swam", comparison = ">=", target = 10000 },
        { statistic = "num_moves_swam_underwater", comparison = ">=", target = 1000 },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_max_z_level",
    name = ccb.content.text("Ain't no mountain high enough"),
    requirements = { { statistic = "max_move_z", comparison = ">=", target = 9 } },
}

ccb.content.define_achievement {
    id = "achievement_reach_min_z_level",
    name = ccb.content.text("Ain't no valley low enough"),
    requirements = { { statistic = "min_move_z", comparison = "<=", target = -10 } },
}

-- Approx distance covered by Bertha Benz in 1888 drive
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_gndv_berthabenz",
    name = ccb.content.text("Test Drive"),
    requirements = { { statistic = "num_moves_gndv_ctrl_direct", comparison = ">=", target = 106000 } },
}

-- Daytona 500 race distance
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_gndv_daytona",
    name = ccb.content.text("Daytona"),
    requirements = { { statistic = "num_moves_gndv_ctrl_direct", comparison = ">=", target = 804672 } },
    hidden_by = { "achievement_vehicle_distance_gndv_berthabenz" },
}

-- From the song by Modest Mouse; 1100 miles = 1770278 m
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_gndv_arcticsounds",
    name = ccb.content.text("Too Far Inside a Car"),
    requirements = { { statistic = "num_moves_gndv_onboard", comparison = ">=", target = 1770278 } },
    hidden_by = { "achievement_vehicle_distance_gndv_daytona" },
}

-- From the song by Bobby Troup; 1926 alignment; 2448 miles = 3939674 m
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_gndv_route66",
    name = ccb.content.text("Chicago to L.A."),
    requirements = { { statistic = "num_moves_gndv_onboard", comparison = ">=", target = 3939674 } },
    hidden_by = { "achievement_vehicle_distance_gndv_arcticsounds" },
}

-- Prestigious rowing race held in Boston
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_boat_hocr",
    name = ccb.content.text("Head of the Charles"),
    requirements = { { statistic = "num_moves_boat_ctrl_direct", comparison = ">=", target = 4800 } },
}

-- Approx distance sailed by the Pilgrims
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_boat_mayflower",
    name = ccb.content.text("Plymouth to Plymouth"),
    requirements = { { statistic = "num_moves_boat_onboard", comparison = ">=", target = 5200000 } },
    hidden_by = { "achievement_vehicle_distance_boat_hocr" },
}

-- Approx distance covered by the Magellan–Elcano expedition
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_boat_circumnavigate",
    name = ccb.content.text("Circumnavigator"),
    requirements = { { statistic = "num_moves_boat_onboard", comparison = ">=", target = 60440000 } },
    hidden_by = { "achievement_vehicle_distance_boat_mayflower" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_acft_wright",
    name = ccb.content.text("Flying Wright"),
    requirements = { { statistic = "num_moves_acft_ctrl_direct", comparison = ">=", target = 279 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_acft_bleriot",
    name = ccb.content.text("Better than Blériot"),
    requirements = { { statistic = "num_moves_acft_ctrl_direct", comparison = ">=", target = 39650 } },
    hidden_by = { "achievement_vehicle_distance_acft_wright" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_acft_lindbergh",
    name = ccb.content.text("Lindbergh's Loss"),
    requirements = { { statistic = "num_moves_acft_ctrl_direct", comparison = ">=", target = 5809000 } },
    hidden_by = { "achievement_vehicle_distance_acft_bleriot" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_acft_fosset",
    name = ccb.content.text("Further than Fosset"),
    requirements = { { statistic = "num_moves_acft_ctrl_direct", comparison = ">=", target = 41467460 } },
    hidden_by = { "achievement_vehicle_distance_acft_lindbergh" },
}

-- 40,000 miles to qualify for Star Alliance Gold status
ccb.content.define_achievement {
    id = "achievement_vehicle_distance_acft_flyergold",
    name = ccb.content.text("Frequent Flyer"),
    requirements = { { statistic = "num_moves_acft_onboard", comparison = ">=", target = 64373760 } },
    hidden_by = { "achievement_vehicle_distance_acft_fosset" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_onboard_rc",
    name = ccb.content.text("Driver's seat optional"),
    requirements = { { statistic = "num_moves_veh_onboard_ctrl_remote", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_passenger",
    name = ccb.content.text("Are we there yet?"),
    requirements = { { statistic = "num_moves_veh_onboard_ctrl_none", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_distance_skidding",
    name = ccb.content.text("I have full control of the car, I swear."),
    requirements = { { statistic = "num_moves_gndv_skidding", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_gndv_42mph",
    name = ccb.content.text("Model T"),
    requirements = { { statistic = "max_velocity_gndv", comparison = ">=", target = 4200 } },
}

-- General Lee
ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_gndv_135mph",
    name = ccb.content.text("Charger"),
    requirements = { { statistic = "max_velocity_gndv", comparison = ">=", target = 13500 } },
    hidden_by = { "achievement_vehicle_velocity_gndv_42mph" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_rail_150mph",
    name = ccb.content.text("Acela"),
    requirements = { { statistic = "max_velocity_rail", comparison = ">=", target = 15000 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_boat_71mph",
    name = ccb.content.text("Miss America"),
    requirements = { { statistic = "max_velocity_boat", comparison = ">=", target = 7143 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_boat_125mph",
    name = ccb.content.text("Miss America X"),
    requirements = { { statistic = "max_velocity_boat", comparison = ">=", target = 12486 } },
    hidden_by = { "achievement_vehicle_velocity_boat_71mph" },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_acft_mach1",
    name = ccb.content.text("Going Mach"),
    requirements = { { statistic = "max_velocity_acft", comparison = ">=", target = 76727 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_acft_max_z_level",
    name = ccb.content.text("Up Like Icarus"),
    requirements = { { statistic = "max_move_acft_ctrl_direct_z", comparison = ">=", target = 9 } },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_drift_50mph",
    name = ccb.content.text("KANSEI DORIFTO?!"),
    requirements = {
        {
            statistic = "max_velocity_skidding",
            comparison = ">=",
            target = 5000,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_vehicle_velocity_rail_human50mph",
    name = ccb.content.text("The human body was not designed for this"),
    requirements = {
        {
            statistic = "max_velocity_rail",
            comparison = ">=",
            target = 5000,
            visibility = "when_achievement_completed",
        },
        {
            statistic = "num_installs_cbm",
            comparison = "<=",
            target = 0,
            visibility = "when_achievement_completed",
        },
        {
            statistic = "num_installs_faulty_cbm",
            comparison = "<=",
            target = 0,
            visibility = "when_achievement_completed",
        },
        {
            statistic = "num_gains_mutation",
            comparison = "<=",
            target = 0,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_wield_crowbar",
    name = ccb.content.text("Freeman's favorite"),
    requirements = {
        {
            statistic = "num_avatar_wields_crowbar",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Wield a crowbar"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_wear_power_armor",
    name = ccb.content.text("Impenetrable"),
    requirements = {
        {
            statistic = "num_avatar_wears_power_armor_heavy",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Wear a tank suit"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_lab_finale",
    name = ccb.content.text("What are they hiding?"),
    requirements = {
        {
            statistic = "num_avatar_enters_lab_finale",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Enter a distorted lab"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_refugee_center",
    name = ccb.content.text("The Last Homely House"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "evac_center" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a refugee center"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_return_to_first_omt",
    name = ccb.content.text("Return to your roots"),
    hidden_by = { "achievement_survive_91_days" },
    time_limit = { since = "game_start", comparison = ">=", duration = "91 days" },
    requirements = {
        {
            statistic = "num_avatar_enter_first_omt",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Return to the location you started the game"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_cut_1_tree",
    name = ccb.content.text("Timber"),
    description = ccb.content.text("If a tree falls in a forest and no one is around to hear it, does it make a sound?"),
    requirements = { { statistic = "num_cuts_tree", comparison = ">=", target = 1 } },
    hidden_by = { "achievement_cut_1_tree" },
}

ccb.content.define_achievement {
    id = "achievement_cut_100_trees",
    name = ccb.content.text("Lumberjack"),
    description = ccb.content.text("What is a forest for a man with an axe?"),
    requirements = { { statistic = "num_cuts_tree", comparison = ">=", target = 100 } },
    hidden_by = { "achievement_cut_1_tree" },
}

ccb.content.define_achievement {
    id = "achievement_cut_1000_trees",
    name = ccb.content.text("Deforestation"),
    description = ccb.content.text("If you cut down the trees you will find the wolf."),
    requirements = { { statistic = "num_cuts_tree", comparison = ">=", target = 1000 } },
    hidden_by = { "achievement_cut_100_trees" },
}

ccb.content.define_achievement {
    id = "achievement_exhume_1_grave",
    name = ccb.content.text("Grave Digger"),
    description = ccb.content.text("That's exactly what we need: more dead bodies."),
    requirements = {
        {
            statistic = "num_exhumed_graves",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
    hidden_by = { "achievement_exhume_1_grave" },
}

ccb.content.define_achievement {
    id = "achievement_exhume_10_graves",
    name = ccb.content.text("Grave Robber"),
    description = ccb.content.text("Hey, what if they turned down there?  You gotta check."),
    requirements = { { statistic = "num_exhumed_graves", comparison = ">=", target = 10 } },
    hidden_by = { "achievement_exhume_1_grave" },
}

ccb.content.define_achievement {
    id = "achievement_bury_1_corpse",
    name = ccb.content.text("Funeral"),
    description = ccb.content.text("It's a privilege to be buried when billions will not be."),
    requirements = {
        {
            statistic = "num_buried_corpses",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
    hidden_by = { "achievement_bury_1_corpse" },
}

ccb.content.define_achievement {
    id = "achievement_bury_10_corpses",
    name = ccb.content.text("Undertaker"),
    description = ccb.content.text("Leave no one to rot among the living dead."),
    requirements = { { statistic = "num_buried_corpses", comparison = ">=", target = 10 } },
    hidden_by = { "achievement_bury_1_corpse" },
}

ccb.content.define_achievement {
    id = "achievement_bury_100_corpses",
    name = ccb.content.text("Funeral House"),
    description = ccb.content.text("You cannot bury the whole world, can you?"),
    requirements = { { statistic = "num_buried_corpses", comparison = ">=", target = 100 } },
    hidden_by = { "achievement_bury_10_corpses" },
}

ccb.content.define_achievement {
    id = "achievement_install_1_cbm",
    name = ccb.content.text("Cyberpunk"),
    description = ccb.content.text("Spiritus quidem promptus; caro vero infirma."),
    requirements = {
        {
            statistic = "num_installs_cbm",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_install_10_cbms",
    name = ccb.content.text("Clockwork Man"),
    description = ccb.content.text("By most mechanical and dirty hand.  I shall have such revenges on you… both.  The things I will do, what they are, yet I know not.  But they will be the terrors of the earth."),
    requirements = { { statistic = "num_installs_cbm", comparison = ">=", target = 10 } },
    hidden_by = { "achievement_install_1_cbm" },
}

ccb.content.define_achievement {
    id = "achievement_crosses_mutation_threshold",
    name = ccb.content.text("Homo Evolutis"),
    description = ccb.content.text("The world of man has ended.  Long live the world of transhumanity."),
    requirements = {
        {
            statistic = "num_crosses_mutation_threshold",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_plant",
    name = ccb.content.text("Carbon neutral"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "PLANT" },
            description = ccb.content.text("crossed plant mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_rabbit",
    name = ccb.content.text("Finally beat the tortoise"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "RABBIT" },
            description = ccb.content.text("crossed rabbit mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_insect",
    name = ccb.content.text("Heard of the swarm?"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "INSECT" },
            description = ccb.content.text("crossed insect mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_spider",
    name = ccb.content.text("With great power…"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "SPIDER" },
            description = ccb.content.text("crossed spider mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_slime",
    name = ccb.content.text("Slippery when moist"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "SLIME" },
            description = ccb.content.text("crossed slime mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_fish",
    name = ccb.content.text("Tipping the scales"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "FISH" },
            description = ccb.content.text("crossed fish mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_rat",
    name = ccb.content.text("At first I was afraid, I was petrified…"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "RAT" },
            description = ccb.content.text("crossed rat mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_beast",
    name = ccb.content.text("The nature of the me"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "BEAST" },
            description = ccb.content.text("crossed beast mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_ursine",
    name = ccb.content.text("Just the necessities"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "URSINE" },
            description = ccb.content.text("crossed ursine mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_feline",
    name = ccb.content.text("Nine lives"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "FELINE" },
            description = ccb.content.text("crossed feline mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_lupine",
    name = ccb.content.text("Leader of the pack"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "LUPINE" },
            description = ccb.content.text("crossed lupine mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_cattle",
    name = ccb.content.text("Don't drive a limousine, become it"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "CATTLE" },
            description = ccb.content.text("crossed cattle mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_cephalapod",
    name = ccb.content.text("How did I ever get surrounded by such undead neighbors?"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "CEPHALOPOD" },
            description = ccb.content.text("crossed cephalopod mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_bird",
    name = ccb.content.text("Look, Ma, I can fly!"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "BIRD" },
            description = ccb.content.text("crossed bird mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_lizard",
    name = ccb.content.text("Yer a lizard, Harry"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "LIZARD" },
            description = ccb.content.text("crossed lizard mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_troglobite",
    name = ccb.content.text("Spelunking: a lifestyle, not a hobby"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "TROGLOBITE" },
            description = ccb.content.text("crossed troglobite mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_gastropod",
    name = ccb.content.text("Carrying your home on your back"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "GASTROPOD" },
            description = ccb.content.text("crossed gastropod mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_batrachian",
    name = ccb.content.text("Leaping forward in life"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "BATRACHIAN" },
            description = ccb.content.text("crossed batrachian mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_alpha",
    name = ccb.content.text("Thus spake zombiethustra"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "ALPHA" },
            description = ccb.content.text("crossed alpha mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_medical",
    name = ccb.content.text("What doesn't kill you, makes you stranger"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "MEDICAL" },
            description = ccb.content.text("crossed medical mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_chimera",
    name = ccb.content.text("Equal opportunity assimilator"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "CHIMERA" },
            description = ccb.content.text("crossed chimera mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_elfa",
    name = ccb.content.text("Treat every day like Christmas"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "ELFA" },
            description = ccb.content.text("crossed Elf-A mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_raptor",
    name = ccb.content.text("Clever girl"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "RAPTOR" },
            description = ccb.content.text("crossed raptor mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_mouse",
    name = ccb.content.text("Judge me by my size"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "MOUSE" },
            description = ccb.content.text("crossed mouse mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_break_major_limbs",
    name = ccb.content.text("Broken But Not Defeated"),
    description = ccb.content.text("Does your medical insurance cover that?"),
    requirements = {
        {
            statistic = "num_broken_right_leg",
            comparison = ">=",
            target = 1,
            visibility = "when_requirement_completed",
        },
        {
            statistic = "num_broken_left_leg",
            comparison = ">=",
            target = 1,
            visibility = "when_requirement_completed",
        },
        {
            statistic = "num_broken_right_arm",
            comparison = ">=",
            target = 1,
            visibility = "when_requirement_completed",
        },
        {
            statistic = "num_broken_left_arm",
            comparison = ">=",
            target = 1,
            visibility = "when_requirement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_speech",
    name = ccb.content.text("Talkative"),
    description = ccb.content.text("Hi. Nice to meet you!"),
    requirements = {
        {
            statistic = "num_gains_speech_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain social skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_speech",
    name = ccb.content.text("Eloquent"),
    description = ccb.content.text("We're friends, aren't we?"),
    requirements = {
        {
            statistic = "num_gains_speech_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain social skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_speech" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_speech",
    name = ccb.content.text("Silver Tongue"),
    description = ccb.content.text("Legend has it you convinced a zombie hulk to go away."),
    requirements = {
        {
            statistic = "num_gains_speech_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain social skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_speech" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_computer",
    name = ccb.content.text("Help Desk"),
    description = ccb.content.text("Have you tried turning it off and back on again?"),
    requirements = {
        {
            statistic = "num_gains_computer_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain computers skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_computer",
    name = ccb.content.text("HackerMan"),
    description = ccb.content.text("This OS has a back door.  There is always a back door."),
    requirements = {
        {
            statistic = "num_gains_computer_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain computers skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_computer" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_computer",
    name = ccb.content.text("Baldness and Wigs"),
    description = ccb.content.text("No stereotype!  So are you from the Neumann school or the Turing school?"),
    requirements = {
        {
            statistic = "num_gains_computer_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain computers skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_computer" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_firstaid",
    name = ccb.content.text("Nurse Practitioner"),
    description = ccb.content.text("Clean and disinfected."),
    requirements = {
        {
            statistic = "num_gains_firstaid_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain health care skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_firstaid",
    name = ccb.content.text("MD"),
    description = ccb.content.text("Is there a doctor in the house?"),
    requirements = {
        {
            statistic = "num_gains_firstaid_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain health care skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_firstaid" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_firstaid",
    name = ccb.content.text("Dr. House"),
    description = ccb.content.text("It's lupus."),
    requirements = {
        {
            statistic = "num_gains_firstaid_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain health care skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_firstaid" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_mechanics",
    name = ccb.content.text("Amateur Mechanic"),
    description = ccb.content.text("Righty tighty, lefty loosey."),
    requirements = {
        {
            statistic = "num_gains_mechanics_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain mechanics skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_mechanics",
    name = ccb.content.text("Engineer"),
    description = ccb.content.text("Just give me my wrench."),
    requirements = {
        {
            statistic = "num_gains_mechanics_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain mechanics skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_mechanics" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_mechanics",
    name = ccb.content.text("MacGyver"),
    description = ccb.content.text("This whole deal is holding on faith, spit, and duct tape."),
    requirements = {
        {
            statistic = "num_gains_mechanics_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain mechanics skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_mechanics" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_traps",
    name = ccb.content.text("Rigging"),
    description = ccb.content.text("This will slow them down!"),
    requirements = {
        {
            statistic = "num_gains_traps_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain devices skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_traps",
    name = ccb.content.text("Trapper"),
    description = ccb.content.text("A good trap doesn't discriminate between beavers and zombeavers."),
    requirements = {
        {
            statistic = "num_gains_traps_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain devices skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_traps" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_traps",
    name = ccb.content.text("Minesweeper"),
    description = ccb.content.text("All it takes is one mistake."),
    requirements = {
        {
            statistic = "num_gains_traps_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain devices skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_traps" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_driving",
    name = ccb.content.text("Student Driver"),
    description = ccb.content.text("Easy on the brakes."),
    requirements = {
        {
            statistic = "num_gains_driving_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain vehicles skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_driving",
    name = ccb.content.text("Ace Driver"),
    description = ccb.content.text("No turn is too sharp."),
    requirements = {
        {
            statistic = "num_gains_driving_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain vehicles skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_driving" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_driving",
    name = ccb.content.text("The Stig"),
    description = ccb.content.text("Formula One is for Sunday drivers."),
    requirements = {
        {
            statistic = "num_gains_driving_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain vehicles skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_driving" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_swimming",
    name = ccb.content.text("Swimmer"),
    description = ccb.content.text("I can doggie paddle."),
    requirements = {
        {
            statistic = "num_gains_swimming_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain athletics skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_swimming",
    name = ccb.content.text("Swimmer"),
    description = ccb.content.text("Like a fish to water."),
    requirements = {
        {
            statistic = "num_gains_swimming_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain athletics skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_swimming" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_swimming",
    name = ccb.content.text("Michael Phelps"),
    description = ccb.content.text("Faster than Jaws."),
    requirements = {
        {
            statistic = "num_gains_swimming_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain athletics skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_swimming" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_fabrication",
    name = ccb.content.text("Household Handyman"),
    description = ccb.content.text("If I have the instructions, I can make it work."),
    requirements = {
        {
            statistic = "num_gains_fabrication_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain fabrication skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_fabrication",
    name = ccb.content.text("Do-It-Yourselfer"),
    description = ccb.content.text("Take this thing, put it in that thing, and voila."),
    requirements = {
        {
            statistic = "num_gains_fabrication_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain fabrication skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_fabrication" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_fabrication",
    name = ccb.content.text("Jack of All Trades"),
    description = ccb.content.text("With the right amount of glue, there is nothing I can't do."),
    requirements = {
        {
            statistic = "num_gains_fabrication_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain fabrication skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_fabrication" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_cooking",
    name = ccb.content.text("Home Cook"),
    description = ccb.content.text("I can handle a roast."),
    requirements = {
        {
            statistic = "num_gains_cooking_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain food handling skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_cooking",
    name = ccb.content.text("Master Chef"),
    description = ccb.content.text("Glazed tenderloin is a cakewalk."),
    requirements = {
        {
            statistic = "num_gains_cooking_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain food handling skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_cooking" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_cooking",
    name = ccb.content.text("Hell's Kitchen"),
    description = ccb.content.text("Today's menu: Soupe a l'oignon, Boeuf Bourguignon, and Creme brulee."),
    requirements = {
        {
            statistic = "num_gains_cooking_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain food handling skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_cooking" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_tailor",
    name = ccb.content.text("Patchwork"),
    description = ccb.content.text("Fixing tears isn't too bad."),
    requirements = {
        {
            statistic = "num_gains_tailor_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain tailoring skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_tailor",
    name = ccb.content.text("Tailor"),
    description = ccb.content.text("A needle, a thread, and a dream."),
    requirements = {
        {
            statistic = "num_gains_tailor_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain tailoring skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_tailor" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_tailor",
    name = ccb.content.text("Fashion Designer"),
    description = ccb.content.text("From catwalk to Cataclysm."),
    requirements = {
        {
            statistic = "num_gains_tailor_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain tailoring skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_tailor" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_survival",
    name = ccb.content.text("Enthusiast"),
    description = ccb.content.text("I just love the outdoors!"),
    requirements = {
        {
            statistic = "num_gains_survival_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain survival skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_survival",
    name = ccb.content.text("Survivalist"),
    description = ccb.content.text("Survival is my game."),
    requirements = {
        {
            statistic = "num_gains_survival_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain survival skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_survival" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_survival",
    name = ccb.content.text("Bear Grylls"),
    description = ccb.content.text("So you say you can survive on your own urine?"),
    requirements = {
        {
            statistic = "num_gains_survival_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain survival skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_survival" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_electronics",
    name = ccb.content.text("Shocking"),
    description = ccb.content.text("One is positive, one is negative."),
    requirements = {
        {
            statistic = "num_gains_electronics_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain electronics skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_electronics",
    name = ccb.content.text("Ohm's Law"),
    description = ccb.content.text("Thunder Ohm.  Two volts enter, one volt leaves.  Resistance is futile."),
    requirements = {
        {
            statistic = "num_gains_electronics_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain electronics skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_electronics" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_electronics",
    name = ccb.content.text("Nicola Tesla"),
    description = ccb.content.text("One does not simply taste a 9 V battery."),
    requirements = {
        {
            statistic = "num_gains_electronics_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain electronics skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_electronics" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_archery",
    name = ccb.content.text("Bowman"),
    description = ccb.content.text("Draw, aim and release."),
    requirements = {
        {
            statistic = "num_gains_archery_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain archery skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_archery",
    name = ccb.content.text("Bull's Eye"),
    description = ccb.content.text("Better than Legolas."),
    requirements = {
        {
            statistic = "num_gains_archery_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain archery skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_archery" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_archery",
    name = ccb.content.text("Robin Hood"),
    description = ccb.content.text("Wilhelm Tell?  Never heard of."),
    requirements = {
        {
            statistic = "num_gains_archery_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain archery skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_archery" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_gun",
    name = ccb.content.text("Marksman"),
    description = ccb.content.text("Lead the target."),
    requirements = {
        {
            statistic = "num_gains_gun_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain marksmanship skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_gun",
    name = ccb.content.text("Eagle Eye"),
    description = ccb.content.text("Only me and my target."),
    requirements = {
        {
            statistic = "num_gains_gun_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain marksmanship skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_gun" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_gun",
    name = ccb.content.text("Deadshot"),
    description = ccb.content.text("Don't run.  You'll die tired."),
    requirements = {
        {
            statistic = "num_gains_gun_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain marksmanship skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_gun" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_launcher",
    name = ccb.content.text("Gunner"),
    description = ccb.content.text("Serious Hardware."),
    requirements = {
        {
            statistic = "num_gains_launcher_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain launchers skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_launcher",
    name = ccb.content.text("Heavy Gunner"),
    description = ccb.content.text("Caliber makes the difference."),
    requirements = {
        {
            statistic = "num_gains_launcher_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain launchers skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_launcher" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_launcher",
    name = ccb.content.text("Rocket Man"),
    description = ccb.content.text("I'm sending you to the moon.  In pieces."),
    requirements = {
        {
            statistic = "num_gains_launcher_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain launchers skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_launcher" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_pistol",
    name = ccb.content.text("Pistoleer"),
    description = ccb.content.text("Don't forget the one in the chamber."),
    requirements = {
        {
            statistic = "num_gains_pistol_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain handguns skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_pistol",
    name = ccb.content.text("Small But Deadly"),
    description = ccb.content.text("Caliber doesn't count when you're on the receiving end of the barrel."),
    requirements = {
        {
            statistic = "num_gains_pistol_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain handguns skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_pistol" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_pistol",
    name = ccb.content.text("Dirty Harry"),
    description = ccb.content.text("But being this is a .44 Magnum, the most powerful handgun in the world and would blow your head clean off, you've gotta ask yourself one question:  Do I feel lucky?  Well, do ya, punk?"),
    requirements = {
        {
            statistic = "num_gains_pistol_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain handguns skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_pistol" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_rifle",
    name = ccb.content.text("Recruit"),
    description = ccb.content.text("Point towards enemy and squeeze trigger."),
    requirements = {
        {
            statistic = "num_gains_rifle_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain rifles skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_rifle",
    name = ccb.content.text("Rifleman"),
    description = ccb.content.text("This is my rifle.  There are many like it, but this one is mine.  My rifle is my best friend.  It is my life.  I must master it as I must master my life."),
    requirements = {
        {
            statistic = "num_gains_rifle_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain rifles skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_rifle" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_rifle",
    name = ccb.content.text("Soldier"),
    description = ccb.content.text("Without me, my rifle is useless.  Without my rifle, I am useless.  I will keep my rifle clean and ready, even as I am clean and ready.  We will become part of each other."),
    requirements = {
        {
            statistic = "num_gains_rifle_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain rifles skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_rifle" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_shotgun",
    name = ccb.content.text("Buckshot Barrage"),
    description = ccb.content.text("This is my BOOMSTICK!"),
    requirements = {
        {
            statistic = "num_gains_shotgun_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain shotguns skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_shotgun",
    name = ccb.content.text("Double Barrel, Double Fun"),
    description = ccb.content.text("When you want to hit your target nine times with one shot."),
    requirements = {
        {
            statistic = "num_gains_shotgun_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain shotguns skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_shotgun" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_shotgun",
    name = ccb.content.text("Elmer Fudd"),
    description = ccb.content.text("What's up doc?  Hunting wabbits?"),
    requirements = {
        {
            statistic = "num_gains_shotgun_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain shotguns skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_shotgun" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_smg",
    name = ccb.content.text("Burst Fire"),
    description = ccb.content.text("Volume is a good strategy."),
    requirements = {
        {
            statistic = "num_gains_smg_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain submachine guns skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_smg",
    name = ccb.content.text("Spray'n'Pray"),
    description = ccb.content.text("One will hit.  It's a matter of statistics."),
    requirements = {
        {
            statistic = "num_gains_smg_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain submachine guns skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_smg" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_smg",
    name = ccb.content.text("SMG Goes BRRRT!"),
    description = ccb.content.text("We definitely need more ammo."),
    requirements = {
        {
            statistic = "num_gains_smg_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain submachine guns skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_smg" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_throw",
    name = ccb.content.text("Fling!"),
    description = ccb.content.text("Go that way!"),
    requirements = {
        {
            statistic = "num_gains_throw_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain throwing skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_throw",
    name = ccb.content.text("Yeet!"),
    description = ccb.content.text("And never come back."),
    requirements = {
        {
            statistic = "num_gains_throw_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain throwing skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_throw" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_throw",
    name = ccb.content.text("Kobe Bryant"),
    description = ccb.content.text("Frag out!"),
    requirements = {
        {
            statistic = "num_gains_throw_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain throwing skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_throw" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_melee",
    name = ccb.content.text("Fighter"),
    description = ccb.content.text("I can take a punch."),
    requirements = {
        {
            statistic = "num_gains_melee_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain melee skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_melee",
    name = ccb.content.text("Brawler"),
    description = ccb.content.text("Bottle in left hand, chair leg in right hand."),
    requirements = {
        {
            statistic = "num_gains_melee_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain melee skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_melee" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_melee",
    name = ccb.content.text("Street Fighter"),
    description = ccb.content.text("It's winning that matters, not the style."),
    requirements = {
        {
            statistic = "num_gains_melee_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain melee skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_melee" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_bashing",
    name = ccb.content.text("Batter"),
    description = ccb.content.text("Every strike brings me closer to a home run."),
    requirements = {
        {
            statistic = "num_gains_bashing_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain bashing weapons skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_bashing",
    name = ccb.content.text("Beater"),
    description = ccb.content.text("If you beat them enough, they stay down."),
    requirements = {
        {
            statistic = "num_gains_bashing_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain bashing weapons skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_bashing" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_bashing",
    name = ccb.content.text("Stone Age"),
    description = ccb.content.text("Cudgel was humanity's first tool.  And it may be its last, so why not master it?"),
    requirements = {
        {
            statistic = "num_gains_bashing_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain bashing weapons skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_bashing" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_cutting",
    name = ccb.content.text("Edged Combat"),
    description = ccb.content.text("Blades are one of man's most useful tools.  It was true then and it's even more true now."),
    requirements = {
        {
            statistic = "num_gains_cutting_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain cutting weapons skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_cutting",
    name = ccb.content.text("Way of the Sword"),
    description = ccb.content.text("When the sword is once drawn, the passions of men observe no bounds of moderation."),
    requirements = {
        {
            statistic = "num_gains_cutting_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain cutting weapons skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_cutting" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_cutting",
    name = ccb.content.text("Miyamoto Musashi"),
    description = ccb.content.text("The sword has to be more than a simple weapon; it has to be an answer to life's questions."),
    requirements = {
        {
            statistic = "num_gains_cutting_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain cutting weapons skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_cutting" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_dodge",
    name = ccb.content.text("Avoidant"),
    description = ccb.content.text("Better to move than to be still."),
    requirements = {
        {
            statistic = "num_gains_dodge_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain dodging skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_dodge",
    name = ccb.content.text("Elusive"),
    description = ccb.content.text("The strongest of blows is nothing if it doesn't land."),
    requirements = {
        {
            statistic = "num_gains_dodge_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain dodging skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_dodge" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_dodge",
    name = ccb.content.text("Neo"),
    description = ccb.content.text("But can you dodge a bullet?"),
    requirements = {
        {
            statistic = "num_gains_dodge_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain dodging skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_dodge" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_stabbing",
    name = ccb.content.text("Precise"),
    description = ccb.content.text("I strike where I mean to."),
    requirements = {
        {
            statistic = "num_gains_stabbing_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain piercing weapons skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_stabbing",
    name = ccb.content.text("Cold Steel"),
    description = ccb.content.text("While you were partying, I studied the blade."),
    requirements = {
        {
            statistic = "num_gains_stabbing_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain piercing weapons skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_stabbing" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_stabbing",
    name = ccb.content.text("Jack the Ripper"),
    description = ccb.content.text("Is this a dagger which I see before me, the handle toward my hand?  Come, let me clutch thee."),
    requirements = {
        {
            statistic = "num_gains_stabbing_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain piercing weapons skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_stabbing" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_unarmed",
    name = ccb.content.text("Pugilist"),
    description = ccb.content.text("There is strength in my hands."),
    requirements = {
        {
            statistic = "num_gains_unarmed_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain unarmed combat skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_unarmed",
    name = ccb.content.text("Road to Shaolin"),
    description = ccb.content.text("I feel an army in my fist."),
    requirements = {
        {
            statistic = "num_gains_unarmed_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain unarmed combat skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_unarmed" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_unarmed",
    name = ccb.content.text("Mr. Miyagi"),
    description = ccb.content.text("To be your own weapon."),
    requirements = {
        {
            statistic = "num_gains_unarmed_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain unarmed combat skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_unarmed" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_4_chemistry",
    name = ccb.content.text("Periodic Table"),
    description = ccb.content.text("I remember some of this from school."),
    requirements = {
        {
            statistic = "num_gains_chemistry_level_4",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain applied science skill level 4"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_7_chemistry",
    name = ccb.content.text("Chemical engineer"),
    description = ccb.content.text("It's somewhat like cooking.  Just don't lick the spoon."),
    requirements = {
        {
            statistic = "num_gains_chemistry_level_7",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain applied science skill level 7"),
        },
    },
    hidden_by = { "achievement_lvl_4_chemistry" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_chemistry",
    name = ccb.content.text("Heisenberg"),
    description = ccb.content.text("You all know who I am.  I'm the cook.  Say my name."),
    requirements = {
        {
            statistic = "num_gains_chemistry_level_10",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Gain applied science skill level 10"),
        },
    },
    hidden_by = { "achievement_lvl_7_chemistry" },
}

ccb.content.define_achievement {
    id = "achievement_witnessed_portal_storm",
    name = ccb.content.text("Reality is falling apart"),
    description = ccb.content.text("You will be baked, and then there will be cake."),
    requirements = {
        {
            statistic = "witnessed_portal_storm",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Survive a portal storm"),
        },
    },
}

ccb.content.define_achievement {
    id = "escaped_the_cataclysm",
    name = ccb.content.text("True Freedom"),
    description = ccb.content.text("And to think you hesitated."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_officer_kill",
    name = ccb.content.text("Killed the XEDRA officer"),
    manual = true,
    description = ccb.content.text("The haunting has finished and I am victorious."),
    requirements = {},
}

-- this is the achievement that lets you forever have meta progression disabled
ccb.content.define_achievement {
    id = "achievement_arcade_mode",
    name = ccb.content.text("Arcade Mode"),
    manual = true,
    description = ccb.content.text("STOP HAND-HOLDING ME!!!"),
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_reach_exodii_base",
    name = ccb.content.text("Strange Neighbors"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "exodii_base" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach the strange fortress"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_balthazar",
    name = ccb.content.text("Bunker Robot(s)"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "balthazar_bunker" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Find the bunker complex"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_hub01",
    name = ccb.content.text("Is this thing on?"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "hub_01" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach Hub 01"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_new_england_church_retreat",
    name = ccb.content.text("Bible Study"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "New England Church Retreat" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Do you have a few minutes to talk about our lord and savior Jesus Christ?"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_isherwood_farms",
    name = ccb.content.text("Open Fields"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Isherwood Farm Mutable" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach Isherwood Farms"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_aircraft_carrier",
    name = ccb.content.text("Top Gun"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "aircraft_carrier" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach the Aircraft Carrier"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_nuclear_plant",
    name = ccb.content.text("I'm Nuclear!"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "nuclear power plant" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Nuclear Plant"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_island_prison",
    name = ccb.content.text("Concrete Hell"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Island prison" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach an Island Prison"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_mi-Go_encampment",
    name = ccb.content.text("The Whisperer in Darkness"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Mi-Go Encampment" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Mi-Go Encampment"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_trans_coast_lab",
    name = ccb.content.text("Eureka!"),
    requirements = {
        {
            statistic = "num_avatar_enters_trans_lab",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Trans Coastal Facility"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_bastion_fort",
    name = ccb.content.text("What a Larp!"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Bastion Fort" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Bastion Fort"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_military_base",
    name = ccb.content.text("Zombie Army"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "mil_base" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Military Base"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_military_bunker",
    name = ccb.content.text("Zombie Forces"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "military_bunker_1" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Military Bunker"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_triffid_grove",
    name = ccb.content.text("Floral combat!"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Triffid Grove" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Triffid Grove"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_megastore",
    name = ccb.content.text("Shop Smart, Shop S-Mart!"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "megastore" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Megastore"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_hospital",
    name = ccb.content.text("The Doctor is out!"),
    requirements = {
        {
            statistic = "num_avatar_enters_hospital",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Hospital"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_mid_z_level",
    name = ccb.content.text("I can see my house from here!"),
    requirements = { { statistic = "max_move_z", comparison = ">=", target = 6 } },
}

ccb.content.define_achievement {
    id = "achievement_reach_negative_z_level",
    name = ccb.content.text("All downhill from here."),
    requirements = { { statistic = "min_move_z", comparison = "<=", target = -5 } },
}

ccb.content.define_achievement {
    id = "achievement_reach_fungal_tower",
    name = ccb.content.text("Oh Shitake!"),
    requirements = {
        {
            statistic = "last_overmap_special_avatar_entered",
            comparison = "==",
            target = { type = "overmap_special_id", value = "Fungal Tower" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Fungal Tower"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_mansion",
    name = ccb.content.text("Lifestyles of the rich and fetid!"),
    requirements = {
        {
            statistic = "num_avatar_enters_mansion",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Mansion"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_mine",
    name = ccb.content.text("We need to go deeper!"),
    requirements = {
        {
            statistic = "num_avatar_enters_mine",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Mine"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_police_station",
    name = ccb.content.text("Zombie PD, to protect and zombify!"),
    requirements = {
        {
            statistic = "num_avatar_enters_police_station",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a Police Station"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_read_books_250",
    name = ccb.content.text("Avid Reader"),
    description = ccb.content.text("Read any book 250 times"),
    requirements = {
        {
            statistic = "num_reads_book",
            comparison = ">=",
            target = 250,
            description = ccb.content.text("Read books 250 times"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_read_books_500",
    name = ccb.content.text("Dedicated Reader"),
    description = ccb.content.text("Read any book 500 times"),
    hidden_by = { "achievement_read_books_250" },
    requirements = {
        {
            statistic = "num_reads_book",
            comparison = ">=",
            target = 500,
            description = ccb.content.text("Read books 500 times"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_read_books_1000",
    name = ccb.content.text("Bibliophile"),
    description = ccb.content.text("Read any book 1000 times"),
    hidden_by = { "achievement_read_books_500" },
    requirements = {
        {
            statistic = "num_reads_book",
            comparison = ">=",
            target = 1000,
            description = ccb.content.text("Read books 1000 times"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_break_3_bones",
    name = ccb.content.text("That's not supposed to bend that way!"),
    requirements = {
        {
            statistic = "num_broken_bone",
            comparison = ">=",
            target = 3,
            description = ccb.content.text("Break 3 bones"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_break_6_bones",
    name = ccb.content.text("Paper mache limbs"),
    hidden_by = { "achievement_break_3_bones" },
    requirements = {
        {
            statistic = "num_broken_bone",
            comparison = ">=",
            target = 6,
            description = ccb.content.text("Break 6 bones"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_break_10_bones",
    name = ccb.content.text("Amateur Orthopedic Surgeon"),
    hidden_by = { "achievement_break_6_bones" },
    requirements = {
        {
            statistic = "num_broken_bone",
            comparison = ">=",
            target = 10,
            description = ccb.content.text("Break 10 bones"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_heal_250_damage",
    name = ccb.content.text("Beginner Survivor"),
    requirements = {
        {
            statistic = "avatar_damage_healed",
            comparison = ">=",
            target = 250,
            description = ccb.content.text("Heal 250 Damage"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_heal_1000_damage",
    name = ccb.content.text("Accomplished Survivor"),
    hidden_by = { "achievement_heal_250_damage" },
    requirements = {
        {
            statistic = "avatar_damage_healed",
            comparison = ">=",
            target = 1000,
            description = ccb.content.text("Heal 1,000 Damage"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_heal_2500_damage",
    name = ccb.content.text("Veteran Survivor"),
    hidden_by = { "achievement_heal_1000_damage" },
    requirements = {
        {
            statistic = "avatar_damage_healed",
            comparison = ">=",
            target = 2500,
            description = ccb.content.text("Heal 2,500 Damage"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_heal_5000_damage",
    name = ccb.content.text("Hardened Survivor"),
    hidden_by = { "achievement_heal_2500_damage" },
    requirements = {
        {
            statistic = "avatar_damage_healed",
            comparison = ">=",
            target = 5000,
            description = ccb.content.text("Heal 5,000 Damage"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_LIXA",
    name = ccb.content.text("She Blinded Me… With SCIENCE!"),
    requirements = {
        {
            statistic = "num_avatar_enters_LIXA",
            comparison = ">=",
            target = 1,
            visibility = "when_achievement_completed",
            description = ccb.content.text("Reach a research lab"),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_reach_highlands",
    name = ccb.content.text("Things betwixt"),
    manual = true,
    description = ccb.content.text("Along the shore the cloud waves break,\nThe twin suns sink beneath the lake,\nThe shadows lengthen\n                       In Carcosa."),
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_reach_string_dimension",
    name = ccb.content.text("String Theory"),
    manual = true,
    description = ccb.content.text("Reach the dimension of sundered spacetime, and live to tell the tale."),
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_LIXA_finale",
    name = ccb.content.text("Trigintaduonion"),
    manual = true,
    description = ccb.content.text("Defeat a being from a higher dimension, and free the damned souls trapped inside"),
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_exodii_hub_autodoc_death",
    name = ccb.content.text("Vespertilio Perfidus"),
    manual = true,
    description = ccb.content.text("He that is neither one thing nor the other has no friends."),
    requirements = {},
}

ccb.content.define_achievement {
    id = "achievement_reach_labyrinth",
    name = ccb.content.text("You don't by any chance know the way through this labyrinth, do you?"),
    manual = true,
    description = ccb.content.text("Enter a netherum labyrinth."),
    requirements = {},
}
