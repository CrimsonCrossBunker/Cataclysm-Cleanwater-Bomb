local content = require("ccb").content

do
    local group = content.ItemGroup { id = "helmet_bike_modified", kind = "collection", container = "helmet_bike" }
    group:item("plastic_chin_guard", 50)
    group:item("shield_visor", 10)
    content.add(group)
end

do
    -- Any items likely to be found in a boat or in any place which has boats.
    local group = content.ItemGroup { id = "boat_equipment", kind = "distribution" }
    group:group("allsporting", 50)
    group:item("methanol_fuel_cell", 1)
    group:item("5l_methanol_tank", 1)
    group:item("10l_methanol_tank", 1)
    group:item("28l_methanol_tank", 1)
    group:item("60l_methanol_tank", 1)
    content.add(group)
end

do
    -- camping stuff.
    local group = content.ItemGroup { id = "camping", kind = "collection" }
    group:group("camping_bag_large", 50)
    group:group("camping_bag_small", 30)
    group:group("camping_blades", 40)
    group:group("camping_manuals", 10)
    group:group("camping_firestarter", 60)
    group:group("camping_huntingweapon", 20)
    group:group("camping_lighting", 80)
    group:group("camping_cooking", 60)
    group:group("camping_tent", 60)
    group:group("camping_swimwear", 30)
    group:group("camping_fishing", 10)
    group:group("camping_watercontainer", 80)
    group:group("premium_contents", 40)
    group:entry {
        distribution = {
            { group = "full_survival_kit" },
            { group = "used_survival_kit" },
        },
        probability = 60,
    }
    group:group("pillbox_any_used", 5)
    group:item("sleeping_bag", 90)
    group:group("camping_foldedvehicle", 1)
    group:group("camping_powergen", 50)
    group:group("camping_tool", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_bag_large", kind = "distribution" }
    group:item("daypack", 30)
    group:item("backpack_giant", 1)
    group:item("backpack", 38)
    group:item("backpack_leather", 18)
    group:item("backpack_hiking", 20)
    group:item("backpack_hunting", 1)
    group:item("bigback", 15)
    group:item("duffelbag", 11)
    group:group("large_duffelbags", 12)
    group:item("travelpack", 9)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_bag_small", kind = "distribution" }
    group:item("armrig", 3)
    group:item("leg_small_bag", 3)
    group:item("leg_bag", 3)
    group:item("runner_bag", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_blades", kind = "collection" }
    group:entry {
        distribution = {
            { item = "hatchet", probability = 10 },
            { item = "kukri", probability = 4 },
            { item = "knife_hunting", probability = 18 },
            { group = "knife_rambo_cont", probability = 20 },
            { item = "machete", probability = 5 },
            { item = "machete_gimmick", probability = 5 },
            { item = "ax", probability = 5 },
            { item = "utility_knife_folding", probability = 20 },
            { item = "camping_multitool", probability = 20 },
            { item = "knife_trench", probability = 7 },
        },
    }
    group:item("sheath", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_manuals", kind = "collection" }
    group:item("mag_survival", 40)
    group:item("textbook_survival", 20)
    group:item("modern_tanner", 8)
    group:item("recipe_bows", 8)
    group:item("recipe_arrows", 8)
    group:item("mag_rifle", 30)
    group:item("mag_shotgun", 20)
    group:item("mag_traps", 20)
    group:item("manual_cutting", 12)
    group:item("manual_knives", 8)
    group:item("manual_swords", 8)
    group:item("manual_gun", 8)
    group:item("manual_shotgun", 6)
    group:item("manual_pistol", 4)
    group:item("manual_smg", 2)
    group:item("manual_survival", 20)
    group:item("manual_first_aid", 40)
    group:item("manual_traps", 12)
    group:item("trappers_companion", 2)
    group:item("textbook_traps", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_firestarter", kind = "distribution" }
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "small_lighter", charges = { 0, 50 }, probability = 30 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 10 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "ref_matches", charges = { 1, 32 }, probability = 50 }
    group:group("butane_lighter_and_fuel", 10)
    group:entry { item = "tinderbox", charges = { 0, 100 }, probability = 5 }
    group:item("flint_steel", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_huntingweapon", kind = "distribution" }
    group:group("camping_archery", 20)
    group:group("camping_crossbow", 20)
    group:group("camping_airgun", 20)
    group:item("light_snare_kit", 5)
    group:item("beartrap", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_archery", kind = "collection" }
    group:entry {
        distribution = {
            { item = "longbow", probability = 5 },
            { item = "compbow", probability = 1 },
            { item = "shortbow", probability = 5 },
            { item = "recurbow", probability = 2 },
            { item = "takedown_recurbow", probability = 1 },
            { item = "quiver_takedown_bow", probability = 1 },
            { item = "reflexbow", probability = 2 },
        },
    }
    group:entry {
        distribution = {
            { item = "quiver", probability = 3 },
            { item = "nylon_quiver", probability = 3 },
            { item = "quiver_large", probability = 1 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "makeshift_archery_ammo", probability = 7 },
            { group = "archery_ammo", probability = 5 },
            { group = "archery_loaded_quivers", probability = 2 },
        },
        probability = 50,
    }
    group:item("bow_sight", 10)
    group:item("bow_stabilizer", 10)
    group:item("arrowrest", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_crossbow", kind = "collection" }
    group:entry {
        distribution = {
            { item = "crossbow", probability = 5 },
            { item = "compcrossbow", probability = 15 },
            { item = "hand_crossbow", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { item = "quiver", probability = 3 },
            { item = "nylon_quiver", probability = 3 },
            { item = "quiver_large", probability = 1 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "crossbow_bolts", probability = 5 },
            { group = "crossbow_bolts_makeshift", probability = 7 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_airgun", kind = "distribution" }
    group:entry {
        collection = {
            { item = "bb", charges = { 1, 500 }, probability = 50 },
            { item = "bbgun", charges = { 0, 150 } },
        },
        probability = 50,
    }
    group:entry {
        collection = {
            { item = "varmint_airgun" },
            { group = "ammo_varmint_airgun", probability = 50 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_lighting", kind = "distribution" }
    group:group("camping_lighting_oil", 20)
    group:group("camping_lighting_electric", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_tent", kind = "collection" }
    group:entry {
        distribution = {
            { item = "tent_kit", probability = 17 },
            { item = "large_tent_kit", probability = 17 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "hammock", probability = 5 },
            { item = "hammock_net", probability = 2 },
        },
        probability = 30,
    }
    group:item("tent_pole", 17)
    group:item("tarp", 10)
    group:item("rollmat", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_swimwear", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "swim_briefs", probability = 10 },
            { item = "speedo", probability = 10 },
        },
        probability = 20,
    }
    group:group("bikini", 5)
    group:item("rashguard", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_fishing", kind = "collection" }
    group:group("tools_fishingrods_portable", 20)
    group:item("fishing_waders", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_watercontainer", kind = "distribution" }
    group:item("canteen_wood", 5)
    group:item("bottle_folding", 10)
    group:item("bottle_metal", 5)
    group:item("canteen", 15)
    group:item("2lcanteen", 10)
    group:item("camelbak", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_foldedvehicle", kind = "distribution" }
    group:entry {
        collection = {
            { item = "folded_inflatable_boat" },
            { item = "hand_pump" },
        },
        probability = 1,
    }
    group:item("folded_bicycle", 1)
    group:item("folded_skateboard_generic", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_powergen", kind = "collection" }
    group:item("folding_solar_panel", 5)
    group:item("power_station_portable", 85)
    content.add(group)
end

do
    -- Simpler games that would be found in communal areas, such as evac shelters.
    local group = content.ItemGroup { id = "games_basic", kind = "distribution" }
    group:entry { group = "decks_of_cards", count = { 1, 4 } }
    group:item("chess", 50)
    group:item("small_chess", 50)
    group:item("checkers", 50)
    group:item("small_checkers", 50)
    group:item("battleship", 30)
    group:item("monopoly", 10)
    group:item("clue", 10)
    group:item("snakesnladders", 10)
    group:item("domino", 7)
    group:item("jackstraws", 5)
    group:item("poppirate", 3)
    group:item("go", 1)
    group:item("shogi", 1)
    content.add(group)
end

do
    -- oriental games, for dojo location.
    local group = content.ItemGroup { id = "games_dojo", kind = "distribution" }
    group:item("go", 50)
    group:item("shogi", 50)
    group:item("mahjong", 50)
    group:item("chaturanga", 25)
    content.add(group)
end

do
    -- All board games grouped together.  Currently used to inflate their prices for specific factions.
    local group = content.ItemGroup { id = "games_board_all", kind = "collection" }
    group:item("chess")
    group:item("small_chess")
    group:item("checkers")
    group:item("small_checkers")
    group:group("decks_of_cards")
    group:item("pictionary")
    group:item("monopoly")
    group:item("dnd")
    group:item("g_warhammer")
    group:item("g_warhammer40k")
    group:item("ouija")
    group:item("catan")
    group:item("senet")
    group:item("mahjong")
    group:item("chaturanga")
    group:item("backgammon")
    group:item("latrunculi")
    group:item("go")
    group:item("shogi")
    group:item("hnefatafl")
    group:item("alquerque")
    group:item("domino")
    group:item("jackstraws")
    group:item("snakesnladders")
    group:item("ludo")
    group:item("poppirate")
    group:item("ambush")
    group:item("ranger")
    group:item("openfire")
    group:item("battleship")
    group:item("clue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_lighting_oil", kind = "distribution" }
    group:entry {
        collection = {
            { item = "oil_lamp", charges = { 0, -1 } },
            { item = "lamp_oil", charges = { 0, -1 }, probability = 50 },
        },
        probability = 5,
    }
    group:entry { item = "gasoline_lantern", charges = { 0, -1 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "camping_tool", kind = "collection" }
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:item("e_tool", 10)
    group:item("hammer", 35)
    group:item("pocketwatch", 5)
    group:item("emer_blanket", 20)
    group:item("tourist_table", 30)
    group:item("coat_rain", 10)
    group:item("hood_rain", 5)
    group:entry { item = "heatpack", count = { 1, 5 }, probability = 60 }
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:item("trailmap", 50)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "chem_hexamine", count = { 5, 10 }, probability = 60 }
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 40 }
    group:item("rope_30", 35)
    group:item("storage_line", 20)
    group:item("binoculars", 20)
    group:group("charcoal_bag_part", 20)
    group:entry {
        distribution = {
            { item = "sewing_kit", charges = { 0, -1 }, probability = 47 },
            { item = "tailors_kit", charges = { 0, -1 }, probability = 3 },
        },
        probability = 30,
    }
    group:entry { item = "thread", count = { 2, 10 }, probability = 40 }
    group:group("pur_tablets_bottle_plastic_small_1_50", 10)
    group:entry {
        distribution = {
            { item = "umbrella", probability = 47 },
            { item = "teleumbrella", probability = 3 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { item = "whistle", probability = 10 },
            { item = "airhorn", probability = 10 },
            { item = "whistle_multitool", probability = 5 },
        },
        probability = 20,
    }
    group:entry {
        collection = {
            { item = "flaregun" },
            { item = "signal_flare", count = { 1, 3 } },
        },
        probability = 20,
    }
    content.add(group)
end

do
    -- stuff you could fit in a bag
    local group = content.ItemGroup { id = "hiking", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("rope_30", 35)
    group:item("hatchet", 10)
    group:item("storage_line", 20)
    group:item("misc_repairkit", 5)
    group:item("mess_kit", 10)
    group:item("pot", 20)
    group:item("folded_inflatable_boat", 25)
    group:item("hand_pump", 5)
    group:item("pot_copper", 5)
    group:item("teapot", 5)
    group:item("pan", 20)
    group:item("binoculars", 20)
    group:item("hotplate", 10)
    group:entry { item = "popcan_stove", charges = { 0, 500 }, probability = 10 }
    group:item("coffeemaker", 5)
    group:group("tinware", 10)
    group:item("kukri", 4)
    group:item("knife_hunting", 18)
    group:group("knife_rambo_cont", 20)
    group:item("machete", 5)
    group:item("machete_gimmick", 5)
    group:item("armrig", 3)
    group:item("leg_small_bag", 3)
    group:item("leg_bag", 3)
    group:item("cowboy_hat", 4)
    group:item("10gal_hat", 4)
    group:item("mag_survival", 40)
    group:item("textbook_survival", 20)
    group:item("modern_tanner", 8)
    group:item("recipe_bows", 8)
    group:item("recipe_arrows", 8)
    group:item("mag_rifle", 30)
    group:item("mag_shotgun", 20)
    group:item("mag_traps", 20)
    group:item("manual_cutting", 12)
    group:item("manual_knives", 8)
    group:item("manual_swords", 8)
    group:item("manual_gun", 8)
    group:item("manual_shotgun", 6)
    group:item("manual_pistol", 4)
    group:item("manual_smg", 2)
    group:item("manual_survival", 20)
    group:item("manual_first_aid", 40)
    group:item("manual_traps", 12)
    group:item("trappers_companion", 2)
    group:item("textbook_traps", 8)
    group:entry { item = "lighter", charges = { 0, 100 }, probability = 60 }
    group:entry { item = "ref_lighter", charges = { 0, 50 }, probability = 10 }
    group:entry { item = "matches", charges = { 1, 20 }, probability = 60 }
    group:entry { item = "sewing_kit", charges = { 0, -1 }, probability = 47 }
    group:entry { item = "tailors_kit", charges = { 0, -1 }, probability = 3 }
    group:item("electric_spinwheel", 3)
    group:item("thread", 40)
    group:item("hammer", 35)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 20 }
    group:item("water_purifier", 5)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("string_36", 40)
    group:item("lc_wire", 50)
    group:item("rollmat", 40)
    group:item("tent_kit", 17)
    group:item("ax", 8)
    group:item("heatpack", 60)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 60 }
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 40 }
    group:item("emer_blanket", 20)
    group:item("cloak", 5)
    group:item("sleeping_bag", 10)
    group:item("dive_bag", 10)
    group:item("dry_bag", 10)
    group:item("dry_duffelbag", 10)
    group:item("dry_bag_large", 5)
    group:group("tools_fishingrods_portable", 20)
    group:item("fishing_waders", 12)
    group:entry { item = "gasoline_lantern", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "electric_lantern", charges = { 0, 100 }, probability = 8 }
    group:entry { item = "oil_lamp", charges = { 0, -1 }, probability = 5 }
    group:entry { item = "lamp_oil", charges = { 0, -1 }, probability = 5 }
    group:item("coat_rain", 10)
    group:item("hood_rain", 5)
    group:item("jacket_windbreaker", 5)
    group:item("umbrella", 12)
    group:item("teleumbrella", 5)
    group:item("pocketwatch", 5)
    group:item("boots_hiking", 20)
    group:item("runner_bag", 15)
    group:group("pur_tablets_bottle_plastic_small_1_50", 10)
    group:item("e_tool", 10)
    group:item("knife_trench", 7)
    group:item("flaregun", 20)
    group:item("signal_flare", 25)
    group:item("airhorn", 20)
    group:item("whistle", 20)
    group:item("bullwhip", 1)
    group:item("grapnel", 1)
    group:item("razor_blade", 9)
    group:item("survnote", 1)
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:item("trailmap", 5)
    group:item("chem_hexamine", 5)
    group:item("flint_steel", 10)
    group:item("bottle_metal", 5)
    group:item("tarp", 10)
    group:entry { item = "tinderbox", charges = { 0, 100 }, probability = 5 }
    group:item("cloak_wool", 5)
    group:item("whistle_multitool", 5)
    group:item("esbit_stove", 10)
    group:item("bottle_folding", 10)
    group:group("pillbox_any_used", 1)
    content.add(group)
end
