local content = require("ccb").content

do
    local group = content.ItemGroup { id = "pawn_shop_electronics", kind = "distribution" }
    group:group("elecsto_entapl")
    group:group("elecsto_cameras")
    group:group("elecsto_homapl")
    group:group("elecsto_pcs")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "armor_suit", kind = "collection" }
    group:item("helmet_plate")
    group:item("boots_plate")
    group:item("armor_lc_armguard")
    group:item("gloves_plate")
    group:item("armor_lc_leg_guard")
    group:item("armor_junk_plate")
    group:item("chainmail_junk_hauberk", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bondage", kind = "distribution" }
    group:item("leather_belt", 50)
    group:item("blindfold", 50)
    group:item("bondage_mask", 50)
    group:item("bondage_mask_zipped", 50)
    group:item("bondage_suit", 40)
    group:item("leather_collar", 50)
    group:group("sex_accessories_domestic", 80)
    group:item("bullwhip", 50)
    group:item("candle", 50)
    group:item("rope_6", 20)
    group:item("camisole", 25)
    group:item("panties", 40)
    group:item("bra", 40)
    group:item("hot_pants_leather", 30)
    group:item("boxer_shorts", 30)
    group:item("mag_porn", 20)
    group:item("briefs", 30)
    group:entry { item = "cooking_oil", sealed = false, container = "bottle_plastic", probability = 20 }
    group:item("bikini_top_leather", 25)
    group:item("skirt_leather", 25)
    group:item("honey_bottled", 20)
    group:item("nanoskirt", 25)
    group:item("mag_dude", 20)
    group:item("chaps_leather", 25)
    group:item("novel_romance", 10)
    group:item("novel_erotic", 10)
    group:item("leather_cat_ears", 25)
    group:item("leather_cat_tail", 25)
    group:item("rope_30", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Gimp", kind = "collection" }
    group:item("bondage_mask_zipped")
    group:item("bondage_suit")
    group:item("corpse")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Maynard", kind = "collection" }
    group:item("longshirt")
    group:item("wristwatch")
    group:item("pants")
    group:item("boxer_shorts")
    group:item("socks")
    group:item("boots")
    group:item("corpse")
    content.add(group)
end
