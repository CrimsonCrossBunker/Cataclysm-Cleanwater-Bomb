local ccb = require("ccb")
local content = ccb.content

-- Native monster adjustments
do
local definition = content.MonsterAdjustment {
    species = "ZOMBIE",
    stat = "speed",
    stat_adjust = 0.95,
    flag = "REVIVES",
    flag_val = false,
}
content.add(definition)
end
do
local definition = content.MonsterAdjustment {
    species = "ZOMBIE",
    stat = "hp",
    stat_adjust = 5,
    flag = "DEADLY_VIRUS",
    flag_val = true,
}
content.add(definition)
end
do
local definition = content.MonsterAdjustment {
    species = "ZOMBIE",
    stat = "bleed_rate",
    stat_adjust = 0,
}
content.add(definition)
end
