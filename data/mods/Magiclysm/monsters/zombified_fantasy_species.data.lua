local ccb = require("ccb")

-- Better night vision than default zombies, but not as good as living dwarves, and worse day vision.
ccb.content.define_monster {
    id = "mon_zombie_dwarf",
    name = ccb.content.plural_text("zombie dwarf", "zombie dwarves"),
    copy_from = "mon_zombie_tough",
    species = { "ZOMBIE", "DWARF" },
    description = ccb.content.text("Once a dwarf, this zombie now has rent flesh and a beard in tatters.  Its face is twisted in an expression of rage."),
    speed = 65,
    vision_day = 15,
    vision_night = 8,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_DWARF_UPGRADE" },
    inheritance = { scale = { volume = 0.7, mass = 0.9 } },
}

-- Better night vision than default zombies, but not as good as living dwarves, and worse day vision.
ccb.content.define_monster {
    id = "mon_zombie_dwarf_miner",
    name = ccb.content.plural_text("zombie dwarven miner", "zombie dwarven miners"),
    copy_from = "mon_zombie_miner",
    species = { "ZOMBIE", "DWARF" },
    description = ccb.content.text("Once a dwarven miner, this zombie now has rent flesh and a beard in tatters.  Its face is twisted in an expression of rage."),
    vision_day = 15,
    vision_night = 8,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_DWARF_UPGRADE" },
    inheritance = { scale = { hp = 1.2, volume = 0.7, mass = 0.9, speed = 0.9 } },
}

-- Better night vision than default zombies, but not as good as living elves.
ccb.content.define_monster {
    id = "mon_zombie_elf",
    name = ccb.content.plural_text("zombie elf", "zombie elves"),
    copy_from = "mon_zombie",
    species = { "ZOMBIE", "ELF" },
    description = ccb.content.text("Its face twisted in an expression of pure rage and with glassy eyes, this elf looks nothing like the ethereal elves from before the Cataclysm.  Though it also lacks the elves' characteristic grace, its movements are quieter than the other dead."),
    vision_night = 5,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_ELF_UPGRADE" },
    inheritance = { add = { flags = { "QUIETMOVES" } }, scale = { hp = 0.82, speed = 1.03, mass = 0.85 } },
}

-- zombie goblins are basically blind during the day
ccb.content.define_monster {
    id = "mon_zombie_goblin",
    name = ccb.content.plural_text("zombie goblin", "zombie goblins"),
    copy_from = "mon_zombie",
    description = ccb.content.text("With bared teeth and black eyes filled with rage, this formerly-living goblin is now a walking nightmare.  While small, unlike the human zombies it was born with teeth and claws."),
    body_type = "human",
    species = { "ZOMBIE", "GOBLIN" },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_child_body" },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5, attack_upper = false },
        {
            id = "scratch",
            attack_upper = false,
            cooldown = 4,
            damage = { { type = "cut", amount = 8 } },
            when = "monster_attack_intact_arms",
        },
    },
    vision_day = 3,
    vision_night = 15,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_GOBLIN_UPGRADE" },
    inheritance = { scale = { hp = 0.5, speed = 1.05, volume = 0.5, mass = 0.5 } },
    death = { drops = "feral_goblin_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_ravenfolk",
    name = ccb.content.plural_text("zombie ravenfolk", "zombie ravenfolk"),
    copy_from = "mon_zombie",
    description = ccb.content.text("With bedraggled wings, dull eyes, and beak hanging open, this ravenfolk body still walks, a slight sway as it moves."),
    body_type = "angel",
    species = { "RAVENFOLK", "ZOMBIE" },
    volume = "62500 ml",
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    weakpoints = {
        {
            id = "wing",
            name = ccb.content.text("the wings"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
            attack_coverage = { point = 0.25 },
            effects = {
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 100 },
                },
            },
            coverage = 12,
        },
    },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_demihuman", "prof_wp_basic_bird" },
    harvest = "zombie_ravenfolk",
    attacks = {
        { reference = "SHRIEK_ALERT", cooldown = 15 },
        {
            id = "feral_ravenfolk_peck",
            cooldown = 15,
            move_cost = 100,
            damage = { { type = "stab", amount = 12, penetration = 8 } },
            minimum_hit_size = 4,
            avatar_hit = ccb.content.text("%1$s buries its beak in your %2$s!"),
            npc_hit = ccb.content.text("%1$s buries its beak in <npcname>!"),
            avatar_miss = ccb.content.text("%1$s tries to peck you, but you dodge!"),
            npc_miss = ccb.content.text("%1$s tries to peck <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text("%1$s tries to peck your %2$s, but fails to penetrate your armor."),
            npc_no_damage = ccb.content.text("%1$s tries to peck <npcname>, but fails to penetrate their armor."),
            kind = "melee",
        },
        {
            id = "scratch",
            attack_upper = true,
            cooldown = 2,
            damage = { { type = "cut", amount = 8 } },
        },
        {
            cooldown = 15,
            maximum_range = 6,
            message = ccb.content.text_without_extraction("%1$s leaps with a flutter of wings!"),
            kind = "leap",
        },
    },
    vision_day = 35,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_RAVENFOLK_UPGRADE" },
    inheritance = { scale = { hp = 0.6, speed = 1.1, mass = 0.75 } },
    death = { drops = "feral_ravenfolk_death_drops" },
}

-- No grab--they have multiple natural weapons so they just attack
-- With their long muzzles lizardfolk can bite without grabbing, but it's still a little awkward, hence the move cost.
ccb.content.define_monster {
    id = "mon_zombie_lizardfolk",
    copy_from = "mon_zombie",
    name = ccb.content.plural_text("zombie lizardfolk", "zombie lizardfolk"),
    description = ccb.content.text("A proud servant of dragons reduced to a walking corpse, this lizardfolk's scales are streaked with grime and its black eyes burn with rage.  It has not lost its teeth and claws in the transition to undeath."),
    species = { "LIZARDFOLK", "ZOMBIE" },
    volume = "80 L",
    mass = "100 kg",
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_demihuman" },
    armor = { bash = 3, cut = 4, stab = 4, bullet = 2 },
    harvest = "zombie_lizardfolk",
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        {
            id = "scratch",
            attack_upper = true,
            cooldown = 1,
            damage = { { type = "cut", amount = 11 } },
            when = "monster_attack_intact_arms",
        },
        {
            id = "lizardfolk_zombie_bite",
            cooldown = 10,
            move_cost = 200,
            range = 1,
            damage = { { type = "stab", amount = 15 } },
            minimum_damage_multiplier = 0.3,
            avatar_hit = ccb.content.text("%1$s's lunges forward, and its teeth sink into your %2$s!"),
            npc_hit = ccb.content.text("%1$s's lunges forward, and its teeth sink into <npcname>!"),
            avatar_no_damage = ccb.content.text("%1$s's lunges at your %2$s, but its teeth glance off your armor."),
            npc_no_damage = ccb.content.text("%1$s's lunges at <npcname>, but its teeth glance off their armor."),
            avatar_miss = ccb.content.text("%s lunges forward to bite you, but you dodge!"),
            npc_miss = ccb.content.text("%s lunges forward to bite <npcname>, but they dodge!"),
            kind = "melee",
        },
    },
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_LIZARDFOLK_UPGRADE" },
    death = { drops = "feral_lizardfolk_death_drops" },
}
