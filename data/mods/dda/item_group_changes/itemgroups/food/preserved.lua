local content = require("ccb").content

do
    local group = content.ItemGroup { id = "preserved_food", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("jar_glass_sealed", 10)
    group:item("jar_3l_glass_sealed", 10)
    group:group("cheese_hard_wrapper_8", 15)
    group:entry { item = "cheese_hard", count = { -1, -1 }, probability = 20 }
    group:group("veggy_pickled_jar_glass_sealed_2", 50)
    group:group("sauerkraut_jar_glass_sealed_2", 5)
    group:group("meat_pickled_jar_glass_sealed_2", 20)
    group:group("confit_meat_jar_3l_glass_sealed_12", 20)
    group:group("fish_pickled_jar_glass_sealed_2", 30)
    group:group("lobster_in_can", 10)
    group:group("meat_canned_jar_3l_glass_sealed_12", 20)
    group:group("veggy_canned_jar_3l_glass_sealed_12", 40)
    group:group("fruits_in_3l_jar", 30)
    group:group("can_tomato_jar_3l_glass_sealed_24", 40)
    group:group("meat_pickled_jar_3l_glass_sealed_12", 10)
    group:group("veggy_pickled_jar_3l_glass_sealed_12", 20)
    group:entry { item = "jam_fruit", charges = { -1, -1 }, probability = 50 }
    group:entry { item = "jam_fruit", charges = { -1, -1 }, container = "jar_3l_glass_sealed", probability = 20 }
    group:entry { item = "brandied_fruit", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 10 }
    group:group("fish_pickled_jar_3l_glass_sealed_12", 40)
    group:entry { item = "sauce_red", charges = { 48, 48 }, container = "jar_3l_glass_sealed", probability = 60 }
    group:entry { item = "kompot", charges = { 12, 12 }, container = "jar_3l_glass_sealed", probability = 10 }
    group:group("freeze_dried_meal_box_any", 10)
    content.add(group)
end
