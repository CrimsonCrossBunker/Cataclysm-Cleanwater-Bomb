local content = require("ccb").content

do
    -- add some foam to fill the thing?
    local group = content.ItemGroup {
        id = "ammo_can_belt40mm_full",
        kind = "distribution",
        container = "ammunition_can_pa120",
        container_variant = "ammunition_can_pa120_40x53_32",
    }
    group:entry { item = "belt40mm", count = { 1, 1 }, charges = { 32, 32 } }
    content.add(group)
end
