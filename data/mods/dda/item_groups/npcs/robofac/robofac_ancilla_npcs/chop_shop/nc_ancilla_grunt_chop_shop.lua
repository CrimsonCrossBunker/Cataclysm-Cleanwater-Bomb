local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ANCILLA_GRUNT_CHOP_SHOP_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:entry {
        item = "legpouch_large",
        contents = {
            { group = "army_mags_m4" },
        },
    }
    group:group("NC_BOUNTY_HUNTER_pants")
    group:item("pants_army")
    group:group("NC_BOUNTY_HUNTER_coat")
    group:item("boots_combat")
    group:item("slingpack")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    group:entry { item = "survivor_machete_qt", container = "scabbard" }
    group:item("gloves_fingerless_mod")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_GRUNT_CHOP_SHOP_wield", kind = "collection" }
    group:group("longguns_cop_loaded")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_GRUNT_CHOP_SHOP_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "stanag30", charges = { 30, 30 }, ammo = { item = "556" } }
    group:entry { item = "glock17_22", count = { 1, 2 }, charges = { 22, 22 }, ammo = { item = "9mmP" } }
    group:entry { item = "9mmP", count = { 1, 2 } }
    group:entry { item = "556", count = { 2, 2 } }
    group:entry { group = "any_MRE", count = { 2, 2 } }
    content.add(group)
end
