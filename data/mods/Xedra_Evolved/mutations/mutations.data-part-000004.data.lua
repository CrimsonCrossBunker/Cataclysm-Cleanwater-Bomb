local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DHAMPIR_BLACKEN_SOUL_ARION",
    name = ccb.content.text_without_extraction("Blacken the Soul of Arion"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("You've gained the ability to create and mold a horse into a beast worthy of carrying you across the wastelands."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { dhampir_horse_familiar_spell = 1 },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_SUN_SENSITIVITY",
    name = ccb.content.text("Weakness: Sun Sensitivity"),
    points = -2,
    description = ccb.content.text("While you won't burn in the sunlight like a true vampire, it's not comfortable.  You suffer a -1 penalty to all stats when outdoors during the daytime, and an additional -2 if it's sunny or clear."),
    purifiable = false,
    valid = false,
    enchantments = {
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SENSITIVITY_0",
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SENSITIVITY_1",
    },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_SUN_SLEEPINESS",
    name = ccb.content.text("Weakness: Nocturnal"),
    points = -2,
    description = ccb.content.text("You aren't forced to slumber the day away, but you sure want to.  Your sleepiness accumulates much faster while the sun is in the sky, but you have an easier time sleeping during the day."),
    purifiable = false,
    valid = false,
    enchantments = {
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_0", "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_1",
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SLEEPINESS_2",
    },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_SLOW_HEALING",
    name = ccb.content.text("Weakness: Slow Healing"),
    points = -2,
    description = ccb.content.text("Being so close to death has slowed down the processes of your living cells considerably.  You heal at 50% of the normal rate."),
    purifiable = false,
    valid = false,
    enchantments = {
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_0", "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_1",
        "INLINE_ENCH_DHAMPIR_WEAKNESS_SLOW_HEALING_2",
    },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_ANIMAL_DISCORD",
    name = ccb.content.text("Weakness: Animal Hatred"),
    points = -2,
    description = ccb.content.text("Animals can sense your dead blood and they hate it.  They may run or be aggressive to you."),
    purifiable = false,
    valid = false,
    flags = { "ANIMALDISCORD2" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_WATER_PAIN",
    name = ccb.content.text("Weakness: Burned by Water"),
    points = -2,
    description = ccb.content.text("While running water is not deadly to you, it is uncomfortable.  Moving through running water without a boat will cause pain."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_DHAMPIR_WEAKNESS_WATER_PAIN_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR",
    name = ccb.content.text("Weakness: Corpselike Pallor"),
    points = -2,
    description = ccb.content.text("Your skin has the obviously-unnatural grayish-white tinge of a corpse, and mortals will react appropriately to seeing it."),
    purifiable = false,
    valid = false,
    visibility = 7,
    ugliness = 6,
    enchantments = { "INLINE_ENCH_DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_OVERWHELMING_ARROGANCE",
    name = ccb.content.text("Weakness: Overwhelming Arrogance"),
    points = -2,
    description = ccb.content.text("The vampires are right about one thing; they are better than humans, and your vampire blood makes you better as well."),
    purifiable = false,
    valid = false,
    social_modifiers = { persuade = -25, lie = -15 },
    flags = { "PSYCHOPATH" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_BLOODTHIRST",
    name = ccb.content.text("Weakness: Bloodlust"),
    points = -2,
    description = ccb.content.text("You have tasted blood and that taste forever lingers in the back of your mind.  You will get cravings for blood that only time or drinking more blood can sate."),
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD",
    name = ccb.content.text("Weakness: Thirst of the Damned"),
    points = -3,
    description = ccb.content.text("Fresh blood has an energy that mortal food simply cannot compare to.  You gain 33% reduced kcal from the food you eat, but additional calories from drinking blood."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN",
    name = ccb.content.text("Weakness: Decreased Blood Empowerment"),
    points = -2,
    description = ccb.content.text("The power of fresh stolen blood lingers in your veins.  The natural rate that your blood empowers itself is cut in half."),
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "DHAMPIR_WEAKNESS_BURNED_BY_THE_SUN",
    name = ccb.content.text("Weakness: Sun-Seared"),
    points = -5,
    description = ccb.content.text("Your tainted blood flows so strongly that you have inherited the vampire's vulnerability to sunlight.  Unless you cover any exposed flesh, the sun will burn you slowly to ash."),
    purifiable = false,
    valid = false,
    flags = { "SUNBURN" },
}

-- Unless you attack them or are the ultimate vampire killer, vampires and renfields won't attack you as your blood holds no interest for them.
ccb.content.define_mutation {
    id = "VAMPIRE",
    name = ccb.content.text("Infected with the vampire disease"),
    points = 0,
    description = ccb.content.text("You have developed a thirst for the blood of your fellow humans."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_intervals = { human_blood_vitamin = 720, mutagen = 300 },
    no_empathize_with = { "HUMAN" },
    flags = { "CANNIBAL", "HEMOVORE" },
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    enchantments = { "INLINE_ENCH_VAMPIRE_0", "INLINE_ENCH_VAMPIRE_1" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "VAMPIRE_TRUCE",
    name = ccb.content.text_without_extraction("Vampire's Truce"),
    description = ccb.content.text_without_extraction("The hidden trait that makes other vampires not attack you first.  It should be hidden."),
    points = 1,
    valid = false,
    purifiable = false,
    player_display = false,
    ignored_by = { "VAMPIRE", "RENFIELD" },
}

-- true
ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_ARTS",
    name = ccb.content.text("Blood Arts"),
    points = 1,
    description = ccb.content.text("This provides the school trait for vampire blood powers.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
}
