local content = require("ccb").content

do
    local group = content.ItemGroup { id = "female_underwear_child", kind = "collection" }
    group:group("female_underwear_top_child")
    group:group("female_underwear_bottom")
    content.add(group)
end

do
    -- unisex underwear
    local group = content.ItemGroup { id = "underwear_unisex", kind = "distribution" }
    group:item("thermal_suit", 1)
    group:item("thermal_outfit", 1)
    group:item("long_undertop", 30)
    group:item("under_armor", 10)
    group:item("undershirt", 40)
    group:item("under_armor_shorts", 10)
    group:item("long_underpants", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "female_underwear_top_child", kind = "distribution" }
    group:item("bra", 70)
    group:item("sports_bra", 50)
    group:item("camisole", 30)
    group:item("halter_top", 30)
    group:entry { item = "bikini_top", variant = "flag_bikini_top", event = "independence_day", probability = 70 }
    content.add(group)
end

do
    -- women's underwear.
    local group = content.ItemGroup { id = "underwear_womens", kind = "distribution" }
    group:item("boy_shorts", 30)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day" }
    group:item("bra", 60)
    group:item("panties", 70)
    group:group("bikini", 55)
    group:item("flag_swimsuit", 5)
    group:item("camisole", 30)
    group:item("corset", 10)
    group:item("corset_waist", 10)
    group:item("sports_bra", 50)
    group:item("stockings", 20)
    group:item("garter_belt", 10)
    group:item("tights", 20)
    group:entry { group = "costume_independence_undergarments_women", event = "independence_day", probability = 70 }
    group:entry { group = "costume_undergarments_women", event = "halloween", probability = 70 }
    content.add(group)
end

do
    -- men's underwear.
    local group = content.ItemGroup { id = "underwear_mens", kind = "distribution" }
    group:item("boxer_briefs", 30)
    group:item("boxer_shorts", 50)
    group:item("boxer_shorts", 5, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("briefs", 50)
    group:item("trunks", 10)
    group:item("swim_briefs", 5)
    group:item("speedo", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "underwear", kind = "distribution" }
    group:group("female_underwear", 50)
    group:group("male_underwear", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "female_underwear", kind = "collection" }
    group:group("female_underwear_top")
    group:group("female_underwear_bottom")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "male_underwear", kind = "collection" }
    group:group("male_underwear_top")
    group:group("male_underwear_bottom")
    content.add(group)
end

do
    -- unisex socks
    local group = content.ItemGroup { id = "socks_unisex", kind = "distribution" }
    group:item("socks", 70)
    group:item("socks_ankle", 50)
    group:item("socks_wool", 30)
    group:item("thermal_socks", 1)
    content.add(group)
end
