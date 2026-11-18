local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "ammo_can_300_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_300jhp_240",
    }
    group:entry { group = "ammo_box_300", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_300_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_300jhp_240",
    }
    group:entry { group = "ammo_box_300", count = { 1, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_300",
        kind = "distribution",
        container = "300_ammo_box_20",
        container_variant = "ammo_box_army_20_300wm",
    }
    group:entry { item = "300_winmag", charges = { 20, 20 } }
    content.add(group)
end
