local content = require("ccb").content

do
    local group = content.ItemGroup { id = "supplies_skyfarer_ballista", kind = "collection" }
    group:entry { item = "bolt_ballista_steel", count = { 5, 15 } }
    group:entry { item = "ammo_ballista_wood", count = { 3, 8 }, probability = 50 }
    group:entry { item = "ammo_ballista_iron", count = { 2, 5 }, probability = 50 }
    content.add(group)
end
