local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bag_paper_powder_50lb",
        category = "container",
        name = ccb.content.plural_text("50lb powder paper bag", "50lb powder paper bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A very large paper bag, for bulk storage and transport of powdered goods."),
        ascii_picture = "bag_paper_powder",
        mass_milligrams = 40000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:clear_flags()
    item:flag("TARDIS")
    item:container_pocket { max_volume_ml = 50000, max_weight_milligrams = 25000000, magazine_well_ml = 1000, moves = 200 }
    item:material("paper", 1)
    content.add(item)
end

do
    -- Assumption that you're wrapping it around your hand to use it as a weapon. The weight might do something to make it more damaging I guess?
    local item = content.Item {
        id = "heavy_punching_bag_sack",
        category = "container",
        name = ccb.content.plural_text("heavy punching bag sack", "heavy punching bag sacks"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A five-foot-long cylindrical leather sack, a foot in diameter, with attachment points at the top.  With some bags of sand, some chains, and a bunch of blankets, you could hang it from the ceiling as a heavy punching bag."),
        ascii_picture = "heavy_punching_bag_sack",
        mass_milligrams = 2400000,
        volume_ml = 12260,
        longest_side_mm = 1500,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        replace_pockets = true,
        color = "dark_gray",
    }
    item:material("leather", 1)
    item:container_pocket {
        max_volume_ml = 110000,
        max_weight_milligrams = 100000000,
        magazine_well_ml = 10000,
        max_item_length_mm = 1500,
        moves = 400,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- Calculated as a cylinder of 2.9in diameter and 10in height, to account for it getting thinner near the top.
    -- Based on https://www.amazon.com/dp/B09K2VQLZV
    local item = content.Item {
        id = "bottle_glass",
        category = "container",
        name = ccb.content.plural_text("glass bottle", "glass bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A watertight glass bottle, holds 750 mL of liquid."),
        ascii_picture = "bottle_glass",
        mass_milligrams = 511000,
        volume_ml = 1082,
        longest_side_mm = 290,
        price_cents = 200,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ")",
        color = "cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_glass_330ml",
        copy_from = "bottle_glass",
        looks_like = "bottle_glass",
        category = "container",
        name = ccb.content.plural_text("small glass bottle", "small glass bottles"),
        description = ccb.content.text("A watertight glass bottle, holds 330 mL of liquid."),
        longest_side_mm = 220,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 330,
        max_weight_milligrams = 1300000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:adjust_measurements { volume_ml = { factor = 0.44 }, mass_milligrams = { factor = 0.44 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic bottle", "plastic bottles"),
        description = ccb.content.text("A watertight plastic bottle, holds 500 mL of liquid.  Some may be factory-sealed to increase shelf life."),
        ascii_picture = "bottle_plastic",
        mass_milligrams = 13000,
        volume_ml = 510,
        longest_side_mm = 220,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1250000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        sealed_spoil_multiplier = 0.5,
        moves = 400,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_355ml",
        copy_from = "bottle_plastic",
        looks_like = "bottle_plastic",
        category = "container",
        name = ccb.content.plural_text("small plastic bottle", "small plastic bottles"),
        description = ccb.content.text("A watertight plastic bottle, holds 355 mL of liquid.  Some may be factory-sealed to increase shelf life."),
        longest_side_mm = 180,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 355,
        max_weight_milligrams = 875000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        sealed_spoil_multiplier = 0.5,
        moves = 400,
    }
    item:adjust_measurements { volume_ml = { factor = 0.7 }, mass_milligrams = { factor = 0.7 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "can_drink",
        category = "container",
        name = ccb.content.plural_text("aluminum can", "aluminum cans"),
        description = ccb.content.text("An aluminum can, like what soda comes in."),
        ascii_picture = "can_drink",
        mass_milligrams = 11000,
        volume_ml = 416,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "light_blue",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 355,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
        max_item_volume_ml = 10,
        sealed_spoil_multiplier = 0.0,
    }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    content.add(item)
end

do
    local item = content.Item {
        id = "can_aluminum_250ml",
        copy_from = "can_drink",
        looks_like = "can_drink",
        category = "container",
        name = ccb.content.plural_text("small aluminum can", "small aluminum cans"),
        description = ccb.content.text("A small aluminum can, like what soda comes in."),
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
        max_item_volume_ml = 10,
        sealed_spoil_multiplier = 0.0,
    }
    item:adjust_measurements { volume_ml = { factor = 0.7 }, mass_milligrams = { factor = 0.7 } }
    content.add(item)
end

do
    -- Calculated to keep shelf stable milk fresh for 304 days when sealed
    local item = content.Item {
        id = "carton_sealed",
        category = "container",
        name = ccb.content.plural_text("half gallon carton", "half gallon cartons"),
        looks_like = "box_small",
        description = ccb.content.text("A half-gallon carton constructed of a paper, aluminum, and plastic laminate.  It has a threaded cap to keep liquid from leaking out."),
        ascii_picture = "carton_sealed",
        mass_milligrams = 28000,
        volume_ml = 2003,
        longest_side_mm = 130,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("paper", 75)
    item:material("plastic", 20)
    item:material("aluminum", 5)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 5000000,
        rigid = true,
        watertight = true,
        sealed_spoil_multiplier = 0.023,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "carton_946ml",
        copy_from = "carton_sealed",
        looks_like = "carton_sealed",
        category = "container",
        name = ccb.content.plural_text("quart carton", "quart cartons"),
        description = ccb.content.text("A quart carton constructed of a paper, aluminum, and plastic laminate.  It has a threaded cap to keep liquid from leaking out."),
        mass_milligrams = 14000,
        volume_ml = 974,
        longest_side_mm = 190,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 946,
        max_weight_milligrams = 2500000,
        rigid = true,
        watertight = true,
        sealed_spoil_multiplier = 0.023,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "carton_284ml",
        copy_from = "carton_946ml",
        looks_like = "carton_946ml",
        category = "container",
        name = ccb.content.plural_text("half pint carton", "half pint cartons"),
        description = ccb.content.text("A half pint carton constructed of a paper, aluminum, and plastic laminate.  It has a threaded cap to keep liquid from leaking out."),
        longest_side_mm = 70,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 284,
        max_weight_milligrams = 625000,
        rigid = true,
        watertight = true,
        sealed_spoil_multiplier = 0.023,
    }
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "carton_egg",
        category = "container",
        name = ccb.content.plural_text("egg carton", "egg cartons"),
        looks_like = "box_small",
        description = ccb.content.text("A cardboard container with individual cavities for storing eggs."),
        ascii_picture = "carton_egg",
        mass_milligrams = 28000,
        volume_ml = 620,
        longest_side_mm = 290,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 600, max_weight_milligrams = 1000000, rigid = true, max_item_length_mm = 45 }
    content.add(item)
end

do
    local item = content.Item {
        id = "carton_egg_6",
        copy_from = "carton_egg",
        looks_like = "carton_egg",
        category = "container",
        name = ccb.content.plural_text("small egg carton", "small egg cartons"),
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 300, max_weight_milligrams = 500000, rigid = true, max_item_length_mm = 45 }
    item:adjust_measurements { longest_side_mm = { factor = 0.5 }, volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "test_tube_micro",
        category = "container",
        name = ccb.content.plural_text("microcentrifuge tube", "microcentrifuge tubes"),
        looks_like = "test_tube",
        description = ccb.content.text("A plastic tube with a little built in snap-cap, a great way to store a tiny amount of liquid.  Great for Jell-O shots if 1 mL is enough of a shot for you.  Cool people call these \"eppies\"."),
        ascii_picture = "test_tube_micro",
        mass_milligrams = 1000,
        volume_ml = 2,
        price_cents = 10,
        price_postapoc_cents = 5,
        symbol = "v",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 1, max_weight_milligrams = 5000, rigid = true, watertight = true, transparent = true }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    -- Calculated as a cylinder of 6in diameter and 9.5in height, to account for it getting thinner near the top.
    -- Based on https://www.amazon.com/dp/B07GC1VJ9T
    local item = content.Item {
        id = "jug_plastic",
        category = "container",
        name = ccb.content.plural_text("gallon jug", "gallon jugs"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A standard plastic jug used for milk and household cleaning chemicals.  Some may be factory-sealed to increase shelf life."),
        ascii_picture = "jug_plastic",
        mass_milligrams = 160000,
        volume_ml = 4402,
        longest_side_mm = 280,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 3750,
        max_weight_milligrams = 8000000,
        rigid = true,
        watertight = true,
        transparent = true,
        max_item_volume_ml = 32,
        sealed_spoil_multiplier = 0.5,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "jug_plastic_1892ml",
        copy_from = "jug_plastic",
        looks_like = "jug_plastic",
        category = "container",
        name = ccb.content.plural_text("half gallon jug", "half gallon jugs"),
        description = ccb.content.text("A half gallon plastic jug used for milk and household cleaning chemicals.  Some may be factory-sealed to increase shelf life."),
        longest_side_mm = 250,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 1892,
        max_weight_milligrams = 4000000,
        rigid = true,
        watertight = true,
        transparent = true,
        max_item_volume_ml = 32,
        sealed_spoil_multiplier = 0.5,
    }
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "bucket",
        category = "container",
        name = ccb.content.plural_text("bucket", "buckets"),
        description = ccb.content.text("A galvanized bucket for peanuts, chilled wine, iced beer, lobster, crab legs, French fries, animal feed, farm use, tailgating, crafts, planting flowers, holding gift baskets, containing a fruit basket and herbs, loose item storage, or as an ice bucket."),
        ascii_picture = "bucket",
        mass_milligrams = 725000,
        volume_ml = 5500,
        longest_side_mm = 250,
        price_cents = 300,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 5000,
        max_weight_milligrams = 20000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pressurized_canister",
        category = "tool_magazine",
        name = ccb.content.plural_text("pressurized canister", "pressurized canisters"),
        description = ccb.content.text("A small tank for containing pressurized gases."),
        mass_milligrams = 25000,
        volume_ml = 350,
        longest_side_mm = 120,
        price_cents = 2000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 250, max_weight_milligrams = 50000, airtight = true, watertight = true, rigid = true }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "small_biogas_tank",
        category = "container",
        name = ccb.content.plural_text("small biogas tank", "small biogas tanks"),
        description = ccb.content.text("A small tank of biogas, commonly used for camping stoves and torches."),
        copy_from = "small_propane_tank",
        looks_like = "small_propane_tank",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 5000,
        max_weight_milligrams = 1000000,
        airtight = true,
        rigid = true,
        allowed_items = { "biogas" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "medium_biogas_tank",
        category = "container",
        name = ccb.content.plural_text("medium biogas tank", "medium biogas tanks"),
        description = ccb.content.text("A medium-sized tank of biogas, commonly used for barbeques."),
        copy_from = "medium_propane_tank",
        looks_like = "medium_propane_tank",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 20000,
        max_weight_milligrams = 10000000,
        airtight = true,
        rigid = true,
        allowed_items = { "biogas" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "large_biogas_tank",
        category = "container",
        name = ccb.content.plural_text("large biogas tank", "large biogas tanks"),
        description = ccb.content.text("A large tank of biogas, commonly used for heating."),
        copy_from = "large_propane_tank",
        looks_like = "large_propane_tank",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 75000,
        max_weight_milligrams = 25000000,
        airtight = true,
        rigid = true,
        allowed_items = { "biogas" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_biogas_tank",
        category = "container",
        name = ccb.content.plural_text("extra large biogas tank", "extra large biogas tanks"),
        description = ccb.content.text("A massive tank of biogas, commonly used for heating a home or vehicle."),
        copy_from = "xl_propane_tank",
        looks_like = "xl_propane_tank",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 350000,
        max_weight_milligrams = 50000000,
        airtight = true,
        rigid = true,
        allowed_items = { "biogas" },
    }
    item:tool()
    content.add(item)
end

do
    -- 1 gallon tank, filled to 80% for safety.  1.3lbs while empty
    -- https://learnmetrics.com/propane-tank-sizes
    local item = content.Item {
        id = "small_propane_tank",
        category = "tool_magazine",
        name = ccb.content.plural_text("small propane tank", "small propane tanks"),
        description = ccb.content.text("A small tank of propane, commonly used for camping stoves and torches."),
        ascii_picture = "small_propane_tank",
        mass_milligrams = 591000,
        volume_ml = 5030,
        longest_side_mm = 300,
        price_cents = 2000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("GAS_TANK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { propane = 3000 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    -- 5 gallon tank, filled to 80% for safety..  About 15lbs while empty.
    -- https://learnmetrics.com/propane-tank-sizes
    local item = content.Item {
        id = "medium_propane_tank",
        category = "tool_magazine",
        name = ccb.content.plural_text("medium propane tank", "medium propane tanks"),
        description = ccb.content.text("A medium-sized tank of propane, commonly used for barbeques."),
        ascii_picture = "medium_propane_tank",
        mass_milligrams = 6720000,
        volume_ml = 23250,
        longest_side_mm = 500,
        price_cents = 2000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = ";",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("GAS_TANK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { propane = 15000 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    -- 20 gallon tank, filled to 80% for safety.  About 50 lbs while empty.
    -- https://learnmetrics.com/propane-tank-sizes
    local item = content.Item {
        id = "large_propane_tank",
        category = "tool_magazine",
        name = ccb.content.plural_text("large propane tank", "large propane tanks"),
        description = ccb.content.text("A large tank of propane, commonly used for heating."),
        ascii_picture = "large_propane_tank",
        mass_milligrams = 22727000,
        volume_ml = 80000,
        longest_side_mm = 1170,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("GAS_TANK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 11)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { propane = 60000 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end

do
    -- 100 gallon tank, filled to 80% for safety.  212 lbs while empty
    -- https://learnmetrics.com/propane-tank-sizes
    local item = content.Item {
        id = "xl_propane_tank",
        category = "tool_magazine",
        name = ccb.content.plural_text("extra large propane tank", "extra large propane tanks"),
        description = ccb.content.text("A massive tank of propane, commonly used for heating a home or vehicle."),
        ascii_picture = "xl_propane_tank",
        mass_milligrams = 96000000,
        volume_ml = 390000,
        longest_side_mm = 1220,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("GAS_TANK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { propane = 300000 }, airtight = true, watertight = true, rigid = true }
    content.add(item)
end
