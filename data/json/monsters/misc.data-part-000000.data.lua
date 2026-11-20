local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "pseudo_debug_mon",
    name = ccb.content.text_without_extraction("debug monster"),
    description = ccb.content.text_without_extraction("This monster exists only for testing purposes."),
    default_faction = "",
    species = { "ZOMBIE" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 10000,
    speed = 100,
    materials = { "flesh" },
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 1,
    weakpoints = {
        {
            name = ccb.content.text("the knee"),
            armor_multiplier = { bullet = 0.5 },
            armor_penalty = { bullet = 25 },
            coverage = 25,
            id = "the knee",
        },
        {
            name = ccb.content.text("the bugs"),
            armor_multiplier = { bullet = 0.0 },
            armor_penalty = { bullet = 0 },
            coverage = 25,
            id = "the bugs",
        },
    },
    harvest = "exempt",
    regenerates = 50,
    regeneration_modifiers = { onfire = -5, corroding = 5 },
    flags = { "IMMOBILE", "NOT_HALLUCINATION", "FILTHY" },
    armor = { bullet = 100 },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s melts away.") } },
}
