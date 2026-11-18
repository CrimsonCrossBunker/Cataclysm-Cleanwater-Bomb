local content = require("ccb").content

do
    -- all comestible alcohol -- packaged, mixed and homemade
    local group = content.ItemGroup { id = "alcohol", kind = "distribution" }
    group:group("alcohol_bottled_canned", 376)
    group:group("mixed_alcoholic_drinks", 141)
    group:item("dandelion_wine", 8)
    group:item("hb_beer", 8)
    group:item("hb_seltzer", 8)
    group:item("moonshine", 8)
    group:entry { item = "brandied_fruit", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wines_worthy", kind = "distribution" }
    group:item("wine_riesling", 20)
    group:item("wine_chardonnay", 30)
    group:item("wine_cabernet", 30)
    group:item("wine_noir", 20)
    group:item("wine_vermouth", 25)
    group:item("wine_marsala", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "misc_alcohol", kind = "distribution" }
    group:item("bum_wine", 20)
    group:item("pine_wine", 6)
    group:item("fruit_wine", 12)
    group:item("mead", 10)
    group:item("sherry", 10)
    group:item("bristol_sherry", 5)
    group:item("madeira", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mixed_alcoholic_drinks", kind = "distribution" }
    group:item("drink_rumcola", 12)
    group:item("drink_screwdriver", 12)
    group:item("drink_wild_apple", 8)
    group:item("long_island", 6)
    group:item("drink_strawberry_surprise", 6)
    group:item("drink_boozeberry", 6)
    group:item("drink_gintonic", 12)
    group:item("drink_pinacolada", 10)
    group:item("drink_tequilasunrise", 8)
    group:item("drink_hobo", 10)
    group:item("drink_kalimotxo", 10)
    group:item("drink_beeknees", 8)
    group:item("drink_wsour", 8)
    group:item("eggnog_spiked", 5)
    group:item("drink_martini", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_beer", kind = "distribution" }
    group:item("beer", 35)
    group:item("european_pilsner", 25)
    group:item("drink_hard_seltzer", 25)
    group:item("pale_ale", 25)
    group:item("india_pale_ale", 25)
    group:item("stout", 15)
    group:item("belgian_ale", 10)
    group:item("imperial_stout", 4)
    group:item("wine_barley", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_in_container_full", kind = "distribution" }
    group:entry { group = "any_beer", container = "bottle_glass" }
    group:entry { group = "any_beer", container = "bottle_glass_330ml" }
    group:entry { group = "any_beer", container = "can_drink" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_in_six_pack_rings", kind = "distribution", container = "six_pack_rings" }
    group:entry { item = "beer", count = { 6, 6 }, container = "can_drink", probability = 35 }
    group:entry { item = "european_pilsner", count = { 6, 6 }, container = "can_drink", probability = 25 }
    group:entry { item = "drink_hard_seltzer", count = { 6, 6 }, container = "can_drink", probability = 25 }
    group:entry { item = "pale_ale", count = { 6, 6 }, container = "can_drink", probability = 25 }
    group:entry { item = "india_pale_ale", count = { 6, 6 }, container = "can_drink", probability = 25 }
    group:entry { item = "stout", count = { 6, 6 }, container = "can_drink", probability = 15 }
    group:entry { item = "belgian_ale", count = { 6, 6 }, container = "can_drink", probability = 10 }
    group:entry { item = "imperial_stout", count = { 6, 6 }, container = "can_drink", probability = 4 }
    group:entry { item = "wine_barley", count = { 6, 6 }, container = "can_drink", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_in_six_pack_cardboard", kind = "distribution", container = "six_bottle_box" }
    group:entry { item = "beer", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 35 }
    group:entry { item = "european_pilsner", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 25 }
    group:entry { item = "drink_hard_seltzer", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 25 }
    group:entry { item = "pale_ale", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 25 }
    group:entry { item = "india_pale_ale", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 25 }
    group:entry { item = "stout", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 15 }
    group:entry { item = "belgian_ale", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 10 }
    group:entry { item = "imperial_stout", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 4 }
    group:entry { item = "wine_barley", count = { 6, 6 }, container = "bottle_glass_330ml", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_in_six_pack", kind = "distribution" }
    group:group("beer_in_six_pack_rings")
    group:group("beer_in_six_pack_cardboard")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beer_in_container", kind = "distribution" }
    group:entry { group = "any_beer", charges = { 1, -1 }, container = "bottle_glass" }
    group:entry { group = "any_beer", charges = { 1, -1 }, container = "bottle_glass_330ml" }
    group:entry { group = "any_beer", charges = { 1, -1 }, container = "can_drink" }
    content.add(group)
end
