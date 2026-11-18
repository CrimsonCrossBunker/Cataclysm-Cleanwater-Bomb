local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for Exodii storage pods and lockers that contain unprocessed and possibly unsorted scrap.  At some point these pieces should expand to more than just scrap, including various nice tools.
    local group = content.ItemGroup { id = "SUS_exodii_storage_lowvalue", kind = "distribution" }
    group:entry {
        collection = {
            { item = "chain", count = { 2, 15 }, probability = 30 },
            { item = "mc_steel_chunk", count = { 2, 10 }, probability = 40 },
            { item = "spring", count = { 2, 10 }, probability = 20 },
            { item = "mc_steel_lump", count = { 1, 5 }, probability = 40 },
            { item = "frame", count = { 1, 10 }, probability = 10 },
            { item = "frame", count = { 1, 5 }, probability = 10 },
            { item = "scrap", count = { 5, 40 }, probability = 40 },
            { item = "pipe", count = { 2, 8 }, probability = 20 },
            { item = "spike", count = { 3, 40 }, probability = 50 },
            { item = "hinge", count = { 1, 30 }, probability = 20 },
            { item = "lc_wire", count = { 5, 20 }, probability = 40 },
            { item = "mc_wire", count = { 5, 20 }, probability = 10 },
            { item = "hc_wire", count = { 5, 20 }, probability = 10 },
            { item = "qt_wire", count = { 5, 20 }, probability = 5 },
            { item = "rebar", count = { 2, 30 }, probability = 30 },
            { item = "sheet_metal", count = { 2, 30 }, probability = 20 },
            { item = "sheet_metal_small", count = { 5, 50 }, probability = 40 },
            { item = "nail", count = { 5, 70 }, charges = { 1, 100 }, probability = 50 },
            { item = "blade", count = { 5, 10 }, probability = 20 },
            { item = "hammer", count = { 1, 3 }, probability = 20 },
            { item = "tongs", count = { 1, 3 }, probability = 20 },
        },
        probability = 40,
    }
    group:entry {
        collection = {
            { item = "cu_pipe", count = { 0, 50 } },
            { item = "copper_knife", count = { 2, 20 }, probability = 30 },
            { item = "scrap_copper", count = { 50, 200 } },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "bubblewrap", count = { 0, 20 } },
            { item = "rigid_plastic_sheet", count = { 2, 20 } },
            { item = "plastic_sheet", count = { 5, 25 } },
            { item = "sheet_neoprene", count = { 1, 10 }, probability = 50 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for Exodii storage pods and lockers that contain sorted scrap that could use further processing but is definitely useful.
    local group = content.ItemGroup { id = "SUS_exodii_storage_medvalue", kind = "distribution" }
    group:group("SUS_exodii_storage_lowvalue", 30)
    group:entry {
        collection = {
            { item = "pamd68", count = { 2, 3 } },
            { item = "pamd71z", count = { 1, 2 } },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "exodiiminimag", count = { 2, 5 } },
            { item = "exodiiBRmag", count = { 2, 3 } },
            { item = "exodiiBRmag_26", count = { 3, 5 } },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "exodii_ingot_lead", probability = 40 },
            { item = "exodii_ingot_tin", probability = 30 },
            { item = "exodii_ingot_zinc", probability = 20 },
        },
        probability = 20,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for Exodii storage pods and lockers that processed ingots and the like, ready for use.
    local group = content.ItemGroup { id = "SUS_exodii_storage_highvalue", kind = "distribution" }
    group:entry {
        collection = {
            { item = "pamd68", count = { 2, 3 } },
            { item = "pamd71z", count = { 1, 2 } },
        },
        probability = 5,
    }
    group:entry {
        collection = {
            { item = "exodiiminimag", count = { 2, 3 } },
            { item = "exodiiBRmag", count = { 1, 2 } },
            { item = "exodiiBRmag_153", count = { 0, 1 } },
            { item = "exodiiBRmag_26", count = { 2, 4 } },
            { item = "123ln", count = { 0, 100 } },
            { item = "123ln_ap", count = { 0, 50 } },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { item = "exodii_ingot_aluminum", probability = 30 },
            { item = "exodii_ingot_plastic", probability = 10 },
            { item = "exodii_ingot_lc_steel", probability = 50 },
            { item = "exodii_ingot_copper", probability = 50 },
            { item = "exodii_ingot_lead", probability = 30 },
            { item = "exodii_ingot_tin", probability = 10 },
            { item = "exodii_ingot_zinc", probability = 10 },
        },
        probability = 60,
    }
    content.add(group)
end
