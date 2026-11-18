local content = require("ccb").content

do
    -- decorative finger rings worn by people.
    local group = content.ItemGroup { id = "accessory_ring", kind = "distribution" }
    group:entry { item = "copper_ring", count = { 1, 3 }, probability = 80 }
    group:entry { item = "silver_ring", count = { 1, 3 }, probability = 50 }
    group:entry { item = "gold_ring", count = { 1, 3 }, probability = 40 }
    group:item("diamond_ring", 10)
    group:item("platinum_ring", 10)
    content.add(group)
end

do
    -- decorative or functional teeth miscellany that may be present in people's mouths.
    local group = content.ItemGroup { id = "accessory_teeth", kind = "distribution" }
    group:entry { item = "gold_dental_grill", count = { 1, 2 }, probability = 50 }
    group:entry { item = "platinum_dental_grill", count = { 1, 2 }, probability = 30 }
    group:item("diamond_dental_grill", 10)
    content.add(group)
end

do
    -- unisex personal accessories
    local group = content.ItemGroup { id = "accesories_personal_unisex", kind = "collection" }
    group:group("accesories_personal_unisex_child")
    group:group("accessory_cat", 1)
    group:group("accessory_weaponcarry", 5)
    group:group("accessory_sportsgear", 5)
    group:item("american_flag", 1)
    group:item("national_flag", 1)
    group:item("state_flag", 1)
    group:item("tool_belt", 2)
    group:group("flask_liquor", 3)
    group:item("pin_badge", 6)
    content.add(group)
end
