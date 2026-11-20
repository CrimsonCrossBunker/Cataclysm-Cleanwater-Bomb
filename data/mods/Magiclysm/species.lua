local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "MAGICAL_BEAST",
    description = ccb.content.text("a magical beast"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "SUMMONED_CREATURE",
    description = ccb.content.text("a creature summoned by magic"),
}
content.add(definition)
end
do
local definition = content.Species {
    id = "DRAGON",
    description = ccb.content.text("a dragon"),
}
definition:anger("HURT")
definition:anger("PLAYER_CLOSE")
definition:anger("PLAYER_WEAK")
definition:anger("STALK")
content.add(definition)
end
do
local definition = content.Species {
    id = "DEMON_SPIDER",
    description = ccb.content.text("a huge spider"),
}
definition:anger("FRIEND_ATTACKED")
definition:anger("FRIEND_DIED")
definition:anger("HURT")
definition:anger("STALK")
definition:anger("PLAYER_WEAK")
definition:anger("PLAYER_CLOSE")
content.add(definition)
end
do
local definition = content.Species {
    id = "LIZARDFOLK",
    description = ccb.content.text("a lizard-like humanoid"),
}
definition:anger("FRIEND_ATTACKED")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "GOBLIN",
    description = ccb.content.text("a short and cruel humanoid"),
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
definition:anger("PLAYER_WEAK")
content.add(definition)
end
do
local definition = content.Species {
    id = "FORGE_LORD",
    description = ccb.content.text("an entrepreneurial being"),
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "GOBLIN_FORGE",
    description = ccb.content.text("a short and entrepreneurial humanoid"),
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "WARG",
    description = ccb.content.text("a gigantic lupine beast"),
    bleeds = "fd_blood",
}
definition:fear("HURT")
definition:fear("FIRE")
definition:fear("FRIEND_DIED")
content.add(definition)
end
do
local definition = content.Species {
    id = "ORC",
    description = ccb.content.text("a stocky, green-skinned humanoid"),
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
definition:anger("PLAYER_WEAK")
content.add(definition)
end
do
local definition = content.Species {
    id = "GOLEM",
    description = ccb.content.text("an automaton, animated by magical forces"),
}
definition:anger("HURT")
definition:anger("PLAYER_CLOSE")
content.add(definition)
end
do
local definition = content.Species {
    id = "IRON_GOLEM",
    description = ccb.content.text("an iron golem, hated by rust monsters"),
}
definition:anger("HURT")
definition:anger("PLAYER_CLOSE")
content.add(definition)
end
do
local definition = content.Species {
    id = "OGRE",
    description = ccb.content.text("a monstrous, powerful humanoid"),
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
definition:anger("PLAYER_WEAK")
content.add(definition)
end
do
local definition = content.Species {
    id = "RAVENFOLK",
    description = ccb.content.text("a corvid-like humanoid"),
}
definition:anger("FRIEND_ATTACKED")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "DWARF",
    description = ccb.content.text("a short and stocky humanoid"),
}
definition:anger("FRIEND_ATTACKED")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "ELF",
    description = ccb.content.text("a tall and slender humanoid"),
}
definition:anger("FRIEND_ATTACKED")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "FEY",
    description = ccb.content.text("a small, magical humanoid"),
}
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "AIR_SPIRIT",
    description = ccb.content.text("a magical being of wind and rain"),
    bleeds = "fd_cold_air1",
}
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
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
    id = "EARTH_SPIRIT",
    description = ccb.content.text("a magical being of rock and stone"),
}
definition:flag("NEVER_WANDER")
definition:flag("NO_FUNG_DMG")
definition:anger("FRIEND_ATTACKED")
content.add(definition)
end
do
local definition = content.Species {
    id = "WIND_SPIRIT",
    description = ccb.content.text("a magical being of wind and gale"),
}
definition:flag("NEVER_WANDER")
definition:flag("NO_FUNG_DMG")
definition:anger("FRIEND_ATTACKED")
content.add(definition)
end
