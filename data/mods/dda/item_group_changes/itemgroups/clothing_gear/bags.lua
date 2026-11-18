local content = require("ccb").content

do
    local group = content.ItemGroup { id = "large_bags", kind = "distribution" }
    group:item("backpack", 38)
    group:item("backpack_hiking", 3)
    group:item("backpack_hunting", 1)
    group:item("daypack", 3)
    group:item("backpack_tactical_large", 1)
    group:group("molle_backpacks_and_accessories", 1)
    group:item("duffelbag", 5)
    group:group("large_duffelbags", 5)
    group:group("large_gym_bags", 10)
    group:item("bigback", 1)
    group:item("travelpack", 5)
    group:item("rucksack", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_bags", kind = "distribution" }
    group:item("petpack", 3)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:item("slingpack", 8)
    group:group("small_gym_bags", 10)
    group:item("backpack_small", 10)
    group:item("backpack_denim", 3)
    group:item("backpack_leather", 8)
    group:item("briefcase", 10)
    content.add(group)
end
