local ccb = require("ccb")

-- Zombie faction so they don't attack a clear prop
-- ahh! it sees you!
ccb.content.define_monster {
    id = "mon_dragon_dummy",
    name = ccb.content.plural_text("ancient red dragon", "ancient red dragons"),
    description = ccb.content.text("A towering, hulking dragon, with tremendous, curving horns and shining red scales, its glowing maw peeled back in a hateful grimace as its eyes bore into yours."),
    body_type = "dog",
    default_faction = "zombie",
    difficulty_adjustment = 50,
    volume = "875000 ml",
    mass = "4535 g",
    hp = 1,
    materials = { "paper" },
    symbol = "D",
    color = "red",
    luminance = 8,
    aggression = 100,
    morale = 100,
    vision_day = 50,
    vision_night = 50,
    harvest = "exempt",
    flags = { "SEES" },
    death = {
        drops = "mon_dragon_dummy_drops",
        outcome = { message = ccb.content.text("The %s disintegrates!"), corpse = "NO_CORPSE" },
    },
}
