local content = require("ccb").content

do
    local group = content.ItemGroup { id = "creek_bed", kind = "distribution" }
    group:item("rock", 5)
    group:item("field_stone", 20)
    group:item("stick", 10)
    group:item("stick_long", 2)
    group:item("log", 1)
    content.add(group)
end
