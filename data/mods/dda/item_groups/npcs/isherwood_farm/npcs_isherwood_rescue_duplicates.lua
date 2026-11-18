local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_Isherwood_swat_worn", kind = "collection" }
    group:entry {
        distribution = {
            { item = "backpack_leather" },
            { item = "wicker_backpack" },
            { item = "slingpack" },
        },
    }
    group:item("armor_riot")
    group:entry {
        collection = {
            { item = "3006", container = "ammo_pouch" },
            { item = "3006", charges = { 24, 28 } },
        },
    }
    group:entry { item = "3006", charges = { 24, 28 } }
    group:entry {
        distribution = {
            { item = "boxer_briefs" },
            { item = "boxer_shorts" },
            { item = "briefs" },
        },
    }
    group:entry {
        distribution = {
            { item = "tshirt" },
            { item = "undershirt" },
        },
    }
    group:entry {
        distribution = {
            { item = "jeans" },
            { item = "pants_cargo" },
            { item = "pants_leather" },
        },
    }
    group:item("leather_belt", 50)
    group:item("gloves_fingerless", 50)
    group:item("helmet_riot")
    group:item("armor_riot_arm")
    group:item("armor_riot_leg")
    group:entry {
        distribution = {
            { item = "boots" },
            { item = "boots_western" },
        },
    }
    group:item("socks", 50)
    content.add(group)
end
