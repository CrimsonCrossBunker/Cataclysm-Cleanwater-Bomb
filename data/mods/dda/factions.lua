local ccb = require("ccb")
local content = ccb.content

-- Native faction templates

ccb.runtime.handler("free_merchants_hub_trade_route_active", function(_)
    local result = ccb.services.variables.get_global_number("free_merchants_hub_trade_route")
    if not result.ok then error(result.error.message) end
    return (result.value.value or 0) == 2
end)

do
local definition = content.Faction {
    id = "your_followers",
    name = ccb.content.text("Your Followers"),
    description = ccb.content.text("The survivors who have entrusted you with their well-being.  If morale drops, poor performance and mutiny may become issues."),
    likes = 60,
    respects = 60,
    known = true,
    size = 1,
    power = 100,
    wealth = 0,
    consumes_food = true,
    monster_faction = "player",
    relations = {
        ["your_followers"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
    },
    epilogues = {
        { id = "epilogue_faction_your_followers_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_your_followers_150", power_min = 150 },
        { id = "epilogue_faction_your_followers_FM", power_min = 150, dynamic = { { faction = "free_merchants", power_min = 150 }, { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 } } },
        { id = "epilogue_faction_your_followers_revolt", power_min = 150, dynamic = { { faction = "free_merchants", power_max = 150 }, { faction = "tacoma_commune", power_min = 150 } } },
        { id = "epilogue_faction_your_followers_OG", power_min = 150, dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "robofac", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "amf",
    name = ccb.content.text("AMF"),
    description = ccb.content.text("The survivors who formerly entrusted you with their well-being, but have now mutinied because of your abuse and incompetence.  They will kill you if they can."),
    likes = -60,
    respects = -60,
    known = false,
    size = 1,
    power = 100,
    wealth = 0,
    relations = {
        ["your_followers"] = { "kill on sight", "knows your voice" },
        ["amf"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "robofac",
    name = ccb.content.text("Hub 01"),
    description = ccb.content.text("The surviving staff of Hub 01, a pre-Cataclysm research lab.  They rarely leave their lab, if at all, and rely on their robots and advanced technology to survive."),
    likes = -200,
    respects = 0,
    known = false,
    size = 100,
    power = 100,
    wealth = 100000000,
    currency = "RobofacCoin",
    monster_faction = "robofac",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    price_rules = {
        { group = "NC_ROBOFAC_gear", markup = 2 },
    },
    relations = {
        ["robofac"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["robofac_auxiliaries"] = { "share my stuff" },
        ["marloss"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_robofac_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_robofac_150", power_min = 150, dynamic = { { faction = "exodii", power_max = 150 }, { faction = "the_great_library", power_max = 150 } } },
        { id = "epilogue_faction_robofac_150", power_min = 150, dynamic = { { faction = "exodii", power_min = 150 }, { faction = "the_great_library", power_max = 150 } } },
        { id = "epilogue_faction_robofac_150", power_min = 150, dynamic = { { faction = "exodii", power_max = 150 }, { faction = "the_great_library", power_min = 150 } } },
        { id = "epilogue_faction_robofac_thrive", power_min = 150, dynamic = { { faction = "exodii", power_min = 150 }, { faction = "the_great_library", power_min = 150 } } },
        { id = "epilogue_faction_robofac_thrive_OG", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "robofac", power_min = 150 }, { faction = "exodii", power_min = 150 }, { faction = "the_great_library", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "robofac_auxiliaries",
    name = ccb.content.text("Hub 01 Ancilla"),
    description = ccb.content.text("A loose association of skilled wastelanders, traders, mercenaries and scouts.  All working on behalf of Hub 01, for their own reasons."),
    likes = 15,
    respects = 15,
    known = false,
    size = 70,
    power = 100,
    wealth = 75000,
    currency = "RobofacCoin",
    relations = {
        ["robofac"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["marloss"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "robofac_auxiliaries_chop_shop",
    name = ccb.content.text("Strip Mall Mercenaries"),
    description = ccb.content.text("A team of mercenaries working for the Hub 01, and operating out of a local strip mall."),
    likes = 15,
    respects = 15,
    known = false,
    size = 70,
    power = 100,
    wealth = 75000,
    currency = "RobofacCoin",
    relations = {
        ["robofac"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["robofac_auxiliaries"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["marloss"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "balthazar_fac",
    name = ccb.content.text("Balthazar"),
    description = ccb.content.text("A mysterious figure who operates out of a bunker.  They're trying to restore some semblance of infrastructure."),
    likes = 0,
    respects = 0,
    known = false,
    size = 20,
    power = 10,
    wealth = 50000,
    currency = "",
    monster_faction = "balthazar",
    relations = {
        ["your_followers"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["free_merchants"] = { "kill on sight", "guard your stuff", "knows your voice" },
        ["old_guard"] = { "kill on sight", "guard your stuff", "knows your voice" },
        ["tacoma_commune"] = { "kill on sight", "guard your stuff", "knows your voice" },
        ["lobby_beggars"] = { "kill on sight", "guard your stuff", "knows your voice" },
        ["wasteland_scavengers"] = { "kill on sight", "guard your stuff", "knows your voice" },
        ["no_faction"] = { "lets you in", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_balthazar_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_balthazar_150", power_min = 150, power_max = 499 },
        { id = "epilogue_faction_balthazar_500", power_min = 500 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "old_guard",
    name = ccb.content.text("The Old Guard"),
    description = ccb.content.text("The remains of the federal government.  The extent of their strength is unknown but squads of patrolling soldiers have been seen under their banner."),
    likes = 15,
    respects = 15,
    known = false,
    size = 100,
    power = 100,
    wealth = 100000000,
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["old_guard"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["free_merchants"] = { "watch your back", "guard your stuff", "defends your space", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_old_guard_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_old_guard_150", power_min = 150, dynamic = { { faction = "tacoma_commune", power_max = 150 }, { faction = "robofac", power_min = 150 } } },
        { id = "epilogue_faction_old_guard_150", power_min = 150, dynamic = { { faction = "tacoma_commune", power_min = 150 }, { faction = "robofac", power_max = 150 } } },
        { id = "epilogue_faction_old_guard_150", power_min = 150, dynamic = { { faction = "tacoma_commune", power_max = 150 }, { faction = "robofac", power_max = 150 } } },
        { id = "epilogue_faction_old_guard_thrive", power_min = 150, dynamic = { { faction = "tacoma_commune", power_min = 150 }, { faction = "robofac", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "free_merchants",
    name = ccb.content.text("The Free Merchants"),
    description = ccb.content.text("A conglomeration of entrepreneurs and businessmen that stand together to hammer-out an existence through trade and industry."),
    likes = 30,
    respects = 30,
    known = false,
    size = 100,
    power = 100,
    wealth = 75000000,
    currency = "FMCNote",
    food_calories = 9000000,
    food_vitamins = { ["iron"] = 288000, ["calcium"] = 288000, ["vitC"] = 288000 },
    price_rules = {
        { item = "money_strap_FMCNote", fixed_adjustment = 0 },
        { item = "money_bundle_FMCNote", fixed_adjustment = 0 },
        { item = "RobofacCoin", fixed_adjustment = 0.15, condition_handler = "free_merchants_hub_trade_route_active" },
        { group = "NC_ROBOFAC_gear", markup = 2.5 },
        { group = "games_board_all", premium = 2.5 },
    },
    relations = {
        ["free_merchants"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["old_guard"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["tacoma_commune"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["lobby_beggars"] = { "watch your back", "share public goods", "guard your stuff", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["no_faction"] = { "share public goods", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_free_merchants_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_free_merchants_150", power_min = 150, dynamic = { { faction = "old_guard", power_max = 150 }, { faction = "tacoma_commune", power_min = 150 } } },
        { id = "epilogue_faction_free_merchants_150", power_min = 150, dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_max = 150 } } },
        { id = "epilogue_faction_free_merchants_150", power_min = 150, dynamic = { { faction = "old_guard", power_max = 150 }, { faction = "tacoma_commune", power_max = 150 } } },
        { id = "epilogue_faction_free_merchants_thrive", power_min = 150, dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "lobby_beggars",
    name = ccb.content.text("The Beggars in the Lobby"),
    description = ccb.content.text("A collection of mentally and physically disadvantaged survivors who beg for food in the Evac Center lobby."),
    likes = 0,
    respects = 0,
    known = false,
    size = 5,
    power = 0,
    wealth = 100,
    relations = {
        ["lobby_beggars"] = { "share my stuff", "guard your stuff", "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "tacoma_commune",
    name = ccb.content.text("The Tacoma Commune"),
    description = ccb.content.text("An outpost started by the Free Merchants to provide a source of food and raw materials."),
    likes = 30,
    respects = 30,
    known = false,
    size = 100,
    power = 100,
    wealth = 10000000,
    currency = "FMCNote",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    price_rules = {
        { item = "money_strap_FMCNote", fixed_adjustment = 0 },
        { item = "money_bundle_FMCNote", fixed_adjustment = 0 },
    },
    relations = {
        ["free_merchants"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
    },
    epilogues = {
        { id = "epilogue_faction_tacoma_commune_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_tacoma_commune_150", power_min = 150, dynamic = { { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_min = 150 } } },
        { id = "epilogue_faction_tacoma_commune_150_OG", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_min = 150 }, { faction = "robofac", power_min = 150 } } },
        { id = "epilogue_faction_tacoma_commune_revolt", dynamic = { { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_max = 150 } } },
        { id = "epilogue_faction_tacoma_commune_revolt_OG", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_max = 150 }, { faction = "robofac", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "isolated_artisans",
    name = ccb.content.text("Isolated Artisans"),
    description = ccb.content.text("A couple of talented artisans in the country."),
    likes = 10,
    respects = 0,
    known = false,
    size = 2,
    power = 5,
    wealth = 100000,
    currency = "FMCNote",
    food_calories = 1080000,
    food_vitamins = { ["iron"] = 34560, ["calcium"] = 34560, ["vitC"] = 34560 },
    price_rules = {
        { item = "money_strap_FMCNote", fixed_adjustment = 0 },
        { item = "money_bundle_FMCNote", fixed_adjustment = 0 },
    },
    relations = {
        ["free_merchants"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
    },
    epilogues = {
        { id = "epilogue_faction_isolated_road_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_isolated_road_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "marloss",
    name = ccb.content.text("Marloss Evangelists"),
    description = ccb.content.text("Diverse bands, congregations and organizations with the common goal of preaching human survival through symbiosis with fungaloids."),
    likes = 15,
    respects = 0,
    known = false,
    size = 100,
    power = 100,
    wealth = 25000,
    relations = {
        ["marloss"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "no_faction",
    name = ccb.content.text("No Faction"),
    description = ccb.content.text("A lone wolf, not aligned with any faction."),
    likes = 0,
    respects = 0,
    known = false,
    size = 1,
    power = 1,
    wealth = 1,
    lone_wolf = true,
    relations = {
        ["lobby_beggars"] = { "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "wasteland_scavengers",
    name = ccb.content.text("The Wasteland Scavengers"),
    description = ccb.content.text("Autonomous bands or individuals who make their living raiding the ruins of the old-world for gear and provisions."),
    likes = 0,
    respects = 0,
    known = false,
    size = 100,
    power = 100,
    wealth = 2500000,
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["lobby_beggars"] = { "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "share my stuff", "guard your stuff", "knows your voice" },
        ["no_faction"] = { "knows your voice" },
    },
    epilogues = {
        { id = "epilogue_faction_wasteland_scavengers_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_wasteland_scavengers_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "hells_raiders",
    name = ccb.content.text("Hell's Raiders"),
    description = ccb.content.text("The largest gang of hooligans and bandits that preys upon other survivors.  Even if you have no gear, there is always a need for slaves and fresh meat."),
    likes = -25,
    respects = -25,
    known = false,
    size = 100,
    power = 100,
    wealth = 45000000,
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["hells_raiders"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["slaves"] = { "watch your back", "guard your stuff", "lets you in", "defends your space" },
        ["free_merchants"] = { "kill on sight" },
        ["old_guard"] = { "kill on sight" },
        ["your_followers"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_hells_raiders_0", dynamic = { { faction = "old_guard", power_max = 150 }, { faction = "hells_raiders", power_max = 150 } } },
        { id = "epilogue_faction_hells_raiders_150", dynamic = { { faction = "old_guard", power_max = 150 }, { faction = "hells_raiders", power_min = 150 } } },
        { id = "epilogue_faction_hells_raiders_stalemate", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "hells_raiders", power_max = 150 } } },
        { id = "epilogue_faction_hells_raiders_stalemate", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "hells_raiders", power_min = 150 } } },
        { id = "epilogue_faction_hells_raiders_collapse", dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "robofac", power_min = 150 }, { faction = "exodii", power_min = 150 }, { faction = "the_great_library", power_min = 150 } } },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "slaves",
    name = ccb.content.text("Enslaved individuals"),
    description = ccb.content.text("Individuals who have been enslaved or held prisoner for a long period of time, for various reasons."),
    likes = 0,
    respects = 0,
    known = false,
    size = 1,
    power = 1,
    wealth = 1,
    relations = {
        ["slaves"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["hells_raiders"] = {  },
        ["free_merchants"] = {  },
        ["old_guard"] = {  },
        ["your_followers"] = {  },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "apis_hive",
    name = ccb.content.text("Mutants Bees"),
    description = ccb.content.text("Mutant bees who hate everyone."),
    likes = -25,
    respects = -25,
    known = false,
    size = 1,
    power = 10,
    wealth = 0,
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
    relations = {
        ["apis_hive"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["free_merchants"] = { "kill on sight" },
        ["old_guard"] = { "kill on sight" },
        ["your_followers"] = { "kill on sight" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "isherwood_family",
    name = ccb.content.text("Isherwood family"),
    description = ccb.content.text("A small family surviving on their generational land."),
    likes = 30,
    respects = 20,
    known = false,
    size = 7,
    power = 10,
    wealth = 75000,
    currency = "signed_chit",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["free_merchants"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["old_guard"] = { "kill on sight" },
        ["tacoma_commune"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space" },
        ["lobby_beggars"] = { "guard your stuff" },
        ["no_faction"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_isherwoods_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_isherwoods_OG_FM", power_min = 150, dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_min = 150 }, { faction = "robofac", power_min = 150 } } },
        { id = "epilogue_faction_isherwoods_OG", power_min = 150, dynamic = { { faction = "old_guard", power_min = 150 }, { faction = "tacoma_commune", power_min = 150 }, { faction = "free_merchants", power_max = 150 }, { faction = "robofac", power_min = 150 } } },
        { id = "epilogue_faction_isherwoods_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "gods_community",
    name = ccb.content.text("New England Church Community"),
    description = ccb.content.text("A small group of churchgoers that formed a community in the woods.  They welcome anyone in their faction, but hate the unnatural."),
    likes = 30,
    respects = 20,
    known = false,
    size = 25,
    power = 20,
    wealth = 82500,
    currency = "icon",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["gods_community"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["free_merchants"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["old_guard"] = {  },
        ["tacoma_commune"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space" },
        ["lobby_beggars"] = { "guard your stuff", "lets you in" },
        ["no_faction"] = { "lets you in", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["isherwood_family"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
        ["marloss"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_gods_community_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_gods_community_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "lapin",
    name = ccb.content.text("Rabbit Enthusiasts"),
    description = ccb.content.text("Mr. Lapin and any acolytes he may have gathered in the apocalypse."),
    likes = 30,
    respects = 20,
    known = false,
    size = 1,
    power = 1,
    wealth = 82500,
    limited_area = true,
    currency = "fur",
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
    relations = {
        ["free_merchants"] = { "lets you in", "knows your voice" },
        ["old_guard"] = {  },
        ["tacoma_commune"] = { "lets you in" },
        ["lobby_beggars"] = { "lets you in" },
        ["no_faction"] = { "lets you in", "knows your voice" },
        ["wasteland_scavengers"] = { "lets you in", "knows your voice" },
        ["isherwood_family"] = { "lets you in", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
        ["marloss"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_lapin_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_lapin_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "fisherman_family",
    name = ccb.content.text("Fisherman Family"),
    description = ccb.content.text("A small family trying to survive in this new world."),
    likes = 0,
    respects = 0,
    known = false,
    size = 3,
    power = 3,
    wealth = 20000,
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["your_followers"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "prisoners",
    name = ccb.content.text("Prisoners"),
    description = ccb.content.text("Former prisoners who got their freedom during the apocalypse."),
    likes = 0,
    respects = 0,
    known = true,
    size = 100,
    power = 100,
    wealth = 45000000,
    limited_area = true,
    food_calories = 210000,
    food_vitamins = { ["iron"] = 3360, ["calcium"] = 3360, ["vitC"] = 3360 },
    relations = {
        ["hells_raiders"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["free_merchants"] = { "kill on sight" },
        ["old_guard"] = { "kill on sight" },
        ["your_followers"] = {  },
    },
    epilogues = {
        { id = "epilogue_faction_prisoners_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_prisoners_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "exodii",
    name = ccb.content.text("The Exodii"),
    description = ccb.content.text("A tribe of scavengers and survivors that have been through this before, and sacrificed what they must to make it through."),
    likes = 30,
    respects = 30,
    known = false,
    size = 100,
    power = 100,
    wealth = 75000000,
    monster_faction = "exodii",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    price_rules = {
        { group = "games_board_all", premium = 2.5 },
        { group = "exodii_pay_extra_for_metals", premium = 4 },
        { group = "exodii_pay_extra_for_medicine", premium = 4 },
        { group = "exodii_pay_extra_for_ammo", premium = 4 },
        { group = "exodii_pay_extra_for_petrochemical", premium = 4 },
    },
    relations = {
        ["free_merchants"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["old_guard"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["tacoma_commune"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["lobby_beggars"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["no_faction"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["hells_raiders"] = { "watch your back", "guard your stuff", "knows your voice" },
    },
    epilogues = {
        { id = "epilogue_faction_exodii_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_exodii_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "the_great_library",
    name = ccb.content.text("The Great Library"),
    description = ccb.content.text("A group of academics and other survivors that stand together to preserve and spread knowledge of the world."),
    likes = 30,
    respects = 30,
    known = false,
    size = 100,
    power = 100,
    wealth = 25000000,
    currency = "FlatCoin",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    price_rules = {
        { item = "money_strap_FMCNote", fixed_adjustment = 0 },
        { item = "money_bundle_FMCNote", fixed_adjustment = 0 },
        { group = "games_board_all", premium = 2.5 },
        { group = "manuals", premium = 2 },
        { group = "textbooks", premium = 2 },
        { group = "literature", premium = 2 },
        { group = "exotic_books", premium = 10 },
    },
    relations = {
        ["free_merchants"] = { "watch your back", "lets you in", "knows your voice" },
        ["old_guard"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["tacoma_commune"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["lobby_beggars"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["no_faction"] = { "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
    epilogues = {
        { id = "epilogue_faction_the_great_library_0", power_min = 0, power_max = 149 },
        { id = "epilogue_faction_the_great_library_150", power_min = 150 },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "GM_militia_faction",
    name = ccb.content.text("Grey Moose Militia Community"),
    description = ccb.content.text("A small community of survivors who retreated to a remote lodge."),
    likes = 0,
    respects = 0,
    known = false,
    size = 3,
    power = 3,
    wealth = 20000,
    food_calories = 115,
    relations = {
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["your_followers"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
    },
}
content.add(definition)
end
