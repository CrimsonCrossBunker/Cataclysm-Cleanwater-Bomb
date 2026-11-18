local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_shot_any_full", kind = "distribution" }
    group:group("ammo_can_shot_full")
    group:group("ammo_can_beanbag_full")
    group:group("ammo_can_slug_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_shot_any_part", kind = "distribution" }
    group:group("ammo_can_shot_part")
    group:group("ammo_can_beanbag_part")
    group:group("ammo_can_slug_part")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_shot_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_shot_160",
    }
    group:entry { group = "ammo_box_shot", count = { 32, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_shot_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_shot_160",
    }
    group:entry { group = "ammo_box_shot", count = { 0, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_shot",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "ammo_box_army_5_shot",
    }
    group:entry { item = "shot_00", charges = { 5, 5 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_beanbag_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_beanbag_160",
    }
    group:entry { group = "ammo_box_beanbag", count = { 32, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_beanbag_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_beanbag_160",
    }
    group:entry { group = "ammo_box_beanbag", count = { 0, 32 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_beanbag",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "ammo_box_army_5_beanbag",
    }
    group:entry { item = "shot_beanbag", charges = { 5, 5 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_slug_full",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_shot_120",
    }
    group:entry { group = "ammo_box_slug", count = { 24, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_slug_part",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_shot_120",
    }
    group:entry { group = "ammo_box_slug", count = { 0, 24 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_slug",
        kind = "distribution",
        container = "12_ammo_box_5",
        container_variant = "ammo_box_army_5_slug",
    }
    group:entry { item = "shot_slug", charges = { 5, 5 } }
    content.add(group)
end
