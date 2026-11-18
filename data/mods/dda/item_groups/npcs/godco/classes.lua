local content = require("ccb").content

do
    local group = content.ItemGroup { id = "GODCO_guard_worn", kind = "collection" }
    group:item("boots")
    group:item("boxer_shorts")
    group:item("socks")
    group:item("sweater")
    group:item("pants")
    group:item("hoodie")
    group:item("mbag")
    group:item("hat_ball")
    group:item("sunglasses", 50)
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_chloe_taylor_worn", kind = "collection" }
    group:item("sports_bra")
    group:item("boxer_shorts")
    group:item("socks")
    group:item("tshirt")
    group:item("skirt")
    group:item("sneakers")
    group:item("gloves_light")
    group:item("knit_scarf")
    group:item("holy_symbol_wood")
    group:item("hat_knit", 50)
    group:item("coat_rain")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_sonia_worn", kind = "collection" }
    group:item("socks")
    group:item("sneakers")
    group:item("briefs")
    group:item("bra")
    group:item("tshirt")
    group:item("pants_cargo")
    group:item("leather_belt")
    group:item("trenchcoat_leather")
    group:item("wristwatch")
    group:item("bead_bracelet")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_zachary_montes_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("boxer_shorts")
    group:item("jeans")
    group:item("undershirt")
    group:item("leather_belt")
    group:item("gloves_work")
    group:item("gold_ear")
    group:item("hat_hard_hooded")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_darryl_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_rubber")
    group:item("boxer_shorts")
    group:item("jeans")
    group:item("technician_shirt_gray")
    group:item("knit_scarf")
    group:item("wristwatch")
    group:item("jacket_evac")
    group:item("backpack")
    group:item("silver_ring")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_katherine_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("panties")
    group:item("bra")
    group:item("skirt")
    group:item("sweatshirt")
    group:item("knit_scarf")
    group:item("gold_ring")
    group:item("gold_ear")
    group:item("holy_symbol_wood")
    group:item("glasses_reading")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_julian_worn", kind = "collection" }
    group:item("socks_wool")
    group:item("boots_steel")
    group:item("boxer_shorts")
    group:item("pants_cargo")
    group:item("longshirt")
    group:item("leather_pouch")
    group:item("holy_symbol_wood")
    group:item("wristwatch")
    group:item("badge_deputy")
    group:item("hat_hunting")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_gemma_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_western")
    group:item("panties")
    group:item("bra")
    group:item("jeans")
    group:item("dress_shirt")
    group:item("fanny")
    group:item("jacket_leather")
    group:item("hat_knit")
    group:item("silver_ring")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_russell_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_steel")
    group:item("pants_cargo")
    group:item("tank_top", 100, "tank_top_camo")
    group:entry {
        item = "bandolier_rifle",
        contents = {
            { group = "bandolier_rifle_hunter" },
        },
    }
    group:item("jacket_army")
    group:item("knit_scarf")
    group:item("backpack_hiking")
    group:item("duffelbag")
    group:entry {
        item = "sheath",
        contents = {
            { item = "knife_hunting" },
        },
    }
    group:item("hat_fur")
    group:item("wristwatch")
    group:item("binoculars")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_tom_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("boxer_shorts")
    group:item("jeans")
    group:item("jacket_flannel")
    group:item("fanny")
    group:item("silver_watch")
    group:item("holy_symbol_wood")
    group:entry { item = "mask_gas", charges = { 75, 75 } }
    group:item("gold_ring")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_kostas_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_hiking")
    group:item("briefs")
    group:item("pants_cargo")
    group:item("sweatshirt")
    group:item("bow_sling")
    group:item("trenchcoat_leather")
    group:item("holy_symbol_wood")
    group:item("scabbard")
    group:item("scarf_fur")
    group:item("backpack_hiking")
    group:item("duffelbag")
    group:item("hat_fur")
    group:item("rope_makeshift_6")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_greenwood_worn", kind = "collection" }
    group:item("socks")
    group:item("dress_shoes")
    group:item("briefs")
    group:item("pants")
    group:item("longshirt")
    group:item("cassock")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jane_worn", kind = "collection" }
    group:item("socks")
    group:item("dress_shoes")
    group:item("bra")
    group:item("panties")
    group:item("pants")
    group:item("dress_shirt")
    group:item("coat_lab")
    group:item("purse")
    group:item("stethoscope")
    group:item("mask_dust")
    group:item("diamond_gold_earring")
    group:item("gloves_medical")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_corrie_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_steel")
    group:item("boy_shorts")
    group:item("jeans")
    group:item("bra")
    group:item("technician_shirt_gray")
    group:item("slingpack")
    group:item("wristwatch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_felicity_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("bra")
    group:item("panties")
    group:item("sundress")
    group:item("jacket_leather", 100, "jacket_leather_brown")
    group:item("holy_symbol_wood")
    group:item("purse")
    group:item("gold_ring")
    group:item("garnet_silver_earring")
    group:item("straw_hat", 33)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_theresa_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("bra")
    group:item("panties")
    group:item("jeans")
    group:item("sweater")
    group:item("blazer")
    group:item("knit_scarf")
    group:item("silver_ring")
    group:item("gold_necklace")
    group:item("holy_symbol_wood")
    group:item("glasses_reading")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jeremiah_worn", kind = "collection" }
    group:item("socks")
    group:item("sneakers")
    group:item("boxer_shorts")
    group:item("jeans")
    group:item("tshirt")
    group:item("wristwatch")
    group:item("glasses_eye")
    group:item("holy_symbol_wood")
    group:item("mbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_olwen_worn", kind = "collection" }
    group:item("socks")
    group:item("boots_hiking")
    group:item("bra")
    group:item("panties")
    group:item("leggings")
    group:item("skirt")
    group:item("wool_hoodie")
    group:item("holy_symbol_wood")
    group:item("sunglasses")
    group:item("backpack_leather")
    group:item("beret")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_maria_worn", kind = "collection" }
    group:item("socks")
    group:item("boots")
    group:item("panties")
    group:item("jeans")
    group:item("tshirt")
    group:item("silver_watch")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_arturo_worn", kind = "collection" }
    group:item("leathersandals")
    group:item("boxer_shorts")
    group:item("robe")
    group:item("rope_6")
    group:item("holy_symbol_wood")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_helena_carried", kind = "collection" }
    group:entry { item = "icon", count = { 13, 13 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_chloe_taylor_carried", kind = "collection" }
    group:item("portable_game")
    group:item("lemonlime")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_zachary_montes_carried", kind = "collection" }
    group:item("nail")
    group:item("hammer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_darryl_carried", kind = "collection" }
    group:item("multitool")
    group:entry { group = "farming_seeds", count = { 15, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_katherine_carried", kind = "collection" }
    group:item("photo_album")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_julian_carried", kind = "collection" }
    group:entry { item = "glock17_17", charges = { 15, 17 } }
    group:entry { item = "glock_17", charges = { 25, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_gemma_carried", kind = "collection" }
    group:entry { item = "seed_rose", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_russell_carried", kind = "collection" }
    group:item("ear_plugs")
    group:entry { item = "meat_smoked", count = { 4, 6 } }
    group:entry { item = "270win_jsp", count = { 1, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_tom_carried", kind = "collection" }
    group:group("full_survival_kit")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_greenwood_carried", kind = "collection" }
    group:entry { item = "icon", count = { 5, 5 } }
    group:item("candle")
    group:item("small_relic")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jane_carried", kind = "collection" }
    group:group("full_1st_aid")
    group:entry { item = "bandages", count = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_corrie_carried", kind = "collection" }
    group:item("screwdriver")
    group:group("duct_tape_roll_part")
    group:item("welder")
    group:item("goggles_welding")
    group:item("solar_cell")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_felicity_carried", kind = "collection" }
    group:item("knife_folding")
    group:item("survivor_hairtrimmer")
    group:entry { item = "mask_gas", charges = { 100, 100 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_theresa_carried", kind = "collection" }
    group:item("knitting_needles")
    group:entry { item = "thread", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jeremiah_carried", kind = "collection" }
    group:group("charged_cell_phone")
    group:item("cola")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_olwen_carried", kind = "collection" }
    group:item("laptop")
    group:group("duct_tape_roll_part")
    group:item("lemonlime")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_maria_carried", kind = "collection" }
    group:entry { item = "tailors_kit", charges = { 400, 400 } }
    group:entry { item = "thread", count = { 1000, 1000 } }
    group:item("cell_phone")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_guard_wield", kind = "collection" }
    group:entry { item = "remington_870_express", charges = { 7, 7 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_chloe_taylor_wield", kind = "collection" }
    group:item("knife_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_sonia_wield", kind = "collection" }
    group:entry { item = "acoustic_guitar", damage = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_zachary_montes_wield", kind = "collection" }
    group:item("fire_ax")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_darryl_wield", kind = "collection" }
    group:item("hoe")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_katherine_wield", kind = "collection" }
    group:item("knife_small", 100, "knife_steak")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_julian_wield", kind = "collection" }
    group:item("null")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_gemma_wield", kind = "collection" }
    group:item("g_shovel")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_tom_wield", kind = "collection" }
    group:item("knife_folding")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_kostas_wield", kind = "collection" }
    group:item("machete")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_greenwood_wield", kind = "collection" }
    group:item("holybook_bible1")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jane_wield", kind = "collection" }
    group:item("scalpel")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_corrie_wield", kind = "collection" }
    group:item("wrench")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_felicity_wield", kind = "collection" }
    group:item("null")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_theresa_wield", kind = "collection" }
    group:item("cane")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_jeremiah_wield", kind = "collection" }
    group:item("dnd_handbook")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_olwen_wield", kind = "collection" }
    group:item("spear_knife")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_maria_wield", kind = "collection" }
    group:item("scots_tailor")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "GODCO_russell_sell", kind = "collection" }
    group:entry { item = "tanned_hide", count = { 10, 12 } }
    group:entry { item = "tanned_pelt", count = { 8, 10 } }
    group:entry { item = "icon", count = { 5, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_GODCO_MERCHANT_sell", kind = "distribution" }
    group:group("NC_EVAC_SHOPKEEP_misc")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "poppy_pain_jar_glass_sealed_2", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "poppy_pain", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "poppy_sleep_jar_glass_sealed_2", kind = "collection", container = "jar_glass_sealed" }
    group:entry { item = "poppy_sleep", count = { 2, 2 } }
    content.add(group)
end
