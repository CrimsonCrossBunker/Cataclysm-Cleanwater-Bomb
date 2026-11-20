local ccb = require("ccb")
local content = ccb.content

-- Native terrain and furniture migrations
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_statue_fae_ozymandius",
    to = "t_railroad_rubble",
}
content.add(definition)
end
end
