local content = require("ccb").content

do
    local group = content.ItemGroup { id = "methchef", kind = "distribution" }
    group:item("meth", 90)
    group:item("pan", 50)
    content.add(group)
end
