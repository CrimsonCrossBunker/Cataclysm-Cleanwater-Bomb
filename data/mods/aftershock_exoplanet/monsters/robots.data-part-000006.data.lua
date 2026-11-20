local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_utilibot_fire",
    copy_from = "mon_utilibot_const",
    name = ccb.content.plural_text("TsKBEM Brandspojt", "TsKBEM Brandspojts"),
    description = ccb.content.text("An old and decidedly uncommon firefighter robot of Soviet design.  Crab-like in form, its back mounts a squat water tank beneath a turreted water cannon.  While effective for its original function, the design lacks the flexibility of others from the TsKBEM, and most Brandspojt units still in existence are museum pieces."),
    color = "yellow",
    luminance = 100,
    melee_skill = 3,
    melee_dice = 4,
    melee_sides = 5,
    melee_armor_penetration = 4,
    melee_damage = { { type = "cut", amount = 1 } },
    starting_ammo = { water = 1000 },
    attacks = {
        {
            cooldown = 0,
            move_cost = 100,
            kind = "gun",
            gun = {
                weapon = "watercannon",
                skills = { { id = "gun", level = 2 }, { id = "launcher", level = 2 } },
                dexterity = 8,
                ranges = { { minimum = 0, maximum = 5, mode = "BURST" } },
            },
        },
    },
    inheritance = { add = { flags = { "FIREPROOF", "BASHES" } } },
}

ccb.content.define_monster {
    id = "mon_fumigator",
    copy_from = "base_drone",
    name = ccb.content.plural_text("Croplord 2SPL", "Croplords 2SPL"),
    description = ccb.content.text("Twin linked rotors allow this ubiquitous EINAC drone to comfortably hover above fields and deploy pesticides at prodigious rates.  They have no ability to detect humans within their work areas and will readily disperse lethal pesticides near them."),
    default_faction = "rampant_machine",
    symbol = "y",
    difficulty_adjustment = 40,
    speed = 100,
    hp = 120,
    volume = "1750 ml",
    mass = "1 kg",
    color = "green",
    melee_skill = 8,
    melee_dice = 1,
    melee_sides = 8,
    morale = 20,
    starting_ammo = { afs_foamtoxic = 400 },
    attacks = {
        {
            move_cost = 80,
            cooldown = 3,
            kind = "gun",
            gun = {
                weapon = "afs_foamgun",
                ammo = "afs_foamtoxic",
                skills = { { id = "gun", level = 2 }, { id = "launcher", level = 2 } },
                dexterity = 8,
                ranges = { { minimum = 0, maximum = 6, mode = "DEFAULT" } },
            },
        },
    },
    inheritance = { add = { flags = { "DROPS_AMMO" } } },
    death = {
        outcome = { corpse = "BROKEN", message = ccb.content.text("The Croplord crashes into the ground.") },
    },
}
