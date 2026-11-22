local ccb = require("ccb")

-- Additional dodge due to reading the player's mind
ccb.content.define_monster {
    id = "mon_feral_human_teep",
    name = ccb.content.plural_text("feral esper", "feral espers"),
    description = ccb.content.text("This feral human lacks the crazed look most of their kind have.  Instead, their gaze is unfocused, as though listening to voices only they can hear."),
    copy_from = "mon_feral_psion_default",
    color = "white",
    symbol = "@",
    armor = { psi_telepathic_damage = 20 },
    zombify_into = "mon_zombie_survivor",
    upgrade = { half_life = 180, monster = "mon_feral_human_teep2" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_telepath1_scream",
                    spell = { id = "telepathic_confusion_monster", min_level = 3 },
                    casting_message = ccb.content.text("A roar fills %3$s's mind and the world is blotted out!"),
                    kind = "spell",
                    cooldown = { 10, 30 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath1_blast",
                    spell = { id = "telepathic_blast_monster", min_level = 1 },
                    casting_message = ccb.content.text("%1$s stares at %3$s!"),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
            },
        },
        offset = { dodge = 2 },
    },
    death = {
        drops = "feral_humans_death_drops_teep",
        outcome = {
            spell = { id = "death_psychic_scream", hit_self = true, min_level = 5 },
            message = ccb.content.text("As the %1$s dies, a scream fills your mind!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_human_teep2",
    name = ccb.content.plural_text("feral brainburner", "feral brainburners"),
    description = ccb.content.text("Before you see them, you can feel it--a sensation like spiders crawling along your brain.  As you shudder, this feral human looks at you and smiles slightly."),
    copy_from = "mon_feral_psion_default",
    color = "white",
    symbol = "@",
    zombify_into = "mon_zombie_survivor",
    upgrade = { half_life = 180, monster = "mon_feral_human_teep3" },
    inheritance = {
        add = {
            attacks = {
                { reference = "PARROT_AT_DANGER", cooldown = 10 },
                {
                    id = "psi_telepath2_scream",
                    spell = { id = "telepathic_confusion_monster", min_level = 3 },
                    casting_message = ccb.content.text("A roar fills %3$s's mind and the world is blotted out!"),
                    kind = "spell",
                    cooldown = { 8, 24 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath2_blast",
                    spell = { id = "telepathic_blast_monster", min_level = 2 },
                    casting_message = ccb.content.text("%1$s stares at %3$s!"),
                    kind = "spell",
                    cooldown = { 7, 21 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath2_horror",
                    spell = { id = "telepathic_horror_monster", min_level = 4 },
                    casting_message = ccb.content.text("%1$s stares at %3$s!"),
                    kind = "spell",
                    cooldown = { 12, 36 },
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "TEEP_IMMUNE" },
        },
        offset = { dodge = 3 },
    },
    death = {
        drops = "feral_humans_death_drops_teep",
        outcome = {
            spell = { id = "death_psychic_scream", hit_self = true, min_level = 10 },
            message = ccb.content.text("As the %1$s dies, a scream fills your mind!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_human_teep3",
    name = ccb.content.plural_text("instiller of nightmares", "instillers of nightmares"),
    description = ccb.content.text("Just another feral, with the typical bloodshot eyes and intense expression.  You have only a moment to think that before your heart starts racing in your chest and the hair stands up on the back of your neck as every instinct screams at you to run."),
    copy_from = "mon_feral_psion_default",
    color = "white",
    symbol = "@",
    zombify_into = "mon_zombie_survivor",
    upgrade = { half_life = 180, monster = "mon_feral_human_teep3" },
    inheritance = {
        add = {
            attacks = {
                { reference = "PARROT_AT_DANGER", cooldown = 10 },
                {
                    id = "psi_telepath3_scream",
                    spell = { id = "telepathic_confusion_monster", min_level = 5 },
                    casting_message = ccb.content.text("A roar fills %3$s's mind and the world is blotted out!"),
                    kind = "spell",
                    cooldown = { 7, 21 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath3_blast",
                    spell = { id = "telepathic_blast_monster", min_level = 5 },
                    casting_message = ccb.content.text("%1$s stares at %3$s!"),
                    kind = "spell",
                    cooldown = { 5, 15 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath3_horror_aoe",
                    spell = { id = "telepathic_horror_aoe_monster", min_level = 15 },
                    allow_no_target = true,
                    casting_message = ccb.content.text("%1$s eyes suddenly go wide!"),
                    kind = "spell",
                    cooldown = { 12, 36 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_telepath3_freeze",
                    spell = { id = "telepathic_primal_fear_monster", min_level = 5 },
                    casting_message = ccb.content.text("%1$s stares at %3$s and they freeze like a frightened rabbit!"),
                    kind = "spell",
                    cooldown = { 17, 51 },
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "TEEP_IMMUNE" },
        },
        offset = { dodge = 4 },
    },
    death = {
        drops = "feral_humans_death_drops_teep",
        outcome = {
            spell = { id = "death_psychic_scream", hit_self = true, min_level = 15 },
            message = ccb.content.text("As the %1$s dies, a scream fills your mind!"),
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_human_porter",
    name = ccb.content.plural_text("feral jumper", "feral jumpers"),
    description = ccb.content.text("What was once empty air suddenly contains this feral human.  They have the same crazed expression as their fellows, but their gaze is focused on more distant locations.  A sturdy piece of debris from some ruin dangles from one of their hands."),
    copy_from = "mon_feral_psion_default",
    color = "blue",
    symbol = "@",
    morale = 25,
    zombify_into = "mon_zombie_survivor",
    upgrade = { half_life = 180, monster = "mon_feral_human_porter2" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "feral_weapon_pipe",
                    avatar_hit = ccb.content.text_without_extraction("%1$s hits your %2$s with their weapon!"),
                    npc_hit = ccb.content.text_without_extraction("%1$s hits <npcname>'s %2$s with their weapon!"),
                    avatar_miss = ccb.content.text_without_extraction("%1$s tries to hit you, but you dodge!"),
                    npc_miss = ccb.content.text_without_extraction("%1$s tries to hit <npcname>, but they dodge!"),
                    avatar_no_damage = ccb.content.text_without_extraction("%1$s hits your %2$s without penetrating your armor."),
                    npc_no_damage = ccb.content.text_without_extraction("%1$s hits <npcname>'s %2$s without penetrating their armor."),
                },
                {
                    id = "psi_teleport1_slow",
                    spell = { id = "teleport_slow_monster", min_level = 2 },
                    casting_message = ccb.content.text("%1$s looks at %3$s and the world lurches."),
                    kind = "spell",
                    cooldown = { 7, 21 },
                    when = "monster_attack_psionics_available",
                },
                {
                    allow_no_target = true,
                    maximum_range = 8,
                    message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
                    kind = "leap",
                    cooldown = { 4, 12 },
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "CLIMBS", "HARDTOSHOOT", "TELEPORT_IMMUNE", "WIELDED_WEAPON" },
        },
        offset = { dodge = 2 },
    },
    death = { drops = "feral_humans_death_drops_porter" },
}

ccb.content.define_monster {
    id = "mon_feral_human_telekin3",
    name = "unstoppable force",
    description = "Hovering half a meter off the ground, this feral human is surrounded by a whirling cloud of rock, dust, splintered wood, and various household objects.  As they move, the ground occasionally shakes.",
    copy_from = "mon_feral_psion_default",
    symbol = "@",
    color = "yellow",
    zombify_into = "mon_zombie_survivor",
    species = { "FERAL" },
    melee_damage = {
        { type = "bash", amount = 8 },
    },
    death = {
        drops = "feral_humans_death_drops_telekin",
        outcome = {
            message = "As the %1$s dies, a wave of force explodes outward!",
            spell = { id = "death_telekeinetic_hit_oneinthree", hit_self = true },
        },
    },
    inheritance = {
        add = {
            flags = { "FLIES", "PUSH_VEH", "PUSH_MON" },
            attacks = {
                {
                    kind = "spell",
                    id = "psi_telekin3_telegrab",
                    cooldown = { 5, 15 },
                    spell = { id = "telekinetic_pull_monster", min_level = 6 },
                    casting_message = "%1$s stares at %3$s and %3$s is lifted up and pulled towards them!",
                    when = "w16b_mon_when_mindovermatter_10c7bd6453e1",
                },
                {
                    kind = "melee",
                    id = "mon_telekinetic3_mindhammer",
                    move_cost = 80,
                    accuracy = 9,
                    range = 11,
                    dodgeable = false,
                    uncanny_dodgeable = true,
                    blockable = false,
                    cooldown = { 6, 18 },
                    damage = {
                        { type = "psi_telekinetic_damage", amount = 35 },
                    },
                    avatar_hit = "%1$s stares at you and your %2$s is hammered with psionic force!",
                    avatar_miss = "%1$s stares at you and you narrowly avoid an unseen attack!",
                    avatar_no_damage = "%1$s stares at you, but the telekinetic attack rebounds off your armor.",
                    npc_hit = "%1$s stares at <npcname> and their %2$s is hammered with psionic force!",
                    npc_miss = "%1$s stares and <npcname> narrowly avoids an unseen attack!",
                    npc_no_damage = "%1$s stares at <npcname>, but the telekinetic attack rebounds off their armor.",
                    when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
                },
                {
                    id = "smash",
                    move_cost = 80,
                    accuracy = 9,
                    range = 11,
                    minimum_hit_size = 12,
                    throw_strength = 50,
                    dodgeable = false,
                    uncanny_dodgeable = true,
                    blockable = false,
                    cooldown = { 4, 12 },
                    damage = {
                        { type = "psi_telekinetic_damage", amount = 0 },
                    },
                    avatar_hit = "%1$s stares at you and a powerful force hurls you through the air!",
                    avatar_miss = "%s stares at you, and you feel a crushing pressure for a moment before the feeling vanishes!",
                    npc_hit = "%1$s stares at <npcname> and a powerful force hurls them through the air!",
                    npc_miss = "%s stares at <npcname> but nothing happens!",
                    when = "w16b_mon_when_mindovermatter_83e63041f3d4",
                },
                {
                    kind = "spell",
                    id = "psi_telekin3_momentum_alteration",
                    cooldown = 1,
                    spell = { id = "telekinetic_momentum_monster" },
                    casting_message = "The air around %1$s wavers.",
                    when = "w16b_mon_when_mindovermatter_3df3bbb22100",
                },
                {
                    kind = "spell",
                    id = "psi_telekin3_inertial_barrier",
                    cooldown = 1,
                    spell = { id = "telekinetic_barrier_monster_improved" },
                    casting_message = "The air around %1$s distorts.",
                    when = "w16b_mon_when_mindovermatter_8534ea177917",
                },
                {
                    kind = "spell",
                    id = "psi_telekin3_wreckingball",
                    cooldown = { 7, 21 },
                    spell = { id = "telekinetic_explosion_monster", min_level = 8 },
                    casting_message = "%1$s gestures and the ground bursts apart!",
                    when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
                },
                {
                    kind = "spell",
                    id = "psi_telekin3_aegis",
                    cooldown = 1,
                    spell = { id = "telekinetic_aegis_monster" },
                    casting_message = "%1$s throws their arms wide!",
                    when = "w16b_mon_when_mindovermatter_21f53da13125",
                },
                {
                    kind = "spell",
                    id = "psi_telekin3_earthshake",
                    cooldown = { 15, 45 },
                    spell = { id = "telekinetic_earthshaker_monster", min_level = 5 },
                    casting_message = "%1$s closes their eyes and the ground shakes!",
                    when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
                },
                { reference = "PULL_METAL_WEAPON", cooldown = 5 },
            },
        },
    },
}
