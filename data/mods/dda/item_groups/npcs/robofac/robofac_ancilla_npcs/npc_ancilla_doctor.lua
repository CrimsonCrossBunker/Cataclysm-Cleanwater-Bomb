local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ANCILLA_DOCTOR_worn", kind = "collection" }
    group:item("jeans")
    group:item("boots_combat")
    group:item("boxer_briefs")
    group:item("tshirt")
    group:item("apron_leather")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_DOCTOR_stock", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 8, 10 } }
    group:entry { item = "disinfectant", count = { 2, 10 } }
    group:entry { item = "bandages", count = { 3, 10 } }
    group:entry { item = "saline", count = { 1, 2 } }
    group:entry { group = "drugs_emergency", count = { 4, 6 } }
    group:entry { group = "drugs_analgesic", count = { 2, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_DOCTOR_bionics", kind = "collection" }
    group:entry { item = "bio_robofac_xmleg", count = { 1, 2 } }
    group:entry { item = "bio_robofac_xmarm", count = { 1, 2 } }
    group:entry { item = "bio_robofac_xmback", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_DOCTOR_bionics_LENS", kind = "collection" }
    group:entry { item = "bio_robofac_xmlens", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_DOCTOR_EXPENSIVE_ITEMS", kind = "collection" }
    group:entry { item = "morphine", count = { 4, 4 } }
    group:group("antibiotics_bottle_plastic_pill_prescription_15")
    group:group("strong_antibiotic_bottle_plastic_pill_prescription_5")
    group:item("anesthetic")
    group:group("oxycodone_bottle_plastic_pill_prescription_10")
    group:group("codeine_bottle_plastic_pill_painkiller_10")
    content.add(group)
end
