local content = require("ccb").content

do
    local group = content.ItemGroup { id = "toxic_waste_mx", kind = "distribution" }
    group:entry { item = "water_sewage", charges = { 26, 126 }, container = "55gal_drum", probability = 40 }
    group:entry { item = "fetid_goop", count = { 26, 200 }, wrapper = "55gal_drum", probability = 30 }
    group:group("meat_mutant_tainted_55gal_drum_3_15", 1)
    group:group("veggy_tainted_55gal_drum_3_50", 2)
    group:group("toxic_waste_mx_chems", 35)
    group:item("55gal_drum", 50)
    group:item("slime_scrap", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toxic_waste_mx_chems", kind = "distribution" }
    group:entry { item = "chem_acetone", charges = { 1, 32 }, container = "55gal_drum", probability = 10 }
    group:entry { item = "chem_toluene", charges = { 1, 16 }, container = "55gal_drum", probability = 5 }
    group:entry { item = "chem_glycerol", charges = { 1, 32 }, container = "55gal_drum", probability = 5 }
    group:entry { item = "chem_ethanol", charges = { 20, 90000 }, container = "55gal_drum", probability = 20 }
    group:entry { item = "methed_alcohol", charges = { 1, 32 }, container = "55gal_drum", probability = 10 }
    group:entry { item = "chem_methanol", charges = { 1, 16 }, container = "55gal_drum", probability = 10 }
    group:entry { item = "diesel", charges = { 1, 52 }, container = "55gal_drum", probability = 15 }
    group:entry { item = "motor_oil", charges = { 1, 52 }, container = "55gal_drum", probability = 15 }
    group:entry { item = "chem_turpentine", charges = { 1, 100 }, container = "55gal_drum", probability = 15 }
    group:entry { item = "camphine", charges = { 1, 32 }, container = "55gal_drum", probability = 5 }
    group:entry { item = "gasoline", charges = { 1, 52 }, container = "55gal_drum", probability = 5 }
    group:entry { item = "bleach", charges = { 1, 52 }, container = "55gal_drum", probability = 10 }
    group:entry { item = "lye", charges = { 1, 52 }, container = "55gal_drum", probability = 10 }
    group:entry { item = "chem_sulphuric_acid", charges = { 1, 16 }, container = "55gal_drum", probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "toxic_waste_mx_radioactive", kind = "distribution" }
    group:entry { item = "cobalt_60", count = { 1, 12 }, wrapper = "55gal_drum", probability = 5 }
    group:entry { item = "plutonium", count = { 1, 3 }, wrapper = "55gal_drum", probability = 1 }
    group:entry { item = "plut_slurry", charges = { 1, 45 }, container = "55gal_drum", probability = 50 }
    group:entry { item = "plut_slurry_dense", charges = { 1, 45 }, container = "55gal_drum", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "meat_mutant_tainted_55gal_drum_3_15", kind = "collection", container = "55gal_drum" }
    group:entry { item = "meat_mutant_tainted", count = { 3, 15 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "veggy_tainted_55gal_drum_3_50", kind = "collection", container = "55gal_drum" }
    group:entry { item = "veggy_tainted", count = { 3, 50 } }
    content.add(group)
end
