local ccb = require("ccb")

ccb.content.define_conduct {
    id = "conduct_no_smash",
    name = ccb.content.text("Mouse in a china shop"),
    requirements = {
        {
            statistic = "num_avatar_smash",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Smash no tiles"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_no_attacks",
    name = ccb.content.text("Nonviolence"),
    requirements = {
        {
            statistic = "num_avatar_melee_attacks_monster",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No melee attacks against monsters"),
        },
        {
            statistic = "num_avatar_melee_attacks_character",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No melee attacks against characters"),
        },
        {
            statistic = "num_avatar_ranged_attacks_monster",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No ranged attacks against monsters"),
        },
        {
            statistic = "num_avatar_ranged_attacks_character",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No ranged attacks against characters"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_zero_kills",
    name = ccb.content.text("Pacifist"),
    requirements = {
        {
            statistic = "num_avatar_monster_kills",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Kill no monsters"),
        },
        {
            statistic = "num_avatar_character_kills",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Kill no characters"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_zero_character_kills",
    name = ccb.content.text("Merciful"),
    hidden_by = { "conduct_zero_kills" },
    requirements = {
        {
            statistic = "num_avatar_character_kills",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Kill no characters"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_zero_cut_trees",
    name = ccb.content.text("The Elven Path"),
    requirements = {
        {
            statistic = "num_cuts_tree",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Cut no trees"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_pure_human",
    name = ccb.content.text("Homo Sapiens"),
    requirements = {
        {
            statistic = "num_installs_cbm",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Install no bionic implants"),
        },
        {
            statistic = "num_installs_faulty_cbm",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Install no faulty bionic implants"),
        },
        {
            statistic = "num_gains_mutation",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No mutations"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_no_cbm",
    name = ccb.content.text("Clean on X-ray"),
    requirements = {
        {
            statistic = "num_installs_cbm",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Install no bionic implants"),
        },
        {
            statistic = "num_installs_faulty_cbm",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Install no faulty bionic implants"),
        },
    },
    hidden_by = { "conduct_pure_human" },
}

ccb.content.define_conduct {
    id = "conduct_no_mutations",
    name = ccb.content.text("Pure Blood"),
    requirements = {
        {
            statistic = "num_gains_mutation",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No mutations"),
        },
    },
    hidden_by = { "conduct_pure_human" },
}

ccb.content.define_conduct {
    id = "conduct_no_broken_bones",
    name = ccb.content.text("Structural Integrity"),
    requirements = {
        {
            statistic = "num_broken_bone",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Break no bones"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_no_skill_levels_gained",
    name = ccb.content.text("Teacher, Leave Them Kids Alone"),
    requirements = {
        {
            statistic = "num_gains_skill_level",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Gain no skill levels"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_no_books_read",
    name = ccb.content.text("Self-Imposed Illiteracy"),
    requirements = {
        {
            statistic = "num_reads_book",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Read no books"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_no_food",
    name = ccb.content.text("Foodless"),
    requirements = {
        {
            statistic = "num_avatar_eats_item",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Eat nothing"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_vegan",
    name = ccb.content.text("Vegan"),
    requirements = {
        {
            statistic = "num_avatar_consumes_allergen_milk",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Consume no milk"),
        },
        {
            statistic = "num_avatar_consumes_allergen_eggs",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Consume no eggs"),
        },
        {
            statistic = "num_avatar_consumes_allergen_meat",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Consume no meat"),
        },
    },
    hidden_by = { "conduct_no_food" },
}

ccb.content.define_conduct {
    id = "conduct_vegetarian",
    name = ccb.content.text("Vegetarian"),
    requirements = {
        {
            statistic = "num_avatar_consumes_allergen_meat",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Consume no meat"),
        },
    },
    hidden_by = { "conduct_vegan" },
}

ccb.content.define_conduct {
    id = "conduct_speed_limit_35",
    name = ccb.content.text("Residential speed limit"),
    requirements = {
        {
            statistic = "max_velocity_gndv",
            comparison = "<=",
            target = 3500,
            description = ccb.content.text("Do not exceed 35 mph when driving land vehicles"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_speed_limit_50",
    name = ccb.content.text("Rural road speed limit"),
    requirements = {
        {
            statistic = "max_velocity_gndv",
            comparison = "<=",
            target = 5000,
            description = ccb.content.text("Do not exceed 50 mph when driving land vehicles"),
        },
    },
    hidden_by = { "conduct_speed_limit_35" },
}

ccb.content.define_conduct {
    id = "conduct_speed_limit_65",
    name = ccb.content.text("Freeway speed limit"),
    requirements = {
        {
            statistic = "max_velocity_gndv",
            comparison = "<=",
            target = 6500,
            description = ccb.content.text("Do not exceed 65 mph when driving land vehicles"),
        },
    },
    hidden_by = { "conduct_speed_limit_50" },
}

ccb.content.define_conduct {
    id = "conduct_no_transport",
    name = ccb.content.text("On My Own Two Feet"),
    requirements = {
        {
            statistic = "num_moves_mounted",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Ride no mounts"),
        },
        {
            statistic = "num_moves_veh_onboard",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Ride no vehicles"),
        },
    },
}

ccb.content.define_conduct {
    id = "conduct_landlubber",
    name = ccb.content.text("Landlubber"),
    requirements = {
        {
            statistic = "num_moves_swam",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("No swimming"),
        },
        {
            statistic = "num_moves_boat_onboard",
            comparison = "<=",
            target = 0,
            description = ccb.content.text("Ride no watercraft"),
        },
    },
}
