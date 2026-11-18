local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_50_any_full", kind = "distribution" }
    group:group("ammo_can_50bmg_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_50_any_part", kind = "distribution" }
    group:group("ammo_can_50bmg_part")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup { id = "ammo_can_50_mg_any_full", kind = "distribution" }
    group:group("ammo_can_belt50_full")
    group:group("ammo_can_belt50_mk211_full", 4)
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt50_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_50bmg_4fmj1tracer_100",
    }
    group:entry { group = "belt50_4ball_1tracer", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt50_4ball_1tracer", kind = "collection", container = "belt50" }
    group:entry { item = "50_incendiary", count = { 1, 1 }, charges = { 20, 20 } }
    group:entry { item = "50bmg", count = { 1, 1 }, charges = { 80, 80 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_50bmg_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_50bmg_fmj_120",
    }
    group:entry { group = "ammo_box_50bmg", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_50bmg_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_50bmg_fmj_120",
    }
    group:entry { group = "ammo_box_50bmg", count = { 1, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_50bmg",
        kind = "distribution",
        container = "12_ammo_box_25",
        container_variant = "ammo_box_army_10_50bmg",
    }
    group:entry { item = "50bmg", count = { 1, 1 }, charges = { 10, 10 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt50_mk211_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_50bmg_1tracer4mk211_100",
    }
    group:entry { group = "belt50_4mk211_1tracer", count = { 1, 1 } }
    content.add(group)
end

do
    -- instead of 50_incendiary should be M20 API-T, but doesn't exist in the game yet
    local group = content.ItemGroup { id = "belt50_4mk211_1tracer", kind = "collection", container = "belt50" }
    group:entry { item = "50_incendiary", count = { 1, 1 }, charges = { 20, 20 } }
    group:entry { item = "50_mk211", count = { 1, 1 }, charges = { 80, 80 } }
    content.add(group)
end
