local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "grenade_can_full",
        kind = "distribution",
        container = "ammunition_box_grenade",
        container_variant = "ammunition_box_grenade_m67",
    }
    group:item("grenade")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "grenade_can_empty", kind = "distribution" }
    group:item("ammunition_box_grenade")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "grenade_can_both", kind = "distribution" }
    group:group("grenade_can_full", 14)
    group:group("grenade_can_empty")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "grenade_can_pa120_grenades_part",
        kind = "distribution",
        container = "ammunition_can_pa120",
    }
    group:entry { group = "grenade_can_both", count = { 25, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "grenade_can_pa120_grenades_full",
        kind = "distribution",
        container = "ammunition_can_pa120",
    }
    group:entry { group = "grenade_can_full", count = { 25, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "c4_box_part", kind = "distribution", container = "box_compact_wood" }
    group:entry { item = "c4", count = { 1, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "c4_box_full", kind = "distribution", container = "box_compact_wood" }
    group:entry { item = "c4", count = { 4, 4 } }
    content.add(group)
end
