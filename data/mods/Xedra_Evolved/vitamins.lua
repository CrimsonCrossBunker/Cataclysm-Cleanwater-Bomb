local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "underhill_essence",
        name = ccb.content.text("Relative Physics"),
        kind = "counter",
        minimum = 0,
        maximum = 500,
        rate_turns = 300,
        excess = "relative_physics",
    }
    definition:excess_range(50, 100)
    definition:excess_range(101, 250)
    definition:excess_range(251, 500)
    content.add(definition)
end
-- Only Vampires have the ability to process this vitamin so if other characters gain any amount of this it will stick around forever and potentially give them the excess disease.
-- Regular vampires have a maximum of 5600 blood vitamin.  Only Vampire Anathema can obtain the capacity increase mutations and missing excess tables.
do
    local definition = content.Vitamin {
        id = "human_blood_vitamin",
        name = ccb.content.text("Stolen Blood"),
        kind = "counter",
        minimum = -1502,
        maximum = 32600,
        rate_turns = 0,
        deficiency = "withering",
        excess = "blood_quenched",
    }
    definition:deficiency_range(-1, -300)
    definition:deficiency_range(-301, -750)
    definition:deficiency_range(-751, -1500)
    definition:deficiency_range(-1501, -1502)
    definition:excess_range(1800, 2400)
    definition:excess_range(2401, 4400)
    definition:excess_range(4401, 5600)
    content.add(definition)
end
-- Only Vampire Anathema can gain this vitamin.  It is used to give them their mutations in a way that won't interact with the mutation system as they still can mutate the regular way, despite being locked from thresholds.
content.add(content.Vitamin {
    id = "vampire_blood_vitamin",
    name = ccb.content.text("Stolen Vampire Blood"),
    kind = "counter",
    minimum = 0,
    maximum = 100000,
    rate_turns = 0,
})
-- Maximum amount is one lunar month's worth at 10 spent per hour.
content.add(content.Vitamin {
    id = "lilin_ruach_vitamin",
    name = ccb.content.text("Ruach"),
    kind = "counter",
    minimum = 0,
    maximum = 6720,
    rate_turns = 0,
})
do
    local definition = content.Vitamin {
        id = "cheval",
        name = ccb.content.text("Cheval"),
        kind = "counter",
        minimum = 0,
        maximum = 2000,
        rate_turns = 60,
        deficiency = "cheval_withdrawal",
        excess = "cheval_overdose",
    }
    definition:deficiency_range(1, 400)
    definition:excess_range(401, 1000)
    definition:excess_range(1001, 1300)
    definition:excess_range(1301, 1600)
    definition:excess_range(1601, 2000)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "drank_fae_blood",
        name = ccb.content.text("Hallucinating on Fae blood"),
        kind = "counter",
        minimum = 0,
        maximum = 200,
        rate_turns = 600,
        excess = "drank_fae_blood_hallucination",
    }
    definition:excess_range(1, 5)
    definition:excess_range(6, 18)
    definition:excess_range(19, 30)
    definition:excess_range(31, 200)
    content.add(definition)
end
-- Processed sparks, it respond for inventor's researches of different items, recipes and spells.
content.add(content.Vitamin {
    id = "creative_spark_research",
    name = ccb.content.text("Processed Creativity"),
    kind = "counter",
    minimum = 0,
    maximum = 1000,
    rate_turns = 0,
})
-- This vitamin powers any Spark type abilities for the Inventor/Mad Genius spellcasting class.
do
    local definition = content.Vitamin {
        id = "creative_spark",
        name = ccb.content.text("Creative Spark"),
        kind = "counter",
        minimum = 0,
        maximum = 6,
        rate_turns = 0,
        excess = "creativity",
    }
    definition:excess_range(1, 2)
    definition:excess_range(3, 4)
    definition:excess_range(5, 6)
    content.add(definition)
end
-- This vitamin counts how many stored calories an inventor has.  It also drains them with time to simulate the imperfect process.
content.add(content.Vitamin {
    id = "stored_calories",
    name = ccb.content.text("Stored Calories"),
    kind = "counter",
    minimum = 0,
    maximum = 10000000,
    rate_turns = 120,
})
-- This vitamin counts how many pieces of written media were destroyed through the Book Burner's Buddy.
-- Decay is handled through EOC and effect is handled through the bionic itself, as the effect and the depletion rate increase the higher the vitamin is.
do
    local definition = content.Vitamin {
        id = "burned_books",
        name = ccb.content.text("Burning Knowledge"),
        kind = "counter",
        minimum = 0,
        maximum = 10000,
        rate_turns = 0,
        excess = "effect_burned_books",
    }
    definition:excess_range(1, 20)
    definition:excess_range(21, 40)
    definition:excess_range(41, 60)
    definition:excess_range(61, 80)
    definition:excess_range(81, 100)
    definition:excess_range(101, 120)
    definition:excess_range(121, 140)
    definition:excess_range(141, 160)
    definition:excess_range(161, 180)
    definition:excess_range(181, 10000)
    content.add(definition)
end
-- Respond for dreamer's ability to pull stuff from other dimensions
do
    local definition = content.Vitamin {
        id = "dreamer_vit",
        name = ccb.content.text("Metaphysical Connection"),
        kind = "counter",
        minimum = 0,
        maximum = 1000,
        rate_turns = 0,
        excess = "dreamer_eff",
    }
    definition:excess_range(1, 200)
    definition:excess_range(201, 400)
    definition:excess_range(401, 600)
    definition:excess_range(601, 800)
    definition:excess_range(801, 1000)
    content.add(definition)
end
-- Counts how much insight a chronomancer has obtained.  They automatically obtain 1 per day and may obtain much more by killing particular monsters or other activities.
content.add(content.Vitamin {
    id = "xedra_chronomancer_insight",
    name = ccb.content.text("Insight into Time"),
    kind = "counter",
    minimum = 0,
    maximum = 10000,
    rate_turns = 0,
})
-- This vitamin scales everything the player gains and suffers from reading this book.
content.add(content.Vitamin {
    id = "xedra_knowing_lies",
    name = ccb.content.text("Knowledge of the Lies"),
    kind = "counter",
    minimum = 0,
    maximum = 99999,
    rate_turns = 60,
})
do
    local definition = content.Vitamin {
        id = "mutagen_earthkin",
        name = ccb.content.text("Ierde Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_earthkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_plantkin",
        name = ccb.content.text("Arvore Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_plantkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_alchemical_plantkin",
        name = ccb.content.text("Arvore Alchemical Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_alchemical_plantkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_waterkin",
        name = ccb.content.text("Undine Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_waterkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_flamekin",
        name = ccb.content.text("Salamander Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_flamekin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_dollkin",
        name = ccb.content.text("Homullus Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_dollkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_airkin",
        name = ccb.content.text("Sylph Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_airkin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fair_folk_noble",
        name = ccb.content.text("Noble Fair Folk Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fair_folk_noble",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fair_folk_commoner_brownie",
        name = ccb.content.text("Brownie Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fair_folk_commoner_brownie",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fair_folk_commoner_pooka",
        name = ccb.content.text("Pooka Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fair_folk_commoner_pooka",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fair_folk_commoner_selkie",
        name = ccb.content.text("Selkie Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fair_folk_commoner_selkie",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fair_folk_commoner_trow",
        name = ccb.content.text("Trow Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fair_folk_commoner_trow",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_lilin",
        name = ccb.content.text("Lilin Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_lilin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
