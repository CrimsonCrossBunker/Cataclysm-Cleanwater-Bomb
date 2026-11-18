local content = require("ccb").content

do
    local group = content.ItemGroup { id = "animalshelter_softdrug", kind = "distribution" }
    group:entry { item = "bandages", count = { 1, 3 }, probability = 25 }
    group:group("adhesive_bandages_box_used", 25)
    group:item("saline", 20)
    group:group("vitamins_bottle_plastic_pill_supplement_20", 15)
    group:group("calcium_tablet_bottle_plastic_pill_supplement_20", 15)
    group:item("nyquil", 5)
    group:item("disinfectant", 15)
    group:item("elec_hairtrimmer", 15)
    group:item("survnote", 5)
    group:item("mask_dust", 65)
    group:item("glasses_safety", 5)
    group:item("goggles_chem", 5)
    group:item("towel", 50)
    group:item("scissors", 50)
    group:item("soap", 20)
    group:item("chem_hydrogen_peroxide", 10)
    group:item("stethoscope", 50)
    group:item("gloves_medical", 50)
    group:item("hacksaw", 5)
    group:item("gloves_rubber", 25)
    group:item("bag_plastic", 20)
    group:item("string_6", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animalshelter_utility", kind = "distribution" }
    group:item("dog_whistle", 10)
    group:item("pet_carrier", 30)
    group:entry { item = "dogfood", container = "can_medium", probability = 30 }
    group:entry { item = "catfood", container = "can_food", probability = 30 }
    group:group("dogfood_dry_bag_plastic_18", 10)
    group:group("catfood_dry_bag_plastic_18", 10)
    group:item("towel", 20)
    group:item("soap", 10)
    group:item("gloves_medical", 20)
    group:item("bite_suit", 70)
    group:item("cotton_patchwork", 15)
    group:item("bag_plastic", 20)
    group:item("jerky", 40)
    group:item("rope_6", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animalshelter_hardrug", kind = "distribution" }
    group:item("syringe", 10)
    group:group("antifungal_bottle_plastic_pill_prescription_5", 30)
    group:group("antiparasitic_bottle_plastic_pill_prescription_5", 30)
    group:group("antibiotics_bottle_plastic_pill_prescription_15", 20)
    group:item("saline", 15)
    group:group("medical_tape_roll_part", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animalshelter_toys", kind = "distribution" }
    group:item("baseball", 30)
    group:item("bone", 20)
    group:item("bowl_plastic", 10)
    group:item("rope_6", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "calcium_tablet_bottle_plastic_pill_supplement_20",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "calcium_tablet", count = { 20, 20 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dogfood_dry_bag_plastic_18", kind = "collection", container = "bag_plastic" }
    group:entry { item = "dogfood_dry", count = { 18, 18 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "catfood_dry_bag_plastic_18", kind = "collection", container = "bag_plastic" }
    group:entry { item = "catfood_dry", count = { 18, 18 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "antifungal_bottle_plastic_pill_prescription_5",
        kind = "collection",
        container = "bottle_plastic_pill_prescription",
    }
    group:entry { item = "antifungal", count = { 5, 5 }, container = "null" }
    content.add(group)
end
