local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_strange_megafrog",
    copy_from = "mon_strange_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_odd_megafrog",
    copy_from = "mon_odd_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_foul_megafrog",
    copy_from = "mon_foul_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster { id = "mon_pigeon", copy_from = "mon_pigeon", inheritance = { add = { flags = { "CANPLAY" } } } }

ccb.content.define_monster {
    id = "mon_zombie_nemesis",
    copy_from = "mon_zombie_nemesis",
    name = ccb.content.plural_text("mindhunter", "mindhunters"),
    description = ccb.content.text("A hulking zombie swollen to the size of six men.  Its inky black eyes are locked on you, gleaming with malign intent.  No matter how far you run, it always seems to find you."),
    regeneration_modifiers = { effect_feral_regeneration = 10 },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "nemesis_hardened_skin",
                    spell = { id = "biokinetic_hardened_skin_monster" },
                    cooldown = 10,
                    casting_message = ccb.content.text("%1$s's skin takes on a slightly waxen appearance."),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_hardened_skin",
                },
                {
                    id = "nemesis_shock_touch",
                    spell = { id = "electrokinetic_shock_touch_monster", min_level = 3 },
                    cooldown = 10,
                    casting_message = ccb.content.text("%1$s's touches %3$s with a jolt!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_shock_touch",
                },
                {
                    id = "nemesis_telegrab",
                    spell = { id = "telekinetic_pull_monster", min_level = 6 },
                    cooldown = 20,
                    casting_message = ccb.content.text("%1$s stares at %3$s and %3$s is lifted up and pulled towards them!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_telegrab",
                },
                {
                    id = "nemesis_telepathic_confusion",
                    spell = { id = "telepathic_confusion_monster", min_level = 5 },
                    cooldown = 25,
                    casting_message = ccb.content.text("A roar fills %3$s's mind and the world is blotted out!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_telepathic_confusion",
                },
                {
                    id = "nemesis_momentum_alteration",
                    spell = { id = "telekinetic_momentum_monster" },
                    cooldown = 10,
                    casting_message = ccb.content.text("The air around %1$s wavers."),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_momentum_alteration",
                },
                {
                    id = "nemesis_regeneration",
                    spell = { id = "vitakinetic_regeneration_monster" },
                    cooldown = 80,
                    allow_no_target = true,
                    casting_message = ccb.content.text("%1$s's wounds begin healing at a rapid pace!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_regeneration",
                },
                {
                    cooldown = 15,
                    move_cost = 50,
                    allow_no_target = true,
                    maximum_range = 8,
                    message = ccb.content.text_without_extraction("%1$s moves so quickly your eyes can barely follow it!"),
                    kind = "leap",
                    when = "allow_zombie_nemesis_leap",
                },
                {
                    id = "nemesis_break_concentration",
                    spell = { id = "null_break_concentration_spell" },
                    cooldown = 30,
                    casting_message = ccb.content.text("%1$s looks at %3$s and the static on the edge of your vision flickers."),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_break_concentration",
                },
                {
                    id = "nemesis_slow_teleport",
                    spell = { id = "teleport_slow_monster", min_level = 6 },
                    cooldown = 40,
                    casting_message = ccb.content.text("%1$s glances at %3$s and the world lurches."),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_slow_teleport",
                },
                {
                    id = "nemesis_telepathic_blast",
                    spell = { id = "telepathic_blast_monster", min_level = 2 },
                    cooldown = 25,
                    casting_message = ccb.content.text("%1$s stares at %3$s!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_telepathic_blast",
                },
                {
                    id = "nemesis_inertial_barrier",
                    spell = { id = "telekinetic_barrier_monster" },
                    cooldown = 50,
                    casting_message = ccb.content.text("The air around %1$s distorts."),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_inertial_barrier",
                },
                {
                    id = "nemesis_primal_fear",
                    spell = { id = "telepathic_primal_fear_monster", min_level = 5 },
                    cooldown = 35,
                    casting_message = ccb.content.text("%1$s stares at %3$s and they freeze like a frightened rabbit!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_nemesis_primal_fear",
                },
                {
                    id = "telekinetic_smash_throw",
                    move_cost = 80,
                    cooldown = 15,
                    damage = { { type = "psi_telekinetic_damage", amount = 25, penetration = 10 } },
                    minimum_hit_size = 12,
                    range = 8,
                    throw_strength = 50,
                    dodgeable = false,
                    uncanny_dodgeable = true,
                    blockable = false,
                    avatar_hit = ccb.content.text("%1$s stares at you and a powerful force hurls you through the air!"),
                    npc_hit = ccb.content.text("%1$s stares at <npcname> and a powerful force hurls them through the air!"),
                    avatar_miss = ccb.content.text("%s stares at you, and you feel a crushing pressure for a moment before the feeling vanishes!"),
                    npc_miss = ccb.content.text("%s stares at <npcname> but nothing happens!"),
                    kind = "melee",
                    when = "allow_zombie_nemesis_telekinetic_smash_throw",
                },
                {
                    id = "mon_vitakinetic_weakness_2",
                    cooldown = 30,
                    move_cost = 60,
                    damage = { { type = "biological", amount = 0 } },
                    dodgeable = true,
                    blockable = true,
                    effects = { { id = "effect_vitakinetic_healing_down", duration = { 920000, 2120000 } } },
                    avatar_hit = ccb.content.text("%1$s touches you and you feel weaker!"),
                    npc_hit = ccb.content.text("%1$s touches <npcname> and they flinch!"),
                    avatar_miss = ccb.content.text("%1$s tries to touch you, but you dodge!"),
                    npc_miss = ccb.content.text("%1$s tries to touch <npcname>, but they dodge!"),
                    avatar_no_damage = ccb.content.text("%1$s touches you but only hits your armor."),
                    npc_no_damage = ccb.content.text("%1$s touches <npcname> but only hits their armor."),
                    kind = "melee",
                    when = "allow_zombie_nemesis_mon_vitakinetic_weakness_2",
                },
                {
                    id = "psi_electrokin3_revive",
                    spell = { id = "electrokinetic_revive_monster", min_level = 5 },
                    cooldown = 35,
                    allow_no_target = true,
                    casting_message = ccb.content.text("Lightning crackles around %1$s!"),
                    kind = "spell",
                    when = "allow_zombie_nemesis_psi_electrokin3_revive",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_shoggoth",
    copy_from = "mon_shoggoth",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_fleshy_shambler",
    copy_from = "mon_fleshy_shambler",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_jabberwock",
    copy_from = "mon_jabberwock",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flesh_golem",
    copy_from = "mon_flesh_golem",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_amigara_horror",
    copy_from = "mon_amigara_horror",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_breather",
    copy_from = "mon_breather",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shrapnel_swarm",
    copy_from = "mon_shrapnel_swarm",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_structural_spur",
    copy_from = "mon_structural_spur",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_dog_thing",
    copy_from = "mon_dog_thing",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flaming_eye",
    copy_from = "mon_flaming_eye",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_flying_polyp",
    copy_from = "mon_flying_polyp",
    inheritance = { add = { flags = { "TEEP_IMMUNE" }, armor = { psi_telekinetic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_headless_dog_thing",
    copy_from = "mon_headless_dog_thing",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

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

ccb.content.define_monster {
    id = "mon_hallucinator",
    copy_from = "mon_hallucinator",
    species = { "NETHER_EMANATION", "PSI_NULL" },
}

ccb.content.define_monster {
    id = "mon_hunting_horror",
    copy_from = "mon_hunting_horror",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shadow",
    copy_from = "mon_shadow",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -40 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_shadow_snake",
    copy_from = "mon_shadow_snake",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -40 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_darkman",
    copy_from = "mon_darkman",
    inheritance = {
        add = {
            flags = { "TEEP_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" },
            armor = { psi_photokinetic_damage = -80 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lieutenant_shadow",
    copy_from = "mon_lieutenant_shadow",
    inheritance = { add = { armor = { psi_photokinetic_damage = -80 } } },
}

ccb.content.define_monster { id = "mon_thing", copy_from = "mon_thing", inheritance = { add = { flags = { "TEEP_IMMUNE" } } } }

ccb.content.define_monster { id = "mon_yugg", copy_from = "mon_yugg", inheritance = { add = { flags = { "TEEP_IMMUNE" } } } }

ccb.content.define_monster {
    id = "mon_vortex",
    copy_from = "mon_vortex",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_archunk_weak",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_hanging_roper",
    copy_from = "mon_hanging_roper",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_carrion_grub",
    copy_from = "mon_carrion_grub",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_spearfisher",
    copy_from = "mon_nether_spearfisher",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_leech",
    copy_from = "mon_nether_leech",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_nether_fish",
    copy_from = "mon_nether_fish",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_tower",
    copy_from = "mon_fungaloid_tower",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_queen",
    copy_from = "mon_fungaloid_queen",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_seeder",
    copy_from = "mon_fungaloid_seeder",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wall",
    copy_from = "mon_fungal_wall",
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_fungal_hedgerow",
    copy_from = "mon_fungal_hedgerow",
    inheritance = { add = { armor = { psi_telepathic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_blossom",
    copy_from = "mon_fungal_blossom",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_tendril",
    copy_from = "mon_fungal_tendril",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid",
    copy_from = "mon_fungaloid",
    inheritance = { add = { armor = { psi_telepathic_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_young",
    copy_from = "mon_fungaloid_young",
    inheritance = { add = { armor = { psi_telepathic_damage = 15 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_shambler",
    copy_from = "mon_fungaloid_shambler",
    inheritance = { add = { armor = { psi_telepathic_damage = 30 } } },
}

ccb.content.define_monster {
    id = "mon_ant_fungus",
    copy_from = "mon_ant_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungus",
    copy_from = "mon_zombie_child_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus",
    copy_from = "mon_zombie_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 6 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_raptor",
    copy_from = "mon_fungal_raptor",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_fungus",
    copy_from = "mon_boomer_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 3 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wretch",
    copy_from = "mon_fungal_wretch",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_spider_fungus",
    copy_from = "mon_spider_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungus",
    copy_from = "mon_skeleton_hulk_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 50 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungus",
    copy_from = "mon_skeleton_brute_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 4 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungus",
    copy_from = "mon_skeleton_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 2 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_fungus",
    copy_from = "mon_zombie_gasbag_fungus",
    inheritance = { add = { armor = { psi_telepathic_damage = 1 } } },
}

ccb.content.define_monster {
    id = "mon_feral_cop_fungal_infected",
    copy_from = "mon_feral_cop_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 10 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_infected",
    copy_from = "mon_feral_human_axe_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_corpse",
    copy_from = "mon_feral_human_axe_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_infected",
    copy_from = "mon_feral_human_pipe_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_corpse",
    copy_from = "mon_feral_human_pipe_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_infected",
    copy_from = "mon_feral_human_crowbar_fungal_infected",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_corpse",
    copy_from = "mon_feral_human_crowbar_fungal_corpse",
    inheritance = { add = { armor = { psi_telepathic_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go",
    copy_from = "mon_mi_go",
    inheritance = { add = { armor = { psi_telepathic_damage = 25 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_scout",
    copy_from = "mon_mi_go_scout",
    inheritance = { add = { armor = { psi_telepathic_damage = 25 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_guard",
    copy_from = "mon_mi_go_guard",
    inheritance = { add = { armor = { psi_telepathic_damage = 70 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_slaver",
    copy_from = "mon_mi_go_slaver",
    inheritance = { add = { armor = { psi_telepathic_damage = 35 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_surgeon",
    copy_from = "mon_mi_go_surgeon",
    inheritance = { add = { armor = { psi_telepathic_damage = 32 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_myrmidon",
    copy_from = "mon_mi_go_myrmidon",
    inheritance = { add = { armor = { psi_telepathic_damage = 120 } } },
}

ccb.content.define_monster {
    id = "mon_cow",
    copy_from = "mon_cow",
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_COW_MUTANT_BABIES" },
        count = 1,
        interval = 343,
    },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_1",
    copy_from = "mon_eigenspectre_1",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_2",
    copy_from = "mon_eigenspectre_2",
    species = { "NETHER_EMANATION" },
    inheritance = {
        add = { flags = { "PHOTOKIN_MONSTER_IMMUNE", "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } },
    },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_3",
    copy_from = "mon_eigenspectre_3",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_3_echo",
    copy_from = "mon_eigenspectre_3_echo",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_eigenspectre_4",
    copy_from = "mon_eigenspectre_4",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_living_vector",
    copy_from = "mon_living_vector",
    species = { "NETHER_EMANATION" },
    inheritance = { add = { flags = { "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    copy_from = "mon_feral_human_crowbar",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe",
    copy_from = "mon_feral_human_pipe",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe",
    copy_from = "mon_feral_human_axe",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_human_tool",
    copy_from = "mon_feral_human_tool",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_cop",
    copy_from = "mon_feral_cop",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_survivalist",
    copy_from = "mon_feral_survivalist",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_militia",
    copy_from = "mon_feral_militia",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_knife",
    copy_from = "mon_feral_prepper_knife",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_mace",
    copy_from = "mon_feral_prepper_mace",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_jackboot",
    copy_from = "mon_feral_jackboot",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_soldier",
    copy_from = "mon_feral_soldier",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_feral_sapien_spear",
    copy_from = "mon_feral_sapien_spear",
    upgrade = { half_life = 360, monster_group = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE_HIGHER_ODDS" },
}
