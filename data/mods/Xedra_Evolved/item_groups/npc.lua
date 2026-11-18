local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BOANN_WORN_GEAR", kind = "collection" }
    group:item("loincloth_gossamer")
    group:item("stockings_gossamer")
    group:item("gloves_light_gossamer")
    group:item("gown_gossamer_boann_unique")
    group:item("slippers_gossamer")
    group:item("sapphire_silver_tiara")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BOANN_WEAPON", kind = "collection" }
    group:item("boann_unique_weapon_sword")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "VAMPIRE_HUNTER_BLOODTHORNE_worn", kind = "collection" }
    group:item("holy_symbol_wood")
    group:entry {
        distribution = {
            { item = "jeans", probability = 25 },
            { item = "pants", probability = 25 },
            { item = "pants_leather", probability = 25 },
            { item = "pants_cargo", probability = 25 },
        },
    }
    group:item("longshirt")
    group:item("socks")
    group:item("boots")
    content.add(group)
end

do
    -- Some common medical supplies they can afford to trade for more useful things.
    local group = content.ItemGroup { id = "hunter_doctor_sold_items", kind = "collection" }
    group:entry { item = "bandages", count = { 5, 10 }, probability = 80 }
    group:entry { item = "adhesive_bandages", count = { 1, 20 }, probability = 70 }
    group:entry { item = "vitamins", count = { 10, 30 }, probability = 75 }
    group:entry { item = "calcium_tablet", count = { 15, 25 }, probability = 75 }
    group:entry { item = "aspirin", count = { 5, 10 }, probability = 60 }
    group:entry { item = "ibuprofen", count = { 5, 10 }, probability = 70 }
    group:entry { item = "acetaminophen", count = { 15, 30 }, probability = 70 }
    group:entry { item = "dayquil", count = { 5, 10 }, probability = 70 }
    group:entry { item = "nyquil", count = { 5, 10 }, probability = 70 }
    group:entry { item = "disinfectant", count = { 5, 20 }, probability = 35 }
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 20 }
    group:entry { item = "antibiotics", count = { 1, 20 }, probability = 35 }
    group:entry { item = "antifungal", count = { 1, 20 }, probability = 10 }
    group:entry { item = "antiparasitic", count = { 1, 20 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hunter_doctor_aspirin", kind = "collection" }
    group:entry { item = "extra_str_aspirin", count = { 5, 20 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hunter_doctor_rage_drink", kind = "collection" }
    group:entry { item = "blackout_rage_drink", count = { 3, 9 }, probability = 75 }
    content.add(group)
end

do
    -- They got their gear before the end happened, so it's proper gear and not random clothing.
    -- However, their focus at passing for mundane to hide in plain sight means that they lack kevlar vests and other hard-to-justify gear.
    -- These hunters know that some vampires are burnt by holy symbols, so they all have one
    -- Until they can decide to prefer wielding a crossbow to a bayonet when dealing with a distant enemy, they won't have bayonets.
    local group = content.ItemGroup { id = "VAMPIRE_HUNTER_DEFAULT_worn", kind = "collection" }
    group:entry {
        distribution = {
            { item = "vest", probability = 20 },
            { item = "vest_jean", probability = 20 },
            { item = "vest_leather", probability = 20 },
        },
    }
    group:item("holy_symbol_wood")
    group:entry {
        distribution = {
            { item = "jeans", probability = 25 },
            { item = "pants", probability = 25 },
            { item = "pants_leather", probability = 25 },
            { item = "pants_cargo", probability = 25 },
        },
    }
    group:item("longshirt")
    group:item("socks")
    group:item("boots")
    group:entry {
        item = "quiver",
        contents = {
            { group = "quiver_crossbow_vampire_hunter" },
        },
    }
    content.add(group)
end

do
    -- They all have the same crossbow type as the hunter professions for the same reason.
    local group = content.ItemGroup { id = "VAMPIRE_HUNTER_DEFAULT_CROSSBOW_wield", kind = "collection" }
    group:item("compcrossbow")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "VAMPIRE_HUNTER_LEADER_worn", kind = "collection" }
    group:item("socks")
    group:item("dress_shoes")
    group:item("knit_scarf")
    group:item("dentures")
    group:item("holy_symbol_wood")
    group:item("briefs")
    group:item("dress_shirt")
    group:item("pants")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "VAMPIRE_HUNTER_LEADER_wield", kind = "collection" }
    group:item("cane")
    content.add(group)
end

do
    -- Leather, bone and sinew, in other words anything worth selling but not edible from various animals.
    -- The guards take turns treating the hides to make leather as Elsa taught them, as having anything to sell can result in more food and supplies.
    local group = content.ItemGroup { id = "hunter_mundane_sold_items", kind = "collection" }
    group:entry { item = "bone", count = { 20, 50 } }
    group:entry { item = "sinew", count = { 400, 800 } }
    group:entry { item = "leather", count = { 3, 15 } }
    group:entry { item = "tanned_hide", count = { 1, 5 } }
    content.add(group)
end

do
    -- Until there's a way to make a NPC spawn with random equipment but with a single non-random piece of equipment, this group will be needed to make sure the sun-sensitive vampire has sunglasses.
    local group = content.ItemGroup { id = "xe_vampire_mission_target_worn", kind = "collection" }
    group:item("sunglasses")
    group:entry {
        distribution = {
            { item = "jeans", probability = 25 },
            { item = "pants", probability = 25 },
            { item = "pants_leather", probability = 25 },
            { item = "pants_cargo", probability = 25 },
        },
    }
    group:item("longshirt")
    group:item("socks")
    group:item("sneakers")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xe_vampire_mission_target_wield", kind = "distribution" }
    group:item("umbrella", 10)
    group:item("teleumbrella-extended", 10)
    content.add(group)
end
