local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_thaumic",
    name = "thaumic zombie",
    description = "A human body, swaying as it moves, an unstoppable rage visible in its oily black eyes.  Faint blue lines are visible beneath parts of its exposed skin, letting off an eldritch glow.",
    copy_from = "mon_zombie_base",
    symbol = "Z",
    color = "cyan",
    luminance = 4,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_THAUMIC" },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab", on_hit = "w16b_mon_hit_magiclysm_f48b3c5ac470" },
        { id = "bite_humanoid", cooldown = 5, on_hit = "w16b_mon_hit_magiclysm_4d961aaef11f" },
        {
            kind = "melee",
            id = "thaumic_zombie_drain_hit",
            move_cost = 100,
            dodgeable = true,
            blockable = true,
            cooldown = 0,
            damage = {
                { type = "bash", amount = 6 },
            },
            avatar_hit = "%1$s hits your %2$s!",
            avatar_miss = "%1$s misses you.",
            avatar_no_damage = "%1$s hits your %2$s, but your armor protects you.",
            npc_hit = "%1$s hits <npcname>!",
            npc_miss = "%1$s misses <npcname>.",
            npc_no_damage = "%1$s hits <npcname>, but their armor protects them.",
            when = "w16b_mon_when_magiclysm_90a8f9dfaf08",
            on_hit = "w16b_mon_hit_magiclysm_f48b3c5ac470",
        },
    },
    inheritance = {
        add = {
            armor = { poison = 14, nether = 10, psionic = 14 },
        },
    },
}
