local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "DM_SWEETS",
    footsteps = ccb.content.text("shlop."),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.add(definition)
end
