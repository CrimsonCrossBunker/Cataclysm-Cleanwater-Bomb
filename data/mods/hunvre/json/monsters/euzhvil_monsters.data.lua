local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_euzhvil",
    abstract = true,
    name = ccb.content.plural_text("abstract euzhvil", "abstract euzhvils"),
    description = ccb.content.text("Abstract euzhvil.  If you see this it's a bug."),
    symbol = "E",
    color = "red",
    categories = { "NULL" },
    default_faction = "euzhvil_faction",
    species = { "EUZHVIL" },
    body_type = "human",
    materials = { "flesh" },
    volume = "60 L",
    mass = "80 kg",
    aggression = 100,
    anger_triggers = { "SOUND", "HURT", "HOSTILE_SEEN" },
    vision_day = 10,
    vision_night = 5,
    flags = { "BASHES", "SEES", "HEARS", "SMELLS" },
    hp = 80,
    speed = 100,
    dodge = 2,
    melee_skill = 6,
    melee_dice = 10,
    melee_sides = 2,
    attacks = { { id = "euzhvil_phase", cooldown = 1 } },
}

ccb.content.define_monster {
    id = "mon_euzhvil_chaser",
    copy_from = "mon_euzhvil",
    name = ccb.content.plural_text("euzhvil chaser", "euzhvil chasers"),
    description = ccb.content.text("A quadrupedal euzhvil, its grotesquely oversized maw lined with human teeth.  It scans its surroundings with a feral, animalistic gaze."),
    looks_like = "mon_dog_skeleton",
    body_type = "dog",
    inheritance = {
        add = { attacks = { { reference = "bite_humanoid", cooldown = 1 } } },
        scale = { speed = 1.1 },
    },
}

ccb.content.define_monster {
    id = "mon_euzhvil_bound",
    copy_from = "mon_euzhvil_chaser",
    name = ccb.content.plural_text("bound euzhvil", "bound euzhvils"),
    description = ccb.content.text("You can see limbs pushing and struggling inside of this misshapen euzhvil, it keeps gnashing at the air and thrashing as if it was trying to escape its own skin."),
    looks_like = "mon_zombie",
    inheritance = {
        add = { attacks = { { reference = "euzhvil_slam", cooldown = 1 } } },
        scale = { volume = 1.25, mass = 1.25 },
    },
}

ccb.content.define_monster {
    id = "mon_euzhvil_bully",
    copy_from = "mon_euzhvil_chaser",
    name = ccb.content.plural_text("euzhvil bully", "euzhvil bullies"),
    description = ccb.content.text("A towering euzhvil with a head squeezed between two gigantic arms almost dragging on the floor, its face stuck in an expression of sadistic bliss."),
    looks_like = "mon_zombie",
    inheritance = { scale = { volume = 2, mass = 2, speed = 0.9, melee_dice = 2 }, offset = { melee_skill = 2 } },
}

ccb.content.define_monster {
    id = "mon_euzhvil_suffocating",
    copy_from = "mon_euzhvil_chaser",
    name = ccb.content.plural_text("suffocating euzhvil", "suffocating euzhvils"),
    description = ccb.content.text("This euzhvil is perpetually seized by violent convulsions, fingers raking desperately at its throat and at the skin that seals its mouth, nose, and eyes.  Just looking at it makes your own breathing laborious."),
    looks_like = "mon_zombie",
    inheritance = {
        add = { attacks = { { reference = "euzhvil_suffocate", cooldown = 1 } } },
        scale = { volume = 1.25, mass = 1.25 },
    },
}
