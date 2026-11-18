local ccb = require("ccb")
local text = ccb.content.text

local antiviral = ccb.content.Item {
    id = "antivirals",
    name = ccb.content.plural_text("antivirals", "antivirals"),
    description = text("An anti-viral medication that inhibits the development of certain viruses.  One dose lasts 16 hours.  Could this, by some miracle, work against whatever the zombies are carrying?"),
    mass_grams = 1,
    volume_ml = 1,
    price_cents = 45,
    price_postapoc_cents = 200,
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_prescription",
}
antiviral:comestible { type = "MED" }
for _, flag in ipairs({ "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "EDIBLE_FROZEN" }) do
    antiviral:flag(flag)
end
antiviral:on_use("take_antiviral", text("Reduces the effect of certain viral infections."))
ccb.content.add(antiviral)

ccb.content.add(ccb.content.Mission {
    id = "MISSION_INFECTED_START_FIND_ANTIVIRALS",
    name = text("Find Antivirals Before You Die!"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_GAME_START" },
    item = "antivirals",
})

ccb.content.add(ccb.content.MonsterAdjustment {
    species = "ZOMBIE",
    flag = "DEADLY_VIRUS",
    flag_val = true,
})
