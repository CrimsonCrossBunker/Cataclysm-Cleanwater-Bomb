local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_FREE_MERCHANT_storage", kind = "distribution" }
    group:item("duffelbag")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_FREE_MERCHANT_coat", kind = "distribution" }
    group:item("trenchcoat", 80)
    group:item("vest", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_FREE_MERCHANT_misc", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 5, 30 }, probability = 90 }
    group:entry { item = "jerky", count = { 10, 25 } }
    group:entry { item = "tallow", count = { 20, 50 } }
    group:entry { item = "pemmican", count = { 10, 25 } }
    group:entry { item = "dry_meat", count = { 10, 25 } }
    group:entry { item = "dry_fish", count = { 10, 25 } }
    group:entry { item = "dry_veggy", count = { 20, 50 } }
    group:entry { item = "dry_fruit", count = { 10, 25 } }
    group:item("trenchcoat", 25)
    group:item("trenchcoat_leather", 20)
    group:item("trenchcoat_fur", 10)
    group:item("jacket_leather", 25)
    group:item("jacket_jean", 15)
    group:item("vest_jean", 5)
    group:item("jacket_flannel", 15)
    group:item("pants_cargo", 40)
    group:item("shorts_cargo", 25)
    group:item("pants_leather", 15)
    group:item("gloves_fingerless", 30)
    group:item("gloves_fur", 5)
    group:item("gloves_leather", 35)
    group:item("boots", 20)
    group:item("boots_hiking", 30)
    group:item("hood_rain", 15)
    group:item("runner_bag", 20)
    group:item("sunglasses", 15)
    group:item("goggles_ski", 5)
    group:item("wristwatch", 30)
    group:item("bandana", 20)
    group:item("scarf", 15)
    group:group("fungicide_bag_plastic_400", 20)
    group:group("insecticide_bag_plastic", 20)
    group:group("antifungal_bottle_plastic_pill_prescription_5", 20)
    group:group("antiparasitic_bottle_plastic_pill_prescription_5", 20)
    group:entry { group = "robofac_basic_trade", count = { 1, 5 }, probability = 20 }
    group:entry { group = "robofac_armor_pieces", count = { 1, 2 }, probability = 20 }
    content.add(group)
end
