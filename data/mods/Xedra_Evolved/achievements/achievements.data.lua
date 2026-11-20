local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_kill_changeling",
    name = ccb.content.text("Smashed a pixie."),
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_changelings",
    name = ccb.content.text("Underhill Hunter"),
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_changelings",
    name = ccb.content.text("Unseelie competition"),
    hidden_by = { "achievement_kill_10_changelings" },
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_changelings",
    name = ccb.content.text("They tell stories to their children of you."),
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_changelings",
    name = ccb.content.text("Faebane"),
    hidden_by = { "achievement_kill_1000_changelings" },
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_changelings",
    name = ccb.content.text("Your name is considered to be cold iron."),
    hidden_by = { "achievement_kill_10000_changelings" },
    requirements = { { statistic = "num_avatar_changeling_kills", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_vampire",
    name = ccb.content.text("Arthur 'Art' Holmwood.  Avenger of lost innocence."),
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_vampires",
    name = ccb.content.text("The third Frog brother."),
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_vampires",
    name = ccb.content.text("Were you chosen as the Slayer?"),
    hidden_by = { "achievement_kill_10_vampires" },
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_vampires",
    name = ccb.content.text("You have an ongoing competition with Blade."),
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_vampires",
    name = ccb.content.text("Founding member of the Hammer and Stake Society"),
    hidden_by = { "achievement_kill_1000_vampires" },
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_vampires",
    name = ccb.content.text("Van Helsing's mentor."),
    hidden_by = { "achievement_kill_10000_vampires" },
    requirements = { { statistic = "num_avatar_vampire_kills", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_gains_dreamer_trait",
    name = ccb.content.text("Never Wake again"),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "DREAMER" },
            description = ccb.content.text("Gained access to dream magic."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_eater_trait",
    name = ccb.content.text("Destroy what doesn't belong."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "EATER" },
            description = ccb.content.text("Gained access to eater magic."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_dreamsmith_trait",
    name = ccb.content.text("Forged by dreams"),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "DREAMSMITH" },
            description = ccb.content.text("Gained access to dream forging magic"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_inventor_trait",
    name = ccb.content.text("This has a small, but fascinating, chance of actually working!  Let's do it!"),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "INVENTOR" },
            description = ccb.content.text("Gained access to mad genius inventions."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_vampire_trait",
    name = ccb.content.text("Welcome to Salem's Lot."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "VAMPIRE" },
            description = ccb.content.text("Developed an unnatural thirst."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_vampire2_trait",
    name = ccb.content.text("John 'Not-A-Vampire-At-All' Smith"),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "VAMPIRE2" },
            description = ccb.content.text("You could still become a Black Ribboner and join the League of Temperance."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_vampire3_trait",
    name = ccb.content.text("Ivy Tamwood, eat your heart out.  'kisskiss' hand motion."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "VAMPIRE3" },
            description = ccb.content.text("Right on the edge of becoming a true vampire."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_vampire4_trait",
    name = ccb.content.text("Embracing the curse, building your power."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "VAMPIRE4" },
            description = ccb.content.text("You became a true vampire, forsaking your mortality forevermore."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_vampire5_trait",
    name = ccb.content.text("Fully walked the shadowed path of blood."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "BLOOD_DRINKER" },
            description = ccb.content.text("You reached the final state of vampirism, becoming worthy of the title of ruler of the night."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_lvl_1_deduction",
    name = ccb.content.text("Inspector Lestrade"),
    description = ccb.content.text("Sherlock Holmes you are not but you definitely see more details than you did before."),
    requirements = { { statistic = "num_gains_deduction_level_1", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_lvl_5_deduction",
    name = ccb.content.text("The Truth is out there"),
    description = ccb.content.text("You can quickly deduce the events leading to every death scene you come across, unfortunately the cause is now always either zombie or suicide."),
    requirements = { { statistic = "num_gains_deduction_level_5", comparison = ">=", target = 1 } },
    hidden_by = { "achievement_lvl_1_deduction" },
}

ccb.content.define_achievement {
    id = "achievement_lvl_10_deduction",
    name = ccb.content.text("Knowing everything you weren't meant to know"),
    description = ccb.content.text("The things that aren't, that never were, that have yet to be and that are but shouldn't be, they hold no secret from you now."),
    requirements = { { statistic = "num_gains_deduction_level_10", comparison = ">=", target = 1 } },
    hidden_by = { "achievement_lvl_5_deduction" },
}

ccb.content.define_achievement {
    id = "achievement_find_border_patrol_office",
    name = ccb.content.text("Do borders even matter now?"),
    requirements = {
        {
            statistic = "last_oter_type_avatar_entered",
            comparison = "==",
            target = { type = "oter_type_str_id", value = "field_office_3" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("Enter a Border Patrol Office"),
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_changeling_trait_noble",
    name = ccb.content.text("A perfect cabinet of oddities."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "THRESH_FAIR_FOLK_NOBLE" },
            description = ccb.content.text("You have joined the courts of your Sidhe kin."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_changeling_trait_brownie",
    name = ccb.content.text("The last helpmeet."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
            description = ccb.content.text("Will you stay here easing the troubles and travails of mankind into its final dusk?  Or will you find hearths beyond this homeworld."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_changeling_trait_pooka",
    name = ccb.content.text("Prankster at the end of the world."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "THRESH_FAIR_FOLK_COMMONER_POOKA" },
            description = ccb.content.text("A unbroken trail alternating between feet and paws."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_changeling_trait_selkie",
    name = ccb.content.text("No one swims only in the shallow water."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
            description = ccb.content.text("Do you choose land or water?"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "avchievement_gains_changeling_trait_trow",
    name = ccb.content.text("Carved from the Mountain."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "THRESH_FAIR_FOLK_COMMONER_TROW" },
            description = ccb.content.text("Where you stand, none shall pass without your leave."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_xe_complete_revenant_mission",
    name = ccb.content.text("Rerisen Revengeance."),
    description = ccb.content.text("Kill your murderer as a revenant"),
    manual = true,
    requirements = {},
    hidden_by = { "achievement_xe_complete_revenant_mission" },
}
