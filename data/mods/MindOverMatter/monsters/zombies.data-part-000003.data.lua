local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spawn_raptor_teke_push",
    copy_from = "mon_spawn_raptor",
    looks_like = "mon_spawn_raptor",
    name = ccb.content.plural_text("forcewave flesh-raptor", "forcewave flesh-raptors"),
    description = ccb.content.text("This small, winged predator darts through the air on three thinly-haired wings that look like stretched human hands.  A sheer, jagged spike juts out from the point where the wings meet.  It looks like nothing you've seen on Earth, and yet strangely like it is made of human parts.  As it darts through the air, nearby obstacles sometimes bend slightly away from it."),
    upgrade = {},
    inheritance = {
        add = {
            attacks = {
                {
                    id = "scratch",
                    damage = { { type = "psi_telekinetic_damage", amount = 3 } },
                    effects = { { id = "downed", duration = 2, chance = 5 } },
                    effects_require_damage = false,
                    avatar_hit = ccb.content.text_without_extraction("%1$s hits your %2$s with a burst of telekinetic force!"),
                    npc_hit = ccb.content.text_without_extraction("%1$s hits <npcname> with a burst of telekinetic force!"),
                    avatar_miss = ccb.content.text_without_extraction("%1$s flaps its wings and a burst of wind whistles around you!"),
                    npc_miss = ccb.content.text_without_extraction("%1$s flaps its wings at <npcname>!"),
                    avatar_no_damage = ccb.content.text_without_extraction("%1$s hits your %2$s with a burst of telekinetic force, but fails to penetrate armor."),
                    npc_no_damage = ccb.content.text_without_extraction("%1$s hits <npcname> with a burst of telekinetic force, but fails to penetrate armor."),
                    cooldown = { 10, 30 },
                    when = "monster_attack_psionics_available",
                },
            },
        },
    },
}
