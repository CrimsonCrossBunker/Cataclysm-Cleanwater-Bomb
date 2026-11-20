local ccb = require("ccb")
local content = ccb.content

-- Native terrain and furniture connection groups
do
local definition = content.ConnectGroup {
    id = "OBSIDIANFLOOR",
}
content.add(definition)
end
