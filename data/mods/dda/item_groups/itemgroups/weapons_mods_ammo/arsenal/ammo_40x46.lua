local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "ammo_can_40x46mm_m433_full",
        kind = "distribution",
        container = "ammunition_crate_40x46_72",
        container_variant = "ammunition_crate_40x46_72",
    }
    group:entry { item = "40x46mm_m433", count = { 1, 1 }, charges = { 72, 72 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "ammo_can_40x46mm_m433_part",
        kind = "distribution",
        container = "ammunition_crate_40x46_72",
        container_variant = "ammunition_crate_40x46_72",
    }
    group:entry { item = "40x46mm_m433", count = { 1, 1 }, charges = { 2, 36 } }
    content.add(group)
end
