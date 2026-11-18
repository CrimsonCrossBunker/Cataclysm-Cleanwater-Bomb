local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for the contents of gunstore delivery crates
    local group = content.ItemGroup { id = "SUS_gunstore_crate", kind = "distribution" }
    group:group("guns_common_display", 80)
    group:group("mags_common", 80)
    group:group("gunmod_common", 15)
    group:group("conversion_kits", 15)
    group:group("book_gunmags", 60)
    group:group("SUS_gunstore_gear", 60)
    group:group("ammo_parts", 80)
    group:group("tools_gunsmith", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for damaged items that can spawn on the floor of looted gunstores
    local group = content.ItemGroup { id = "SUS_gunstore_looted_floor", kind = "distribution" }
    group:entry { group = "guns_common", damage = { 0, 4 }, probability = 15 }
    group:entry { group = "book_gunmags", damage = { 0, 4 }, probability = 25 }
    group:group("SUS_trash_floor", 75)
    group:group("ammo_parts", 5)
    group:entry { group = "SUS_gunstore_gear", damage = { 0, 4 }, probability = 30 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for damaged items that can spawn on storage furniture in looted gunstores
    local group = content.ItemGroup { id = "SUS_gunstore_looted_storage", kind = "distribution" }
    group:entry { group = "guns_common_display", damage = { 0, 2 }, probability = 5 }
    group:entry { group = "mags_common", damage = { 0, 2 }, probability = 10 }
    group:entry { group = "gunmod_common", damage = { 0, 2 }, probability = 5 }
    group:entry { group = "conversion_kits", damage = { 0, 2 }, probability = 5 }
    group:entry { group = "book_gunmags", damage = { 0, 2 }, probability = 10 }
    group:entry { group = "ammo_parts", damage = { 0, 2 }, probability = 10 }
    group:entry { group = "SUS_gunstore_gear", damage = { 0, 2 }, probability = 10 }
    group:entry { group = "tools_gunsmith", damage = { 0, 2 }, probability = 1 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for the contents of gunstore displaycases
    local group = content.ItemGroup { id = "SUS_gunstore_displaycase", kind = "distribution" }
    group:group("guns_pistol_common_display", 90)
    group:group("guns_rifle_common_display", 30)
    group:group("guns_shotgun_common_display", 3)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for gear that protects hearing.  Should have more items like proper ear muffs, but needs to be added.
    local group = content.ItemGroup { id = "SUS_gunstore_hearing", kind = "distribution" }
    group:entry {
        item = "blister_pack",
        contents = {
            { item = "powered_earmuffs" },
        },
        probability = 10,
    }
    group:entry {
        item = "blister_pack",
        contents = {
            { item = "powered_earplugs" },
        },
        probability = 1,
    }
    group:entry {
        item = "bag_plastic_small",
        contents = {
            { item = "ear_plugs" },
        },
        probability = 90,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for optics, such as red dots or scopes that are in their containers.
    local group = content.ItemGroup { id = "SUS_gunstore_optics_packaged", kind = "distribution" }
    group:entry {
        item = "box_small",
        contents = {
            { item = "holo_sight" },
        },
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "pistol_scope" },
        },
        probability = 8,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "red_dot_sight" },
        },
        probability = 800,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "rifle_scope" },
        },
        probability = 1000,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "rifle_scope_high_end_mount" },
        },
        probability = 15,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "acog_scope" },
        },
        probability = 12,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "holo_magnifier" },
        },
        probability = 10,
    }
    group:entry {
        item = "box_small",
        contents = {
            { item = "hybrid_sight_4x" },
        },
        probability = 3,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for optics, such as red dots or scopes that are for display.
    local group = content.ItemGroup { id = "SUS_gunstore_optics_display", kind = "distribution" }
    group:item("holo_sight")
    group:item("pistol_scope", 8)
    group:item("red_dot_sight", 800)
    group:item("rifle_scope", 1000)
    group:item("rifle_scope_high_end_mount", 15)
    group:item("acog_scope", 12)
    group:item("holo_magnifier", 10)
    group:item("hybrid_sight_4x", 3)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for gear such as holsters, intended to help carry a gun.
    local group = content.ItemGroup { id = "SUS_gunstore_carry_gear", kind = "distribution" }
    group:item("holster", 60)
    group:item("sholster", 25)
    group:item("bholster", 20)
    group:item("bbholster", 10)
    group:item("suspenders_holster", 8)
    group:item("tactical_holster", 25)
    group:item("shoulder_holster", 12)
    group:item("bootstrap", 15)
    group:item("nylon_holster", 120)
    content.add(group)
end
