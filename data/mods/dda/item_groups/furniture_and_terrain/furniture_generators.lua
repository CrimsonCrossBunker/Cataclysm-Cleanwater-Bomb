local content = require("ccb").content

do
    local group = content.ItemGroup { id = "some_diesel", kind = "distribution" }
    group:entry { item = "diesel", charges = { 1000, 10000 }, container = "null" }
    content.add(group)
end
