local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VULNERABLECHILL",
    name = ccb.content.text("Cold Intolerance"),
    description = ccb.content.text("You fare worse than most in colder climates and are more bothered by lower temperatures.  Note that while it will take less cold and exposure for you to suffer the effects of frostbite, you aren't any worse at dealing with the symptoms."),
    categories = { "ELFA", "SLIME" },
    types = { "ACCLIMATIZATION", "ECTOTHERMIC" },
    replacements = { "STRONGER_VULNERABLECHILL" },
    cancels = { "STRONGER_RESISTCHILL", "RESISTCHILL" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_VULNERABLECHILL_0" },
}

ccb.content.define_mutation {
    id = "STRONGER_VULNERABLECHILL",
    name = ccb.content.text("High Cold Intolerance"),
    description = ccb.content.text("You are now even more bothered by the cold and it is easier for you to freeze or to even get chilly.  When you do though, it'll hit just as hard as it did before."),
    categories = { "SLIME" },
    types = { "ACCLIMATIZATION", "ECTOTHERMIC" },
    prerequisites = { "VULNERABLECHILL" },
    threshold_requirements = { "THRESH_SLIME" },
    cancels = { "STRONGER_RESISTCHILL", "STRONGER_RESISTWARM", "HUMAN_ACCLIMATIZATION", "RESISTCHILL" },
    points = -3,
    valid = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGER_VULNERABLECHILL_0" },
}

ccb.content.define_mutation {
    id = "RESISTCHILL",
    name = ccb.content.text("Cold Tolerance"),
    description = ccb.content.text("You fare better than most in colder climates and are less bothered by lower temperatures.  Note that while it will take more cold and exposure for you to suffer the effects of frostbite, you aren't any better at dealing with the symptoms."),
    categories = { "LUPINE", "URSINE", "CATTLE", "FELINE", "RABBIT", "MOUSE", "BEAST" },
    types = { "ACCLIMATIZATION", "ECTOTHERMIC" },
    replacements = { "STRONGER_RESISTCHILL" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_RESISTCHILL_0" },
}

ccb.content.define_mutation {
    id = "STRONGER_RESISTCHILL",
    name = ccb.content.text("High Cold Tolerance"),
    description = ccb.content.text("You are now even less bothered by the cold and it is harder for you to freeze or to even get chilly.  When you do though, it'll hit just as hard as it did before."),
    categories = { "LUPINE", "URSINE", "CATTLE", "FELINE", "RABBIT", "MOUSE", "BEAST" },
    types = { "ACCLIMATIZATION", "ECTOTHERMIC" },
    prerequisites = { "RESISTCHILL" },
    threshold_requirements = {
        "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_FELINE", "THRESH_RABBIT",
        "THRESH_MOUSE", "THRESH_BEAST",
    },
    points = 3,
    valid = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGER_RESISTCHILL_0" },
}

ccb.content.define_mutation {
    id = "VULNERABLEWARM",
    name = ccb.content.text("Heat Intolerance"),
    description = ccb.content.text("You fare worse than most in warmer climates and are more bothered by hotter temperatures.  Note that while it will take less heat and exposure for you to suffer the effects of sunstroke, you aren't any worse at dealing with the symptoms."),
    categories = { "CHIMERA" },
    replacements = { "STRONGER_VULNERABLEWARM" },
    cancels = { "STRONGER_RESISTWARM", "RESISTWARM" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_VULNERABLEWARM_0" },
}

ccb.content.define_mutation {
    id = "STRONGER_VULNERABLEWARM",
    name = ccb.content.text("High Heat Intolerance"),
    description = ccb.content.text("You are now even more bothered by the heat and it is easier for you to overheat or even sweat.  When you do though, it'll hit just as hard as it did before."),
    categories = { "CHIMERA" },
    types = { "ACCLIMATIZATION" },
    prerequisites = { "VULNERABLEWARM" },
    threshold_requirements = { "THRESH_CHIMERA" },
    cancels = { "STRONGER_RESISTWARM", "RESISTWARM", "HUMAN_ACCLIMATIZATION" },
    points = -3,
    valid = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGER_VULNERABLEWARM_0" },
}

ccb.content.define_mutation {
    id = "RESISTWARM",
    name = ccb.content.text("Heat Tolerance"),
    description = ccb.content.text("You fare better than most in warmer climates and are less bothered by hotter temperatures.  Note that while it will take more heat and exposure for you to suffer the effects of sunstroke, you aren't any better at dealing with the symptoms."),
    categories = { "FISH", "CEPHALOPOD", "GASTROPOD", "LIZARD", "BATRACHIAN", "PLANT" },
    replacements = { "STRONGER_RESISTWARM" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_RESISTWARM_0" },
}

ccb.content.define_mutation {
    id = "STRONGER_RESISTWARM",
    name = ccb.content.text("High Heat Tolerance"),
    description = ccb.content.text("You are now even less bothered by the heat and it is harder for you to overheat or even sweat.  When you do though, it'll hit just as hard as it did before."),
    categories = { "FISH", "CEPHALOPOD", "GASTROPOD", "LIZARD", "BATRACHIAN", "PLANT" },
    types = { "ACCLIMATIZATION" },
    prerequisites = { "RESISTWARM" },
    threshold_requirements = { "THRESH_FISH", "THRESH_CEPHALOPOD", "THRESH_GASTROPOD", "THRESH_LIZARD", "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 3,
    valid = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGER_RESISTWARM_0" },
}

ccb.content.define_mutation {
    id = "RESISTCHILL_RESISTWARM",
    name = ccb.content.text("Temperature Tolerance"),
    description = ccb.content.text("You are now not at all bothered by the heat and it is harder for you to overheat or freeze at all.  When you do though, it'll hit just as hard as it did before."),
    categories = { "PLANT" },
    types = { "ACCLIMATIZATION" },
    prerequisites = { "RESISTWARM" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 5,
    valid = true,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_RESISTCHILL_RESISTWARM_0", "INLINE_ENCH_RESISTCHILL_RESISTWARM_1" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESISTCHILL_RESISTWARM",
    name = ccb.content.text("Ambient Resilience"),
    description = ccb.content.text("You are less sensitive to hot and cold, but you can still freeze and overheat."),
    categories = { "INTERSTICE" },
    types = { "ACCLIMATIZATION" },
    replacements = { "INTERSTICE_RESISTCHILL_RESISTWARM_2" },
    points = 2,
    valid = true,
    vitamin_cost = 90,
    enchantments = {
        "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_0",
        "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_1",
    },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESISTCHILL_RESISTWARM_2",
    name = ccb.content.text("High Ambient Resilience"),
    description = ccb.content.text("Your body can handle extreme temperatures much better, but you can still freeze and overheat."),
    categories = { "INTERSTICE" },
    types = { "ACCLIMATIZATION" },
    prerequisites = { "INTERSTICE_RESISTCHILL_RESISTWARM" },
    additions = { "INTERSTICE_AURA" },
    points = 3,
    valid = true,
    vitamin_cost = 120,
    enchantments = {
        "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_2_0",
        "INLINE_ENCH_INTERSTICE_RESISTCHILL_RESISTWARM_2_1",
    },
}

ccb.content.define_mutation {
    id = "INTERSTICE_AURA",
    name = ccb.content.text("Penumbral Interstitium"),
    description = ccb.content.text("Your cells operate under different rules.  While you still need to breathe, you are otherwise extremely resistant to the thermal and chemical insults of the so-called universe."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_RESISTCHILL_RESISTWARM_2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    additions = { "INTERSTICE_RESONANCE" },
    purifiable = false,
    points = 6,
    vitamin_cost = 240,
    integrated_armor = { "integrated_interstice_aura" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESONANCE",
    name = ccb.content.text("Resonant"),
    description = ccb.content.text("Your physiology plays by different rules, and it seems the universe has noticed."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_AURA" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    additions = { "INTERSTICE_RESONANCE_2" },
    strict_threshold_requirements = true,
    points = -3,
    purifiable = false,
    vitamin_cost = 120,
    enchantments = { "INLINE_ENCH_INTERSTICE_RESONANCE_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESONANCE_2",
    name = ccb.content.text("Outsider"),
    description = ccb.content.text("Your physiology plays by different rules.  The universe will notice you in your former homeworld."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_RESONANCE" },
    replacements = { "INTERSTICE_RESONANCE_3" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = -4,
    purifiable = true,
    vitamin_cost = 240,
    enchantments = { "INLINE_ENCH_INTERSTICE_RESONANCE_2_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_RESONANCE_3",
    name = ccb.content.text("Deeply Incongruent"),
    description = ccb.content.text("Your physiology plays by different rules, and it has caught the attention of something."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_RESONANCE_2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = -5,
    purifiable = false,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_INTERSTICE_RESONANCE_3_0" },
}

ccb.content.define_mutation {
    id = "QUICK",
    name = ccb.content.text("Quick"),
    description = ccb.content.text("You're just generally quick!  You get a 10% bonus to action points."),
    categories = {
        "FISH", "BIRD", "INSECT", "TROGLOBITE", "CHIMERA", "RAPTOR", "MOUSE", "RABBIT", "CHIROPTERAN",
        "INTERSTICE",
    },
    points = 5,
    starting_trait = true,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_QUICK_0" },
}

ccb.content.define_mutation {
    id = "DEFT",
    name = ccb.content.text("Deft"),
    description = ccb.content.text("While you're not any better at melee combat, you are better at recovering from a miss, and will be able to attempt another strike faster."),
    categories = { "BIRD", "BEAST", "RAPTOR", "FELINE", "INTERSTICE" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "FAST_REFLEXES",
    name = ccb.content.text("Fast Reflexes"),
    description = ccb.content.text("You have fast reflexes, allowing you to dodge attacks more easily."),
    categories = { "FELINE", "INTERSTICE" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FAST_REFLEXES_0" },
}

ccb.content.define_mutation {
    id = "FLEET",
    name = ccb.content.text("Fleet-Footed"),
    description = ccb.content.text("You can move more quickly than most, resulting in a 15% speed bonus on sure footing."),
    categories = { "SPIDER", "MOUSE", "RABBIT", "BIRD", "INTERSTICE" },
    types = { "RUNNING" },
    replacements = { "FLEET2" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FLEET_0" },
}

ccb.content.define_mutation {
    id = "FLEET2",
    name = ccb.content.text("Road-Runner"),
    description = ccb.content.text("Your legs are extremely limber and fast-moving.  You move 30% faster on flat surfaces."),
    categories = { "BIRD" },
    types = { "RUNNING" },
    prerequisites = { "FLEET" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FLEET2_0" },
}

ccb.content.define_mutation {
    id = "SLOWRUNNER",
    name = ccb.content.text("Slow Footed"),
    description = ccb.content.text("You can't move as fast as most, resulting in a 15% speed penalty on flat ground."),
    types = { "RUNNING" },
    points = -3,
    starting_trait = true,
    enchantments = { "INLINE_ENCH_SLOWRUNNER_0" },
}

ccb.content.define_mutation {
    id = "LIGHTSTEP",
    name = ccb.content.text("Light Step"),
    description = ccb.content.text("You make less noise while walking.  You're also less likely to set off traps."),
    categories = { "BIRD", "ELFA", "FELINE", "CHIROPTERAN" },
    cancels = { "CLUMSY" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_LIGHTSTEP_0" },
}

ccb.content.define_mutation {
    id = "GOODCARDIO",
    name = ccb.content.text("Indefatigable"),
    description = ccb.content.text("Whether due to exercise and good diet, or due to a natural propensity to physical endurance, you tire due to physical exertion much less readily than others.  Your cardio fitness and maximum stamina are higher than usual."),
    categories = { "FISH", "LUPINE", "MOUSE", "INSECT", "RABBIT", "CHIROPTERAN" },
    types = { "CARDIO" },
    replacements = { "GOODCARDIO2" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_GOODCARDIO_0" },
}

ccb.content.define_mutation {
    id = "GOODCARDIO2",
    name = ccb.content.text("Hyperactive"),
    description = ccb.content.text("Your body's efficiency is like that of a tiny furnace, greatly increasing your cardio and stamina."),
    categories = { "MOUSE", "RABBIT" },
    types = { "CARDIO" },
    prerequisites = { "GOODCARDIO" },
    threshold_requirements = { "THRESH_MOUSE", "THRESH_RABBIT" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_GOODCARDIO2_0" },
}

ccb.content.define_mutation {
    id = "BADCARDIO",
    name = ccb.content.text("Languorous"),
    description = ccb.content.text("Whether due to lack of exercise and poor diet, or due to a natural disinclination to physical endurance, you tire due to physical exertion much more readily than others.  Your total cardio fitness and stamina are lower than normal."),
    types = { "CARDIO" },
    points = -2,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_BADCARDIO_0" },
}

ccb.content.define_mutation {
    id = "BADKNEES",
    name = ccb.content.text("Bad Knees"),
    description = ccb.content.text("Whether due to injury or age, your knees aren't particularly strong or flexible.  Moving over rough terrain will slow you down more than normal."),
    cancels = { "STRONGKNEES", "REALLYBADKNEES" },
    points = -1,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_BADKNEES_0" },
}

ccb.content.define_mutation {
    id = "REALLYBADKNEES",
    name = ccb.content.text("Stiff Knees"),
    description = ccb.content.text("Your knees never bend.  Period.  Stiff as a metal pole.  Pray that your journey doesn't involve stairs or slightly uneven terrain."),
    cancels = { "STRONGKNEES", "BADKNEES" },
    points = -3,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_REALLYBADKNEES_0" },
}

ccb.content.define_mutation {
    id = "TOUGH_FEET",
    name = ccb.content.text("Tough Feet"),
    description = ccb.content.text("The bottoms of your feet are tough, and you are accustomed to going barefoot.  You receive no movement penalty for not wearing shoes."),
    categories = { "GASTROPOD" },
    types = { "SOLES" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "TOUGH_FEET" },
}

ccb.content.define_mutation {
    id = "STRONGBACK",
    name = ccb.content.text("Strong Back"),
    description = ccb.content.text("You are capable of carrying far more than someone with similar strength could.  Your maximum weight carried is increased by 35%."),
    cancels = { "BADBACK" },
    points = 2,
    starting_trait = true,
    valid = false,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_STRONGBACK_0" },
}

ccb.content.define_mutation {
    id = "BADBACK",
    name = ccb.content.text("Bad Back"),
    description = ccb.content.text("You simply cannot carry as much as people with a similar strength could.  Your maximum weight carried is reduced by 35%."),
    categories = { "BIRD", "ELFA" },
    cancels = { "STRONGBACK" },
    points = -3,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_BADBACK_0" },
}

ccb.content.define_mutation {
    id = "PACKMULE",
    name = ccb.content.text("Packmule"),
    description = ccb.content.text("You pack things very efficiently!  You can retrieve things from containers 10% faster."),
    cancels = { "DISORGANIZED" },
    points = 1,
    starting_trait = true,
    valid = false,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_PACKMULE_0" },
}

ccb.content.define_mutation {
    id = "DISORGANIZED",
    name = ccb.content.text("Disorganized"),
    description = ccb.content.text("You are terrible at organizing and storing your possessions.  You retrieve things from containers 10% slower."),
    cancels = { "PACKMULE" },
    points = -1,
    valid = false,
    enchantments = { "INLINE_ENCH_DISORGANIZED_0" },
}

ccb.content.define_mutation {
    id = "GOODHEARING",
    name = ccb.content.text("Good Hearing"),
    description = ccb.content.text("Your hearing is better than average, and you can hear distant sounds more easily."),
    categories = { "ALPHA", "MOUSE", "ELFA", "RABBIT", "CHIROPTERAN", "INTERSTICE" },
    types = { "HEARING" },
    replacements = { "BATEARS" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_GOODHEARING_0" },
}

ccb.content.define_mutation {
    id = "BADHEARING",
    name = ccb.content.text("Poor Hearing"),
    description = ccb.content.text("Your hearing is poor, and you may not hear quiet or far-off noises."),
    categories = { "PLANT", "GASTROPOD" },
    types = { "HEARING" },
    replacements = { "DEAF" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_BADHEARING_0" },
}

ccb.content.define_mutation {
    id = "DEAF",
    name = ccb.content.text("Deaf"),
    description = ccb.content.text("You're not able to hear anything, and as such you're not able to talk to NPCs."),
    types = { "HEARING" },
    prerequisites = { "BADHEARING" },
    points = -4,
    starting_trait = true,
    flags = { "DEAF" },
    enchantments = { "INLINE_ENCH_DEAF_0" },
}

ccb.content.define_mutation {
    id = "TOUGH",
    name = ccb.content.text("Tough"),
    description = ccb.content.text("It takes a lot to bring you down!  You get a 20% bonus to all hit points."),
    replacements = { "TOUGH2" },
    cancels = { "FLIMSY", "FLIMSY2", "FLIMSY3" },
    points = 2,
    starting_trait = true,
    valid = false,
    vitamin_cost = 160,
    social_modifiers = { intimidate = 2 },
    enchantments = { "INLINE_ENCH_TOUGH_0" },
}

ccb.content.define_mutation {
    id = "TOUGH2",
    name = ccb.content.text("Durable"),
    description = ccb.content.text("You can shrug off almost anything!  You get a 30% bonus to all hit points."),
    prerequisites = { "TOUGH" },
    replacements = { "TOUGH3" },
    points = 3,
    valid = false,
    vitamin_cost = 180,
    social_modifiers = { intimidate = 3 },
    enchantments = { "INLINE_ENCH_TOUGH2_0" },
}

ccb.content.define_mutation {
    id = "TOUGH3",
    name = ccb.content.text("Unbreakable"),
    description = ccb.content.text("Nothing can break you!  You get a 40% bonus to all hit points."),
    prerequisites = { "TOUGH2" },
    points = 4,
    valid = false,
    vitamin_cost = 195,
    social_modifiers = { intimidate = 4 },
    enchantments = { "INLINE_ENCH_TOUGH3_0" },
}

ccb.content.define_mutation {
    id = "FLIMSY",
    name = ccb.content.text("Flimsy"),
    description = ccb.content.text("Your body can't take much abuse.  Its maximum HP is 25% lower than usual.  Your weakness is apparent and makes you less intimidating.  Stacks with Glass Jaw."),
    categories = { "MOUSE", "ELFA", "RABBIT", "CHIROPTERAN" },
    types = { "DURABILITY" },
    replacements = { "FLIMSY2" },
    cancels = { "TOUGH", "TOUGH2", "TOUGH3" },
    points = -4,
    starting_trait = true,
    vitamin_cost = 160,
    social_modifiers = { intimidate = -2 },
    enchantments = { "INLINE_ENCH_FLIMSY_0" },
}

ccb.content.define_mutation {
    id = "FLIMSY2",
    name = ccb.content.text("Frail"),
    description = ccb.content.text("Your body breaks very easily.  Its maximum HP is 50% lower than usual.  Your weakness is apparent and makes you less intimidating.  Stacks with Glass Jaw."),
    types = { "DURABILITY" },
    prerequisites = { "FLIMSY" },
    replacements = { "FLIMSY3" },
    cancels = { "TOUGH", "TOUGH2", "TOUGH3" },
    points = -6,
    starting_trait = true,
    valid = false,
    vitamin_cost = 210,
    social_modifiers = { intimidate = -3 },
    enchantments = { "INLINE_ENCH_FLIMSY2_0" },
}

ccb.content.define_mutation {
    id = "FLIMSY3",
    name = ccb.content.text("Fragile"),
    description = ccb.content.text("Your body is extremely fragile.  Its maximum HP is 75% lower than usual.  Your weakness is apparent and makes you less intimidating.  Stacks with Glass Jaw."),
    types = { "DURABILITY" },
    prerequisites = { "FLIMSY2" },
    cancels = { "TOUGH", "TOUGH2", "TOUGH3" },
    points = -8,
    starting_trait = true,
    valid = false,
    vitamin_cost = 300,
    social_modifiers = { intimidate = -4 },
    enchantments = { "INLINE_ENCH_FLIMSY3_0" },
}

ccb.content.define_mutation {
    id = "GLASSJAW",
    name = ccb.content.text("Glass Jaw"),
    description = ccb.content.text("Your head can't take much abuse.  Its maximum HP is 20% lower than usual.  Your apparent fragility makes you less intimidating."),
    categories = { "BIRD", "RAPTOR" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    social_modifiers = { intimidate = -2 },
}

ccb.content.define_mutation {
    id = "FASTHEALER",
    name = ccb.content.text("Fast Healer"),
    description = ccb.content.text("Your wounds and broken limbs heal quicker than usual."),
    categories = { "MEDICAL", "PLANT", "BATRACHIAN", "LIZARD", "SLIME", "TROGLOBITE", "CRUSTACEAN" },
    types = { "HEALING" },
    replacements = { "FASTHEALER2", "REGEN_LIZ" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FASTHEALER_0" },
}

ccb.content.define_mutation {
    id = "FASTHEALER2",
    name = ccb.content.text("Very Fast Healer"),
    description = ccb.content.text("Your wounds and broken limbs heal very quickly."),
    categories = { "PLANT", "BATRACHIAN", "SLIME", "TROGLOBITE" },
    types = { "HEALING" },
    prerequisites = { "FASTHEALER" },
    replacements = { "REGEN" },
    points = 4,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FASTHEALER2_0" },
}

ccb.content.define_mutation {
    id = "SLOWHEALER",
    name = ccb.content.text("Slow Healer"),
    description = ccb.content.text("Your wounds heal a little slower than most.  Your HP whilst asleep, as well as your broken limbs, heal at 75% of the regular rate."),
    types = { "HEALING" },
    points = -2,
    starting_trait = true,
    enchantments = { "INLINE_ENCH_SLOWHEALER_0" },
}

ccb.content.define_mutation {
    id = "SLOWHEALER2",
    name = ccb.content.text("Poor Healer"),
    description = ccb.content.text("Your health recovery is severely impaired.  Your HP whilst asleep, as well as your broken limbs, heal at 33% of the regular rate."),
    types = { "HEALING" },
    points = -4,
    starting_trait = true,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_SLOWHEALER2_0" },
}

ccb.content.define_mutation {
    id = "SLOWHEALER3",
    name = ccb.content.text("Imperceptive Healer"),
    description = ccb.content.text("Wounds are incredibly dangerous to you, as they barely heal at all.  Your HP whilst asleep, as well as your broken limbs, heal at 10% of the regular rate."),
    types = { "HEALING" },
    points = -8,
    starting_trait = true,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_SLOWHEALER3_0" },
}

ccb.content.define_mutation {
    id = "NOHEAL",
    name = ccb.content.text("Irreparable"),
    description = ccb.content.text("Whatever caused the end of the world affected you in a horrible way.  Your wounds will never heal on their own and your broken limbs will never mend."),
    types = { "HEALING" },
    points = -12,
    starting_trait = true,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_NOHEAL_0" },
}

ccb.content.define_mutation {
    id = "POISRESIST",
    name = ccb.content.text("Poison Resistant"),
    description = ccb.content.text("Your system is rather tolerant of poisons and toxins, and most will affect you less."),
    categories = {
        "INSECT", "SLIME", "SPIDER", "MEDICAL", "CEPHALOPOD", "TROGLOBITE", "RAPTOR", "RAT",
        "BATRACHIAN", "CHIMERA", "GASTROPOD", "CRUSTACEAN",
    },
    additions = { "EATPOISON" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "INFRESIST",
    name = ccb.content.text("Infection Resistant"),
    description = ccb.content.text("Your immune system is particularly good at resisting infections.  You have an increased chance for bad wounds and infections to heal on their own, and only suffer reduced penalties from them."),
    categories = { "TROGLOBITE", "RAT", "MEDICAL", "GASTROPOD", "CHIMERA", "SLIME" },
    replacements = { "INFIMMUNE" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "INFIMMUNE",
    name = ccb.content.text("Infection Immune"),
    description = ccb.content.text("Your bloodstream has developed antibiotic properties.  Your wounds will never become infected."),
    categories = { "MEDICAL" },
    prerequisites = { "DISRESISTANT", "DISIMMUNE" },
    secondary_prerequisites = { "INFRESIST" },
    points = 3,
    vitamin_cost = 160,
    flags = { "INFECTION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "DISRESISTANT",
    name = ccb.content.text("Disease Resistant"),
    description = ccb.content.text("It's very unlikely that you will catch ambient diseases like the cold or flu."),
    categories = { "CATTLE", "RAT", "MEDICAL", "PLANT", "SLIME", "TROGLOBITE", "CHIMERA", "CHIROPTERAN" },
    replacements = { "DISIMMUNE" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "DISIMMUNE",
    name = ccb.content.text("Disease Immune"),
    description = ccb.content.text("Your body is simply immune to diseases.  You will never catch an ambient disease."),
    categories = { "PLANT", "SLIME", "TROGLOBITE" },
    prerequisites = { "DISRESISTANT" },
    points = 2,
    vitamin_cost = 160,
    flags = { "NO_DISEASE" },
}

ccb.content.define_mutation {
    id = "MASOCHIST",
    name = ccb.content.text("Pain Driven"),
    description = ccb.content.text("Although you still suffer the negative effects of pain, it also brings a unique pleasure to you."),
    categories = { "MEDICAL" },
    types = { "MASOCHISM" },
    replacements = { "MASOCHIST_MED", "CENOBITE" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "PAINRESIST",
    name = ccb.content.text("Pain Resistant"),
    description = ccb.content.text("You have a high tolerance for pain."),
    categories = { "MEDICAL", "TROGLOBITE" },
    types = { "PAIN" },
    points = 3,
    starting_trait = true,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_PAINRESIST_0" },
}

-- The MORE_PAIN mutations will always increase the pain you receive by at least 1.
ccb.content.define_mutation {
    id = "MORE_PAIN",
    name = ccb.content.text("Pain Sensitive"),
    description = ccb.content.text("For some reason, things always seem to hurt you more.  Pain dealt to you is increased by 25%."),
    categories = { "CEPHALOPOD" },
    types = { "PAIN" },
    replacements = { "MORE_PAIN2" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_MORE_PAIN_0" },
}

ccb.content.define_mutation {
    id = "MORE_PAIN2",
    name = ccb.content.text("Hyperalgesia"),
    description = ccb.content.text("Your body experiences pain out of proportion to the physical causes.  Pain dealt to you is increased by 50%."),
    types = { "PAIN" },
    prerequisites = { "MORE_PAIN" },
    replacements = { "MORE_PAIN3" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_MORE_PAIN2_0" },
}

ccb.content.define_mutation {
    id = "MORE_PAIN3",
    name = ccb.content.text("Extreme Hyperalgesia"),
    description = ccb.content.text("Your body reacts cripplingly to any source of pain.  Pain dealt to you is doubled."),
    types = { "PAIN_RECOVERY" },
    prerequisites = { "MORE_PAIN2" },
    points = -5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_MORE_PAIN3_0" },
}

ccb.content.define_mutation {
    id = "XXXL",
    name = ccb.content.text("Weight: XXXL"),
    description = ccb.content.text("You gained an awful lot of weight before the Cataclysm.  Whatever the reason, now that mobility is key to survival, your bloated figure presents an additional danger.  You need to lose weight or die trying."),
    cancels = { "XS" },
    points = -1,
    player_display = false,
    starting_trait = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "XS",
    name = ccb.content.text("Weight: XS"),
    description = ccb.content.text("You lost an awful lot of weight before the Cataclysm.  Whatever the reason, now that food is not always close at hand, your skeletal figure presents an additional danger.  You need to gain weight or die trying."),
    cancels = { "XXXL" },
    points = -1,
    player_display = false,
    starting_trait = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VERY_SHORT",
    name = ccb.content.text("Very Short"),
    description = ccb.content.text("You are significantly shorter than the general population.  You can't carry quite as much as a person of average height and you need special accommodations to drive a car, but otherwise being little isn't too much of a bother."),
    categories = { "MOUSE", "RABBIT" },
    types = { "SIZE" },
    replacements = { "SMALL" },
    points = 0,
    mixed_effect = true,
    starting_trait = true,
    vitamin_cost = 175,
    visibility = 4,
    flags = { "SMALL" },
    enchantments = { "INLINE_ENCH_VERY_SHORT_0" },
}

ccb.content.define_mutation {
    id = "VERY_TALL",
    name = ccb.content.text("Very Tall"),
    description = ccb.content.text("You are significantly taller than the general population.  This leaves you with high blood pressure, a big appetite, and some minor health concerns, but you can carry a bit more than normal."),
    categories = { "URSINE", "CATTLE", "LIZARD", "CHIMERA", "CRUSTACEAN" },
    types = { "SIZE" },
    replacements = { "LARGE", "HUGE" },
    points = 0,
    mixed_effect = true,
    starting_trait = true,
    vitamin_cost = 175,
    visibility = 1,
    flags = { "LARGE" },
    enchantments = { "INLINE_ENCH_VERY_TALL_0" },
}

ccb.content.define_mutation {
    id = "NIGHTVISION",
    name = ccb.content.text("Night Vision"),
    description = ccb.content.text("You possess natural night vision, and can see further in the dark than most.  Activate to toggle NV-visible areas on or off."),
    categories = {
        "BIRD", "CATTLE", "INSECT", "BATRACHIAN", "FISH", "BEAST", "RAT", "CHIMERA", "LUPINE", "MOUSE",
        "SPIDER", "TROGLOBITE", "INTERSTICE",
    },
    types = { "VISION" },
    replacements = { "NIGHTVISION2" },
    points = 3,
    starting_trait = true,
    active = true,
    starts_active = true,
    vitamin_cost = 210,
    cancels = { "ELFA_NV", "ELFA_FNV", "FEL_NV", "CEPH_VISION" },
}

ccb.content.define_mutation {
    id = "NIGHTVISION2",
    name = ccb.content.text("High Night Vision"),
    description = ccb.content.text("You can see incredibly well in the dark!  Activate to toggle NV-visible areas on or off."),
    categories = {
        "FISH",
        "BEAST",
        "INSECT",
        "RAT",
        "CHIMERA",
        "LUPINE",
        "MOUSE",
        "TROGLOBITE",
        "SPIDER",
        "INTERSTICE",
    },
    types = { "VISION" },
    prerequisites = { "NIGHTVISION" },
    replacements = { "NIGHTVISION3" },
    points = 4,
    active = true,
    starts_active = true,
    vitamin_cost = 190,
    cancels = { "ELFA_NV", "ELFA_FNV", "FEL_NV", "CEPH_VISION" },
}

ccb.content.define_mutation {
    id = "NIGHTVISION3",
    name = ccb.content.text("Full Night Vision"),
    description = ccb.content.text("You can see in pitch blackness as if you were wearing night-vision goggles.  Activate to toggle NV-visible areas on or off."),
    categories = { "FISH", "TROGLOBITE", "SPIDER", "INSECT", "INTERSTICE" },
    types = { "VISION" },
    prerequisites = { "NIGHTVISION2" },
    additions = { "INFRARED" },
    points = 6,
    active = true,
    starts_active = true,
    vitamin_cost = 210,
    cancels = { "ELFA_NV", "ELFA_FNV", "FEL_NV", "CEPH_VISION" },
}

ccb.content.define_mutation {
    id = "MYOPIC",
    name = ccb.content.text("Near-Sighted"),
    description = ccb.content.text("Without glasses, your seeing radius is severely reduced!  However, you are guaranteed to start with a pair of glasses."),
    categories = { "BEAST" },
    cancels = { "URSINE_EYE", "MESOPIC" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    flags = { "MYOPIC" },
}

ccb.content.define_mutation {
    id = "HYPEROPIC",
    name = ccb.content.text("Far-Sighted"),
    description = ccb.content.text("Without reading glasses, you are unable to read anything, and take penalties on melee accuracy and electronics/tailoring crafting.  However, you are guaranteed to start with a pair of reading glasses."),
    cancels = { "MESOPIC" },
    points = -2,
    starting_trait = true,
    flags = { "HYPEROPIC" },
}

ccb.content.define_mutation {
    id = "MESOPIC",
    name = ccb.content.text("Mesopic"),
    description = ccb.content.text("You find it difficult to see very far in bright light.  On its own, this doesn't necessarily make you any better in the dark."),
    categories = { "CHIROPTERAN", "TROGLOBITE", "INTERSTICE" },
    cancels = { "MYOPIC", "HYPEROPIC" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "MYOPIC_IN_LIGHT" },
}

-- Can't change the ID as that breaks save-compatibility.
ccb.content.define_mutation {
    id = "EAGLEEYED",
    name = ccb.content.text("Scout"),
    description = ccb.content.text("You're an excellent navigator and your ability to recognize distant landmarks is unmatched.  Your sight radius on the overmap extends beyond the normal range."),
    categories = { "BIRD", "MOUSE", "CEPHALOPOD" },
    cancels = { "UNOBSERVANT" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_EAGLEEYED_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_VISION",
    name = ccb.content.text("Tenebrous Sight"),
    description = ccb.content.text("Useless things like light have no bearing on your ability to navigate the universe."),
    categories = { "INTERSTICE" },
    cancels = { "UNOBSERVANT" },
    prerequisites = { "INTERSTICEEYES" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    points = 1,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_INTERSTICE_VISION_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_VISION2",
    name = ccb.content.text("Ontological Sight"),
    description = ccb.content.text("You've become attuned to the folds and gaps in the world and you now detect nearby creatures through them."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_VISION" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_INTERSTICE_VISION2_0" },
}

ccb.content.define_mutation {
    id = "UNOBSERVANT",
    name = ccb.content.text("Topographagnosia"),
    description = ccb.content.text("Focal brain damage has rendered you incapable of recognizing landmarks and orienting yourself in your surroundings, severely crippling your sight radius on the overmap."),
    cancels = { "EAGLEEYED" },
    points = -1,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_UNOBSERVANT_0" },
}

ccb.content.define_mutation {
    id = "HEAVYSLEEPER",
    name = ccb.content.text("Heavy Sleeper"),
    description = ccb.content.text("You're quite the heavy sleeper.  Noises are unlikely to wake you up."),
    categories = { "INSECT", "PLANT", "MEDICAL", "LUPINE", "BEAST", "URSINE", "INTERSTICE" },
    replacements = { "HEAVYSLEEPER2" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "HEAVYSLEEPER2",
    name = ccb.content.text("Very Heavy Sleeper"),
    description = ccb.content.text("You could probably sleep through a firefight."),
    categories = { "BEAST", "LUPINE", "URSINE", "INTERSTICE" },
    prerequisites = { "HEAVYSLEEPER" },
    points = -2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SLEEPY",
    name = ccb.content.text("Sleepy"),
    description = ccb.content.text("You need sleep more often, but still spend most of your time awake."),
    categories = { "BEAST", "CHIMERA", "MOUSE", "RABBIT", "FELINE", "RAT", "INTERSTICE" },
    types = { "SLEEP" },
    replacements = { "SLEEPY2", "MET_RAT" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_SLEEPY_0" },
}

ccb.content.define_mutation {
    id = "SLEEPY2",
    name = ccb.content.text("Very Sleepy"),
    description = ccb.content.text("You find yourself needing to sleep quite often.  You'll spend about half of your time in or around a bed."),
    categories = { "FELINE", "INTERSTICE" },
    types = { "SLEEP" },
    prerequisites = { "SLEEPY" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_SLEEPY2_0" },
}

ccb.content.define_mutation {
    id = "WAKEFUL",
    name = ccb.content.text("Less Sleep"),
    description = ccb.content.text("You need less sleep than the average person."),
    categories = { "ALPHA", "ELFA", "PLANT", "BATRACHIAN" },
    types = { "SLEEP" },
    replacements = { "WAKEFUL2" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_WAKEFUL_0" },
}

ccb.content.define_mutation {
    id = "WAKEFUL2",
    name = ccb.content.text("Very Little Sleep"),
    description = ccb.content.text("You don't sleep often.  But when you do, you need very little of it."),
    categories = { "ALPHA", "ELFA", "BATRACHIAN" },
    types = { "SLEEP" },
    prerequisites = { "WAKEFUL" },
    replacements = { "WAKEFUL3" },
    threshold_requirements = { "THRESH_ALPHA", "THRESH_ELFA", "THRESH_BATRACHIAN" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_WAKEFUL2_0" },
}

ccb.content.define_mutation {
    id = "WAKEFUL3",
    name = ccb.content.text("Tireless"),
    description = ccb.content.text("You defend the realm all night and all day."),
    categories = { "ELFA" },
    types = { "SLEEP" },
    prerequisites = { "WAKEFUL2" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_WAKEFUL3_0" },
}

ccb.content.define_mutation {
    id = "EASYSLEEPER",
    name = ccb.content.text("Accomplished Sleeper"),
    description = ccb.content.text("You have always been able to fall asleep easily, even when sleeping in less than ideal circumstances."),
    categories = { "MOUSE", "INSECT", "GASTROPOD", "RABBIT" },
    types = { "SLEEPINESS" },
    replacements = { "EASYSLEEPER2" },
    cancels = { "INSOMNIA" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_EASYSLEEPER_0" },
}

ccb.content.define_mutation {
    id = "EASYSLEEPER2",
    name = ccb.content.text("Practiced Sleeper"),
    description = ccb.content.text("Your body's demanding energy needs mean you can fall asleep just about anywhere."),
    categories = { "MOUSE", "RABBIT" },
    types = { "SLEEPINESS" },
    prerequisites = { "MET_RAT" },
    threshold_requirements = { "THRESH_MOUSE", "THRESH_RABBIT" },
    cancels = { "INSOMNIA" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_EASYSLEEPER2_0" },
}

ccb.content.define_mutation {
    id = "ALBINO",
    name = ccb.content.text("Albino"),
    description = ccb.content.text("You lack skin pigmentation due to a genetic problem.  You sunburn extremely easily, and typically use an umbrella and sunglasses when going out in the sun."),
    categories = { "TROGLOBITE", "MOUSE", "RABBIT" },
    types = { "skin_tone" },
    replacements = { "SUNBURN" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "ALBINO" },
}

ccb.content.define_mutation {
    id = "ASTHMA",
    name = ccb.content.text("Asthmatic"),
    description = ccb.content.text("You will occasionally need to use an inhaler, or else suffer severe physical limitations.  However, you are guaranteed to start with an inhaler."),
    points = -4,
    starting_trait = true,
    valid = false,
    social_modifiers = { intimidate = -2 },
}

ccb.content.define_mutation {
    id = "SEASONAL_ALLERGIES",
    name = ccb.content.text("Seasonal Allergies"),
    description = ccb.content.text("You tend to get hay fever, especially in springtime.  Antihistamines are your friend."),
    categories = { "CHIMERA", "BEAST" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "WOOLALLERGY",
    name = ccb.content.text("Wool Allergy"),
    description = ccb.content.text("You are badly allergic to wool, and cannot wear any clothing made of the substance."),
    points = -1,
    starting_trait = true,
    valid = true,
}

ccb.content.define_mutation {
    id = "NO_CBM_INSTALLATION",
    name = ccb.content.text("Oversensitive System"),
    description = ccb.content.text("While it doesn't cause you any problems in daily life, your immune system and body chemistry are overly sensitive to foreign implants.  You cannot have any CBMs installed."),
    cancels = { "CBM_Interface", "Hub01_CBM_Interface", "NL_CBM_Interface" },
    points = -8,
    player_display = true,
    starting_trait = true,
    purifiable = false,
    flags = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "CHEMIMBALANCE",
    name = ccb.content.text("Chemical Imbalance"),
    description = ccb.content.text("You suffer from a minor chemical imbalance, whether mental or physical.  Minor changes to your internal chemistry will manifest themselves on occasion, such as hunger, sleepiness, narcotic effects, etc."),
    categories = { "SLIME", "MEDICAL", "CHIMERA", "ELFA" },
    points = -2,
    starting_trait = true,
    chargen_allow_npc = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "WEAKSCENT",
    name = ccb.content.text("Weak Scent"),
    description = ccb.content.text("Your scent is quite weak.  Animals that track your scent will do so with more difficulty."),
    categories = { "ALPHA" },
    types = { "SCENT" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    scent_intensity = 300,
}

ccb.content.define_mutation {
    id = "SMELLY",
    name = ccb.content.text("Strong Scent"),
    description = ccb.content.text("Your scent is particularly strong.  It's not offensive to humans, but animals that track your scent will do so more easily."),
    categories = {
        "FELINE", "LUPINE", "MOUSE", "BEAST", "SLIME", "CHIMERA", "URSINE", "BATRACHIAN", "FISH",
        "INSECT", "CATTLE", "CRUSTACEAN",
    },
    types = { "SCENT" },
    replacements = { "SMELLY2" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    scent_intensity = 800,
}

ccb.content.define_mutation {
    id = "SMELLY2",
    name = ccb.content.text("Smelly"),
    description = ccb.content.text("You smell awful.  Monsters that track scent will find you very easily, and humans will react poorly."),
    categories = {
        "FISH",
        "BEAST",
        "SLIME",
        "CHIMERA",
        "URSINE",
        "BATRACHIAN",
        "INSECT",
        "CATTLE",
        "CRUSTACEAN",
    },
    types = { "SCENT" },
    prerequisites = { "SMELLY" },
    additions = { "PHEROMONE_INSECT", "PHEROMONE_MAMMAL", "PHEROMONE_AMPHIBIAN" },
    points = -2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 5,
    scent_intensity = 1200,
}

ccb.content.define_mutation {
    id = "HUNGER",
    name = ccb.content.text("Fast Metabolism"),
    description = ccb.content.text("You require more food than most people, but recover stamina slightly faster."),
    categories = { "RAT", "ALPHA", "MEDICAL", "ELFA", "BEAST", "SLIME", "RAPTOR", "CHIMERA", "MOUSE", "RABBIT" },
    types = { "METABOLISM" },
    replacements = { "HUNGER2", "MET_RAT" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_HUNGER_0" },
}

ccb.content.define_mutation {
    id = "HUNGER2",
    name = ccb.content.text("Very Fast Metabolism"),
    description = ccb.content.text("You need about twice as much food as the average human to maintain your expanded cardiovascular and respiratory systems.  On the plus side, it doesn't take you much time to recover from any strenuous activity."),
    categories = { "BEAST", "SLIME", "RAPTOR", "CHIMERA" },
    types = { "METABOLISM" },
    prerequisites = { "HUNGER" },
    replacements = { "HUNGER3" },
    points = -2,
    vitamin_cost = 250,
    enchantments = { "INLINE_ENCH_HUNGER2_0" },
}

ccb.content.define_mutation {
    id = "HUNGER3",
    name = ccb.content.text("Extreme Metabolism"),
    description = ccb.content.text("You consume three times as much food as the average human to maintain your truly superhuman endurance."),
    categories = { "CHIMERA" },
    types = { "METABOLISM" },
    prerequisites = { "HUNGER2" },
    additions = { "EATHEALTH" },
    points = -2,
    vitamin_cost = 250,
    enchantments = { "INLINE_ENCH_HUNGER3_0" },
}

ccb.content.define_mutation {
    id = "THIRST",
    name = ccb.content.text("High Thirst"),
    description = ccb.content.text("Your body dries out easily; you need to drink more water."),
    categories = { "SLIME", "CEPHALOPOD", "CHIMERA", "ELFA", "GASTROPOD", "FISH", "BATRACHIAN", "CRUSTACEAN" },
    types = { "THIRST" },
    replacements = { "THIRST2" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_THIRST_0" },
}

ccb.content.define_mutation {
    id = "THIRST2",
    name = ccb.content.text("Very Thirsty"),
    description = ccb.content.text("Ugh, out of water already?  You need about twice the fluids of an average human."),
    categories = { "FISH", "SLIME", "CEPHALOPOD", "BATRACHIAN", "CRUSTACEAN" },
    types = { "THIRST" },
    prerequisites = { "THIRST" },
    replacements = { "THIRST3" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_THIRST2_0" },
}

ccb.content.define_mutation {
    id = "THIRST3",
    name = ccb.content.text("Extremely Thirsty"),
    description = ccb.content.text("You dry out seriously quickly, requiring three times as much liquid to stay hydrated."),
    categories = { "BATRACHIAN", "CRUSTACEAN" },
    types = { "THIRST" },
    prerequisites = { "THIRST2" },
    threshold_requirements = { "THRESH_BATRACHIAN", "THRESH_CRUSTACEAN" },
    points = -5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_THIRST3_0" },
}

ccb.content.define_mutation {
    id = "TINYSTOMACH",
    name = ccb.content.text("Tiny Stomach"),
    description = ccb.content.text("Either as the result of a lifesaving surgery, or as a congenital defect, your stomach is much smaller than usual.  You'll have to eat your food in small servings during the day, rather than one or two large daily meals."),
    points = -3,
    starting_trait = true,
    active = false,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TINYSTOMACH_0" },
}

-- nope.  This does NOT lead to EATPOISON.  Stomach problems are part of the GI upgrades--one advantage to not having Robust Genetics.
ccb.content.define_mutation {
    id = "STRONGSTOMACH",
    name = ccb.content.text("Strong Stomach"),
    description = ccb.content.text("You are less likely to throw up from food poisoning, alcohol, etc.  If you throw up despite this, you won't suffer any residual nausea."),
    types = { "CONSTITUTION" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_STRONGSTOMACH_0" },
}

ccb.content.define_mutation {
    id = "WEAKSTOMACH",
    name = ccb.content.text("Weak Stomach"),
    description = ccb.content.text("You are more likely to throw up from food poisoning, alcohol, etc."),
    categories = {
        "ALPHA", "SLIME", "RAT", "MEDICAL", "ELFA", "BATRACHIAN", "TROGLOBITE", "RAPTOR", "CHIMERA",
        "GASTROPOD", "CRUSTACEAN",
    },
    types = { "CONSTITUTION" },
    additions = { "NAUSEA" },
    replacements = { "EATPOISON" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_WEAKSTOMACH_0" },
}

-- Nauseous means 'to induce nausea.'
ccb.content.define_mutation {
    id = "NAUSEA",
    name = ccb.content.text("Nausea"),
    description = ccb.content.text("You feel nauseated almost constantly, and are more liable to throw up from food poisoning, alcohol, etc.  You can, if desired, think yourself into vomiting, too."),
    categories = {
        "ALPHA", "SLIME", "RAT", "MEDICAL", "ELFA", "BATRACHIAN", "TROGLOBITE", "RAPTOR", "CHIMERA",
        "GASTROPOD", "CRUSTACEAN",
    },
    types = { "CONSTITUTION" },
    prerequisites = { "WEAKSTOMACH" },
    replacements = { "VOMITOUS" },
    points = -2,
    active = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_NAUSEA_0" },
}

ccb.content.define_mutation {
    id = "VOMITOUS",
    name = ccb.content.text("Vomitous"),
    description = ccb.content.text("You have a major digestive disorder.  Though it causes you to vomit frequently, you have found that you can trigger your vomit reflex on demand, too."),
    categories = {
        "ALPHA", "SLIME", "RAT", "MEDICAL", "ELFA", "BATRACHIAN", "TROGLOBITE", "RAPTOR", "CHIMERA",
        "GASTROPOD", "CRUSTACEAN",
    },
    types = { "CONSTITUTION" },
    prerequisites = { "WEAKSTOMACH" },
    secondary_prerequisites = { "NAUSEA" },
    replacements = { "EATPOISON" },
    points = -3,
    active = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_VOMITOUS_0" },
}

ccb.content.define_mutation {
    id = "VEGETARIAN",
    name = ccb.content.text("Meat Intolerance"),
    description = ccb.content.text("You have problems with eating meat.  It's possible for you to eat it, but you will suffer morale penalties and obtain less nutrition from it."),
    categories = { "CATTLE", "RABBIT" },
    types = { "DIET" },
    replacements = { "HERBIVORE" },
    cancels = { "CANNIBAL", "STRICT_HUMANITARIAN", "VEGAN" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    vitamin_absorption = { flesh = { vitC = 0, calcium = 0, iron = 0 } },
}

ccb.content.define_mutation {
    id = "VEGAN",
    name = ccb.content.text("Vegan"),
    description = ccb.content.text("You're very strictly vegan, eating animal products is out of the question, even if it means death.  You also can't bear to wear clothing made of animal products, such as leather or fur."),
    types = { "DIET" },
    cancels = { "CANNIBAL", "STRICT_HUMANITARIAN", "VEGETARIAN" },
    points = -4,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "MEATARIAN",
    name = ccb.content.text("Hates Vegetables"),
    description = ccb.content.text("You have problems with eating vegetables.  It's possible for you to eat them, but you will suffer morale penalties and obtain less nutrition from them."),
    cancels = { "HERBIVORE", "RUMINANT", "GRAZER" },
    points = -2,
    starting_trait = true,
    valid = false,
    vitamin_absorption = { veggy = { vitC = 0, calcium = 0, iron = 0 } },
}

ccb.content.define_mutation {
    id = "ANTIFRUIT",
    name = ccb.content.text("Fructose Intolerance"),
    description = ccb.content.text("Eating fruits always causes your stomach to ache.  It's possible for you to eat them, but you will suffer morale penalties and obtain less nutrition from them."),
    cancels = { "HERBIVORE", "RUMINANT", "GRAZER" },
    points = -3,
    starting_trait = true,
    valid = false,
    vitamin_absorption = { fruit = { vitC = 0, calcium = 0, iron = 0 } },
}

ccb.content.define_mutation {
    id = "LACTOSE",
    name = ccb.content.text("Lactose Intolerance"),
    description = ccb.content.text("You, like 75 percent of the world, cannot tolerate milk or milk based products.  It's possible for you to eat them, but you will suffer morale penalties and obtain less nutrition from them."),
    points = -1,
    starting_trait = true,
    vitamin_absorption = { milk = { vitC = 0, calcium = 0, iron = 0 } },
}

ccb.content.define_mutation {
    id = "ANTIJUNK",
    name = ccb.content.text("Junkfood Intolerance"),
    description = ccb.content.text("Something in those heavily processed foods doesn't agree with you.  It's possible for you to eat them, but you will suffer morale penalties and obtain less nutrition from them."),
    categories = { "RAPTOR", "ALPHA", "ELFA", "RABBIT", "GASTROPOD", "CHIROPTERAN" },
    cancels = { "PROJUNK" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    vitamin_absorption = { junk = { vitC = 0, calcium = 0, iron = 0 } },
}

-- Add Lupine to category in a followup PR
ccb.content.define_mutation {
    id = "ANTIWHEAT",
    name = ccb.content.text("Grain Intolerance"),
    description = ccb.content.text("You have a rare allergy that prevents you from eating wheat.  It's possible for you to eat wheat-based products, but you will suffer morale penalties and obtain less nutrition from them."),
    categories = { "CHIROPTERAN" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    vitamin_absorption = { wheat = { vitC = 0, calcium = 0, iron = 0 } },
}

ccb.content.define_mutation {
    id = "CANNIBAL",
    name = ccb.content.text("Cannibal"),
    description = ccb.content.text("For your whole life you've been forbidden from indulging in your peculiar tastes.  Now the world's ended, and you'll be damned if anyone is going to tell you that you can't eat people."),
    cancels = { "VEGETARIAN", "VEGAN", "HERBIVORE", "RUMINANT", "GRAZER" },
    points = 2,
    random_start_allowed = false,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
    flags = { "CANNIBAL" },
}

ccb.content.define_mutation {
    id = "STRICT_HUMANITARIAN",
    name = ccb.content.text("Strict Humanitarian"),
    description = ccb.content.text("You're convinced that these things that look vaguely human from elsewhere are definitely not people.  Therefore it's okay to eat them, right?"),
    cancels = { "VEGETARIAN", "VEGAN", "HERBIVORE", "RUMINANT", "GRAZER", "CANNIBAL" },
    points = 1,
    random_start_allowed = false,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
    flags = { "STRICT_HUMANITARIAN" },
}

ccb.content.define_mutation {
    id = "PROJUNK",
    name = ccb.content.text("Sweet Tooth"),
    description = ccb.content.text("You have a soft spot for processed foods, and gain a morale bonus from eating them."),
    categories = { "MOUSE", "INSECT" },
    replacements = { "PROJUNK2" },
    cancels = { "ANTIJUNK" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "PROJUNK2",
    name = ccb.content.text("Sugar-Loving"),
    description = ccb.content.text("You *adore* the taste of junk food, and find it preferable to everything else!"),
    categories = { "MOUSE" },
    prerequisites = { "PROJUNK" },
    threshold_requirements = { "THRESH_MOUSE" },
    cancels = { "ANTIJUNK" },
    points = 2,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "SKIP_HEALTH" },
}

ccb.content.define_mutation {
    id = "GOURMAND",
    name = ccb.content.text("Gourmand"),
    description = ccb.content.text("You eat faster, and can eat and drink more, than anyone else!  You also enjoy food more; delicious food is better for your morale, and you don't mind unsavory meals as much.  Activate to skip prompt for overeating."),
    categories = { "MOUSE", "LUPINE" },
    cancels = { "PICKYEATER" },
    points = 2,
    starting_trait = true,
    active = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_GOURMAND_0" },
}

ccb.content.define_mutation {
    id = "LIGHTEATER",
    name = ccb.content.text("Light Eater"),
    description = ccb.content.text("Your metabolism is a little slower, and you require less food than most."),
    categories = { "FISH", "BIRD", "TROGLOBITE", "CHIROPTERAN", "GASTROPOD", "CEPHALOPOD", "RAPTOR" },
    types = { "METABOLISM" },
    replacements = { "GIZZARD" },
    cancels = { "MET_RAT" },
    points = 2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_LIGHTEATER_0" },
}

ccb.content.define_mutation {
    id = "PICKYEATER",
    name = ccb.content.text("Picky Eater"),
    description = ccb.content.text("You're a very picky eater.  You refuse to eat any food that tastes bad unless you're starving."),
    categories = { "ALPHA" },
    cancels = { "GOURMAND" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "TABLEMANNERS",
    name = ccb.content.text("Rigid Table Manners"),
    description = ccb.content.text("You've been taught proper table manners from your early childhood on; now, you can't even think about eating without being seated at a table and taking your time.  Eating without a table and chair frustrates you, but eating like a civilized person gives you a bigger morale bonus."),
    points = -1,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
    enchantments = { "INLINE_ENCH_TABLEMANNERS_0" },
}

ccb.content.define_mutation {
    id = "NONADDICTIVE",
    name = ccb.content.text("Addiction Resistant"),
    description = ccb.content.text("Whether due to a lifetime of exposure or through simple willpower, it's harder for you to become addicted to substances, and easier to rid yourself of these addictions."),
    categories = { "BATRACHIAN" },
    cancels = { "ADDICTIVE" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "ADDICTIVE",
    name = ccb.content.text("Addictive Personality"),
    description = ccb.content.text("It's easier for you to become addicted to substances, and harder to rid yourself of these addictions."),
    categories = { "MEDICAL" },
    cancels = { "NONADDICTIVE" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TOLERANCE",
    name = ccb.content.text("Substance Tolerance"),
    description = ccb.content.text("You can handle intoxicants well.  Their effects clear up more quickly for you."),
    categories = { "TROGLOBITE", "RAPTOR", "RAT", "CHIMERA", "BATRACHIAN", "CRUSTACEAN" },
    additions = { "ALCMET" },
    cancels = { "LIGHTWEIGHT" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    vitamin_intervals = { BAC = 30 },
}

ccb.content.define_mutation {
    id = "LIGHTWEIGHT",
    name = ccb.content.text("Lightweight"),
    description = ccb.content.text("Alcohol and drugs go straight to your head.  You suffer the negative effects of these for longer."),
    categories = { "MEDICAL", "INSECT" },
    cancels = { "TOLERANCE" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    vitamin_intervals = { BAC = -40 },
}

ccb.content.define_mutation {
    id = "CLUMSY",
    name = ccb.content.text("Clumsy"),
    description = ccb.content.text("You make more noise while walking.  You're also more likely to set off traps."),
    categories = { "CRUSTACEAN" },
    cancels = { "LIGHTSTEP" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_CLUMSY_0" },
}

ccb.content.define_mutation {
    id = "JITTERY",
    name = ccb.content.text("Jittery"),
    description = ccb.content.text("When very hungry or under the effects of stimulants, you may find your hands shaking uncontrollably, severely reducing your Dexterity."),
    categories = { "MEDICAL", "MOUSE", "RABBIT" },
    points = -3,
    starting_trait = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SCHIZOPHRENIC",
    name = ccb.content.text("Kaluptic Psychosis"),
    description = ccb.content.text("Ever since the sky first broke, you have felt unwell, your head split by alien thoughts.  You will periodically suffer from delusions, ranging from minor effects to full visual hallucinations.  Some of these effects may be controlled through the use of antipsychotics."),
    categories = { "MEDICAL", "INTERSTICE" },
    points = -3,
    starting_trait = true,
    chargen_allow_npc = false,
    purifiable = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "NARCOLEPTIC",
    name = ccb.content.text("Narcoleptic"),
    description = ccb.content.text("You randomly fall asleep without any reason."),
    categories = { "MEDICAL" },
    points = -3,
    starting_trait = true,
    chargen_allow_npc = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "PSYCHOPATH",
    name = ccb.content.text("Morbid Unconcern"),
    description = ccb.content.text("You don't feel any strong feelings for your fellow man.  You have no empathy.  The suffering of others doesn't bother you at all.  You don't mind if others are butchered or left unburied unless it affects yourself.  You also feel no mood boost from socializing."),
    types = { "HUMAN_EMPATHY" },
    cancels = { "SOCIAL1", "SOCIAL2" },
    points = 2,
    mixed_effect = true,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
    flags = { "PSYCHOPATH" },
    social_modifiers = { lie = -5, persuade = -5 },
}

ccb.content.define_mutation {
    id = "PYROMANIA",
    name = ccb.content.text("Pyromaniac"),
    description = ccb.content.text("You have an unhealthy obsession with fire, and you get anxious if you don't light them every now and then or stand near them often.  However, you gain a mood bonus from doing so."),
    points = -2,
    starting_trait = true,
    chargen_allow_npc = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "INSENSITIVITY",
    name = ccb.content.text("Insensitivity"),
    description = ccb.content.text("Perhaps from seeing too much, killing too much, or harvesting too much from those who used to look like you.  You have grown numb to what ordinary people call immoral.  Murder no longer burdens your conscience.  Harvesting resources from bloody corpses or even feeding on your own kind doesn't disgust you like it used to.  In normal times, this would be a tragic turn, but perhaps not after the Cataclysm."),
    points = 0,
    starting_trait = false,
    chargen_allow_npc = false,
    valid = false,
    purifiable = false,
    flags = { "INSENSITIVITY" },
}

ccb.content.define_mutation {
    id = "INSOMNIA",
    name = ccb.content.text("Insomniac"),
    description = ccb.content.text("You have a hard time falling asleep, even under the best circumstances!"),
    categories = { "MEDICAL", "ALPHA" },
    types = { "SLEEPINESS" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_INSOMNIA_0" },
}

ccb.content.define_mutation {
    id = "WAYFARER",
    name = ccb.content.text("Wayfarer"),
    description = ccb.content.text("Whether from personal choice or childhood trauma, traveling with vehicles is off-limits to you, even if your life depended on it."),
    points = -8,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "COMPUTER_ILLITERATE",
    name = ccb.content.text("Computer Illiterate"),
    description = ccb.content.text("You just never really figured out how to use those infernal devices.  You cannot use computer terminals and cannot raise the computer skill above 0."),
    points = -5,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_COMPUTER_ILLITERATE_0" },
    flags = { "CANNOT_USE_COMPUTERS" },
}

ccb.content.define_mutation {
    id = "PACIFIST",
    name = ccb.content.text("Pacifist"),
    description = ccb.content.text("You don't like thinking about violence.  Your combat skills advance much slower than usual, and you feel more guilt about killing."),
    types = { "HUMAN_EMPATHY", "PREDATION" },
    points = -4,
    starting_trait = true,
    valid = false,
    social_modifiers = { intimidate = -10 },
}

ccb.content.define_mutation {
    id = "BRAWLER",
    name = ccb.content.text("Brawler"),
    description = ccb.content.text("Whether from personal choice or childhood trauma, using ranged weapons is off-limits to you, even if your life depended on it."),
    cancels = { "GUNSHY" },
    points = -4,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "GUNSHY",
    name = ccb.content.text("Gun-Shy"),
    description = ccb.content.text("Using a firearm is off limits, due to personal philosophy or a traumatic event.  You can still use bows and slings."),
    cancels = { "BRAWLER" },
    points = -3,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "HOARDER",
    name = ccb.content.text("Hoarder"),
    description = ccb.content.text("You don't feel right unless you're carrying a bunch of stuff.  You want to always have the right tool for every occasion, whether that's a knife, a gas mask, fresh water, a crowbar, or jelly babies.  If you can't be well stocked, then even carrying junk helps keep the horrible thoughts quiet.  Xanax can help control this anxiety."),
    points = -2,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "INATTENTIVE",
    name = ccb.content.text("Inattentive"),
    description = ccb.content.text("You never paid attention to your surroundings and specifically to people around you.  You can't judge the intent of critters you see."),
    points = -2,
    starting_trait = true,
    purifiable = false,
    valid = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SPIRITUAL",
    name = ccb.content.text("Spiritual"),
    description = ccb.content.text("You've always felt that there is more to the world than we can see.  Whether driven by religious beliefs or philosophical interest, you find great inspiration in studying holy texts and experiencing mystical things."),
    points = 1,
    starting_trait = true,
    valid = false,
    flags = { "SPIRITUAL" },
    social_modifiers = { persuade = 5 },
}

ccb.content.define_mutation {
    id = "NYCTOPHOBIA",
    name = ccb.content.text("Nyctophobia"),
    description = ccb.content.text("You are terribly afraid of the dark.  You refuse to enter very dark areas.  If you somehow still happen to stay in dark areas, you suffer from various detrimental mental and physical effects."),
    points = -3,
    starting_trait = true,
    purifiable = false,
    valid = false,
    flags = { "NYCTOPHOBIA" },
}

ccb.content.define_mutation {
    id = "SQUEAMISH",
    name = ccb.content.text("Squeamish"),
    description = ccb.content.text("You can't even think about putting filthy clothes on yourself, especially from zombies' corpses."),
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "OUTDOORSMAN",
    name = ccb.content.text("Outdoorsman"),
    description = ccb.content.text("You are accustomed to being exposed to the elements.  This decreases morale penalties for being wet."),
    points = 1,
    valid = false,
    vitamin_cost = 60,
    wet_protection = {
        { part = "head", neutral = 6 },
        { part = "leg_l", neutral = 8 },
        { part = "leg_r", neutral = 8 },
        { part = "foot_l", neutral = 2 },
        { part = "foot_r", neutral = 2 },
        { part = "arm_l", neutral = 8 },
        { part = "arm_r", neutral = 8 },
        { part = "hand_l", neutral = 12 },
        { part = "hand_r", neutral = 12 },
        { part = "torso", neutral = 10 },
    },
}

ccb.content.define_mutation {
    id = "NOMAD",
    name = ccb.content.text("Nomad"),
    description = ccb.content.text("You're too adventurous for your own good.  The more time you spend somewhere, the unhappier it makes you to be there."),
    categories = { "BIRD", "FISH", "CHIMERA" },
    types = { "WANDERLUST" },
    replacements = { "NOMAD2" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "NOMAD2",
    name = ccb.content.text("Antsy"),
    description = ccb.content.text("You can't bear to stay still for long.  Your morale will suffer unless you constantly explore new territory."),
    categories = { "BIRD", "FISH", "CHIMERA" },
    types = { "WANDERLUST" },
    prerequisites = { "NOMAD" },
    replacements = { "NOMAD3" },
    points = -2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "NOMAD3",
    name = ccb.content.text("Restless"),
    description = ccb.content.text("Spending any amount of time in familiar places makes you miserable.  Must.  Keep.  Moving."),
    categories = { "CHIMERA" },
    types = { "WANDERLUST" },
    prerequisites = { "NOMAD2" },
    points = -4,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "GOODMEMORY",
    name = ccb.content.text("Good Memory"),
    description = ccb.content.text("You have an exceptional memory, and find it easy to remember things.  This makes it easier to apply your theoretical knowledge when learning skills.  However, you don't benefit as much as other people from dropping a subject for a while and will thus end up learning slower."),
    types = { "MEMORY" },
    cancels = { "FORGETFUL" },
    points = 0,
    mixed_effect = true,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_GOODMEMORY_0" },
}

ccb.content.define_mutation {
    id = "FORGETFUL",
    name = ccb.content.text("Forgetful"),
    description = ccb.content.text("You have a hard time remembering things.  Your skills will erode slightly faster than usual, it's harder for you to apply your book-learning to the real world, and you have trouble keeping your story straight when lying."),
    categories = { "BEAST", "MEDICAL", "CHIMERA", "MOUSE", "INSECT", "RABBIT" },
    types = { "MEMORY" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
    social_modifiers = { lie = -5 },
    enchantments = { "INLINE_ENCH_FORGETFUL_0" },
}

ccb.content.define_mutation {
    id = "LOVES_BOOKS",
    name = ccb.content.text("Bookworm"),
    description = ccb.content.text("There's nothing quite like the smell of a good book!  Books are more fun (or less boring) for you!"),
    cancels = { "ILLITERATE", "HATES_BOOKS" },
    points = 1,
    valid = false,
}

ccb.content.define_mutation {
    id = "HATES_BOOKS",
    name = ccb.content.text("Hates Books"),
    description = ccb.content.text("Reading is for nerds!  Boring books are more boring, and you can't have fun by reading books."),
    cancels = { "ILLITERATE", "LOVES_BOOKS" },
    points = -1,
    valid = false,
}

ccb.content.define_mutation {
    id = "FASTREADER",
    name = ccb.content.text("Fast Reader"),
    description = ccb.content.text("You're a quick reader, and can get through books a lot faster than most."),
    cancels = { "ILLITERATE", "SLOWREADER" },
    points = 1,
    starting_trait = true,
    valid = false,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_FASTREADER_0" },
}

ccb.content.define_mutation {
    id = "SLOWREADER",
    name = ccb.content.text("Slow Reader"),
    description = ccb.content.text("You're a slow reader, and it takes you longer to get through books than most."),
    cancels = { "FASTREADER", "ILLITERATE" },
    points = -1,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_SLOWREADER_0" },
}

ccb.content.define_mutation {
    id = "ILLITERATE",
    name = ccb.content.text("Illiterate"),
    description = ccb.content.text("You struggle to read and understand written language.  Books, complex instructions, and most computer interfaces are effectively off-limits without help."),
    cancels = { "FASTREADER", "SLOWREADER", "PROF_DICEMASTER", "LOVES_BOOKS", "HATES_BOOKS" },
    points = -6,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "FASTLEARNER",
    name = ccb.content.text("Fast Learner"),
    description = ccb.content.text("You have a flexible mind, allowing you to learn skills much faster than others.  Note that this only applies to real-world experience, not to skill gain from other sources like books."),
    cancels = { "SLOWLEARNER" },
    points = 3,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_FASTLEARNER_0" },
}

ccb.content.define_mutation {
    id = "SLOWLEARNER",
    name = ccb.content.text("Slow Learner"),
    description = ccb.content.text("You are slow to grasp new ideas, and thus learn things more slowly than others.  Note that this only applies to real-world experience, not to skill gain from other sources like books."),
    cancels = { "FASTLEARNER" },
    points = -3,
    starting_trait = true,
    valid = false,
    enchantments = { "INLINE_ENCH_SLOWLEARNER_0" },
}

ccb.content.define_mutation {
    id = "SAVANT",
    name = ccb.content.text("Savant"),
    description = ccb.content.text("You tend to specialize in one skill and be poor at all others.  You advance at half speed in all skills except your best one.  Note that combining this with Fast Learner will come out to a slower rate of learning for all skills."),
    points = -4,
    starting_trait = true,
    valid = false,
}

ccb.content.define_mutation {
    id = "OPTIMISTIC",
    name = ccb.content.text("Optimist"),
    description = ccb.content.text("Nothing gets you down!  You savor the joys of life, ignore its hardships, and are generally happier than most people."),
    types = { "ATTITUDE" },
    points = 2,
    starting_trait = true,
    valid = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "BADTEMPER",
    name = ccb.content.text("Bad Temper"),
    description = ccb.content.text("Things just keep getting you down.  You tend to be unhappy, and it takes some doing to cheer you up."),
    categories = { "URSINE", "LIZARD", "CHIMERA", "ALPHA" },
    types = { "ATTITUDE" },
    points = -2,
    starting_trait = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "MOODSWINGS",
    name = ccb.content.text("Mood Swings"),
    description = ccb.content.text("Your morale will shift up and down at random, often dramatically."),
    categories = { "MEDICAL", "ELFA" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "SEASONAL_AFFECTIVE",
    name = ccb.content.text("Seasonal Affective Disorder"),
    description = ccb.content.text("You tend to have bouts of depression during the fall and especially winter.  Taking antidepressants can help."),
    categories = { "PLANT", "ELFA", "MEDICAL" },
    types = { "ATTITUDE" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "PRETTY",
    name = ccb.content.text("Pretty"),
    description = ccb.content.text("You are a sight to behold.  People who care about such things will react more kindly to you."),
    categories = { "ALPHA", "ELFA" },
    types = { "ATTRACTIVENESS" },
    replacements = { "BEAUTIFUL" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = -2,
}

ccb.content.define_mutation {
    id = "UGLY",
    name = ccb.content.text("Ugly"),
    description = ccb.content.text("You're not much to look at.  People who care about such things will react poorly to you."),
    categories = {
        "RAPTOR", "FELINE", "LUPINE", "BATRACHIAN", "FISH", "CATTLE", "INSECT", "CEPHALOPOD", "BEAST",
        "URSINE", "PLANT", "GASTROPOD", "SLIME", "RAT", "CHIMERA", "SPIDER", "CRUSTACEAN", "CHIROPTERAN",
    },
    types = { "ATTRACTIVENESS" },
    replacements = { "DEFORMED" },
    cancels = { "VANITY" },
    points = -1,
    starting_trait = true,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "BEAUTIFUL",
    name = ccb.content.text("Beautiful"),
    description = ccb.content.text("You're a real head-turner.  Some people will react well to your appearance, and most people have an easier time trusting you."),
    categories = { "ALPHA", "ELFA" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "PRETTY" },
    additions = { "VANITY" },
    replacements = { "BEAUTIFUL2" },
    points = 2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = -4,
}

ccb.content.define_mutation {
    id = "BEAUTIFUL2",
    name = ccb.content.text("Very Beautiful"),
    description = ccb.content.text("You are a vision of beauty.  Some people will react very well to your looks, and most people will trust you immediately."),
    categories = { "ALPHA", "ELFA" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "BEAUTIFUL" },
    additions = { "VANITY" },
    replacements = { "BEAUTIFUL3" },
    threshold_requirements = { "THRESH_ALPHA", "THRESH_ELFA" },
    points = 3,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = -7,
}

ccb.content.define_mutation {
    id = "BEAUTIFUL3",
    name = ccb.content.text("Glorious"),
    description = ccb.content.text("You are incredibly beautiful.  People cannot help themselves due to your charms, and will do whatever they can to please you."),
    categories = { "ELFA" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "BEAUTIFUL2" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 4,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -10,
}

ccb.content.define_mutation {
    id = "DEFORMED",
    name = ccb.content.text("Deformed"),
    description = ccb.content.text("You're slightly deformed.  Some people will react badly to your appearance."),
    categories = {
        "FISH", "CATTLE", "INSECT", "CEPHALOPOD", "FELINE", "LUPINE", "BATRACHIAN", "BEAST", "URSINE",
        "PLANT", "GASTROPOD", "SLIME", "RAT", "CHIMERA", "SPIDER", "CRUSTACEAN", "CHIROPTERAN",
    },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "UGLY" },
    replacements = { "DEFORMED2" },
    points = -2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 4,
}

ccb.content.define_mutation {
    id = "DEFORMED2",
    name = ccb.content.text("Badly Deformed"),
    description = ccb.content.text("You're hideously deformed.  Some people will have a strong negative reaction to your appearance."),
    categories = { "BEAST", "URSINE", "PLANT", "GASTROPOD", "SLIME", "RAT", "CHIMERA", "CRUSTACEAN" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "DEFORMED" },
    replacements = { "DEFORMED3" },
    points = -3,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 7,
}

ccb.content.define_mutation {
    id = "DEFORMED3",
    name = ccb.content.text("Grotesque"),
    description = ccb.content.text("Your visage is disgusting and liable to induce vomiting.  People will not want to interact with you unless they have a very good reason to."),
    categories = { "SLIME", "RAT", "CHIMERA" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "DEFORMED2" },
    threshold_requirements = { "THRESH_SLIME", "THRESH_RAT", "THRESH_CHIMERA" },
    purifiable = false,
    points = -4,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 10,
}

ccb.content.define_mutation {
    id = "DEFORMED_INTERSTICE",
    name = ccb.content.text("Gloam Presence"),
    description = ccb.content.text("Something about you and your muted features darkens minds and moods.  People will be very unwilling to engage with you."),
    categories = { "INTERSTICE" },
    types = { "ATTRACTIVENESS" },
    prerequisites = { "TERRIFYING" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    mixed_effect = true,
    points = 0,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 10,
}

ccb.content.define_mutation {
    id = "LIAR",
    name = ccb.content.text("Skilled Liar"),
    description = ccb.content.text("You have no qualms about bending the truth, and have practically no tells.  Telling lies and otherwise bluffing will be much easier for you."),
    cancels = { "TRUTHTELLER" },
    points = 1,
    social_modifiers = { lie = 40 },
}

ccb.content.define_mutation {
    id = "TRUTHTELLER",
    name = ccb.content.text("Truth Teller"),
    description = ccb.content.text("When you try to tell a lie, you blush, stammer, and get all shifty-eyed.  Telling lies and otherwise bluffing will be much more difficult for you."),
    cancels = { "LIAR" },
    points = -1,
    starting_trait = true,
    social_modifiers = { lie = -40 },
}

ccb.content.define_mutation {
    id = "SOCIAL1",
    name = ccb.content.text("Extrovert"),
    description = ccb.content.text("You don't mind being alone, but you get a slight mood boost from being around friends."),
    categories = { "CATTLE", "ELFA", "LUPINE", "MOUSE", "RAT", "CHIROPTERAN", "BIRD", "FISH" },
    types = { "SOCIAL" },
    replacements = { "SOCIAL2" },
    cancels = { "ASOCIAL1", "ASOCIAL2" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "SOCIAL1" },
}

ccb.content.define_mutation {
    id = "SOCIAL2",
    name = ccb.content.text("Sociable"),
    description = ccb.content.text("You are a social creature.  Spending time with friends will improve your mood, but if you're alone too long, you'll start to feel unhappy."),
    categories = { "CATTLE", "LUPINE", "MOUSE", "RAT", "CHIROPTERAN", "ELFA" },
    types = { "SOCIAL" },
    cancels = { "ASOCIAL1", "ASOCIAL2" },
    points = 1,
    mixed_effect = true,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "SOCIAL2" },
}

ccb.content.define_mutation {
    id = "ASOCIAL1",
    name = ccb.content.text("Introvert"),
    description = ccb.content.text("You can tolerate others, but you prefer to be alone.  Spending time by yourself will boost your mood slightly."),
    categories = { "SPIDER", "URSINE", "FELINE", "LIZARD", "BEAST", "CHIMERA", "INTERSTICE" },
    types = { "SOCIAL" },
    replacements = { "ASOCIAL2" },
    cancels = { "SOCIAL1", "SOCIAL2" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "ASOCIAL1" },
}

ccb.content.define_mutation {
    id = "ASOCIAL2",
    name = ccb.content.text("Loner"),
    description = ccb.content.text("You'd really rather be by yourself.  Being alone will improve your mood, but spending too much time around other people can grate on your nerves."),
    categories = { "SPIDER", "URSINE", "LIZARD", "BEAST", "INTERSTICE" },
    types = { "SOCIAL" },
    cancels = { "SOCIAL1", "SOCIAL2" },
    points = 1,
    mixed_effect = true,
    starting_trait = true,
    vitamin_cost = 60,
    flags = { "ASOCIAL2" },
}

ccb.content.define_mutation {
    id = "CHANGING",
    name = ccb.content.text_without_extraction("Changing"),
    description = ccb.content.text_without_extraction("You shouldn't see this.  This makes you mutate."),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
    flags = { "CHANGING" },
}

ccb.content.define_mutation {
    id = "THRESH_FISH",
    name = ccb.content.text("Aquatic"),
    description = ccb.content.text("Ninety percent of the planet, and it's yours to explore.  And colonize.  And enjoy.  What was that about a surface?"),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_SLIME",
    name = ccb.content.text("Aqueous"),
    description = ccb.content.text("What was that old advertisement?  'Paint the planet'?  That might be a good long-term goal, but for now…"),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_SPIDER",
    name = ccb.content.text("Arachnid"),
    description = ccb.content.text("Well, maybe you'll just have to make your own worldwide web."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "INSECTBLOOD" },
}

ccb.content.define_mutation {
    id = "THRESH_BATRACHIAN",
    name = ccb.content.text("Batrachian"),
    description = ccb.content.text("A perfect ambush predator, if only there were less competition."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_URSINE",
    name = ccb.content.text("Bear"),
    description = ccb.content.text("So the humans died; what's the worry?  Now they won't ruin the woods."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_BEAST",
    name = ccb.content.text("Beast"),
    description = ccb.content.text("It's about time you grew out.  Now that you've matured, it is time to make something of yourself."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT" },
}

ccb.content.define_mutation {
    id = "THRESH_BIRD",
    name = ccb.content.text("Bird"),
    description = ccb.content.text("You're sure you'll fly someday.  In the meantime, there are still nests to build."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_CATTLE",
    name = ccb.content.text("Bovine"),
    description = ccb.content.text("Civilization collapsed?  Great!  You and your kin will never have to worry about a slaughterhouse again."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_CEPHALOPOD",
    name = ccb.content.text("Cephalopod"),
    description = ccb.content.text("Strange aeons, true, but Death seems to be slacking, and you are doing just fine."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "INVERTEBRATEBLOOD" },
}

-- Acceptable substitute for many lines except the human-based ones, raptor, plant, and slime - the former are more controlled, the latter will diverge too much in anatomy.
ccb.content.define_mutation {
    id = "THRESH_CHIMERA",
    name = ccb.content.text("Chaos"),
    description = ccb.content.text("You can't tell what you are anymore.  Everything and yet nothing, like you weren't meant to exist.  But you do, and you're a force, no matter what happens.  Unlocks gaining post-threshold traits from most other mutation categories."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_CHIROPTERAN",
    name = ccb.content.text("Chiropteran"),
    description = ccb.content.text("You long for a colony, the cover of darkness, and a meal on the wing."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_CRUSTACEAN",
    name = ccb.content.text("Crustacean"),
    description = ccb.content.text("Who needs skin when you can have a hard carapace?"),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "INVERTEBRATEBLOOD" },
}

ccb.content.define_mutation {
    id = "THRESH_MOUSE",
    name = ccb.content.text("Diminutive"),
    description = ccb.content.text("So much food, everywhere!  And nobody's even guarding it anymore!  These are good times."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_FELINE",
    name = ccb.content.text("Feline"),
    description = ccb.content.text("Stalking prey, eating well, and lying in the sun.  Mmm, all you could ever desire."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT" },
}

ccb.content.define_mutation {
    id = "THRESH_ELFA",
    name = ccb.content.text("Fey"),
    description = ccb.content.text("You are the tree under which humankind will shelter during these dark times."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_GASTROPOD",
    name = ccb.content.text("Gastropod"),
    description = ccb.content.text("You feel bad for all the creatures that don't carry their home on their backs."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "INVERTEBRATEBLOOD" },
}

ccb.content.define_mutation {
    id = "THRESH_INSECT",
    name = ccb.content.text("Insect"),
    description = ccb.content.text("It would be good to be a queen, having workers constantly servicing your every need… but how would you keep them in line?"),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "INSECTBLOOD" },
}

ccb.content.define_mutation {
    id = "THRESH_RABBIT",
    name = ccb.content.text("Lagomorph"),
    description = ccb.content.text("You really want to eat some carrots.  Welcome to the Lagomorpha family."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT" },
}

ccb.content.define_mutation {
    id = "THRESH_LIZARD",
    name = ccb.content.text("Lizard"),
    description = ccb.content.text("You sometimes look back on your days before your tail came in.  But you're better now."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_PLANT",
    name = ccb.content.text("Plant"),
    description = ccb.content.text("Well, you still have those other walking flowers--and the mushrooms, too--to deal with.  But you'll manage."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "PLANTBLOOD" },
}

ccb.content.define_mutation {
    id = "THRESH_ALPHA",
    name = ccb.content.text("Prime"),
    description = ccb.content.text("You're the perfect candidate to tidy this mess."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_MEDICAL",
    name = ccb.content.text("Prototype"),
    description = ccb.content.text("After all those experiments, what's a few more, hmm?"),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_RAPTOR",
    name = ccb.content.text("Raptor"),
    description = ccb.content.text("The chance to undo not one but TWO extinction events.  You're confident you'll do fine."),
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_TROGLOBITE",
    name = ccb.content.text("Subterranean"),
    description = ccb.content.text("Not much point to rebuilding up in that horribly bright, roofless wasteland.  Now that you've become accustomed to your new digs, there's the beginning of a great empire right here, underground."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_RAT",
    name = ccb.content.text("Survivor"),
    description = ccb.content.text("Hey.  Civilization fell.  You're still around.  'Rat' just isn't respectful."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_LUPINE",
    name = ccb.content.text("Wolf"),
    description = ccb.content.text("You're the perfect candidate to lead a pack."),
    threshold = true,
    threshold_substitutes = { "THRESH_CHIMERA" },
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "THRESH_ALLOWS_QUADRUPEDAL_MOVEMENT" },
}

ccb.content.define_mutation {
    id = "THRESH_INTERSTICE",
    name = ccb.content.text("Interstitial"),
    description = ccb.content.text("You're still here, mostly.  But you have seen the other places, and part of you lives in the cracks between those realities."),
    threshold = true,
    threshold_substitutes = { "THRESH_INTERSTICE" },
    points = 1,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ROBUST",
    name = ccb.content.text("Robust Genetics"),
    description = ccb.content.text("Your genome has rapidly adapted to the Cataclysm and can handle the strain of mutation better.  Taking different kinds of mutagen won't result in more defective mutations than normal."),
    categories = { "FISH", "SLIME", "MEDICAL", "PLANT" },
    cancels = { "CHAOTIC_BAD", "RESTRICTED", "RESISTANT_GENETICS" },
    points = 3,
    starting_trait = true,
    vitamin_cost = 260,
    flags = { "ROBUST_GENETIC" },
}

ccb.content.define_mutation {
    id = "UNSTABLE",
    name = ccb.content.text("Genetically Unstable"),
    description = ccb.content.text("Your DNA has been damaged in a way that causes you to continually develop more mutations."),
    categories = { "MEDICAL", "CHIMERA" },
    replacements = { "CHAOTIC" },
    points = -2,
    mixed_effect = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "CHAOTIC",
    name = ccb.content.text("Genetic Chaos"),
    description = ccb.content.text("Your body alters itself rapidly, and without your intervention or conscious control."),
    categories = { "CHIMERA" },
    prerequisites = { "UNSTABLE", "MUT_JUNKIE" },
    replacements = { "CHAOTIC_BAD" },
    points = -4,
    purifiable = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "CHAOTIC_BAD",
    name = ccb.content.text("Genetic Downward Spiral"),
    description = ccb.content.text("The events of the Cataclysm have damaged your DNA beyond repair.  You mutate frequently, all mutations you receive (from any source) are negative, and your instability is rapidly growing out of control."),
    categories = { "CHIMERA" },
    prerequisites = { "CHAOTIC" },
    cancels = { "ROBUST", "RESTRICTED", "RESISTANT_GENETICS" },
    points = -8,
    starting_trait = true,
    random_start_allowed = false,
    purifiable = false,
    vitamin_cost = 300,
    vitamin_intervals = { instability = -60 },
}

ccb.content.define_mutation {
    id = "RESISTANT_GENETICS",
    name = ccb.content.text("Resistant Genetics"),
    description = ccb.content.text("Your body eats up lesser mutagens faster than normal.  Exotic and esoteric mutagens will still affect you normally."),
    categories = { "ALPHA" },
    replacements = { "RESTRICTED" },
    cancels = { "CHAOTIC_BAD", "ROBUST" },
    points = -1,
    vitamin_cost = 60,
    vitamin_intervals = {
        mutagen_batrachian = 600,
        mutagen_beast = 600,
        mutagen_bird = 600,
        mutagen_cattle = 600,
        mutagen_cephalopod = 600,
        mutagen_crustacean = 600,
        mutagen_feline = 600,
        mutagen_fish = 600,
        mutagen_gastropod = 600,
        mutagen_human = 600,
        mutagen_insect = 600,
        mutagen_lizard = 600,
        mutagen_lupine = 600,
        mutagen_mouse = 600,
        mutagen_plant = 600,
        mutagen_rabbit = 600,
        mutagen_rat = 600,
        mutagen_slime = 600,
        mutagen_spider = 600,
        mutagen_troglobite = 600,
        mutagen_ursine = 600,
    },
}

ccb.content.define_mutation {
    id = "RESTRICTED",
    name = ccb.content.text("Restricted Genetics"),
    description = ccb.content.text("Your genome has become an impregnable fortress to lesser genetic deviations.  You are no longer able to mutate traits that are outside of the Alpha category nor regress to unremarkable humanity.  Any other mutations that you previously developed are safe for now."),
    categories = { "ALPHA" },
    allowed_categories = { "ALPHA" },
    prerequisites = { "RESISTANT_GENETICS" },
    cancels = { "CHAOTIC_BAD", "ROBUST" },
    points = -3,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "MAKAYLA_MUTATOR",
    name = ccb.content.text("Catastrophic Mutation"),
    description = ccb.content.text("Exposure to portal storms and related phenomena causes you to mutate in a mostly predictable fashion."),
    cancels = { "CHAOTIC", "UNSTABLE" },
    points = -2,
    mixed_effect = true,
    purifiable = false,
    valid = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "MUTAGEN_AVOID",
    name = ccb.content.text("Mutagenic Aversion"),
    description = ccb.content.text("Ever since you had that life-threatening reaction to those mutagen and purifier things, you can't bear the thought of ever using them again!"),
    points = 0,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "HEMOVORE",
    name = ccb.content.text("Hemovore"),
    description = ccb.content.text("You can still eat other food, but you crave the taste of blood over everything else.  Without a steady supply or some kind of iron supplement, you're prone to developing anemia."),
    categories = { "CHIROPTERAN" },
    types = { "DIET" },
    replacements = { "BLOODFEEDER" },
    cancels = { "VEGAN" },
    points = -4,
    vitamin_cost = 160,
    flags = { "HEMOVORE" },
    vitamin_intervals = { iron = 1000, vitC = -300 },
}

ccb.content.define_mutation {
    id = "HERBIVORE",
    name = ccb.content.text("Herbivore"),
    description = ccb.content.text("Your body's ability to digest meat is severely hampered.  Eating meat has a good chance of making you vomit it back up; even if you manage to keep it down, its nutritional value is greatly reduced."),
    categories = { "CATTLE", "RABBIT" },
    types = { "DIET" },
    prerequisites = { "VEGETARIAN", "VEGAN" },
    additions = { "RUMINANT" },
    points = -3,
    vitamin_cost = 160,
    flags = { "HERBIVORE_DIET" },
}

ccb.content.define_mutation {
    id = "SAPIOVORE",
    name = ccb.content.text("Sapiovore"),
    description = ccb.content.text("The hairless apes make as good eating as any other meat."),
    categories = { "BEAST", "RAPTOR", "CHIMERA", "URSINE", "LIZARD", "SPIDER" },
    types = { "HUMAN_EMPATHY" },
    prerequisites = { "CARNIVORE", "CARNIVORE_FAKE" },
    secondary_prerequisites = { "PRED3", "PRED4" },
    threshold_requirements = {
        "THRESH_BEAST",
        "THRESH_RAPTOR",
        "THRESH_CHIMERA",
        "THRESH_URSINE",
        "THRESH_LIZARD",
        "THRESH_SPIDER",
    },
    cancels = { "VEGETARIAN", "HERBIVORE", "RUMINANT", "GRAZER" },
    points = 1,
    purifiable = false,
    vitamin_cost = 90,
    flags = { "SAPIOVORE" },
    social_modifiers = { persuade = -20, lie = -20, intimidate = 6 },
}

ccb.content.define_mutation {
    id = "CARNIVORE",
    name = ccb.content.text("Carnivore"),
    description = ccb.content.text("Your body's ability to digest fruits, vegetables, grains and nuts is severely hampered.  You cannot eat anything besides meat.  While your vitamin C needs are lowered, it's still needed and can be found often in organ meat."),
    categories = { "LIZARD", "SPIDER", "CHIMERA", "RAPTOR", "FELINE", "BATRACHIAN", "BEAST", "LUPINE" },
    types = { "DIET" },
    cancels = { "VEGAN" },
    points = -4,
    vitamin_cost = 160,
    flags = { "CARNIVORE_DIET" },
    vitamin_intervals = { vitC = -1200 },
}

ccb.content.define_mutation {
    id = "CARNIVORE_FAKE",
    name = ccb.content.text_without_extraction("Imitation Carnivore"),
    description = ccb.content.text_without_extraction("Fake mutation to allow post-threshold Ursine mutants access to mutations normally gated behind Carnivore.  This is not meant to be visible in-game."),
    categories = { "URSINE" },
    threshold_requirements = { "THRESH_URSINE" },
    points = 0,
    player_display = false,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SAPROVORE",
    name = ccb.content.text("Saprovore"),
    description = ccb.content.text("Your digestive system is specialized to allow you to consume decaying material.  You can eat rotten food, albeit for less nutrition than usual."),
    categories = { "TROGLOBITE", "CHIMERA", "GASTROPOD", "MOUSE" },
    points = 2,
    vitamin_cost = 160,
    flags = { "IMMUNE_SPOIL" },
}

-- Yes, you eventually got over the massive digestive upset.  Mutations aren't easy on a system!
ccb.content.define_mutation {
    id = "EATPOISON",
    name = ccb.content.text("Intestinal Fortitude"),
    description = ccb.content.text("Your guts have developed the ability to handle the toxic elements of mutated flesh.  Mostly."),
    categories = { "TROGLOBITE", "RAPTOR", "RAT", "CHIMERA", "BATRACHIAN", "GASTROPOD", "CRUSTACEAN" },
    types = { "CONSTITUTION" },
    prerequisites = { "WEAKSTOMACH" },
    secondary_prerequisites = { "VOMITOUS" },
    replacements = { "EATDEAD" },
    threshold_requirements = {
        "THRESH_TROGLOBITE", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_RAT", "THRESH_MOUSE",
        "THRESH_BATRACHIAN", "THRESH_CRUSTACEAN", "THRESH_GASTROPOD",
    },
    points = 2,
    vitamin_cost = 160,
    vitamin_absorption = { all = { mutant_toxin = 0.25 } },
}

ccb.content.define_mutation {
    id = "EATDEAD",
    name = ccb.content.text("Eater Of The Dead"),
    description = ccb.content.text("Your digestion has evolved further.  In addition to mutated meat, you can also stomach the tainted and long-dead flesh of zombies… if you can stand the taste, of course."),
    categories = { "RAT", "CHIMERA", "CRUSTACEAN" },
    types = { "CONSTITUTION" },
    prerequisites = { "EATPOISON" },
    threshold_requirements = { "THRESH_CHIMERA", "THRESH_RAT", "THRESH_CRUSTACEAN" },
    cancels = { "VEGETARIAN", "HERBIVORE", "RUMINANT", "GRAZER" },
    points = 4,
    vitamin_cost = 190,
    flags = { "IMMUNE_SPOIL" },
    vitamin_absorption = { all = { mutant_toxin = 0.25 } },
}

ccb.content.define_mutation {
    id = "GROWL",
    name = ccb.content.text("Growling Voice"),
    description = ccb.content.text("You have a growling, rough voice.  Persuading NPCs will be more difficult, but threatening them will be easier."),
    categories = { "RAT", "URSINE", "LUPINE", "BEAST", "CHIMERA", "FELINE" },
    types = { "VOICE_TONE" },
    replacements = { "SNARL" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { persuade = -20, lie = -10, intimidate = 10 },
}

ccb.content.define_mutation {
    id = "SNARL",
    name = ccb.content.text("Snarling Voice"),
    description = ccb.content.text("You have a threatening snarl in your voice.  Persuading NPCs will be near impossible, but threatening them will be much easier."),
    categories = { "BEAST", "CHIMERA", "FELINE", "LUPINE" },
    types = { "VOICE_TONE" },
    prerequisites = { "GROWL" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { persuade = -60, lie = -40, intimidate = 20 },
}

ccb.content.define_mutation {
    id = "HISS",
    name = ccb.content.text("Hissing Voice"),
    description = ccb.content.text("You hiss when speaking.  Persuading NPCs will be more difficult, but threatening them will be easier."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "VOICE_TONE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { persuade = -20, lie = -10, intimidate = 10 },
}

ccb.content.define_mutation {
    id = "SCREECH",
    name = ccb.content.text("Screeching Voice"),
    description = ccb.content.text("Your voice sounds like a bird trying to imitate a human.  Persuading NPCs will be more difficult, but threatening them will be easier."),
    categories = { "BIRD" },
    types = { "VOICE_TONE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { persuade = -10, lie = -20, intimidate = 10 },
}

ccb.content.define_mutation {
    id = "CROAK",
    name = ccb.content.text("Croaking Voice"),
    description = ccb.content.text("You have a low, croaking voice, like an aged grandparent.  Persuading NPCs will be easier, but threatening them will be more difficult."),
    categories = { "BATRACHIAN" },
    types = { "VOICE_TONE" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { persuade = 10, lie = 10, intimidate = -10 },
}

ccb.content.define_mutation {
    id = "BOOMING_VOICE",
    name = ccb.content.text("Booming Voice"),
    description = ccb.content.text("You know how to project your voice.  You are able to shout much louder than the average person."),
    categories = { "BEAST" },
    points = 1,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_BOOMING_VOICE_0" },
}

ccb.content.define_mutation {
    id = "SHOUT1",
    name = ccb.content.text("Shouter"),
    description = ccb.content.text("You occasionally shout uncontrollably."),
    categories = { "RAPTOR", "BEAST", "CHIMERA", "LUPINE" },
    replacements = { "SHOUT2" },
    points = -2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_SHOUT1_0" },
}

ccb.content.define_mutation {
    id = "SHOUT2",
    name = ccb.content.text("Screamer"),
    description = ccb.content.text("You sometimes scream uncontrollably."),
    categories = { "BEAST", "CHIMERA", "LUPINE" },
    prerequisites = { "SHOUT1" },
    replacements = { "SHOUT3" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_SHOUT2_0" },
}

ccb.content.define_mutation {
    id = "SHOUT3",
    name = ccb.content.text("Howler"),
    description = ccb.content.text("You frequently let out a piercing howl."),
    categories = { "CHIMERA", "LUPINE" },
    prerequisites = { "SHOUT2" },
    points = -4,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_SHOUT3_0" },
}

ccb.content.define_mutation {
    id = "RADIOGENIC",
    name = ccb.content.text("Radiogenic"),
    description = ccb.content.text("Your system has somewhat adapted to radiation.  While irradiated, you will actually heal slowly, converting the radiation into hit points.  This doesn't stop you from getting radiation sickness."),
    categories = { "SLIME", "MEDICAL" },
    points = 3,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "RADIOPHILE",
    name = ccb.content.text("Radiophile"),
    description = ccb.content.text("Your flesh has developed a unique reaction to radiation that lets you sense when ambient radiation is abnormally high.  Turn off to ignore messages."),
    categories = { "SLIME", "MEDICAL" },
    prerequisites = { "RADIOGENIC" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "RADIOACTIVE1",
    name = ccb.content.text("Minor Radioactivity"),
    description = ccb.content.text("Your body has become radioactive!  You continuously emit low levels of radiation, which slowly contaminates the world around you."),
    replacements = { "RADIOACTIVE2" },
    points = -2,
    vitamin_cost = 160,
    body_temperature = { 250, 250 },
}

ccb.content.define_mutation {
    id = "RADIOACTIVE2",
    name = ccb.content.text("Radioactivity"),
    description = ccb.content.text("Your body has become radioactive!  You continuously emit moderate levels of radiation, which contaminates the world around you."),
    prerequisites = { "RADIOACTIVE1" },
    replacements = { "RADIOACTIVE3" },
    points = -4,
    vitamin_cost = 160,
    body_temperature = { 750, 750 },
}

ccb.content.define_mutation {
    id = "RADIOACTIVE3",
    name = ccb.content.text("Severe Radioactivity"),
    description = ccb.content.text("Your body has become radioactive!  You continuously emit heavy levels of radiation, making your surroundings unlivable."),
    prerequisites = { "RADIOACTIVE2" },
    points = -6,
    vitamin_cost = 210,
    body_temperature = { 1500, 1500 },
}

ccb.content.define_mutation {
    id = "COLDBLOOD",
    name = ccb.content.text("Heat Dependent"),
    description = ccb.content.text("Your muscle response is dependent on ambient temperatures.  You lose 1% of your speed for every 5 (2.8) degrees below 65 F (18.3 C).  This sluggishness helps you conserve energy, however."),
    categories = {
        "FISH",
        "CEPHALOPOD",
        "SPIDER",
        "GASTROPOD",
        "INSECT",
        "LIZARD",
        "BATRACHIAN",
        "PLANT",
        "CRUSTACEAN",
    },
    types = { "ECTOTHERMIC" },
    replacements = { "COLDBLOOD2" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 90,
    flags = { "COLDBLOOD" },
    enchantments = { "INLINE_ENCH_COLDBLOOD_0" },
}

ccb.content.define_mutation {
    id = "COLDBLOOD2",
    name = ccb.content.text("Very Heat Dependent"),
    description = ccb.content.text("Your muscle response is highly dependent on ambient temperatures.  You lose 1% of your speed for every 3 (1.7) degrees below 65 F (18.3 C), but your slow metabolism requires much less energy."),
    categories = { "INSECT", "LIZARD", "BATRACHIAN", "PLANT", "CRUSTACEAN" },
    types = { "ECTOTHERMIC" },
    prerequisites = { "COLDBLOOD" },
    replacements = { "COLDBLOOD3" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 90,
    flags = { "COLDBLOOD2" },
    enchantments = { "INLINE_ENCH_COLDBLOOD2_0" },
}

ccb.content.define_mutation {
    id = "COLDBLOOD3",
    name = ccb.content.text("Cold Blooded"),
    description = ccb.content.text("You are cold-blooded and rely on heat to keep moving.  Your lose 1% of your speed for every 2 (1.1) degrees below 65 F (18.3 C), resulting in less calorie usage."),
    categories = { "INSECT", "LIZARD", "BATRACHIAN", "PLANT" },
    types = { "ECTOTHERMIC" },
    prerequisites = { "COLDBLOOD2" },
    replacements = { "COLDBLOOD4" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    flags = { "COLDBLOOD3", "NO_BODY_HEAT" },
    enchantments = { "INLINE_ENCH_COLDBLOOD3_0" },
}

ccb.content.define_mutation {
    id = "COLDBLOOD4",
    name = ccb.content.text("Ectothermic"),
    description = ccb.content.text("Your body has become permanently cold-blooded.  Your speed lowers or raises 1% for every 2 (1.1) degrees below or above 65 F (18.3 C).  You eat much less than you otherwise would."),
    categories = { "LIZARD", "PLANT", "BATRACHIAN" },
    types = { "ECTOTHERMIC" },
    prerequisites = { "COLDBLOOD3" },
    threshold_requirements = { "THRESH_LIZARD", "THRESH_PLANT", "THRESH_BATRACHIAN" },
    points = 0,
    mixed_effect = true,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "ECTOTHERM", "NO_BODY_HEAT" },
    enchantments = { "INLINE_ENCH_COLDBLOOD4_0" },
}

ccb.content.define_mutation {
    id = "LARGE",
    name = ccb.content.text("Inconveniently Large"),
    description = ccb.content.text("You have grown noticeably taller and broader.  Much of it is useful muscle mass (Strength +2), but you find it throws off your balance and you get in your own way (+10 torso and arm encumbrance)."),
    categories = { "URSINE", "CATTLE", "LIZARD", "CHIMERA", "CRUSTACEAN" },
    types = { "SIZE" },
    prerequisites = { "STR_UP", "STR_UP_2", "STR_UP_3", "STR_UP_4", "MASOCHIST_MED" },
    secondary_prerequisites = { "DENSE_BONES" },
    replacements = { "LARGE_OK", "HUGE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 200,
    visibility = 1,
    ugliness = 1,
    flags = { "LARGE" },
    encumbrance = { torso = 10, arm_l = 10, arm_r = 10 },
    enchantments = { "INLINE_ENCH_LARGE_0" },
}

ccb.content.define_mutation {
    id = "LARGE_OK",
    name = ccb.content.text("Large"),
    description = ccb.content.text("You carry your rugged body with the dignity you deserve.  Strength +2."),
    categories = { "URSINE", "CATTLE", "LIZARD", "CHIMERA", "CRUSTACEAN" },
    types = { "SIZE" },
    prerequisites = { "LARGE" },
    secondary_prerequisites = { "STR_UP", "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    replacements = { "HUGE" },
    threshold_requirements = { "THRESH_URSINE", "THRESH_CATTLE", "THRESH_LIZARD", "THRESH_CHIMERA", "THRESH_CRUSTACEAN" },
    points = 2,
    vitamin_cost = 200,
    visibility = 1,
    flags = { "LARGE" },
    enchantments = { "INLINE_ENCH_LARGE_OK_0" },
}

ccb.content.define_mutation {
    id = "HUGE",
    name = ccb.content.text("Freakishly Huge"),
    description = ccb.content.text("You have grown even more massive, to the point where you cannot usefully fit into human-sized clothing or vehicles.  Much of it is powerful muscle mass (Strength +4), but it's a real pain to haul around."),
    categories = { "URSINE", "CATTLE", "CRUSTACEAN" },
    types = { "SIZE" },
    prerequisites = { "LARGE", "LARGE_OK" },
    secondary_prerequisites = { "STR_UP_3", "STR_UP_4" },
    replacements = { "HUGE_OK" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 300,
    visibility = 4,
    ugliness = 4,
    flags = { "HUGE" },
    destroys_gear = true,
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    enchantments = { "INLINE_ENCH_HUGE_0" },
}

ccb.content.define_mutation {
    id = "HUGE_OK",
    name = ccb.content.text("Huge"),
    description = ccb.content.text("Your cardiovascular system has caught up with your muscular physique, so who needs pathetic human cars?  Strength +4."),
    categories = { "URSINE", "CATTLE", "CRUSTACEAN" },
    types = { "SIZE" },
    prerequisites = { "HUGE" },
    secondary_prerequisites = { "STR_UP_3", "STR_UP_4" },
    threshold_requirements = { "THRESH_URSINE", "THRESH_CATTLE", "THRESH_CRUSTACEAN" },
    strict_threshold_requirements = true,
    points = 2,
    mixed_effect = true,
    vitamin_cost = 400,
    visibility = 4,
    ugliness = 3,
    flags = { "HUGE" },
    destroys_gear = true,
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    enchantments = { "INLINE_ENCH_HUGE_OK_0" },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH",
    name = ccb.content.text("Resilient"),
    description = ccb.content.text("You can survive injuries that would incapacitate humans: you get a 20% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "URSINE", "CATTLE", "CHIMERA", "BEAST", "LIZARD", "CRUSTACEAN" },
    types = { "DURABILITY" },
    prerequisites = { "LARGE_OK", "HUGE_OK", "STR_UP_3", "STR_UP_4" },
    replacements = { "MUT_TOUGH2" },
    threshold_requirements = {
        "THRESH_URSINE",
        "THRESH_CATTLE",
        "THRESH_CHIMERA",
        "THRESH_LIZARD",
        "THRESH_BEAST",
        "THRESH_CRUSTACEAN",
    },
    points = 2,
    vitamin_cost = 160,
    social_modifiers = { intimidate = 2 },
    enchantments = { "INLINE_ENCH_MUT_TOUGH_0" },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH2",
    name = ccb.content.text("Solidly Built"),
    description = ccb.content.text("Not much scares you.  You get a 30% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "URSINE", "CATTLE", "CHIMERA", "CRUSTACEAN" },
    types = { "DURABILITY" },
    prerequisites = { "MUT_TOUGH" },
    replacements = { "MUT_TOUGH3" },
    threshold_requirements = { "THRESH_URSINE", "THRESH_CATTLE", "THRESH_CHIMERA", "THRESH_CRUSTACEAN" },
    points = 3,
    vitamin_cost = 175,
    social_modifiers = { intimidate = 3 },
    enchantments = { "INLINE_ENCH_MUT_TOUGH2_0" },
}

ccb.content.define_mutation {
    id = "MUT_TOUGH3",
    name = ccb.content.text("TAAANK"),
    description = ccb.content.text("You can simply take the punishment from lesser beings and keep going.  You get a 40% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "URSINE", "CATTLE" },
    types = { "DURABILITY" },
    prerequisites = { "MUT_TOUGH2" },
    threshold_requirements = { "THRESH_URSINE", "THRESH_CATTLE" },
    strict_threshold_requirements = true,
    cancels = { "FLIMSY", "FLIMSY2", "FLIMSY3", "GLASSJAW" },
    points = 4,
    vitamin_cost = 190,
    social_modifiers = { intimidate = 4 },
    enchantments = { "INLINE_ENCH_MUT_TOUGH3_0" },
}

ccb.content.define_mutation {
    id = "STR_UP",
    name = ccb.content.text("Strong"),
    description = ccb.content.text("Your muscles are a little stronger.  +1 Strength."),
    categories = {
        "INSECT", "RAPTOR", "LIZARD", "CATTLE", "PLANT", "ALPHA", "CHIMERA", "LUPINE", "TROGLOBITE",
        "BEAST", "URSINE", "CRUSTACEAN",
    },
    types = { "STR" },
    replacements = { "STR_UP_2" },
    points = 1,
    enchantments = { "INLINE_ENCH_STR_UP_0" },
}

ccb.content.define_mutation {
    id = "STR_UP_2",
    name = ccb.content.text("Very Strong"),
    description = ccb.content.text("Your muscles are stronger.  +2 Strength."),
    categories = {
        "LIZARD",
        "CATTLE",
        "PLANT",
        "ALPHA",
        "CHIMERA",
        "LUPINE",
        "TROGLOBITE",
        "BEAST",
        "URSINE",
        "CRUSTACEAN",
    },
    types = { "STR" },
    prerequisites = { "STR_UP" },
    replacements = { "STR_UP_3", "STR_ALPHA" },
    points = 2,
    vitamin_cost = 170,
    enchantments = { "INLINE_ENCH_STR_UP_2_0" },
}

ccb.content.define_mutation {
    id = "STR_UP_3",
    name = ccb.content.text("Extremely Strong"),
    description = ccb.content.text("Your muscles are much stronger.  +4 Strength."),
    categories = { "CHIMERA", "LUPINE", "TROGLOBITE", "BEAST", "URSINE", "CATTLE", "CRUSTACEAN" },
    types = { "STR" },
    prerequisites = { "STR_UP_2" },
    replacements = { "STR_UP_4" },
    threshold_requirements = {
        "THRESH_CHIMERA", "THRESH_LUPINE", "THRESH_TROGLOBITE", "THRESH_BEAST", "THRESH_URSINE",
        "THRESH_CATTLE", "THRESH_CRUSTACEAN",
    },
    points = 4,
    vitamin_cost = 200,
    visibility = 1,
    enchantments = { "INLINE_ENCH_STR_UP_3_0" },
}

ccb.content.define_mutation {
    id = "STR_UP_4",
    name = ccb.content.text("Insanely Strong"),
    description = ccb.content.text("Your muscles are noticeably bulging.  +7 Strength."),
    categories = { "BEAST", "URSINE", "CRUSTACEAN" },
    types = { "STR" },
    prerequisites = { "STR_UP_3" },
    threshold_requirements = { "THRESH_BEAST", "THRESH_URSINE", "THRESH_CRUSTACEAN" },
    strict_threshold_requirements = true,
    points = 7,
    vitamin_cost = 300,
    visibility = 2,
    ugliness = 2,
    enchantments = { "INLINE_ENCH_STR_UP_4_0" },
}

ccb.content.define_mutation {
    id = "STR_ALPHA",
    name = ccb.content.text("Prime Strength"),
    description = ccb.content.text("Your muscles are perfectly developed."),
    categories = { "ALPHA" },
    types = { "STR" },
    prerequisites = { "STR_UP_2" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 6,
    vitamin_cost = 400,
    enchantments = { "INLINE_ENCH_STR_ALPHA_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_POSTURE",
    name = ccb.content.text("Languid Posture"),
    description = ccb.content.text("Your connective tissues are weakening.  -1 Strength."),
    replacements = { "INTERSTICE_POSTURE_2" },
    categories = { "INTERSTICE" },
    points = -2,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_INTERSTICE_POSTURE_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_POSTURE_2",
    name = ccb.content.text("Loosened Anatomy"),
    mixed_effect = true,
    description = ccb.content.text("Your connective tissues and joints are unnaturally lose, leaving you nimble.  -1 Strength, +1 Dexterity."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_POSTURE" },
    points = 2,
    vitamin_cost = 80,
    enchantments = { "INLINE_ENCH_INTERSTICE_POSTURE_2_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP",
    name = ccb.content.text("Dextrous"),
    description = ccb.content.text("You are a little nimbler.  +1 Dexterity."),
    categories = {
        "INSECT", "CHIROPTERAN", "ALPHA", "LIZARD", "SPIDER", "CHIMERA", "RAPTOR", "MOUSE", "RABBIT",
        "BIRD", "ELFA", "FELINE", "CEPHALOPOD", "FISH", "INTERSTICE",
    },
    types = { "DEX" },
    replacements = { "DEX_UP_2" },
    points = 1,
    enchantments = { "INLINE_ENCH_DEX_UP_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_2",
    name = ccb.content.text("Very Dextrous"),
    description = ccb.content.text("You are nimbler.  +2 Dexterity."),
    categories = {
        "LIZARD", "SPIDER", "CHIMERA", "RAPTOR", "MOUSE", "RABBIT", "BIRD", "ELFA", "FELINE",
        "CEPHALOPOD", "FISH", "ALPHA", "CHIROPTERAN", "INTERSTICE",
    },
    types = { "DEX" },
    prerequisites = { "DEX_UP" },
    replacements = { "DEX_UP_3", "DEX_ALPHA" },
    points = 2,
    vitamin_cost = 170,
    enchantments = { "INLINE_ENCH_DEX_UP_2_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_3",
    name = ccb.content.text("Extremely Dextrous"),
    description = ccb.content.text("You are nimble and quick.  +4 Dexterity."),
    categories = { "BIRD", "ELFA", "FELINE", "CEPHALOPOD", "FISH", "CHIROPTERAN", "INTERSTICE" },
    types = { "DEX" },
    prerequisites = { "DEX_UP_2" },
    replacements = { "DEX_UP_4" },
    additions = { "DEX_INTERSTICE" },
    threshold_requirements = {
        "THRESH_BIRD", "THRESH_ELFA", "THRESH_FELINE", "THRESH_CEPHALOPOD", "THRESH_FISH",
        "THRESH_CHIROPTERAN", "THRESH_INTERSTICE",
    },
    points = 3,
    vitamin_cost = 200,
    enchantments = { "INLINE_ENCH_DEX_UP_3_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_4",
    name = ccb.content.text("Insanely Dextrous"),
    description = ccb.content.text("You are much nimbler than before.  +7 Dexterity."),
    categories = { "CEPHALOPOD", "FISH" },
    types = { "DEX" },
    prerequisites = { "DEX_UP_3" },
    threshold_requirements = { "THRESH_CEPHALOPOD", "THRESH_FISH" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_DEX_UP_4_0" },
}

ccb.content.define_mutation {
    id = "DEX_ALPHA",
    name = ccb.content.text("Prime Dexterity"),
    description = ccb.content.text("You're perfectly coordinated."),
    categories = { "ALPHA" },
    types = { "DEX" },
    prerequisites = { "DEX_UP_2" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 6,
    vitamin_cost = 400,
    enchantments = { "INLINE_ENCH_DEX_ALPHA_0" },
}

ccb.content.define_mutation {
    id = "DEX_INTERSTICE",
    name = ccb.content.text("Liminal Stride"),
    description = ccb.content.text("You are just passing through these places.  They present no distractions or resistance.  You move much easier, particularly over obstacles and through tight spaces."),
    categories = { "INTERSTICE" },
    prerequisites = { "DEX_UP_3" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    purifiable = false,
    points = 6,
    vitamin_cost = 400,
    enchantments = { "INLINE_ENCH_DEX_INTERSTICE_0" },
}

ccb.content.define_mutation {
    id = "INT_UP",
    name = ccb.content.text("Smart"),
    description = ccb.content.text("You are a little smarter.  +1 Intelligence."),
    categories = { "SLIME", "ALPHA", "ELFA", "CEPHALOPOD" },
    types = { "INT" },
    replacements = { "INT_UP_2", "INT_SLIME" },
    points = 1,
    enchantments = { "INLINE_ENCH_INT_UP_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_2",
    name = ccb.content.text("Very Smart"),
    description = ccb.content.text("You are smarter.  +2 Intelligence."),
    categories = { "CEPHALOPOD", "ALPHA" },
    types = { "INT" },
    prerequisites = { "INT_UP" },
    replacements = { "INT_UP_3", "INT_ALPHA" },
    points = 2,
    vitamin_cost = 170,
    enchantments = { "INLINE_ENCH_INT_UP_2_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_3",
    name = ccb.content.text("Extremely Smart"),
    description = ccb.content.text("You are much smarter, and your skull bulges slightly.  +4 Intelligence."),
    categories = { "CEPHALOPOD" },
    types = { "INT" },
    prerequisites = { "INT_UP_2" },
    replacements = { "INT_UP_4" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    points = 3,
    vitamin_cost = 200,
    visibility = 1,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_INT_UP_3_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_4",
    name = ccb.content.text("Insanely Smart"),
    description = ccb.content.text("Your skull bulges noticeably due to your impressive brain.  +7 Intelligence."),
    categories = { "CEPHALOPOD" },
    types = { "INT" },
    prerequisites = { "INT_UP_3" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 300,
    visibility = 3,
    ugliness = 3,
    enchantments = { "INLINE_ENCH_INT_UP_4_0" },
}

ccb.content.define_mutation {
    id = "INT_ALPHA",
    name = ccb.content.text("Prime Intelligence"),
    description = ccb.content.text("You understand almost everything about which you think, with minimal effort."),
    categories = { "ALPHA" },
    types = { "INT" },
    prerequisites = { "INT_UP_2" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 6,
    vitamin_cost = 400,
    enchantments = { "INLINE_ENCH_INT_ALPHA_0" },
}

ccb.content.define_mutation {
    id = "INT_SLIME",
    name = ccb.content.text("Distributed Neurology"),
    description = ccb.content.text("Your brain has evolved beyond human imagination.  You'll show them the REAL meaning of 'gray goo'!"),
    categories = { "SLIME" },
    types = { "INT" },
    prerequisites = { "INT_UP" },
    secondary_prerequisites = { "AMORPHOUS" },
    additions = { "SLIMESPAWNER", "SLIMEMIND" },
    threshold_requirements = { "THRESH_SLIME" },
    points = 4,
    purifiable = false,
    vitamin_cost = 400,
    visibility = 10,
    ugliness = 10,
    armor = {
        {
            parts = {
                "torso", "head", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r", "foot_l",
                "foot_r", "mouth", "eyes",
            },
            resistances = { bash = -3 },
        },
    },
    enchantments = { "INLINE_ENCH_INT_SLIME_0" },
}

ccb.content.define_mutation {
    id = "PER_UP",
    name = ccb.content.text("Perceptive"),
    description = ccb.content.text("Your senses are a little keener.  +1 Perception."),
    categories = { "ALPHA", "CHIMERA", "BATRACHIAN", "ELFA", "RAPTOR", "BIRD", "SLIME", "SPIDER", "INTERSTICE" },
    types = { "PER" },
    replacements = { "PER_UP_2" },
    points = 1,
    enchantments = { "INLINE_ENCH_PER_UP_0" },
}

ccb.content.define_mutation {
    id = "PER_UP_2",
    name = ccb.content.text("Very Perceptive"),
    description = ccb.content.text("Your senses are keener.  +2 Perception."),
    categories = { "ALPHA", "CHIMERA", "BATRACHIAN", "ELFA", "RAPTOR", "BIRD", "SPIDER", "INTERSTICE" },
    types = { "PER" },
    prerequisites = { "PER_UP" },
    replacements = { "PER_UP_3", "PER_ALPHA" },
    points = 2,
    vitamin_cost = 170,
    enchantments = { "INLINE_ENCH_PER_UP_2_0" },
}

ccb.content.define_mutation {
    id = "PER_UP_3",
    name = ccb.content.text("Extremely Perceptive"),
    description = ccb.content.text("Your senses are much keener.  +4 Perception."),
    categories = { "ELFA", "RAPTOR", "BIRD", "INTERSTICE" },
    types = { "PER" },
    prerequisites = { "PER_UP_2" },
    replacements = { "PER_UP_4" },
    threshold_requirements = { "THRESH_ELFA", "THRESH_RAPTOR", "THRESH_BIRD", "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = 3,
    vitamin_cost = 200,
    enchantments = { "INLINE_ENCH_PER_UP_3_0" },
}

ccb.content.define_mutation {
    id = "PER_UP_4",
    name = ccb.content.text("Insanely Perceptive"),
    description = ccb.content.text("You can sense things you never imagined.  +7 Perception."),
    categories = { "BIRD", "INTERSTICE" },
    types = { "PER" },
    prerequisites = { "PER_UP_3" },
    additions = { "BIRD_EYE" },
    replacements = { "PER_INTERSTICE" },
    threshold_requirements = { "THRESH_BIRD", "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_PER_UP_4_0" },
}

ccb.content.define_mutation {
    id = "PER_INTERSTICE",
    name = ccb.content.text("Perceptual Overreach"),
    description = ccb.content.text("You see all the colors of space.  It is maddening and confusing.  +12 Perception, -3 intelligence."),
    categories = { "INTERSTICE" },
    types = { "PER" },
    prerequisites = { "PER_UP_4" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    mixed_effect = true,
    points = 4,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_PER_INTERSTICE_0" },
}

ccb.content.define_mutation {
    id = "PER_ALPHA",
    name = ccb.content.text("Prime Perception"),
    description = ccb.content.text("Your senses are keenly honed."),
    categories = { "ALPHA" },
    types = { "PER" },
    prerequisites = { "PER_UP_2" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 6,
    vitamin_cost = 400,
    enchantments = { "INLINE_ENCH_PER_ALPHA_0" },
}

ccb.content.define_mutation {
    id = "PER_SLIME",
    name = ccb.content.text("Sensory Disintegration"),
    description = ccb.content.text("Your sense organs are all over the place: eyes extending and retracting, 'ears' of various shapes migrating about, and taste & smell are uncontrollable.  The world is a horrible mixup.  Ugh!"),
    categories = { "SLIME" },
    types = { "PER" },
    prerequisites = { "PER_UP" },
    secondary_prerequisites = { "AMORPHOUS" },
    additions = { "SLIMEMIND" },
    replacements = { "PER_SLIME_OK" },
    threshold_requirements = { "THRESH_SLIME" },
    points = -7,
    purifiable = false,
    vitamin_cost = 400,
    visibility = 10,
    ugliness = 10,
    enchantments = { "INLINE_ENCH_PER_SLIME_0" },
}

ccb.content.define_mutation {
    id = "PER_SLIME_OK",
    name = ccb.content.text("Distributed Senses"),
    description = ccb.content.text("You can now extend and reabsorb sensory organs at will, and can therefore ignore most shocks that would overwhelm lesser beings."),
    categories = { "SLIME" },
    types = { "PER" },
    prerequisites = { "PER_SLIME" },
    secondary_prerequisites = { "AMORPHOUS" },
    additions = { "SLIMESPAWNER", "SLIMEMIND" },
    threshold_requirements = { "THRESH_SLIME" },
    points = 7,
    purifiable = false,
    vitamin_cost = 400,
    visibility = 10,
    ugliness = 10,
    flags = { "EYE_MEMBRANE" },
    enchantments = { "INLINE_ENCH_PER_SLIME_OK_0" },
}

ccb.content.define_mutation {
    id = "SLIMEMIND",
    name = ccb.content.text("Slimewave"),
    description = ccb.content.text("You can communicate with your extant mass without physical contact, absorbing knowledge from nearby friendly slime."),
    categories = { "SLIME" },
    prerequisites = { "PER_SLIME", "PER_SLIME_OK" },
    secondary_prerequisites = { "INT_SLIME" },
    threshold_requirements = { "THRESH_SLIME" },
    points = 10,
    purifiable = false,
    vitamin_cost = 500,
    visibility = 2,
    ugliness = 10,
    monster_cameras = { mon_slime_ocularium = 32, mon_player_blob = 16 },
}

ccb.content.define_mutation {
    id = "MUTE",
    name = ccb.content.text("Mute"),
    description = ccb.content.text("Trait that makes it impossible to say anything."),
    points = 0,
    valid = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "NL_MUTE",
    name = ccb.content.text("Mute (Dimensional Jaunt)"),
    description = ccb.content.text("Something is rendering you incapable of speech."),
    points = 0,
    valid = false,
    purifiable = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "MUTE_BIRD",
    name = ccb.content.text("Mute (Bird)"),
    description = ccb.content.text("Your mouth and larynx have changed dramatically, rendering you incapable of human speech.  With enough practice you could relearn imitating their weird ape chirps, but it will take time.  <color_red>Look for a new practice recipe to lose this setback.</color>"),
    categories = { "BIRD" },
    prerequisites = { "BEAK", "BEAK_PECK", "BEAK_HUM" },
    points = -2,
    purifiable = false,
    valid = false,
    flags = { "MUTE" },
}

-- Least punishing social malus, but still not nothing
ccb.content.define_mutation {
    id = "MUTE_BIRD_OK",
    name = ccb.content.text("Speech Mimicry (Bird)"),
    description = ccb.content.text("Your throat cramps, your beak twitches, but you can speak human again if you want."),
    categories = { "BIRD" },
    prerequisites = { "MUTE_BIRD" },
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_MUTE_BIRD_OK_0" },
}

ccb.content.define_mutation {
    id = "MUTE_CEPH",
    name = ccb.content.text("Mute (Cephalopod)"),
    description = ccb.content.text("Your beak and new lungs have diverged too much from your human form to be capable of human speech.  <color_red>Look for a new practice recipe to lose this setback.</color>"),
    categories = { "CEPHALOPOD" },
    prerequisites = { "BEAK" },
    points = -2,
    purifiable = false,
    valid = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "MUTE_CEPH_OK",
    name = ccb.content.text("Speech Mimicry (Cephalopod)"),
    description = ccb.content.text("Contorting your voice to match your surroundings is just as necessary as changing your color, even if learning it was a pain."),
    categories = { "CEPHALOPOD" },
    prerequisites = { "MUTE_CEPH" },
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_MUTE_CEPH_OK_0" },
}

ccb.content.define_mutation {
    id = "MUTE_GASTROPOD",
    name = ccb.content.text("Mute (Snail)"),
    description = ccb.content.text("Just losing your teeth would have been an adjustment, but with your new tongue human speech is straight-up impossible.  <color_red>Look for a new practice recipe to lose this setback.</color>"),
    categories = { "GASTROPOD" },
    prerequisites = { "GASTROPOD_EXTREMITY2", "GASTROPOD_EXTREMITY3" },
    replacements = { "MUTE_GASTROPOD_OK" },
    points = -2,
    purifiable = false,
    valid = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "MUTE_GASTROPOD_OK",
    name = ccb.content.text("Speech Mimicry (Snail)"),
    description = ccb.content.text("Fine control of your radula was hard to learn, but now that you mapped out which calcified not-tooth on there makes what pitch you can open your mouth and…speak.  Yes, let's call it speaking."),
    categories = { "GASTROPOD" },
    prerequisites = { "MUTE_GASTROPOD" },
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_MUTE_GASTROPOD_OK_0" },
}

ccb.content.define_mutation {
    id = "MUTE_INSECT",
    name = ccb.content.text("Mute (Insect)"),
    description = ccb.content.text("Your mandibles already made speech hard, but now that you don't even have a tongue…<color_red>Look for a new practice recipe to lose this setback.</color>"),
    categories = { "INSECT" },
    prerequisites = { "PROBOSCIS" },
    points = -2,
    purifiable = false,
    valid = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "MUTE_INSECT_OK",
    name = ccb.content.text("Speech Mimicry (Insect)"),
    description = ccb.content.text("Using all this new anatomy cramps you up, and there's spittle flying everywhere, but you can manage short sentences of whistling almost-words."),
    categories = { "INSECT" },
    prerequisites = { "MUTE_INSECT" },
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_MUTE_INSECT_OK_0" },
}

ccb.content.define_mutation {
    id = "MUTE_SLIME",
    name = ccb.content.text("Mute (Slime)"),
    description = ccb.content.text("Your mouth is gone.  Oh, wait, there's one, isn't there?  If only it stopped moving around you might start to relearn something like human speech.  <color_red>Look for a new practice recipe to lose this setback.</color>"),
    categories = { "SLIME" },
    prerequisites = { "AMORPHOUS" },
    points = -2,
    purifiable = false,
    valid = false,
    flags = { "MUTE" },
}

ccb.content.define_mutation {
    id = "MUTE_SLIME_OK",
    name = ccb.content.text("Speech Mimicry (Slime)"),
    description = ccb.content.text("Each word its own custom bubble under your membrane, waiting for its turn to pop.  It sounds like something small and furry drowning in sourdough, but if you manage to convince somebody to listen to you they will probably understand."),
    categories = { "SLIME" },
    prerequisites = { "MUTE_SLIME" },
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_MUTE_SLIME_OK_0" },
}

ccb.content.define_mutation {
    id = "ADRENALINE",
    name = ccb.content.text("High Adrenaline"),
    description = ccb.content.text("If you are in a very dangerous situation, you may experience a temporary rush which increases your speed and strength significantly."),
    categories = { "BEAST", "CHIMERA" },
    replacements = { "ADRENALINE2" },
    threshold_requirements = { "THRESH_BEAST", "THRESH_CHIMERA" },
    points = 1,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "ADRENALINE2",
    name = ccb.content.text("Combat Adaptation"),
    description = ccb.content.text("When you are in great danger you may flip a chemical switch in your brain and for a cost in hunger, fatigue, and thirst your nervous system will process things around you slightly faster.  Giving you better reaction times that you can pay for later if you survive."),
    categories = { "BEAST" },
    prerequisites = { "ADRENALINE" },
    points = 3,
    active = true,
    cooldown = "10 s",
    cost = 90,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    consumes_rest = true,
    enchantments = { "INLINE_ENCH_ADRENALINE2_0" },
}

ccb.content.define_mutation {
    id = "ACIDPROOF",
    name = ccb.content.text("Acidproof"),
    description = ccb.content.text("Your mutated flesh is immune to the damaging effects of acid."),
    categories = { "INSECT", "CHIMERA", "MEDICAL", "SLIME" },
    threshold_requirements = { "THRESH_INSECT", "THRESH_CHIMERA", "THRESH_MEDICAL", "THRESH_SLIME" },
    points = 3,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "ACID_IMMUNE", "IRRITANT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "ACIDBLOOD",
    name = ccb.content.text("Acid Blood"),
    description = ccb.content.text("Your body has developed a wonderful defense mechanism.  Instead of normal blood, you bleed a strong molecular acid which will damage any creature foolish enough to harm you."),
    categories = { "INSECT", "CHIMERA", "MEDICAL", "SLIME" },
    types = { "BLOOD" },
    prerequisites = { "ACIDPROOF" },
    threshold_requirements = { "THRESH_INSECT", "THRESH_CHIMERA", "THRESH_MEDICAL", "THRESH_SLIME" },
    points = 4,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "ACIDBLOOD" },
}

ccb.content.define_mutation {
    id = "PHEROMONE_MAMMAL",
    name = ccb.content.text("Mammal Pheromones"),
    description = ccb.content.text("Your body produces low-level pheromones which put mammals at ease.  They will be less likely to attack or flee from you."),
    categories = { "BEAST", "CATTLE", "CHIROPTERAN" },
    types = { "PHEROMONE" },
    prerequisites = { "SMELLY2", "LEGS_BAT" },
    threshold_requirements = { "THRESH_BEAST", "THRESH_CATTLE", "THRESH_CHIROPTERAN" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "PRED1",
    name = ccb.content.text("Culler"),
    description = ccb.content.text("You've had a revelation: by killing the weaker creatures, who would only die anyway, you preserve resources for those better able to survive.  You are less bothered by the deaths of others: their own weakness invited these fates upon them."),
    categories = { "BEAST", "RAPTOR", "CHIMERA", "LUPINE", "FELINE", "URSINE", "LIZARD", "SPIDER", "BATRACHIAN" },
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE", "CARNIVORE_FAKE" },
    replacements = { "PRED2" },
    threshold_requirements = {
        "THRESH_BEAST", "THRESH_RAPTOR", "THRESH_CHIMERA", "THRESH_LUPINE", "THRESH_FELINE",
        "THRESH_URSINE", "THRESH_LIZARD", "THRESH_SPIDER", "THRESH_BATRACHIAN",
    },
    cancels = { "MANSBESTFRIEND" },
    points = 2,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "PRED1" },
}

ccb.content.define_mutation {
    id = "PRED2",
    name = ccb.content.text("Hunter"),
    description = ccb.content.text("Your brain has a lot more in common with a predatory animal than a human, making it easier to control misplaced reactions to the death of your prey.  Your combat skills are becoming instinctual, helping you turn theory into practice."),
    categories = { "BEAST", "RAPTOR", "CHIMERA", "LUPINE", "FELINE", "URSINE", "LIZARD", "SPIDER" },
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE", "CARNIVORE_FAKE" },
    secondary_prerequisites = { "PRED1" },
    replacements = { "PRED3" },
    threshold_requirements = {
        "THRESH_BEAST", "THRESH_RAPTOR", "THRESH_CHIMERA", "THRESH_LUPINE", "THRESH_FELINE",
        "THRESH_URSINE", "THRESH_LIZARD", "THRESH_SPIDER",
    },
    points = 3,
    purifiable = false,
    vitamin_cost = 175,
    flags = { "PRED2" },
    social_modifiers = { intimidate = 3 },
    enchantments = { "INLINE_ENCH_PRED2_0" },
}

ccb.content.define_mutation {
    id = "PRED3",
    name = ccb.content.text("Predator"),
    description = ccb.content.text("You consider yourself something other than human and no longer empathize with them.  Combat comes naturally to you, but your critical thinking, so characteristic to these creatures, suffers."),
    categories = { "BEAST", "RAPTOR", "CHIMERA", "LUPINE", "FELINE", "URSINE", "LIZARD", "SPIDER" },
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE", "CARNIVORE_FAKE" },
    secondary_prerequisites = { "PRED2" },
    additions = { "SAPIOVORE" },
    replacements = { "PRED4", "PACK_HUNTER" },
    threshold_requirements = {
        "THRESH_BEAST", "THRESH_RAPTOR", "THRESH_CHIMERA", "THRESH_LUPINE", "THRESH_FELINE",
        "THRESH_URSINE", "THRESH_LIZARD", "THRESH_SPIDER",
    },
    cancels = { "PACIFIST" },
    points = 3,
    purifiable = false,
    vitamin_cost = 190,
    flags = { "PRED3" },
    social_modifiers = { intimidate = 4 },
    enchantments = { "INLINE_ENCH_PRED3_0" },
}

ccb.content.define_mutation {
    id = "PRED4",
    name = ccb.content.text("Apex Predator"),
    description = ccb.content.text("Your mind and brain have adapted to your new place in the world: as one on top of the food chain.  You can effortlessly master combat skills, but your critical thinking has atrophied further."),
    categories = { "BEAST", "RAPTOR", "CHIMERA", "URSINE" },
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE", "CARNIVORE_FAKE" },
    secondary_prerequisites = { "PRED3" },
    threshold_requirements = { "THRESH_BEAST", "THRESH_RAPTOR", "THRESH_CHIMERA", "THRESH_URSINE" },
    points = 2,
    purifiable = false,
    vitamin_cost = 195,
    flags = { "PRED4" },
    social_modifiers = { intimidate = 5 },
    enchantments = { "INLINE_ENCH_PRED4_0" },
}

ccb.content.define_mutation {
    id = "EATHEALTH",
    name = ccb.content.text("Hyper-Metabolism"),
    description = ccb.content.text("Your particular metabolism allows you to burn calories at a prodigious rate to regenerate tissues in a matter of minutes; this is, however, a very wasteful process.  Activate to start healing."),
    categories = { "CHIMERA" },
    types = { "METABOLISM" },
    prerequisites = { "HUNGER3" },
    threshold_requirements = { "THRESH_CHIMERA" },
    points = 15,
    active = true,
    vitamin_cost = 350,
    transform = {
        target = "EATHEALTH_active",
        message = ccb.content.text("Your hyper-metabolism starts burning up calories."),
        active = true,
        moves = 0,
    },
}

ccb.content.define_mutation {
    id = "EATHEALTH_active",
    copy_from = "EATHEALTH",
    name = ccb.content.text("Hyper-Metabolism: burning"),
    description = ccb.content.text("You're burning calories like crazy to heal your wounds."),
    valid = false,
    cooldown = "1 s",
    cost = 9,
    consumes_calories = true,
    transform = {
        target = "EATHEALTH",
        message = ccb.content.text("Your hyper-metabolism slows down."),
        active = false,
        moves = 0,
    },
    enchantments = { "INLINE_ENCH_EATHEALTH_active_0" },
}

ccb.content.define_mutation {
    id = "EMOTIONALVOLATILITY",
    name = ccb.content.text("Emotional Volatility"),
    description = ccb.content.text("Your emotions fluctuate more than the average person; you cry more easily and laugh more easily."),
    types = { "ATTITUDE" },
    cancels = { "EMOTIONALFLATNESS" },
    points = 0,
    mixed_effect = true,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "EMOTIONALFLATNESS",
    name = ccb.content.text("Emotional Flatness"),
    description = ccb.content.text("Compared to others, you are less likely to experience significant emotional changes.  You feel that the intensity of your emotions is only about half that of others."),
    types = { "ATTITUDE" },
    cancels = { "EMOTIONALVOLATILITY" },
    points = 0,
    mixed_effect = true,
    starting_trait = true,
    chargen_allow_npc = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "SNOUT",
    name = ccb.content.text("Snout"),
    description = ccb.content.text("Your face and jaw have begun… changing.  Masks and such fit OK, but you're noticeably mutated."),
    categories = {
        "BIRD", "CEPHALOPOD", "FELINE", "RAPTOR", "INSECT", "CATTLE", "BEAST", "LUPINE", "URSINE",
        "LIZARD", "RAT", "RABBIT", "MOUSE",
    },
    types = { "MUZZLE" },
    replacements = {
        "BEAK", "BEAK_HUM", "BEAK_PECK", "PROBOSCIS", "MINOTAUR", "MUZZLE_RAPTOR", "MUZZLE",
        "MUZZLE_BEAR", "MUZZLE_LONG", "MUZZLE_RAT", "RABBIT_NOSE",
    },
    points = -1,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "MINOTAUR",
    name = ccb.content.text("Bovine Snout"),
    description = ccb.content.text("Your face resembles that of a bull, with a significant snout.  It looks fearsome but makes it difficult to find gear that covers your face."),
    categories = { "CATTLE" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = -4,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 6,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 15 },
}

ccb.content.define_mutation {
    id = "BOVINE_BULK",
    name = ccb.content.text("Bovine Bulk"),
    description = ccb.content.text("Your flesh has become dense with fat and muscle.  This makes you harder to take down, but also a poor swimmer."),
    categories = { "CATTLE" },
    types = { "BUILD" },
    prerequisites = { "DENSE_BONES" },
    replacements = { "BOVINE_BULK2" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_BOVINE_BULK_0" },
}

ccb.content.define_mutation {
    id = "BOVINE_BULK2",
    name = ccb.content.text("Bull Roids"),
    description = ccb.content.text("Your bulk has rendered you a veritable living wall.  Be careful around water though; while you're as sturdy as a rock, you'll sink like one too."),
    categories = { "CATTLE" },
    types = { "BUILD" },
    prerequisites = { "BOVINE_BULK" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_BOVINE_BULK2_0" },
}

ccb.content.define_mutation {
    id = "DENSE_BONES",
    name = ccb.content.text("Dense Bones"),
    description = ccb.content.text("Your bones are particularly dense and durable.  Your tougher frame grants 5% more HP and 15% more carry capacity plus bashing attacks injure you less, but your higher weight makes attacking and moving 5% slower.  Also, dodging and swimming are harder."),
    categories = { "URSINE", "CATTLE", "CHIMERA", "BEAST", "LIZARD", "CRUSTACEAN" },
    types = { "BONES" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 60,
    armor = {
        {
            part_types = { "torso", "head", "arm", "hand", "leg", "foot", "mouth", "tail" },
            resistances = { bash = 2 },
        },
    },
    enchantments = { "INLINE_ENCH_DENSE_BONES_0" },
}

-- Also allows you to break down normally indigestible triffid fiber 3x as quickly.
ccb.content.define_mutation {
    id = "RUMINANT",
    name = ccb.content.text("Ruminant"),
    description = ccb.content.text("Your digestive system is capable of digesting cellulose and other rough plant material.  You can eat underbrush and shrubs by activating this, standing over your target, and pressing E."),
    categories = { "CATTLE", "RABBIT" },
    types = { "GRAZING" },
    prerequisites = { "HERBIVORE" },
    replacements = { "GRAZER" },
    points = 2,
    active = true,
    cost = 0,
    vitamin_cost = 160,
    vitamin_intervals = { triffid_fiber = 3600 },
}

-- Also allows you to break down normally indigestible triffid fiber 5x as quickly.
ccb.content.define_mutation {
    id = "GRAZER",
    name = ccb.content.text("Grazer"),
    description = ccb.content.text("You're accustomed to eating plants directly, and can get nutrition from grass as well as underbrush and shrubs.  Eat either one by activating this, standing over your target, and pressing E."),
    categories = { "CATTLE", "RABBIT" },
    types = { "GRAZING" },
    prerequisites = { "RUMINANT", "INCISORS" },
    threshold_requirements = { "THRESH_CATTLE", "THRESH_RABBIT" },
    points = 3,
    active = true,
    cost = 0,
    vitamin_cost = 160,
    vitamin_intervals = { triffid_fiber = 1800 },
}

ccb.content.define_mutation {
    id = "URSINE_EARS",
    name = ccb.content.text("Ursine Ears"),
    description = ccb.content.text("Your ears have grown longer and rounder, much like those of a bear.  You can hear things a little farther away."),
    categories = { "URSINE" },
    types = { "EARS" },
    points = 1,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_URSINE_EARS_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_BEAR",
    name = ccb.content.text("Ursine Muzzle"),
    description = ccb.content.text("Your jaw and nose have extended into a bearish muzzle.  You could bite with it, and it looks impressive, but it prevents wearing mouthgear."),
    categories = { "URSINE" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    secondary_prerequisites = { "FANGS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 4,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_MUZZLE_BEAR_0" },
}

ccb.content.define_mutation {
    id = "URSINE_EYE",
    name = ccb.content.text("Ursine Vision"),
    description = ccb.content.text("Your visual processing has shifted: though you can see better in the dark, you're nearsighted in the light.  Maybe glasses would help.  Activate to toggle NV-visible areas on or off."),
    categories = { "URSINE" },
    types = { "EYES", "VISION" },
    cancels = { "MYOPIC", "MESOPIC" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_URSINE_EYE_0" },
}

ccb.content.define_mutation {
    id = "FAT",
    name = ccb.content.text("Fat Deposits"),
    description = ccb.content.text("You've put on some additional weight around your body.  It slows you down a little, but helps your swimming and warmth."),
    categories = { "URSINE" },
    prerequisites = { "STR_UP", "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    additions = { "HIBERNATE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 1,
    body_temperature = { 200, 200 },
    armor = {
        {
            part_types = { "torso", "head", "arm", "hand", "leg", "foot", "mouth", "tail" },
            resistances = { bash = 1 },
        },
    },
    enchantments = { "INLINE_ENCH_FAT_0" },
}

ccb.content.define_mutation {
    id = "HIBERNATE",
    name = ccb.content.text("Hibernation"),
    description = ccb.content.text("You've developed the ability to stockpile calories and then sleep for extended periods of time."),
    categories = { "URSINE" },
    prerequisites = { "HEAVYSLEEPER2" },
    secondary_prerequisites = { "FAT" },
    threshold_requirements = { "THRESH_URSINE" },
    strict_threshold_requirements = true,
    points = 3,
    active = true,
    cost = 0,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_HIBERNATE_0" },
}

ccb.content.define_mutation {
    id = "CANINE_EARS",
    name = ccb.content.text("Canine Ears"),
    description = ccb.content.text("Your ears have extended into long, pointed ones, like those of a canine.  They enhance your hearing, allowing you to hear at greater distances."),
    categories = { "BEAST", "CATTLE", "CHIMERA", "LUPINE" },
    types = { "EARS" },
    replacements = { "LUPINE_EARS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_CANINE_EARS_0" },
}

ccb.content.define_mutation {
    id = "LUPINE_EARS",
    name = ccb.content.text("Lupine Ears"),
    description = ccb.content.text("Your hearing has evolved further and is now on par with that of wolves.  You can hear things significantly farther away."),
    categories = { "LUPINE" },
    types = { "EARS" },
    prerequisites = { "CANINE_EARS" },
    points = 1,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_LUPINE_EARS_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE",
    name = ccb.content.text("Lupine Muzzle"),
    description = ccb.content.text("Your jaw and nose have extended into a wolfish muzzle.  It lends itself to biting in combat and looks impressive, but prevents wearing mouthgear."),
    categories = { "BEAST", "LUPINE" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    secondary_prerequisites = { "FANGS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 4,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 6 },
    enchantments = { "INLINE_ENCH_MUZZLE_0" },
}

ccb.content.define_mutation {
    id = "MANSBESTFRIEND",
    name = ccb.content.text("Man's Best Friend"),
    description = ccb.content.text("Man's oldest and most well known friends are all Lupines.  Somehow you've mutated something that reminds other survivors of your more domestic relatives.  A softer edge around the eyes, maybe."),
    categories = { "LUPINE" },
    types = { "EYES" },
    prerequisites = { "LUPINE_FUR", "LUPINE_FUR_SUMMER" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 60,
    social_modifiers = { lie = -5, persuade = 5, intimidate = -5 },
}

ccb.content.define_mutation {
    id = "PACK_HUNTER",
    name = ccb.content.text("Pack Hunter"),
    description = ccb.content.text("Puny as they may seem, a hunter needs a pack, and some of those hairless bipeds may yet prove some worth.  You continue to gain combat skills at an elevated rate, and maintain a level of critical thinking that supports cooperation."),
    categories = { "LUPINE" },
    types = { "PREDATION" },
    prerequisites = { "CARNIVORE" },
    secondary_prerequisites = { "PRED3" },
    threshold_requirements = { "THRESH_LUPINE" },
    strict_threshold_requirements = true,
    points = 4,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "PRED3" },
    social_modifiers = { intimidate = 4 },
}

ccb.content.define_mutation {
    id = "PERSISTENCE_HUNTER",
    name = ccb.content.text("Persistence Hunter"),
    description = ccb.content.text("You can pursue prey for miles and miles at a variety of paces until they stop from exhaustion."),
    categories = { "LUPINE" },
    types = { "METABOLISM" },
    replacements = { "PERSISTENCE_HUNTER2" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_PERSISTENCE_HUNTER_0" },
}

ccb.content.define_mutation {
    id = "PERSISTENCE_HUNTER2",
    name = ccb.content.text("Extreme Persistence Hunter"),
    description = ccb.content.text("You can pursue prey for days until they literally die from exhaustion.  It's too bad zombies don't fatigue either."),
    categories = { "LUPINE" },
    types = { "METABOLISM" },
    prerequisites = { "PERSISTENCE_HUNTER" },
    threshold_requirements = { "THRESH_LUPINE" },
    strict_threshold_requirements = true,
    points = 10,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_PERSISTENCE_HUNTER2_0" },
}

ccb.content.define_mutation {
    id = "FEL_EYE",
    name = ccb.content.text("Feline Eyes"),
    description = ccb.content.text("Your eyes have mutated; now you have slit pupils, and they glitter in the light, much like a cat's.  This is visually striking, but it isn't helping you see at night."),
    categories = { "FELINE" },
    types = { "EYES" },
    additions = { "FEL_NV" },
    points = 0,
    vitamin_cost = 60,
    visibility = 2,
    ugliness = 1,
    social_modifiers = { lie = 2, persuade = 2 },
}

ccb.content.define_mutation {
    id = "FEL_NV",
    name = ccb.content.text("Feline Vision"),
    description = ccb.content.text("Your optic nerves and brain caught up with your eyes.  Now you can see pretty well at night.  Activate to toggle NV-visible areas on or off."),
    categories = { "FELINE" },
    types = { "VISION" },
    prerequisites = { "FEL_EYE" },
    points = 4,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FEL_NV_0" },
}

ccb.content.define_mutation {
    id = "WHISKERS",
    name = ccb.content.text("Whiskers"),
    description = ccb.content.text("You have a handsome set of whiskers around your mouth.  These make you more aware of vibrations in the air, and improve your ability to dodge very slightly."),
    categories = { "FELINE", "RABBIT" },
    types = { "WHISKERS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "FELINE_EARS",
    name = ccb.content.text("Feline Ears"),
    description = ccb.content.text("Your ears have extended into long, pointed, velvety ones, like those of a feline.  You find it easier to tune in on sounds from afar."),
    categories = { "FELINE" },
    types = { "EARS" },
    points = 1,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_FELINE_EARS_0" },
}

ccb.content.define_mutation {
    id = "SABER_TEETH",
    name = ccb.content.text("Saber Teeth"),
    description = ccb.content.text("Your fangs have grown extremely large and incredibly sharp.  They make it impossible to wear mouthgear and difficult to eat… but leave nasty wounds when you bite."),
    categories = { "FELINE", "CHIMERA" },
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_FELINE", "THRESH_CHIMERA" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 8,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 15 },
    integrated_armor = { "integrated_saber_teeth" },
}

ccb.content.define_mutation {
    id = "FELINE_LEAP",
    name = ccb.content.text("Pounce"),
    description = ccb.content.text("You've gained a strong ability to leap a short distance from a standing position with little preparation time."),
    categories = { "FELINE" },
    prerequisites = { "TAIL_LONG" },
    secondary_prerequisites = { "STRONG_LEGS" },
    threshold_requirements = { "THRESH_FELINE" },
    cancels = { "LEAPING_LEGS", "LEAPING_LEGS2" },
    points = 3,
    active = true,
    vitamin_cost = 160,
    activation_setup_only = false,
    consumes_stamina = true,
    cost = 2000,
    on_activate = "activate_feline_leap",
}

ccb.content.define_mutation {
    id = "FELINE_FLEXIBILITY",
    name = ccb.content.text("Feline Flexibility"),
    description = ccb.content.text("Your muscles, joints, and the movement center of your brain have changed internally somewhat, allowing you to traverse obstacles with ease."),
    categories = { "FELINE" },
    threshold_requirements = { "THRESH_FELINE" },
    points = 4,
    purifiable = false,
    vitamin_cost = 190,
    enchantments = { "INLINE_ENCH_FELINE_FLEXIBILITY_0" },
}

ccb.content.define_mutation {
    id = "HATES_WATER",
    name = ccb.content.text("Hates Water"),
    description = ccb.content.text("You really hate getting your fur all wet.  This increases morale penalties for being wet, and you will get them even when wearing appropriate clothing."),
    categories = { "FELINE" },
    prerequisites = { "FELINE_FUR" },
    cancels = { "OUTDOORSMAN" },
    points = -2,
    vitamin_cost = 160,
    wet_protection = {
        { part = "head", good = -12 },
        { part = "leg_l", good = -16 },
        { part = "leg_r", good = -16 },
        { part = "foot_l", good = -4 },
        { part = "foot_r", good = -4 },
        { part = "arm_l", good = -16 },
        { part = "arm_r", good = -16 },
        { part = "hand_l", good = -16 },
        { part = "hand_r", good = -16 },
        { part = "torso", good = -30 },
    },
}

ccb.content.define_mutation {
    id = "RABBIT_EARS",
    name = ccb.content.text("Rabbit Ears"),
    description = ccb.content.text("Your ears have grown into tall and flexible rabbit ears.  They're are slender and enhance your hearing beyond the normal range."),
    categories = { "RABBIT" },
    types = { "EARS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 9,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_RABBIT_EARS_0" },
}

ccb.content.define_mutation {
    id = "RABBIT_NOSE",
    name = ccb.content.text("Rabbit Nose"),
    description = ccb.content.text("Your nose has morphed into a cute bunny nose, along with the snout.  It's extremely twitchy too."),
    categories = { "RABBIT" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = -1,
    vitamin_cost = 90,
    visibility = 6,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_RABBIT_NOSE_0" },
}

ccb.content.define_mutation {
    id = "INCISORS",
    name = ccb.content.text("Incisors"),
    description = ccb.content.text("Your big teeth have grown in.  Folks had best show some more respect."),
    categories = { "RAT", "RABBIT" },
    types = { "TEETH" },
    prerequisites = { "MUZZLE_RAT", "RABBIT_NOSE" },
    threshold_requirements = { "THRESH_RAT", "THRESH_RABBIT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "MUZZLE_RAT",
    name = ccb.content.text("Rodent Muzzle"),
    description = ccb.content.text("Your face and jaw have extended, giving you an alert and attentive appearance."),
    categories = { "RAT", "MOUSE" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = -2,
    vitamin_cost = 160,
    visibility = 6,
    ugliness = 4,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_MUZZLE_RAT_0" },
}

ccb.content.define_mutation {
    id = "MOUSE_EARS",
    name = ccb.content.text("Rodent Ears"),
    description = ccb.content.text("Your ears are huge, round, and gray!  They're rather fascinating, and help you hear from a much greater distance."),
    categories = { "MOUSE", "RAT" },
    types = { "EARS" },
    threshold_requirements = { "THRESH_MOUSE", "THRESH_RAT" },
    points = 1,
    vitamin_cost = 80,
    visibility = 8,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_MOUSE_EARS_0" },
}

ccb.content.define_mutation {
    id = "SMALL",
    name = ccb.content.text("Little"),
    description = ccb.content.text("You've noticeably shrunk in size.  You're able to move with increased litheness, but your smaller stature prevents you from carrying as much."),
    categories = { "MOUSE", "RABBIT" },
    types = { "SIZE" },
    replacements = { "SMALL2" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 5,
    flags = { "SMALL" },
    enchantments = { "INLINE_ENCH_SMALL_0" },
}

ccb.content.define_mutation {
    id = "SMALL2",
    name = ccb.content.text("Tiny"),
    description = ccb.content.text("You're only half as tall as you used to be!  The weight of things you once found easy to carry is now unbearable, clothes are now twice as encumbering for you unless you refit them (since you're half their size), and your hit points are heavily reduced.  However, your movement is silent, and your dodge skill is a little higher."),
    categories = { "MOUSE" },
    types = { "SIZE" },
    prerequisites = { "SMALL" },
    replacements = { "SMALL_OK" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 8,
    flags = { "TINY" },
    enchantments = { "INLINE_ENCH_SMALL2_0" },
}

ccb.content.define_mutation {
    id = "SMALL_OK",
    name = ccb.content.text("Unassuming"),
    description = ccb.content.text("You've mastered your tiny form!  Item encumbrance and carry weight penalties are reduced, and you've learned to use your increased nimbleness to offset your reduced capacity to absorb damage."),
    categories = { "MOUSE" },
    types = { "SIZE" },
    prerequisites = { "SMALL2" },
    additions = { "CRAFTY" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 3,
    mixed_effect = true,
    purifiable = false,
    vitamin_cost = 300,
    flags = { "TINY" },
    enchantments = { "INLINE_ENCH_SMALL_OK_0" },
}

ccb.content.define_mutation {
    id = "WHISKERS_RAT",
    name = ccb.content.text("Wiry Whiskers"),
    description = ccb.content.text("You have a set of prominent rodent-like whiskers around your mouth.  These make you more aware of vibrations in the air, and improve your ability to dodge slightly."),
    categories = { "RAT", "MOUSE" },
    types = { "WHISKERS" },
    prerequisites = { "MUZZLE_RAT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "CRAFTY",
    name = ccb.content.text("Crafty"),
    description = ccb.content.text("By making the most of your small stature, you can avoid the notice of all but the most perceptive creatures, and your speed is greatly increased."),
    categories = { "MOUSE" },
    prerequisites = { "SMALL_OK" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 4,
    purifiable = false,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_CRAFTY_0" },
}

ccb.content.define_mutation {
    id = "NO_THIRST",
    name = ccb.content.text("Metabolic Rehydration"),
    description = ccb.content.text("Your body gets everything it needs from the food that you eat!  You no longer need hydration from fluids."),
    categories = { "MOUSE" },
    types = { "THIRST" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 6,
    purifiable = false,
    vitamin_cost = 210,
    flags = { "NO_THIRST" },
}

ccb.content.define_mutation {
    id = "BURROW",
    name = ccb.content.text("Burrowing"),
    description = ccb.content.text("Your dextrous paws and long teeth allow you to dig through dirt and rubble with ease."),
    categories = { "RAT", "RABBIT" },
    prerequisites = { "CLAWS_ST", "PAWS", "PAWS_LITTLE" },
    secondary_prerequisites = { "INCISORS" },
    threshold_requirements = { "THRESH_RAT", "THRESH_RABBIT" },
    points = 10,
    purifiable = false,
    active = true,
    vitamin_cost = 300,
}

-- Since bears and wolves cannot get incisiors, but still burrow.
ccb.content.define_mutation {
    id = "BURROWLARGE",
    name = ccb.content.text("Burrowing"),
    description = ccb.content.text("Your tough paws allow you to dig through dirt and rubble with ease."),
    categories = { "LUPINE", "URSINE" },
    prerequisites = { "PAWS", "PAWS_LARGE" },
    threshold_requirements = { "THRESH_LUPINE", "THRESH_URSINE" },
    points = 10,
    purifiable = false,
    active = true,
    vitamin_cost = 300,
}

ccb.content.define_mutation {
    id = "MET_RAT",
    name = ccb.content.text("Rapid Metabolism"),
    description = ccb.content.text("You require more resources than most, but heal more rapidly as well.  Provides weak regeneration even when not asleep."),
    categories = { "RAT", "MOUSE", "RABBIT" },
    types = { "HEALING", "SLEEP", "METABOLISM" },
    prerequisites = { "HUNGER" },
    secondary_prerequisites = { "SLEEPY" },
    points = 0,
    vitamin_cost = 250,
    enchantments = { "INLINE_ENCH_MET_RAT_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_LONG",
    name = ccb.content.text("Reptilian Muzzle"),
    description = ccb.content.text("Your face and jaws are a shorter version of those found on alligators.  They look NASTY--as do the bite wounds they can inflict--but prevent wearing mouthgear."),
    categories = { "LIZARD" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    secondary_prerequisites = { "FANGS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 20 },
    enchantments = { "INLINE_ENCH_MUZZLE_LONG_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_RAPTOR",
    name = ccb.content.text("Dromeosaur Muzzle"),
    description = ccb.content.text("Your face has drastically mutated, with the bones of your jaws having extended forth into a long, tapered snout.  The palate of your mouth is considerably vaulted, with curved, serrated teeth lining your saurian maw and reptilian scales covering your muzzle's exterior.  While paleobiology has evidently not evolved with mouth gear in mind (making such items unwearable), the bite wounds you can now inflict promise the ferocity of long-dead beasts."),
    categories = { "RAPTOR" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 20 },
    enchantments = { "INLINE_ENCH_MUZZLE_RAPTOR_0" },
}

ccb.content.define_mutation {
    id = "FORKED_TONGUE",
    name = ccb.content.text("Forked Tongue"),
    description = ccb.content.text("Your tongue is forked, like that of a reptile.  This has no effect."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "TONGUE" },
    points = 0,
    visibility = 1,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "LIZ_EYE",
    name = ccb.content.text("Reptilian Eyes"),
    description = ccb.content.text("Your eyes have mutated, with a brilliant iris and slitted pupil similar to that of a lizard.  This is visually striking, but doesn't seem to affect your vision."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "EYES" },
    additions = { "LIZ_IR" },
    points = 0,
    vitamin_cost = 60,
    visibility = 2,
    ugliness = 1,
    social_modifiers = { persuade = -1, intimidate = 1 },
}

ccb.content.define_mutation {
    id = "LIZ_IR",
    name = ccb.content.text("Reptilian IR"),
    description = ccb.content.text("Your optic nerves and brain have mutated to catch up with your eyes, allowing you to see in the infrared spectrum."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "VISION" },
    prerequisites = { "LIZ_EYE" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "REGEN_LIZ",
    name = ccb.content.text("Reptilian Healing"),
    description = ccb.content.text("Your broken limbs mend themselves without significant difficulty in addition to your already-quick healing.  You do not require splints for broken limbs."),
    categories = { "LIZARD" },
    prerequisites = { "FASTHEALER" },
    threshold_requirements = { "THRESH_LIZARD" },
    cancels = { "ROT1", "ROT2", "ROT3" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    flags = { "MEND_ALL" },
    enchantments = { "INLINE_ENCH_REGEN_LIZ_0" },
}

ccb.content.define_mutation {
    id = "BLOODLETTER",
    name = ccb.content.text("Bloodletter"),
    description = ccb.content.text("Your saliva contains powerful anticoagulants.  If you have a bite attack, it will prolong the bleeding of most animals, including humans and the undead.  It may be less effective against insects and stranger creatures."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "HEMOVORE", "BLOODFEEDER" },
    points = 2,
    vitamin_cost = 160,
    flags = { "DRACULIN_VENOM" },
}

ccb.content.define_mutation {
    id = "BLOODFEEDER",
    name = ccb.content.text("Bloodfeeder"),
    description = ccb.content.text("Your craving for blood borders on obsession.  You need the stuff too much to care about whether it came from a human, and your body can filter out most of the toxins in mutant blood."),
    categories = { "CHIROPTERAN" },
    types = { "DIET" },
    prerequisites = { "HEMOVORE" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    strict_threshold_requirements = true,
    cancels = { "VEGAN" },
    points = -2,
    mixed_effect = true,
    vitamin_cost = 160,
    flags = { "BLOODFEEDER" },
    vitamin_intervals = { iron = 800, vitC = -600 },
    vitamin_absorption = { blood = { mutant_toxin = 0.25 }, flesh = { mutant_toxin = 0.75 } },
}

ccb.content.define_mutation {
    id = "ECHOLOCATION",
    name = ccb.content.text("Echolocation"),
    description = ccb.content.text("You've learned how to hunt without sight.  Activate this mutation to make a quiet chirp that can reveal obstacles and enemies by its echo."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "BATEARS" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    points = 3,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SLIT_NOSTRILS",
    name = ccb.content.text("Slit Nostrils"),
    description = ccb.content.text("You have a flattened nose and thin slits for nostrils, giving you a lizard-like appearance.  This makes breathing slightly difficult and increases mouth encumbrance by 10."),
    categories = { "LIZARD", "CEPHALOPOD", "RAPTOR", "CHIROPTERAN" },
    replacements = { "LEAFNOSE" },
    points = -2,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_SLIT_NOSTRILS_0" },
}

ccb.content.define_mutation {
    id = "LEAFNOSE",
    name = ccb.content.text("Leaf Nose"),
    description = ccb.content.text("Your nose is upturned, ridged and flared out into a leaf shape that humans will likely find unsightly.  On the plus side, thermoreceptors in your nostrils allow you to smell heat as long as you can breathe."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "SLIT_NOSTRILS", "BLOODFEEDER" },
    points = 2,
    vitamin_cost = 160,
    ugliness = 3,
    enchantments = { "THERMAL_VISION_LEAFNOSE" },
}

-- A bat mutant is a bit better at hearing overall than someone with GOODHEARING and a CBM.
ccb.content.define_mutation {
    id = "BATEARS",
    name = ccb.content.text("Bat Ears"),
    description = ccb.content.text("Your broad, pointed ears are like radar dishes.  You can hear even the slightest sounds at great distance, and are less likely to be deafened by loud noises."),
    categories = { "CHIROPTERAN" },
    types = { "HEARING", "EARS" },
    prerequisites = { "GOODHEARING" },
    points = 5,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 2,
    flags = { "HEARING_PROTECTION", "SAFECRACK_NO_TOOL" },
    enchantments = { "INLINE_ENCH_BATEARS_0" },
}

ccb.content.define_mutation {
    id = "FANGS",
    name = ccb.content.text("Fangs"),
    description = ccb.content.text("Your teeth have grown into long, sharp fangs.  If your mouth is uncovered, you'll sometimes bite your enemies."),
    categories = { "LIZARD", "FISH", "LUPINE", "FELINE", "CHIMERA", "CHIROPTERAN", "URSINE", "BEAST" },
    types = { "TEETH" },
    replacements = { "SABER_TEETH", "SHARKTEETH", "FANGS_VAMPIRE" },
    points = 2,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    integrated_armor = { "integrated_fangs" },
}

ccb.content.define_mutation {
    id = "FANGS_VAMPIRE",
    name = ccb.content.text("Vampire Fangs"),
    description = ccb.content.text("Your teeth are so sharp, you can use them to shave the fur from your victims before you feed.  What's more, anticoagulants in your saliva will keep their blood flowing long after it should have clotted."),
    categories = { "CHIROPTERAN" },
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    strict_threshold_requirements = true,
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 3,
    integrated_armor = { "integrated_vampire_fangs" },
}

ccb.content.define_mutation {
    id = "ARM_FEATHERS",
    name = ccb.content.text("Feathered Arms"),
    description = ccb.content.text("Your forearms are covered by long, stiff feathers.  While they are impressive to look at and resistant to water and other contaminants, they always get in the way and you hate it when they get filthy."),
    categories = { "RAPTOR", "BIRD" },
    types = { "ARMS" },
    replacements = { "WINGS_BIRD" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 2,
    covered_encumbrance = { arm_feathers_l = 4, arm_feathers_r = 4 },
    enchantments = { "INLINE_ENCH_ARM_FEATHERS_0", "INLINE_ENCH_ARM_FEATHERS_1" },
}

ccb.content.define_mutation {
    id = "LIGHT_BONES",
    name = ccb.content.text("Light Bones"),
    description = ccb.content.text("Your bones are very light.  This enables you to move and attack 10% faster, but also reduces your carrying weight by 20% and makes bashing attacks hurt a little more."),
    categories = { "MOUSE", "RABBIT", "BIRD", "SLIME", "ELFA", "SPIDER", "CHIROPTERAN" },
    types = { "BONES" },
    replacements = { "HOLLOW_BONES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_LIGHT_BONES_0" },
}

ccb.content.define_mutation {
    id = "HOLLOW_BONES",
    name = ccb.content.text("Hollow Bones"),
    description = ccb.content.text("You have Avian Bone Syndrome--your bones are nearly hollow.  Your body is very light as a result, enabling you to move and attack 20% faster, but also frail; you can carry 40% less, and bashing attacks injure you more."),
    categories = { "BIRD", "SLIME", "ELFA" },
    types = { "BONES" },
    prerequisites = { "LIGHT_BONES" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_HOLLOW_BONES_0" },
}

ccb.content.define_mutation {
    id = "BIRD_EYE",
    name = ccb.content.text("Avian Eyes"),
    description = ccb.content.text("Your vision has become particularly acute: you suspect you could pick out zombies much farther away.  Perception +2, as well as increased vision and reaction limb scores."),
    categories = { "BIRD" },
    types = { "EYES" },
    prerequisites = { "PER_UP_4" },
    threshold_requirements = { "THRESH_BIRD" },
    points = 5,
    vitamin_cost = 210,
    visibility = 1,
    enchantments = { "INLINE_ENCH_BIRD_EYE_0", "INLINE_ENCH_BIRD_EYE_1" },
}

ccb.content.define_mutation {
    id = "GIZZARD",
    name = ccb.content.text("Gizzard"),
    description = ccb.content.text("You seem to get full faster now, and food goes through you more rapidly as well."),
    categories = { "BIRD" },
    prerequisites = { "BEAK", "BEAK_PECK", "BEAK_HUM" },
    secondary_prerequisites = { "LIGHTEATER" },
    threshold_requirements = { "THRESH_BIRD" },
    cancels = { "GOURMAND" },
    points = -5,
    purifiable = false,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_GIZZARD_0" },
}

ccb.content.define_mutation {
    id = "BEAK",
    name = ccb.content.text("Beak"),
    description = ccb.content.text("You have a beak for a mouth.  You can use it to peck at your enemies, but it is impossible for you to wear mouth gear.  Slightly reduces wet effects."),
    categories = { "BIRD", "CEPHALOPOD" },
    types = { "TEETH" },
    replacements = { "BEAK_HUM", "BEAK_PECK" },
    cancels = { "MUZZLE", "MUZZLE_RAT", "MUZZLE_BEAR" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 4,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    wet_protection = { { part = "mouth", ignored = 1 } },
    enchantments = { "INLINE_ENCH_BEAK_0" },
}

ccb.content.define_mutation {
    id = "BEAK_PECK",
    name = ccb.content.text("Woodpecker Beak"),
    description = ccb.content.text("Pecking at prey is part of your daily routine now.  Slightly reduces wet effects."),
    categories = { "BIRD" },
    types = { "TEETH" },
    prerequisites = { "BEAK" },
    threshold_requirements = { "THRESH_BIRD" },
    cancels = { "MOUTH_TENTACLES", "MUZZLE", "MUZZLE_RAT", "MUZZLE_LONG", "MUZZLE_RAPTOR", "MUZZLE_BEAR" },
    points = 0,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 5,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    wet_protection = { { part = "mouth", ignored = 2 } },
    enchantments = { "INLINE_ENCH_BEAK_PECK_0" },
    armor = { { parts = { "head", "beak" }, resistances = { bash = 3 } } },
}

ccb.content.define_mutation {
    id = "BEAK_HUM",
    name = ccb.content.text("Hummingbird Beak"),
    description = ccb.content.text("Though your beak's not suitable for pecking, those flowers out there are a good source of energy.  Examine them to feed."),
    categories = { "BIRD" },
    types = { "TEETH" },
    prerequisites = { "BEAK" },
    threshold_requirements = { "THRESH_BIRD" },
    strict_threshold_requirements = true,
    cancels = { "MOUTH_TENTACLES" },
    points = 0,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 5,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_BEAK_HUM_0" },
    wet_protection = { { part = "mouth", ignored = 2 } },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY1",
    name = ccb.content.text("Muscle Consolidation"),
    description = ccb.content.text("Your extremities have gained strength but lost fine motor skills.  -1 Dexterity +2 Strength."),
    categories = { "GASTROPOD" },
    replacements = { "GASTROPOD_EXTREMITY2" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY1_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY2",
    name = ccb.content.text("Rasping Tongue"),
    description = ccb.content.text("You've developed an extremely long and mobile tongue capped with teeth.  You may use it to attack your enemies and pull them towards you."),
    categories = { "GASTROPOD" },
    types = { "TONGUE" },
    replacements = { "GASTROPOD_EXTREMITY3" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    cancels = { "FANGS", "MANDIBLES" },
    points = 6,
    active = true,
    vitamin_cost = 210,
    visibility = 1,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY2_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY3",
    name = ccb.content.text("Harpoon Tongue"),
    description = ccb.content.text("Your tongue has increased its length and mobility.  You may use it to pull your enemies towards you."),
    categories = { "GASTROPOD" },
    types = { "TONGUE" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 8,
    active = true,
    vitamin_cost = 300,
    visibility = 5,
    ugliness = 5,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY3_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_FOOT",
    name = ccb.content.text("Gastropod Foot"),
    description = ccb.content.text("Your legs have consolidated into a single muscular 'foot' that goes up into your belly.  You move about a fourth of your previous speed and can no longer wear pants or shoes, on the other hand you make significantly less noise.  In addition to being harder to knock down, you can move through sludge-covered surfaces easily."),
    categories = { "GASTROPOD" },
    types = { "RUNNING", "LEGS", "FEET" },
    prerequisites = { "SLIMY" },
    additions = { "GASTROPOD_BALANCE" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 9,
    flags = { "SLUDGE_IMMUNE", "TOUGH_FEET" },
    destroys_gear = true,
    restricts_gear = { "leg_l", "leg_r", "foot_l", "foot_r" },
    allowed_item_flags = { "ALLOWS_GASTROPOD_FOOT" },
    enchantments = { "INLINE_ENCH_GASTROPOD_FOOT_0", "INLINE_ENCH_GASTROPOD_FOOT_1" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_BALANCE",
    name = ccb.content.text("Gastropod Balance"),
    description = ccb.content.text("By pushing your whole 'foot' against the ground you are able to move across rough terrain without losing your 'footing'.  You're also able to cling to the ground underwater, allowing you to move along the bottom more easily."),
    categories = { "GASTROPOD" },
    prerequisites = { "GASTROPOD_FOOT" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    vitamin_cost = 60,
    flags = { "WALK_UNDERWATER" },
}

ccb.content.define_mutation {
    id = "MUCUS_SECRETION",
    name = ccb.content.text("Mucus Secretion"),
    description = ccb.content.text("You once had a significant other call you slimy, now you exemplify that.  It covers everything you come into contact with but now you can move through slime you didn't create with ease."),
    categories = { "GASTROPOD" },
    prerequisites = { "GASTROPOD_FOOT" },
    additions = { "MUCUS_SECRETION2" },
    replacements = { "SNAIL_TRAIL" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    vitamin_cost = 80,
    visibility = 2,
    ugliness = 2,
    flags = { "IRRITANT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "MUCUS_SECRETION2",
    name = ccb.content.text("Acidic Secretion"),
    description = ccb.content.text("Your mucus has developed an acidic component that seems to soften your prey up.  When attacking unarmed, sometimes your slime will hit your target as well."),
    categories = { "GASTROPOD" },
    prerequisites = { "MUCUS_SECRETION" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 3,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    flags = { "IRRITANT_IMMUNE" },
    enchantments = { "INLINE_ENCH_MUCUS_SECRETION2_0" },
}

ccb.content.define_mutation {
    id = "SNAIL_TRAIL",
    name = ccb.content.text("Snail Trail"),
    description = ccb.content.text("You've developed some ability to control your slime emissions.  As a result of this you can leave trails of slime anywhere you walk."),
    categories = { "GASTROPOD" },
    prerequisites = { "MUCUS_SECRETION" },
    points = 3,
    active = true,
    cooldown = "100 s",
    cost = 174,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    visibility = 4,
    ugliness = 4,
    flags = { "IRRITANT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "SLIME_SPRAY",
    name = ccb.content.text("Slime Spray"),
    description = ccb.content.text("You exude slime from your pores.  You can spread that slime on an opponent in melee range."),
    categories = { "GASTROPOD" },
    prerequisites = { "VISCOUS", "AMORPHOUS" },
    points = 1,
    active = true,
    cost = 700,
    vitamin_cost = 60,
    consumes_calories = true,
    visibility = 1,
    ugliness = 2,
    activation_setup_only = false,
    on_activate = "activate_slime_spray",
}

ccb.content.define_mutation {
    id = "SHELL",
    name = ccb.content.text("Shell"),
    description = ccb.content.text("You have grown a thick shell over your torso, providing excellent armor, but you cannot wear anything on your torso.  Somewhat reduces wet effects."),
    categories = { "CEPHALOPOD", "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "CHITIN", "THICKSKIN" },
    replacements = { "SHELL2" },
    cancels = { "CHITIN3" },
    points = 0,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 3,
    integrated_armor = { "integrated_shell" },
    wet_protection = { { part = "torso", ignored = 26 } },
}

ccb.content.define_mutation {
    id = "SHELL2",
    name = ccb.content.text("Roomy Shell"),
    description = ccb.content.text("Your protective shell has grown large enough to accommodate--if need be--your whole body.  Activate to pull your head and limbs into your shell, trading mobility and vision for warmth and shelter."),
    categories = { "CEPHALOPOD", "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "SHELL" },
    replacements = { "SHELL3" },
    threshold_requirements = { "THRESH_CEPHALOPOD", "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 0,
    mixed_effect = true,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 3,
    comfort = {
        {
            conditions = { { kind = "trait", id = "SHELL2", active = true } },
            comfort = "sleep_aid",
            add_sleep_aids = true,
        },
    },
    body_temperature = { 500, 750 },
    integrated_armor = { "integrated_shell2" },
    enchantments = { "INLINE_ENCH_SHELL2_0" },
    wet_protection = { { part = "torso", ignored = 26 } },
}

ccb.content.define_mutation {
    id = "SHELL3",
    name = ccb.content.text("Nacreous Shell"),
    description = ccb.content.text("Your protective shell has developed increased strength and hardness and a mother of pearl sheen."),
    categories = { "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "SHELL2" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 0,
    mixed_effect = true,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -2,
    comfort = {
        {
            conditions = { { kind = "trait", id = "SHELL3", active = true } },
            comfort = "sleep_aid",
            add_sleep_aids = true,
        },
    },
    integrated_armor = { "integrated_shell3" },
    wet_protection = { { part = "torso", ignored = 45 } },
}

ccb.content.define_mutation {
    id = "EYEBULGE",
    name = ccb.content.text("Bulging Eyes"),
    description = ccb.content.text("Your eyes bulge out several inches from your skull.  This does not affect your vision in any way."),
    categories = { "BATRACHIAN", "INSECT", "GASTROPOD", "FISH", "CRUSTACEAN" },
    types = { "EYES" },
    additions = { "MEMBRANE" },
    replacements = { "COMPOUND_EYES", "EYESTALKS1", "FROG_EYES" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_EYEBULGE_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS1",
    name = ccb.content.text("Intermediate Eyestalks"),
    description = ccb.content.text("Your eyes barely protrude from your head on tentacles, preventing the use of any rigid eyewear.  On the plus side, you can have additional awareness, but sometimes your vision goes wonky as your brain tries to process the new angles."),
    categories = { "GASTROPOD", "CRUSTACEAN" },
    types = { "EYES" },
    replacements = { "EYESTALKS2", "EYESTALKS_RIGID" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    allow_soft_gear = true,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_EYESTALKS1_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS2",
    name = ccb.content.text("Eyestalks"),
    description = ccb.content.text("Your eyes protrude from your head on flexible tentacles, preventing the use of any eyewear.  On the plus side, you can see in two directions at once, and they automatically retract to reduce damage."),
    categories = { "GASTROPOD" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    types = { "EYES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    purifiable = false,
    restricts_gear = { "eyes" },
    armor = { { parts = { "eyes_snail_good" }, resistances = { cut = 3, bash = 1 } } },
    enchantments = { "INLINE_ENCH_EYESTALKS2_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS_RIGID",
    name = ccb.content.text("Rigid Eyestalks"),
    description = ccb.content.text("You have compound eyes on rigid stalks that can fold back against your head to protect them from danger.  This gives you better all-around vision and allows you to see underwater, but interferes with eyewear.  Your vision and reaction limb scores are also increased."),
    categories = { "CRUSTACEAN" },
    types = { "EYES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    allow_soft_gear = true,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_EYESTALKS_RIGID_0" },
}

ccb.content.define_mutation {
    id = "FROG_EYES",
    name = ccb.content.text("Frog Eyes"),
    description = ccb.content.text("Your eyes bulge noticeably out of your face, and you are able to move them much more freely than before.  You can see movement and close objects clearly, but you have trouble picking up distant details in the light.  Instead of eyelids they are covered by a translucent, protective membrane that blocks irritants and water.  It allows you to sleep with your eyes open!  Activate to cause the approach of hostile creatures to wake you up."),
    categories = { "BATRACHIAN" },
    types = { "EYES", "VISION" },
    prerequisites = { "EYEBULGE" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    cancels = { "MEMBRANE", "MYOPIC", "URSINE_EYE", "MESOPIC" },
    points = 0,
    active = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 4,
    armor = { { parts = { "eyes" }, resistances = { cut = 3, bash = 1 } } },
    wet_protection = { { part = "eyes", neutral = 1 } },
    enchantments = { "INLINE_ENCH_FROG_EYES_0" },
}

ccb.content.define_mutation {
    id = "PHEROMONE_AMPHIBIAN",
    name = ccb.content.text("Amphibian Pheromones"),
    description = ccb.content.text("Your body produces low-level pheromones, identifying you as a friend to many species of amphibian.  Amphibians will attack you much less."),
    categories = { "BATRACHIAN" },
    types = { "PHEROMONE" },
    prerequisites = { "SMELLY2" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "WIDE_MOUTH",
    name = ccb.content.text("Wide Mouth"),
    description = ccb.content.text("You have an unsettlingly wide mouth, like a frog.  This looks hideous, but allows you to swallow your food whole."),
    categories = { "BATRACHIAN" },
    types = { "MUZZLE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 8,
    enchantments = { "INLINE_ENCH_WIDE_MOUTH_0" },
    wet_protection = { { part = "mouth", good = 6 } },
}

ccb.content.define_mutation {
    id = "LONG_TONGUE",
    name = ccb.content.text("Lolling Tongue"),
    description = ccb.content.text("Your tongue has lengthened and often extends far beyond your mouth.  This has no effect."),
    categories = { "BATRACHIAN" },
    types = { "TONGUE" },
    replacements = { "LONG_TONGUE2" },
    points = 0,
    visibility = 1,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "LONG_TONGUE2",
    name = ccb.content.text("Whipping Tongue"),
    description = ccb.content.text("You've developed an extremely long and mobile tongue.  You may use it to pull your enemies towards you."),
    categories = { "BATRACHIAN" },
    types = { "TONGUE" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 3,
    active = true,
    vitamin_cost = 160,
    visibility = 1,
}

-- Create an effect on condition that reduces nausea quickly whenever it occurs by one intensity per vomit?
ccb.content.define_mutation {
    id = "VOMITSTOMACH",
    name = ccb.content.text("Stomach Cleanse"),
    description = ccb.content.text("You have gained the ability to invert your stomach outside your body to quickly eliminate toxins, and are more likely to throw up from food poisoning, alcohol, etc.  If you throw up because of this, you won't suffer any residual nausea."),
    categories = { "BATRACHIAN" },
    types = { "CONSTITUTION" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 1,
    starting_trait = false,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_VOMITSTOMACH_0" },
}

ccb.content.define_mutation {
    id = "DIRTSLEEPER",
    name = ccb.content.text("Earth Sleeper"),
    description = ccb.content.text("You always sleep better surrounded by earth."),
    categories = { "BATRACHIAN" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_DIRTSLEEPER_0" },
}

ccb.content.define_mutation {
    id = "STRONGKNEES",
    name = ccb.content.text("Strong Knees"),
    description = ccb.content.text("Your knees are strong and capable of angles that you couldn't imagine previously.  Moving over rough terrain will slow you down less than normal."),
    categories = { "BATRACHIAN" },
    cancels = { "BADKNEES", "REALLYBADKNEES" },
    points = 1,
    enchantments = { "INLINE_ENCH_STRONGKNEES_0" },
}

ccb.content.define_mutation {
    id = "AMPHIBIAN",
    name = ccb.content.text("Amphibious"),
    description = ccb.content.text("You're as comfortable in water as on land, and your body has adapted around that fact.  Your base swimming speed is greatly increased, and weight will hinder you much less while swimming."),
    categories = { "FISH", "BATRACHIAN" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_AMPHIBIAN_0" },
}

ccb.content.define_mutation {
    id = "WATERSLEEP",
    name = ccb.content.text("Aqueous Repose"),
    description = ccb.content.text("Falling asleep underwater is easy for you, and you spend less time asleep when you rest there.  You can also eat underwater, though you can't drink."),
    categories = { "FISH", "BATRACHIAN", "CEPHALOPOD" },
    prerequisites = { "SEESLEEP", "FROG_EYES", "GILLS_CEPH" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN", "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    points = 1,
    vitamin_cost = 60,
    comfort = {
        {
            conditions = { { kind = "terrain", flag = "DEEP_WATER" } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You lay beneath the waves' embrace, gazing up through the water's surface…"),
                rating = "good",
            },
        },
        {
            conditions = { { kind = "terrain", flag = "SWIMMABLE" } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You settle into the water and begin to drowse…"),
                rating = "good",
            },
        },
    },
}

ccb.content.define_mutation {
    id = "WATERSLEEPER",
    name = ccb.content.text("Aquatic Sleeper"),
    description = ccb.content.text("You always sleep better underwater."),
    categories = { "BATRACHIAN", "FISH" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_WATERSLEEPER_0" },
}

ccb.content.define_mutation {
    id = "FRESHWATEROSMOSIS",
    name = ccb.content.text("Freshwater Osmosis"),
    description = ccb.content.text("Your gills and skin are highly permeable to moisture, and you can hydrate your body through osmosis.  While submerged in fresh water, any thirst you might have will be slaked."),
    categories = { "FISH", "BATRACHIAN" },
    prerequisites = { "GILLS" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "ELECTRORECEPTORS",
    name = ccb.content.text("Electroreceptors"),
    description = ccb.content.text("A network of jelly-filled electroreceptors, like that of a shark, have grown throughout your face and nose.  They are very sensitive to magnetic fields, allowing you to see robots and creatures charged with electricity through walls, but being shocked will seriously mess you up."),
    categories = { "FISH" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    enchantments = { "ELECTRIC_VISION", "INLINE_ENCH_ELECTRORECEPTORS_1" },
}

ccb.content.define_mutation {
    id = "MEMBRANE",
    name = ccb.content.text("Nictitating Membrane"),
    description = ccb.content.text("You have a set of clear lenses which lower over your eyes while underwater, allowing you to see as though you were wearing goggles.  Slightly decreases wet penalties."),
    categories = { "LIZARD", "FISH" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 2,
    flags = { "EYE_MEMBRANE" },
    wet_protection = { { part = "eyes", neutral = 1 } },
}

ccb.content.define_mutation {
    id = "SEESLEEP",
    name = ccb.content.text("Lidless Eyes"),
    description = ccb.content.text("Like a true fish, your eyes lack eyelids, and are instead covered by a translucent, protective membrane that blocks irritants and water, and provides minor armor.  It also allows you to sleep with your eyes open!  Activate to cause the approach of hostile creatures to wake you up."),
    categories = { "FISH" },
    threshold_requirements = { "THRESH_FISH" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 4,
    flags = { "EYE_MEMBRANE", "SEESLEEP" },
    armor = { { parts = { "eyes" }, resistances = { cut = 3, bash = 1 } } },
}

ccb.content.define_mutation {
    id = "GILLS",
    name = ccb.content.text("Gills"),
    description = ccb.content.text("You've grown a set of gills in your neck, allowing you to breathe underwater.  Slightly increases wet benefits."),
    categories = { "FISH", "BATRACHIAN", "CRUSTACEAN" },
    types = { "GILLS" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN", "THRESH_CRUSTACEAN" },
    points = 2,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 3,
    flags = { "GILLS" },
    wet_protection = { { part = "head", good = 1 } },
}

ccb.content.define_mutation {
    id = "SHARKTEETH",
    name = ccb.content.text("Shark Teeth"),
    description = ccb.content.text("Your teeth have grown incredibly sharp, and have calcified even further.  In addition to letting you eat much faster, you can use them as a lethal natural weapon, as long as your anatomy favors it.  They also grow very fast, and you harmlessly shed them more or less at random."),
    categories = { "FISH" },
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_FISH" },
    points = 3,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 8,
    social_modifiers = { intimidate = 5 },
    integrated_armor = { "integrated_shark_teeth" },
    enchantments = { "INLINE_ENCH_SHARKTEETH_0" },
}

ccb.content.define_mutation {
    id = "TOXICFLESH",
    name = ccb.content.text("Toxic Flesh"),
    description = ccb.content.text("Your flesh is highly poisonous, and creatures that bite you will receive a nasty surprise."),
    categories = { "FISH", "GASTROPOD" },
    threshold_requirements = { "THRESH_FISH", "THRESH_GASTROPOD" },
    points = 1,
    purifiable = false,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "CEPH_EYES",
    name = ccb.content.text("Cephalopod Eyes"),
    description = ccb.content.text("Your eyes still bulge, yet your pupils look different somehow.  Water doesn't seem to cause any trouble at all, though."),
    categories = { "CEPHALOPOD" },
    types = { "EYES" },
    additions = { "CEPH_VISION" },
    points = 1,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 5,
    flags = { "EYE_MEMBRANE" },
}

ccb.content.define_mutation {
    id = "CEPH_VISION",
    name = ccb.content.text("Cephalopod Vision"),
    description = ccb.content.text("Your brain has caught up with your eyes.  You can see much better in the dark, but sunlight seems much brighter now.  Activate to toggle NV-visible areas on or off."),
    categories = { "CEPHALOPOD" },
    types = { "VISION" },
    prerequisites = { "CEPH_EYES" },
    points = 3,
    active = true,
    starts_active = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_CEPH_VISION_0" },
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
}

ccb.content.define_mutation {
    id = "CEPH_MIND",
    name = ccb.content.text("Cephalopod Mind"),
    description = ccb.content.text("Your mind has been altered in such a way that you now find it very difficult to understand humans.  Your capability to persuade and lie to them suffers slightly, even if it is mitigated by your intelligence.  In addition, while you find it much easier to learn by doing now, the plasticity of your psyche means you forget skills much faster."),
    categories = { "CEPHALOPOD" },
    types = { "HUMAN_EMPATHY" },
    prerequisites = { "INT_UP_4" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    cancels = { "TRUTHTELLER", "LIAR", "SLOWLEARNER", "FASTLEARNER" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    social_modifiers = { lie = -5, persuade = -5 },
    enchantments = { "INLINE_ENCH_CEPH_MIND_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_MIND",
    name = ccb.content.text("Apathy of the Outer Dark"),
    description = ccb.content.text("Your mind has been altered in such a way that you now find it very difficult to relate to or understand humans, the things they know, and the things they care about.  You are no longer bothered by much, but your ability to persuade, lie, and retain human knowledge is diminished."),
    categories = { "INTERSTICE" },
    types = { "HUMAN_EMPATHY" },
    prerequisites = { "NUMB" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    mixed_effect = true,
    cancels = { "TRUTHTELLER", "LIAR", "SLOWLEARNER", "FASTLEARNER" },
    points = -1,
    purifiable = false,
    vitamin_cost = 210,
    social_modifiers = { lie = -5, persuade = -5 },
    enchantments = { "INLINE_ENCH_INTERSTICE_MIND_0" },
    flags = { "NUMB" },
}

ccb.content.define_mutation {
    id = "GILLS_CEPH",
    name = ccb.content.text("Cephalopod Gills"),
    description = ccb.content.text("You've grown a set of gills, running from your neck up behind your ears.  They allow you to breathe underwater and slightly increase wet benefits."),
    categories = { "CEPHALOPOD" },
    types = { "GILLS" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    points = 2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 4,
    flags = { "GILLS" },
    wet_protection = { { part = "head", good = 1 } },
}

ccb.content.define_mutation {
    id = "INK_GLANDS",
    name = ccb.content.text("Ink Glands"),
    description = ccb.content.text("Several ink glands have developed in your gill structure.  When active, they will spray defensive ink and blind an attacker in an emergency."),
    categories = { "CEPHALOPOD" },
    prerequisites = { "GILLS_CEPH" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_INK_GLANDS_0" },
}

ccb.content.define_mutation {
    id = "MOUTH_FLAPS",
    name = ccb.content.text("Mouth Flaps"),
    description = ccb.content.text("Skin tabs and odd flaps of skin surround your mouth.  They don't affect your eating, but are unpleasant to look at."),
    categories = { "CHIMERA", "CEPHALOPOD", "INSECT", "SPIDER" },
    types = { "MUZZLE" },
    replacements = { "MOUTH_TENTACLES", "MANDIBLES" },
    points = -1,
    vitamin_cost = 60,
    visibility = 7,
    ugliness = 6,
}

ccb.content.define_mutation {
    id = "MOUTH_TENTACLES",
    name = ccb.content.text("Mouth Tentacles"),
    description = ccb.content.text("A set of tentacles surrounds your mouth.  They allow you to eat twice as fast.  Slightly decreases wet penalties."),
    categories = { "CEPHALOPOD" },
    types = { "MUZZLE" },
    prerequisites = { "MOUTH_FLAPS" },
    points = 1,
    vitamin_cost = 70,
    visibility = 8,
    ugliness = 5,
    enchantments = { "INLINE_ENCH_MOUTH_TENTACLES_0" },
    wet_protection = { { part = "mouth", neutral = 4 } },
}

-- Increases the lumination the more you hunger (max hunger = 300, max lumination when you hunger = 30, ie 3 tile of light), and the more you happy (1 tile of lumination for each +10 morale, negative morage excluded)
ccb.content.define_mutation {
    id = "BIOLUM0",
    name = ccb.content.text("Reflex Photophore"),
    description = ccb.content.text("A photophore has grown from your head.  You can't consciously control it, and it might start to shine in response to your emotions or your physiological state."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    replacements = { "BIOLUM1" },
    points = -1,
    vitamin_cost = 60,
    covered_encumbrance = { head = 5 },
    enchantments = { "INLINE_ENCH_BIOLUM0_0" },
}

ccb.content.define_mutation {
    id = "BIOLUM1",
    name = ccb.content.text("Weak Photophore"),
    description = ccb.content.text("A photophore has grown from your head; you can make it glow softly.  This will make you very visible in the dark, ideal for attracting a partner during mating season."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM0" },
    replacements = { "BIOLUM2" },
    points = 2,
    active = true,
    cooldown = "225 h",
    cost = 9,
    vitamin_cost = 160,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    transform = {
        target = "BIOLUM1_active",
        message = ccb.content.text("Your photophore starts glowing."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM1_active",
    copy_from = "BIOLUM1",
    name = ccb.content.text("Weak Photophore (on)"),
    description = ccb.content.text("Your photophore is glowing softly."),
    valid = false,
    body_light = { head = 8 },
    transform = {
        target = "BIOLUM1",
        message = ccb.content.text("Your photophore stops glowing."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM2",
    name = ccb.content.text("Photophore"),
    description = ccb.content.text("You can make your photophore glow brightly."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM1" },
    additions = { "BIOLUM3" },
    points = 3,
    active = true,
    cooldown = "112 h 30 m",
    cost = 9,
    vitamin_cost = 160,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    transform = {
        target = "BIOLUM2_active",
        message = ccb.content.text("Your photophore starts glowing."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM2_active",
    copy_from = "BIOLUM2",
    name = ccb.content.text("Photophore (on)"),
    description = ccb.content.text("You photophore is glowing brightly."),
    valid = false,
    body_light = { head = 20 },
    transform = {
        target = "BIOLUM2",
        message = ccb.content.text("Your photophore stops glowing."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM3",
    name = ccb.content.text("Bioluminescent Flare"),
    description = ccb.content.text("You can spit a wad of bioluminescent goo several meters away.  There it will light up its surroundings until it dissipates."),
    categories = { "INSECT" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM2" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 6,
    active = true,
    cost = 400,
    vitamin_cost = 210,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    on_activate = "activate_biolum3",
}

ccb.content.define_mutation {
    id = "INSECT_RESERVOIR",
    name = ccb.content.text("Bulging Reservoir"),
    description = ccb.content.text("You develop a reservoir of fluids that bulges out of your abdomen.  Your body has adapted to containing extra liquids in event of shortfalls."),
    categories = { "INSECT" },
    types = { "THIRST" },
    additions = { "BOMBADIER_BLAST" },
    points = 0,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 3,
    enchantments = { "INLINE_ENCH_INSECT_RESERVOIR_0" },
}

ccb.content.define_mutation {
    id = "BOMBADIER_BLAST",
    name = ccb.content.text("Bombardier Beetle Blast"),
    description = ccb.content.text("You have an ability to spray boiling water on your enemies at melee distance.  This will drastically increase your thirst.  Without an extra reservoir you would quickly dehydrate yourself."),
    categories = { "INSECT" },
    prerequisites = { "INSECT_RESERVOIR" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 5,
    active = true,
    cost = 95,
    vitamin_cost = 210,
    consumes_water = true,
    visibility = 1,
    ugliness = 2,
    attacks = {
        {
            player_message = ccb.content.text("You spray %s with a boiling chemical mixture!"),
            npc_message = ccb.content.text("%1$s sprays %2$s with a boiling chemical mixture!"),
            body_part = "torso",
            chance = 15,
            base_damage = { type = "heat", amount = 15 },
            strength_damage = { type = "heat", amount = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "PHEROMONE_INSECT",
    name = ccb.content.text("Insect Pheromones"),
    description = ccb.content.text("Your body produces low-level pheromones, identifying you as a friend to many species of insects.  Insects will attack you much less."),
    categories = { "INSECT" },
    types = { "PHEROMONE" },
    prerequisites = { "SMELLY2" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "COMPOUND_EYES",
    name = ccb.content.text("Compound Eyes"),
    description = ccb.content.text("Your eyes are compound, like those of an insect.  This increases your reaction time, but your fine detailed vision isn't as acute."),
    categories = { "INSECT" },
    types = { "EYES" },
    prerequisites = { "EYEBULGE" },
    points = 2,
    vitamin_cost = 160,
    visibility = 9,
    ugliness = 5,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_COMPOUND_EYES_0" },
}

ccb.content.define_mutation {
    id = "ANTENNAE",
    name = ccb.content.text("Antennae"),
    description = ccb.content.text("You have a pair of antennae.  They allow you to detect the presence of monsters up to a few tiles away, even if you can't see or hear them, but prevent wearing headwear that is not made of fabric."),
    categories = { "INSECT" },
    types = { "HORNS" },
    prerequisites = { "HEADBUMPS" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
    visibility = 9,
    ugliness = 4,
    allow_soft_gear = true,
    restricts_gear = { "head_crown" },
    enchantments = { "INLINE_ENCH_ANTENNAE_0" },
}

ccb.content.define_mutation {
    id = "MANDIBLES",
    name = ccb.content.text("Mandibles"),
    description = ccb.content.text("A set of insect-like mandibles have grown around your mouth.  They allow you to eat faster and provide a slicing unarmed attack.  Slightly reduces wet effects."),
    categories = { "INSECT", "SPIDER" },
    types = { "TEETH", "MUZZLE" },
    prerequisites = { "MOUTH_FLAPS" },
    additions = { "PROBOSCIS" },
    replacements = { "FANGS_SPIDER" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 90,
    visibility = 8,
    ugliness = 6,
    provided_qualities = { BUTCHER = 4 },
    integrated_armor = { "integrated_mandibles" },
    enchantments = { "INLINE_ENCH_MANDIBLES_0" },
    wet_protection = { { part = "mouth", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "PROBOSCIS",
    name = ccb.content.text("Proboscis"),
    description = ccb.content.text("You've gotten rid of that terribly imprecise mouth and now imbibe your food like a proper person.  Chewing was tiresome anyway."),
    categories = { "INSECT" },
    prerequisites = { "MANDIBLES" },
    secondary_prerequisites = { "CHITIN", "CHITIN2", "CHITIN2_MOLTED" },
    points = -4,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 7,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_PROBOSCIS_0" },
}

ccb.content.define_mutation {
    id = "CF_HAIR",
    name = ccb.content.text("Urticating Hairs"),
    description = ccb.content.text("Significant amounts of your hairs have loosened.  If some creature tries to attack you, your assailant is quite likely to get fine, bristly chitin in an irritating spot; it doesn't carry your venom but it will be distracting."),
    categories = { "SPIDER" },
    prerequisites = { "CHITIN3", "CHITIN3_MOLTED" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 3,
    vitamin_cost = 160,
    visibility = 1,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "FANGS_SPIDER",
    name = ccb.content.text("Folding Fangs"),
    description = ccb.content.text("You have developed deadly extensible fangs, allowing you to bite quickly or ensure your venom goes home, as desired."),
    categories = { "SPIDER" },
    types = { "TEETH", "MUZZLE" },
    prerequisites = { "MANDIBLES" },
    secondary_prerequisites = { "POISONOUS", "POISONOUS2" },
    cancels = { "MOUTH_TENTACLES" },
    points = 2,
    vitamin_cost = 120,
    visibility = 6,
    ugliness = 6,
    integrated_armor = { "integrated_fangs_spider" },
    enchantments = { "INLINE_ENCH_FANGS_SPIDER_0" },
    wet_protection = { { part = "mouth", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "POISONOUS",
    name = ccb.content.text("Venomous"),
    description = ccb.content.text("Your body produces a potent venom.  Cutting or stabbing attacks from mutations have a chance to poison your target."),
    categories = { "SLIME", "TROGLOBITE", "SPIDER", "CEPHALOPOD", "GASTROPOD", "CHIMERA", "BATRACHIAN" },
    prerequisites = { "POISRESIST" },
    replacements = { "POISONOUS2" },
    points = 1,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "POISONOUS2",
    name = ccb.content.text("Strongly Venomous"),
    description = ccb.content.text("Your venom has become particularly strong.  You're confident that your bites or other cutting/stabbing natural attacks will take your target down quickly."),
    categories = { "SPIDER" },
    prerequisites = { "POISONOUS" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "WEB_WALKER",
    name = ccb.content.text("Web Walker"),
    description = ccb.content.text("Your body excretes very fine amounts of a chemical which prevents you from sticking to webs.  Walking through webs does not affect you at all."),
    categories = { "SPIDER" },
    additions = { "WEB_WEAVER" },
    points = 1,
    vitamin_cost = 60,
    comfort = {
        {
            conditions = {
                { kind = "field", id = "fd_web", intensity = 3 },
                { kind = "trait", id = "WEB_SPINNER", invert = true },
                { kind = "trait", id = "WEB_WEAVER", invert = true },
            },
            comfort = "sleep_aid",
            use_better_comfort = true,
            add_sleep_aids = true,
            try_message = {
                text = ccb.content.text_without_extraction("These thick webs support your weight, and are strangely comfortable…"),
                rating = "good",
            },
        },
        {
            conditions = {
                { kind = "field", id = "fd_web" },
                { kind = "trait", id = "WEB_SPINNER", invert = true },
                { kind = "trait", id = "WEB_WEAVER", invert = true },
            },
            add_human_comfort = true,
            add_sleep_aids = true,
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but the webs get in the way.  You brush them aside."),
                rating = "info",
            },
        },
    },
    flags = { "WEBWALK" },
}

ccb.content.define_mutation {
    id = "WEB_SPINNER",
    name = ccb.content.text("Web Spinner"),
    description = ccb.content.text("Your body produces and anchors webbing.  Too bad you can't seem to control the process.  There is a chance that you will leave webs in your wake."),
    categories = { "SPIDER" },
    types = { "SECRETION" },
    prerequisites = { "WEB_WALKER" },
    replacements = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = -3,
    vitamin_cost = 160,
    comfort = {
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3, invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but you feel exposed and your spinnerets keep twitching."),
                rating = "bad",
            },
            hint_message = {
                text = ccb.content.text_without_extraction("Maybe a nice thick web would help you sleep."),
                rating = "info",
            },
        },
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3 } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax into your web."),
                rating = "good",
            },
        },
    },
}

ccb.content.define_mutation {
    id = "WEB_WEAVER",
    name = ccb.content.text("Web Weaver"),
    description = ccb.content.text("You've developed the necessary anatomy and techniques to control your web-generation.  Activate this to start or stop weaving webs."),
    categories = { "SPIDER" },
    types = { "SECRETION" },
    prerequisites = { "WEB_SPINNER" },
    additions = { "WEB_RAPPEL", "WEB_ROPE" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    cooldown = "100 s",
    cost = 69,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    comfort = {
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3, invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but you feel exposed and your spinnerets keep twitching."),
                rating = "bad",
            },
            hint_message = {
                text = ccb.content.text_without_extraction("Maybe a nice thick web would help you sleep."),
                rating = "info",
            },
        },
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3 } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax into your web."),
                rating = "good",
            },
        },
    },
}

ccb.content.define_mutation {
    id = "WEB_RAPPEL",
    name = ccb.content.text("Web Diver"),
    description = ccb.content.text("Your webbing is strong enough to support your weight.  Activate to rappel down any drop you encounter, at the cost of nutrition."),
    categories = { "SPIDER" },
    prerequisites = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    cost = 95,
    vitamin_cost = 160,
    consumes_calories = true,
    active_flags = { "WEB_RAPPEL" },
}

ccb.content.define_mutation {
    id = "WEB_ROPE",
    name = ccb.content.text("Rope Webs"),
    description = ccb.content.text("With spinnerets like THESE, who needs rope?!  Activate to produce rope."),
    categories = { "SPIDER" },
    prerequisites = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 3,
    active = true,
    cost = 260,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    spawn_item = { item = "rope_30", message = ccb.content.text("You spin a rope from your silk.") },
}

ccb.content.define_mutation {
    id = "ROT1",
    name = ccb.content.text("Weakening"),
    description = ccb.content.text("You feel as though you are slowly weakening and your body heals slower."),
    categories = { "ELFA", "CHIMERA", "ALPHA" },
    types = { "HEALING" },
    replacements = { "ROT2" },
    points = -2,
    vitamin_cost = 160,
    body_temperature = { -250, -250 },
    enchantments = { "INLINE_ENCH_ROT1_0" },
}

ccb.content.define_mutation {
    id = "ROT2",
    name = ccb.content.text("Deterioration"),
    description = ccb.content.text("Your body is very slowly wasting away."),
    categories = { "CHIMERA", "ALPHA" },
    types = { "HEALING" },
    prerequisites = { "ROT1" },
    replacements = { "ROT3" },
    points = -8,
    vitamin_cost = 250,
    body_temperature = { -750, -750 },
    enchantments = { "INLINE_ENCH_ROT2_0" },
}

ccb.content.define_mutation {
    id = "ROT3",
    name = ccb.content.text("Disintegration"),
    description = ccb.content.text("Your body is slowly wasting away!"),
    categories = { "ALPHA" },
    types = { "HEALING" },
    prerequisites = { "ROT2" },
    secondary_prerequisites = { "STR_ALPHA", "DEX_ALPHA", "PER_ALPHA", "INT_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = -10,
    vitamin_cost = 260,
    body_temperature = { -1500, -1500 },
    enchantments = { "INLINE_ENCH_ROT3_0" },
}

ccb.content.define_mutation {
    id = "VANITY",
    name = ccb.content.text("Highly Vain"),
    description = ccb.content.text("You know you're beautiful, and the world deserves to know it too.  You prefer to show off your stunningly good looks and will be unhappy if you cover up your face."),
    categories = { "ALPHA" },
    prerequisites = { "BEAUTIFUL", "BEAUTIFUL2" },
    points = -1,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "ALPHA_COMPLEX",
    name = ccb.content.text("Superiority Complex"),
    description = ccb.content.text("You can't stand to prostrate yourself before your lessers and hate it when they don't immediately do what you say.  Persuasion is much more difficult, but you're better at lying and intimidating."),
    categories = { "ALPHA" },
    types = { "SOCIAL" },
    prerequisites = { "INT_ALPHA", "PER_ALPHA" },
    secondary_prerequisites = { "STR_ALPHA", "DEX_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = 0,
    purifiable = false,
    vitamin_cost = 180,
    social_modifiers = { lie = 10, persuade = -25, intimidate = 10 },
}

ccb.content.define_mutation {
    id = "NUMB",
    name = ccb.content.text("Numb"),
    description = ccb.content.text("Your ability to feel or express emotion has been greatly hampered."),
    categories = { "MEDICAL", "INTERSTICE" },
    types = { "HUMAN_EMPATHY" },
    threshold_requirements = { "THRESH_MEDICAL", "THRESH_INTERSTICE" },
    replacements = { "INTERSTICE_MIND" },
    points = 0,
    purifiable = false,
    vitamin_cost = 160,
    flags = { "NUMB" },
}

ccb.content.define_mutation {
    id = "STIMBOOST",
    name = ccb.content.text("Stimulant Psychosis"),
    description = ccb.content.text("You have a unique history with stimulants (like coffee or amphetamines).  You can tolerate a lot more of them without overdosing, but if you indulge too much, you start seeing things…"),
    categories = { "MEDICAL" },
    cancels = { "NONADDICTIVE" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "PAINREC1",
    name = ccb.content.text("Pain Recovery"),
    description = ccb.content.text("You recover from pain slightly faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    replacements = { "PAINREC2" },
    points = 3,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "PAINREC2",
    name = ccb.content.text("Quick Pain Recovery"),
    description = ccb.content.text("You recover from pain faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    prerequisites = { "PAINREC1" },
    replacements = { "PAINREC3" },
    points = 5,
    vitamin_cost = 210,
}

ccb.content.define_mutation {
    id = "PAINREC3",
    name = ccb.content.text("Very Quick Pain Recovery"),
    description = ccb.content.text("You recover from pain much faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    prerequisites = { "PAINREC2" },
    points = 8,
    vitamin_cost = 300,
}

-- MASOCHIST_MED and NOPAIN don't cancel each other.  By design.  Poor painless folks...
ccb.content.define_mutation {
    id = "MASOCHIST_MED",
    name = ccb.content.text("Pain Junkie"),
    description = ccb.content.text("You've developed a serious appetite for pain, and take pride in your scars."),
    categories = { "MEDICAL" },
    types = { "MASOCHISM" },
    prerequisites = { "MASOCHIST", "PAINRESIST", "ADDICTIVE" },
    secondary_prerequisites = { "PAINREC2", "PAINREC3" },
    replacements = { "CENOBITE" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 4,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 2,
}

-- CENOBITE and NOPAIN also don't cancel each other.  By design.  Poor painless cenobites...
ccb.content.define_mutation {
    id = "CENOBITE",
    name = ccb.content.text("Cenobite"),
    description = ccb.content.text("You positively adore pain, in all its varied forms."),
    categories = { "MEDICAL" },
    types = { "MASOCHISM" },
    prerequisites = { "MASOCHIST_MED" },
    secondary_prerequisites = { "PAINREC3", "ADDICTIVE" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 6,
    purifiable = false,
    vitamin_cost = 210,
    visibility = 4,
    ugliness = 10,
    enchantments = { "INLINE_ENCH_CENOBITE_0" },
}

-- MASOCHIST_MED, CENOBITE, and NOPAIN don't cancel each other.  By design.  Poor painless people...
ccb.content.define_mutation {
    id = "NOPAIN",
    name = ccb.content.text("Deadened"),
    description = ccb.content.text("Nothing hurts anymore.  Those bites tickle and the wounds itch a bit, but that's it."),
    categories = { "MEDICAL" },
    types = { "PAIN" },
    prerequisites = { "MASOCHIST", "PAINRESIST" },
    secondary_prerequisites = { "PAINREC3" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 2,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "PAIN_IMMUNE" },
}

-- Like Resilient, but Medical-flavored, and doesn't need huge/strong
ccb.content.define_mutation {
    id = "TOUGH_MEDICAL",
    name = ccb.content.text("Resilient Physiology"),
    description = ccb.content.text("Your body is well-adapted to resist trauma.  20% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "MEDICAL" },
    types = { "DURABILITY" },
    replacements = { "TOUGH2_MEDICAL" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TOUGH_MEDICAL_0" },
}

-- Like Solidly Built, but Medical-flavored, and doesn't need huge/strong
ccb.content.define_mutation {
    id = "TOUGH2_MEDICAL",
    name = ccb.content.text("Solid Physiology"),
    description = ccb.content.text("Your body is extremely well-adapted to resist trauma.  30% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "MEDICAL" },
    types = { "DURABILITY" },
    prerequisites = { "TOUGH_MEDICAL" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TOUGH2_MEDICAL_0" },
}

ccb.content.define_mutation {
    id = "PARAIMMUNE",
    name = ccb.content.text("Parasite Immune"),
    description = ccb.content.text("Your body is unusually inhospitable to parasitic lifeforms.  You will never become infested with internal parasites."),
    categories = { "CHIMERA", "MEDICAL", "SLIME" },
    prerequisites = { "DISRESISTANT", "DISIMMUNE" },
    secondary_prerequisites = { "INFRESIST", "INFIMMUNE" },
    points = 1,
    vitamin_cost = 60,
    flags = { "PARAIMMUNE" },
}

-- name courtesy of wiktionary's Greek for 'mutate'.  Greek-speakers, feel free to correct the term
ccb.content.define_mutation {
    id = "MUT_JUNKIE",
    name = ccb.content.text("Metallassomaiphile"),
    description = ccb.content.text("Just thinking of mutagen (such a lovely word!  'Mutagen'.  Perfect!) makes you thirsty.  And you so love your new parts.  You simply must have more mutagen!"),
    categories = { "MEDICAL", "CHIMERA" },
    threshold_requirements = { "THRESH_MEDICAL", "THRESH_CHIMERA" },
    points = -1,
    mixed_effect = true,
    purifiable = false,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "TROGLO",
    name = ccb.content.text("Light Sensitive"),
    description = ccb.content.text("Sunlight makes you uncomfortable.  If you are outdoors and the weather is Sunny, you suffer -1 to all stats."),
    categories = {
        "BEAST",
        "INSECT",
        "SLIME",
        "SPIDER",
        "BATRACHIAN",
        "RAT",
        "TROGLOBITE",
        "CHIROPTERAN",
        "INTERSTICE",
    },
    types = { "SUNLIGHT" },
    replacements = { "TROGLO2" },
    cancels = { "SEASONAL_AFFECTIVE" },
    points = -2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TROGLO2",
    name = ccb.content.text("Very Light Sensitive"),
    description = ccb.content.text("Sunlight makes you very uncomfortable.  If you are outdoors during the day, you suffer -1 to all stats; -2 if the weather is Sunny."),
    categories = { "RAT", "TROGLOBITE", "INTERSTICE" },
    types = { "SUNLIGHT" },
    prerequisites = { "TROGLO" },
    replacements = { "TROGLO3" },
    points = -3,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TROGLO3",
    name = ccb.content.text("Troglobite"),
    description = ccb.content.text("Sunlight makes you extremely uncomfortable, resulting in large penalties to all stats."),
    categories = { "TROGLOBITE" },
    purifiable = false,
    types = { "SUNLIGHT" },
    prerequisites = { "TROGLO2" },
    points = -5,
    vitamin_cost = 210,
}

ccb.content.define_mutation {
    id = "SUNBURN",
    name = ccb.content.text("Solar Sensitivity"),
    description = ccb.content.text("Your skin simply cannot handle ultraviolet radiation, such as sunlight.  It will seriously burn you."),
    categories = { "TROGLOBITE" },
    types = { "skin_tone" },
    prerequisites = { "ALBINO" },
    secondary_prerequisites = { "TROGLO2", "TROGLO3" },
    points = -3,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "SUNBURN" },
}

ccb.content.define_mutation {
    id = "SUNBURN_INTERSTICE",
    name = ccb.content.text("Daylight Exclusion"),
    description = ccb.content.text("You cannot handle sunlight.  It will seriously burn you."),
    categories = { "INTERSTICE" },
    prerequisites = { "TROGLO2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    points = -3,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "SUNBURN" },
}

ccb.content.define_mutation {
    id = "NIGHT_RAIDER",
    name = ccb.content.text("Night Raider"),
    description = ccb.content.text("Your body is one with the night.  You make less noise when the moon is up in the sky, even when you cannot see it."),
    categories = { "TROGLOBITE" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_NIGHT_RAIDER_0" },
}

ccb.content.define_mutation {
    id = "ALCMET",
    name = ccb.content.text("Alcohol Metabolism"),
    description = ccb.content.text("So it's fermented?  Whatever, it's still good drinking.  You've developed the ability to metabolize alcohol as a food source."),
    categories = { "TROGLOBITE" },
    prerequisites = { "TOLERANCE" },
    secondary_prerequisites = { "SAPROVORE" },
    points = 2,
    vitamin_cost = 160,
    vitamin_intervals = { BAC = 20 },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROGLO",
    name = ccb.content.text("Subterranean Fortitude"),
    description = ccb.content.text("The aches and pains of living underground don't bother you as much."),
    categories = { "TROGLOBITE" },
    types = { "PAIN" },
    prerequisites = { "PAINRESIST" },
    secondary_prerequisites = { "STOCKY_TROGLO" },
    threshold_requirements = { "THRESH_TROGLOBITE" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_PAINRESIST_TROGLO_0" },
}

-- Trading X for Y usually means reducing X to gain Y, so I switched the order.
ccb.content.define_mutation {
    id = "STOCKY_TROGLO",
    name = ccb.content.text("Subterranean Build"),
    description = ccb.content.text("Your frame has adapted for life in confined spaces.  You seem a little shorter and bulkier, trading mobility for muscle mass.  (+2 Strength, -2 Dexterity)"),
    categories = { "TROGLOBITE" },
    purifiable = false,
    threshold_requirements = { "THRESH_TROGLOBITE" },
    points = 0,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 2,
    enchantments = { "INLINE_ENCH_STOCKY_TROGLO_0" },
}

ccb.content.define_mutation {
    id = "TUNNEL_FIGHTER",
    name = ccb.content.text("Tunnel Fighter"),
    description = ccb.content.text("You know how to fight in cramped tunnels at risk of collapse.  You gain bonuses when fighting underground."),
    categories = { "INSECT", "TROGLOBITE", "RAT" },
    additions = { "NIGHT_RAIDER" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TUNNEL_FIGHTER_0" },
}

ccb.content.define_mutation {
    id = "INFRARED",
    name = ccb.content.text("Infrared Vision"),
    description = ccb.content.text("Your eyes have mutated to pick up radiation in the infrared spectrum."),
    categories = { "INSECT", "TROGLOBITE", "SPIDER" },
    prerequisites = { "NIGHTVISION3" },
    threshold_requirements = { "THRESH_INSECT", "THRESH_TROGLOBITE", "THRESH_SPIDER" },
    cancels = { "LIZ_IR" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "REGEN",
    name = ccb.content.text("Regeneration"),
    description = ccb.content.text("Your flesh regenerates and your limbs mend incredibly quickly."),
    categories = { "SLIME", "TROGLOBITE" },
    types = { "HEALING" },
    prerequisites = { "FASTHEALER2" },
    threshold_requirements = { "THRESH_SLIME", "THRESH_TROGLOBITE" },
    points = 6,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_REGEN_0" },
}

ccb.content.define_mutation {
    id = "SLIMY",
    name = ccb.content.text("Slimy"),
    description = ccb.content.text("Your body is coated with a fine slime which makes uncovered skin harder to grab and protects from long-term effects of acid, though not short-term ones.  Greatly increases wet benefits."),
    categories = { "FISH", "SLIME", "TROGLOBITE", "CEPHALOPOD", "GASTROPOD", "BATRACHIAN" },
    types = { "SECRETION" },
    additions = { "SLIME_HANDS" },
    replacements = { "VISCOUS" },
    points = 2,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 6,
    flags = { "IRRITANT_IMMUNE" },
    wet_protection = {
        { part = "head", neutral = 3, good = 4 },
        { part = "leg_l", neutral = 7, good = 14 },
        { part = "leg_r", neutral = 7, good = 14 },
        { part = "foot_l", neutral = 2, good = 4 },
        { part = "foot_r", neutral = 2, good = 4 },
        { part = "arm_l", neutral = 7, good = 12 },
        { part = "arm_r", neutral = 7, good = 12 },
        { part = "hand_l", neutral = 2, good = 3 },
        { part = "hand_r", neutral = 2, good = 3 },
        { part = "torso", neutral = 14, good = 26 },
    },
}

ccb.content.define_mutation {
    id = "VISCOUS",
    name = ccb.content.text("Viscous"),
    description = ccb.content.text("Your body's slime output has become sticky and gel-like, making uncovered skin harder to grab and offering some protection from acid.  Greatly increases wet benefits."),
    categories = { "SLIME", "GASTROPOD" },
    prerequisites = { "SLIMY" },
    additions = { "AMORPHOUS" },
    threshold_requirements = { "THRESH_SLIME", "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 8,
    flags = { "IRRITANT_IMMUNE" },
    armor = { { part_types = { "ALL" }, resistances = { acid = 2 } } },
    wet_protection = {
        { part = "head", neutral = 4, good = 5 },
        { part = "leg_l", neutral = 8, good = 15 },
        { part = "leg_r", neutral = 8, good = 15 },
        { part = "foot_l", neutral = 3, good = 5 },
        { part = "foot_r", neutral = 3, good = 5 },
        { part = "arm_l", neutral = 8, good = 14 },
        { part = "arm_r", neutral = 8, good = 14 },
        { part = "hand_l", neutral = 3, good = 4 },
        { part = "hand_r", neutral = 3, good = 4 },
        { part = "torso", neutral = 15, good = 27 },
    },
}

ccb.content.define_mutation {
    id = "PALE",
    name = ccb.content.text("Pale Skin"),
    description = ccb.content.text("Your skin is rather pale."),
    categories = { "LUPINE", "TROGLOBITE", "MOUSE", "RABBIT", "BEAST" },
    types = { "skin_tone" },
    replacements = { "ALBINO" },
    points = 0,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "SPOTS",
    name = ccb.content.text("Spots"),
    description = ccb.content.text("Your skin is covered in a pattern of red spots."),
    categories = { "BATRACHIAN", "SLIME" },
    replacements = { "SORES" },
    points = 0,
    vitamin_cost = 60,
    visibility = 6,
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "SORES",
    name = ccb.content.text("Sores"),
    description = ccb.content.text("Your extremities are covered in painful sores.  The pain is worse when they are covered in clothing."),
    categories = { "SLIME" },
    prerequisites = { "SPOTS" },
    points = -2,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 6,
}

ccb.content.define_mutation {
    id = "AMORPHOUS",
    name = ccb.content.text("Amorphous Body"),
    description = ccb.content.text("Your flesh is a pleasing gel-like consistency.  Your bodily functions seem to be moving around, and your leg-equivalents flow comfortably - if a little slower than your old meat-legs."),
    categories = { "SLIME" },
    prerequisites = { "VISCOUS" },
    secondary_prerequisites = { "BENDY2", "SLIME_HANDS" },
    additions = { "INT_SLIME", "PER_SLIME" },
    threshold_requirements = { "THRESH_SLIME" },
    points = -2,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 10,
    bionic_exclusions = {
        "torso", "head", "eyes", "mouth", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r",
        "foot_l", "foot_r",
    },
    armor = {
        {
            parts = {
                "torso", "head", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r", "foot_l",
                "foot_r", "mouth", "eyes",
            },
            resistances = { bash = 4 },
        },
    },
    enchantments = { "INLINE_ENCH_AMORPHOUS_0" },
}

ccb.content.define_mutation {
    id = "SLIMESPAWNER",
    name = ccb.content.text("Omnicellular"),
    description = ccb.content.text("Your body is more or less one consistent whole: a single, giant, omni-cell that alters itself as needed."),
    categories = { "SLIME" },
    prerequisites = { "INT_SLIME" },
    secondary_prerequisites = { "PER_SLIME_OK" },
    threshold_requirements = { "THRESH_SLIME" },
    cancels = { "TINYSTOMACH" },
    points = 10,
    purifiable = false,
    active = true,
    cost = 347,
    vitamin_cost = 300,
    consumes_calories = true,
    consumes_water = true,
    visibility = 10,
    ugliness = 10,
    enchantments = { "INLINE_ENCH_SLIMESPAWNER_0", "INLINE_ENCH_SLIMESPAWNER_1" },
    flags = { "DISTRIBUTED_DAMAGE" },
}

ccb.content.define_mutation {
    id = "FEYHEARING",
    name = ccb.content.text("Fey Hearing"),
    description = ccb.content.text("You're not sure the shape of your ears is helping you any; regardless, you have become very sensitive to sounds."),
    categories = { "ELFA" },
    types = { "HEARING" },
    prerequisites = { "GOODHEARING" },
    secondary_prerequisites = { "ELFA_EARS" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FEYHEARING_0" },
}

ccb.content.define_mutation {
    id = "ELFAEYES",
    name = ccb.content.text("Fey Eyes"),
    description = ccb.content.text("Your eyes have turned… green.  It's tough to tell the exact shade, as it seems to shift.  The effect is… pleasant."),
    categories = { "ELFA" },
    types = { "EYES" },
    additions = { "ELFA_NV" },
    points = 1,
    vitamin_cost = 60,
    social_modifiers = { lie = 5, persuade = 5, intimidate = -5 },
}

ccb.content.define_mutation {
    id = "INTERSTICEEYES",
    name = ccb.content.text("Pale Eyes"),
    description = ccb.content.text("Your eyes have turned almost completely white.  The effect is unpleasant and intimidating."),
    categories = { "INTERSTICE" },
    types = { "EYES" },
    additions = { "INTERSTICE_VISION" },
    points = 1,
    vitamin_cost = 60,
    social_modifiers = { persuade = -5, intimidate = 5 },
}

ccb.content.define_mutation {
    id = "INTERSTICEHEARING",
    name = ccb.content.text("Otherworldly Hearing"),
    description = ccb.content.text("You hear so well that you could hear the whisper of a shadow.  And you do.  Everything speaks to you.  You have extremely good hearing, but -1 Intelligence."),
    categories = { "INTERSTICE" },
    types = { "HEARING" },
    prerequisites = { "GOODHEARING" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    mixed_effect = true,
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_INTERSTICEHEARING_0" },
}

ccb.content.define_mutation {
    id = "ELFA_NV",
    name = ccb.content.text("Fey Vision"),
    description = ccb.content.text("Your corneas have taken on the same weird green as your irises, and golden veins shift below the surface in a mesmerizing dance.  The shadows don't seem nearly as dark now."),
    categories = { "ELFA" },
    types = { "VISION" },
    prerequisites = { "ELFAEYES" },
    replacements = { "ELFA_FNV" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 3,
    vitamin_cost = 160,
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
    enchantments = { "INLINE_ENCH_ELFA_NV_0" },
}

ccb.content.define_mutation {
    id = "ELFA_FNV",
    name = ccb.content.text("Fey Nightsight"),
    description = ccb.content.text("Your corneas have taken on the same weird green as your irises, and golden veins shift below the surface in a mesmerizing dance.  You have great low-light vision now, but it doesn't allow you to perform fine tasks such as crafting and reading in darkness."),
    categories = { "ELFA" },
    types = { "VISION" },
    prerequisites = { "ELFA_NV" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 5,
    vitamin_cost = 210,
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
    enchantments = { "INLINE_ENCH_ELFA_FNV_0" },
}

ccb.content.define_mutation {
    id = "ELFA_EARS",
    name = ccb.content.text("Pointed Ears"),
    description = ccb.content.text("Your upper earlobes have grown noticeably higher.  Fortunately, they don't get in the way of your headgear, much.  Unfortunately, they also don't seem to help your hearing any."),
    categories = { "ELFA" },
    types = { "EARS" },
    points = 0,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH",
    name = ccb.content.text("Animal Empathy"),
    description = ccb.content.text("Peaceful animals will not run away from you, and even aggressive animals are less likely to attack.  This only applies to natural animals such as woodland creatures."),
    categories = { "LUPINE", "ELFA" },
    types = { "ANIMAL_EMPATHY" },
    replacements = { "ANIMALEMPATH2" },
    points = 1,
    vitamin_cost = 60,
    flags = { "ANIMALEMPATH" },
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH2",
    name = ccb.content.text("Animal Kinship"),
    description = ccb.content.text("Something about your presence is calming to animals, and they will treat you with innate trust.  This only applies to natural animals such as woodland creatures."),
    categories = { "ELFA" },
    types = { "ANIMAL_EMPATHY" },
    prerequisites = { "ANIMALEMPATH" },
    points = 2,
    vitamin_cost = 160,
    flags = { "ANIMALEMPATH2" },
}

ccb.content.define_mutation {
    id = "ANIMALDISCORD",
    name = ccb.content.text("Animal Discord"),
    description = ccb.content.text("Most animals don't like you, and aggressive animals are more likely to attack you.  This only applies to natural animals such as woodland creatures."),
    categories = { "BEAST", "RAPTOR", "INSECT", "MOUSE", "RABBIT" },
    types = { "ANIMAL_EMPATHY" },
    replacements = { "ANIMALDISCORD2" },
    points = -1,
    vitamin_cost = 60,
    flags = { "ANIMALDISCORD" },
}

ccb.content.define_mutation {
    id = "ANIMALDISCORD2",
    name = ccb.content.text("Prey Animal"),
    description = ccb.content.text("Natural animals like dogs and wolves see you as prey, and are liable to attack you on sight."),
    categories = { "MOUSE", "RABBIT" },
    types = { "ANIMAL_EMPATHY", "PREDATION" },
    prerequisites = { "ANIMALDISCORD" },
    points = -3,
    vitamin_cost = 160,
    flags = { "ANIMALDISCORD2" },
}

ccb.content.define_mutation {
    id = "TERRIFYING",
    name = ccb.content.text("Terrifying"),
    description = ccb.content.text("There's something about you that creatures find frightening, and they are more likely to try to flee."),
    categories = { "BEAST", "INSECT", "CHIMERA", "CRUSTACEAN", "INTERSTICE" },
    types = { "ANIMAL_EMPATHY" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    social_modifiers = { intimidate = 15 },
}

ccb.content.define_mutation {
    id = "THORNS",
    name = ccb.content.text("Thorns"),
    description = ccb.content.text("Your skin is covered in small, woody thorns.  Whenever an unarmed opponent strikes a part of your body that is not covered by clothing, they will receive minor damage.  Your punches may also deal extra damage."),
    categories = { "PLANT" },
    prerequisites = { "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    points = 2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_THORNS_0" },
}

ccb.content.define_mutation {
    id = "LEAVES",
    name = ccb.content.text("Leaves"),
    description = ccb.content.text("All the hair on your body has turned to long, grass-like leaves.  Apart from being physically striking, these provide you with a minor amount of nutrients while in sunlight when your head is uncovered.  Slightly reduces wet effects."),
    categories = { "PLANT", "ELFA" },
    types = { "HAIR" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    replacements = { "LEAVES2" },
    points = 3,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 3,
    wet_protection = { { part = "head", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "LEAVES2",
    name = ccb.content.text("Lush Leaves"),
    description = ccb.content.text("Your leaves have grown in size and prominence, with additional leaves sprouting along your arms.  While your arms and head are uncovered, you will photosynthesize nutrients while in sunlight.  Reduces wet effects."),
    categories = { "PLANT" },
    types = { "HAIR" },
    prerequisites = { "LEAVES" },
    secondary_prerequisites = { "TRANSPIRATION" },
    replacements = { "LEAVES3" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 6,
    vitamin_cost = 210,
    visibility = 10,
    ugliness = 5,
    covered_encumbrance = { arm_l = 5, arm_r = 5 },
    wet_protection = {
        { part = "head", ignored = 4 },
        { part = "arm_l", ignored = 5 },
        { part = "arm_r", ignored = 5 },
    },
}

ccb.content.define_mutation {
    id = "LEAVES3",
    name = ccb.content.text("Verdant Leaves"),
    description = ccb.content.text("Your leaves are vibrant, large, and green, and have become a major source of nutrients for your body.  Whenever your arms and head are uncovered you will gain a large amount of nutrients by standing in the sunlight.  Reduces wet effects."),
    categories = { "PLANT" },
    types = { "HAIR" },
    prerequisites = { "LEAVES2" },
    secondary_prerequisites = { "TRANSPIRATION" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 9,
    vitamin_cost = 350,
    visibility = 12,
    ugliness = 6,
    covered_encumbrance = { arm_l = 10, arm_r = 10 },
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "arm_l", ignored = 8 },
        { part = "arm_r", ignored = 8 },
    },
}

ccb.content.define_mutation {
    id = "FLOWERS",
    name = ccb.content.text("Flowering"),
    description = ccb.content.text("You've started blooming where your scalp used to be.  Your blossoms have a pleasant aroma, are visually striking, and are quite sensitive."),
    categories = { "PLANT", "ELFA" },
    types = { "SCENT" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "HAIRROOTS" },
    replacements = { "ROSEBUDS" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    points = 2,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -4,
    social_modifiers = { lie = 10 },
    enchantments = { "INLINE_ENCH_FLOWERS_0" },
}

ccb.content.define_mutation {
    id = "ROSEBUDS",
    name = ccb.content.text("Rosebuds"),
    description = ccb.content.text("The top of your head is blooming with rosebuds.  They're eye catching, and have a strong fragrance that makes you pleasant to be around."),
    categories = { "PLANT", "ELFA" },
    types = { "SCENT" },
    prerequisites = { "FLOWERS" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    cancels = { "SMELLY", "SMELLY2" },
    points = 3,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -6,
    social_modifiers = { lie = 15, persuade = 10 },
}

ccb.content.define_mutation {
    id = "PONDEROUS1",
    name = ccb.content.text("Ponderous"),
    description = ccb.content.text("Your muscles are generally slow to move.  You move 10% slower."),
    categories = { "URSINE", "CATTLE", "PLANT" },
    types = { "RUNNING" },
    replacements = { "PONDEROUS2" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_PONDEROUS1_0" },
}

ccb.content.define_mutation {
    id = "PONDEROUS2",
    name = ccb.content.text("Very Ponderous"),
    description = ccb.content.text("Your muscles are quite slow to move.  You move 20% slower."),
    categories = { "CATTLE", "PLANT" },
    types = { "RUNNING" },
    prerequisites = { "PONDEROUS1" },
    replacements = { "PONDEROUS3" },
    points = -5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_PONDEROUS2_0" },
}

ccb.content.define_mutation {
    id = "PONDEROUS3",
    name = ccb.content.text("Extremely Ponderous"),
    description = ccb.content.text("Your muscles are very slow to move.  You move 30% slower."),
    categories = { "PLANT" },
    types = { "RUNNING" },
    prerequisites = { "PONDEROUS2" },
    points = -6,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_PONDEROUS3_0" },
}

ccb.content.define_mutation {
    id = "VINES1",
    name = ccb.content.text("Vines"),
    description = ccb.content.text("You have developed several vines sprouting from your shoulder area.  They're bulky, and get in the way."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    replacements = { "VINES2" },
    points = -2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    encumbrance = { torso = 10 },
}

ccb.content.define_mutation {
    id = "VINES2",
    name = ccb.content.text("Vine Limbs"),
    description = ccb.content.text("You've developed the ability to control your vines; they make good lashes.  You can even rappel down sheer drops using them, but disconnecting HURTS."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "VINES1" },
    replacements = { "VINES3" },
    points = 2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    flags = { "VINE_RAPPEL" },
    encumbrance = { torso = 10 },
    enchantments = { "INLINE_ENCH_VINES2_0", "INLINE_ENCH_VINES2_1", "INLINE_ENCH_VINES2_2" },
}

ccb.content.define_mutation {
    id = "VINES3",
    name = ccb.content.text("Vine Sprouter"),
    description = ccb.content.text("You have full control of your vines, and can grow new ones and detach old ones more or less at will."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "VINES2" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 5,
    active = true,
    cost = 90,
    vitamin_cost = 210,
    consumes_calories = true,
    consumes_water = true,
    visibility = 10,
    ugliness = 6,
    flags = { "VINE_RAPPEL" },
    spawn_item = { item = "vine_30", message = ccb.content.text("You detach a vine from your body.") },
    enchantments = { "INLINE_ENCH_VINES3_0", "INLINE_ENCH_VINES3_1", "INLINE_ENCH_VINES3_2" },
}

ccb.content.define_mutation {
    id = "HAIRROOTS",
    name = ccb.content.text("Hair Roots"),
    description = ccb.content.text("Roots have started growing from your leaf-like hair.  They don't seem to do much."),
    categories = { "PLANT", "ELFA" },
    prerequisites = { "LEAVES" },
    points = 0,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "ROOTS1",
    name = ccb.content.text("Toe Roots"),
    description = ccb.content.text("Your toes have grown wriggly, and you can't imagine why you wear that stuff on your feet.  Take it off.  It's in the way."),
    categories = { "PLANT" },
    types = { "FEET" },
    prerequisites = { "PLANTSKIN" },
    replacements = { "ROOTS2" },
    threshold_requirements = { "THRESH_PLANT" },
    cancels = { "LEG_TENTACLES", "HOOVES" },
    points = -2,
    vitamin_cost = 160,
    visibility = 1,
    ugliness = 5,
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

-- The idea is that you, for lack of a better term, plant yourself.  Crafting and digging don't count because they presume a certain amount of movement during the task.  The handheld game does count.
ccb.content.define_mutation {
    id = "ROOTS2",
    name = ccb.content.text("Roots"),
    description = ccb.content.text("It's about time you started developing a root system.  When reading, fishing, waiting, or otherwise being stationary for a while on diggable terrain, you'll extract nutrients and water from the soil."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS1" },
    replacements = { "ROOTS3" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 5,
    flags = { "TOUGH_FEET", "ROOTS2" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "ROOTS3",
    name = ccb.content.text("Rooter"),
    description = ccb.content.text("You find it difficult not to sink roots when able.  You extract nutrients and water whenever on diggable terrain, but move more slowly."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS2" },
    secondary_prerequisites = { "SAPROPHAGE" },
    replacements = { "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 0,
    vitamin_cost = 190,
    visibility = 5,
    ugliness = 5,
    flags = { "TOUGH_FEET", "ROOTS3" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "SUNLIGHT_DEPENDENT",
    name = ccb.content.text("Sunlight Dependent"),
    description = ccb.content.text("You feel very sluggish when not in direct sunlight.  You suffer a 5% drop in speed when in shade, and a 10% drop in speed when in the dark."),
    categories = { "PLANT" },
    types = { "SUNLIGHT" },
    points = -5,
    vitamin_cost = 210,
}

ccb.content.define_mutation {
    id = "CHLOROMORPH",
    name = ccb.content.text("Chloromorphosis"),
    description = ccb.content.text("Every inch of your skin is packed with chlorophyll and you have strong roots.  Sleeping on diggable soil will satisfy any hunger or thirst you might have."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS3" },
    secondary_prerequisites = { "SAPROPHAGE" },
    threshold_requirements = { "THRESH_PLANT" },
    cancels = { "SMELLY", "SMELLY2" },
    points = 10,
    purifiable = false,
    vitamin_cost = 300,
    visibility = 7,
    ugliness = 1,
    scent_type = "sc_flower",
    comfort = {
        {
            conditions = { { kind = "vehicle" } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("It's impossible to sleep in this wheeled pot!"),
                rating = "bad",
            },
        },
        {
            conditions = { { kind = "furniture", id = "f_null", invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("The humans' furniture blocks your roots.  You can't get comfortable."),
                rating = "bad",
            },
        },
        {
            conditions = {
                { kind = "terrain", flag = "PLOWABLE", invert = true },
                { kind = "terrain", flag = "PLANTABLE", invert = true },
                { kind = "terrain", id = "t_pit", invert = true },
                { kind = "terrain", id = "t_pit_shallow", invert = true },
            },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("Your roots scrabble ineffectively at the unyielding surface."),
                rating = "bad",
            },
        },
        {
            conditions = {
                { kind = "terrain", flag = "PLANTABLE" },
                { kind = "terrain", id = "t_dirt" },
                { kind = "terrain", id = "t_pit" },
                { kind = "terrain", id = "t_pit_shallow" },
            },
            any_condition = true,
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax as your roots embrace the soil."),
                rating = "good",
            },
        },
        {
            conditions = { { kind = "terrain", flag = "PLOWABLE" } },
            comfort = "comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax as your roots embrace the soil."),
                rating = "good",
            },
        },
    },
    flags = { "TOUGH_FEET", "ROOTS3" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "TREE_COMMUNION",
    name = ccb.content.text("Mycorrhizal Communion"),
    description = ccb.content.text("You have gained the ability to commune with trees and comprehend their ancient wisdom.  Activate next to a tree to gradually gain overmap vision through connected forests."),
    categories = { "PLANT", "ELFA" },
    prerequisites = { "HAIRROOTS", "ROOTS2", "ROOTS3", "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    points = 2,
    active = true,
    cost = 0,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TRANSPIRATION",
    name = ccb.content.text("Transpiration"),
    description = ccb.content.text("Your body has begun moving nutrients via the evaporation of water.  This increases your thirst when it's hot, but reduces it when it's cold."),
    categories = { "PLANT" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "LEAVES" },
    threshold_requirements = { "THRESH_PLANT" },
    points = -5,
    vitamin_cost = 210,
    visibility = 0,
    ugliness = 0,
}

ccb.content.define_mutation {
    id = "SAPROPHAGE",
    name = ccb.content.text("Saprophage"),
    description = ccb.content.text("You prefer to sustain your nutritional needs using your roots and direct nutrient extraction/synthesis.  Your human parts still need the raw caloric bulk of 'food' to keep them going, though, and you handle it a lot easier if it's had time to… age a little."),
    categories = { "PLANT" },
    types = { "DIET" },
    prerequisites = { "ROOTS2" },
    secondary_prerequisites = { "LEAVES", "LEAVES2", "LEAVES3" },
    additions = { "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT" },
    points = -3,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 9,
    flags = { "IMMUNE_SPOIL" },
}

ccb.content.define_mutation {
    id = "ELDRITCH_IRE",
    name = ccb.content.text("Eldritch Ire"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("As if the apocalypse itself wasn't enough, you are constantly being at the ire of the zombies.  Zombies somehow can sense your presence from very far away and approach your general location."),
}

ccb.content.define_mutation {
    id = "INTERSTICE_PHYSIOLOGY",
    name = ccb.content.text("Unbound Physiology"),
    description = ccb.content.text("Your body is no longer constrained by the rules of this world.  You move deftly and quietly, but this forced existence is exhausting."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_POSTURE_2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = 3,
    mixed_effect = true,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_INTERSTICE_PHYSIOLOGY_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_GROWING",
    name = ccb.content.text("Growing Shadowy Flesh"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The ends of your appendages are covered in an inky, shadowy substance.  It does not impede you at all, but you can feel it growing."),
}

ccb.content.define_mutation {
    id = "INTERSTICE_SHRINKING",
    name = ccb.content.text("Retreating Shadowy Flesh"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The ends of your appendages are covered in an inky, shadowy substance.  It does not impede you at all, and you can feel it slowly shrinking away."),
}

ccb.content.define_mutation {
    id = "RM13_ENVIRONMENTAL",
    name = ccb.content.text_without_extraction("Heatsink"),
    description = ccb.content.text_without_extraction("Your armor makes you immune to many environmental threats."),
    points = 0,
    valid = false,
    starting_trait = false,
    player_display = false,
    flags = { "HEATSINK", "ACID_IMMUNE", "IRRITANT_IMMUNE" },
}
