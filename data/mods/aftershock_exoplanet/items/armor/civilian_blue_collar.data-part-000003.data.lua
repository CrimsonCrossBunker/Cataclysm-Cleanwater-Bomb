local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hazard_suit",
    copy_from = "robofac_enviro_suit",
    name = ccb.content.plural_text("soft hazard suit", "soft hazard suits"),
    materials = { "plastic", "cotton" },
    description = ccb.content.text("A brightly colored, standard-fab pattern environmental suit for use in industrial and medical settings.  Offers good protection from chemical and radioactive hazards, but is not insulated against heat or cold.  Requires a gas mask or sealed helmet for full protection."),
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "foot_l", "foot_r", "head", "torso", "eyes", "mouth", "leg_l", "leg_r", "arm_l",
                    "arm_r", "hand_l", "hand_r",
                },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear casually"),
            message = ccb.content.text("You slip out of the top of the suit and tie the sleeves around your waist."),
            target = "afs_hazard_suit_casual",
        },
    },
}

ccb.content.define_item {
    id = "afs_hazard_suit_casual",
    copy_from = "robofac_enviro_suit_casual",
    name = ccb.content.plural_text("soft hazard suit (casual)", "soft hazard suits (casual)"),
    description = ccb.content.text("A brightly colored, standard-fab pattern environmental suit for use in industrial and medical settings.  The upper portion has been tied around the waist casually."),
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r", "head", "leg_l", "leg_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear normally"),
            message = ccb.content.text("You untie the sleeves and put back on the top of the suit."),
            target = "afs_hazard_suit",
        },
    },
}
