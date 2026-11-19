local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ghostly_warrior",
    copy_from = "mon_shadow",
    looks_like = "mon_memory",
    name = ccb.content.plural_text("ghostly warrior", "ghostly warriors"),
    description = ccb.content.text("The shade of a long-dead warrior, rent armor and notched weapons indicating a violent death."),
    default_faction = "undead",
    species = { "UNDEAD" },
    hp = 70,
    speed = 80,
    symbol = "G",
    regenerates = 0,
    luminance = 3,
    attacks = {
        {
            id = "shadow_chill_attack",
            damage = { { type = "cold", amount = 2 } },
            effects = { { id = "effect_nether_shadow_unnatural_chill", duration = 900, chance = 100 } },
            blockable = false,
            cooldown = 15,
            move_cost = 100,
            avatar_hit = ccb.content.text("%1$s touches your %2$s with a freezing-cold hand!"),
            npc_hit = ccb.content.text("%1$s touches <npcname>'s %2$s!"),
            avatar_miss = ccb.content.text("%1$s reaches for you, but you dodge!"),
            npc_miss = ccb.content.text("%1$s reaches for <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text("%1$s touches your %2$s, but can't penetrate your armor."),
            npc_no_damage = ccb.content.text("%1$s touches <npcname>'s %2$s, but can't penetrate their armor."),
            kind = "melee",
        },
    },
}
