local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_shifting_mass",
    name = ccb.content.plural_text("shifting mass", "shifting masses"),
    description = ccb.content.text("A small, shifting mass floating in midair.  It is not even real enough to have a stable shape.  You can see through it, not as if it were transparent, but as if it isn't quite fully there."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "1000 ml",
    mass = "0 g",
    hp = 10,
    speed = 110,
    symbol = "Q",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 2,
    attacks = {
        {
            spell = { id = "shifting_mass_attack", min_level = 1 },
            cooldown = 1,
            casting_message = ccb.content.text("For a moment the shifting mass passes into you as if it were an illusion and a slight wave of fatigue washes over you."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_impossible_shape",
    name = ccb.content.plural_text("impossible shape", "impossible shapes"),
    description = ccb.content.text("A twisted shape floating in midair; its angles don't quite seem to add up - it hurts to look at. You can see through it, not as if it were transparent but as if it isn't quite fully there."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 30,
    speed = 90,
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "impossible_shape_attack", min_level = 1 },
            cooldown = 5,
            casting_message = ccb.content.text("You get a very clear view of the impossible shape."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "RANGED_ATTACKER" },
    death = { outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s fades away.") } },
}

ccb.content.define_monster {
    id = "mon_absence",
    name = ccb.content.plural_text("absence", "absences"),
    description = ccb.content.text("Every sense you have claims this space to be empty, but your mind is not fooled.  There is an emptiness here that is far from natural or safe."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 150,
    speed = 40,
    symbol = "O",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            spell = { id = "absence_capture_attack", min_level = 1 },
            cooldown = 10,
            casting_message = ccb.content.text("The absence intensifies."),
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "RANGED_ATTACKER" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s returns to normal levels of empty."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_giant_appendage",
    name = ccb.content.plural_text("giant appendage", "giant appendages"),
    description = ccb.content.text("A gigantic appendage reaching through what looks like a portal, as if this is merely a probing piece of something much larger."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 1000000000,
    speed = 90,
    symbol = "A",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    melee_skill = 6,
    melee_dice = 5,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 14 } },
    flags = { "FLIES", "NO_BREATHE", "SEES", "HEARS" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s is pulled back through the closing portal."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_memory",
    name = ccb.content.plural_text("memory", "memories"),
    description = ccb.content.text("The shade of a human body reaching towards you like it needs help.  Though it has no eyes you feel as though it is staring through you."),
    default_faction = "nether",
    species = { "NETHER" },
    volume = "62500 ml",
    mass = "0 g",
    hp = 25,
    speed = 100,
    symbol = "O",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 1,
    attacks = { { reference = "PARROT", cooldown = 4 } },
    flags = { "SEES", "NO_BREATHE", "PUSH_MON" },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s begins to cry as it disappears."),
        },
    },
}
