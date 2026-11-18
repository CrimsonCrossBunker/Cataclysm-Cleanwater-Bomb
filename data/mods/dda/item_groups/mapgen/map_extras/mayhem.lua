local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wheel_spare", kind = "distribution" }
    group:entry { item = "wheel", damage = { 0, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wheel_busted", kind = "distribution" }
    group:entry { item = "wheel", damage = { 3, 4 } }
    content.add(group)
end
