local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_308_any_full", kind = "distribution" }
    group:group("ammo_can_308_full")
    group:group("ammo_can_308_ap_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_308_any_part", kind = "distribution" }
    group:group("ammo_can_308_part")
    group:group("ammo_can_308_ap_part")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup { id = "ammo_can_308_mg_any_full", kind = "distribution" }
    group:group("ammo_can_belt308_full")
    group:group("ammo_can_belt308_full_4ap_1tracer")
    group:group("ammo_can_belt308_ball_full")
    group:group("ammo_can_belt308_full_5ap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_308_mg_any_part", kind = "distribution" }
    group:group("ammo_can_belt308_part")
    group:group("ammo_can_belt308_part_4ap_1tracer")
    group:group("ammo_can_belt308_ball_part")
    group:group("ammo_can_belt308_part_5ap")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_308_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_308fmj_460",
    }
    group:entry { group = "ammo_box_308", count = { 23, 23 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_308_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_308fmj_460",
    }
    group:entry { group = "ammo_box_308", count = { 0, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_308",
        kind = "distribution",
        container = "308_ammo_box_20",
        container_variant = "ammo_box_army_20_308",
    }
    group:entry { item = "762_51", charges = { 20, 20 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt308_full",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308_4fmj1tracer_200",
    }
    group:entry { group = "ammo_can_belt308_pouch", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_part",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308_4fmj1tracer_200",
    }
    group:entry { group = "ammo_can_belt308_pouch", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt308",
    }
    group:group("belt308_4ball_1tracer")
    content.add(group)
end

do
    -- should actually be M80A1 instead of M80 but we don't have one
    local group = content.ItemGroup { id = "belt308_4ball_1tracer", kind = "collection", container = "belt308" }
    group:entry { item = "762_51_incendiary", count = { 1, 1 }, charges = { 20, 20 } }
    group:entry { item = "762_51", count = { 1, 1 }, charges = { 80, 80 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt308_full_4ap_1tracer",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308_1tracer4ap_200",
    }
    group:entry { group = "ammo_can_belt308_pouch_4ap_1tracer", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_part_4ap_1tracer",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308_1tracer4ap_200",
    }
    group:entry { group = "ammo_can_belt308_pouch_4ap_1tracer", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_pouch_4ap_1tracer",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt308",
    }
    group:group("belt308_4ap_1tracer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt308_4ap_1tracer", kind = "collection", container = "belt308" }
    group:entry { item = "762_51_incendiary", count = { 1, 1 }, charges = { 20, 20 } }
    group:entry { item = "762_51_m993", count = { 1, 1 }, charges = { 80, 80 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_308_ap_full",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308ap_240",
    }
    group:entry { group = "ammo_box_ap_308", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_308_ap_part",
        kind = "distribution",
        container = "ammunition_can_30",
        container_variant = "ammunition_can_30_308ap_240",
    }
    group:entry { group = "ammo_box_ap_308", count = { 0, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_ap_308",
        kind = "distribution",
        container = "308_ammo_box_20",
        container_variant = "ammo_box_army_20_308",
    }
    group:entry { item = "762_51_m993", charges = { 20, 20 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt308_ball_full",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_308_600",
    }
    group:entry { group = "ammo_can_belt308_ball_pouch", count = { 6, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_ball_part",
        kind = "distribution",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_308_600",
    }
    group:entry { group = "ammo_can_belt308_ball_pouch", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_ball_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt308",
    }
    group:group("belt308_ball")
    content.add(group)
end

do
    -- should actually be M80A1 instead of M80 but we don't have one
    local group = content.ItemGroup { id = "belt308_ball", kind = "collection", container = "belt308" }
    group:entry { item = "762_51", count = { 1, 1 }, charges = { 100, 100 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt308_full_5ap",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_308_1tracer4ap_600",
    }
    group:entry { group = "ammo_can_belt308_pouch_5ap", count = { 6, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_part_5ap",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_308_1tracer4ap_600",
    }
    group:entry { group = "ammo_can_belt308_pouch_5ap", count = { 0, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt308_pouch_5ap",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt308",
    }
    group:group("belt308_5ap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt308_5ap", kind = "collection", container = "belt308" }
    group:entry { item = "762_51_m993", count = { 1, 1 }, charges = { 100, 100 } }
    content.add(group)
end
