local content = require("ccb").content

do
    local group = content.ItemGroup { id = "fully_loaded_medium_battery_cell", kind = "distribution" }
    group:entry { item = "medium_battery_cell", charges = { 100, 100 } }
    content.add(group)
end
