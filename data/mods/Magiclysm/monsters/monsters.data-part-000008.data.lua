local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_rust_monster_aggressive",
    name = "rust monster",
    copy_from = "mon_rust_monster",
    aggression = 50,
    aggressive_to_characters = true,
    attacks = {
        {
            kind = "melee",
            id = "rust_monster_kill_iron_golem",
            move_cost = 100,
            accuracy = 6,
            blockable = false,
            cooldown = 4,
            damage = {
                { type = "bash", amount = 9999 },
            },
            avatar_hit = "",
            avatar_miss = "",
            avatar_no_damage = "",
            npc_hit = "%1$s antennae touch <npcname>",
            npc_miss = "%1$s antennae bend toward <npcname>, but they dodge!",
            npc_no_damage = "%1$s antennae touch <npcname>",
            when = "w16b_mon_when_magiclysm_1569edf3b3ec",
        },
        {
            kind = "melee",
            id = "rest_monster_rusting",
            move_cost = 100,
            accuracy = 6,
            blockable = false,
            cooldown = 4,
            damage = {
                { type = "bash", amount = 0 },
            },
            avatar_hit = "%1$s's antennae touch you!",
            avatar_miss = "%1$s antennae bend toward you, but you dodge!",
            avatar_no_damage = "%1$s's antennae touch you!",
            npc_hit = "%1$s antennae touch <npcname>",
            npc_miss = "%1$s antennae bend toward <npcname>, but they dodge!",
            npc_no_damage = "%1$s antennae touch <npcname>",
            on_hit = "w16b_mon_hit_magiclysm_0943fa32b485",
        },
    },
}
