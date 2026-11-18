local content = require("ccb").content

do
    local group = content.ItemGroup { id = "farming_tools", kind = "distribution" }
    group:item("hoe", 60)
    group:item("shovel", 60)
    group:item("g_shovel", 60)
    group:item("trimmer_off", 60)
    group:item("bucket", 40)
    group:item("bucket_5gal", 40)
    group:item("gloves_rubber", 60)
    group:item("fertilizer_liquid", 20)
    group:group("fertilizer_commercial_bag_canvas_60", 30)
    group:item("fungicide", 20)
    group:entry { item = "chem_saltpetre", count = { 10, 50 }, probability = 15 }
    group:item("sickle", 40)
    group:group("tools_toolbox", 10)
    group:item("bullwhip", 30)
    group:item("distaff_spindle", 2)
    group:item("carding_paddles", 2)
    group:item("scythe", 40)
    group:item("scythe_fake", 1)
    group:item("shears", 20)
    group:item("elec_shears", 10)
    group:item("tree_spile", 40)
    group:group("quicklime_bag", 30)
    group:item("pitchfork", 40)
    group:item("v_plow_item", 41)
    group:item("v_planter_item", 41)
    group:item("v_reaper_item", 41)
    group:item("v_reaper_item_advanced", 8)
    group:item("v_planter_item_advanced", 8)
    group:item("rake", 40)
    group:item("rake_plastic", 50)
    group:item("shovel_snow", 40)
    group:item("shovel_snow_plastic", 50)
    group:item("hose_garden", 60)
    content.replace(group)
end

do
    -- Stuff you can find in the worktables of biology and chemistry labs.
    local group = content.ItemGroup { id = "afs_tools_biolab", kind = "distribution" }
    group:entry {
        collection = {
            { item = "microscope" },
            { item = "microscope_dissecting", probability = 30 },
            { item = "microscope_slide", count = { 5, 20 } },
            { item = "petri_dish", count = { 0, 3 } },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "microcentrifuge" },
            { item = "test_tube_micro", count = { 5, 20 } },
            { item = "rack_test_tube_micro", count = { 0, 1 } },
            { item = "petri_dish", count = { 0, 3 } },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "stand_ring" },
            { item = "funnel_separation", probability = 30 },
            { item = "gradcylinder", probability = 30 },
            { item = "still_lab", probability = 30 },
            { item = "test_tube", count = { 5, 20 } },
            { item = "flask_glass", count = { 0, 3 } },
            { item = "beaker", count = { 0, 3 } },
            { item = "stand_ring_clamps", count = { 0, 3 } },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "pouch_autoclave", count = { 5, 20 } },
            { item = "autoclave", probability = 20 },
        },
        probability = 20,
    }
    group:item("vac_oven_small", 30)
    group:entry { item = "filter_paper_quantitative", charges = { 10, -1 }, probability = 3 }
    group:item("afs_sample_container", 30)
    group:item("ph_meter", 30)
    group:item("analytical_set_basic", 30)
    group:item("vac_pump", 30)
    group:item("autoclave", 20)
    content.add(group)
end
