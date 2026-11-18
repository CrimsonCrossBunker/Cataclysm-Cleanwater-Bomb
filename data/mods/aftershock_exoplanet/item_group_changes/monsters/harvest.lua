local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cyborg_harvest", kind = "distribution" }
    group:item("afs_neural_io_5", 40)
    content.extend_item_group(group)
end
