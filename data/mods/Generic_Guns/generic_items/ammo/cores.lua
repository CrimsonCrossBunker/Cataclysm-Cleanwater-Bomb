local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rifle_steel_core",
        copy_from = "3006_steel_core",
        looks_like = "3006_steel_core",
        name = ccb.content.plural_text("steel rifle core", "steel rifle core"),
        description = ccb.content.text("A machined core for reloading armour piercing rifle ammo."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_alien_steel_core",
        copy_from = "123_steel_core",
        looks_like = "123_steel_core",
        name = ccb.content.plural_text("steel rifle core", "steel rifle core"),
        description = ccb.content.text("A machined core for reloading armour piercing alien rifle ammo."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_huge_steel_core",
        copy_from = "50_steel_core",
        looks_like = "50_steel_core",
        name = ccb.content.plural_text("huge steel rifle core", "huge steel rifle core"),
        description = ccb.content.text("A machined core for reloading armour piercing huge rifle ammo."),
    }
    content.add(item)
end
