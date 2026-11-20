local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "FISH",
    description = ccb.content.text("a fish"),
    bleeds = "fd_blood",
}
definition:flag("EVIL_EYE_IMMUNE_MONSTER")
definition:fear("HURT")
definition:fear("FRIEND_ATTACKED")
content.replace(definition)
end
do
local definition = content.Species {
    id = "NIGHT_CREATURE",
    description = ccb.content.text("One of the children of the night"),
}
content.add(definition)
end
do
if not content.is_mod_active("magiclysm") then
    local definition = content.Species {
        id = "SUMMONED_CREATURE",
        description = ccb.content.text("a creature summoned by magic"),
    }
    content.add(definition)
end
end
do
local definition = content.Species {
    id = "CHANGELING",
    description = ccb.content.text("a creature from under the hill"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "CHANGELING_NOBLE",
    description = ccb.content.text("one of the leaders of the people under the hill"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "MARCH_LORD",
    description = ccb.content.text("one of the warlords from under the hill"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "IERDE",
    description = ccb.content.text("an earth elemental spirit"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "UNDINE",
    description = ccb.content.text("a water elemental spirit"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "ARVORE",
    description = ccb.content.text("a plant elemental spirit"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "SALAMANDER",
    description = ccb.content.text("a fire elemental spirit"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "HOMULLUS",
    description = ccb.content.text("an elemental spirit of humanity"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "SYLPH",
    description = ccb.content.text("an air elemental spirit"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "NATURE_SPIRIT",
    description = ccb.content.text("A spirit of nature"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "SHABRIRI",
    description = ccb.content.text("A blinding spirit"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "THORNBEAST",
    description = ccb.content.text("A magickally-animated mass of thorns, born to kill vampires"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "RENFIELD",
    description = ccb.content.text("a variety of creatures that have partaken of the unholy blood of the vampyr"),
}
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "VAMPIRE",
    description = ccb.content.text("a variety of creatures that subsist off the blood of living humans"),
}
definition:flag("NO_NECRO")
definition:flag("VAMP_VIRUS")
definition:flag("DRACULIN_IMMUNE")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "VAMPIRE_ANATHEMA",
    description = ccb.content.text("a being who devoured vampires to become better at killing them."),
}
definition:flag("NO_NECRO")
definition:flag("VAMP_VIRUS")
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "NIGHTMARE",
    description = ccb.content.text("creatures made from dreams, technically not alive"),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "GRACKEN",
    description = ccb.content.text("Grackens from the nether"),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "SHAPESHIFTER",
    description = ccb.content.text("A creature that can take more than one form at will"),
}
content.add(definition)
end
