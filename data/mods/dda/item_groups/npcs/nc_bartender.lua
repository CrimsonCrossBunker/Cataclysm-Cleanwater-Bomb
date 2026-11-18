local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_BARTENDER_extra", kind = "distribution" }
    group:item("backpack", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BARTENDER_coat", kind = "distribution" }
    group:item("trenchcoat", 80)
    group:item("vest", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BARTENDER_misc", kind = "distribution" }
    group:item("whiskey", 16)
    group:item("vodka", 20)
    group:item("gin", 20)
    group:item("rum", 14)
    group:item("tequila", 12)
    group:item("moonshine", 15)
    group:item("triple_sec", 12)
    group:item("bum_wine", 20)
    group:item("mixed_alcohol_strong", 15)
    group:item("mixed_alcohol_weak", 15)
    group:item("fruit_wine", 12)
    group:item("brandy", 12)
    group:item("irish_coffee", 12)
    group:item("drink_boozeberry", 8)
    group:item("drink_hard_seltzer", 25)
    group:item("drink_rumcola", 12)
    group:item("drink_screwdriver", 12)
    group:item("drink_wsour", 12)
    group:item("drink_wild_apple", 8)
    group:item("drink_martini", 12)
    group:item("drink_hobo", 8)
    group:item("drink_beeknees", 8)
    group:item("drink_kalimotxo", 8)
    group:item("drink_strawberry_surprise", 8)
    group:item("long_island", 6)
    group:item("eggnog_spiked", 6)
    group:item("wine_riesling", 6)
    group:item("wine_chardonnay", 10)
    group:item("wine_cabernet", 10)
    group:item("wine_noir", 2)
    group:item("wine_marsala", 2)
    group:item("wine_vermouth", 9)
    group:item("dandelion_wine", 10)
    group:item("pine_wine", 10)
    group:item("mead", 2)
    group:item("beer", 35)
    group:item("hb_beer", 25)
    group:item("european_pilsner", 25)
    group:item("wine_barley", 30)
    group:item("pale_ale", 25)
    group:item("india_pale_ale", 25)
    group:item("stout", 15)
    group:item("belgian_ale", 10)
    group:item("imperial_stout", 4)
    group:entry { item = "single_malt_whiskey", container = "bottle_glass", probability = 2 }
    group:group("cig_box_cigarette_20", 50)
    group:group("chaw_wrapper_20", 20)
    group:entry { item = "cigar", count = { 5, 5 }, probability = 40 }
    content.add(group)
end
