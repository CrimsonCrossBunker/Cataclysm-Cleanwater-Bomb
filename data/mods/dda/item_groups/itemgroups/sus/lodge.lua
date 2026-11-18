local content = require("ccb").content

do
    -- items found in a shotgun hunting space
    local group = content.ItemGroup { id = "hunting_lodge_weapons", kind = "distribution" }
    group:group("guns_shotgun_common", 30)
    group:group("SUS_hunting_rifle", 20)
    group:group("SUS_hunting_archery", 15)
    content.add(group)
end

do
    -- items found in a most dangerous game space
    local group = content.ItemGroup { id = "cannibal_weapons", kind = "distribution" }
    group:group("guns_shotgun_common", 30)
    group:group("SUS_hunting_rifle", 20)
    content.add(group)
end
