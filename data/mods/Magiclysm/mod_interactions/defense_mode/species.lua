local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "GOBLIN_DM",
    description = ccb.content.text("a short and cruel humanoid"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
definition:anger("PLAYER_WEAK")
content.add(definition)
end
do
local definition = content.Species {
    id = "LIZARDFOLK_DM",
    description = ccb.content.text("a lizard-like humanoid"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:anger("FRIEND_ATTACKED")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "GOLEM_DM",
    description = ccb.content.text("an automaton, animated by magical forces"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:anger("HURT")
definition:anger("PLAYER_CLOSE")
content.add(definition)
end
do
local definition = content.Species {
    id = "ORC_DM",
    description = ccb.content.text("a stocky, green-skinned humanoid"),
}
definition:flag("ALL_SEEING")
definition:flag("NEMESIS")
definition:anger("HURT")
definition:anger("FRIEND_ATTACKED")
definition:anger("PLAYER_WEAK")
content.add(definition)
end
