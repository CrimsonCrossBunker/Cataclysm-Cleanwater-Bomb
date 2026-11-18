local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_deep_fryer", kind = "distribution" }
    group:entry { item = "cooking_oil", count = { 1000, 1000 } }
    content.add(group)
end
