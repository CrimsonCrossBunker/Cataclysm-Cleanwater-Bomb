local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "large_damaged_shelter_kit",
        symbol = ";",
        color = "brown",
        name = ccb.content.plural_text("large damaged shelter", "large damaged shelters"),
        description = ccb.content.text("A huge shelter made of sticks and skins, very bulky but with plenty of space.  This is broken and cannot be deployed."),
        price_cents = 10000,
        price_postapoc_cents = 150,
        mass_milligrams = 15000000,
        volume_ml = 17000,
        melee_to_hit = -3,
    }
    item:material("wood", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "tent_pole",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("aluminum tent pole", "aluminum tent poles"),
        description = ccb.content.text("A light, collapsible tent pole made from aluminum, perfect for pitching a tent."),
        looks_like = "long_pole",
        mass_milligrams = 225000,
        volume_ml = 100,
        longest_side_mm = 900,
        melee_to_hit = 0,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
