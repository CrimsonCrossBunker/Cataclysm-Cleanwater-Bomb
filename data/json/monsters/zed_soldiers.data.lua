local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_soldier",
    name = ccb.content.plural_text("zombie soldier", "zombie soldiers"),
    description = ccb.content.text("Once a soldier, it is dressed head to toe in combat gear and carries itself rather steadily for a zombie."),
    copy_from = "mon_zombie_base",
    categories = { "CLASSIC" },
    hp = 100,
    speed = 80,
    color = "light_green_green",
    melee_skill = 5,
    melee_sides = 6,
    vision_day = 30,
    grab_strength = 30,
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid" },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 0.8 },
    },
    upgrade = { half_life = 168, monster_group = "GROUP_SOLDIER_UPGRADE" },
    armor = { bash = 12, cut = 25, bullet = 20, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { flags = { "STUMBLES" } },
    },
    death = { drops = "mon_zombie_soldier_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_blackops_1",
    name = ccb.content.plural_text("black-ops zombie", "black-ops zombies"),
    description = ccb.content.text("This soldier zombie's skin radiates a sort of shadowy smoke that obscures its outline, making its camouflage even harder to see against the background.  In the darkness it would be nigh invisible."),
    copy_from = "mon_zombie_base",
    looks_like = "mon_zombie_soldier",
    hp = 120,
    speed = 90,
    color = "light_green_green",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_skill = 6,
    melee_sides = 6,
    dodge = 3,
    bleed_rate = 50,
    vision_day = 30,
    vision_night = 35,
    harvest = "zombie_humanoid_shadow",
    attacks = {
        { id = "grab" },
        { id = "scratch_humanoid" },
        {
            id = "bite_humanoid",
            cooldown = 8,
            damage = { { type = "stab", amount = 8, armor_multiplier = 0.8 } },
        },
    },
    upgrade = { half_life = 180, monster = "mon_zombie_soldier_blackops_2" },
    armor = { bash = 12, cut = 25, bullet = 20, electric = 3 },
    inheritance = {
        add = {
            flags = { "SMELLS", "NIGHT_INVISIBILITY" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { flags = { "STUMBLES" } },
    },
    death = { drops = "mon_zombie_soldier_death_drops" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_zombie_soldier_no_weakpoints",
    name = ccb.content.text_without_extraction("zombie soldier test only", "zombie soldier test only"),
    description = ccb.content.text_without_extraction("This zombie soldier is used by hardcoded dps logic and for testing purposes only."),
    copy_from = "mon_zombie_soldier",
    dodge = 1,
    inheritance = {
        add = { flags = { "NOT_HALLUCINATION" } },
        remove = {
            weakpoint_sets = {
                "wps_humanoid_body",
                "wps_vital_organs",
                "wps_eyes",
                "wps_humanoid_body_armor",
                "wps_humanoid_open_helmet",
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_blackops_2",
    name = ccb.content.plural_text("hunter-killer zombie", "hunter-killer zombies"),
    description = ccb.content.text("Fragments of visible uniform hint that this monstrosity was once a soldier.  Anything human is invisible, hidden inside a sheath of living shadow.  It moves with preternatural fluidity and grace."),
    copy_from = "mon_zombie_soldier_blackops_1",
    looks_like = "mon_zombie_soldier_blackops_1",
    bleed_rate = 0,
    upgrade = false,
    inheritance = {
        add = {
            attacks = { { cooldown = 10, maximum_range = 3, kind = "leap" } },
            flags = { "KEENNOSE" },
        },
        offset = { hp = 20, speed = 10, melee_skill = 1, dodge = 1, vision_night = 15 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_acid_1",
    name = ccb.content.plural_text("bilious soldier zombie", "bilious soldier zombies"),
    description = ccb.content.text("This staggering soldier wears a burnt gas mask, now fused to its face.  Through the melted, bile-encrusted ruination of the mask protrudes some sort of hardened, fleshy proboscis, with steaming corrosive fluid leaking from the end."),
    copy_from = "mon_zombie_soldier",
    looks_like = "mon_zombie_soldier",
    difficulty_adjustment = 20,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    inheritance = {
        add = {
            attacks = {
                { reference = "ACID_BARF", cooldown = 10 },
                {
                    cooldown = 15,
                    move_cost = 90,
                    kind = "gun",
                    gun = {
                        weapon = "acid_sniper",
                        skills = { { id = "gun", level = 4 }, { id = "rifle", level = 4 } },
                        dexterity = 8,
                        perception = 8,
                        lock_player = false,
                        target_moving_vehicles = true,
                        description = ccb.content.text("The %s launches a corrosive dart!"),
                        ranges = { { minimum = 2, maximum = 20, mode = "DEFAULT" } },
                    },
                },
            },
            flags = { "ACIDPROOF", "ACID_BLOOD" },
        },
        remove = { categories = { "CLASSIC" } },
        offset = { hp = 20, speed = 10, melee_skill = 1, vision_day = 10 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier_acid_2",
    name = ccb.content.plural_text("caustic soldier zombie", "caustic soldier zombies"),
    description = ccb.content.text("This zombie wears what appears to have once been a soldier's uniform and armor, now a series of cracked and melted plates that have fused to its skin and thickened hide.  Its face and arms blister with strange, mutated tubes that pulse and drip with acid."),
    copy_from = "mon_zombie_soldier",
    looks_like = "mon_zombie_soldier",
    difficulty_adjustment = 20,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    upgrade = false,
    inheritance = {
        add = {
            attacks = {
                { reference = "ACID_BARF", cooldown = 5 },
                { id = "slam" },
                {
                    cooldown = 4,
                    move_cost = 50,
                    kind = "gun",
                    gun = {
                        weapon = "acid_spray",
                        skills = { { id = "gun", level = 4 }, { id = "rifle", level = 4 } },
                        dexterity = 8,
                        perception = 8,
                        lock_player = false,
                        target_moving_vehicles = true,
                        description = ccb.content.text("The %s launches a hail of corrosive darts!"),
                        ranges = { { minimum = 2, maximum = 8, mode = "DEFAULT" } },
                    },
                },
            },
            flags = { "ACIDPROOF", "ACID_BLOOD" },
        },
        remove = { categories = { "CLASSIC" } },
        offset = { hp = 40, speed = -10, melee_skill = 2, armor = { bash = 5 } },
    },
}

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

ccb.content.define_monster {
    id = "mon_zombie_armored",
    name = ccb.content.plural_text("armored zombie", "armored zombies"),
    description = ccb.content.text("Despite being encased in a what was once a nigh-impenetrable combat exoskeleton, something still managed to kill this soldier."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    hp = 120,
    speed = 50,
    color = "white_red",
    melee_skill = 5,
    melee_dice = 3,
    melee_sides = 6,
    weakpoint_sets = { "wps_humanoid_full_helmet" },
    weakpoints = {
        {
            name = ccb.content.text("a crack in the armor"),
            armor_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            coverage = 4,
            attack_coverage = { broad = 0.75 },
            difficulty = { ranged = 7, melee = 5 },
            id = "a crack in the armor",
        },
    },
    bleed_rate = 0,
    vision_day = 30,
    upgrade = false,
    armor = { bash = 64, cut = 64, acid = 20, heat = 20, bullet = 51, electric = 10 },
    inheritance = {
        add = { families = { "prof_wp_syn_armored" }, flags = { "PULP_PRYING" } },
        remove = {
            flags = { "STUMBLES", "GRABS", "PUSH_MON" },
            attacks = { "bite_humanoid", "scratch_humanoid", "grab" },
        },
    },
    death = { drops = "mon_zombie_armored_death_drops" },
}
