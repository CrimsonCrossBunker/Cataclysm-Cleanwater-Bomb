local ccb = require("ccb")
local content = ccb.content

do
    -- danby.com/products/apartment-size-refrigerators/dar110a3ldb/
    -- 60.50 * 66.50 * 149.50 cm, 249 kwh/annual
    local item = content.Item {
        id = "apartment_fridge",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("household fridge", "household fridges"),
        description = ccb.content.text("A disconnected household refrigerator.  General choice to store some perishables for an average family.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 1495,
        insulation = 10,
        volume_ml = 601475,
        mass_milligrams = 56520000,
        price_cents = 109900,
        price_postapoc_cents = 700,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("apartment_fridge")
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 311000, max_weight_milligrams = 800000000, rigid = true }
    content.add(item)
end

do
    -- danby.com/products/compact-refrigerators/dar033a6bsldb/
    -- 44.91 * 51.89 * 84.00
    local item = content.Item {
        id = "minifridge",
        name = ccb.content.plural_text("minifridge", "minifridges"),
        description = ccb.content.text("A disconnected minifridge, similar to ones in some luxury limousines.  Activate to deploy and connect to your electric grid."),
        symbol = "F",
        color = "light_blue",
        price_cents = 51900,
        price_postapoc_cents = 300,
        volume_ml = 195751,
        mass_milligrams = 24490000,
        longest_side_mm = 840,
        insulation = 2,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("minifridge")
    item:container_pocket { max_volume_ml = 96000, max_weight_milligrams = 300000000, rigid = true }
    content.add(item)
end

do
    -- TrueMFG T-19-HC, scaled down to fit the size of vehicle parts (assumed to be 500L)
    -- original values: 686 * 623 * 1912 mm, 112 kg, gross capacity 417 L, 495 kwh/annual
    -- scaled values: 578 * 525 * 1615 mm, 67 kg, gross capacity 250 L, 296 kwh/annual
    local item = content.Item {
        id = "big_portable_fridge",
        name = ccb.content.plural_text("food truck fridge", "food truck fridges"),
        description = ccb.content.text("A heavy and bulky fridge with little wheels for easier transportation.  Has a bunch of sections and separators, which allow it to be installed in a vehicle with relative assurance that any items inside will stay put.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 67000000,
        volume_ml = 490000,
        longest_side_mm = 1615,
        price_cents = 220000,
        price_postapoc_cents = 1000,
        insulation = 7,
        copy_from = "minifridge",
        looks_like = "minifridge",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("big_portable_fridge")
    item:container_pocket { max_volume_ml = 250000, max_weight_milligrams = 700000000, rigid = true }
    content.add(item)
end

do
    -- Tefcold CEV425CP, 1980 x 595 x 640 mm, net capacity 347 L, 821 kwh/annum, 94 kwh
    -- door should be approx 11 kilo of glass
    local item = content.Item {
        id = "glass_fridge",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("single glass door fridge", "single glass door fridges"),
        description = ccb.content.text("A disconnected commercial refrigerator with a transparent glass door, designed to show off any cold drinks and similar goods in a grocery store while still keeping them cool.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 1980,
        insulation = 9,
        volume_ml = 753984,
        mass_milligrams = 78000000,
        price_cents = 71000,
        price_postapoc_cents = 500,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("glass_fridge")
    item:material("steel", 7)
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 347000, max_weight_milligrams = 800000000, rigid = true }
    content.add(item)
end

do
    -- True GDM-35-HC-TSL01, 1998 x 1004 x 759 mm (because of technical limitations, only 1000L of volume, not 1522), net capacity 991 L, 2103 kwh/annum, 240 kwh
    -- doors should be approx 19 kilo of glass
    local item = content.Item {
        id = "glass_fridge_double",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("double glass door fridge", "double glass door fridges"),
        description = ccb.content.text("A disconnected commercial refrigerator with two transparent glass doors, designed to show off any cold drinks and similar goods in a grocery store while still keeping them cool.  Activate to deploy and connect to your electric grid."),
        volume_ml = 1000000,
        longest_side_mm = 1998,
        insulation = 9,
        mass_milligrams = 168000000,
        price_cents = 250000,
        price_postapoc_cents = 600,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("glass_fridge_double")
    item:material("steel", 11)
    item:material("aluminum", 3)
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 991000, max_weight_milligrams = 3000000000, rigid = true }
    content.add(item)
end

do
    -- Polar UA030, 2150 x 700 x 810 mm (because of technical limitations, only 1000 L of volume, not 1219), net capacity 700 L, 351 kwh/annum, 40 kwh
    local item = content.Item {
        id = "heavy_duty_fridge",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("heavy-duty fridge", "heavy-duty fridges"),
        description = ccb.content.text("A disconnected commercial refrigerator, used in many professional kitchens.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 2150,
        insulation = 9,
        volume_ml = 1000000,
        mass_milligrams = 165000000,
        price_cents = 224900,
        price_postapoc_cents = 1500,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("heavy_duty_fridge")
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 700000, max_weight_milligrams = 2500000000, rigid = true }
    content.add(item)
end

do
    -- Interlevin CHOPIN 1000 FV-VP, 1300 x 1050 x 800 mm (because of technical limitations, only 1000 L of volume, not 1092), net capacity 600 L (dimensions are calculated manually, 775 * 775 * 1000 mm), 1205 kwh/annum, 137 kwh
    local item = content.Item {
        id = "display_fridge",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("display fridge", "display fridges"),
        description = ccb.content.text("A big glass chamber, designed to display different food in a multiple rows, while cooling it at the same time.  While you might not need to actually display any of your food, it cools the food as good as any another fridge.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 928,
        price_cents = 490000,
        price_postapoc_cents = 400,
        insulation = 8,
        volume_ml = 1000000,
        mass_milligrams = 102000000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("display_fridge")
    item:material("steel", 3)
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 600000, max_weight_milligrams = 1200000000, rigid = true }
    content.add(item)
end

do
    -- danby.com/products/freezers/dufm043a2wdd/
    -- 60.81 * 63.20 * 92.86 cm, 260 kwh/annual
    local item = content.Item {
        id = "apartment_freezer",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("household freezer", "household freezers"),
        description = ccb.content.text("A disconnected household freezer.  Great choice if you need to freeze some discount meat.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 928,
        price_cents = 49900,
        price_postapoc_cents = 600,
        insulation = 10,
        volume_ml = 356878,
        mass_milligrams = 56520000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("apartment_freezer")
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 122000, max_weight_milligrams = 350000000, rigid = true }
    content.add(item)
end

do
    -- danby.com/products/freezers/dufm032a3wdb-3/
    -- 52.55 * 57.15 * 83.03 cm
    local item = content.Item {
        id = "minifreezer",
        name = ccb.content.plural_text("minifreezer", "minifreezers"),
        description = ccb.content.text("A compact version of an upright freezer, designed as a mobile solution for freezing food.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 26900000,
        volume_ml = 249358,
        longest_side_mm = 830,
        price_cents = 36300,
        price_postapoc_cents = 500,
        insulation = 4,
        copy_from = "minifridge",
        looks_like = "minifridge",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("minifreezer")
    item:container_pocket { max_volume_ml = 90000, max_weight_milligrams = 300000000, rigid = true }
    content.add(item)
end

do
    -- danby.com/products/freezers/dcf035a6wm/
    -- 51.44 * 54.94 * 84.33 cm
    local item = content.Item {
        id = "chest_minifreezer",
        name = ccb.content.plural_text("chest minifreezer", "chest minifreezers"),
        description = ccb.content.text("A compact version of a chest freezer, designed as a mobile solution for freezing food, but it's pretty tricky to pull anything out from the bottom.  Perfect choice to put in your closet and forget for a year.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 22940000,
        volume_ml = 238000,
        longest_side_mm = 843,
        price_cents = 24900,
        price_postapoc_cents = 800,
        insulation = 4,
        copy_from = "minifridge",
        looks_like = "minifridge",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("chest_minifreezer")
    item:container_pocket { max_volume_ml = 99000, max_weight_milligrams = 300000000, rigid = true }
    content.add(item)
end

do
    -- TrueMFG T-19F-HC, scaled down to fit the size of vehicle parts (assumed to be 500L)
    -- original values: 686 * 623 * 1912 mm, 120 kg, gross capacity 417 L, 2066 kwh/annual
    -- scaled values: 578 * 525 * 1615 mm, 72 kg, gross capacity 250 L, 1238 kwh/annual
    local item = content.Item {
        id = "big_portable_freezer",
        name = ccb.content.plural_text("food truck freezer", "food truck freezers"),
        description = ccb.content.text("A heavy and bulky freezer with little wheels for easier transportation.  Has a bunch of sections and separators, which allow it to be installed in a vehicle with relative assurance that any items inside will stay put.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 72000000,
        volume_ml = 490000,
        longest_side_mm = 1615,
        price_cents = 330000,
        price_postapoc_cents = 1200,
        insulation = 7,
        copy_from = "minifridge",
        looks_like = "minifridge",
    }
    item:clear_use_actions()
    item:deploy_appliance("big_portable_freezer")
    content.add(item)
end

do
    -- Prodis Arctic AR350SS, 850 x 1030 x 750 mm, gross capacity 350L, 0.724 kwh/day, 30kwh
    local item = content.Item {
        id = "chest_freezer",
        name = ccb.content.plural_text("chest freezer", "chest freezers"),
        description = ccb.content.text("A hefty chest freezer, designed to store plenty of perishables for a minuscule amount of power.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 50000000,
        volume_ml = 656625,
        longest_side_mm = 1030,
        price_cents = 49900,
        price_postapoc_cents = 1500,
        insulation = 4,
        copy_from = "minifridge",
        looks_like = "minifridge",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("chest_freezer")
    item:container_pocket { max_volume_ml = 350000, max_weight_milligrams = 1100000000, rigid = true }
    content.add(item)
end

do
    -- Infrico AGN602BT, 850 x 1030 x 750 mm (because of technical limitations, 1000L instead of 1421L ), gross capacity 745 L, 3365 kwh/annum, 384 kwh
    local item = content.Item {
        id = "heavy_duty_freezer",
        name = ccb.content.plural_text("heavy-duty freezer", "heavy-duty freezers"),
        description = ccb.content.text("A heavy-duty upright freezer.  Big as a closet, heavy as a tank, can probably fit enough meat to feed a little colony for a week, but consumes power like no other.  Activate to deploy and connect to your electric grid."),
        mass_milligrams = 172000000,
        volume_ml = 1000000,
        longest_side_mm = 1030,
        price_cents = 459900,
        price_postapoc_cents = 1500,
        insulation = 4,
        copy_from = "minifridge",
        looks_like = "minifridge",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("heavy_duty_freezer")
    item:container_pocket { max_volume_ml = 745000, max_weight_milligrams = 2500000000, rigid = true }
    content.add(item)
end

do
    -- Tefcold UF400VG, 1855 x 600 x 585 mm, net capacity 400 L, 2664 kwh/annum, 304 kwh
    -- door should be approx 11 kilo of glass
    local item = content.Item {
        id = "glass_freezer",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("glass door freezer", "glass door freezers"),
        description = ccb.content.text("A disconnected commercial freezer with a glass door, used to present different frozen goods.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 1855,
        insulation = 9,
        volume_ml = 651105,
        mass_milligrams = 80000000,
        price_cents = 71000,
        price_postapoc_cents = 500,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("glass_freezer")
    item:material("steel", 7)
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 400000, max_weight_milligrams = 1200000000, rigid = true }
    content.add(item)
end

do
    -- Blizzard BDF32, 850 x 1030 x 680 mm, net capacity 320 L, 198 kwh/annum, 23 kwh
    local item = content.Item {
        id = "display_freezer",
        looks_like = "fridge",
        symbol = "F",
        color = "light_blue",
        name = ccb.content.plural_text("display freezer", "display freezers"),
        description = ccb.content.text("A disconnected commercial chest freezer with a glass lid.  Activate to deploy and connect to your electric grid."),
        longest_side_mm = 1855,
        insulation = 9,
        volume_ml = 595340,
        mass_milligrams = 60500000,
        price_cents = 83300,
        price_postapoc_cents = 1500,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:deploy_appliance("display_freezer")
    item:material("steel", 7)
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 320000, max_weight_milligrams = 1000000000, rigid = true }
    content.add(item)
end
