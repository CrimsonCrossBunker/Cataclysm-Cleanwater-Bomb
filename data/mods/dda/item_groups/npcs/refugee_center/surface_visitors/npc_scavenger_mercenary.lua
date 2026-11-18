local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_MERC_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:entry {
        item = "legpouch_large",
        contents = {
            { group = "army_mags_m4" },
        },
    }
    group:item("boxer_briefs")
    group:item("pants_army")
    group:item("duster")
    group:item("boots_combat")
    group:item("socks_wool")
    group:entry { item = "knife_combat", container = "bootsheath" }
    group:item("tank_top", 100, "tank_top_camo")
    group:item("gloves_fingerless_mod")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_MERC_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:entry { item = "stanag30", charges = { 30, 30 }, ammo = { item = "556" } }
    group:entry { group = "any_MRE", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_MERC_wield", kind = "collection" }
    group:entry {
        group = "modular_m4a1",
        charges = { 30, 30 },
        ammo = { item = "556" },
        contents = {
            { item = "shoulder_strap" },
            { item = "holo_sight" },
            { item = "suppressor" },
        },
    }
    content.add(group)
end
