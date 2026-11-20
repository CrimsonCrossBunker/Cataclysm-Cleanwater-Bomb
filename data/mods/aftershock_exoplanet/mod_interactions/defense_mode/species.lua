local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "AFTERSHOCK_DM",
    description = ccb.content.text("a monster"),
}
definition:flag("BASHES")
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.add(definition)
end
