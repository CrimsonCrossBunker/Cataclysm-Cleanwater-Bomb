local content = require("ccb").content

do
    local group = content.ItemGroup { id = "female_underwear_top", kind = "distribution" }
    group:item("corset", 5)
    group:item("binder_top", 1)
    group:item("corset_waist", 5)
    group:group("female_underwear_top_child", 190)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "female_underwear_bottom", kind = "distribution" }
    group:item("panties", 70)
    group:item("boy_shorts", 50)
    group:item("boy_shorts", 2, "flag_boy_shorts")
    group:entry { item = "boy_shorts", variant = "flag_boy_shorts", event = "independence_day", probability = 70 }
    group:entry { item = "bikini_bottom", variant = "flag_bikini_bottom", event = "independence_day", probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "male_underwear_top", kind = "distribution" }
    group:item("undershirt", 50)
    group:item("binder_top", 2)
    group:item("long_undertop", 20)
    group:item("thermal_shirt", 10)
    group:item("under_armor", 20)
    group:item("tank_top", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "male_underwear_bottom", kind = "distribution" }
    group:item("boxer_shorts", 70)
    group:item("boxer_shorts", 5, "flag_boxer_shorts")
    group:entry { item = "boxer_shorts", variant = "flag_boxer_shorts", event = "independence_day" }
    group:item("briefs", 30)
    group:item("boxer_briefs", 50)
    group:item("long_underpants", 20)
    group:item("under_armor_shorts", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "loincloth", kind = "distribution" }
    group:item("loincloth", 2)
    group:item("loincloth_wool", 1)
    group:item("loincloth_fur", 1)
    group:item("loincloth_leather", 1)
    content.add(group)
end
