local ccb = require("ccb")

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
