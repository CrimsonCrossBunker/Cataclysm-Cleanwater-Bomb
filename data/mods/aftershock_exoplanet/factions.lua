local ccb = require("ccb")
local content = ccb.content

-- Native faction templates
do
local definition = content.Faction {
    id = "Prepnet_Phyle",
    name = ccb.content.text("PrepNet Phyle"),
    description = ccb.content.text("A multitude of frontier homesteading groups brought together by their use of the PrepNet communication protocols.  Spread out onto the edges of the frontier, enthusiastically squatting and building tiny kingdoms often consisting of just a couple families or like-minded individuals.  Their mutual aid societies are wildly varied in their laws; influenced by the people who set them up, but they all share in a distrust for those that wish to impose restrictions upon new colonization efforts."),
    likes = 0,
    respects = 0,
    known = false,
    size = 15,
    power = 20,
    wealth = 75000,
    currency = "crypto_coin",
    monster_faction = "PrepNet",
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
    relations = {
        ["your_followers"] = { "share public goods", "knows your voice" },
        ["tskbem_vostok"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["UICA"] = { "kill on sight" },
        ["wraitheon"] = { "kill on sight" },
        ["mercurial"] = { "kill on sight" },
        ["whately_family"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "UICA",
    name = ccb.content.text("United Interstellar Coordination Authority"),
    description = ccb.content.text("A loose confederation and military alliance composed by Solar Corporations, Governments, and other politically relevant organizations united by their desire to restore Earth's dominion over the Orion Arm.  Due to the disinterest of the Salus Charter owners and the recent rediscovery of the system, UICA administers Salus IV using a combination of military and civilian law designed to maximize wealth extraction, with the bulk of their forces concentrated within Port Augustmoon.\n\nCorruption and nepotism are rampant across UICA's frontier administrations, management is generally more interested in lining their own pockets than in any sort of solar revanchist rhetoric."),
    likes = 0,
    respects = 0,
    known = true,
    size = 100,
    power = 100,
    wealth = 75000,
    currency = "money",
    monster_faction = "UICA_mil",
    food_calories = 62500000000,
    food_vitamins = { ["iron"] = 2000000000, ["calcium"] = 2000000000, ["vitC"] = 2000000000 },
    price_rules = {
        { item = "cash_card", fixed_adjustment = 0 },
        { item = "UICA_1d", fixed_adjustment = 0 },
        { item = "UICA_50d", fixed_adjustment = 0 },
        { item = "UICA_10d", fixed_adjustment = 0 },
        { item = "UICA_100d", fixed_adjustment = 0 },
        { item = "UICA_1000d", fixed_adjustment = 0 },
        { item = "UICA_10000d", fixed_adjustment = 0 },
    },
    relations = {
        ["your_followers"] = { "share public goods", "lets you in", "knows your voice" },
        ["no_faction"] = { "share public goods", "lets you in", "knows your voice" },
        ["wraitheon"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["mercurial"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["independents"] = { "watch your back", "share my stuff", "guard your stuff", "defends your space", "knows your voice" },
        ["tskbem_vostok"] = { "kill on sight" },
        ["Prepnet_Phyle"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "wraitheon",
    name = ccb.content.text("Wraitheon Industries ltd."),
    description = ccb.content.text("A massive, multi-system corporation with major investments across artificial intelligence, shipbuilding, military cybernetics and applied robotics.  Among the oldest of the Solar Corporations, it is a major player in the Orion Arm, and a key military supplier of UICA's military hardware.  It is best known for its normally secretive and highly advanced research and archaeology division."),
    likes = 0,
    respects = 0,
    known = true,
    size = 100,
    power = 100,
    wealth = 75000,
    currency = "",
    monster_faction = "WraitheonRobotics",
    relations = {
        ["UICA"] = { "knows your voice" },
        ["mercurial"] = { "knows your voice" },
        ["independents"] = { "knows your voice" },
        ["tskbem_vostok"] = { "kill on sight" },
        ["Prepnet_Phyle"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "mercurial",
    name = ccb.content.text("Mercurial Genomics ltd."),
    description = ccb.content.text("A massive, multi-system corporation specializing in genetic engineering, terraforming, and biotechnology.  Before the Discontinuity, it heavily invested in extrasolar colonization and the study of alien life.  Theoretically, it holds the planetary colonization charter for Salus IV, per UICA's constitutional treaty, but the corporation's interests currently lie elsewhere."),
    likes = 0,
    respects = 0,
    known = true,
    size = 100,
    power = 100,
    wealth = 62500000000000,
    currency = "",
    food_calories = 62500000000,
    food_vitamins = { ["iron"] = 2000000000, ["calcium"] = 2000000000, ["vitC"] = 2000000000 },
    relations = {
        ["UICA"] = { "knows your voice" },
        ["mercurial"] = { "knows your voice" },
        ["independents"] = { "knows your voice" },
        ["tskbem_vostok"] = { "kill on sight" },
        ["Prepnet_Phyle"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "tskbem_vostok",
    name = ccb.content.text("TsKBEM Vostok"),
    description = ccb.content.text("Most consider forge fleets relics of Earth's mythical past, from a time when interstellar travel was the stuff of hopeful dreams and grand ambition.  That TsKBEM Vostok still exists at all is a testament to the dedication of its crews and the strength of their mission, and to the fact that it is a mobile military-industrial complex: a self-sufficient war machine that builds, maintains, and fights with its own hardware.  Anyone with a real grudge against UICA is likely to find an ally in Vostok, although not a particularly reliable one."),
    likes = 0,
    respects = 0,
    known = false,
    size = 100,
    power = 100,
    wealth = 62500000000000,
    currency = "money",
    monster_faction = "tskbem_vostok",
    food_calories = 62500000000,
    food_vitamins = { ["iron"] = 2000000000, ["calcium"] = 2000000000, ["vitC"] = 2000000000 },
    relations = {
        ["Prepnet_Phyle"] = { "knows your voice" },
        ["UICA"] = { "kill on sight" },
        ["wraitheon"] = { "kill on sight" },
        ["mercurial"] = { "kill on sight" },
        ["independents"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "independents",
    name = ccb.content.text("Independents"),
    description = ccb.content.text("A loose group of salvors, mercenaries and frontiersmen working as free agents or in representation of interest groups too small or remote to have official presence in the system.  Equally likely to cooperate among themselves as they are to fight each other."),
    likes = 0,
    respects = 0,
    known = true,
    size = 100,
    power = 100,
    wealth = 62500000000000,
    currency = "money",
    food_calories = 62500000000,
    food_vitamins = { ["iron"] = 2000000000, ["calcium"] = 2000000000, ["vitC"] = 2000000000 },
    price_rules = {
        { item = "cash_card", fixed_adjustment = 0 },
        { item = "UICA_1d", fixed_adjustment = 0 },
        { item = "UICA_50d", fixed_adjustment = 0 },
        { item = "UICA_10d", fixed_adjustment = 0 },
        { item = "UICA_100d", fixed_adjustment = 0 },
        { item = "UICA_1000d", fixed_adjustment = 0 },
        { item = "UICA_10000d", fixed_adjustment = 0 },
    },
    relations = {
        ["your_followers"] = { "share public goods", "knows your voice" },
        ["UICA"] = { "knows your voice" },
        ["mercurial"] = { "knows your voice" },
        ["wraitheon"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "whately_family",
    name = ccb.content.text("Whately Clan"),
    description = ccb.content.text("The owners of Mercurial Genomics.  Its dangerous to know them personally, let alone cross them.  Their presence on Salus IV despite their stated disinterest in the planet via Mercurial Genomics is an anomaly."),
    likes = 0,
    respects = 0,
    known = false,
    size = 15,
    power = 20,
    wealth = 7500,
    monster_faction = "whately",
    relations = {
        ["UICA"] = { "knows your voice" },
    },
}
content.add(definition)
end
