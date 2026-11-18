local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier2", kind = "collection" }
    group:entry {
        item = "273x44thermobaric",
        count = { 1, 2 },
        sealed = true,
        container = "box_small_wood",
        probability = 10,
    }
    group:entry { item = "273x110slugmedium", count = { 2, 4 }, sealed = true, container = "box_small", probability = 30 }
    group:entry {
        collection = {
            { item = "ree_33", count = { 1, 3 } },
            { item = "ree_33_4_mag", count = { 2, 4 } },
            { item = "ree_33_53_mag", count = { 1, 3 }, probability = 20 },
            { item = "33naval_ball", charges = { 200, 200 }, sealed = true, container = "box_medium_wood" },
            {
                item = "33naval_ball",
                charges = { 200, 200 },
                sealed = true,
                container = "box_medium_wood",
                probability = 50,
            },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "khuunaofaai", count = { 1, 2 } },
            { item = "exodii_khuunaofaai_mag_firework", count = { 3, 4 } },
            { item = "exodii_khuunaofaai_mag_incendiary", count = { 1, 2 }, probability = 50 },
            { item = "exodii_khuunaofaai_mag_corrosive", count = { 1, 2 }, probability = 50 },
            { item = "exodii_khuunaofaai_mag_adhesive", count = { 1, 2 }, probability = 50 },
        },
        probability = 25,
    }
    content.add(group)
end

do
    -- To get items from this group in the Exodii CBM store requires finishing missions for their faction and earning their trust
    local group = content.ItemGroup { id = "EXODII_CBM_unlocks_weapons_heavy", kind = "distribution" }
    group:item("bio_chain_lightning", 15)
    group:item("bio_emp", 1)
    group:item("bio_emp_armgun", 1)
    group:item("bio_shockwave", 10)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_Magiclysm_no_spell_scrolls", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_dreamdross_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_fair_folk_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end

do
    -- This group does not spawn anywhere, it exists only to set Exodii merchant prices
    local group = content.ItemGroup { id = "Exodii_XE_no_spell_items", kind = "distribution" }
    group:item("bandages_makeshift", 1)
    content.add(group)
end
