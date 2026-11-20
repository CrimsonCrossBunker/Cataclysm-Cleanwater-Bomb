local ccb = require("ccb")
local content = ccb.content

-- Native composable overmap-vision profiles
do
local definition = content.OvermapVision {
    id = "hollow_village",
}
definition:appearance {
    name = "cluster of buildings",
    symbol = ";",
    color = "red",
    looks_like = "campsite",
}
definition:appearance {
    name = "village",
    symbol = "^",
    color = "red",
    looks_like = "campsite",
}
definition:appearance {
    name = "village",
    symbol = "^",
    color = "red",
    looks_like = "campsite",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "zombie_village",
}
definition:appearance {
    name = "cluster of buildings",
    symbol = ";",
    color = "red",
    looks_like = "campsite",
}
definition:appearance {
    name = "village",
    symbol = "^",
    color = "red",
    looks_like = "campsite",
}
definition:appearance {
    name = "village",
    symbol = "^",
    color = "red",
    looks_like = "campsite",
}
content.add(definition)
end
