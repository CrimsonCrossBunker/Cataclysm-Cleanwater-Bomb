local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "fd_crawling_darkness",
    percent_spread = 50,
    half_life_turns = 300,
    looks_like = "fd_darkness",
}
definition:intensity {
    name = ccb.content.text("darkness"),
    move_cost = 2,
    local_light_override = 0.0,
    translucency = 100.0,
}
content.add(definition)
end
