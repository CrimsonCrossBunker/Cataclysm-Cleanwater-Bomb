local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ARSONIST_storage", kind = "distribution" }
    group:item("golf_bag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "makayla_belt", kind = "collection" }
    group:item("gadget_pouch")
    group:entry { item = "bandages", count = { 5, 5 } }
    group:item("pockknife")
    group:entry { item = "lighter", charges = { 100, 100 } }
    group:item("hatchet")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ARSONIST_worn", kind = "collection" }
    group:item("backpack_leather")
    group:entry {
        item = "legrig",
        contents = {
            { group = "makayla_ammo" },
        },
    }
    group:item("bunker_pants")
    group:group("clothing_watch")
    group:item("bunker_coat")
    group:item("socks")
    group:item("boots_combat")
    group:item("slingpack")
    group:item("bra")
    group:item("tank_top")
    group:item("panties")
    group:entry { item = "model_10_revolver", charges = { 6, 6 }, container = "holster", ammo = { item = "38_special" } }
    group:entry {
        item = "webbing_belt",
        contents = {
            { group = "makayla_belt" },
        },
    }
    group:item("gloves_fingerless_mod")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "makayla_ammo", kind = "collection" }
    group:entry { item = "38_speedloader6", charges = { 6, 6 }, ammo = { item = "38_special" } }
    group:entry { item = "38_speedloader6", charges = { 6, 6 }, ammo = { item = "38_special" } }
    group:entry { item = "38_speedloader6", charges = { 6, 6 }, ammo = { item = "38_special" } }
    group:item("38_special")
    content.add(group)
end
