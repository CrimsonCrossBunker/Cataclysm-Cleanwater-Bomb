local ccb = require("ccb")

ccb.content.define_item {
    id = "mana_potion_lesser",
    name = ccb.content.plural_text("lesser mana potion", "lesser mana potions"),
    description = ccb.content.text("You can't buy these, so you need to save them until the last boss!  Actually, don't even use them there!"),
    mass = "265 g",
    volume = "250ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "light_blue",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE", "SINGLE_USE" },
    phase = "liquid",
    price = "25 USD",
    comestible = { quench = 1, calories = 0, servings = 1, fun = -1, kind = "MED", freezing_point = 4 },
    use_actions = { { kind = "cast_spell", spell = "potion_recover_mana", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "mana_potion",
    name = ccb.content.plural_text("mana potion", "mana potions"),
    copy_from = "mana_potion_lesser",
    price = "100 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "potion_recover_mana", no_fail = true, level = 5 } },
}

ccb.content.define_item {
    id = "mana_potion_greater",
    name = ccb.content.plural_text("greater mana potion", "greater mana potions"),
    copy_from = "mana_potion_lesser",
    price = "300 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "potion_recover_mana", no_fail = true, level = 15 } },
}

ccb.content.define_item {
    id = "cats_grace_potion",
    name = ccb.content.plural_text("potion of Cat's Grace", "potions of Cat's Grace"),
    description = ccb.content.text("This is a potion of Cat's Grace.  It will increase your dexterity for 50 minutes."),
    copy_from = "mana_potion_lesser",
    color = "yellow",
    price = "30 USD",
    comestible = { calories = 25 },
    use_actions = { { kind = "cast_spell", spell = "cats_grace", no_fail = true, level = 25 } },
}

ccb.content.define_item {
    id = "ogres_strength_potion",
    name = ccb.content.plural_text("potion of Ogre's Strength", "potions of Ogre's Strength"),
    description = ccb.content.text("This is a potion of Ogre's Strength.  It will increase your strength for 50 minutes."),
    color = "yellow",
    copy_from = "mana_potion_lesser",
    comestible = { calories = 50 },
    use_actions = { { kind = "cast_spell", spell = "ogres_strength", no_fail = true, level = 25 } },
}

ccb.content.define_item {
    id = "eagles_sight_potion",
    name = ccb.content.plural_text("potion of Eagle's Sight", "potions of Eagle's Sight"),
    description = ccb.content.text("This is a potion of Eagle's Sight.  It will increase your perception for 50 minutes."),
    color = "yellow",
    copy_from = "mana_potion_lesser",
    comestible = { calories = 17 },
    use_actions = { { kind = "cast_spell", spell = "eagles_sight", no_fail = true, level = 25 } },
}

ccb.content.define_item {
    id = "foxs_cunning_potion",
    name = ccb.content.plural_text("potion of Fox's Cunning", "potions of Fox's Cunning"),
    description = ccb.content.text("This is a potion of Fox's Cunning.  It will increase your intelligence for 50 minutes."),
    color = "yellow",
    copy_from = "mana_potion_lesser",
    comestible = { calories = 56 },
    use_actions = { { kind = "cast_spell", spell = "foxs_cunning", no_fail = true, level = 25 } },
}

ccb.content.define_item {
    id = "flask_clairvoyance",
    name = ccb.content.plural_text("potion of clairvoyance", "potions of clairvoyance"),
    description = ccb.content.text("Close your eyes and see."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 86 },
    use_actions = { { kind = "cast_spell", spell = "flask_clairvoyance", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_spear",
    name = ccb.content.plural_text("\"Spear in the flask\"", "\"Spear in the flask\""),
    description = ccb.content.text("Use it to penetrate everything in line of sight"),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_spear", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_confusion",
    name = ccb.content.plural_text("potion of instability", "potions of instability"),
    description = ccb.content.text("A potion that temporarily freezes the higher brain activity for a while.  It was banned by the government due to popularity in the criminal sphere, but some people still know the recipe."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_confusion", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_teleport_rand",
    name = ccb.content.plural_text("potion of escape", "potions of escape"),
    description = ccb.content.text("Get out of jail free card for each who care about his life."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 220 },
    use_actions = { { kind = "cast_spell", spell = "flask_teleport_rand", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_teleport",
    name = ccb.content.plural_text("potion of teleportation", "potions of teleportation"),
    description = ccb.content.text("Important part of every professional robber's kit.  It was banned by the government due to the popularity in criminal sphere, but some people still know the recipe."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 260 },
    use_actions = { { kind = "cast_spell", spell = "flask_teleport", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_shadow_field",
    name = ccb.content.plural_text("potion of shadows", "potions of shadows"),
    description = ccb.content.text("No one really knows why it was created, but it can be useful in some situations"),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_shadow_field", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_fireball",
    name = ccb.content.plural_text("\"Fire in the flask\"", "\"Fire in the flask\""),
    description = ccb.content.text("They were really useful in middle ages, but the price was too high, and they were supplanted with another incendiary weapon and, long after, with Molotov cocktails."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_fireball", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_invisibility",
    name = ccb.content.plural_text("potion of invisibility", "potions of invisibility"),
    description = ccb.content.text("Make you totally invisible, except in mana spectrum.  It was banned by the government due to the popularity in crime sphere, but some people still know the recipe."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 77 },
    use_actions = { { kind = "cast_spell", spell = "flask_invisibility", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_healing",
    name = ccb.content.plural_text("potion of healthiness", "potions of healthiness"),
    description = ccb.content.text("Classical medicine, used from ancient times, that came to us with almost no changes.  Allows you to heal the common illness way faster than before."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 358 },
    use_actions = { { kind = "cast_spell", spell = "flask_healing", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_feather",
    name = ccb.content.plural_text("potion of lesser gravity control", "potions of lesser gravity control"),
    description = ccb.content.text("Allow user to survive the fall from any height.  Sadly, the required preparation and effect's weakness do not allow to use it for climbing protection."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 57 },
    use_actions = { { kind = "cast_spell", spell = "flask_feather", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_night_vision",
    name = ccb.content.plural_text("potion of night vision", "potions of night vision"),
    description = ccb.content.text("Designed by Occult Coalition sorcerers, this potion was fairly popular inside the special operation forces and in the hunting communities."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 56 },
    use_actions = { { kind = "cast_spell", spell = "flask_night_vision", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_charm",
    name = ccb.content.plural_text("potion of domination", "potions of domination"),
    description = ccb.content.text("Rearrange neural activity of the creature to be 100% loyal to a blood owner.  It was banned by the government due to the popularity in crime sphere, but some people still know the recipe."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 21 },
    use_actions = { { kind = "cast_spell", spell = "flask_charm", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_sludge_field",
    name = ccb.content.plural_text("potion of slippery splash", "potions of slippery splash"),
    description = ccb.content.text("At first only an insignificant spell designed to trap and kill small bugs and rodents, someone found it pretty useful in a real fight and improved it with that goal in mind."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_sludge_field", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_speed",
    name = ccb.content.plural_text("potion of sprint", "potions of sprint"),
    description = ccb.content.text("They count as doping in Olympic games.  Luckily you are not in a stadium."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 26 },
    use_actions = { { kind = "cast_spell", spell = "flask_speed", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_stamina",
    name = ccb.content.plural_text("potion of iron lungs", "potions of iron lungs"),
    description = ccb.content.text("Old recipe, used to increase the user's endurance.  The diluted version was used by different armies for fast and long forced marches."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 156 },
    use_actions = { { kind = "cast_spell", spell = "flask_stamina", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_rebreather",
    name = ccb.content.plural_text("potion of water breathing", "potions of water breathing"),
    description = ccb.content.text("An old marine recipe, that saved a lot of shipwreck victim lives."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 121 },
    use_actions = { { kind = "cast_spell", spell = "flask_rebreather", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_excitement",
    name = ccb.content.plural_text("potion of stimulus", "potions of stimulus"),
    description = ccb.content.text("One among a variety of potions designed to make a person stronger on the battlefield.  Sharpens the user's senses and improves reaction time, increasing their ability to fight in melee."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 89 },
    use_actions = { { kind = "cast_spell", spell = "flask_excitement", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_resistance",
    name = ccb.content.plural_text("potion of iron skin", "potions of iron skin"),
    description = ccb.content.text("Harden the user's skin, and allow taking more damage with no harm.  Was popular in ancient armies, but now mostly forgotten."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 211 },
    use_actions = { { kind = "cast_spell", spell = "flask_resistance", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_illumination",
    name = ccb.content.plural_text("potion of illumination", "potions of illumination"),
    description = ccb.content.text("A potion designed during the 19th century and popular among miners wishing to avoid the dangers of explosive gas leaks underground.  It is less popular these days due to the abundance of electric lighters, but still sees occasional use."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 7 },
    use_actions = { { kind = "cast_spell", spell = "flask_illumination", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_mana_regen",
    name = ccb.content.plural_text("potion of mana regeneration", "potions of mana regeneration"),
    description = ccb.content.text("Attract the ley-lines to user, increasing the natural mana regeneration."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 66 },
    use_actions = { { kind = "cast_spell", spell = "flask_mana_regen", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_max_mana",
    name = ccb.content.plural_text("potion of mana reserves", "potions of mana reserves"),
    description = ccb.content.text("Splay user's ley-lines, what allow them to use more mana than they usually can."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 76 },
    use_actions = { { kind = "cast_spell", spell = "flask_max_mana", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_regeneration",
    name = ccb.content.plural_text("potion of regeneration", "potions of regeneration"),
    description = ccb.content.text("Start a long-term spell sequence, that increase your regeneration abilities."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 344 },
    use_actions = { { kind = "cast_spell", spell = "flask_regeneration", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_mood",
    name = ccb.content.plural_text("potion of happiness", "potions of happiness"),
    description = ccb.content.text("Closer to an alcoholic drink than a potion, this mixture makes your brain feel constant happiness, ignoring the whole boredom of reality.  It causes no addiction, but is still banned in some countries, including the USA (except in Texas and New Hampshire, where it's just frowned upon)."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 65 },
    use_actions = { { kind = "cast_spell", spell = "flask_mood", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_toxin",
    name = ccb.content.plural_text("potion of toxin", "potions of toxin"),
    description = ccb.content.text("Spread a low lethal toxin on your enemies.  It's surprisingly effective, if you have enough time."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_toxin", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "flask_venom",
    name = ccb.content.plural_text("potion of venom", "potions of venom"),
    description = ccb.content.text("Concentrated potion, teleported right in the enemy body - fast, painful, and guarantee death."),
    copy_from = "mana_potion_lesser",
    price = "400 USD",
    comestible = { calories = 0 },
    use_actions = { { kind = "cast_spell", spell = "flask_venom", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "animist_doll_zombie",
    name = ccb.content.plural_text("zombie voodoo doll", "zombie voodoo dolls"),
    description = ccb.content.text("A remarkably accurate effigy of an undead human, including pieces of bone and organs.  Necromantic magic delays immediate rot, but it won't last forever.  Piercing it with the attached needle could compel it to serve you."),
    category = "weapons",
    materials = { "leather", "flesh", "bone" },
    mass = "225 g",
    volume = "700 ml",
    symbol = "t",
    color = "pink",
    flags = { "TRADER_AVOID", "INEDIBLE", "NUTRIENT_OVERRIDE" },
    comestible = { kind = "FOOD", shelf_life = "4 days", vitamins = { { id = "meat_allergen", amount = 1 } } },
    use_actions = { { kind = "cast_spell", spell = "summon_zombie_brute", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "animist_doll_skeleton",
    name = ccb.content.plural_text("ossified voodoo doll", "ossified voodoo dolls"),
    description = ccb.content.text("A remarkably accurate effigy of an undead human covered with bone, including pieces of organs.  Necromantic magic delays immediate rot, but it won't last forever.  Piercing it with the attached needle could compel it to serve you."),
    category = "weapons",
    copy_from = "animist_doll_zombie",
    comestible = {},
    use_actions = { { kind = "cast_spell", spell = "summon_skeleton_brute", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "animist_doll_decayed_pouncer",
    name = ccb.content.plural_text("cougar voodoo doll", "cougar voodoo dolls"),
    description = ccb.content.text("A remarkably accurate effigy of an undead cougar, complete with fur, bones, and organs.  Necromantic magic delays immediate rot, but it won't last forever.  Piercing it with the attached needle could compel it to serve you."),
    category = "weapons",
    materials = { "fur", "flesh", "bone" },
    copy_from = "animist_doll_skeleton",
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    use_actions = { { kind = "cast_spell", spell = "summon_zougar", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "twisted_restore_potion",
    name = ccb.content.plural_text("potion of Twisted Restoration", "potions of Twisted Restoration"),
    description = ccb.content.text("This foul-smelling liquid simulates undead regeneration by accelerating your heart to dangerous levels.  Drinking this in danger or at critical condition may be lethal."),
    mass = "265 g",
    volume = "250ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "brown",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    phase = "liquid",
    price = "25 USD",
    comestible = {
        quench = -30,
        calories = 100,
        servings = 5,
        fun = -5,
        healthy = -1,
        shelf_life = "5 days",
        kind = "DRINK",
        freezing_point = -12,
    },
    use_actions = { { kind = "cast_spell", spell = "twisted_restore", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "twisted_restore_potion_improved",
    name = ccb.content.plural_text("potion of Improved Twisted Restoration", "potions of Improved Twisted Restoration"),
    description = ccb.content.text("This foul-smelling liquid simulates undead regeneration by accelerating your heart to dangerous levels.  Drinking this in danger or at critical condition may be lethal.  Improved infusion techniques lessen the strain of the process."),
    copy_from = "twisted_restore_potion",
    comestible = {},
    use_actions = { { kind = "cast_spell", spell = "twisted_restore_improved", no_fail = true, level = 1 } },
}
