local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bags", kind = "distribution" }
    group:group("small_bags", 92)
    group:item("backpack", 38)
    group:item("backpack_hiking", 3)
    group:item("backpack_hunting", 1)
    group:item("backpack_tactical_large", 1)
    group:item("bigback", 1)
    group:item("travelpack", 5)
    group:item("rucksack", 1)
    group:group("large_gym_bags", 5)
    group:item("leg_bag", 1)
    group:item("quiver_takedown_bow", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "small_gym_bags", kind = "distribution" }
    group:item("duffelbag_gym_xxs", 2)
    group:item("duffelbag_gym_xs", 5)
    group:item("duffelbag_gym_s", 20)
    group:item("duffelbag_gym_m", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "large_gym_bags", kind = "distribution" }
    group:item("duffelbag_gym_l", 10)
    group:item("duffelbag_gym_xl", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gym_bags", kind = "distribution" }
    group:group("small_gym_bags", 5)
    group:group("large_gym_bags", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gun_cases", kind = "distribution" }
    group:item("rifle_case_soft", 50)
    group:item("rifle_case_soft_leather", 30)
    group:item("rifle_case_soft_2", 40)
    group:item("rifle_case_soft_leather_2", 30)
    group:item("rifle_case_xl_soft_leather", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bags_trip", kind = "distribution" }
    group:item("suitcase_l", 37)
    group:item("suitcase_m", 55)
    group:item("duffelbag", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "large_duffelbags", kind = "distribution" }
    group:group("large_gym_bags")
    group:item("duffelbag_l_poly", 60)
    group:item("duffelbag_xl_nylon", 30)
    content.add(group)
end
