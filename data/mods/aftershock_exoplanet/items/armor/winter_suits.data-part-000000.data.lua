local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_frontier_cryo_xl_on",
    name = ccb.content.plural_text("uplift cryo suit (on)", "uplift cryo suits (on)"),
    copy_from = "afs_frontier_cryo_xl",
    revert_to = "afs_frontier_cryo_xl",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_frontier_cryo_xl",
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo_xl",
    name = ccb.content.plural_text("Mercurial cryo suit", "Mercurial cryo suits"),
    copy_from = "afs_combat_cryo",
    description = ccb.content.text("A sleek black undersuit criss-crossed with the tubing of a heat regulation unit.  Insulation is kept at a minimum to allow for combat mobility, and the suit is quite power hungry as a result.  Despite the name, it's minimally protective and designed to be worn under a set of armor.  Made to fit the uplifted, the heavily augmented, or similarly sized individuals."),
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL", "ALLOWS_NATURAL_ATTACKS" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 3.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "head", "torso", "eyes", "mouth", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l",
                    "hand_r", "tail", "animal_paw_l", "animal_paw_r", "paw_default_l", "paw_default_r",
                    "hoof_r", "hoof_l",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_combat_cryo_on_xl",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo_on_xl",
    name = ccb.content.plural_text("Mercurial cryo suit (on)", "Mercurial cryo suits (on)"),
    copy_from = "afs_combat_cryo_xl",
    revert_to = "afs_combat_cryo_xl",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_combat_cryo_xl",
        },
    },
}
