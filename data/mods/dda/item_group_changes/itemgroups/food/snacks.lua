local content = require("ccb").content

do
    local group = content.ItemGroup { id = "snacks", kind = "distribution" }
    group:group("candy_chocolate", 620)
    group:group("salty_snacks", 595)
    group:item("foodplace_snack_bar", 5)
    group:entry { item = "foodplace_zero_drink", container = "bottle_plastic", probability = 5 }
    group:item("foodplace_zero_drink", 5)
    group:group("pemmican_bag_small", 5)
    group:group("granola_bag_plastic_4", 10)
    group:group("cookies_box_snack_4", 80)
    group:group("tea_raw_bag_plastic_33", 10)
    group:group("tea_green_raw_bag_plastic_33", 5)
    group:item("instant_coffee", 20)
    group:group("choco_coffee_beans_bag_plastic_5", 10)
    group:group("salt_various", 10)
    group:group("pepper_various", 10)
    group:item("syrup", 10)
    group:item("coffee_syrup", 10)
    group:group("fruit_leather_bag_plastic_full", 25)
    group:item("kernels", 25)
    group:group("pine_nuts_bag_plastic_4", 20)
    group:group("protein_bar_any_box_12", 20)
    group:group("teabag_box", 10)
    group:group("soup_box", 10)
    content.add(group)
end
