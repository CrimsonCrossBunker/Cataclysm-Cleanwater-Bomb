local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_utilibot_const",
    copy_from = "mon_utilibot",
    name = ccb.content.plural_text("TsKBEM Udarnik", "TsKBEM Udarniks"),
    description = ccb.content.text("A highly customizable light industrial and agricultural robot.  Its original design dates back to the ancient Soviet Union; the aptly named Udarnik \"shock worker\" was the trigger behind the automation revolution, and with subsequent adaptations, became the workhorse of early human space colonization.  Although outdated by modern standards, the Udarnik is still commonly seen in frontier worlds - thanks to its easily obtainable fabrication schematics.\n\nThis particular version is equipped with a mix of construction and heavy cargo-handling tools and was likely involved in the construction of colony buildings."),
    color = "yellow",
    volume = "680388 ml",
    mass = "680388 g",
    luminance = 10,
    melee_skill = 2,
    melee_dice = 4,
    melee_sides = 5,
    melee_armor_penetration = 4,
    speed = 80,
    hp = 400,
    armor = { bash = 12, cut = 20, bullet = 12, acid = 80, heat = 20 },
    melee_damage = { { type = "cut", amount = 1 } },
    starting_ammo = { nail = 1000 },
    attacks = {
        {
            cooldown = 0,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "nailgun",
                skills = { { id = "gun", level = 0 }, { id = "pistol", level = 2 } },
                dexterity = 8,
                ranges = { { minimum = 0, maximum = 3, mode = "BURST" } },
            },
        },
    },
    inheritance = { add = { flags = { "DROPS_AMMO" } } },
}
