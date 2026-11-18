local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_exodii_botrack", kind = "distribution" }
    group:item("exodii_sensor", 20)
    group:item("exodii_motor", 30)
    group:item("spring", 50)
    group:item("ch_steel_lump", 10)
    group:item("pipe", 10)
    group:item("frame", 20)
    group:item("hdframe", 20)
    group:item("exodii_computer", 25)
    group:item("exodii_chassis", 50)
    group:item("exodii_drone_chassis", 40)
    group:item("cyborg_matrix", 50)
    group:item("sheet_metal", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_exodii_storage_dryfood", kind = "distribution" }
    group:entry {
        collection = {
            { group = "flour_bag_paper", probability = 50 },
            { item = "cornmeal", count = { 2, -1 }, probability = 75 },
            { item = "oatmeal", count = { 2, -1 }, probability = 90 },
            { item = "barley", count = { 2, -1 }, container = "bag_canvas_small", probability = 90 },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { group = "salt_various" },
            { group = "pepper_various", probability = 95 },
            { group = "sugar_jar_glass_sealed_10_140", probability = 25 },
            { group = "saltpeter_canvas_bag_part", probability = 10 },
            { group = "yeast_various", probability = 30 },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "dry_meat", probability = 20 },
            { item = "dry_fish", probability = 30 },
            { item = "dry_veggy", probability = 80 },
            { item = "dry_corn", probability = 70 },
            { item = "dry_fruit", probability = 70 },
        },
        probability = 10,
    }
    group:entry {
        collection = {
            { item = "dry_beans", count = { 2, -1 }, probability = 80 },
            { item = "dry_lentils", count = { 2, -1 }, probability = 80 },
            { item = "dry_rice", count = { 2, -1 }, probability = 50 },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "chem_agar", count = { 2, -1 }, probability = 20 },
            { item = "lye", charges = { 2, -1 }, probability = 45 },
            { group = "lye_powder_bottle_part", probability = 20 },
            {
                item = "chem_sulphur",
                count = { 100, -1 },
                wrapper = "bottle_plastic_small",
                container = "null",
                probability = 30,
            },
            { item = "chem_peptone_broth", probability = 95 },
        },
        probability = 20,
    }
    content.add(group)
end
