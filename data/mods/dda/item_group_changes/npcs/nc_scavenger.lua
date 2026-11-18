local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_gloves", kind = "distribution" }
    group:item("null", 30)
    group:item("gloves_leather", 20)
    group:item("gloves_work", 20)
    group:item("gloves_fingerless", 50)
    group:item("gloves_fingerless_mod", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_archery", kind = "distribution" }
    group:item("shortbow", 5)
    group:item("crossbow", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_pistols", kind = "distribution" }
    group:item("usp_45", 30)
    group:item("sw_619", 30)
    group:item("sw629", 5)
    group:item("colt_anaconda_8", 2)
    group:item("colt_anaconda_6", 3)
    group:item("colt_anaconda_4", 1)
    group:item("makarov", 5)
    group:item("m9", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_rifle", kind = "distribution" }
    group:item("browning_blr", 35)
    group:item("remington_700", 35)
    group:item("m1a", 35)
    group:item("m1903", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_SCAVENGER_misc", kind = "distribution" }
    group:item("water_clean", 90)
    group:item("water_mineral", 5)
    group:item("cola", 70)
    group:item("creamsoda", 60)
    group:item("lemonlime", 60)
    group:item("orangesoda", 60)
    group:item("crispycran", 40)
    group:item("colamdew", 60)
    group:item("choc_drink", 30)
    group:item("jerky", 55)
    group:group("cracklins_bag_plastic_4", 25)
    group:item("salted_fish", 35)
    group:group("porkstick_bag_plastic_4", 55)
    group:group("ravioli_in_can", 25)
    group:group("beans_in_can", 40)
    group:group("corn_in_can", 35)
    group:group("spam_in_can", 30)
    group:group("salt_various", 10)
    group:group("seasoning_salt_various", 5)
    group:item("vinegar", 10)
    group:group("veggy_pickled_jar_glass_sealed_2", 30)
    group:item("con_milk", 20)
    group:group("fish_pickled_jar_glass_sealed_2", 26)
    group:item("lutefisk", 1)
    group:item("pemmican", 10)
    group:group("meat_pickled_jar_glass_sealed_2", 20)
    content.add(group)
end
