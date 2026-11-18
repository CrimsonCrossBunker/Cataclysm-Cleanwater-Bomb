local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_box_84x246mm_any_full", kind = "distribution" }
    group:group("ammo_box_84x246mm_he_full")
    group:group("ammo_box_84x246mm_hedp_full", 50)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_84x246mm_he_full",
        kind = "distribution",
        container = "ammunition_box_carlgustav",
        container_variant = "ammunition_box_carlgustav_he",
    }
    group:entry { group = "ammo_can_84x246mm_he_full", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_box_84x246mm_hedp_full",
        kind = "distribution",
        container = "ammunition_box_carlgustav",
        container_variant = "ammunition_box_carlgustav_hedp",
    }
    group:entry { group = "ammo_can_84x246mm_hedp_full", count = { 3, 3 } }
    content.add(group)
end

do
    -- 1 charge per pocket. the charge system in items must die
    local group = content.ItemGroup {
        id = "ammo_can_84x246mm_he_full",
        kind = "collection",
        container = "ammunition_can_carlgustav",
        container_variant = "ammunition_can_carlgustav_he",
    }
    group:entry { item = "84x246mm_he", count = { 1, 1 }, charges = { 1, 1 } }
    group:entry { item = "84x246mm_he", count = { 1, 1 }, charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_84x246mm_hedp_full",
        kind = "collection",
        container = "ammunition_can_carlgustav",
        container_variant = "ammunition_can_carlgustav_hedp",
    }
    group:entry { item = "84x246mm_hedp", count = { 1, 1 }, charges = { 1, 1 } }
    group:entry { item = "84x246mm_hedp", count = { 1, 1 }, charges = { 1, 1 } }
    content.add(group)
end
