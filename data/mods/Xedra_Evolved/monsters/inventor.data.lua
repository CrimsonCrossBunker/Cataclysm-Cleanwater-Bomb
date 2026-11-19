local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_shotgunbot_science",
    copy_from = "mon_shotgunbot",
    default_faction = "science",
    revert_item = "bot_shotgunbot",
    broken_item = "broken_shotgunbot",
    death = { outcome = { corpse = "BROKEN" } },
}

ccb.content.define_monster {
    id = "mon_meleebot",
    name = ccb.content.plural_text("cutthroater", "cutthroaters"),
    description = ccb.content.text("A tiny arachnid-like bot with three manipulators with telescopic razor-sharp blades."),
    default_faction = "player",
    species = { "ROBOT" },
    categories = { "XE_CLASSIC" },
    volume = "30 L",
    mass = "40750 g",
    hp = 90,
    speed = 160,
    materials = { "steel" },
    symbol = "a",
    color = "light_blue",
    aggression = 100,
    morale = 100,
    melee_skill = 8,
    melee_dice = 3,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 22 } },
    dodge = 6,
    armor = { bash = 14, cut = 14, bullet = 11, electric = 5 },
    vision_day = 50,
    revert_item = "bot_meleebot",
    pathing = { max_distance = 9, avoid_dangerous_fields = true, avoid_traps = true },
    flags = {
        "SEES", "HEARS", "GOODHEARING", "ELECTRONIC", "COLDPROOF", "NO_BREATHE", "PATH_AVOID_DANGER",
        "STUN_IMMUNE",
    },
    death = { outcome = { corpse = "BROKEN" } },
}

ccb.content.define_monster {
    id = "mon_meleebot_science",
    copy_from = "mon_meleebot",
    default_faction = "science",
    revert_item = "bot_meleebot",
    broken_item = "broken_meleebot",
    death = { outcome = { corpse = "BROKEN" } },
}

-- A bear trap attached to something that writhes and pulls.  Should be hard to get the bot to stop grabbing without something breaking or tearing.  It does little damage with the rest of its body.
-- Freeing yourself from an animated bear trap by pulling should be damaging, but that's not there yet.  Lower the grab strength when it's applied to this bot.
ccb.content.define_monster {
    id = "mon_bitebot",
    name = ccb.content.plural_text("bitebot", "bitebots"),
    description = ccb.content.text("A small doglike bot with bot with a primed bear trap for a head.  It's like a regular dog but made of metal and with a stronger bite."),
    copy_from = "mon_meleebot",
    default_faction = "player",
    species = { "ROBOT" },
    materials = { "steel" },
    symbol = "d",
    melee_skill = 8,
    melee_dice = 2,
    melee_sides = 2,
    grab_strength = 250,
    revert_item = "bot_bitebot",
    attacks = {
        {
            id = "bite_grab",
            cooldown = 5,
            accuracy = 5,
            damage = {
                { type = "cut", amount = 18, armor_multiplier = 0.5 },
                { type = "bash", amount = 12, armor_multiplier = 0.5 },
            },
        },
        { id = "drag_followup", cooldown = 1 },
    },
    inheritance = { add = { flags = { "GRABS", "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_bitebot_science",
    copy_from = "mon_bitebot",
    default_faction = "science",
    revert_item = "bot_bitebot",
    broken_item = "broken_bitebot",
    death = { outcome = { corpse = "BROKEN" } },
}
