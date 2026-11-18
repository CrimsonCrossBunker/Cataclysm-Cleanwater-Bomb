local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mushroom_collection", kind = "distribution" }
    group:entry { item = "mushroom", count = { 1, 1 } }
    group:entry { item = "mushroom_morel", count = { 1, 1 } }
    content.add(group)
end
