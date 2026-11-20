local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "HUMAN",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.replace(definition)
end
