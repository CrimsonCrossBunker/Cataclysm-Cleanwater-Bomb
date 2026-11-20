local ccb = require("ccb")

-- Vampire faction so they aren't killed by the vampires.  They're food, not foe.
-- Being fed and locked does wonders to keep them alive, so they don't die over time like the other civilians.
-- When possible, apply a permanent dazed effect to them without needing a spell.  This effects allows vampires to drink from them at all times.
ccb.content.define_monster {
    id = "mon_civilian_bloodbag",
    name = ccb.content.plural_text("enthralled victim", "enthralled victims"),
    copy_from = "mon_civilian_stationary",
    description = ccb.content.text("They just stand there, staring into the void, with a vacant expression on their face.  A multitude of small puncture scars can be seen on their neck."),
    default_faction = "vampire",
    upgrade = false,
    categories = { "XE_CLASSIC" },
    attacks = {
        {
            id = "BLOODBAG_DAZE_SELF",
            spell = { id = "BLOODBAG_DAZE_SELF", min_level = 1, hit_self = true },
            cooldown = 1,
            allow_no_target = true,
            kind = "spell",
            when = "allow_civilian_bloodbag_bloodbag_daze_self",
        },
    },
    flags = { "FILTHY", "KEENNOSE" },
    inheritance = { remove = { flags = { "CAN_OPEN_DOORS" } } },
    death = { drops = "revenant_death_drops" },
}
