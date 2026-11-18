local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ammo_can_60mm_any_full", kind = "distribution" }
    group:group("ammo_can_60mm_m720a1_full")
    group:group("ammo_can_60mm_m768_full", 80)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_60mm_m720a1_full",
        kind = "distribution",
        container = "ammunition_can_pa124",
        container_variant = "ammunition_can_pa124_60mm_m720a1_8",
    }
    group:entry { group = "ammo_tube_60mm_m720a1", count = { 8, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_60mm_m768_full",
        kind = "distribution",
        container = "ammunition_can_pa124",
        container_variant = "ammunition_can_pa124_60mm_m768_8",
    }
    group:entry { group = "ammo_tube_60mm_m768_full", count = { 8, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_tube_60mm_m720a1",
        kind = "distribution",
        container = "ammunition_tube_mortar",
        container_variant = "ammunition_tube_mortar_m720a1",
    }
    group:entry { item = "60mm_shell_m720a1", charges = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_tube_60mm_m768_full",
        kind = "distribution",
        container = "ammunition_tube_mortar",
        container_variant = "ammunition_tube_mortar_m768",
    }
    group:entry { item = "60mm_shell_m768", charges = { 1, 1 } }
    content.add(group)
end
