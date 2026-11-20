local ccb = require("ccb")
local content = ccb.content

-- Native overmap-terrain migrations
do
do
local definition = content.Migration {
    kind = "oter",
    from = "termites_fungus",
    to = "termites_food",
}
content.add(definition)
end
end

-- Native terrain and furniture migrations
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_fungus_termite",
    to = "t_dirt_underground",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_fungus_underground",
    to = "t_dirt_underground",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_fungus_underground_harvested",
    to = "t_dirt_underground",
}
content.add(definition)
end
end
