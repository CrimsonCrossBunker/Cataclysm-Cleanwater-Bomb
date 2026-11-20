local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "SPIDER_DM",
    description = ccb.content.text("a spider"),
    bleeds = "fd_blood_insect",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "PLANT",
    description = ccb.content.text("a plant"),
    bleeds = "fd_blood_veggy",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:fear("HURT")
definition:fear("FIRE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "ZOMBIE",
    description = ccb.content.text("a zombie"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.replace(definition)
end
do
local definition = content.Species {
    id = "FERAL",
    description = ccb.content.text("a feral"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.replace(definition)
end
do
local definition = content.Species {
    id = "ROBOT",
    description = ccb.content.text("a robot"),
    footsteps = ccb.content.text("mechanical whirring."),
    bleeds = "fd_mechanical_fluid",
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.replace(definition)
end
do
local definition = content.Species {
    id = "MIGO",
    description = ccb.content.text("a creature from the mi-go homeworld"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:fear("HURT")
content.replace(definition)
end
do
local definition = content.Species {
    id = "NETHER",
    description = ccb.content.text("a nether creature"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
content.replace(definition)
end
