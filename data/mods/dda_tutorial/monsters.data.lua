local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_dummy_tutorial",
    name = ccb.content.plural_text("dummy", "dummies"),
    description = ccb.content.text("This dummy serves for only one purpose - to teach players how to hit monsters."),
    looks_like = "f_mannequin",
    default_faction = "",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 50,
    speed = 100,
    materials = { "wood" },
    symbol = "X",
    color = "white",
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 1,
    harvest = "exempt",
    flags = { "IMMOBILE", "NOT_HALLUCINATION" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s is destroyed!") } },
}
