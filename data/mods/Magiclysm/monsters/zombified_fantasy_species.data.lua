local ccb = require("ccb")

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
