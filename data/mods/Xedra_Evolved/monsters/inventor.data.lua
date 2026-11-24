local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_sniperbot",
    name = ccb.content.plural_text("sniper bot", "sniper bots"),
    description = ccb.content.text("A doglike robot with a rifle barrel mounted on its back.  The quadrupedal platform appears to grant a high level of stability in order to strike targets at long range."),
    default_faction = "player",
    species = { "ROBOT" },
    categories = { "XE_CLASSIC" },
    difficulty_adjustment = 0,
    volume = "150 L",
    mass = "40750 g",
    hp = 80,
    speed = 100,
    materials = { "aluminum" },
    symbol = "R",
    color = "dark_gray",
    aggression = 100,
    morale = 100,
    armor = { bash = 14, cut = 14, bullet = 11 },
    vision_day = 50,
    tracking_distance = 16,
    revert_item = "bot_sniperbot",
    starting_ammo = { ["308"] = 150 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 450,
            kind = "gun",
            gun = {
                weapon = "inventor_sniper",
                ammo = "308",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 60, mode = "DEFAULT" } },
                lock_npc = true,
                lock_monster = true,
                laser_lock = false,
                targeting_cost = 300,
                targeting_extension = -10,
                targeting_sound = ccb.content.text("\"Steady, steady.\""),
                targeting_volume = 4,
                empty_sound = ccb.content.text("chk-chk pop!"),
            },
        },
    },
    flags = {
        "SEES", "HEARS", "ELECTRONIC", "COLDPROOF", "NO_BREATHE", "PATH_AVOID_DANGER",
        "PRIORITIZE_TARGETS", "LOUDMOVES", "DROPS_AMMO", "STUN_IMMUNE",
    },
    pathing = { avoid_traps = true, avoid_dangerous_fields = true },
    death = { drops = {}, outcome = { corpse = "BROKEN" } },
}

ccb.content.define_monster {
    id = "mon_sniperbot_science",
    copy_from = "mon_sniperbot",
    default_faction = "science",
    revert_item = "bot_sniperbot",
    broken_item = "broken_sniperbot",
    death = { outcome = { corpse = "BROKEN" } },
}

ccb.content.define_monster {
    id = "mon_shotgunbot",
    name = ccb.content.plural_text("shotgun bot", "shotgun bots"),
    description = ccb.content.text("A heavy, but quick two-legged drone that holds a massive shotgun system above himself.  Effectively a machinegun with legs."),
    copy_from = "mon_sniperbot",
    species = { "ROBOT" },
    categories = { "XE_CLASSIC" },
    tracking_distance = 4,
    revert_item = "bot_shotgunbot",
    starting_ammo = { shot_00 = 240 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 50,
            kind = "gun",
            gun = {
                weapon = "inventor_shotgun",
                ammo = "shot_00",
                skills = { { id = "gun", level = 8 }, { id = "shotgun", level = 8 } },
                lock_npc = false,
                lock_monster = false,
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 10, mode = "DEFAULT" } },
                empty_sound = ccb.content.text("chk-chk!"),
            },
        },
    },
}

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
