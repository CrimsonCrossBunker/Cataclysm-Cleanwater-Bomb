local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_9mm_any_full", kind = "distribution" }
    group:group("ammo_can_9mm_full", 40)
    group:group("ammo_can_9mmP_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_9mm_any_part", kind = "distribution" }
    group:group("ammo_can_9mm_part", 50)
    group:group("ammo_can_9mmP_part")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_9mmP_full",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_9mm_P_1000",
    }
    group:entry { group = "ammo_box_9mmP", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_9mmP_part",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_9mm_fmj_1000",
    }
    group:entry { group = "ammo_box_9mmP", count = { 0, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_9mmP",
        kind = "distribution",
        container = "9mm_ammo_box_50",
        container_variant = "ammo_box_army_50_9mm_P",
    }
    group:entry { item = "9mmP", charges = { 50, 50 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_9mm_full",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_9mm_jhp_1000",
    }
    group:entry { group = "ammo_box_9mm", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_9mm_part",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_9mm_jhp_1000",
    }
    group:entry { group = "ammo_box_9mm", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_9mm",
        kind = "distribution",
        container = "9mm_ammo_box_100",
        container_variant = "ammo_box_army_100_9mm_jhp",
    }
    group:entry { item = "9mm", charges = { 50, 50 } }
    content.add(group)
end
