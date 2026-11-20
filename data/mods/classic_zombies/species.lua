local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "ZOMBIE",
    description = ccb.content.text("a zombie"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
definition:fear("FIRE")
content.replace(definition)
end
