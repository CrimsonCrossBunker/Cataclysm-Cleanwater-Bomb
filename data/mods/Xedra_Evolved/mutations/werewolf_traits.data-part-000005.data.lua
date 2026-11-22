local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_CURE_OUTSIDE_EFFECTS",
    name = "Strike the Inner Outsider",
    points = 4,
    description = ccb.content.text("The People is meant to fight the things from Outside, but sometimes they must fight what is inside their own bodies.  You can focus your mana to try and cure most ailments caused by beings from the Nether, from Under the Hill and from wherever vampires come from.  The amount of mana this requires increases with the amount and severity of your afflictions, and will fail if your mana is insufficient."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    on_activate = "werewolf_cure_outside_effects",
}

-- Tier 4 traits begin here
ccb.content.define_mutation {
    id = "WEREWOLF_SUPER_FAST_REGENERATION",
    name = ccb.content.text("Gift of Lunar Renewal"),
    points = 8,
    description = ccb.content.text("The moon cycles from new to full and back to new, and it always returns no matter how many cycles pass.  You can draw on that eternal renewal and enhance your natural regeneration to a truly monstrous level, healing grievous wounds in seconds and regrowing lost limbs in less than a minute."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 7,
    cooldown = 1,
    activation_message = ccb.content.text("Your natural regeneration kicks into overdrive."),
    on_process = "werewolf_super_fast_regeneration",
}
