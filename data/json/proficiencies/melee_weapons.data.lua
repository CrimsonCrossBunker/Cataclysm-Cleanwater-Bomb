local ccb = require("ccb")

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_rifles_familiar",
    category = "prof_combat",
    name = ccb.content.text("Long Gun CQC Familiarity"),
    description = ccb.content.text("You're familiar with how to grip a long gun correctly while striking someone with it."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_rifles_pro",
    category = "prof_combat",
    name = ccb.content.text("Long Gun CQC Proficiency"),
    description = ccb.content.text("You're proficient in striking with your rifle, both with and without a bayonet."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_auto_rifles_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_rifles_master",
    category = "prof_combat",
    name = ccb.content.text("Long Gun CQC Mastery"),
    description = ccb.content.text("You've mastered the art of the bayonet charge and know how to handle the gun itself as a weapon."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_auto_rifles_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_pistols_familiar",
    category = "prof_combat",
    name = ccb.content.text("Handgun CQC Familiarity"),
    description = ccb.content.text("You're able to use your handgun effectively as a melee weapon without shooting yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_pistols_pro",
    category = "prof_combat",
    name = ccb.content.text("Handgun CQC Proficiency"),
    description = ccb.content.text("You're proficient in striking with your handgun and can do so precisely."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_auto_pistols_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_auto_pistols_master",
    category = "prof_combat",
    name = ccb.content.text("Handgun CQC Mastery"),
    description = ccb.content.text("You're able to precisely strike your opponent with your handgun where it hurts the most."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_auto_pistols_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_knives_familiar",
    category = "prof_combat",
    name = ccb.content.text("Knife Familiarity"),
    description = ccb.content.text("You've got a handling on gripping knives so they don't slip out of your hand."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_knives_pro",
    category = "prof_combat",
    name = ccb.content.text("Knife Proficiency"),
    description = ccb.content.text("You handle your knife like a butcher, and are ready to prove it."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_knives_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_knives_master",
    category = "prof_combat",
    name = ccb.content.text("Knife Mastery"),
    description = ccb.content.text("Your knife is like an extension of yourself, you wield it effortlessly."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_knives_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_shivs_familiar",
    category = "prof_combat",
    name = ccb.content.text("Shiv Familiarity"),
    description = ccb.content.text("You know how to stab someone with something not typically intended to stab them with."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_shivs_pro",
    category = "prof_combat",
    name = ccb.content.text("Shiv Proficiency"),
    description = ccb.content.text("You're pretty good at shanking your enemy, if you do say so yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_shivs_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_shivs_master",
    category = "prof_combat",
    name = ccb.content.text("Shiv Mastery"),
    description = ccb.content.text("You've mastered the ancient and ignoble art of sticking someone with something small and pointy."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_shivs_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_batons_familiar",
    category = "prof_combat",
    name = ccb.content.text("Baton Familiarity"),
    description = ccb.content.text("You've learned to swing a baton without spraining your wrists."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_batons_pro",
    category = "prof_combat",
    name = ccb.content.text("Baton Proficiency"),
    description = ccb.content.text("You know how to strike with your baton so you get the most out of every blow."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_batons_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_batons_master",
    category = "prof_combat",
    name = ccb.content.text("Baton Mastery"),
    description = ccb.content.text("You've mastered the use of all kinds of batons, and the fine art of beating someone with a stick."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_batons_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_medium_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Medium Sword Familiarity"),
    description = ccb.content.text("You have enough practice not to cut yourself with your own blade."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_medium_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Medium Sword Proficiency"),
    description = ccb.content.text("The weight of your weapon feels as natural to you as if it were your own limb."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_medium_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_medium_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Medium Sword Mastery"),
    description = ccb.content.text("Your body has grown accustomed to the rigors of sword fighting, and can handle it for longer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_medium_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_short_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Short Sword Familiarity"),
    description = ccb.content.text("You understand how to swing a short blade around.  In theory, at least."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_short_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Short Sword Proficiency"),
    description = ccb.content.text("You've trained your body against the strain of fighting with a short sword."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_short_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_short_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Short Sword Mastery"),
    description = ccb.content.text("You're able to cut through zombies with the same ease you cut through foliage."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_short_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_quarterstaves_familiar",
    category = "prof_combat",
    name = ccb.content.text("Quarterstaff Familiarity"),
    description = ccb.content.text("You're familiar with how to handle your staff and can use it without knocking yourself out."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_quarterstaves_pro",
    category = "prof_combat",
    name = ccb.content.text("Quarterstaff Proficiency"),
    description = ccb.content.text("You're used to the balance of a staff and know how to handle it."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_quarterstaves_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_quarterstaves_master",
    category = "prof_combat",
    name = ccb.content.text("Quarterstaff Mastery"),
    description = ccb.content.text("You've mastered the use of quarterstaves.  Donatello would be proud."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_quarterstaves_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_fencing_weapons_familiar",
    category = "prof_combat",
    name = ccb.content.text("Fencing Weapon Familiarity"),
    description = ccb.content.text("You've got the basics of lunging and parrying your opponent."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_fencing_weapons_pro",
    category = "prof_combat",
    name = ccb.content.text("Fencing Weapon Proficiency"),
    description = ccb.content.text("You strike forth with ease after many hours of training."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_fencing_weapons_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_fencing_weapons_master",
    category = "prof_combat",
    name = ccb.content.text("Fencing Weapon Mastery"),
    description = ccb.content.text("Before the Cataclysm, you could have been an Olympic fencer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_fencing_weapons_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_claws_familiar",
    category = "prof_combat",
    name = ccb.content.text("Claw Weapon Familiarity"),
    description = ccb.content.text("You've learned how to use claw weapons in combat."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_claws_pro",
    category = "prof_combat",
    name = ccb.content.text("Claw Weapon Proficiency"),
    description = ccb.content.text("You're quite experienced with your claws by now."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_claws_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_claws_master",
    category = "prof_combat",
    name = ccb.content.text("Claw Weapon Mastery"),
    description = ccb.content.text("You feel as dangerous as a tiger with your claws."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_claws_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hooking_familiar",
    category = "prof_combat",
    name = ccb.content.text("Hooking Weapon Familiarity"),
    description = ccb.content.text("You're getting a hang of hooking your opponents with your weapon."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hooking_pro",
    category = "prof_combat",
    name = ccb.content.text("Hooking Weapon Proficiency"),
    description = ccb.content.text("You could probably unhorse someone with your weapon with your skills."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_hooking_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hooking_master",
    category = "prof_combat",
    name = ccb.content.text("Hooking Weapon Mastery"),
    description = ccb.content.text("You've mastered the art of knocking someone to the ground with your weapon."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_hooking_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_polearms_familiar",
    category = "prof_combat",
    name = ccb.content.text("Polearm Familiarity"),
    description = ccb.content.text("Dominant hand on the grip, the other on the haft, you're familiar with how to hold most polearms."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_polearms_pro",
    category = "prof_combat",
    name = ccb.content.text("Polearm Proficiency"),
    description = ccb.content.text("You know how to keep your enemies at a distance with a polearm, and are able to defend yourself with one."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_polearms_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_polearms_master",
    category = "prof_combat",
    name = ccb.content.text("Polearm Mastery"),
    description = ccb.content.text("You can handle the awkward balance of a polearm well, like it's an extension of your body."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_polearms_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionics_familiar",
    category = "prof_combat",
    name = ccb.content.text("Bionic Weapon Familiarity"),
    description = ccb.content.text("Your body is getting used to the stress your bionic weapons put on it."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionics_pro",
    category = "prof_combat",
    name = ccb.content.text("Bionic Weapon Proficiency"),
    description = ccb.content.text("You've become accustomed to the motions of your bionic weapons in combat."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_bionics_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionics_master",
    category = "prof_combat",
    name = ccb.content.text("Bionic Weapon Mastery"),
    description = ccb.content.text("Your bionic weapon feels as natural to you as your heartbeat."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_bionics_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_spears_familiar",
    category = "prof_combat",
    name = ccb.content.text("Spear Familiarity"),
    description = ccb.content.text("Non-dominant leg forward, you know the basics of impaling someone on a spear."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_spears_pro",
    category = "prof_combat",
    name = ccb.content.text("Spear Proficiency"),
    description = ccb.content.text("Whether you're hunting boar or hunting zombies, you know how to stab with your spear."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_spears_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_spears_master",
    category = "prof_combat",
    name = ccb.content.text("Spear Mastery"),
    description = ccb.content.text("You're in touch with your inner hunter-gatherer, able to keep up the hunt for longer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_spears_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_thrusting_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Long Thrusting Sword Familiarity"),
    description = ccb.content.text("You're no stranger to thrusting your sword through zombies."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_thrusting_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Long Thrusting Sword Proficiency"),
    description = ccb.content.text("You're able to gore someone on your sword like a pro."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_thrusting_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_thrusting_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Long Thrusting Sword Mastery"),
    description = ccb.content.text("You're a virtuoso with your sword, ready to deliver a swift and deadly thrust."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_thrusting_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_long_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Long Sword Familiarity"),
    description = ccb.content.text("You know how to swing a longsword without chopping off your own foot."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_long_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Long Sword Proficiency"),
    description = ccb.content.text("You're proficient with the use of long swords, and are deadly with one in your hands."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_long_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_long_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Long Sword Mastery"),
    description = ccb.content.text("You are a blade master of unparalleled skill.  And they said anime wasn't real."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_long_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionic_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Bionic Sword Familiarity"),
    description = ccb.content.text("You are able to operate your bionic sword without incident."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionic_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Bionic Sword Proficiency"),
    description = ccb.content.text("Your bionic sword proficiency is satisfactory.  You are able to use it without discomfort."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_bionic_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_bionic_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Bionic Sword Mastery"),
    description = ccb.content.text("Your capabilities with your bionic sword is the epitome of combat efficiency."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_bionic_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_flails_familiar",
    category = "prof_combat",
    name = ccb.content.text("Flail Familiarity"),
    description = ccb.content.text("You've learned how to hit your opponent instead of yourself with your flail."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_flails_pro",
    category = "prof_combat",
    name = ccb.content.text("Flail Proficiency"),
    description = ccb.content.text("You're able to swing your flail with deadly precision, crushing through ribs and skulls alike."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_flails_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_flails_master",
    category = "prof_combat",
    name = ccb.content.text("Flail Mastery"),
    description = ccb.content.text("You can make your flail dance like a ballerina, and hit like a truck."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_flails_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_maces_familiar",
    category = "prof_combat",
    name = ccb.content.text("Mace Familiarity"),
    description = ccb.content.text("You've got the gist of bludgeoning your enemies."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_maces_pro",
    category = "prof_combat",
    name = ccb.content.text("Mace Proficiency"),
    description = ccb.content.text("You swing your mace with dead efficiency."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_maces_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_maces_master",
    category = "prof_combat",
    name = ccb.content.text("Mace Mastery"),
    description = ccb.content.text("Your strikes with a mace shatter skulls and pulp brains."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_maces_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_swords_familiar",
    category = "prof_combat",
    name = ccb.content.text("Great Sword Familiarity"),
    description = ccb.content.text("You're not afraid to lift a heavy sword nor bring it down on someone's head."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_swords_pro",
    category = "prof_combat",
    name = ccb.content.text("Great Sword Proficiency"),
    description = ccb.content.text("You are not afraid to swing big with a heavy sword."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_great_swords_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_swords_master",
    category = "prof_combat",
    name = ccb.content.text("Great Sword Mastery"),
    description = ccb.content.text("You wield your blade like it was a modern day Caliburn."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_great_swords_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_hammers_familiar",
    category = "prof_combat",
    name = ccb.content.text("Great Hammer Familiarity"),
    description = ccb.content.text("You can handle a big ol' hammer without dropping it on your toes."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_hammers_pro",
    category = "prof_combat",
    name = ccb.content.text("Great Hammer Proficiency"),
    description = ccb.content.text("You're not afraid to put some muscle into it when you're swinging a hammer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_great_hammers_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_hammers_master",
    category = "prof_combat",
    name = ccb.content.text("Great Hammer Mastery"),
    description = ccb.content.text("You're a hammering juggernaut, ready to smash it all."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_great_hammers_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_axes_familiar",
    category = "prof_combat",
    name = ccb.content.text("Great Axe Familiarity"),
    description = ccb.content.text("You're not quite a professional lumberjack, but you can handle an axe."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_axes_pro",
    category = "prof_combat",
    name = ccb.content.text("Great Axe Proficiency"),
    description = ccb.content.text("You chop through bodies as easily as you chop through trees."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_great_axes_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_great_axes_master",
    category = "prof_combat",
    name = ccb.content.text("Great Axe Mastery"),
    description = ccb.content.text("You're a post-apocalyptic Paul Bunyan, but it's not just wood you're chopping."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_great_axes_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hand_axes_familiar",
    category = "prof_combat",
    name = ccb.content.text("Hand Axe Familiarity"),
    description = ccb.content.text("You know the proper technique to use with a hand axe."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hand_axes_pro",
    category = "prof_combat",
    name = ccb.content.text("Hand Axe Proficiency"),
    description = ccb.content.text("You know how to use a hatchet safely and effectively."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_hand_axes_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_hand_axes_master",
    category = "prof_combat",
    name = ccb.content.text("Hand Axe Mastery"),
    description = ccb.content.text("You're more than capable of using a hand axe to protect yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_hand_axes_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_unarmed_familiar",
    category = "prof_combat",
    name = ccb.content.text("Unarmed Technique Familiarity"),
    description = ccb.content.text("You know how to punch someone and make it hurt."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_unarmed_pro",
    category = "prof_combat",
    name = ccb.content.text("Unarmed Technique Proficiency"),
    description = ccb.content.text("You're able to pace yourself when you've got nothing else to fight with."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_unarmed_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_unarmed_master",
    category = "prof_combat",
    name = ccb.content.text("Unarmed Technique Mastery"),
    description = ccb.content.text("You're used to fighting with nothing and can fight unarmed for longer."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_unarmed_pro" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_whips_familiar",
    category = "prof_combat",
    name = ccb.content.text("Whip Familiarity"),
    description = ccb.content.text("You can crack a whip without hurting yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "800 s",
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_whips_pro",
    category = "prof_combat",
    name = ccb.content.text("Whip Proficiency"),
    description = ccb.content.text("You can use a whip to snuff out a candle from across the room without touching the wax."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.025 } } },
    time_to_learn = "1600 s",
    requires = { "prof_whips_familiar" },
}

-- Code assumes each attack is 1s
ccb.content.define_proficiency {
    id = "prof_whips_master",
    category = "prof_combat",
    name = ccb.content.text("Whip Mastery"),
    description = ccb.content.text("Your skill at hunting the living dead with a whip is unparalleled.  Make the Belmonts proud."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.2,
    bonuses = { melee_attack = { { attribute = "stamina", value = 0.05 } } },
    time_to_learn = "3200 s",
    requires = { "prof_whips_pro" },
}
