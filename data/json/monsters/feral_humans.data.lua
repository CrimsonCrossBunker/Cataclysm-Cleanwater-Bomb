local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral human", "feral humans"),
    description = ccb.content.text("Their pupils are dilated and what can be seen of the iris and sclera are bloodshot.  This pipe-wielding maniac still breathes, but the zombies treat them like one of their own."),
    default_faction = "zombie",
    looks_like = "chud",
    body_type = "human",
    species = { "FERAL", "HUMAN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 84,
    speed = 100,
    move_skills = { climb = 8 },
    materials = { "flesh" },
    symbol = "@",
    color = "magenta",
    aggression = 30,
    morale = 100,
    melee_skill = 3,
    melee_dice = 1,
    melee_sides = 6,
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dodge = 1,
    harvest = "human",
    dissect = "dissect_human_sample_single",
    vision_day = 45,
    vision_night = 3,
    pathing = { max_distance = 45, open_doors = true, avoid_traps = true, avoid_sharp = true },
    starting_ammo = { rock = 6 },
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_pipe" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    upgrade = { half_life = 360, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    zombify_into = "mon_zombie",
    fungalize_into = "mon_feral_human_pipe_fungal_infected",
    anger_triggers = { "FRIEND_DIED", "FRIEND_ATTACKED", "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    flags = {
        "SEES", "HEARS", "SMELLS", "WARM", "BASHES", "GROUP_BASH", "HUMAN", "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER", "DROPS_AMMO", "WIELDED_WEAPON", "EATS",
    },
    death = { drops = "feral_humans_death_drops_pipe" },
}

ccb.content.define_monster {
    id = "mon_feral_sapien_spear",
    name = ccb.content.plural_text("cunning feral", "cunning ferals"),
    description = ccb.content.text("This feral human's eyes look more focused, and its movements steadier, than others of their kind.  They're carrying a crude spear, and have assembled some basic armor from scavenged clothing and bits of riot armor, though you can see several gaps.  Despite these signs of greater intelligence, this creature is still only a few steps away from being a zombie themselves."),
    copy_from = "mon_feral_human_pipe",
    dodge = 3,
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 }, { id = "feral_weapon_spear_knife" } },
    vision_day = 50,
    zombify_into = "mon_zombie_survivor",
    armor = { bash = 9, cut = 14, acid = 4, bullet = 18 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "feral_sapien_death_drops_spear" },
}

ccb.content.define_monster {
    id = "mon_chud",
    name = ccb.content.plural_text("feral troglobite", "feral troglobites"),
    description = ccb.content.text("This person is still alive but completely crazed, changed by something they were exposed to down here.  Their face is dominated by unnaturally large, faintly glowing eyes and needle-sharp teeth poking through their lips.  They remind you of something out of a campy monster movie - and of the good times when underground cannibals were less of a real concern."),
    copy_from = "mon_feral_human_pipe",
    looks_like = "mon_zombie_runner",
    symbol = "@",
    color = "white",
    melee_skill = 6,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 3 } },
    weakpoint_sets = { "wps_humanoid_body", "wps_vital_organs", "wps_eyes" },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    dodge = 4,
    vision_night = 15,
    attacks = {
        { id = "scratch", minimum_damage_multiplier = 0.5, cooldown = 10 },
        { minimum_damage_multiplier = 0.7, cooldown = 15, kind = "bite" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    dissect = "dissect_troglobite_sample_small",
    zombify_into = "mon_zombie_shady",
    inheritance = { add = { flags = { "FILTHY", "INFRARED_VISION" } } },
    death = { drops = "default_zombie_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    description = ccb.content.text("Their pupils are dilated and what can be seen of the iris and sclera are bloodshot.  This crowbar-wielding maniac still breathes, but the zombies treat them like one of their own."),
    copy_from = "mon_feral_human_pipe",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_crowbar" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    fungalize_into = "mon_feral_human_crowbar_fungal_infected",
    death = { drops = "feral_humans_death_drops_crowbar" },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe",
    name = ccb.content.plural_text("axe murderer", "axe murderers"),
    description = ccb.content.text("They stumble along dragging a large bloodstained axe.  Their face is twisted into a sadistic grin, and they walk among the dead as though already one of them."),
    copy_from = "mon_feral_human_pipe",
    attacks = { { id = "feral_weapon_axe" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    fungalize_into = "mon_feral_human_axe_fungal_infected",
    death = { drops = "feral_humans_death_drops_axe" },
}

ccb.content.define_monster {
    id = "mon_feral_human_tool",
    name = ccb.content.plural_text("feral mechanic", "feral mechanics"),
    description = ccb.content.text("This wild human-like creature was probably a mechanic before the Cataclysm.  You can see it by his worker uniform, or by his blood-covered hammer in hand, or by his all-hating view."),
    copy_from = "mon_feral_human_pipe",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_hammer" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    death = { drops = "feral_humans_death_drops_tool" },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_infected",
    copy_from = "mon_feral_human_pipe",
    speed = 90,
    upgrade = { grow_at_age = 4, monster = "mon_feral_human_pipe_fungal_corpse" },
    burn_into = "mon_starer_pipe",
    inheritance = { add = { flags = { "NO_FUNG_DMG" }, species = { "FUNGUS" } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_infected",
    copy_from = "mon_feral_human_crowbar",
    speed = 90,
    upgrade = { grow_at_age = 4, monster = "mon_feral_human_crowbar_fungal_corpse" },
    burn_into = "mon_starer_crowbar",
    inheritance = { add = { flags = { "NO_FUNG_DMG" }, species = { "FUNGUS" } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_infected",
    copy_from = "mon_feral_human_axe",
    speed = 90,
    upgrade = { grow_at_age = 4, monster = "mon_feral_human_axe_fungal_corpse" },
    burn_into = "mon_starer_axe",
    inheritance = { add = { flags = { "NO_FUNG_DMG" }, species = { "FUNGUS" } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_corpse",
    description = ccb.content.text("Delicate fungal stalks sprout in rows from sores covering this person's body, and their facial expression is pure agony."),
    copy_from = "mon_feral_human_pipe",
    default_faction = "fungus",
    upgrade = { half_life = 56, monster = "mon_fungaloid" },
    inheritance = {
        add = {
            attacks = { { reference = "FUNGUS", cooldown = 40 } },
            flags = { "NO_FUNG_DMG", "IMMOBILE" },
        },
    },
    death = { outcome = { spell = { id = "death_fungus", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_corpse",
    description = ccb.content.text("Delicate fungal stalks sprout in rows from sores on this person's arms, and their facial expression is pure agony.  Their mouth opens and closes softly in a silent moan."),
    copy_from = "mon_feral_human_crowbar",
    default_faction = "fungus",
    upgrade = { half_life = 56, monster = "mon_fungaloid" },
    inheritance = {
        add = {
            attacks = { { reference = "FUNGUS", cooldown = 40 } },
            flags = { "NO_FUNG_DMG", "IMMOBILE" },
        },
    },
    death = { outcome = { spell = { id = "death_fungus", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_corpse",
    description = ccb.content.text("Delicate fungal stalks sprout in rows from sores on this person's arms, and their facial expression is pure agony."),
    copy_from = "mon_feral_human_axe",
    default_faction = "fungus",
    upgrade = { half_life = 56, monster = "mon_fungaloid" },
    inheritance = {
        add = {
            attacks = { { reference = "FUNGUS", cooldown = 40 } },
            flags = { "NO_FUNG_DMG", "IMMOBILE" },
        },
    },
    death = { outcome = { spell = { id = "death_fungus", hit_self = true } } },
}

ccb.content.define_monster {
    id = "mon_feral_scientist_scalpel",
    name = ccb.content.plural_text("mad scientist", "mad scientists"),
    description = ccb.content.text("A researcher who has stared too long into the abyss, and now shambles about muttering nonsense under their breath.  For some reason, the zombies don't seem to mind that this person is obviously still alive.  They're clutching a tiny but razor-sharp blade in one shaky hand."),
    copy_from = "mon_feral_human_pipe",
    default_faction = "science",
    melee_skill = 4,
    vision_day = 50,
    attacks = { { id = "feral_weapon_scalpel" } },
    zombify_into = "mon_zombie_scientist",
    death = { drops = "feral_scientists_death_drops_scalpel" },
}

ccb.content.define_monster {
    id = "mon_feral_labsecurity_9mm",
    name = ccb.content.plural_text("feral security guard", "feral security guards"),
    description = ccb.content.text("This security guard still breathes, but has been lost to some terrible madness.  They move among the undead, with a baton in their arms and saucer pupils scanning for threats in a mockery of their former duty."),
    copy_from = "mon_feral_human_pipe",
    default_faction = "science",
    melee_skill = 6,
    vision_day = 50,
    vision_night = 4,
    difficulty_adjustment = 5,
    attacks = { { id = "feral_weapon_baton-extended" } },
    zombify_into = "mon_zombie_labsecurity",
    armor = { bash = 4, cut = 6, stab = 4, bullet = 4 },
    inheritance = {
        add = { weakpoint_sets = { "wps_humanoid_body_armor" }, families = { "prof_wp_syn_armored" } },
    },
    death = { drops = "feral_security_death_drops_9mm" },
}

ccb.content.define_monster {
    id = "mon_feral_labsecurity_flashlight",
    copy_from = "mon_feral_labsecurity_9mm",
    description = ccb.content.text("At first glance, this disheveled figure could almost pass for a survivor, but the bloodshot eyes give them away as one of the humans who have gone feral and joined the undead without dying.  Their uniform suggests that this was at some point a security guard, and they still carry a stun gun and a heavy-duty flashlight that looks like it could easily double as a club."),
    attacks = {
        { reference = "TAZER", cooldown = 10 },
        { id = "feral_weapon_heavy_flashlight" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    luminance = 500,
    death = { drops = "feral_security_death_drops_flashlight" },
}

-- Nonsense feral for the mansion escape challenge scenario, shouldn't be used for general spawns
ccb.content.define_monster {
    id = "mon_feral_maid_broom",
    name = ccb.content.plural_text("feral servant", "feral servants"),
    description = ccb.content.text("Once a fancy servant of some rich family, this maniac walks around with a broom in hand, searching for a victim to sweep off this mortal coil."),
    copy_from = "mon_feral_human_pipe",
    melee_skill = 2,
    attacks = {
        { id = "feral_weapon_broom" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    inheritance = { remove = { flags = { "BASHES", "GROUP_BASH" } } },
    death = { drops = "feral_maids_death_drops_broom" },
}

ccb.content.define_monster {
    id = "mon_feral_maid_candlestick",
    copy_from = "mon_feral_maid_broom",
    name = ccb.content.plural_text("feral servant", "feral servants"),
    description = ccb.content.text("Once a fancy servant of some rich family, this maniac walks around with a candlestick in hand, ready to snuff out your life."),
    attacks = {
        { id = "feral_weapon_candlestick" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    death = { drops = "feral_maids_death_drops_candlestick" },
}

ccb.content.define_monster {
    id = "mon_feral_maid_knife",
    copy_from = "mon_feral_maid_broom",
    name = ccb.content.plural_text("feral servant", "feral servants"),
    description = ccb.content.text("Once a fancy servant of some rich family, this maniac walks around with a knife in hand, searching for some victims to butcher."),
    melee_skill = 3,
    attacks = {
        { id = "feral_weapon_knife_chef" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    death = { drops = "feral_maids_death_drops_knife" },
}

ccb.content.define_monster {
    id = "mon_feral_fancy_rapier",
    copy_from = "mon_feral_maid_broom",
    name = ccb.content.plural_text("well dressed feral", "well dressed ferals"),
    description = ccb.content.text("Wearing fancy clothes and with a rapier in hand, this maniac was once a socialite.  They smile with madness and seem like they want to invite you to dinner."),
    melee_skill = 4,
    attacks = {
        { id = "feral_weapon_rapier" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT", cooldown = 400 },
    },
    death = { drops = "feral_fancy_death_drops_rapier" },
}

ccb.content.define_monster {
    id = "mon_feral_fancy_rapier_fake",
    copy_from = "mon_feral_fancy_rapier",
    name = ccb.content.plural_text("well dressed feral", "well dressed ferals"),
    description = ccb.content.text("Wearing fancy clothes and with a rapier in hand, this maniac was once a socialite.  They smile with madness and seem like they want to invite you to dinner."),
    attacks = {
        { id = "feral_weapon_rapier_fake" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT", cooldown = 400 },
    },
    death = { drops = "feral_fancy_death_drops_rapier_fake" },
}

-- No synthetic armor proficiency because plate armor doesn't work the same as modern armor
ccb.content.define_monster {
    id = "mon_feral_armored_mace",
    copy_from = "mon_feral_maid_broom",
    name = ccb.content.plural_text("armored feral", "armored ferals"),
    color = "i_magenta",
    description = ccb.content.text("Clad in ancient armor and with a mace in hand, this maniac walks around in search of their next prey.  You can see stains of dried blood all over their mace."),
    melee_skill = 3,
    speed = 75,
    attacks = {
        { id = "feral_weapon_mace" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT", cooldown = 600 },
    },
    armor = { bash = 20, cut = 20, stab = 15, bullet = 12 },
    inheritance = {
        add = {
            flags = { "LOUDMOVES", "BASHES", "GROUP_BASH" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
        },
        remove = { move_skills = { climb = 8 } },
    },
    death = { drops = "feral_armored_death_drops_mace" },
}

ccb.content.define_monster {
    id = "mon_feral_armored_battleaxe",
    copy_from = "mon_feral_armored_mace",
    color = "i_magenta",
    name = ccb.content.plural_text("armored feral", "armored ferals"),
    description = ccb.content.text("Clad in ancient armor and with a battle axe in hand, this maniac walks around in search of their next prey.  You can see stains of dried blood all over their axe."),
    attacks = {
        { id = "feral_weapon_battleaxe" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT", cooldown = 600 },
    },
    death = { drops = "feral_armored_death_drops_battleaxe" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_mace",
    name = ccb.content.plural_text("feral prepper", "feral preppers"),
    description = ccb.content.text("A quick glance at this person would suggest that they have prepared well enough for the apocalypse, with their armor equipped and some makeshift mace in their hands.  Unfortunately, their bloodshot eyes, and the excluding treatment by the undead, shows that they have turned feral."),
    copy_from = "mon_feral_human_pipe",
    aggression = 75,
    dodge = 3,
    vision_day = 50,
    attacks = { { id = "feral_weapon_mace_pipe" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_survivor",
    armor = { bash = 4, cut = 4, acid = 4, bullet = 4 },
    inheritance = {
        add = { weakpoint_sets = { "wps_humanoid_light_armor" }, families = { "prof_wp_syn_armored" } },
    },
    death = { drops = "mon_feral_prepper_mace_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_prepper_knife",
    copy_from = "mon_feral_prepper_mace",
    name = ccb.content.plural_text("feral prepper", "feral preppers"),
    description = ccb.content.text("A quick glance at this person would suggest that they have prepared well enough for the apocalypse, with their armor equipped and some military-grade knife in their hands.  Unfortunately, their bloodshot eyes, and the excluding treatment by the undead, shows that they have turned feral."),
    attacks = {
        { id = "feral_weapon_knife_combat_low_skill" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    death = { drops = "mon_feral_prepper_knife_death_drops" },
}

-- Due to the description I assumed a str 10 character instead of the standard str 8 as for the others
ccb.content.define_monster {
    id = "mon_feral_survivalist",
    name = ccb.content.plural_text("crazed survivalist", "crazed survivalists"),
    description = ccb.content.text("Grasping a sharp bladed weapon, this feral prepper has an athletic physique, a sign that they trained extensively before turning feral.  In addition to remembering how to use a flashlight, their survival instincts seem to kick in when critically harmed, causing them to act in self-preservation unlike most of their fellows."),
    copy_from = "mon_feral_human_pipe",
    hp = 90,
    speed = 110,
    aggression = 75,
    morale = 12,
    melee_skill = 6,
    dodge = 3,
    vision_day = 50,
    luminance = 500,
    attacks = { { id = "feral_weapon_makeshift_machete" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_survivor",
    fear_triggers = { "HURT" },
    armor = { bash = 4, cut = 4, acid = 4, bullet = 4, electric = 3 },
    inheritance = {
        add = {
            anger_triggers = { "STALK" },
            weakpoint_sets = { "wps_humanoid_light_armor" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { anger_triggers = { "HURT" } },
    },
    death = { drops = "mon_feral_survivalist_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_militia",
    name = ccb.content.plural_text("mad militia", "mad militias"),
    description = ccb.content.text("Wearing a tactical camo uniform with a Kevlar vest, this person seems to have been a militia member, now turned feral.  Their hands grip onto a semi-automatic rifle as their bloodshot eyes scan for threats; a flashlight strapped to their helmet illuminates their presence and surroundings."),
    copy_from = "mon_feral_human_pipe",
    difficulty_adjustment = 15,
    aggression = 75,
    morale = 20,
    melee_skill = 6,
    dodge = 3,
    vision_day = 50,
    luminance = 500,
    attacks = { { id = "feral_weapon_feral_militia_gun" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_milbase_personnel",
    fear_triggers = { "HURT" },
    armor = { bash = 5, cut = 7, acid = 5, bullet = 10, electric = 4 },
    inheritance = {
        add = {
            anger_triggers = { "STALK" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
        remove = { anger_triggers = { "HURT" } },
    },
    death = { drops = "mon_feral_militia_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_soldier",
    name = ccb.content.plural_text("feral soldier", "feral soldiers"),
    description = ccb.content.text("Wearing a military uniform with an armored vest, this person seems to be a highly trained military professional, now turned feral.  Tense, dirty hands grip a combat knife as their bloodshot eyes scan for threats."),
    copy_from = "mon_feral_human_pipe",
    speed = 85,
    aggression = 40,
    dodge = 4,
    vision_night = 5,
    attacks = { { id = "feral_weapon_knife_combat" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_soldier",
    armor = { bash = 4, cut = 9, bullet = 7, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "mon_feral_soldier_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_jackboot",
    name = ccb.content.plural_text("feral biker", "feral bikers"),
    description = ccb.content.text("A rough-looking feral human, clad in black leather and wielding a pump-action shotgun, that seems to be empty already.  It seems body-armor wasn't one of their priorities however."),
    copy_from = "mon_feral_human_pipe",
    aggression = 75,
    melee_skill = 6,
    vision_day = 50,
    attacks = { { id = "feral_weapon_shotgun_melee" } },
    death = { drops = "mon_feral_jackboot_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_swimmer_kickboard",
    name = ccb.content.plural_text("feral swimmer", "feral swimmers"),
    description = ccb.content.text("Clad in swimwear and with a stick in hand, this once normal person is now a bloodthirsty maniac."),
    copy_from = "mon_feral_human_pipe",
    color = "light_blue",
    attacks = { { id = "feral_weapon_stick" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_swimmer_base",
    death = { drops = "feral_swimmer_death_drops_kickboard" },
}

ccb.content.define_monster {
    id = "mon_feral_sailor_wrench",
    name = ccb.content.plural_text("feral crewman", "feral crewmen"),
    description = ccb.content.text("Clad in a grimy and tattered naval uniform, this former sailor clutches a massive wrench as some form of makeshift weapon.  At a distance, you could mistake them as being another survivor.  However, upon closer inspection you make note of how their veins are visibly bulging, their wide open eyes have a primal, animalistic quality to their gaze, and their breaths come in ragged, wheezing pants.  Whatever the Cataclysm has done to the military crewman that this twitching shell of their former self once was, you're certain that they're not fully human anymore."),
    copy_from = "mon_feral_human_pipe",
    color = "i_magenta",
    aggression = 40,
    dodge = 2,
    attacks = { { id = "feral_weapon_wrench_large" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_sailor",
    armor = { bash = 2, cut = 2, bullet = 2, electric = 2 },
    death = { drops = "mon_feral_sailor_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_sailor_axe",
    copy_from = "mon_feral_sailor_wrench",
    description = ccb.content.text("Spattered from head to toe in large swaths of dried viscera, the deep blue of this person's tattered naval uniform has been stained the color of rust.  Having seemingly had enough presence of mind to consider arming itself, this former crewman carries a crash axe in its shaking hands.  The veins on the back of their neck are visibly bulging, their eyes bloodshot, and a mass of crisscrossing blackened veins stand out against the pale skin of their face as they regard the area around them for perceived threats."),
    attacks = { { id = "feral_weapon_crash_axe" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    death = { drops = "mon_feral_sailor_axe_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_sailor_mop",
    copy_from = "mon_feral_sailor_wrench",
    description = ccb.content.text("Clutching a stout mop in their quivering hands, this crewman was presumably assigned to basic deck sweeping in their final moments, before the Cataclysm struck and stripped them of their humanity.  Dressed in basic naval fatigues, you'd be forgiven for believing them to be another survivor.  However, their bloodshot eyes, blackened veins, and spastic twitching tell a far different story."),
    attacks = { { id = "feral_weapon_mop_folded" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    death = { drops = "mon_feral_sailor_mop_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_sailor_lug_wrench",
    copy_from = "mon_feral_sailor_wrench",
    description = ccb.content.text("Still dressed in a grease spattered uniform, this crewman appears to have once been a naval engineer.  With tangled hair, oil stained working attire, and a lug wrench clenched in their fist, you assume that they were either assigned to shipside maintenance or responsible for servicing onboard aircraft.  Now all that's left of the crewman that this person once was is a madly twitching, psychopathic monster."),
    attacks = { { id = "feral_weapon_lug_wrench" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    death = { drops = "mon_feral_sailor_lug_wrench_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_marine_bayonet",
    name = ccb.content.plural_text("feral Marine", "feral Marines"),
    description = ccb.content.text("This twitching, bloodied person is still clad in a ragged Marine uniform, the insignia of the Marines visible on their coat and a corresponding tattoo on their forearm.  Clutching a rifle in their quivering hands, you see them repeatedly pull the weapon's trigger, constantly muttering incoherently and yanking back on the gun's charging handle every time the rifle fails to fire.  Seemingly having lost the capability to comprehend that their weapon is empty, you'd feel relatively safe were it not for the gleaming bayonet still attached to the end of their firearm."),
    copy_from = "mon_feral_human_pipe",
    speed = 85,
    aggression = 50,
    melee_skill = 4,
    dodge = 2,
    attacks = {
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "feral_weapon_feral_m4_carbine_bayonet" },
    },
    zombify_into = "mon_zombie_marine",
    armor = { bash = 4, cut = 6, bullet = 10 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "mon_feral_marine_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_officer",
    copy_from = "mon_feral_sailor_wrench",
    name = ccb.content.plural_text("feral officer", "feral officers"),
    description = ccb.content.text("This person, clad in the tattered uniform of a naval officer, twitches erratically as their bloodshot eyes dart about and their breaths come in ragged pants.  The Cataclysm has clearly done something horrible to this military professional, inaudible mutterings emanating from their lips as they creep about like a skittish animal.  In their quivering hands they clutch a service pistol, the officer's fingers nervously fidgeting with the weapon.  They may not be an undead corpse, but you doubt that they're any more rational than the zombies which now infest the world."),
    aggression = 30,
    morale = 25,
    color = "light_blue",
    dodge = 3,
    difficulty_adjustment = 4,
    attacks = { { id = "feral_weapon_m18" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_officer",
    death = { drops = "mon_feral_officer_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_cop",
    name = ccb.content.plural_text("feral cop", "feral cops"),
    description = ccb.content.text("Another of the crazed humans among the dead.  This police officer angrily mutters to themselves, wandering about with a truncheon in hand in search of someone to brutalize."),
    copy_from = "mon_feral_human_pipe",
    default_faction = "feral_police",
    speed = 95,
    color = "blue",
    aggression = 100,
    melee_skill = 6,
    dodge = 3,
    attacks = {
        { reference = "PARROT", cooldown = 200 },
        { reference = "BLOW_WHISTLE", cooldown = 25 },
        { id = "feral_weapon_PR24" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    fungalize_into = "mon_feral_cop_fungal_infected",
    zombify_into = "mon_zombie_cop",
    armor = { bash = 8, cut = 12, stab = 9, bullet = 14, electric = 2 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_open_helmet" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = { drops = "mon_feral_cop_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_cop_fungal_infected",
    copy_from = "mon_feral_cop",
    speed = 85,
    description = ccb.content.text("A maddened and crazed police officer infected by the fungus.  Their body armor is overgrown with fungal matter.  Though obviously in pain they don't seem any less keen to batter you to death with their baton."),
    inheritance = { add = { flags = { "NO_FUNG_DMG" }, species = { "FUNGUS" } } },
}

ccb.content.define_monster {
    id = "mon_feral_prisoner",
    name = ccb.content.plural_text("feral prisoner", "feral prisoners"),
    description = ccb.content.text("This frenzied prisoner has somehow avoided turning into one of the undead thus far, though seeing how zombies seem to ignore this shiv-wielding, blood-stained maniac, they are likely not far off from that fate."),
    copy_from = "mon_feral_human_pipe",
    melee_skill = 5,
    dodge = 3,
    attacks = { { id = "feral_weapon_shiv" }, { reference = "PARROT_AT_DANGER", cooldown = 0 } },
    zombify_into = "mon_zombie_prisoner",
    death = { drops = "feral_prisoner_death_drops" },
}

ccb.content.define_monster {
    id = "mon_feral_serum_user_locutus",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("This person, clad in the remnants of an orange jumpsuit, looks healthy.  Their eyes are bright, without any red markings; their hair has a pleasant shine; and their skin is practically glowing.  Only the twitching and the pipe held in one hand as they walk among the zombies would tell you that they've gone feral."),
    regenerates = 2,
    regeneration_modifiers = { onfire = -2, corroding = -2 },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_regen", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}

-- Much shorter half-life since Noonien both reduces healing and suppresses feelings of hunger
-- all melee damage is decreased by 10% with assumption it is at least `|/` broken
ccb.content.define_monster {
    id = "mon_feral_serum_user_noonien",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("Clad in the remnants of an orange jumpsuit, this feral swings a pipe as they walk.  They hold it in one hand and move it like it's a stick, despite the  fittings on the end that must be increasing its weight."),
    upgrade = { half_life = 90, monster_group = "GROUP_ZOMBIE_UPGRADE" },
    attacks = {
        { id = "smash", throw_strength = 20, cooldown = 25 },
        { id = "bio_op_takedown", cooldown = 15 },
        {
            id = "feral_weapon_pipe_mace",
            cooldown = 1,
            move_cost = 80,
            accuracy = 2,
            damage = { { type = "bash", amount = 18 } },
            avatar_hit = ccb.content.text("%1$s hits your %2$s with a pipe!"),
            npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a pipe!"),
            avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
            npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
            avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
            npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
            kind = "melee",
            when = "monster_attack_armed",
        },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    inheritance = { offset = { melee_skill = 2, melee_dice = 1, melee_sides = 2, dodge = 2 } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_super_soldier", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_serum_user_landru",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("With bloodshot eyes and a ripped orange jumpsuit, this obviously-feral human wanders among the undead.  Their movements are uncanny, almost like an old-fashioned camera film that's been sped up.  All of their motions are jerky and unfocused but they make them at blinding speed."),
    speed = 110,
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "feral_weapon_pipe", move_cost = 55 },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_speed", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_serum_user_armus",
    name = "feral test subject",
    description = "Despite the myriad rips and tears in this feral's orange jumpsuit, they don't have a single scratch on them.  Only their bloodshot eyes and the way the zombies ignore them indicate something is wrong.",
    copy_from = "mon_feral_human_pipe",
    bleed_rate = 0,
    death = {
        drops = {
            kind = "collection",
            items = {
                {
                    item = "serum_resilience",
                    probability = 30,
                    count = { 1, 3 },
                },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
    inheritance = {
        add = {
            attacks = {
                {
                    kind = "scripted",
                    id = "armus_user_armor",
                    range = 100,
                    allow_no_target = true,
                    cooldown = 1,
                    when = "w16b_mon_when_dda_faf89649dc5f",
                    action = "w16b_mon_act_dda_1cdaa456d5d6",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_serum_user_lore",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("Despite their bloodshot eyes, this feral exhibits a level of awareness not seen among most of their fellows.  Their eyes purposefully scan their surroundings for danger, they carry a homemade spear, and they wear a set of armor they've cobbled together from bits of riot armor and lab supplies.  The remnants of an orange jumpsuit are visible under their improvised armor."),
    dodge = 3,
    vision_day = 50,
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 }, { id = "feral_weapon_spear_knife" } },
    zombify_into = "mon_zombie_survivor",
    armor = { bash = 9, cut = 14, acid = 4, bullet = 18 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_learning", probability = 30, count = { 1, 3 } },
                { group = "feral_sapien_death_drops_spear", probability = 100 },
            },
        },
    },
}

-- No PARROT since Anaximander makes you silent
ccb.content.define_monster {
    id = "mon_feral_serum_user_anaximander",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("In light, this feral is clearly visible but they blend into the darkness like a ghost, despite the orange jumpsuit they still wear.  They don't seem to have any problems seeing in the dark either."),
    attacks = { { id = "feral_weapon_pipe" } },
    vision_night = 15,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_night_operations", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}
