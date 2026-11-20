local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "DINOSAUR",
    description = ccb.content.text("a dinosaur"),
    bleeds = "fd_blood",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:fear("FIRE")
content.replace(definition)
end
