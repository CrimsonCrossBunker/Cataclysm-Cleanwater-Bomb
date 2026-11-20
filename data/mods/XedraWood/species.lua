local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "ELDRITCH_BEING",
    description = ccb.content.text("a creature bizarre and inexplicable."),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
do
local definition = content.Species {
    id = "LIZARDFOLK",
    description = ccb.content.text("a lizard-like humanoid"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "GIANT",
    description = ccb.content.text("a gigantic humanoid"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "FOREST_SPIRIT",
    description = ccb.content.text("a magical being of the forest"),
    bleeds = "fd_blood_veggy",
}
definition:flag("NEVER_WANDER")
definition:flag("PATH_AVOID_FIRE")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "UNDEAD",
    description = ccb.content.text("a creature animated by necromancy"),
}
definition:flag("DRACULIN_IMMUNE")
content.add(definition)
end
