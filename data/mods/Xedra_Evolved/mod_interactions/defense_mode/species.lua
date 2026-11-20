local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "DM_VAMPIRE",
    description = ccb.content.text("a variety of creatures that subsist off the blood of living humans"),
}
definition:flag("NO_NECRO")
definition:flag("VAMP_VIRUS")
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.add(definition)
end
do
local definition = content.Species {
    id = "DM_XEDRA_EVOLVED",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:flag("BASHES")
content.add(definition)
end
