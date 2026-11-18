local content = require("ccb").content
local text = content.text

-- Marks a character as Earthside so the expedition can advance warp sickness.
content.add(content.Mutation {
    id = "awayfromhome",
    name = text("Earthside"),
    description = text("You are away from your sanctuary island.  Over time, you will begin to succumb to the intangible miasma of the world below, and your stats will suffer.  You have several hours after warp before this becomes a problem, after which it will rapidly get worse until you warp home or die."),
    points = 0,
    valid = false,
    purifiable = false,
})

content.add(content.Mutation {
    id = "mut_skyisland_sunblock",
    name = text("Personal Sunblock"),
    description = text("As long as you are on the island, the sun cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("enchantment", "INLINE_ENCH_mut_skyisland_sunblock_0"))

content.add(content.Mutation {
    id = "mut_skyisland_sunblock_real",
    name = text("Personal Sunblock"),
    description = text("As long as you are on the island, the sun cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("integrated_armor", "sky_island_sunblock"))

content.add(content.Mutation {
    id = "mut_skyisland_windblock",
    name = text("Personal Windblock"),
    description = text("As long as you are on the island, the winds cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("enchantment", "INLINE_ENCH_mut_skyisland_windblock_0"))

content.add(content.Mutation {
    id = "mut_skyisland_windblock_real",
    name = text("Personal Windblock Real"),
    description = text("As long as you are on the island, the winds cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("integrated_armor", "sky_island_windblock"))

content.add(content.Mutation {
    id = "mut_skyisland_personal_temperature_adaptation",
    name = text("Personal Temperature Adaptation"),
    description = text("As long as you are on the island, temperature cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("enchantment", "INLINE_ENCH_mut_skyisland_personal_temperature_adaptation_0"))

content.add(content.Mutation {
    id = "mut_skyisland_radblock",
    name = text("Personal Radiation Shield"),
    description = text("As long as you are on the island, radiation cannot affect you."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("enchantment", "INLINE_ENCH_mut_skyisland_radblock_0"))

content.add(content.Mutation {
    id = "mut_skyisland_island_steady",
    name = text("Island-Side Resilience"),
    description = text("As long as you are on the island, your speed cannot be lower than its default."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
}
    :relationship("enchantment", "INLINE_ENCH_mut_skyisland_island_steady_0"))

content.add(content.Mutation {
    id = "CHALLENGE_MODE_HORDES",
    name = text("Inverted Warp"),
    description = text("Instead of protecting you when you ended up here, the warpstream inverted itself and is now summoning zombies to your location."),
    points = 0,
    valid = false,
    purifiable = false,
})

content.add(content.Mutation {
    id = "SI_TRIFFID_DECOR_MUTATION",
    name = text("Triffid"),
    description = text("You are a triffid."),
    points = 0,
    valid = false,
    purifiable = false,
    override_look_id = "mon_triffid",
    override_look_category = "monster",
})

content.add(content.Mutation {
    id = "mut_secure_container_1",
    name = text("Security Alpha"),
    description = text("You have come into possession of a tiny, ethereal storage container that cannot be removed or destroyed.  It can hold 500 mL and will bring items back to the island with you, even when you die."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
}
    :relationship("integrated_armor", "secure_container_1"))

content.add(content.Mutation {
    id = "mut_secure_container_2",
    name = text("Security Beta"),
    description = text("You have come into possession of a small, ethereal storage container that cannot be removed or destroyed.  It can hold 750 mL and will bring items back to the island with you, even when you die."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
}
    :relationship("integrated_armor", "secure_container_2"))

content.add(content.Mutation {
    id = "mut_secure_container_3",
    name = text("Security Gamma"),
    description = text("You have come into possession of a medium-sized, ethereal storage container that cannot be removed or destroyed.  It can hold 1 liter and will bring items back to the island with you, even when you die."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
}
    :relationship("integrated_armor", "secure_container_3"))

content.add(content.Mutation {
    id = "mut_secure_container_4",
    name = text("Security Epsilon"),
    description = text("You have come into possession of a large, ethereal storage container that cannot be removed or destroyed.  It can hold 1500 mL and will bring items back to the island with you, even when you die."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
}
    :relationship("integrated_armor", "secure_container_4"))

content.add(content.Mutation {
    id = "mut_secure_container_5",
    name = text("Security Kappa"),
    description = text("You have come into possession of a very large, ethereal storage container that cannot be removed or destroyed.  It can hold 2 liters and will bring items back to the island with you, even when you die."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = true,
}
    :relationship("integrated_armor", "secure_container_5"))
