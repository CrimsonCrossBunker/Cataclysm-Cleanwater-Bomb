local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_vita2",
    copy_from = "mon_feral_human_vita2",
    inheritance = {
        add = {
            attacks = {
                {
                    kind = "melee",
                    id = "mon_vitakinetic_ligma_infection",
                    move_cost = 60,
                    accuracy = 6,
                    dodgeable = true,
                    blockable = true,
                    cooldown = { 18, 54 },
                    damage = {
                        { type = "biological", amount = 5 },
                    },
                    avatar_hit = "%1$s touches you and you feel a moment of acute terror!",
                    avatar_miss = "%1$s tries to touch you, but you dodge!",
                    avatar_no_damage = "%1$s touches you but only hits your armor.",
                    npc_hit = "%1$s touches <npcname> and an expression of horror passes across their face!",
                    npc_miss = "%1$s tries to touch <npcname>, but they dodge!",
                    npc_no_damage = "%1$s touches <npcname> but only hits their armor.",
                    effects = {
                        { id = "effect_mom_crazy_feral_ligma", chance = 100, duration = 3600 },
                    },
                    when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
                    on_hit = "w16b_mon_hit_mindovermatter_da185f3b02a1",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_human_vita3",
    copy_from = "mon_feral_human_vita3",
    inheritance = {
        add = {
            attacks = {
                {
                    kind = "melee",
                    id = "mon_vitakinetic_ligma_infection",
                    move_cost = 60,
                    accuracy = 6,
                    dodgeable = true,
                    blockable = true,
                    cooldown = { 18, 54 },
                    damage = {
                        { type = "biological", amount = 5 },
                    },
                    avatar_hit = "%1$s touches you and you feel a moment of acute terror!",
                    avatar_miss = "%1$s tries to touch you, but you dodge!",
                    avatar_no_damage = "%1$s touches you but only hits your armor.",
                    npc_hit = "%1$s touches <npcname> and an expression of horror passes across their face!",
                    npc_miss = "%1$s tries to touch <npcname>, but they dodge!",
                    npc_no_damage = "%1$s touches <npcname> but only hits their armor.",
                    effects = {
                        { id = "effect_mom_crazy_feral_ligma", chance = 100, duration = 10800 },
                    },
                    when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
                    on_hit = "w16b_mon_hit_mindovermatter_c4cce8a29bc8",
                },
            },
        },
    },
}
