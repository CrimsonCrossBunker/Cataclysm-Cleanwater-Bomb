local content = require("ccb").content

do
    -- TODO: Add more groups to this file.
    local group = content.ItemGroup { id = "elevator_fridge_food", kind = "distribution" }
    group:group("any_crepe")
    content.add(group)
end

do
    -- TODO: Add more groups to this file.
    local group = content.ItemGroup { id = "elevator_fridge_drink", kind = "distribution" }
    group:group("any_crepe")
    content.add(group)
end

do
    -- TODO: Make actual food items made of algae & fungus and put into real itemgroups
    local group = content.ItemGroup { id = "vending_food_drink_items", kind = "collection" }
    group:group("default_vending_machine")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "depressants", kind = "distribution" }
    group:item("xanax", 1)
    group:item("weed", 1)
    group:item("thorazine", 1)
    group:item("prozac", 1)
    group:item("pills_sleep", 1)
    group:item("oxycodone", 1)
    group:item("antihistamine", 1)
    group:item("nyquil", 1)
    group:item("morphine", 1)
    group:item("joint", 1)
    group:item("heroin", 1)
    group:item("hi_q_distillate", 1)
    group:item("hi_q_wax", 1)
    group:item("hi_q_shatter", 1)
    group:item("diazepam", 1)
    group:item("codeine", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stimulants", kind = "distribution" }
    group:group("raw_coffee_in_container", 1)
    group:item("pure_meth", 1)
    group:item("meth", 1)
    group:item("lsd", 1)
    group:item("crack", 1)
    group:item("cola_meth", 1)
    group:item("coke", 1)
    group:item("caffeine", 1)
    group:item("caff_gum", 1)
    group:item("adderall", 1)
    group:item("choco_coffee_beans", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "oneirosis_countermeasures", kind = "distribution" }
    group:group("depressants", 1)
    group:group("stimulants", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "any_crepe", kind = "distribution" }
    group:item("crepe_plain")
    group:item("crepe")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crepe_filling_ingredients", kind = "distribution" }
    group:group("sugar_various_full")
    group:group("butter_wrapper_1_32")
    group:group("chocolate_wrapper_1_3")
    group:group("jam_fruit_jar_sealed")
    group:group("butcher_meat")
    group:group("cheese_hard_wrapper_8")
    group:group("eggs_in_carton_full")
    group:group("onion_bag_plastic_1")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crepe_ingredients", kind = "distribution" }
    group:group("flour_bulk")
    group:group("eggs_in_carton_full")
    group:group("salt_various_full")
    group:group("milk_in_container_full")
    content.add(group)
end
