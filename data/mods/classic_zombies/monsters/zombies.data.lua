local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_cunning",
    copy_from = "mon_zombie",
    name = ccb.content.plural_text("zombie", "zombies"),
    looks_like = "mon_zombie",
    description = ccb.content.text("A human body, skin a sickly grayish color, moving with a slow shuffling motion.  It occasionally looks at its surroundings with more focus than its peers; could it be remembering something?"),
    upgrade = false,
    categories = { "CLASSIC" },
    pathing = { max_distance = 30, avoid_traps = true, avoid_sharp = true },
    inheritance = {
        add = { flags = { "CAN_OPEN_DOORS", "PATH_AVOID_DANGER", "PATH_AVOID_FALL" } },
        remove = { flags = { "CLUMSY_ATTACKS" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fat",
    copy_from = "mon_zombie_fat",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier",
    copy_from = "mon_zombie_soldier",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_cop",
    copy_from = "mon_zombie_cop",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler",
    copy_from = "mon_zombie_crawler",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child",
    copy_from = "mon_zombie_child",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie",
    description = "A human body, skin a sickly grayish color, moving with a slow shuffling motion.",
    copy_from = "mon_zombie",
    inheritance = {
        add = {
            flags = { "CLUMSY_ATTACKS" },
            attacks = {
                {
                    kind = "melee",
                    id = "zombie_drag_down",
                    move_cost = 100,
                    accuracy = 5,
                    dodgeable = true,
                    blockable = false,
                    effects_require_damage = false,
                    cooldown = 15,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s drags you down to the ground!",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s drags you down to the ground!",
                    npc_hit = "%1$s drags <npcname> down to the ground!",
                    npc_miss = "",
                    npc_no_damage = "%1$s drags <npcname> down to the ground!",
                    effects = {
                        { id = "downed", duration = 3 },
                    },
                    when = "w16b_mon_when_classic_zombies_1a6cf59beca8",
                },
                {
                    kind = "melee",
                    id = "zombie_pile_on",
                    move_cost = 100,
                    accuracy = 5,
                    dodgeable = true,
                    blockable = false,
                    effects_require_damage = false,
                    cooldown = 15,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s piles on while you're down!",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s piles on while you're down!",
                    npc_hit = "%1$s piles on <npcname> while they're down!",
                    npc_miss = "",
                    npc_no_damage = "%1$s piles on <npcname> while they're down!",
                    effects = {
                        { id = "downed", duration = 3 },
                        { id = "effect_zombie_pile_on", duration = 10 },
                    },
                    self_effects_always = {
                        { id = "downed", duration = 3 },
                    },
                    when = "w16b_mon_when_classic_zombies_b6428e37817e",
                },
            },
        },
        remove = {
            flags = { "UNBREAKABLE_MORALE", "WARM" },
        },
    },
}
