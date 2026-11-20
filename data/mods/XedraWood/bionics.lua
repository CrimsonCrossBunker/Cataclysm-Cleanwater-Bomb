local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "flames_tattoo_one",
    name = ccb.content.text("The Smoke of the Fire"),
    description = ccb.content.text("The first element of the flames pattern, the rising smoke above the bonfire that floats up to the stars and disappears, depicted on the upper back.  When active, you will immediately rise if you are downed and you'll gain a speed bonus for a short period of time afterwards."),
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_flames_tattoo_one_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 4 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "flames_tattoo_two",
    name = ccb.content.text("The Light of the Fire"),
    description = ccb.content.text("The second element of the flames pattern, the light emitted by the fire, that comfort to weary travelers and beacon in the darkness, depicted in a dim glow on all your limbs.  When active, a softly flickering reddish light springs up around you, illuminating your surroundings."),
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 50000,
    charge_time_turns = 1,
    required_bionic = "flames_tattoo_one",
    enchantments = { "BIONIC_ENCH_flames_tattoo_two_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 }, { bodypart = "torso", slots = 5 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "mountain_tattoo_one",
    name = ccb.content.text("Roots of the Mountain"),
    description = ccb.content.text("The first element of the mountain pattern, a series of stylized boulders and trees on the upper legs.  It makes your limbs more resilient, providing them with extra armor."),
    protection = { { bodypart = "arm_l", damage_type = "bash", amount = 4 }, { bodypart = "arm_l", damage_type = "cut", amount = 2 }, { bodypart = "arm_r", damage_type = "bash", amount = 4 }, { bodypart = "arm_r", damage_type = "cut", amount = 2 }, { bodypart = "hand_l", damage_type = "bash", amount = 4 }, { bodypart = "hand_l", damage_type = "cut", amount = 2 }, { bodypart = "hand_r", damage_type = "bash", amount = 4 }, { bodypart = "hand_r", damage_type = "cut", amount = 2 }, { bodypart = "leg_l", damage_type = "bash", amount = 4 }, { bodypart = "leg_l", damage_type = "cut", amount = 2 }, { bodypart = "leg_r", damage_type = "bash", amount = 4 }, { bodypart = "leg_r", damage_type = "cut", amount = 2 }, { bodypart = "foot_l", damage_type = "bash", amount = 4 }, { bodypart = "foot_l", damage_type = "cut", amount = 2 }, { bodypart = "foor_r", damage_type = "bash", amount = 4 }, { bodypart = "foor_r", damage_type = "cut", amount = 2 } },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "mountain_tattoo_three",
    name = ccb.content.text("Slopes of the Mountain"),
    description = ccb.content.text("The third element of the mountain pattern, the pathways up the mountain past forest glens and rushing streams, taking up the rest of the lower back.  When activated, you cannot be knocked back, dazed, stunned, or downed."),
    activation_energy_millijoules = 125000,
    over_time_energy_millijoules = 125000,
    charge_time_turns = 1,
    required_bionic = "mountain_tattoo_two",
    enchantments = { "BIONIC_ENCH_mountain_tattoo_three_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 15 } },
})
content.add(content.Bionic {
    id = "mountain_tattoo_four",
    name = ccb.content.text("The Caverns Beneath the Mountain"),
    description = ccb.content.text("The fourth element of the mountain pattern, the fantastic caverns and hidden grottos depicted on the legs.  You regain anima when underground, proportional to your depth beneath the earth, and have even more armor on your limbs."),
    required_bionic = "mountain_tattoo_three",
    enchantments = { "BIONIC_ENCH_mountain_tattoo_four_0" },
    protection = { { bodypart = "arm_l", damage_type = "bash", amount = 4 }, { bodypart = "arm_l", damage_type = "cut", amount = 2 }, { bodypart = "arm_r", damage_type = "bash", amount = 4 }, { bodypart = "arm_r", damage_type = "cut", amount = 2 }, { bodypart = "hand_l", damage_type = "bash", amount = 4 }, { bodypart = "hand_l", damage_type = "cut", amount = 2 }, { bodypart = "hand_r", damage_type = "bash", amount = 4 }, { bodypart = "hand_r", damage_type = "cut", amount = 2 }, { bodypart = "leg_l", damage_type = "bash", amount = 4 }, { bodypart = "leg_l", damage_type = "cut", amount = 2 }, { bodypart = "leg_r", damage_type = "bash", amount = 4 }, { bodypart = "leg_r", damage_type = "cut", amount = 2 }, { bodypart = "foot_l", damage_type = "bash", amount = 4 }, { bodypart = "foot_l", damage_type = "cut", amount = 2 }, { bodypart = "foor_r", damage_type = "bash", amount = 4 }, { bodypart = "foor_r", damage_type = "cut", amount = 2 } },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 8 }, { bodypart = "leg_r", slots = 8 } },
})
content.add(content.Bionic {
    id = "mountain_tattoo_five",
    name = ccb.content.text("The Heights of the Mountain"),
    description = ccb.content.text("The fifth element of the mountain pattern, the areas above the tree line and the unmelting snows depicted on the upper back.  Your stamina is increased by 50%, and you may activate this element to regenerate stamina at 5x normal speed."),
    activation_energy_millijoules = 450000,
    over_time_energy_millijoules = 450000,
    charge_time_turns = 1,
    required_bionic = "mountain_tattoo_four",
    enchantments = { "BIONIC_ENCH_mountain_tattoo_five_0", "BIONIC_ENCH_mountain_tattoo_five_1" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
