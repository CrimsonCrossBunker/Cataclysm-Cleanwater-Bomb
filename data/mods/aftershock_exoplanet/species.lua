local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "UPLIFT",
    description = ccb.content.text("an intelligent animal created by man before the Cataclysm"),
}
definition:fear("HURT")
definition:fear("FIRE")
definition:fear("FRIEND_DIED")
content.add(definition)
end
do
local definition = content.Species {
    id = "ALIEN_ARTHROPOD",
    description = ccb.content.text("an alien arthropod"),
    footsteps = ccb.content.text("chittering."),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "ALIEN_FLOATER",
    description = ccb.content.text("a floating alien"),
    bleeds = "fd_blood",
}
content.add(definition)
end
do
local definition = content.Species {
    id = "MOXIE",
    description = ccb.content.text("a humanoid monster"),
    footsteps = ccb.content.text("shuffling."),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "BIOMACHINE",
    description = ccb.content.text("an unusual creature"),
    footsteps = ccb.content.text("shuffling."),
}
definition:fear("HURT")
definition:fear("FIRE")
definition:fear("FRIEND_DIED")
content.add(definition)
end
