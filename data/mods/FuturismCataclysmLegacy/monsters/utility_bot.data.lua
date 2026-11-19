local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_utilibot_hostile",
    copy_from = "mon_utilibot_const",
    name = ccb.content.plural_text("rampant Udarnik", "rampant Udarniks"),
    description = ccb.content.text("An erratic and dangerous Udarnik that mistakenly attempts to hammer everything in its sights.  Although this corrupted robot is not built for combat, its sheer size and hydraulic strength make it extremely dangerous up close."),
    default_faction = "berserk_bot",
    color = "yellow",
    melee_skill = 4,
    morale = 20,
    aggression = 50,
    melee_dice = 4,
    melee_sides = 5,
    melee_armor_penetration = 4,
    attacks = { { id = "smash", throw_strength = 96 } },
    inheritance = { add = { flags = { "BASHES", "DESTROYS", "ATTACKMON" } } },
    death = { outcome = { corpse = "BROKEN" } },
}
