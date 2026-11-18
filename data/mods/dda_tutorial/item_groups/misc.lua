local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fully_loaded_medium_battery", kind = "distribution" }
    group:entry { item = "medium_battery_cell", charges = { 56, 56 } }
    content.add(group)
end
