local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_223_any_full", kind = "distribution" }
    group:group("ammo_can_ammo_pouch_223_full")
    group:group("ammo_can_box_223_20tracer_full", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_223_any_part", kind = "distribution" }
    group:group("ammo_can_ammo_pouch_223_part")
    group:group("ammo_can_box_223_20tracer_part", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_223_mg_any_full", kind = "distribution" }
    group:group("ammo_can_belt223_full")
    group:group("ammo_can_belt223_ball_full")
    group:group("ammo_can_belt223_4ap_tracer_1_full")
    group:group("ammo_can_belt223_5ap_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ammo_can_223_mg_any_part", kind = "distribution" }
    group:group("ammo_can_belt223_part")
    group:group("ammo_can_belt223_ball_part")
    group:group("ammo_can_belt223_4ap_tracer_1_part")
    group:group("ammo_can_belt223_5ap_part")
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_ammo_pouch_223_full",
        kind = "collection",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_556_m855a1_clipped_840",
    }
    group:entry { group = "ammo_pouch_223", count = { 7, 7 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_ammo_pouch_223_part",
        kind = "collection",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_556_m855a1_clipped_840",
    }
    group:entry { group = "ammo_pouch_223", count = { 1, 6 } }
    content.add(group)
end

do
    -- TODO: add 1 stripper clip guide (aka 'spoon') for 223 in this group, when the game will be able to check its use
    local group = content.ItemGroup { id = "ammo_pouch_223", kind = "collection", container = "cheap_ammo_pouch" }
    group:entry { group = "box_223_clips", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "box_223_clips",
        kind = "distribution",
        container = "ammo_box_army_3_clips",
        overflow = "discard",
    }
    group:entry { group = "clip223_10rd_556", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clip223_10rd_556", kind = "distribution", container = "clip223_10rd" }
    group:entry { item = "556_m855a1", count = { 1, 1 }, charges = { 10, 10 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt223_full",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223_1tracer4ball_800",
    }
    group:entry { group = "ammo_can_belt223_pouch", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_part",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223_1tracer4ball_800",
    }
    group:entry { group = "ammo_can_belt223_pouch", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt223",
        overflow = "discard",
    }
    group:group("belt223_4ball_1tracer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt223_4ball_1tracer", kind = "collection", container = "belt223" }
    group:entry { item = "556_incendiary", count = { 1, 1 }, charges = { 40, 40 } }
    group:entry { item = "556", count = { 1, 1 }, charges = { 160, 160 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt223_ball_full",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223fmj_800",
    }
    group:entry { group = "ammo_can_belt223_ball_pouch", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_ball_part",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223fmj_800",
    }
    group:entry { group = "ammo_can_belt223_ball_pouch", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_ball_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt223",
        overflow = "discard",
    }
    group:group("belt223_ball")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt223_ball", kind = "collection", container = "belt223" }
    group:entry { item = "556", count = { 1, 1 }, charges = { 200, 200 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_box_223_20tracer_full",
        kind = "collection",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_556tracer_820",
    }
    group:entry { group = "box_223_20_tracer", count = { 41, 41 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_box_223_20tracer_part",
        kind = "collection",
        container = "ammunition_can_50",
        container_variant = "ammunition_can_50_556tracer_820",
    }
    group:entry { group = "box_223_20_tracer", count = { 0, 41 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "box_223_20_tracer",
        kind = "distribution",
        container = "223_ammo_box_20",
        container_variant = "ammo_box_army_20_223",
        overflow = "discard",
    }
    group:entry { item = "556_incendiary", count = { 1, 1 }, charges = { 20, 20 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt223_4ap_tracer_1_full",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223_1tracer4ap_800",
    }
    group:entry { group = "ammo_can_belt223_4ap_tracer_1_pouch", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_4ap_tracer_1_part",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223_1tracer4ap_800",
    }
    group:entry { group = "ammo_can_belt223_4ap_tracer_1_pouch", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_4ap_tracer_1_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt223",
        overflow = "discard",
    }
    group:group("belt223_4ap_1tracer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt223_4ap_1tracer", kind = "collection", container = "belt223" }
    group:entry { item = "556_incendiary", count = { 1, 1 }, charges = { 40, 40 } }
    group:entry { item = "556_m995", count = { 1, 1 }, charges = { 160, 160 } }
    content.add(group)
end

do
    -- ---------------------------------------------------
    local group = content.ItemGroup {
        id = "ammo_can_belt223_5ap_full",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223ap_800",
    }
    group:entry { group = "ammo_can_belt223_5ap_pouch", count = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_5ap_part",
        kind = "distribution",
        container = "ammunition_can_fat_50",
        container_variant = "ammunition_can_fat_50_223ap_800",
    }
    group:entry { group = "ammo_can_belt223_5ap_pouch", count = { 0, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_belt223_5ap_pouch",
        kind = "distribution",
        container = "cheap_ammo_pouch_belt223",
        overflow = "discard",
    }
    group:group("belt223_5ap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "belt223_5ap", kind = "collection", container = "belt223" }
    group:entry { item = "556_m995", count = { 1, 1 }, charges = { 200, 200 } }
    content.add(group)
end
