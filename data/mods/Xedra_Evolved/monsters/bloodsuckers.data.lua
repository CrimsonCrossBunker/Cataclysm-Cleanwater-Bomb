local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_vampire_feral",
    name = ccb.content.plural_text("wight", "wight"),
    description = "This creature scarcely looks like the human you know they must once have been.  Red eyes lit by a faint inner glow, a pair of protruding fangs, fingers twisted into claws, clothes in tatters, and skin so covered in dirt and blood you have no idea what color it originally was.  They move like a wild animal, occasionally dropping on all fours and raising their head to sniff the air.",
    copy_from = "mon_vampire_generic",
    grab_strength = 30,
    vision_day = 25,
    vision_night = 25,
    death = { drops = "revenant_death_drops" },
    inheritance = {
        add = {
            flags = { "FILTHY", "KEENNOSE" },
            attacks = {
                {
                    id = "bite_humanoid",
                    cooldown = 3,
                    damage = {
                        { type = "stab", amount = 10, armor_multiplier = 0.2 },
                    },
                    on_hit = "w16b_mon_hit_xedra_evolved_fa5cd452db4e",
                },
                {
                    kind = "melee",
                    id = "feral_vampire_claw_no_strength_buff",
                    move_cost = 110,
                    dodgeable = true,
                    blockable = true,
                    cooldown = 3,
                    damage = {
                        { type = "cut", amount = 10 },
                    },
                    avatar_hit = "%1$s claws at your %2$s!",
                    avatar_miss = "%1$s claws at you, but you dodge!",
                    avatar_no_damage = "%1$s claws at your %2$s, but fails to penetrate armor.",
                    npc_hit = "%1$s claws at <npcname>!",
                    npc_miss = "%1$s tries to claw at <npcname>, but they dodge!",
                    npc_no_damage = "%1$s tries to claw at <npcname>, but fails to penetrate armor.",
                    when = "w16b_mon_when_xedra_evolved_45e65cdb86ff",
                },
                {
                    kind = "melee",
                    id = "feral_vampire_claw_with_strength_buff",
                    move_cost = 110,
                    dodgeable = true,
                    blockable = false,
                    cooldown = 3,
                    damage = {
                        { type = "cut", amount = 18, armor_multiplier = 0.75 },
                    },
                    avatar_hit = "%1$s claws at your %2$s!",
                    avatar_miss = "%1$s claws at you, but you dodge!",
                    avatar_no_damage = "%1$s claws at your %2$s, but fails to penetrate armor.",
                    npc_hit = "%1$s claws at <npcname>!",
                    npc_miss = "%1$s tries to claw at <npcname>, but they dodge!",
                    npc_no_damage = "%1$s tries to claw at <npcname>, but fails to penetrate armor.",
                    when = "w16b_mon_when_xedra_evolved_45e65cdb86ff",
                },
                {
                    kind = "melee",
                    id = "feral_vampire_use_random_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 60,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "",
                    when = "w16b_mon_when_xedra_evolved_61dac5e052b4",
                    on_hit = "w16b_mon_hit_xedra_evolved_31121f454ad0",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_vampire_moroi_fast",
    name = ccb.content.plural_text("moroi", "moroi"),
    description = "This creature looks more aware than most of the ferals you have seen and in fact you might even suspect them of being normal if it weren't for the dried blood caked around their mouth and down the front of their clothes.  The light glints against what look to be sharp fangs in their mouth.  They move with inhuman speed and fluidity.",
    copy_from = "mon_vampire_generic",
    looks_like = "mon_vampire_moroi",
    speed = 95,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = {
        { type = "cut", amount = 5 },
    },
    death = { drops = "default_moroi_death_drops" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "bite_humanoid",
                    cooldown = 10,
                    damage = {
                        { type = "stab", amount = 10, armor_multiplier = 0.2 },
                    },
                    on_hit = "w16b_mon_hit_xedra_evolved_64f2f1ddd8da",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_blood_driven_speed_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 60,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s moves with inhuman speed.",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s moves with inhuman speed.",
                    npc_hit = "%1$s moves with inhuman speed.",
                    npc_miss = "",
                    npc_no_damage = "%1$s moves with inhuman speed.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_speed",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_47df1c956c58",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_sanguine_agility_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 45,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s begins moving with inhuman agility.",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s begins moving with inhuman agility.",
                    npc_hit = "%1$s begins moving with inhuman agility.",
                    npc_miss = "",
                    npc_no_damage = "%1$s begins moving with inhuman agility.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_agility",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_c834f7f30ed5",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_vampire_moroi_tough",
    name = ccb.content.plural_text("moroi", "moroi"),
    description = "This creature looks more aware than most of the ferals you have seen and in fact you might even suspect them of being normal if it weren't for the dried blood caked around their mouth and down the front of their clothes.  The light glints against what look to be sharp fangs in their mouth.  Their skin has a waxen appearance and their muscles bulge oddly.",
    copy_from = "mon_vampire_generic",
    looks_like = "mon_vampire_moroi",
    hp = 145,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = {
        { type = "cut", amount = 5 },
    },
    death = { drops = "default_moroi_death_drops" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "bite_humanoid",
                    cooldown = 10,
                    damage = {
                        { type = "stab", amount = 10, armor_multiplier = 0.2 },
                    },
                    on_hit = "w16b_mon_hit_xedra_evolved_64f2f1ddd8da",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_vigor_mortis_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 30,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s flexes their fingers with an audible crack.",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s flexes their fingers with an audible crack.",
                    npc_hit = "%1$s flexes their fingers with an audible crack.",
                    npc_miss = "",
                    npc_no_damage = "%1$s flexes their fingers with an audible crack.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_strength",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_cdb593e3486c",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_sanguine_resilience_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 35,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s' s skin takes on a waxen sheen.",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s's skin takes on a waxen sheen.",
                    npc_hit = "%1$s' s skin takes on a waxen sheen.",
                    npc_miss = "",
                    npc_no_damage = "%1$s' s skin takes on a waxen sheen.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_resilience",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_afced22116e5",
                },
                {
                    id = "smash",
                    move_cost = 130,
                    throw_strength = 40,
                    minimum_damage_multiplier = 0.8,
                    cooldown = 8,
                    when = "w16b_mon_when_xedra_evolved_a91bd9385f75",
                },
                { id = "bio_op_takedown", cooldown = 10, when = "w16b_mon_when_xedra_evolved_a91bd9385f75" },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_vampire_moroi_animalistic",
    name = ccb.content.plural_text("moroi", "moroi"),
    description = "This creature looks more aware than most of the ferals you have seen and in fact you might even suspect them of being normal if it weren't for the dried blood caked around their mouth and down the front of their clothes.  There is a red light in their eyes, and they hunch over almost as though they want to drop to all fours.  When they do open their mouth, every single one of their teeth is a jagged fang.",
    copy_from = "mon_vampire_generic",
    looks_like = "mon_vampire_moroi",
    speed = 80,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    vision_night = 25,
    melee_damage = {
        { type = "cut", amount = 5 },
    },
    death = { drops = "default_moroi_death_drops" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "bite_humanoid",
                    cooldown = 10,
                    damage = {
                        { type = "stab", amount = 10, armor_multiplier = 0.2 },
                    },
                    on_hit = "w16b_mon_hit_xedra_evolved_64f2f1ddd8da",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_sanguine_resilience_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 35,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s' s skin takes on a waxen sheen.",
                    npc_hit = "",
                    npc_miss = "",
                    npc_no_damage = "%1$s' s skin takes on a waxen sheen.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_resilience",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_afced22116e5",
                },
                {
                    id = "scratch",
                    move_cost = 90,
                    minimum_damage_multiplier = 1,
                    maximum_damage_multiplier = 2,
                    cooldown = 3,
                    damage = {
                        { type = "cut", amount = 11 },
                    },
                },
                {
                    kind = "spell",
                    cooldown = 20,
                    spell = { id = "mon_vampire_fear_gaze", min_level = 1 },
                    casting_message = "%1$s bares their fangs and hisses at %3$s!",
                    when = "w16b_mon_when_xedra_evolved_8ea0389db125",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_vampire_moroi_stealthy",
    name = ccb.content.plural_text("moroi", "moroi"),
    description = "This creature looks more aware than most of the ferals you have seen and in fact you might even suspect them of being normal if it weren't for the dried blood caked around their mouth and down the front of their clothes.  You have to stare straight at them for your eyes to register that they're there.",
    copy_from = "mon_vampire_generic",
    looks_like = "mon_vampire_moroi",
    speed = 80,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    vision_night = 25,
    melee_damage = {
        { type = "cut", amount = 5 },
    },
    death = { drops = "default_moroi_death_drops" },
    inheritance = {
        add = {
            flags = { "NIGHT_INVISIBILITY", "SILENTMOVES" },
            attacks = {
                {
                    id = "bite_humanoid",
                    cooldown = 10,
                    damage = {
                        { type = "stab", amount = 10, armor_multiplier = 0.2 },
                    },
                    on_hit = "w16b_mon_hit_xedra_evolved_64f2f1ddd8da",
                },
                {
                    kind = "melee",
                    id = "moroi_vampire_sanguine_agility_buff",
                    move_cost = 10,
                    range = 10,
                    dodgeable = false,
                    uncanny_dodgeable = false,
                    blockable = false,
                    cooldown = 45,
                    damage = {
                        { type = "bash", amount = 0 },
                    },
                    avatar_hit = "%1$s begins moving with inhuman agility.",
                    avatar_miss = "",
                    avatar_no_damage = "%1$s begins moving with inhuman agility.",
                    npc_hit = "%1$s begins moving with inhuman agility.",
                    npc_miss = "",
                    npc_no_damage = "%1$s begins moving with inhuman agility.",
                    self_effects_always = {
                        {
                            id = "effect_vampire_monster_agility",
                            duration = { 25, 45 },
                        },
                    },
                    when = "w16b_mon_when_xedra_evolved_c834f7f30ed5",
                },
            },
        },
    },
}
