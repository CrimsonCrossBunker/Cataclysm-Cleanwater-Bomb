local ccb = require("ccb")
local content = ccb.content

-- Native score definitions
do
local definition = content.Score {
    id = "score_spells_learned",
    statistic = "num_spells_learned",
}
content.add(definition)
end
do
local definition = content.Score {
    id = "score_spells_forgotten",
    statistic = "num_spells_forgotten",
}
content.add(definition)
end
