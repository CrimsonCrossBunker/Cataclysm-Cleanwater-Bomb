local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "DINOSAUR",
    description = ccb.content.text("a dinosaur"),
    bleeds = "fd_blood",
}
definition:fear("FIRE")
content.add(definition)
end
