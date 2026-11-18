local content = require("ccb").content

do
    local group = content.ItemGroup { id = "brogyeki_weapon_override", kind = "collection" }
    group:entry { item = "brogyeki", charges = { 2, 2 } }
    content.add(group)
end
