local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "MYTHOS_DM",
    description = ccb.content.text("a mythos creature"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.add(definition)
end
