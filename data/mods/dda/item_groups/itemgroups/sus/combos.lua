local content = require("ccb").content

do
    local group = content.ItemGroup { id = "catalyic_cracking_items", kind = "collection" }
    group:item("catalytic_cracking_handbook")
    content.add(group)
end

do
    -- These are personal effects, such as might be found at their workplace or on their person. The rates for medication (including vision aids) are intended to mirror the distribution of these items in the general US population.
    -- diazepem ~5.6% in 2013 https://www.benzoinfo.com/prescribing-statistics/
    -- antiparasitics: only data for US military could be found via Google searching, but if rate is comparable to general population it's not even 1% https://academic.oup.com/ofid/article/9/3/ofac040/6528390 https://health.mil/News/Articles/2024/01/01/MSMR-Ivermectin
    -- ~4.1% of the population with at least one stimulant prescription per year https://www.cdc.gov/mmwr/volumes/72/wr/mm7213a1.htm
    -- ~8.7% of the population have asthma, presumably only some require an inhaler https://www.cdc.gov/nchs/fastats/asthma.htm
    local group = content.ItemGroup { id = "SUS_science_personal_effects", kind = "collection" }
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 8 }
    group:item("eyedrops", 20)
    group:item("steroid_eyedrops", 5)
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 4)
    group:group("wallets_science", 15)
    group:item("badge_doctor", 2)
    group:item("lanyard", 15)
    group:group("civilian_phones", 80)
    group:group("civilian_memory_cards", 30)
    group:item("mask_dust", 30)
    group:group("box_of_contact_lens_any", 16)
    group:group("clothing_glasses", 65)
    group:item("wrapped_rad_badge", 5)
    group:group("antiparasitic_bottle_plastic_pill_prescription_1_10", 1)
    group:group("diazepam_bottle_plastic_pill_prescription_1_10", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ultralight_battery_any_open", kind = "distribution" }
    group:entry {
        collection = {
            { group = "ultralight_battery_small_bag", count = { 0, 2 } },
            { group = "ultralight_battery_small_bag_part" },
        },
    }
    group:entry {
        collection = {
            { group = "ultralight_battery_large_bag", count = { 0, 1 } },
            { group = "ultralight_battery_large_bag_part" },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "light_battery_any_open", kind = "distribution" }
    group:entry {
        collection = {
            { group = "light_battery_small_bag", count = { 0, 2 } },
            { group = "light_battery_small_bag_part" },
        },
    }
    group:entry {
        collection = {
            { group = "light_battery_large_bag", count = { 0, 1 } },
            { group = "light_battery_large_bag_part" },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "medium_battery_any_open", kind = "distribution" }
    group:entry {
        collection = {
            { group = "medium_battery_small_bag", count = { 0, 2 } },
            { group = "medium_battery_small_bag_part" },
        },
    }
    group:entry {
        collection = {
            { group = "medium_battery_large_bag", count = { 0, 1 } },
            { group = "medium_battery_large_bag_part" },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_used_batteries", kind = "collection" }
    group:group("ultralight_battery_any_open", 70)
    group:group("light_battery_any_open")
    group:group("medium_battery_any_open", 35)
    content.add(group)
end
