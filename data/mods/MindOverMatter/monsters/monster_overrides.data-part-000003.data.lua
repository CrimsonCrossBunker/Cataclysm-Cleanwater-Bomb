local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_hound_tindalos",
    copy_from = "mon_hound_tindalos",
    attack_effects = {
        {
            id = "effect_teleporting_lock",
            chance = 50,
            duration = { 5, 60 },
        },
    },
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEPORT_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            attacks = {
                {
                    kind = "melee",
                    id = "hound_tindalos_maintain_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_22fe335795fb",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
                {
                    kind = "melee",
                    id = "hound_tindalos_lose_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_f95e310c1a27",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
            },
            armor = { psi_telekinetic_damage = 50 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_hound_tindalos_afterimage",
    copy_from = "mon_hound_tindalos_afterimage",
    attack_effects = {
        {
            id = "effect_teleporting_lock",
            chance = 50,
            duration = { 5, 60 },
        },
    },
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEPORT_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            attacks = {
                {
                    kind = "melee",
                    id = "hound_tindalos_maintain_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_22fe335795fb",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
                {
                    kind = "melee",
                    id = "hound_tindalos_lose_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_f95e310c1a27",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
            },
            armor = { psi_telekinetic_damage = 50 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_tindalos",
    copy_from = "mon_tindalos",
    attack_effects = {
        {
            id = "effect_teleporting_lock",
            chance = 50,
            duration = { 5, 60 },
        },
    },
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEPORT_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            attacks = {
                {
                    kind = "melee",
                    id = "hound_tindalos_maintain_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_22fe335795fb",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
                {
                    kind = "melee",
                    id = "hound_tindalos_lose_speed",
                    move_cost = 1,
                    range = 60,
                    dodgeable = false,
                    blockable = false,
                    cooldown = 1,
                    damage = {
                        { type = "biological", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_mindovermatter_f95e310c1a27",
                    on_hit = "w16b_mon_hit_mindovermatter_118c53782a77",
                },
            },
            armor = { psi_telekinetic_damage = 50 },
        },
    },
}
