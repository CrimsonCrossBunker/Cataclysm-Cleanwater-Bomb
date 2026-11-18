local ccb = require("ccb")
local content = ccb.content

do
    -- Calculated as a cylinder of 21.46in diameter (numbers from Amazon listing) and 5in height - the reason for such height is the brazier is 10.4in height with the legs set out, though with hypothetically legs pulled close to the base the height would be ~50% lower hence 5in.
    -- Based on https://www.amazon.com/dp/B0BQ6JNS2H
    local item = content.Item {
        id = "brazier",
        name = ccb.content.plural_text("brazier", "braziers"),
        description = ccb.content.text("A large metal stand used to contain a fire.  Fires set in a brazier will not spread to surrounding flammable objects."),
        mass_milligrams = 4459000,
        volume_ml = 30000,
        longest_side_mm = 550,
        price_cents = 7000,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_brazier")
    item:quality("COOK", 1)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_brazier",
        name = ccb.content.plural_text("makeshift brazier", "makeshift braziers"),
        description = ccb.content.text("A portable brazier fashioned from a steel bucket by punching small holes on the sides to improve the air supply.  It is too small to fit any fuel item larger than some splintered wood.  Fires set in this bucket will not spread to surrounding flammable objects."),
        copy_from = "bucket",
        looks_like = "bucket",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 5000,
        max_weight_milligrams = 20000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:clear_use_actions()
    item:deploy_furniture("f_makeshift_brazier")
    item:quality("COOK", 1)
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "portable_stove",
        symbol = "_",
        color = "light_gray",
        default_container = "nylon_bag",
        name = ccb.content.plural_text("portable stove", "portable stoves"),
        description = ccb.content.text("A foldable wood stove to safely lit fires while camping in the wilderness.  Activate it to deploy."),
        mass_milligrams = 2670000,
        volume_ml = 3000,
    }
    item:clear_use_actions()
    item:deploy_furniture("f_portable_stove")
    item:tool()
    content.add(item)
end

do
    -- values based on real world 55 gallon metal barrel
    local item = content.Item {
        id = "55gal_firebarrel",
        name = ccb.content.plural_text("fire barrel (200 L)", "fire barrels (200 L)"),
        description = ccb.content.text("A large metal barrel used to contain a fire.  It has multiple holes punched in its walls for air supply.  Fires set in a fire barrel will not spread to surrounding flammable objects."),
        mass_milligrams = 20000000,
        volume_ml = 200000,
        longest_side_mm = 1000,
        price_cents = 10000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        looks_like = "55gal_drum",
        symbol = "0",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_55gal_firebarrel")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    -- values based on real world 30 gal metal barrel
    local item = content.Item {
        id = "30gal_firebarrel",
        name = ccb.content.plural_text("fire barrel (100 L)", "fire barrels (100 L)"),
        description = ccb.content.text("A large metal barrel used to contain a fire.  It has multiple holes punched in its walls for air supply.  Fires set in a fire barrel will not spread to surrounding flammable objects."),
        mass_milligrams = 15000000,
        volume_ml = 100000,
        longest_side_mm = 850,
        price_cents = 5000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        looks_like = "30gal_drum",
        symbol = "0",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_30gal_firebarrel")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    -- values based on basic real world folding camp chair
    local item = content.Item {
        id = "camp_chair",
        name = ccb.content.plural_text("camp chair", "camp chairs"),
        description = ccb.content.text("A folded chair for camping.  Activate it to set it down for a place to sit."),
        mass_milligrams = 2200000,
        volume_ml = 15000,
        longest_side_mm = 900,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        looks_like = "rollmat",
        symbol = "#",
        color = "light_gray",
    }
    item:material("steel", 39)
    item:material("cotton", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_camp_chair")
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "deck_chair",
        name = ccb.content.plural_text("deck chair", "deck chairs"),
        description = ccb.content.text("Folded deck chair, deploy to sit down."),
        mass_milligrams = 6000000,
        volume_ml = 20000,
        longest_side_mm = 1200,
        price_cents = 7000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = "#",
        color = "brown",
    }
    item:material("wood", 9)
    item:material("cotton", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_deckchair")
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "chair_folding",
        name = ccb.content.plural_text("folding chair", "folding chairs"),
        description = ccb.content.text("Folded plastic chair on a metal frame, deploy to sit down."),
        mass_milligrams = 2900000,
        volume_ml = 5000,
        longest_side_mm = 880,
        price_cents = 2350,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = "#",
        color = "light_gray",
    }
    item:material("plastic", 6)
    item:material("steel", 4)
    item:clear_use_actions()
    item:deploy_furniture("f_chair_folding")
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_antenna",
        name = ccb.content.plural_text("deployable antenna", "deployable antennas"),
        description = ccb.content.text("A directional antenna and accompanying tripod, folded into a shape vaguely resembling an umbrella."),
        mass_milligrams = 3200000,
        volume_ml = 10000,
        longest_side_mm = 900,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        looks_like = "directional_antenna",
        symbol = "i",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_xedra_antenna")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_butcher_rack",
        name = ccb.content.plural_text("metal butchering rack", "metal butchering racks"),
        description = ccb.content.text("A metal butchering rack designed to hang a carcass in the air.  It is folded for easy transportation."),
        mass_milligrams = 5000000,
        volume_ml = 10000,
        longest_side_mm = 600,
        price_cents = 5000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = "=",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_metal_butcher_rack")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_smoking_rack",
        name = ccb.content.plural_text("metal smoking rack", "metal smoking racks"),
        description = ccb.content.text("A metal rack designed to smoke food for better preservation and taste.  It is folded for easy transportation.  As a deployable item, it's smaller than a stationary version."),
        mass_milligrams = 5000000,
        volume_ml = 25000,
        longest_side_mm = 900,
        price_cents = 5000,
        price_postapoc_cents = 750,
        melee_to_hit = -4,
        symbol = "=",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_metal_smoking_rack")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    -- values based on real world collapsible camping table
    local item = content.Item {
        id = "tourist_table",
        name = ccb.content.plural_text("folding table", "folding tables"),
        description = ccb.content.text("A metal folding table for off-road trips.  It is currently folded for easy transportation."),
        mass_milligrams = 4500000,
        volume_ml = 15000,
        longest_side_mm = 900,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = "=",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_tourist_table")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "leather_tarp",
        name = ccb.content.plural_text("leather tarp", "leather tarps"),
        description = ccb.content.text("A large sheet of leather.  You could use it as a picnic blanket, but it's more valuable as a surface for butchering as it does not soak up blood.  It's rolled and ready for carrying."),
        mass_milligrams = 2000000,
        volume_ml = 2500,
        price_cents = 5000,
        price_postapoc_cents = 500,
        replace_qualities = true,
        symbol = "*",
        color = "brown",
    }
    item:material("leather", 1)
    item:quality("SURFACE", 3)
    item:clear_use_actions()
    item:deploy_furniture("f_leather_tarp")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fiber_mat",
        name = ccb.content.plural_text("fiber mat", "fiber mats"),
        description = ccb.content.text("A large mat woven from fibrous material.  You could use it as a picnic blanket, but it's more valuable as a surface for butchering.  Too thin to be used as a comfortable sleeping mat.  It's rolled and ready for carrying."),
        mass_milligrams = 1000000,
        volume_ml = 2500,
        price_cents = 1000,
        price_postapoc_cents = 100,
        replace_qualities = true,
        symbol = "*",
        color = "yellow",
    }
    item:material("veggy", 1)
    item:quality("SURFACE", 3)
    item:clear_use_actions()
    item:deploy_furniture("f_fiber_mat")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "churn",
        name = ccb.content.plural_text("folded butter churn", "folded butter churns"),
        description = ccb.content.text("A large wooden container used to turn raw milk into butter and buttermilk.  This model uses a foot crank and holds three gallons of raw milk."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        melee_to_hit = -4,
        looks_like = "f_wood_keg",
        symbol = "u",
        color = "light_gray",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_butter_churn")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "water_mill",
        name = ccb.content.plural_text("water mill", "water mills"),
        description = ccb.content.text("A small water-powered mill that can convert starchy products into flour.  Needs to be placed via the construction menu."),
        mass_milligrams = 120000000,
        volume_ml = 22500,
        longest_side_mm = 1500,
        price_cents = 100000,
        price_postapoc_cents = 1500,
        symbol = "*",
        color = "red",
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wind_mill",
        name = ccb.content.plural_text("wind mill", "wind mills"),
        description = ccb.content.text("A small wind-powered mill that can convert starchy products into flour.  Needs to be placed via the construction menu."),
        mass_milligrams = 120000000,
        volume_ml = 22500,
        longest_side_mm = 1500,
        price_cents = 100000,
        price_postapoc_cents = 1500,
        symbol = "T",
        color = "red",
    }
    item:material("steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "screw_press_tool",
        name = ccb.content.plural_text("screw press", "screw presses"),
        description = ccb.content.text("A large screw press for manually pressing oil out of fruit or seed paste.  Needs to be placed via the construction menu."),
        mass_milligrams = 70000000,
        volume_ml = 100000,
        longest_side_mm = 2500,
        price_cents = 100000,
        price_postapoc_cents = 1500,
        symbol = "T",
        color = "red",
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    -- Based on the Beverly B-2 Throatless Shear, 10 gauge capacity - as was furniture - values based on real world Beverly B-2 Throatless Shear
    local item = content.Item {
        id = "beverly_shear",
        name = ccb.content.plural_text("Beverly shear", "Beverly shears"),
        description = ccb.content.text("A massive bench-mounted device with a short guillotine blade mounted to a long lever.  Designed for making straight or curved cuts through sheet metal up to 3 millimeters thick."),
        mass_milligrams = 15880000,
        volume_ml = 18000,
        longest_side_mm = 1000,
        price_cents = 10000,
        price_postapoc_cents = 1500,
        melee_to_hit = -3,
        symbol = "7",
        color = "yellow_red",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_beverly_shear")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    -- Based on the Redline TC500M Manual Tire Changer
    local item = content.Item {
        id = "manual_tire_changer",
        name = ccb.content.plural_text("manual tire changer", "manual tire changers"),
        description = ccb.content.text("A floor-mounted machine containing all the levers, clamps, and mounts required to remove or fit a tire, plus an integrated foot pump to inflate it."),
        mass_milligrams = 162000000,
        volume_ml = 100000,
        longest_side_mm = 1100,
        price_cents = 10000,
        price_postapoc_cents = 1500,
        symbol = "7",
        color = "yellow_red",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_manual_tire_changer")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "solar_cooker",
        name = ccb.content.plural_text("parabolic solar cooker", "parabolic solar cookers"),
        description = ccb.content.text("A portable faceted reflector dish on a tripod, made of shaped metal panels that concentrate sunlight into a focal point for cooking.  Requires some assembly to set up and only works outdoors in strong direct sunlight."),
        mass_milligrams = 14000000,
        volume_ml = 30000,
        longest_side_mm = 1200,
        price_cents = 8000,
        price_postapoc_cents = 200,
        symbol = ")",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("aluminum", 1)
    item:quality("COOK", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cot",
        name = ccb.content.plural_text("cot", "cots"),
        description = ccb.content.text("A military-style folding cot.  While it may not be quite as comfortable as a bed, it's better than slumming it on the ground."),
        mass_milligrams = 7500000,
        volume_ml = 15000,
        longest_side_mm = 1000,
        price_cents = 7500,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "green",
    }
    item:material("aluminum", 1)
    item:material("cotton", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_cot",
        moves = 1000,
        practice = 0,
        message = ccb.content.text("You unfold the cot and place it on the ground."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "target_spinner",
        name = ccb.content.plural_text("spinner target", "spinner targets"),
        description = ccb.content.text("Two steel plates mounted on a pipe in a double-sided oar design, installed in a sturdy frame with a rotating mechanism.  It spins when struck, eventually returning to vertical alignment due to one plate being heavier than the other.  You can use it for target practice when stationary targets become too easy."),
        mass_milligrams = 20000000,
        volume_ml = 10000,
        longest_side_mm = 1300,
        price_cents = 3500,
        price_postapoc_cents = 1000,
        symbol = "%",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_target_spinner",
        moves = 500,
        practice = 0,
        message = ccb.content.text("You set up the spinner target, time to shoot!"),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end
