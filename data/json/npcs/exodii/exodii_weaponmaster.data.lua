local ccb = require("ccb")

-- while it can be handled via limbs and stuff, player have no way to obtain this frame (yet? ever? time will tell) so just enchantments
ccb.content.define_mutation {
    id = "EXODII_BODY_9",
    flags = { "Exodii_Body" },
    name = ccb.content.text("Exodii cyborg framework - style 9"),
    points = 0,
    visibility = 9,
    ugliness = 7,
    mixed_effect = true,
    description = ccb.content.text("Your entire body is covered by a rectangular frame, that has numerous supporting arms and manipulators, with decent stability.  The price of this is that the weight of the entire frame is enormous, which causes the user to either use dedicated tracked treads to move around, or stay immobile for a large amount of time."),
    valid = false,
    purifiable = false,
    types = { "Cyberframe", "Cybernetic" },
    enchantments = { "INLINE_ENCH_EXODII_BODY_9_0" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    armor = {
        {
            parts = {
                "torso",
                "head",
                "arm_l",
                "arm_r",
                "hand_l",
                "hand_r",
                "leg_l",
                "leg_r",
                "foot_l",
                "foot_r",
                "mouth",
            },
            resistances = { cut = 30, bash = 30, stab = 30, bullet = 25, acid = 25, electric = 5 },
        },
    },
}
