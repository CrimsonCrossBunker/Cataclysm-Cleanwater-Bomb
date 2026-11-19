local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_kevlar_0",
    name = ccb.content.plural_text("Kevlar zombie", "Kevlar zombies"),
    description = ccb.content.text("This zombie dons a uniform with heavy, bulletproof materials sewn in.  Peculiarly, the uniform seems to have fused to its skin in certain places, its flesh gripping the edges of its gear as though the body were trying to absorb it."),
    copy_from = "mon_zombie_base",
    looks_like = "mon_zombie_soldier",
    hp = 120,
    speed = 80,
    color = "light_green_white",
    melee_skill = 5,
    melee_sides = 6,
    vision_day = 30,
    harvest = "zombie_kevlar",
    grab_strength = 30,
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 0.7 },
        { id = "scratch_humanoid" },
    },
    upgrade = { half_life = 168, monster = "mon_zombie_kevlar_1" },
    armor = { bash = 18, cut = 28, bullet = 22, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
        },
    },
    death = { drops = "mon_zombie_kevlar_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_kevlar_1",
    name = ccb.content.plural_text("Kevlar brute", "Kevlar brutes"),
    description = ccb.content.text("This zombie was once wearing some kind of uniform with heavy, bulletproof materials sewn in.  At this point it's impossible to tell what kind of uniform it was: the monster's skin has grown over the fabric, splitting and tearing it to shreds, turning the remaining Kevlar and other bits of armor material into part of its hide.  Its hands have similarly fused into large, leathery cudgels."),
    copy_from = "mon_zombie_brute",
    volume = "72500 ml",
    mass = "85500 g",
    hp = 150,
    speed = 80,
    color = "light_green_white",
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 0 } },
    vision_day = 30,
    vision_night = 5,
    harvest = "zombie_kevlar",
    attacks = {
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { id = "smash", throw_strength = 36, cooldown = 30 },
        { id = "smash_equal", throw_strength = 18, cooldown = 30 },
    },
    upgrade = { half_life = 168, monster = "mon_zombie_kevlar_2" },
    armor = { bash = 20, cut = 30, bullet = 24, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
        },
        remove = { flags = { "GRABS" } },
    },
    death = { drops = "mon_zombie_kevlar_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_kevlar_2",
    name = ccb.content.plural_text("Kevlar hulk", "Kevlar hulks"),
    description = ccb.content.text("This zombie was once wearing some kind of now long-shredded uniform with heavy, bulletproof materials sewn in.  It has grown into a hulking, leatherbacked beast, its mutated skin taking on a strange texture similar to the Kevlar bits embedded in it.  Its arms have twisted into enormous clubs of misshapen bone that it drags on the ground behind it."),
    copy_from = "mon_zombie_hulk",
    hp = 300,
    speed = 75,
    color = "light_green_white",
    melee_skill = 8,
    melee_dice = 3,
    vision_day = 50,
    harvest = "zombie_kevlar_hulk",
    attacks = {
        { id = "slam", cooldown = 12, damage = { { type = "bash", amount = 35 } } },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "smash", throw_strength = 72 },
        { id = "smash_equal", throw_strength = 36 },
        { id = "hulk_wide_swing", accuracy = 9 },
    },
    armor = { bash = 30, cut = 50, bullet = 40, electric = 6 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored", "prof_wp_nat_armored" },
        },
        remove = { flags = { "GRABS" } },
    },
    death = { drops = "mon_zombie_kevlar_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_military_pilot",
    name = ccb.content.plural_text("zombie military pilot", "zombie military pilots"),
    description = ccb.content.text("Once a pilot, it is wearing a flight suit and a sturdy-looking flight helmet.  The head twitches and adjusts constantly, following any and every source of movement."),
    copy_from = "mon_zombie_base",
    categories = { "CLASSIC" },
    hp = 90,
    speed = 75,
    color = "light_green_green",
    melee_sides = 4,
    vision_day = 30,
    upgrade = false,
    harvest = "zombie_humanoid",
    armor = { bash = 5, cut = 5, bullet = 4, electric = 2 },
    inheritance = {
        add = { weakpoint_sets = { "wps_humanoid_full_helmet" }, flags = { "NOHEAD" } },
        remove = { flags = { "HEARS", "STUMBLES" } },
    },
    death = { drops = "mon_zombie_military_pilot_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_milbase_personnel",
    name = ccb.content.plural_text("uniformed zombie", "uniformed zombies"),
    description = ccb.content.text("This undead soldier is adorned in standard military fatigues.  It carries itself rather steadily for a zombie."),
    copy_from = "mon_zombie_military_pilot",
    looks_like = "mon_zombie",
    upgrade = { half_life = 128, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    armor = { bash = 2, cut = 2, bullet = 2 },
    inheritance = {
        add = { flags = { "HEARS" } },
        remove = { weakpoint_sets = { "wps_humanoid_full_helmet" }, flags = { "NOHEAD" } },
    },
    death = { drops = "mon_zombie_milbase_personnel_death_drops" },
}

-- no provision for body armour or helmets in either the weak point set or dissection set, as Navy sailors aren't normally dressed in military combat gear whilst shipside.
ccb.content.define_monster {
    id = "mon_zombie_sailor",
    name = ccb.content.plural_text("zombie mariner", "zombie mariners"),
    description = ccb.content.text("Still dressed in the ragged remains of deep blue naval fatigues, it's clear that this walking corpse was once a sailor of some description.  The US Navy's insignia is embroidered on the shredded sleeve and shoulder of its bloodied jacket, the dead crewman's battered cap is beaten into the remains of its fractured skull and its inky black eyes are scanning the area around it as dark ooze drips from its limply hanging maw."),
    copy_from = "mon_zombie_milbase_personnel",
    looks_like = "mon_zombie_soldier",
    armor = { electric = 2, bash = 2, cut = 2, bullet = 2 },
    death = { drops = "mon_zombie_sailor_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_officer",
    copy_from = "mon_zombie_sailor",
    name = ccb.content.plural_text("zombie officer", "zombie officers"),
    description = ccb.content.text("Dressed in the shredded blue dress uniform of a naval officer, this undead corpse was evidently a higher ranking crewman in life.  Having more than likely not been clad in body armor, the result now staggers before you: horrific wounds exposed to the air and large portions of flesh and muscle ripped from its glistening skeleton."),
    death = { drops = "mon_zombie_officer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine",
    name = ccb.content.plural_text("zombie marine", "zombie marines"),
    description = ccb.content.text("Dressed head to toe in naval combat equipment and with Marine insignia embroidered on its gear, this lurching corpse still retains its physical fitness in death.  From underneath its helmet, its inky black eyes scan the area around it."),
    copy_from = "mon_zombie_soldier",
    melee_skill = 6,
    melee_dice = 3,
    melee_sides = 4,
    upgrade = { half_life = 152, monster = "mon_zombie_marine_upgrade" },
    death = { drops = "mon_zombie_marine_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine_upgrade",
    copy_from = "mon_zombie_marine",
    name = ccb.content.plural_text("bestial stalker", "bestial stalkers"),
    description = ccb.content.text("Lumbering about on all fours, this mutated beast's dagger-like claws clack against the ground as it predatorially moves: thick strands of exposed muscle tissue running across its rotting body.  The addition of its new bulk has caused the skin along its arms and back to split, and the brute's teeth have extended into spikes of bone.  The Marine insignias on the remains of the creature's pulverized gear are the only testaments to the soldier that this hulking abomination used to be."),
    volume = "140 L",
    mass = "120 kg",
    hp = 150,
    speed = 110,
    color = "white_red",
    difficulty_adjustment = 5,
    melee_sides = 6,
    bleed_rate = 20,
    grab_strength = 35,
    attacks = {
        { id = "grab" },
        { id = "smash", throw_strength = 75, cooldown = 30 },
        { id = "smash_equal", throw_strength = 37, cooldown = 30 },
        { id = "hulk_wide_swing", accuracy = 9 },
        {
            id = "scratch_humanoid",
            move_cost = 150,
            cooldown = 4,
            minimum_damage_multiplier = 1.5,
            maximum_damage_multiplier = 3.5,
        },
        { id = "bite_humanoid", move_cost = 150, cooldown = 2, accuracy = 4, infection_chance = 8 },
    },
    inheritance = { remove = { categories = { "CLASSIC" } } },
}

-- This is a variation which will drop default military equipment, rather than specific naval uniforms and gear.
ccb.content.define_monster {
    id = "mon_bestial_stalker",
    copy_from = "mon_zombie_marine_upgrade",
    species = { "ZOMBIE" },
    looks_like = "mon_zombie_marine_upgrade",
    description = ccb.content.text("Lumbering about on all fours, this mutated beast's dagger-like claws clack against the ground as it predatorially moves: thick strands of exposed muscle tissue running across its rotting body.  The addition of its new bulk has caused the skin along its arms and back to split, and the brute's teeth have extended into spikes of bone.  The military insignias on the remains of the creature's pulverized gear are the only testaments to the soldier that this hulking abomination used to be."),
    death = { drops = "mon_zombie_soldier_death_drops" },
}
