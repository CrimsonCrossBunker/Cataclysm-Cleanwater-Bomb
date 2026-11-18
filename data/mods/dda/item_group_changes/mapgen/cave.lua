local content = require("ccb").content

do
    local group = content.ItemGroup { id = "archeology_tools", kind = "collection" }
    group:item("pickaxe", 75)
    group:item("paint_brush", 75)
    group:item("hammer", 75)
    group:item("chipper", 75)
    group:item("g_shovel", 75)
    group:item("stepladder", 50)
    group:group("hat_hard_flashlight", 75)
    content.add(group)
end
