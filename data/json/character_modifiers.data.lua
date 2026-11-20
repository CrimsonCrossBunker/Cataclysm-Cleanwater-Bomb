local ccb = require("ccb")

ccb.content.define_character_modifier {
    id = "aim_speed_skill_mod",
    description = ccb.content.text("Aim speed skill modifier"),
    operation = "add",
    builtin = "aim_speed_skill_modifier",
}

ccb.content.define_character_modifier {
    id = "aim_speed_dex_mod",
    description = ccb.content.text("Aim speed dexterity modifier"),
    operation = "add",
    builtin = "aim_speed_dex_modifier",
}

ccb.content.define_character_modifier {
    id = "aim_speed_mod",
    description = ccb.content.text("Gun aim speed modifier <color_dark_gray>(Manipulation, Grip, Lift)</color> "),
    operation = "multiply",
    scores = { { id = "grip", weight = 0.4 }, { id = "manip", weight = 0.4 }, { id = "lift", weight = 0.9 } },
    combine = "add",
    min = 0.1,
    max = 1.8,
}

ccb.content.define_character_modifier {
    id = "solid_consume_mod",
    description = ccb.content.text("Consume time multiplier for solid foods."),
    operation = "multiply",
    scores = "consume_solid",
    max = 10,
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "liquid_consume_mod",
    description = ccb.content.text("Consume time multiplier for drinks."),
    operation = "multiply",
    scores = "consume_liquid",
    max = 10,
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "melee_thrown_move_lift_mod",
    description = ccb.content.text("Melee and thrown attack movement point modifier <color_dark_gray>(Lift)</color>"),
    operation = "multiply",
    scores = "lift",
    max = 3,
    override_encumbrance = true,
    override_wounds = true,
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "melee_thrown_move_balance_mod",
    description = ccb.content.text("Melee and thrown attack movement point modifier <color_dark_gray>(Balance)</color>"),
    operation = "multiply",
    scores = "balance",
    max = 3,
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "melee_stamina_cost_mod",
    description = ccb.content.text("Melee stamina cost <color_dark_gray>(Lift)</color>"),
    operation = "multiply",
    scores = "lift",
    override_encumbrance = true,
    max = 20,
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "reloading_move_mod",
    description = ccb.content.text("Reloading movement point cost <color_dark_gray>(Manipulation)</color>"),
    operation = "multiply",
    scores = "manip",
    limb_type = "hand",
    max = "max_move_cost",
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "thrown_dex_mod",
    description = ccb.content.text("Dexterity when throwing items <color_dark_gray>(Manipulation)</color>"),
    operation = "multiply",
    scores = "manip",
    limb_type = "hand",
}

ccb.content.define_character_modifier {
    id = "ranged_dispersion_manip_mod",
    description = ccb.content.text("Hand dispersion when using ranged attacks <color_dark_gray>(Manipulation)</color>"),
    operation = "add",
    scores = "manip",
    limb_type = "hand",
    max = 1000.0,
    numerator = 22.8,
    subtract = 22.8,
}

ccb.content.define_character_modifier {
    id = "ranged_dispersion_vision_mod",
    description = ccb.content.text("Sight dispersion when using ranged attacks <color_dark_gray>(Vision)</color>"),
    operation = "add",
    scores = "vision",
    max = 10000.0,
    numerator = 30.0,
    subtract = 30.0,
}

ccb.content.define_character_modifier {
    id = "move_mode_move_cost_mod",
    description = ccb.content.text("Move mode move cost modifier"),
    operation = "multiply",
    builtin = "move_mode_move_cost_modifier",
}

-- Major limb scores - grip would be nice but unless
ccb.content.define_character_modifier {
    id = "grab_break_limb_mod",
    description = ccb.content.text("Grab break success modifier"),
    operation = "multiply",
    scores = { "balance", { id = "lift", weight = 2 }, "move_speed", "grip" },
    combine = "multiply",
    min = 0.1,
    max = 0.9,
}

ccb.content.define_character_modifier {
    id = "stamina_move_cost_mod",
    description = ccb.content.text("Stamina move cost modifier"),
    operation = "multiply",
    builtin = "stamina_move_cost_modifier",
}

ccb.content.define_character_modifier {
    id = "stamina_recovery_breathing_mod",
    description = ccb.content.text("Stamina Regeneration <color_dark_gray>(Breathing)</color>"),
    operation = "multiply",
    scores = "breathing",
}

ccb.content.define_character_modifier {
    id = "crawl_speed_movecost_mod",
    description = ccb.content.text("Crawl speed move cost modifier <color_dark_gray>(Crawling)</color>"),
    operation = "multiply",
    scores = "crawl",
    max = "max_move_cost",
    numerator = 1.2,
}

ccb.content.define_character_modifier {
    id = "limb_speed_movecost_mod",
    description = ccb.content.text("Limb speed move cost modifier <color_dark_gray>(Movement)</color>"),
    operation = "multiply",
    scores = "move_speed",
    max = "max_move_cost",
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "limb_footing_movecost_mod",
    description = ccb.content.text("Footing move cost modifier <color_dark_gray>(Footing)</color>"),
    operation = "multiply",
    scores = "footing",
    max = "max_move_cost",
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "limb_fall_mod",
    description = ccb.content.text("Fall damage modifier <color_dark_gray>(Movement, Footing, Reaction)</color>"),
    operation = "multiply",
    scores = { "move_speed", "footing", "reaction" },
    combine = "multiply",
}

ccb.content.define_character_modifier {
    id = "slip_prevent_mod",
    description = ccb.content.text("Slip prevention modifier"),
    operation = "multiply",
    scores = { { id = "grip", weight = 3.0 }, { id = "lift", weight = 2.0 }, "footing" },
    override_encumbrance = true,
    combine = "add",
    denominator = 6.0,
}

ccb.content.define_character_modifier {
    id = "obstacle_climb_mod",
    description = ccb.content.text("Obstacle climb modifier <color_dark_gray>(Crawling, Grip, Lift)</color>"),
    operation = "multiply",
    scores = { { id = "crawl", weight = 3.0 }, { id = "grip", weight = 2.0 }, "lift" },
    override_encumbrance = true,
    combine = "add",
    denominator = 6.0,
}

ccb.content.define_character_modifier {
    id = "bleed_staunch_mod",
    description = ccb.content.text("Maximum bleed intensity staunchable by hand <color_dark_gray>(Manipulation, Grip)</color>"),
    operation = "multiply",
    scores = { "grip", "manip" },
    combine = "multiply",
}

ccb.content.define_character_modifier {
    id = "limb_str_mod",
    description = ccb.content.text("Strength modifier <color_dark_gray>(Lift)</color>"),
    operation = "multiply",
    scores = "lift",
}

ccb.content.define_character_modifier {
    id = "limb_run_cost_mod",
    description = ccb.content.text("Limb run cost modifier <color_dark_gray>(Movement, Footing)</color>"),
    operation = "multiply",
    builtin = "limb_run_cost_modifier",
}

ccb.content.define_character_modifier {
    id = "swim_mod",
    description = ccb.content.text("Swimming movement point cost <color_dark_gray>(Swimming)</color>"),
    operation = "multiply",
    scores = "swim",
    max = "max_move_cost",
    numerator = 1.0,
}

ccb.content.define_character_modifier {
    id = "melee_attack_roll_mod",
    description = ccb.content.text("Melee attack rolls <color_dark_gray>(Balance)</color>"),
    operation = "multiply",
    scores = "balance",
    min = 0.2,
}

ccb.content.define_character_modifier {
    id = "limb_dodge_mod",
    description = ccb.content.text("Dodge chance modifier <color_dark_gray>(Balance, Movement, Footing)</color>"),
    operation = "multiply",
    scores = { { id = "balance", weight = 1.5 }, "move_speed", "footing" },
    override_encumbrance = true,
    combine = "multiply",
    min = 0.0,
}
