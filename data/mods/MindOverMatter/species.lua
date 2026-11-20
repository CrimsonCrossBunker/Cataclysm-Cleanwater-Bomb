local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "PSI_NULL",
    description = ccb.content.text("a being immune to psionics"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "PLANT_INFLAMMABLE",
    description = ccb.content.text("a plant with no fear of fire"),
    bleeds = "fd_blood_veggy",
}
definition:flag("DRACULIN_IMMUNE")
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "NETHER_EMANATION",
    description = ccb.content.text("a reflection of another dimension"),
}
definition:flag("TEEP_IMMUNE")
definition:fear("HURT")
content.replace(definition)
end
do
local definition = content.Species {
    id = "LEECH_PLANT",
    description = ccb.content.text("a leech plant"),
}
definition:flag("TEEP_IMMUNE")
definition:fear("HURT")
definition:fear("FIRE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "WORM",
    description = ccb.content.text("a worm"),
    footsteps = ccb.content.text("rustle."),
    bleeds = "fd_blood_invertebrate",
}
definition:flag("TEEP_IMMUNE")
definition:fear("HURT")
content.replace(definition)
end
do
local definition = content.Species {
    id = "ZOMBIE",
    description = ccb.content.text("a zombie"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
definition:flag("TEEP_IMMUNE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "ROBOT",
    description = ccb.content.text("a robot"),
    footsteps = ccb.content.text("mechanical whirring."),
    bleeds = "fd_mechanical_fluid",
}
definition:flag("TEEP_IMMUNE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "ROBOT_FLYING",
    description = ccb.content.text("a flying robot"),
    footsteps = ccb.content.text("WHIRR"),
}
definition:flag("LOUDMOVES")
definition:flag("TEEP_IMMUNE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "FUNGUS",
    description = ccb.content.text("a fungus"),
}
definition:flag("HIVE_MIND")
definition:fear("HURT")
definition:fear("FIRE")
content.replace(definition)
end
do
local definition = content.Species {
    id = "MIGO",
    description = ccb.content.text("a creature from the mi-go homeworld"),
}
definition:flag("HIVE_MIND")
definition:fear("HURT")
content.replace(definition)
end
do
local definition = content.Species {
    id = "SLIME",
    description = ccb.content.text("a slime"),
    footsteps = ccb.content.text("plop."),
    bleeds = "fd_slime",
}
definition:flag("TEEP_IMMUNE")
content.replace(definition)
end
