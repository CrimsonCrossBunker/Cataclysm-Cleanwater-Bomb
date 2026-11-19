local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_debug_bullet_sponge",
    copy_from = "pseudo_debug_mon",
    name = ccb.content.text_without_extraction("debug bullet sponge"),
    description = ccb.content.text_without_extraction("This monster exists only for testing purposes"),
    aggression = 0,
    morale = 0,
    regenerates = 5000,
}

-- NO_I18N
-- NO_I18N
-- Basic zombie strength
ccb.content.define_monster {
    id = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("weak debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a basic zombie."),
    looks_like = "mon_thing",
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "300000 g",
    hp = 1,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_skill = 100,
    grab_strength = 20,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 50,
    attacks = { { id = "grab", cooldown = 0, move_cost = 0 } },
    harvest = "exempt",
    regeneration_modifiers = { onfire = -5, corroding = 5 },
    flags = { "IMMOBILE", "SEES", "NOT_HALLUCINATION" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_mid",
    copy_from = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("middle-strength debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a Tier 2 grabbing zombie."),
    grab_strength = 50,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_debug_grabber_strong",
    copy_from = "mon_debug_grabber",
    name = ccb.content.text_without_extraction("strong debug grabber"),
    description = ccb.content.text_without_extraction("This monster exists only for grab testing purposes.  Same grab strength as a Tier 3 grabbing zombie."),
    grab_strength = 100,
}
