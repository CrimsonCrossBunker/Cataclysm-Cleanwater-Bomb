local ccb = require("ccb")
local content = ccb.content

-- Native overmap-terrain migrations
do
do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_ground_north",
    to = "ravine_straight_ground_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_ground_west",
    to = "ravine_straight_ground_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_ground_east",
    to = "ravine_straight_ground_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_ground_south",
    to = "ravine_straight_ground_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_north",
    to = "ravine_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_west",
    to = "ravine_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_east",
    to = "ravine_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_south",
    to = "ravine_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_bottom_north",
    to = "ravine_straight_bottom_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_bottom_west",
    to = "ravine_straight_bottom_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_bottom_east",
    to = "ravine_straight_bottom_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ravine_edge_bottom_south",
    to = "ravine_straight_bottom_south",
}
content.add(definition)
end
end
