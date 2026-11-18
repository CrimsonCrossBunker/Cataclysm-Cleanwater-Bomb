local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a storage furniture containing supplies for an office.
    local group = content.ItemGroup { id = "SUS_office_supplies", kind = "collection" }
    group:entry {
        group = "used_eink_tablet_pcs",
        count = { 1, 2 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 30,
    }
    group:entry {
        group = "used_laptops",
        count = { 1, 4 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:entry {
        group = "used_usb_drives",
        count = { 3, 8 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:entry {
        group = "used_memory_cards",
        count = { 2, 7 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:item("battery_charger", 80)
    group:entry { item = "rubber_band", count = { 8, 20 }, probability = 60 }
    group:entry { item = "file", count = { 8, 20 }, probability = 80 }
    group:entry { item = "paper", count = { 40, 90 }, probability = 80 }
    group:entry { group = "writing_utensils", count = { 40, 100 }, probability = 80 }
    group:entry { item = "book_binder", count = { 1, 5 }, probability = 90 }
    group:entry { item = "stapler", count = { 3, 10 }, probability = 60 }
    group:entry { item = "office_holepunch", count = { 2, 10 }, probability = 35 }
    group:entry { item = "scissors", count = { 4, 10 }, probability = 35 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for an office filing cabinet containing folders and documents.
    local group = content.ItemGroup { id = "SUS_office_filing_cabinet", kind = "collection" }
    group:entry { item = "file", count = { 1, 15 }, probability = 95 }
    group:entry { item = "paper", count = { 2, 30 }, probability = 80 }
    group:item("book_binder", 80)
    group:entry {
        group = "used_memory_cards",
        count = { 1, 2 },
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 30,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_efiles_office", kind = "collection" }
    group:entry { group = "textbooks", count = { 1, 2 }, probability = 40 }
    group:entry { item = "efile_lore", count = { 1, 1 }, probability = 30 }
    group:entry { item = "efile_map", count = { 1, 1 }, probability = 10 }
    group:entry { item = "efile_recipes", count = { 1, 1 }, probability = 80 }
    group:entry { item = "efile_junk", count = { 6, 12 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for an office desk containing documents and electronics for work and some desk clutter.
    local group = content.ItemGroup { id = "SUS_office_desk", kind = "collection" }
    group:entry {
        group = "used_eink_tablet_pcs",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 20,
    }
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 60,
    }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 50,
    }
    group:entry {
        group = "used_memory_cards",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 30,
    }
    group:item("battery_charger", 80)
    group:entry { item = "file", count = { 1, 8 }, probability = 50 }
    group:entry { item = "paper", count = { 2, 9 }, probability = 60 }
    group:entry { group = "pens", count = { 1, 10 }, charges = { 0, 100 }, probability = 95 }
    group:item("rubber_band", 20)
    group:item("book_binder", 90)
    group:item("stapler", 60)
    group:item("office_holepunch", 35)
    group:item("scissors", 35)
    group:item("phonebook", 10)
    group:item("family_photo", 10)
    group:item("coin_quarter", 10)
    group:entry { group = "oa_discarded_news", count = { 2, 12 }, probability = 20 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a messy assortment of items around an office desk.
    local group = content.ItemGroup { id = "SUS_office_mess", kind = "collection" }
    group:entry {
        group = "used_eink_tablet_pcs",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 2,
    }
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 6,
    }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 5,
    }
    group:entry {
        group = "used_memory_cards",
        contents = {
            { group = "SUS_efiles_office" },
        },
        probability = 3,
    }
    group:item("battery_charger", 8)
    group:entry { item = "file", count = { 1, 8 }, probability = 20 }
    group:entry { item = "paper", count = { 2, 9 }, probability = 20 }
    group:entry { group = "pens", count = { 1, 10 }, charges = { 0, 100 }, probability = 30 }
    group:item("stapler", 5)
    group:item("office_holepunch", 2)
    group:item("scissors", 5)
    group:item("phonebook", 1)
    group:item("family_photo", 10)
    group:group("oa_discarded_news", 20)
    group:entry { item = "inhaler", charges = { 10, 75 }, probability = 3 }
    group:item("mbag", 5)
    group:entry { item = "rubber_band", count = { 2, 10 }, probability = 20 }
    group:entry { item = "coin_quarter", count = { 1, 8 }, probability = 10 }
    group:group("duct_tape_roll_part", 5)
    group:group("glue_weak_domestic", 5)
    group:item("umbrella", 5)
    group:item("teleumbrella", 5)
    group:item("survnote", 1)
    group:entry { item = "cola", count = { 1, 3 }, probability = 6 }
    group:entry { item = "can_drink", count = { 1, 4 }, probability = 15 }
    group:group("cig_box_cigarette_1_20", 5)
    group:item("fan", 8)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a typical janitors closet with cleaning chemicals and tools.
    local group = content.ItemGroup { id = "SUS_janitors_closet", kind = "collection" }
    group:group("bleach_jug_part", 90)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 75)
    group:item("broom", 95)
    group:item("mop", 60)
    group:item("mop_folded", 35)
    group:item("sponge", 90)
    group:entry { item = "cotton_patchwork", count = { 1, 6 } }
    group:entry { item = "towel", count = { 1, 2 }, probability = 80 }
    group:item("brush", 95)
    group:item("bucket", 90)
    group:entry { item = "bucket_5gal", count = { 1, 2 }, probability = 90 }
    group:item("boots_rubber", 90)
    group:item("gloves_rubber", 90)
    group:item("apron_plastic", 40)
    group:entry { item = "chem_hydrogen_peroxide", charges = { 4, -1 }, probability = 40 }
    group:entry { item = "soap", count = { 1, 2 }, probability = 70 }
    group:group("detergent_small_box_part", 40)
    group:group("borax_box_part", 40)
    group:entry { item = "paper", count = { 1, 2 }, probability = 90 }
    content.add(group)
end
