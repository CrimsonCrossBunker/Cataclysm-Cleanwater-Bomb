local content = require("ccb").content
local text = content.text

content.add(content.Profession {
    id = "SKY_ISLAND_WEREWOLF",
    subtype = "hobby",
    name_male = text("Werewolf, Natural-born (Species)", "profession_male"),
    name_female = text("Werewolf, Natural-born (Species)", "profession_female"),
    description_male = text("You had no idea what was going on the first time it happened, when you woke up with mud on your bare feet and a sour taste in your mouth, but you were soon found.  The People of the Moon, they called themselves, and they said you were one of them.  A werewolf.  You lived out in the wilderness for a while but didn't entirely abandon human civilization, and when the Cataclysm hit you ignored the evacuation warnings and struck it out on your own.  Maybe some of the People are still out there.", "prof_desc_male"),
    description_female = text("You had no idea what was going on the first time it happened, when you woke up with mud on your bare feet and a sour taste in your mouth, but you were soon found.  The People of the Moon, they called themselves, and they said you were one of them.  A werewolf.  You lived out in the wilderness for a while but didn't entirely abandon human civilization, and when the Cataclysm hit you ignored the evacuation warnings and struck it out on your own.  Maybe some of the People are still out there.", "prof_desc_female"),
    points = 3,
    traits = { "NATIVE_SHAPESHIFTER", "WEREWOLF_ANIMAL_FORM", "WEREWOLF_HYBRID_FORM" },
})

content.add(content.Profession {
    id = "SKY_ISLAND_LILIT",
    subtype = "hobby",
    name_male = text("Lilit (Species)", "profession_male"),
    name_female = text("Lilit (Species)", "profession_female"),
    description_male = text("For most or all of your life, you've had a secret; you are a predator.  While you don't need to drink blood or eat flesh or anything so crude, you must absorb the spiritual essence, the \"ruach\", of living beings in order to maintain your health and vitality.  You had to hide your condition before the Cataclysm, especially as things became stranger in the years leading up to it, but now you don't have to hide anymore.  On the other hand, your potential ruach supply has taken a drastic decline.", "prof_desc_male"),
    description_female = text("For most or all of your life, you've had a secret; you are a predator.  While you don't need to drink blood or eat flesh or anything so crude, you must absorb the spiritual essence, the \"ruach\", of living beings in order to maintain your health and vitality.  You had to hide your condition before the Cataclysm, especially as things became stranger in the years leading up to it, but now you don't have to hide anymore.  On the other hand, your potential ruach supply has taken a drastic decline.", "prof_desc_female"),
    points = 3,
    traits = { "LILIN_TRAITS", "LILIN_DRAIN_RUACH_MELEE" },
})

content.add(content.Profession {
    id = "SKY_ISLAND_VAMPIRE",
    subtype = "hobby",
    name_male = text("Vampire", "profession_male"),
    name_female = text("Vampire", "profession_female"),
    description_male = text("As if the world ending and you being stranded on some flying island away from everything wasn't bad enough, you now feel a growing hunger for the blood of others.  Whether you decide to try and cure it or see what abilities can be gained from this condition is up to you.", "prof_desc_male"),
    description_female = text("As if the world ending and you being stranded on some flying island away from everything wasn't bad enough, you now feel a growing hunger for the blood of others.  Whether you decide to try and cure it or see what abilities can be gained from this condition is up to you.", "prof_desc_female"),
    points = 3,
    -- Doesn't give the vampire trait itself to give a grace period before that extra need kicks in.
    -- Intentionally compatible with anything not blocking vampirism, and anything not compatible with vampirism will simply remove the effect without issue.
    traits = { "START_AS_VAMPIRE" },
})
