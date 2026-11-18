local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_EVAC_BROKER_gloves", kind = "distribution" }
    group:item("null", 30)
    group:item("gloves_leather", 20)
    group:item("gloves_work", 20)
    group:item("gloves_fingerless", 50)
    group:item("gloves_fingerless_mod", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_EVAC_BROKER_archery", kind = "distribution" }
    group:item("shortbow", 5)
    group:item("crossbow", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_EVAC_BROKER_pistols", kind = "distribution" }
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
    local group = content.ItemGroup { id = "NC_EVAC_BROKER_rifle", kind = "distribution" }
    group:item("browning_blr", 35)
    group:item("remington_700", 35)
    group:item("m1a", 35)
    group:item("m1903", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_EVAC_BROKER_misc", kind = "distribution" }
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
    group:item("cracklins", 25)
    group:item("salted_fish", 35)
    group:item("porkstick", 55)
    group:item("ravioli", 25)
    group:item("can_beans", 40)
    group:item("can_corn", 35)
    group:item("can_spam", 30)
    group:item("salt", 10)
    group:item("seasoning_salt", 5)
    group:item("vinegar", 10)
    group:group("veggy_pickled_jar_glass_sealed_2", 30)
    group:item("con_milk", 20)
    group:group("fish_pickled_jar_glass_sealed_2", 26)
    group:item("lutefisk", 1)
    group:item("pemmican", 10)
    group:group("meat_pickled_jar_glass_sealed_2", 20)
    content.add(group)
end
