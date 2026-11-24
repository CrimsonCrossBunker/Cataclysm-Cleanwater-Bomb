local ccb = require("ccb")

ccb.content.define_mutation {
    id = "EGGSAC_SURVIVABLE",
    name = ccb.content.text_without_extraction("Spider egg host"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "EGGSAC_FATAL",
    name = ccb.content.text_without_extraction("Spider egg host"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "DREAMLESS",
    name = ccb.content.text("Dreamless"),
    points = -1,
    starting_trait = true,
    valid = false,
    description = ccb.content.text("You live firmly in reality and never experience extremely vivid dreams about choices that have real world consequences.  ( You will be unable to gain Dream magicks from sleeping after strange events)"),
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
}

ccb.content.define_mutation {
    id = "MANIFEST_DESTINY_GOBLIN",
    name = ccb.content.text_without_extraction("Transforming into Goblin"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "MANIFESTED_DESTINY_GOBLIN",
    name = ccb.content.text("Transformed into Goblin"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You feel like you've left behind your old life and form."),
}

ccb.content.define_mutation {
    id = "MANIFEST_DESTINY_SPIDER",
    name = ccb.content.text_without_extraction("Transforming into Spider"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "MANIFESTED_DESTINY_SPIDER",
    name = ccb.content.text("Transformed into Spider"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You feel like you've left behind your old life and form."),
}

ccb.content.define_mutation {
    id = "DRUNKEN",
    name = ccb.content.text("Drunken Master"),
    points = 1,
    description = ccb.content.text("The ancient arts of drunken brawling come naturally to you!  While under the influence of alcohol, your melee skill will rise considerably, especially unarmed combat."),
    starting_trait = true,
    valid = false,
    cancels = { "LIGHTWEIGHT" },
    enchantments = { "DRUNKEN_ARMED", "DRUNKEN_UNARMED" },
}

ccb.content.define_mutation {
    id = "KI_STRIKE",
    name = ccb.content.text("Ki Strike"),
    points = 2,
    description = ccb.content.text("Who needs weapons?  You deal more melee damage while fighting barehanded and without gloves.  This damage improves as your unarmed skill increases."),
    starting_trait = true,
    valid = false,
    enchantments = { "KI_STRIKE" },
}

-- For now life extenders such as this one grant MEND_ALL.  When the new wound system will be implemented, their function will be to always allow you to fully heal from your wounds (no scars, etc).
ccb.content.define_mutation {
    id = "EXTEND_LIFE",
    name = ccb.content.text("Extended Life"),
    points = 10,
    description = ccb.content.text("You swallow the potion and feel younger already.  Though the taste lingers long past when you'd hope it would pass."),
    valid = false,
    flags = { "MEND_ALL" },
}

ccb.content.define_mutation {
    id = "NIGHTMARE_CHIMERAS",
    name = ccb.content.text_without_extraction("Haunted by your dreams made flesh"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Your dreams can change reality."),
    vitamin_intervals = { dream = -8640000 },
}

ccb.content.define_mutation {
    id = "FRIENDLY_CHIMERAS",
    name = ccb.content.text_without_extraction("Accompanied by your dreams made flesh"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Your dreams can change reality."),
    vitamin_intervals = { dream = -8640000 },
}

ccb.content.define_mutation { id = "INFRESIST", copy_from = "INFRESIST", add = { categories = { "LILIN" } } }

ccb.content.define_mutation { id = "INFIMMUNE", copy_from = "INFIMMUNE", add = { categories = { "LILIN" } } }

ccb.content.define_mutation { id = "DEFT", copy_from = "DEFT", add = { categories = { "LILIN" } } }

ccb.content.define_mutation {
    id = "GENERIC_UNCANNY_DODGE_TRAIT",
    name = ccb.content.text_without_extraction("The Trait That Gives you Uncanny Dodge"),
    description = ccb.content.text_without_extraction("The uncanny dodge flag now works in effects, but preserve this trait for conditional logic such as with lilin."),
    points = 1,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    flags = { "UNCANNY_DODGE" },
}

-- Dhampirs not getting Cannibal is deliberate.  The struggle over their own humanity is a core part of the dhampir theme.
ccb.content.define_mutation {
    id = "DHAMPIR_TRAIT",
    name = ccb.content.text("Dhampir"),
    points = 0,
    description = ccb.content.text("You are a dhampir, the child of a vampire.  You have inherited a portion of their vampiric power, as well as the ability to drink blood.  Hopefully you can keep your urges under control.\n\nAs a dhampir, your blood naturally slowly fills with power over time, which you can use to fuel your abilities."),
    types = { "HERITAGE" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    mixed_effect = true,
    vitamin_intervals = { mutagen = 600, mutagenic_slurry = 1 },
    enchantments = {
        "INLINE_ENCH_DHAMPIR_TRAIT_0", "INLINE_ENCH_DHAMPIR_TRAIT_1", "INLINE_ENCH_DHAMPIR_TRAIT_2",
        "INLINE_ENCH_DHAMPIR_TRAIT_3", "INLINE_ENCH_DHAMPIR_TRAIT_4", "INLINE_ENCH_DHAMPIR_TRAIT_5",
    },
    flags = { "HEMOVORE", "HERITAGE" },
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_DETECT_VAMPIRES",
    name = ccb.content.text("Blood Calls to Blood"),
    points = 1,
    description = ccb.content.text("You can use the connection of your heritage to sense nearby vampires and their minions."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You open your senses to the presence of the night-hunters."),
    enchantments = { "INLINE_ENCH_DHAMPIR_DETECT_VAMPIRES_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_FANGS",
    name = ccb.content.text("Dhampir Fangs"),
    points = 1,
    description = ccb.content.text("You have a set of small fangs, not as long as a true vampire's, but on the other hand, you can retract them to more easily conceal them.  Activate to extend your fangs."),
    types = { "TEETH" },
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your fangs lengthen."),
    enchantments = { "INLINE_ENCH_DHAMPIR_FANGS_0" },
    on_activate = "enable_dhampir_fangs",
    on_deactivate = "disable_dhampir_fangs",
}

ccb.content.define_mutation {
    id = "DHAMPIR_FANGS_ACTIVE",
    name = ccb.content.text_without_extraction("Dhampir Fangs on"),
    points = 0,
    visibility = 1,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Fang on!"),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { vampire_drink_blood_with_fangs_spell = 1 },
}

ccb.content.define_mutation {
    id = "DHAMPIR_REDUCED_COLD_TEMPS",
    name = ccb.content.text("Cold as the Grave"),
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your half-dead flesh is inured to winter's chill.  As long as you have empowered blood in your body, you suffer much less from colder temperatures."),
    enchantments = { "INLINE_ENCH_DHAMPIR_REDUCED_COLD_TEMPS_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_RESIST_DISEASE_POISON_INFECTION",
    name = ccb.content.text("One Foot in the Grave"),
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The deathly energies that course through your veins are inimical to mundane poisons and diseases.  As long as you have empowered blood in your body, you are more resistant to disease, poison, and infection."),
    enchantments = { "INLINE_ENCH_DHAMPIR_RESIST_DISEASE_POISON_INFECTION_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_SLOWFALL",
    name = ccb.content.text("Light as the Last Breath"),
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("While unable to ignore gravity like a true vampire, it has less of a hold on you.  You can fall one story without ill effect and take greatly-reduced fall damage as long as you have empowered blood in your body."),
    enchantments = { "INLINE_ENCH_DHAMPIR_SLOWFALL_0" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_REDUCED_PAIN",
    name = ccb.content.text("Half-Dead Flesh"),
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Being born closer to death, you feel the sensations of the living less strongly.  You suffer much less pain from your injuries than a human would, and the pain affects your capabilities less."),
    enchantments = { "INLINE_ENCH_DHAMPIR_REDUCED_PAIN_0" },
}

-- This should prevent permanent damage from wounds, once that's possible.
ccb.content.define_mutation {
    id = "DHAMPIR_MEND_WOUNDS_FASTER",
    name = ccb.content.text("A Thousand Years of Night"),
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You are only half-alive now, sustained as much by the energy in your blood as by biological processes.  You age far slower than a mortal, and when your limbs break, they heal more quickly in proportion to how much empowered blood you have."),
    enchantments = { "INLINE_ENCH_DHAMPIR_MEND_WOUNDS_FASTER_0" },
    flags = { "MEND_ALL" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
    name = ccb.content.text("The Blood is the Life"),
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("While you must normally eat, sleep, and drink as a mortal must, in times of need you can put that off.  Activate this trait to reduce your need for food, water, and sleep to zero.  While active, the Blood is the Life will continually expend the power in your blood, and when it wears off, you will become exhausted in proportion to how long the trait was active.  You spend <color_yellow>much more blood</color> if outdoors in the sunlight.\n\n<color_light_red>Initial Blood Cost:</color> 1 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 1 ml per minute"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You draw on the power in your blood to stave off mortal needs."),
    on_activate = "dhampir_avoid_needs_on",
    on_process = "dhampir_avoid_needs_process",
    on_deactivate = "dhampir_avoid_needs_off",
    enchantments = { "INLINE_ENCH_DHAMPIR_AVOID_EAT_SLEEP_DRINK_0" },
}

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

ccb.content.define_mutation {
    id = "EYEGLEAM",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Gleaming Eyes"),
    description = ccb.content.text("Your eyes gleam lightly red as the light catches in them and with a few drops of the stolen blood in your veins you are able to see in the dark.\n\n<color_light_red>Initial Blood Cost:</color> 100 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 50 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_eyegleam_on",
    on_deactivate = "vampire_eyegleam_off",
    enchantments = {
        "INLINE_ENCH_EYEGLEAM_0",
        "INLINE_ENCH_EYEGLEAM_1",
    },
}

ccb.content.define_mutation {
    id = "BLOOD_FUN",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Ecstasy"),
    description = ccb.content.text("Your palate adapted to your new condition.  Drinking human blood will make you feel great."),
}

ccb.content.define_mutation {
    id = "VAMPIRIC_STRENGTH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Vigor Mortis"),
    description = ccb.content.text("Your stolen blood reinforces your muscles, making your grip crack bone and your punches dent steel.\n\n<color_light_red>Initial Blood Cost:</color> 150 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 75 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You feel a surge of power as blood floods your muscles."),
    on_activate = "vampire_strength_on",
    on_deactivate = "vampire_strength_off",
    enchantments = { "INLINE_ENCH_VAMPIRIC_STRENGTH_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRIC_RESILIENCE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Resilience"),
    description = ccb.content.text("Your cold flesh is not as vulnerable as it once was.  Activate to render it even more resistant to physical damage.\n\n<color_light_red>Initial Blood Cost:</color> 150 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 75 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_resilience_on",
    on_deactivate = "vampire_resilience_off",
    enchantments = {
        "INLINE_ENCH_VAMPIRIC_RESILIENCE_0",
        "INLINE_ENCH_VAMPIRIC_RESILIENCE_1",
    },
    active_flags = { "SUNBURN_SUPERNATURAL_REDUCTION" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_HEIGHTENED_SENSES",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Predator's Senses"),
    description = ccb.content.text("Your senses are heightened, allowing you to see more clearly, hear even tiny sounds, and smell nearby fresh human blood."),
    spells_learned = { vampire_smell_nearby_blood_spell = 1 },
    enchantments = {
        "ench_vampire_heightened_senses_hearing", "ench_vampire_heightened_senses_perception",
        "INLINE_ENCH_VAMPIRE_HEIGHTENED_SENSES_2",
    },
}

ccb.content.define_mutation {
    id = "VAMPIRE_HEALTH_BONUS",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blush of Health"),
    description = ccb.content.text("The power of stolen blood keeps you feel amazing.  As long as you are not suffering from the Withering, you gain a bonus to your health."),
    enchantments = { "INLINE_ENCH_VAMPIRE_HEALTH_BONUS_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SILENT_MOVE",
    points = 1,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Silent as Death"),
    description = ccb.content.text("Your movements don't make nearby as much noise as they used to."),
    enchantments = { "INLINE_ENCH_VAMPIRE_SILENT_MOVE_0" },
}

ccb.content.define_mutation {
    id = "STAMINAFORBLOOD",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Unholy Endurance"),
    description = ccb.content.text("Your exhaust some of the blood in your veins to boost and recover some of your spent stamina."),
    spells_learned = { vampire_stamina_for_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "COMMUNE_NIGHT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Learn from the Children of the Night"),
    description = ccb.content.text("You call out to the creatures that inhabit the night.  Wolves, bats, rats and more.  They tell you about what terrain surrounds you."),
    spells_learned = { vampire_commune_with_night_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sense the Children of the Night"),
    description = ccb.content.text("You can sense the presence of nearby predatory night creatures."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You open your senses to the children of the night."),
    enchantments = { "INLINE_ENCH_VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE2",
    name = ccb.content.text("Walking the shadowed path of blood"),
    points = 0,
    description = ccb.content.text("You have new fangs to go along with your thirst for blood."),
    starting_trait = false,
    purifiable = false,
    types = { "TEETH" },
    valid = false,
    vitamin_intervals = { human_blood_vitamin = 720, mutagen = 300, mutagenic_slurry = 1 },
    flags = { "CANNIBAL", "HEMOVORE" },
    enchantments = { "INLINE_ENCH_VAMPIRE2_0" },
    spells_learned = { vampire_drink_blood_with_fangs_spell = 1 },
}

ccb.content.define_mutation {
    id = "COAGULANTWEAVE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Coagulant Weave"),
    description = ccb.content.text("Your body prepares to prevent the loss of any blood to combat damage.\n\n<color_light_red>Initial Blood Cost:</color> 500 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 250 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You hold tightly to your blood, preventing it from leaving your body."),
    on_activate = "vampire_coagulantweave_on",
    on_deactivate = "vampire_coagulantweave_off",
}

ccb.content.define_mutation {
    id = "BLOODHEAL",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Restoration"),
    description = ccb.content.text("Your flesh heals visibly while blood disintegrates hidden inside your veins."),
    spells_learned = { spell_blood_heal = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRIC_DODGE",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Flow Like Blood"),
    description = ccb.content.text("You can move faster than the eye can see, avoiding the claws and teeth and weapons of your enemies.\n\n<color_light_red>Initial Blood Cost:</color> 250 (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 125 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You begin dodging with preternatural agility."),
    on_activate = "vampire_dodge_on",
    on_deactivate = "vampire_dodge_off",
    enchantments = { "INLINE_ENCH_VAMPIRIC_DODGE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRIC_STEALTH_BONUS",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Cloak of Shadows"),
    description = ccb.content.text("When indoors or at night, you can cloud the minds of nearby enemies, making it harder for them to spot you.  This does not make you invisible.\n\n<color_light_red>Initial Blood Cost:</color> 100 (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 50 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You fade slightly into the shadows."),
    on_activate = "vampire_stealth_on",
    on_deactivate = "vampire_stealth_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_FEAR_GAZE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Predator's Mien"),
    description = ccb.content.text("With a bit of stolen blood and a savage expression, you can send your enemies fleeing."),
    spells_learned = { vampire_fear_gaze_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_FEIGN_DEATH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Corpse's Countenance"),
    description = ccb.content.text("You are close enough to death now that you can easily imitate it; your heartbeat slows to a near-stop, your breathing ceases, your flesh grows pale, and you show no signs of life.  You will be unable to move or act while feigning death, but enemies will generally ignore you.  You will be unable to feign death twice in a short time if you are seen ending your masquerade."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You collapse in an imitation of death."),
    on_deactivate = "vampire_feign_death_off",
    enchantments = { "INLINE_ENCH_VAMPIRE_FEIGN_DEATH_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WALK_ON_WALLS",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Spider's Walk"),
    description = ccb.content.text("Gravity seems to have less of an effect than it used it.  With barely an effort you can ascend or descend even sheer walls, and you can fall any distance and land on your feet uninjured."),
    flags = { "CLIMB_NO_LADDER", "FEATHER_FALL", "WALL_CLING" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BEAST_CLAWS",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Claws of the Beast"),
    description = ccb.content.text("You can twist your fingernails into sharp claws, allowing you to inflict extra damage in unarmed combat.\n\n<color_light_red>Initial Blood Cost:</color> 125 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 62 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your fingers twist into sharp claws."),
    on_activate = "vampire_beast_claws_on",
    on_deactivate = "vampire_beast_claws_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_BEAST_CLAWS_active",
    name = ccb.content.text_without_extraction("Claws of the Beast Extended"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Your fingers are transformed into sharp claws.  You can use them to attack, but performing mundane tasks will be harder."),
    types = { "CLAWS" },
    cost = 0,
    player_display = false,
    valid = false,
    integrated_armor = { "integrated_claws_rat" },
    enchantments = { "INLINE_ENCH_VAMPIRE_BEAST_CLAWS_active_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SEE_HEAT",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Crimson Vision"),
    description = ccb.content.text("Your vision has improved and now you can see flowing blood in the vein, like bright trails in the dark."),
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Carmine Vitality"),
    description = ccb.content.text("Blood fills you with a surge of power.  You gain a bonus to your strength and dexterity for one hour after drinking blood."),
}

ccb.content.define_mutation {
    id = "VAMPIRE3",
    name = ccb.content.text("Mortal hungers are replaced with immortal hungers"),
    points = 0,
    description = ccb.content.text("You replace some of your regular caloric intake with blood and begin to see some of the more esoteric abilities inherent to vampirism, though the sun now burns exposed flesh."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_absorption = { all = { human_blood_vitamin = 1.25 } },
    vitamin_intervals = { human_blood_vitamin = 720, mutagen = 300 },
    flags = { "CANNIBAL", "DAYFEAR", "HEMOVORE" },
    enchantments = { "INLINE_ENCH_VAMPIRE3_0", "INLINE_ENCH_VAMPIRE3_1", "INLINE_ENCH_VAMPIRE3_2" },
}

ccb.content.define_mutation {
    id = "HYPNOTIC_GAZE",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Hypnotic Gaze"),
    description = ccb.content.text("You can mesmerize your prey, gazing into their eyes and freezing them in their tracks."),
    spells_learned = { spell_hypnotic_gaze = 1 },
}

ccb.content.define_mutation {
    id = "BLOODHASTE",
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blood-Driven Speed"),
    description = ccb.content.text("Your body exceeds normal human reaction limits as blood turns to ash in your veins.\n\n<color_light_red>Initial Blood Cost:</color> 750 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 375 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Warmth floods your limbs as you move with inhuman speed."),
    on_activate = "vampire_bloodhaste_on",
    on_deactivate = "vampire_bloodhaste_off",
}

ccb.content.define_mutation {
    id = "MAGICFORBLOOD",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blood-Fueled Magic"),
    description = ccb.content.text("Blood has power, and you can draw on that power to fuel magick."),
    spells_learned = { vampire_magic_for_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_COMMAND_BEAST",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Cowing the Beast"),
    description = ccb.content.text("You are a supreme predator, and other predators bow at your feet."),
    spells_learned = { vampire_command_beast_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_EARTH_SLUMBER",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Earthen Slumber"),
    description = ccb.content.text("You can sleep within the earth itself, avoiding the hateful light of the sun."),
    spells_learned = { vampire_earth_slumber_spell = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_CARDIO_BONUS",
    name = ccb.content.text("Incarnadine Energy"),
    points = 2,
    description = ccb.content.text("The stolen blood within your body provides you with a fountain of energy.  You gain a bonus to your Cardio rating."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_CARDIO_BONUS_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_MOTION_ALARM",
    name = ccb.content.text("Wakeful Slumber"),
    points = 2,
    description = ccb.content.text("Your senses are so fine they can alert you to danger even while you slumber.  Activate to cause yourself to wake up if danger approaches while you sleep."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    enchantments = { "INLINE_ENCH_VAMPIRE_MOTION_ALARM_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BONUS_HP",
    name = ccb.content.text("Fortitude of the Damned"),
    points = 2,
    description = ccb.content.text("Your flesh is more resilient and you can suffer much more damage than a mortal before expiring.  Your hit points are increased."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_BONUS_HP_0", "INLINE_ENCH_VAMPIRE_BONUS_HP_1" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_RENDING_TEETH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Rending Jaws"),
    description = ccb.content.text("You can turn the rest of your teeth into jagged fangs, allowing to you bite and inflict serious injuries in combat.\n\n<color_light_red>Initial Blood Cost:</color> 200 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 100 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your jaw extends and your teeth grow long and jagged."),
    on_activate = "vampire_rending_teeth_on",
    on_deactivate = "vampire_rending_teeth_off",
}

-- NO_I18N
-- NO_I18N
-- Does not have the TEETH type to avoid oddness with vampire fangs
ccb.content.define_mutation {
    id = "VAMPIRE_RENDING_TEETH_active",
    name = ccb.content.text_without_extraction("Rending Jaws Extended"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Your jaws are extended and full of sharp teeth."),
    cost = 0,
    player_display = false,
    valid = false,
    integrated_armor = { "integrated_vampire_rending_jaws" },
}

ccb.content.define_mutation {
    id = "VAMPIRE4",
    name = ccb.content.text("Discarded their mortality"),
    points = 0,
    description = ccb.content.text("You have become a true vampire and are beginning to see some of the most potent abilities vampirism has to offer.  The sun burns you even if you cover yourself, your body is now too dead to passively produce mana and your healing will stop while you suffer from the Withering, but your new power more than compensates for that."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "CANNIBAL", "DAYFEAR", "HEMOVORE", "MEND_ALL" },
    enchantments = {
        "INLINE_ENCH_VAMPIRE4_0", "INLINE_ENCH_VAMPIRE4_1", "INLINE_ENCH_VAMPIRE4_2",
        "INLINE_ENCH_VAMPIRE4_3", "INLINE_ENCH_VAMPIRE4_4", "INLINE_ENCH_VAMPIRE4_5",
        "INLINE_ENCH_VAMPIRE4_6",
    },
}

ccb.content.define_mutation {
    id = "TRUE_VAMPIRE_POWER",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("True Vampire's Potence"),
    description = ccb.content.text("Your new status as a true vampire has empowered your other abilities."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_TORPOR",
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Torpor"),
    cancels = { "NARCOLEPTIC", "INSOMNIA", "HEAVYSLEEPER", "HEAVYSLEEPER2" },
    enchantments = { "INLINE_ENCH_VAMPIRE_TORPOR_0" },
    description = ccb.content.text("You can enter a deathlike stake known as torpor, in which your wounds will close faster, your fatigue will fully recover and your blood thirst will be less intense.  Be careful, though, as nothing will be able to wake you up until eight hours have passed."),
    spells_learned = { vampire_torpor = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_DOMINATE",
    points = 7,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Dominating Gaze"),
    description = ccb.content.text("You can focus your gaze and take control of your target.  Only works against targets that have a mind."),
    spells_learned = { vampire_dominate = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_BREATHE",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Facultative Breathing"),
    description = ccb.content.text("You do not need to breathe air to live anymore.  It prevents you from being drowned or suffocated and allows you to ignore inhaled gases."),
    flags = { "GILLS", "SUFFOCATION_IMMUNE", "INHALED_TOXIN_IMMUNE" },
    cancels = { "ASTHMA" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_ILLNESS",
    points = 6,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Corpse-like Flesh"),
    description = ccb.content.text("Your undead body is now much more dead than alive.  It prevents mundane illnesses and parasites from affecting you, while granting you a total immunity against radiation.  In addition, your scent is now something most mundane creatures cannot understand."),
    scent_type = "sc_vampire",
    flags = { "PARAIMMUNE", "NO_DISEASE", "NO_RADIATION", "INFECTION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SUMMON_SHADOWS",
    name = ccb.content.text("The Shadows that Crawl"),
    points = 5,
    description = ccb.content.text("Your control over darkness has progressed to the point that you can animate patches of it as living shadows to attack your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { vampire_summon_shadows = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BAT_FORM",
    name = ccb.content.text("Shape of the Night Flier"),
    points = 8,
    description = ccb.content.text("You can transform yourself into a bat and take wing on the night air."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_bat_form_on",
    on_deactivate = "vampire_bat_form_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_BAT_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Bat Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a bat.  This provides the actual effects of bat form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_0", "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_1",
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_2", "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_3",
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_4",
    },
    flags = {
        "DRACULIN_VENOM", "TOUGH_FEET", "MUTE", "LEVITATION", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_TINY", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_bat", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WOLF_FORM",
    name = ccb.content.text("Shape of the Pack Hunter"),
    points = 6,
    description = ccb.content.text("You can transform yourself into a wolf and stalk your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_wolf_form_on",
    on_deactivate = "vampire_wolf_form_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_WOLF_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Wolf Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a wolf.  This provides the actual effects of wolf form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_0", "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_1",
        "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_2", "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_3",
    },
    flags = {
        "MUTE",
        "QUADRUPED_RUN",
        "TOUGH_FEET",
        "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_wolf", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_MIST_FORM",
    name = ccb.content.text("Shape of the Billowing Mists"),
    points = 8,
    description = ccb.content.text("You can transform yourself into a cloud of mist and flee any dangers."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_mist_form_on",
    on_deactivate = "vampire_mist_form_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_MIST_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Mist form traits"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the traits for mist form.  You shouldn't be able to see it in-game."),
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_MIST_FORM_TRAITS_0" },
    appearance = { id = "fd_extinguisher", tile_category = "field" },
}

ccb.content.define_mutation {
    id = "BLOOD_DRINKER",
    name = ccb.content.text("Fully fueled by the Blood"),
    points = 0,
    description = ccb.content.text("By reaching the final stage of vampirism, you have freed yourself from your mundane needs and feelings.  The only thing you need and care about now is blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    can_only_eat = { "blood", "hblood", "fae_blood", "vampire_blood" },
    flags = {
        "CANNIBAL",
        "DAYFEAR",
        "NO_THIRST",
        "NO_BODY_HEAT",
        "CANNOT_CONSUME_DRUGS",
        "CANNOT_GAIN_WEARINESS",
    },
    vitamin_intervals = { vitC = -500, iron = -500, calcium = -500 },
    enchantments = { "INLINE_ENCH_BLOOD_DRINKER_0", "INLINE_ENCH_BLOOD_DRINKER_1" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_MASTER_MORTAL_MIND",
    points = 10,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Master the Mortal Mind"),
    description = ccb.content.text("Your ability to influence others has amplified.  You can now spend blood while talking with someone else to make them like you more, with the costliest application of this power being able to turn them into your obsessed servants.  Not all can be influenced by this power, for anger, panic and strong ties to a group that isn't yours will disrupt the process.  Other vampires and the rare saint-blooded are also immune to it."),
}

ccb.content.define_mutation {
    id = "VAMPIRE_DISTILLATE_INNER_BLOOD",
    points = 8,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Distillate the Inner Blood"),
    description = ccb.content.text("Unlike lesser vampires who bloat as they gorge on blood, you concentrate the blood you consume, making it fit nicely in your veins.  This removes the penalties for containing too much blood, but doesn't expand your maximal capacity."),
    enchantments = { "ench_vampire_no_gorge_issues" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SHADOW_FORM",
    points = 10,
    name = ccb.content.text("Shape of the Shadowed Path"),
    description = ccb.content.text("You can shroud your body and what you are carrying with shadows, amplifying your combat ability but preventing communication and using other powers until you return to your normal form.  It also costs blood for every second you spend in that state."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_shadow_form_on",
    on_process = "vampire_shadow_form_process",
    on_deactivate = "vampire_shadow_form_off",
}

ccb.content.define_mutation {
    id = "VAMPIRE_SHADOW_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Shadow Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are shrouded in shadows.  This provides the actual effects of Shadow form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_SHADOW_FORM_TRAITS_0" },
    flags = { "MUTE", "NO_SPELLCASTING ", "NO_PSIONICS" },
    appearance = { id = "mon_darkman", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_LAST_BREATH_MIST",
    points = 11,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Last Breath's Mist"),
    description = ccb.content.text("Your mastery over your mist form has increased to the point that you can now instinctively activate it should you be about to die.  It requires you to have a lot of stolen blood in your body and can't trigger more than once a week but might save your life."),
}

-- There is no difference between this and the Ierde version, so I use that one instead of making a new one to avoid duplicates.  The player isn't supposed to see this anyway.
ccb.content.define_mutation {
    id = "VAMPIRE_IRON_MIND",
    points = 8,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Immortal Iron Mind"),
    description = ccb.content.text("Your vampiric potency has reinforced your mind beyond anything a mortal could ever hope.  You are immune to anything that could negatively impact your mind."),
    enchantments = { "ench_ierde_no_mind_problems" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLIND_THE_SUN",
    points = 10,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blind the Sun"),
    description = ccb.content.text("You mastery over the shadowed path of blood has become much more potent, allowing you to use your vampiric powers and a massive expense of blood to shroud yourself from the sun for a short time.\n\n<color_light_red>Initial Blood Cost:</color> 1000 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 700 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_blind_the_sun_on",
    on_deactivate = "vampire_blind_the_sun_off",
}

ccb.content.define_mutation {
    id = "RENFIELD",
    name = ccb.content.text("Renfield"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("This person is now a renfield, a human obsessed with serving their vampire masters.  This obsession impedes their cognition as they struggle to think about anything but serving said vampire masters."),
    mixed_effect = true,
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "CANNIBAL" },
    enchantments = { "INLINE_ENCH_RENFIELD_0" },
}

-- NO_I18N
-- NO_I18N
-- Until NPC_DEATH can work, I'm using a forcefield so they can't perma-die before vanishing forever.  I tried to use an evasion effect so the message would be more fitting but it interfered with the hit_me.
-- <npcname> and %1$s both failed to work for dialogue-based vanishing, so until it is fixed these messages will refer to the mentor's title.
ccb.content.define_mutation {
    id = "MENTOR_PEACE",
    points = 0,
    name = ccb.content.text_without_extraction("Mentor's peace"),
    description = ccb.content.text_without_extraction("Intended to be hidden.  Prevent the mentor from being killed by vampires and renfields and makes them react to attacks by vanishing in mist."),
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
    ignored_by = { "VAMPIRE", "RENFIELD" },
    enchantments = { "INLINE_ENCH_MENTOR_PEACE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_MORE_BLOOD",
    name = ccb.content.text("Vampiric weakness: blood drain"),
    points = -1,
    description = ccb.content.text("You thirst for blood is more intense than usual.  You now need much more blood to prevent blood starvation."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

-- You have to convince those you talk to that you're not just a smarter zombie, hence the intimidate malus.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_GROTESQUE",
    name = ccb.content.text("Vampiric weakness: revolting appearance"),
    points = -1,
    description = ccb.content.text("Your body brings to mind a rotting corpse.  Social interactions will be much harder for you."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    visibility = 30,
    ugliness = 30,
    social_modifiers = { lie = -30, persuade = -30, intimidate = -30 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_EARTH_SLEEP",
    name = ccb.content.text("Vampiric weakness: earth-sleeper"),
    points = -1,
    description = ccb.content.text("You now depend on the proximity to the earth to sleep well.  Should you sleep or torpor aboveground or not surrounded by earth, you will suffer penalties for the next day."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

-- Unsafe: churches, cathedrals, synagogues, rural churches, eventual other holy places.
-- Safe: Vampire-filled holy places, the New England Community Church, anywhere not unsafe.
-- The desired behavior is that carrying holy symbols and books (WARDING_SYMBOL and INSPIRATIONAL flags) is sufficient to cause pain.  Since there's no way to do this without constantly scanning the player's inventory, the full implementation will wait.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_HOLY_BURN",
    name = ccb.content.text("Vampiric weakness: rebuked by the holy"),
    points = -1,
    description = ccb.content.text("Your flesh will burn should you ever enter a sanctified area.  Only places that are holy will burn you, so holy places filled with vampires or unholy humans are safe for you to enter.  Holy symbols won't burn you, but wearing them will cause you severe pain."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_HOLY_BURN_0" },
}

-- Unsafe: rivers, lakes, oceans.
-- Safe: anywhere else.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_VAST_WATER_BURN",
    name = ccb.content.text("Vampiric weakness: melted by vast water"),
    points = -1,
    description = ccb.content.text("Your flesh will melt should you ever try to cross a large body of water or get too close to them.  Only rivers, lakes and oceans have enough water to trigger this weakness, but it will take effect even if floating or water-walking."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_ANIMAL_HATE",
    name = ccb.content.text("Vampiric weakness: hated by animals"),
    points = -1,
    description = ccb.content.text("Animals cannot tolerate your wicked presence.  Expect any animal you encounter to either flee or attack you on sight."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    species_anger = {
        MAMMAL = 50,
        AMPHIBIAN = 50,
        BIRD = 50,
        REPTILE = 50,
        FISH = 50,
        KRAKEN = 50,
        INSECT = 50,
        CENTIPEDE = 50,
        INSECT_FLYING = 50,
        SPIDER = 50,
    },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_FIRE_VULNERABLE",
    name = ccb.content.text("Vampiric weakness: vulnerable to fire"),
    points = -1,
    description = ccb.content.text("Fire damages you far more than it should.  You take massive damage from fire and flames, mundane and magical."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_FIRE_VULNERABLE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_COLD_BLOODED",
    name = ccb.content.text("Vampiric weakness: cold as a corpse"),
    points = -1,
    description = ccb.content.text("Ambient cold temperature makes you stiff and slow even under winter clothes.  The lower the ambient temperature, the lower your speed."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_COLD_BLOODED_0" },
    flags = { "NO_BODY_HEAT" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD",
    name = ccb.content.text("Vampiric weakness: living-drinker"),
    points = -1,
    description = ccb.content.text("You now need to drink some fresh, warm blood from a living being once in a while or suffer growing penalties.  You better find someone willing to share their blood, as blood from fresh corpses won't satisfy this need."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD",
    name = ccb.content.text("Vampiric weakness: picky feeding"),
    points = -1,
    description = ccb.content.text("Your ability to process varied types of blood is now hampered.  Blood that isn't regular human blood will only sate your thirst half as much."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_BLOOD_CRAVING",
    name = ccb.content.text("Vampiric weakness: blood cravings"),
    points = -1,
    description = ccb.content.text("Your thirst for blood will occasionally magnify, causing painful cravings.  You can calm these cravings as or before they happen by consuming blood."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NO_FUN",
    name = ccb.content.text("Vampiric weakness: barred from mortal joys"),
    points = -1,
    description = ccb.content.text("Blood is the only thing that can bring a smile to your lips.  Nothing else gives you any lasting joy or pleasure.  It is impossible for you to be truly happy unless you recently consumed blood."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

-- Required for vampire blood to have any consumption benefit.  Regular vampires instinctively feel threatened by you and their renfields try to protect them, so they react accordingly.
-- The traits unlocked by this have no category, as they aren't given by the regular mutation system.
ccb.content.define_mutation {
    id = "VAMPIRE_ANATHEMA",
    name = ccb.content.text("Vampiric Anathema"),
    points = 0,
    description = ccb.content.text("Through the consumption of self-cannibalizing vampire blood, you gained the ability to consume vampire blood to gain vampiric abilities undreamt of by other vampires."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    species_anger = { VAMPIRE = 200, RENFIELD = 200 },
    threshold = true,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_STORE_MORE_BLOOD",
    name = ccb.content.text("Inner Vault of Blood"),
    points = 5,
    description = ccb.content.text("Your vestigial circulatory system is now better at holding stolen blood.  You can hold two and a half more liters inside you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "EYEGLEAM_UPGRADE",
    name = ccb.content.text("Eternally-Gleaming Eyes"),
    points = 5,
    description = ccb.content.text("Your ability to see in the dark has expanded.  You no longer need to spend blood to maintain your gleaming eyes."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_INSTANT_BLEED",
    name = ccb.content.text("Claim the Crimson Wine"),
    points = 5,
    description = ccb.content.text("You can now attract the blood within a corpse's veins, extracting it all in a second through a small cut.  In addition, you can create temporary blood containers out of some of your stolen blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "INSTANT_BLEED" },
    spells_learned = { vampire_summon_blood_container = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_DETECT_VAMPIRES",
    name = ccb.content.text("Apex Vampire's Sight"),
    points = 5,
    description = ccb.content.text("In comparison to you, regular vampires are the same as mortals.  You can now detect nearby vampires, your new prey, even through walls."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_DETECT_VAMPIRES_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BIG_STOMACH",
    name = ccb.content.text("Unlimited Drinking"),
    points = 5,
    description = ccb.content.text("Your digestive system has warped to repurpose some vestigial parts, making you much better at drinking blood.  Drinking reasonable amounts of blood won't ever stretch your stomach, and you drink blood much faster now."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_BIG_STOMACH_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    name = ccb.content.text("See Through Night's Eyes"),
    points = 5,
    description = ccb.content.text("Your supernatural senses have expanded.  You can now see anything close to some nocturnal creatures, even if they lack sight."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    monster_cameras = { mon_bat = 32, xe_mon_bat = 32, mon_vampire_bat = 32, mon_bat_giant = 32 },
}

-- The main draw of BLOOD_FUN is fae blood being a net morale positive.  The main draw of this upgrade is getting stat boosts from the high morale.
ccb.content.define_mutation {
    id = "BLOOD_FUN_UPGRADE",
    name = ccb.content.text("Sanguine Paradise"),
    points = 5,
    description = ccb.content.text("Becoming more vampire than vampires are has affected your new palate, making the consumption of blood feel even better than before.  You now enjoy drinking blood so much that enough of it will bolster your resolve for a while."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_SILENT_MOVE_UPGRADE",
    name = ccb.content.text("Dead Silent Strikes"),
    points = 5,
    description = ccb.content.text("Your lack of movement noise is now encompassing any noise you could do in combat.  All such noises you would've made by attacking in melee are nullified."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_SILENT_MOVE_UPGRADE_0" },
}

-- Behaves as the anathema's threshold, letting the EOC give the stronger traits.  The enabler is a threshold to limit mixing regular mutations and this path.
-- A few mentors knew that this was possible, but they kept the secret to not threaten the plan.
ccb.content.define_mutation {
    id = "THRESH_VAMPIRE_ANATHEMA",
    name = ccb.content.text("Ascended Anathema"),
    points = 0,
    description = ccb.content.text("You drank enough vampire blood to gain access to power the mentors never thought possible.  There is no more limit to how powerful of a vampire you can be."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    mixed_effect = true,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    name = ccb.content.text("Inner Sea of Blood"),
    points = 10,
    description = ccb.content.text("Your new power allows you to store even more stolen blood inside your body.  You can hold another five liters inside you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

-- should only work in the dark, but such checks aren't yet.
-- This enchantment removes the effect if the vampire is outside at day.
ccb.content.define_mutation {
    id = "VAMPIRE_INVISIBLE_IN_DARK",
    name = ccb.content.text("Shrouded by the Shadowed Path"),
    points = 10,
    description = ccb.content.text("Darkness is your home, and you can call it to shroud you from others.  When away from the sun, you can become invisible with a constant expense of blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { vampire_invisible_in_dark = 1 },
    enchantments = { "INLINE_ENCH_VAMPIRE_INVISIBLE_IN_DARK_0" },
}

-- should only work in the dark, but such checks aren't yet.
ccb.content.define_mutation {
    id = "VAMPIRE_HEAL_IN_DARK",
    name = ccb.content.text("Stitched by the Shadowed Path"),
    points = 10,
    description = ccb.content.text("Darkness is your new friend, and like a good friend it helps you through hard times.  Passively heal your wounds and reduce your pain while away from the sun."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_FOR_POTENCY",
    name = ccb.content.text("Boiling Crimson Cauldron"),
    points = 10,
    description = ccb.content.text("The powers of vampires come through their sustenance of blood, and you now know how to use this at your advantage.  You can increase your need for blood to boost your vampiric potency until you decide to stop the effect.  If you do not have enough blood, it will have no effect until you drink more blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your power increases as your blood burns away."),
    enchantments = { "INLINE_ENCH_VAMPIRE_BLOOD_FOR_POTENCY_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_FOR_POTENCY_REAL",
    name = ccb.content.text_without_extraction("Boiling Crimson Cauldron Real"),
    points = 10,
    description = ccb.content.text_without_extraction("Increases blood potency and drain while the player-visible version is active and has enough blood.  You should never see this."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    vitamin_intervals = { human_blood_vitamin = 2 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_ILLNESS_UPGRADE",
    name = ccb.content.text("Immortal's Health"),
    points = 10,
    description = ccb.content.text("Being protected against mundane afflictions only is something your flesh has stopped tolerating.  Your condition now protects you from any illness, parasite and poison, no matter how dangerous they are."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_NO_ILLNESS_UPGRADE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_FORM_UPGRADE",
    name = ccb.content.text("Mastery of Forms"),
    points = 10,
    description = ccb.content.text("You are much more attuned to your other forms, and they are now easier to activate than ever.  The cost to activate them is halved."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    name = ccb.content.text("Second Final Breath"),
    points = 10,
    description = ccb.content.text("Your instinctive mastery of your mist form has expanded.  You now recover from triggering Last Breath's Mist twice as quickly."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_DRINK_VAMPIRE_BLOOD",
    name = ccb.content.text("Fueled by the Blood-Drinkers' Blood"),
    points = 10,
    description = ccb.content.text("Vampires, mortals, they are all the same for you now.  Drinking vampire blood now gives all the benefits of drinking regular blood, in addition to growing your power."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_GAIN_BLOOD_GIFTS",
    name = ccb.content.text("Knowledge of the Blood"),
    points = 10,
    description = ccb.content.text("Your own blood now reveals its secrets to you.  Every week, you will gain a new gift of the blood.  It will only give you what researching your blood gifts could give you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
    name = ccb.content.text("Maximal Mastery of the Mortal Mind"),
    points = 10,
    description = ccb.content.text("Your mind-control abilities are much simpler to use now, halving their cost."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_SUN_BURN",
    name = ccb.content.text("Anathema's Weakness: Slain by the Sun"),
    points = -10,
    description = ccb.content.text("Vampires burn under the sun, and becoming more of a vampire made you burn far more than any other vampire would.  Being under the sun will quickly ignite your flesh."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_MIND_CHAOS",
    name = ccb.content.text("Anathema's Weakness: Blood-Muddled Mind"),
    points = -10,
    description = ccb.content.text("Your constant consumption of vampire blood has permanently destabilized your mind, and it will only grow worse with each new vampire drained.  Each time you drink vampire blood, you have a growing chance to gain a new mental affliction."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD",
    name = ccb.content.text("Anathema's Weakness: Apex's Thirst"),
    points = -10,
    description = ccb.content.text("Drinking all this vampire blood has left your body yearning for more.  Going too long without drinking vampire blood will progressively increase your thirst for blood with each passing day until you starve or drink vampire blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "BLOOD_OF_SAINTS",
    name = ccb.content.text("Saint's blood"),
    points = 0,
    description = ccb.content.text("Through a complicated ritual utilizing a saint's relic, you have transubstantiated your own blood with the holy blood of the saints.  It'll prevent you from becoming infected with vampirism while you live, effects postmortem unknown."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    types = { "BLOOD" },
}

ccb.content.define_mutation {
    id = "FUTURESIGHT",
    name = ccb.content.text("Future Sight"),
    points = 0,
    description = ccb.content.text("You aren't where you seem to be."),
    starting_trait = false,
    valid = false,
    flags = { "UNCANNY_DODGE" },
}

ccb.content.define_mutation {
    id = "EATER_SIXTH_SENSE",
    name = ccb.content.text("Eater's Sixth Sense"),
    points = 0,
    description = ccb.content.text("You are no longer limited to the five senses common to most humans in your hunt for the unnatural."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "EATER_SIXTH_SENSE" },
}

ccb.content.define_mutation {
    id = "CALL_DAFFODIL",
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Fae Authority"),
    description = ccb.content.text("Boann bestowed upon you the right to summon a few daffodil warriors once a day."),
    spells_learned = { call_daffodil = 1 },
}

ccb.content.define_mutation {
    id = "IRON_ALLERGY",
    name = ccb.content.text("Iron Intolerance"),
    points = -4,
    description = ccb.content.text("You were born with an allergy to iron and, to a lesser extent, steel.  Wearing or touching anything made of iron or steel will cause you pain and discomfort."),
    starting_trait = true,
}

ccb.content.define_mutation {
    id = "FAE_ENMITY",
    name = ccb.content.text("Fae Enmity"),
    points = -10,
    description = ccb.content.text("The Fair Folk can sense the stolen power within you and their vengeance will be terrible."),
    purifiable = false,
    valid = false,
    species_anger = {
        ARVORE = 100,
        CHANGELING = 100,
        HOMULLUS = 100,
        IERDE = 100,
        SALAMANDER = 100,
        SYLPH = 100,
        UNDINE = 100,
    },
}

ccb.content.define_mutation {
    id = "FALSE_ARVORE_HATRED",
    name = ccb.content.text("False Arvore"),
    points = -4,
    description = ccb.content.text("The arvore can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { ARVORE = 100 },
    categories = { "ARVORE_ALCHEMY" },
}

ccb.content.define_mutation {
    id = "FALSE_HOMULLUS_HATRED",
    name = ccb.content.text("False Homullus"),
    points = -4,
    description = ccb.content.text("The homullus can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { HOMULLUS = 100 },
}

ccb.content.define_mutation {
    id = "FALSE_SALAMANDER_HATRED",
    name = ccb.content.text("False Salamander"),
    points = -4,
    description = ccb.content.text("The salamanders can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { SALAMANDER = 100 },
}

ccb.content.define_mutation {
    id = "BOANN_RETALIATION",
    name = ccb.content.text_without_extraction("Boann's retaliation"),
    points = 0,
    description = ccb.content.text_without_extraction("Intended to be hidden.  Makes Boann teleport the player away, spawns some huntsmen and hounds then cure all her ailments and injuries if she survives being hit by the player."),
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BOANN_RETALIATION_0", "INLINE_ENCH_BOANN_RETALIATION_1" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID",
    name = ccb.content.text("Bloodthorne Druid"),
    points = 0,
    description = ccb.content.text("You are a oath-sworn member of the ancient order of Bloodthorne Druids, dedicated to defending humanity against the vampires that lurk in the shadows."),
    purifiable = false,
    valid = false,
    profession = true,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    types = { "HERITAGE" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "XE_FACTION_CAMP_BROWNIE_BLESSING",
    name = ccb.content.text_without_extraction("Brownie's Blessing"),
    points = 1,
    description = ccb.content.text_without_extraction("You are blessed by a brownie.  This should not be visible."),
    purifiable = false,
    valid = false,
    player_display = false,
    chargen_allow_npc = false,
    enchantments = { "INLINE_ENCH_XE_FACTION_CAMP_BROWNIE_BLESSING_0" },
}
