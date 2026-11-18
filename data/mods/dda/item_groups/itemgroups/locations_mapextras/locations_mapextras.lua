local content = require("ccb").content

do
    local group = content.ItemGroup { id = "college_lake", kind = "distribution" }
    group:group("bikini", 120)
    group:item("flag_swimsuit")
    group:item("trunks")
    group:item("rashguard", 30)
    group:item("speedo", 50)
    group:item("swim_briefs", 60)
    group:item("towel")
    group:item("goggles_swim", 30)
    group:item("swim_fins", 20)
    group:item("flotation_vest", 50)
    group:item("swimming_kickboard", 15)
    group:item("diving_watch", 10)
    group:item("sunglasses", 60)
    group:item("fitover_sunglasses", 20)
    group:item("flip_flops", 50)
    group:item("flip_flops_exp", 5)
    group:item("wetsuit_spring", 10)
    group:item("wetsuit_spring_sleeveless", 10)
    group:group("tools_fishingrods_commercial", 30)
    group:item("straw_hat", 80)
    group:item("straw_fedora", 80)
    group:item("silver_ear", 20)
    group:item("bead_ear", 20)
    group:item("silver_necklace", 20)
    group:item("silver_bracelet", 20)
    group:item("silver_locket", 20)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:group("bottle_otc_painkiller_1_20", 80)
    group:entry { item = "inhaler", charges = { 10, 100 }, probability = 30 }
    group:item("beer", 80)
    group:item("wine_barley", 20)
    group:group("cig_box_cigarette_1_20", 20)
    group:entry { item = "weed", count = { 1, 5 }, probability = 10 }
    group:item("joint", 10)
    group:group("civilian_phones", 50)
    content.add(group)
end
