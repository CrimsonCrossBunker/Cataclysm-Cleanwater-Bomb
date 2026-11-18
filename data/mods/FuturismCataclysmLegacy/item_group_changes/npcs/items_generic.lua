local content = require("ccb").content

do
    local group = content.ItemGroup { id = "npc_misc", kind = "distribution" }
    group:item("fcl_atomic_light_off", 1)
    content.extend_item_group(group)
end
