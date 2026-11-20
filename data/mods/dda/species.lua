local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "MAMMAL",
    description = ccb.content.text("a mammal"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FIRE")
definition:fear("FRIEND_DIED")
content.add(definition)
end
do
local definition = content.Species {
    id = "AMPHIBIAN",
    description = ccb.content.text("an amphibian"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "BIRD",
    description = ccb.content.text("a bird"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("SOUND")
definition:fear("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "CYBORG",
    description = ccb.content.text("an alien cyborg"),
    footsteps = ccb.content.text("heavy thuds."),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "REPTILE",
    description = ccb.content.text("a reptile"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "FISH",
    description = ccb.content.text("a fish"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "KRAKEN",
    description = ccb.content.text("a squid-like mutant"),
    footsteps = ccb.content.text("slithering."),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "MUTANT",
    description = ccb.content.text("a mutant"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "NETHER",
    description = ccb.content.text("a nether creature"),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "NETHER_BURROWING",
    description = ccb.content.text("a nether creature"),
    footsteps = ccb.content.text("rustling"),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "NETHER_EMANATION",
    description = ccb.content.text("a reflection of another dimension"),
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "MIGO",
    description = ccb.content.text("a creature from the mi-go homeworld"),
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "TINDALOS",
    description = ccb.content.text("an abomination "),
    bleeds = "fd_tindalos_gas",
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "SLIME",
    description = ccb.content.text("a slime"),
    footsteps = ccb.content.text("plop."),
    bleeds = "fd_slime",
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "FUNGUS",
    description = ccb.content.text("a fungus"),
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "LEECH_PLANT",
    description = ccb.content.text("a leech plant"),
}
definition:flag("DRACULIN_IMMUNE")
definition:flag("VENOM_IMMUNE")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "INSECT",
    description = ccb.content.text("an insect"),
    bleeds = "fd_blood_insect",
}
definition:flag("DRACULIN_IMMUNE")
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "CENTIPEDE",
    description = ccb.content.text("a centipede"),
    footsteps = ccb.content.text("skittering."),
    bleeds = "fd_blood_insect",
}
definition:flag("DRACULIN_IMMUNE")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "INSECT_FLYING",
    description = ccb.content.text("a flying insect"),
    footsteps = ccb.content.text("BZZZZZZZZZZZZZZZZZ"),
    bleeds = "fd_blood_insect",
}
definition:flag("LOUDMOVES")
definition:flag("DRACULIN_IMMUNE")
definition:anger("FRIEND_DIED")
content.add(definition)
end
do
local definition = content.Species {
    id = "SPIDER",
    description = ccb.content.text("a spider"),
    bleeds = "fd_blood_insect",
}
definition:flag("DRACULIN_IMMUNE")
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
definition:flag("DRACULIN_IMMUNE")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "MOLLUSK",
    description = ccb.content.text("a mollusk"),
    bleeds = "fd_blood_invertebrate",
}
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "WORM",
    description = ccb.content.text("a worm"),
    footsteps = ccb.content.text("rustle."),
    bleeds = "fd_blood_invertebrate",
}
definition:flag("DRACULIN_IMMUNE")
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "ZOMBIE",
    description = ccb.content.text("a zombie"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
definition:flag("VENOM_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "GHOUL",
    description = ccb.content.text("a ghoul"),
    footsteps = ccb.content.text("scratching."),
    bleeds = "fd_blood",
}
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "FERAL",
    description = ccb.content.text("a feral"),
    footsteps = ccb.content.text("shuffling."),
    bleeds = "fd_blood",
}
content.add(definition)
end
do
local definition = content.Species {
    id = "ROBOT",
    description = ccb.content.text("a robot"),
    footsteps = ccb.content.text("mechanical whirring."),
    bleeds = "fd_mechanical_fluid",
}
definition:flag("VENOM_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "ROBOT_FLYING",
    description = ccb.content.text("a flying robot"),
    footsteps = ccb.content.text("WHIRR"),
}
definition:flag("LOUDMOVES")
definition:flag("VENOM_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "YRAX",
    description = ccb.content.text("an extradimensional construct"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "HORROR",
    description = ccb.content.text("a horror"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "ABERRATION",
    description = ccb.content.text("an aberration"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "HALLUCINATION",
    description = ccb.content.text("your imagination"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "HUMAN",
    description = ccb.content.text("a human"),
    bleeds = "fd_blood",
}
content.add(definition)
end
do
local definition = content.Species {
    id = "UNKNOWN",
    description = ccb.content.text("a bug"),
}
content.add(definition)
end
