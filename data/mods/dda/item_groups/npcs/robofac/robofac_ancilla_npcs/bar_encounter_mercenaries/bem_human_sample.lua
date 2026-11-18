local content = require("ccb").content

do
    local group = content.ItemGroup { id = "BEM_human_sample_drop", kind = "collection" }
    group:entry { item = "human_sample", count = { 3, 3 }, container = "flask_glass" }
    content.add(group)
end
