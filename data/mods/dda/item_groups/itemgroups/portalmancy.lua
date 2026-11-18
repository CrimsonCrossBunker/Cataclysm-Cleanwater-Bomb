local content = require("ccb").content

do
    local group = content.ItemGroup { id = "portalmancy", kind = "distribution" }
    group:item("altered_exposed_wiring_prototype", 10)
    content.add(group)
end
