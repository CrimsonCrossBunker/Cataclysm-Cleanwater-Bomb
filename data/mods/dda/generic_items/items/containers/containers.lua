local ccb = require("ccb")
local content = ccb.content

do
    -- Based on https://www.amazon.com/dp/B0025QI4XC
    local item = content.Item {
        id = "30gal_barrel",
        category = "container",
        name = ccb.content.plural_text("30 gallon plastic barrel", "30 gallon plastic barrels"),
        looks_like = "55gal_drum",
        description = ccb.content.text("A huge plastic barrel with a watertight lid."),
        ascii_picture = "30gal_barrel",
        mass_milligrams = 6800000,
        volume_ml = 165640,
        longest_side_mm = 720,
        price_cents = 7100,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "0",
        color = "light_blue",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 113560, max_weight_milligrams = 255000000, watertight = true, rigid = true }
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "30gal_drum",
        category = "container",
        looks_like = "30gal_barrel",
        name = ccb.content.plural_text("steel drum (100 L)", "steel drums (100 L)"),
        description = ccb.content.text("A huge steel barrel with a watertight lid."),
        ascii_picture = "30gal_drum",
        mass_milligrams = 7600000,
        volume_ml = 105000,
        price_cents = 8000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "0",
        color = "dark_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 100000, max_weight_milligrams = 500000000, watertight = true, rigid = true }
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "55gal_drum",
        category = "container",
        looks_like = "30gal_drum",
        name = ccb.content.plural_text("steel drum (200 L)", "steel drums (200 L)"),
        description = ccb.content.text("A massive steel barrel with a watertight lid."),
        ascii_picture = "55gal_drum",
        mass_milligrams = 20000000,
        volume_ml = 210000,
        price_cents = 10000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "0",
        color = "dark_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 1000000000, watertight = true, rigid = true }
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- woven polypropylene bags
    local item = content.Item {
        id = "bag_durasack",
        category = "container",
        name = ccb.content.plural_text("reusable plastic sack", "reusable plastic sacks"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A large and sturdy sack, made out of woven polypropylene.  Popular choice to store sand, gravel, cement, or stop some local flood."),
        mass_milligrams = 750000,
        volume_ml = 1250,
        price_cents = 85,
        price_postapoc_cents = 5,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 18000, max_weight_milligrams = 22000000, magazine_well_ml = 750, moves = 500 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_canvas",
        category = "container",
        name = ccb.content.plural_text("canvas sack", "canvas sacks"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A large and sturdy canvas sack.  Smells faintly of soil and hard work."),
        ascii_picture = "bag_canvas",
        mass_milligrams = 415000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:material("canvas", 1)
    item:container_pocket { max_volume_ml = 15000, max_weight_milligrams = 15000000, magazine_well_ml = 750, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_canvas_small",
        category = "container",
        name = ccb.content.plural_text("canvas bag", "canvas bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A small bag made of canvas.  Looks fine to store dried herbs in."),
        ascii_picture = "bag_canvas_small",
        mass_milligrams = 20000,
        volume_ml = 60,
        price_cents = 0,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:material("canvas", 1)
    item:container_pocket { max_volume_ml = 1000, max_weight_milligrams = 3000000, magazine_well_ml = 45, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic bag", "plastic bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("An open plastic bag.  Essentially trash."),
        mass_milligrams = 5000,
        volume_ml = 10,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 6000,
        max_weight_milligrams = 10000000,
        transparent = true,
        magazine_well_ml = 8,
        moves = 400,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_plastic_small",
        category = "container",
        name = ccb.content.plural_text("small plastic bag", "small plastic bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A small, open plastic bag.  Essentially trash."),
        mass_milligrams = 1000,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1250000,
        watertight = true,
        transparent = true,
        magazine_well_ml = 4,
        moves = 400,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "blister_pack",
        category = "container",
        name = ccb.content.plural_text("blister pack", "blister packs"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A blister pack is a sort of packaging that has a thick plastic case attached to a sheet of cardboard, allowing easy viewing of a product while keeping it protected.  Known for being an absolute pain to open."),
        mass_milligrams = 200000,
        volume_ml = 200,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("cardboard", 1)
    item:container_pocket {
        max_volume_ml = 10000,
        max_weight_milligrams = 10000000,
        transparent = true,
        max_item_length_mm = 1000,
        moves = 400,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_garbage",
        category = "container",
        name = ccb.content.plural_text("garbage bag", "garbage bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A hefty plastic bag, made to carry lots of trash.  It's sturdy and water-resistant; this could easily be repurposed."),
        ascii_picture = "bag_garbage",
        mass_milligrams = 40000,
        volume_ml = 42,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "dark_gray",
    }
    item:container_pocket { max_volume_ml = 110000, max_weight_milligrams = 10000000, moves = 400 }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nylon_bag",
        category = "container",
        name = ccb.content.plural_text("nylon bag", "nylon bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A square nylon bag designed to carry a folded portable stove."),
        ascii_picture = "nylon_bag",
        mass_milligrams = 280000,
        volume_ml = 2000,
        price_cents = 400,
        price_postapoc_cents = 100,
        replace_pockets = true,
        symbol = "u",
        color = "dark_gray",
    }
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 3000000,
        magazine_well_ml = 1000,
        max_item_length_mm = 220,
        moves = 200,
    }
    item:material("nylon", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_garbage_reinforced",
        name = ccb.content.plural_text("reinforced garbage bag", "reinforced garbage bags"),
        copy_from = "bag_garbage",
        looks_like = "bag_garbage",
        description = ccb.content.text("Ten garbage bags layered within each other to carry a heavier load."),
        ascii_picture = "bag_garbage_reinforced",
        mass_milligrams = 400000,
        volume_ml = 500,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 98000, max_weight_milligrams = 46000000, watertight = true, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_paper_powder",
        category = "container",
        name = ccb.content.plural_text("small powder paper bag", "small powder paper bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A small but sturdy paper bag.  Rock solid when packed full with powder."),
        ascii_picture = "bag_paper_powder",
        mass_milligrams = 5000,
        volume_ml = 20,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:container_pocket { max_volume_ml = 2500, max_weight_milligrams = 2000000, magazine_well_ml = 15, moves = 200 }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_paper_powder_bulk",
        category = "container",
        name = ccb.content.plural_text("large powder paper bag", "large powder paper bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A large paper bag, for bulk storage and transport of powdered goods."),
        ascii_picture = "bag_paper_powder",
        mass_milligrams = 20000,
        volume_ml = 60,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:container_pocket { max_volume_ml = 10000, max_weight_milligrams = 15000000, magazine_well_ml = 45, moves = 200 }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_zipper",
        category = "container",
        name = ccb.content.plural_text("zipper bag", "zipper bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A resealable, watertight transparent plastic bag roomy enough to hold a sandwich.  Known generically as a Ziploc bag, it can be sealed and opened with a press-together mechanism similar to a zipper."),
        ascii_picture = "bag_zipper",
        mass_milligrams = 2000,
        volume_ml = 20,
        price_cents = 0,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 750000,
        watertight = true,
        transparent = true,
        magazine_well_ml = 10,
        max_item_length_mm = 140,
        spoil_multiplier = 0.8,
        moves = 400,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_zipper_gallon",
        copy_from = "bag_zipper",
        looks_like = "bag_zipper",
        name = ccb.content.plural_text("gallon-sized zipper bag", "gallon-sized zipper bags"),
        description = ccb.content.text("A resealable, watertight transparent plastic bag, extra-large size.  Known generically as a Ziploc bag, it can be sealed and opened with a press-together mechanism similarly to a zipper."),
        ascii_picture = "bag_zipper_gallon",
        mass_milligrams = 20000,
        volume_ml = 75,
        price_postapoc_cents = 13,
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 4500,
        max_weight_milligrams = 5000000,
        watertight = true,
        transparent = true,
        magazine_well_ml = 50,
        max_item_length_mm = 290,
        spoil_multiplier = 0.8,
        moves = 600,
    }
    content.add(item)
end

do
    -- For reference was used Extrawheel Dry bag Sailor 80L
    -- Assumption that you're wrapping it around your hand to use it as a weapon. The weight might do something to make it more damaging I guess?
    local item = content.Item {
        id = "dry_bag_large",
        category = "container",
        name = ccb.content.plural_text("large dry bag", "large dry bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A huge watertight bag made of strong plastic.  Commonly used in activities with high risk of wetting the equipment, such as kayaking."),
        ascii_picture = "dry_bag_large",
        mass_milligrams = 1500000,
        volume_ml = 7500,
        longest_side_mm = 350,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        replace_pockets = true,
        color = "blue",
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 80000,
        max_weight_milligrams = 100000000,
        watertight = true,
        magazine_well_ml = 6000,
        max_item_length_mm = 1000,
        moves = 800,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- This is ~85% of the package volume from the amazon listing, with the assumption that the player would be squishing it harder to condense the volume.
    -- Based on https://www.amazon.com/dp/B0BYPB5DMW
    local item = content.Item {
        id = "bag_body_bag",
        category = "container",
        name = ccb.content.plural_text("body bag", "body bags"),
        looks_like = "bag_canvas",
        description = ccb.content.text("A human-sized rectangular bag made of strong plastic, with a zipper in the middle.  Intended to hold a dead body."),
        ascii_picture = "bag_body_bag",
        mass_milligrams = 1061000,
        volume_ml = 15000,
        price_cents = 3000,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ")",
        replace_pockets = true,
        color = "dark_gray",
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 100000,
        max_weight_milligrams = 100000000,
        magazine_well_ml = 10000,
        max_item_length_mm = 2000,
        moves = 400,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_iv",
        category = "container",
        name = ccb.content.plural_text("IV bag", "IV bags"),
        description = ccb.content.text("A small, sealed plastic bag for liquids used in intravenous therapy."),
        ascii_picture = "bag_iv",
        looks_like = "bag_plastic",
        mass_milligrams = 10000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 3000000,
        watertight = true,
        transparent = true,
        magazine_well_ml = 25,
        moves = 400,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_glue",
        copy_from = "bottle_plastic",
        looks_like = "bottle_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic glue bottle", "plastic glue bottles"),
        description = ccb.content.text("A watertight plastic bottle, holds 500 mL of glue.  Cannot be reused or refilled."),
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "condiment_bottle_sealed",
        category = "container",
        name = ccb.content.plural_text("condiment bottle", "condiment bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("An inverted plastic bottle for condiments.  Preserves its contents from rot until opened."),
        ascii_picture = "condiment_bottle_sealed",
        mass_milligrams = 19000,
        volume_ml = 525,
        longest_side_mm = 220,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        sealed_spoil_multiplier = 0.0,
        moves = 400,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_small",
        category = "container",
        name = ccb.content.plural_text("very small plastic bottle", "very small plastic bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A watertight plastic bottle, holds 250 mL of liquid."),
        ascii_picture = "bottle_plastic_small",
        mass_milligrams = 7000,
        volume_ml = 255,
        longest_side_mm = 140,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_small_glue",
        copy_from = "bottle_plastic_small",
        looks_like = "bottle_plastic_small",
        category = "container",
        name = ccb.content.plural_text("small plastic glue bottle", "small plastic glue bottles"),
        description = ccb.content.text("A watertight plastic bottle, holds 250 mL of glue.  Cannot be reused or refilled."),
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_tiny",
        category = "container",
        name = ccb.content.plural_text("tiny plastic bottle", "tiny plastic bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A watertight plastic bottle, holds 30 mL of liquid."),
        ascii_picture = "bottle_plastic_small",
        mass_milligrams = 2000,
        volume_ml = 35,
        longest_side_mm = 40,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -5,
        symbol = ")",
        color = "white",
    }
    item:container_pocket {
        max_volume_ml = 30,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 1,
        moves = 400,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_tiny_glue",
        copy_from = "bottle_plastic_tiny",
        looks_like = "bottle_plastic_tiny",
        name = ccb.content.plural_text("tiny plastic glue bottle", "tiny plastic glue bottles"),
        description = ccb.content.text("A watertight plastic bottle, holds 30 mL of glue.  Cannot be reused or refilled."),
        longest_side_mm = 120,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "small_squeeze_tube",
        category = "container",
        name = ccb.content.plural_text("small glue squeeze tube", "small glue squeeze tubes"),
        description = ccb.content.text("A small squeeze tube, holds 4 mL of glue.  Cannot be reused or refilled."),
        ascii_picture = "bottle_plastic_small",
        mass_milligrams = 2000,
        volume_ml = 11,
        longest_side_mm = 30,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -5,
        symbol = ")",
        color = "white",
    }
    item:container_pocket {
        max_volume_ml = 4,
        max_weight_milligrams = 50000,
        watertight = true,
        rigid = true,
        max_item_volume_ml = 4,
        moves = 400,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_pill_prescription",
        category = "container",
        name = ccb.content.plural_text("plastic prescription bottle", "plastic prescription bottles"),
        looks_like = "antibiotics",
        description = ccb.content.text("A small orange pill bottle with a white screw top."),
        ascii_picture = "bottle_plastic_pill_prescription",
        mass_milligrams = 7000,
        volume_ml = 251,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_pill_painkiller",
        copy_from = "bottle_plastic_pill_prescription",
        name = ccb.content.plural_text("plastic painkiller bottle", "plastic painkiller bottles"),
        looks_like = "aspirin",
        description = ccb.content.text("A small white pill bottle with a screw top."),
        ascii_picture = "bottle_plastic_pill_painkiller",
        color = "white",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_pill_supplement",
        copy_from = "bottle_plastic_pill_prescription",
        name = ccb.content.plural_text("plastic supplement bottle", "plastic supplement bottles"),
        looks_like = "vitamins",
        description = ccb.content.text("A small green pill bottle with a screw top."),
        ascii_picture = "bottle_plastic_pill_supplement",
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_seasoning",
        category = "container",
        name = ccb.content.plural_text("plastic seasoning bottle", "plastic seasoning bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A 500 mL plastic bottle, for storing large amounts of powder seasoning."),
        ascii_picture = "bottle_plastic_seasoning",
        mass_milligrams = 13000,
        volume_ml = 510,
        longest_side_mm = 180,
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
        max_item_volume_ml = 64,
        sealed_spoil_multiplier = 0.5,
        moves = 200,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_plastic_seasoning_small",
        category = "container",
        name = ccb.content.plural_text("small plastic seasoning bottle", "small plastic seasoning bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A small plastic bottle, the kind seasoning comes in."),
        ascii_picture = "bottle_plastic_seasoning",
        mass_milligrams = 7000,
        volume_ml = 255,
        longest_side_mm = 140,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 32,
        sealed_spoil_multiplier = 0.5,
        moves = 200,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_glass_seasoning",
        category = "container",
        name = ccb.content.plural_text("glass seasoning bottle", "glass seasoning bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A 500 mL glass bottle, for storing large amounts of powder seasoning."),
        mass_milligrams = 450000,
        volume_ml = 510,
        longest_side_mm = 180,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        color = "light_cyan",
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1250000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 64,
        sealed_spoil_multiplier = 0.5,
        moves = 400,
    }
    item:material("glass", 1)
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_glass_seasoning_small",
        category = "container",
        name = ccb.content.plural_text("small glass seasoning bottle", "small glass seasoning bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A small glass bottle, the kind seasoning comes in."),
        mass_milligrams = 150000,
        volume_ml = 251,
        longest_side_mm = 72,
        price_cents = 500,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 32,
        moves = 200,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_liter",
        category = "container",
        name = ccb.content.plural_text("medium plastic bottle", "medium plastic bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("32 oz, or roughly 1-liter plastic bottle that can hold variety of liquids."),
        mass_milligrams = 25000,
        volume_ml = 1188,
        longest_side_mm = 250,
        price_cents = 15,
        price_postapoc_cents = 1,
        symbol = ")",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 5000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_twoliter",
        category = "container",
        name = ccb.content.plural_text("large plastic bottle", "large plastic bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A two-liter plastic bottle that can hold a lot of soda, or, nowadays, boiled water."),
        ascii_picture = "bottle_twoliter",
        mass_milligrams = 53000,
        volume_ml = 2040,
        longest_side_mm = 310,
        price_cents = 25,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        transparent = true,
        max_item_volume_ml = 17,
        moves = 400,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_twoliter_glue",
        copy_from = "bottle_twoliter",
        category = "container",
        name = ccb.content.plural_text("large plastic glue bottle", "large plastic glue bottles"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A two-liter plastic bottle that can hold 2 L of glue.  Cannot be reused or refilled."),
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_clay",
        category = "container",
        name = ccb.content.plural_text("clay bowl", "clay bowls"),
        looks_like = "bowl_plastic",
        description = ccb.content.text("A clay bowl with a waterproofed hide lid.  Can be used as a container or as a tool.  Holds 250 mL of liquid."),
        ascii_picture = "bowl_clay",
        mass_milligrams = 60000,
        volume_ml = 295,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 250, max_weight_milligrams = 3000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_wood",
        category = "container",
        name = ccb.content.plural_text("wooden bowl", "wooden bowls"),
        looks_like = "bowl_plastic",
        description = ccb.content.text("A crude-looking wooden bowl which can hold some liquid."),
        ascii_picture = "bowl_wood",
        mass_milligrams = 48000,
        volume_ml = 300,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_wood_large",
        category = "container",
        name = ccb.content.plural_text("large wooden bowl", "large wooden bowls"),
        looks_like = "bowl_plastic",
        description = ccb.content.text("A large crude-looking wooden bowl which holds liquid."),
        ascii_picture = "bowl_wood",
        mass_milligrams = 88000,
        volume_ml = 550,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_coconut",
        category = "container",
        name = ccb.content.plural_text("coconut bowl", "coconut bowls"),
        looks_like = "bowl_wood",
        description = ccb.content.text("A single half of a coconut with the meat removed.  Usable as a bowl to hold some liquid."),
        ascii_picture = "bowl_coconut",
        mass_milligrams = 55000,
        volume_ml = 300,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bowl_skull",
        category = "container",
        name = ccb.content.plural_text("skull bowl", "skull bowls"),
        looks_like = "bowl_plastic",
        description = ccb.content.text("A macabre-looking bowl made from the upper part of a skull."),
        ascii_picture = "bowl_skull",
        mass_milligrams = 112000,
        volume_ml = 520,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("bone", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 3000000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "box_cigarette",
        category = "container",
        name = ccb.content.plural_text("cigarette pack", "cigarette packs"),
        looks_like = "box_small",
        description = ccb.content.text("SURGEON GENERAL'S WARNING: Smoking Causes Lung Cancer, Heart Disease, Emphysema, And May Complicate Pregnancy."),
        ascii_picture = "box_cigarette",
        mass_milligrams = 15000,
        volume_ml = 95,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
        replace_pockets = true,
    }
    item:material("paper", 1)
    item:container_pocket { max_volume_ml = 90, max_weight_milligrams = 3000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "case_cigar",
        category = "container",
        name = ccb.content.plural_text("cigar case", "cigar cases"),
        looks_like = "box_small",
        description = ccb.content.text("A small handmade wood and leather case meant to hold one or two cigars."),
        ascii_picture = "case_cigar",
        mass_milligrams = 95000,
        volume_ml = 323,
        price_cents = 10000,
        price_postapoc_cents = 50,
        symbol = "u",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:material("leather", 1)
    item:container_pocket { max_volume_ml = 145, max_weight_milligrams = 1000000, rigid = true, max_item_length_mm = 160 }
    content.add(item)
end

do
    local item = content.Item {
        id = "box_snack",
        category = "container",
        name = ccb.content.plural_text("snack cardboard box", "snack cardboard boxes"),
        description = ccb.content.text("A small cardboard box for housing snacks.  Sized so you can take it on the go."),
        ascii_picture = "box_snack",
        mass_milligrams = 12000,
        volume_ml = 550,
        longest_side_mm = 120,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 540, max_weight_milligrams = 800000, rigid = true, max_item_length_mm = 110 }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- ~1x27x30 or ~1x26x44
    local item = content.Item {
        id = "box_small_folded",
        category = "container",
        name = ccb.content.plural_text("small folded cardboard box", "small folded cardboard boxes"),
        description = ccb.content.text("A small folded cardboard box.  No bigger than a foot in dimension.  Can be assembled."),
        ascii_picture = "box_small_folded",
        mass_milligrams = 50000,
        volume_ml = 900,
        longest_side_mm = 300,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
    }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- (1x80x75)
    local item = content.Item {
        id = "box_medium_folded",
        category = "container",
        name = ccb.content.plural_text("folded cardboard box", "folded cardboard boxes"),
        description = ccb.content.text("A sturdy folded cardboard box.  Great for packing.  Can be assembled."),
        ascii_picture = "box_medium_folded",
        mass_milligrams = 400000,
        volume_ml = 6000,
        longest_side_mm = 800,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
    }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- (1x150x120)
    local item = content.Item {
        id = "box_large_folded",
        category = "container",
        name = ccb.content.plural_text("large folded cardboard box", "large folded cardboard boxes"),
        description = ccb.content.text("A very large folded cardboard box, the sort children would have loved to hide in, when there were still children.  Can be assembled."),
        ascii_picture = "box_large_folded",
        mass_milligrams = 2000000,
        volume_ml = 18000,
        longest_side_mm = 1500,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
    }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- A box that children could hide in should be big enough to cram a (un)dead child or uncomfortable adult in (90x60x60)
    local item = content.Item {
        id = "box_large_reinforced",
        category = "container",
        name = ccb.content.plural_text("reinforced large cardboard box", "reinforced large cardboard boxes"),
        looks_like = "box_large",
        description = ccb.content.text("A very large cardboard box, doubled up with a second layer of cardboard and lots of duct tape.  It can't be folded anymore."),
        ascii_picture = "box_large_reinforced",
        mass_milligrams = 4000000,
        volume_ml = 334000,
        longest_side_mm = 910,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 324000, max_weight_milligrams = 100000000, rigid = true, max_item_length_mm = 900 }
    item:clear_use_actions()
    item:deploy_furniture("f_cardboard_box_large_reinforced")
    content.add(item)
end

do
    -- (220x100x1)
    local item = content.Item {
        id = "box_oversize_folded",
        category = "container",
        name = ccb.content.plural_text("oversize folded cardboard box", "oversize folded cardboard boxes"),
        description = ccb.content.text("An oversize cardboard box, big enough to fit some longer items.  Great for storage.  Can be assembled."),
        ascii_picture = "box_oversize_folded",
        mass_milligrams = 2000000,
        volume_ml = 22000,
        longest_side_mm = 2200,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
    }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- (200x50x20)
    local item = content.Item {
        id = "box_oversize_reinforced",
        category = "container",
        name = ccb.content.plural_text("reinforced oversize cardboard box", "reinforced oversize cardboard boxes"),
        looks_like = "box_small",
        description = ccb.content.text("An oversize cardboard box, doubled up with a second layer of cardboard and lots of duct tape.  It can't be folded anymore."),
        ascii_picture = "box_oversize",
        mass_milligrams = 4002000,
        volume_ml = 205000,
        longest_side_mm = 2010,
        price_cents = 1000,
        price_postapoc_cents = 20,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 100000000, rigid = true, max_item_length_mm = 2000 }
    item:material("cardboard", 1)
    content.add(item)
end

do
    -- Roughly based on https://www.amazon.ca/Boxes-Fast-BF14442FOL-Corrugated-Cardboard/dp/B077BZHDYF
    local item = content.Item {
        id = "box_longarm",
        category = "container",
        name = ccb.content.plural_text("longarm cardboard box", "longarm cardboard boxes"),
        looks_like = "box_small",
        description = ccb.content.text("An elongated cardboard box, meant to contain a longarm such as a shotgun or rifle."),
        ascii_picture = "box_oversize",
        mass_milligrams = 600000,
        volume_ml = 40000,
        longest_side_mm = 1350,
        price_cents = 1000,
        price_postapoc_cents = 20,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 38000, max_weight_milligrams = 30000000, rigid = true, max_item_length_mm = 1300 }
    item:material("cardboard", 1)
    item:variants {
        { id = "box_longarm_rifle", name = ccb.content.plural_text("rifle box", "rifle boxes"), description = ccb.content.text("Judging by the print on the packaging, this one is meant for a rifle."), append = true },
        { id = "box_longarm_shotgun", name = ccb.content.plural_text("shotgun box", "shotgun boxes"), description = ccb.content.text("Judging by the print on the packaging, this one is meant for a shotgun."), append = true },
        { id = "box_longarm_handgun", name = ccb.content.plural_text("large handgun box", "large handgun boxes"), description = ccb.content.text("Despite the size of the box, this one seems to be intended for an oversized handgun."), append = true },
    }
    content.add(item)
end

do
    -- Based on https://www.pelican.com/ca/en/product/cases/medium-pistol-case/vault/v200/
    local item = content.Item {
        id = "box_pistol",
        name = ccb.content.plural_text("handgun case", "handgun cases"),
        description = ccb.content.text("A hard plastic case with a foam interior, meant to store handguns along with any extra accessories."),
        mass_milligrams = 2300000,
        volume_ml = 15750,
        longest_side_mm = 516,
        price_cents = 10000,
        price_postapoc_cents = 50,
        symbol = "[",
        looks_like = "briefcase",
        color = "light_gray",
        replace_pockets = true,
        melee_to_hit = -2,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 13000,
        max_weight_milligrams = 30000000,
        rigid = true,
        max_item_length_mm = 437,
        moves = 200,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "box_compact_wood",
        name = ccb.content.plural_text("tiny wooden box", "tiny wooden boxes"),
        copy_from = "box_small_wood",
        looks_like = "box_small_wood",
        description = ccb.content.text("A small wooden box with a cap and two small handles."),
        ascii_picture = "box_compact_wood",
        mass_milligrams = 200000,
        volume_ml = 6000,
        longest_side_mm = 220,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 4000, max_weight_milligrams = 80000000, rigid = true }
    content.add(item)
end

do
    -- ~7x20x15 or ~4x22x22
    local item = content.Item {
        id = "box_small_wood",
        category = "container",
        name = ccb.content.plural_text("small wooden box", "small wooden boxes"),
        description = ccb.content.text("A small wooden box.  Beautifully made, perhaps it could hold something precious."),
        ascii_picture = "box_small_wood",
        mass_milligrams = 650000,
        volume_ml = 3200,
        longest_side_mm = 220,
        replace_pockets = true,
        price_cents = 2000,
        price_postapoc_cents = 5,
        symbol = "[",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 2100, max_weight_milligrams = 40000000, rigid = true, max_item_length_mm = 200 }
    item:material("wood", 1)
    content.add(item)
end

do
    -- (25x40x50)
    local item = content.Item {
        id = "box_medium_wood",
        category = "container",
        name = ccb.content.plural_text("wooden box", "wooden boxes"),
        looks_like = "box_small_wood",
        description = ccb.content.text("A hefty wooden box.  Great for storing items."),
        ascii_picture = "box_medium_wood",
        mass_milligrams = 5200000,
        volume_ml = 58800,
        longest_side_mm = 520,
        price_cents = 2000,
        price_postapoc_cents = 20,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 50000, max_weight_milligrams = 100000000, rigid = true, max_item_length_mm = 500 }
    item:material("wood", 1)
    content.add(item)
end

do
    -- (60x60x90)
    local item = content.Item {
        id = "box_large_wood",
        category = "container",
        name = ccb.content.plural_text("large wooden box", "large wooden boxes"),
        looks_like = "box_small_wood",
        description = ccb.content.text("A large wooden crate.  Sturdy, but still light enough to be moved."),
        ascii_picture = "box_large_wood",
        mass_milligrams = 41600000,
        volume_ml = 394400,
        longest_side_mm = 920,
        price_cents = 5000,
        price_postapoc_cents = 40,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 324000, max_weight_milligrams = 250000000, rigid = true, max_item_length_mm = 900 }
    item:material("wood", 1)
    content.add(item)
end

do
    -- (200x50x20)
    local item = content.Item {
        id = "box_oversize_wood",
        category = "container",
        name = ccb.content.plural_text("oversize wooden box", "oversize wooden boxes"),
        looks_like = "box_small_wood",
        description = ccb.content.text("An oversize wooden box, big enough to fit some longer items.  Great for storage."),
        ascii_picture = "box_oversize_wood",
        mass_milligrams = 34400000,
        volume_ml = 255600,
        longest_side_mm = 2020,
        price_cents = 5000,
        price_postapoc_cents = 40,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 250000000, rigid = true, max_item_length_mm = 2000 }
    item:material("wood", 1)
    content.add(item)
end

do
    -- ~7x20x15 or ~4x22x22
    local item = content.Item {
        id = "box_small_metal",
        category = "container",
        name = ccb.content.plural_text("small metal box", "small metal boxes"),
        description = ccb.content.text("A small metal box.  It could hold even the densest of items."),
        ascii_picture = "box_small_metal",
        mass_milligrams = 750000,
        volume_ml = 2196,
        longest_side_mm = 210,
        replace_pockets = true,
        price_cents = 3000,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket { max_volume_ml = 2100, max_weight_milligrams = 80000000, rigid = true, max_item_length_mm = 200 }
    item:material("steel", 1)
    content.add(item)
end

do
    -- (25x40x50)
    local item = content.Item {
        id = "box_medium_metal",
        category = "container",
        name = ccb.content.plural_text("metal box", "metal boxes"),
        looks_like = "box_small_metal",
        description = ccb.content.text("A strong metal box.  Great for packing your heaviest items."),
        ascii_picture = "box_medium_metal",
        mass_milligrams = 6000000,
        volume_ml = 50750,
        longest_side_mm = 510,
        price_cents = 8000,
        price_postapoc_cents = 40,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket { max_volume_ml = 50000, max_weight_milligrams = 200000000, rigid = true, max_item_length_mm = 500 }
    item:material("steel", 1)
    content.add(item)
end

do
    -- (60x60x90)
    local item = content.Item {
        id = "box_large_metal",
        category = "container",
        name = ccb.content.plural_text("large metal box", "large metal boxes"),
        looks_like = "box_small_metal",
        description = ccb.content.text("A large metal box.  It's big and strong enough to hold just about anything."),
        ascii_picture = "box_large_metal",
        mass_milligrams = 48000000,
        volume_ml = 330000,
        longest_side_mm = 910,
        price_cents = 16000,
        price_postapoc_cents = 80,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket { max_volume_ml = 324000, max_weight_milligrams = 500000000, rigid = true, max_item_length_mm = 900 }
    item:material("steel", 1)
    content.add(item)
end

do
    -- (200x50x20)
    local item = content.Item {
        id = "box_oversize_metal",
        category = "container",
        name = ccb.content.plural_text("oversize metal box", "oversize metal boxes"),
        looks_like = "box_small_metal",
        description = ccb.content.text("An oversize metal box, big enough to fit some longer items.  The slim profile makes storage a little bit easier."),
        ascii_picture = "box_oversize_metal",
        mass_milligrams = 48000000,
        volume_ml = 206000,
        longest_side_mm = 2010,
        price_cents = 16000,
        price_postapoc_cents = 80,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 500000000, rigid = true, max_item_length_mm = 2000 }
    item:material("steel", 1)
    content.add(item)
end

do
    -- https://www.homedepot.com/p/The-Home-Depot-5-Gallon-Orange-Homer-Bucket-05GLHD2/100087613
    local item = content.Item {
        id = "bucket_5gal",
        category = "container",
        name = ccb.content.plural_text("large plastic bucket", "large plastic buckets"),
        description = ccb.content.text("A bright orange plastic bucket about the size of your torso."),
        mass_milligrams = 815000,
        volume_ml = 26300,
        longest_side_mm = 370,
        price_cents = 450,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 20000,
        max_weight_milligrams = 40000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bucket_wood",
        category = "container",
        name = ccb.content.plural_text("wooden bucket", "wooden buckets"),
        description = ccb.content.text("A wooden bucket.  Carefully chiseled out of a hardwood log section, almost like a dugout canoe.  Holds 5 liters of water and has a wooden carrying handle."),
        ascii_picture = "bucket_wood",
        mass_milligrams = 1250000,
        volume_ml = 7500,
        price_cents = 300,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "c_brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 5000,
        max_weight_milligrams = 20000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "carton_milk",
        copy_from = "carton_sealed",
        looks_like = "carton_sealed",
        category = "container",
        name = ccb.content.plural_text("half gallon paper carton", "half gallon paper cartons"),
        description = ccb.content.text("A half-gallon carton constructed of thick, waterproof paper.  It has a threaded cap to keep the contents from leaking out."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_bag_vac",
        category = "container",
        name = ccb.content.plural_text("vacuum-packed bag", "vacuum-packed bags"),
        looks_like = "bag_plastic",
        description = ccb.content.text("A bag of vacuum-packed food."),
        ascii_picture = "plastic_bag_vac",
        mass_milligrams = 2000,
        volume_ml = 10,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "%",
        color = "red",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        magazine_well_ml = 9,
        sealed_spoil_multiplier = 0.5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "thermos",
        category = "container",
        name = ccb.content.plural_text("thermos", "thermoses"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A Thermos brand vacuum flask.  Built for temperature retention, helps keep things hot or cold.  Contains 1 L of liquid."),
        ascii_picture = "thermos",
        mass_milligrams = 530000,
        volume_ml = 1250,
        longest_side_mm = 320,
        price_cents = 1595,
        price_postapoc_cents = 100,
        symbol = "I",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 4000000,
        rigid = true,
        watertight = true,
        insulation = 10,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_canister",
        category = "container",
        name = ccb.content.plural_text("clay canister", "clay canisters"),
        looks_like = "bowl_clay",
        description = ccb.content.text("A fragile clay vessel with a waterproofed hide lid.  It can be used to make crude impact grenades or to store liquid."),
        ascii_picture = "clay_canister",
        mass_milligrams = 536000,
        volume_ml = 590,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = "*",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 500, max_weight_milligrams = 2000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- Weight calculated proportionally from the coffee mug as I couldn't find detailed weight information for the product.
    -- Based on https://woolandclay.co/products/copy-of-clay-rose-ceramic-cup?variant=44312937103577&currency=USD&utm_medium=product_sync&utm_source=google&utm_content=sag_organic&utm_campaign=sag_organic&srsltid=AfmBOooF-nJhokvYE4XmLVMLYkPNM71TgbC7qana3ZQRLCV2Q7qviZy_tHU&com_cvv=8fb3d522dc163aeadb66e08cd7450cbbdddc64c6cf2e8891f6d48747c6d56d2c
    local item = content.Item {
        id = "clay_cup",
        category = "container",
        name = ccb.content.plural_text("clay cup", "clay cups"),
        symbol = "u",
        description = ccb.content.text("A simple clay cup used for holding liquid."),
        mass_milligrams = 318000,
        volume_ml = 475,
        longest_side_mm = 120,
        price_cents = 500,
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket {
        max_volume_ml = 330,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_hydria",
        category = "container",
        name = ccb.content.plural_text("clay hydria", "clay hydrias"),
        looks_like = "bowl_clay",
        description = ccb.content.text("A 15-liter clay pot with three handles for carrying and pouring.  It also has a waterproofed hide lid."),
        ascii_picture = "clay_hydria",
        mass_milligrams = 1955000,
        volume_ml = 17700,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 15000, max_weight_milligrams = 25000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_watercont",
        category = "container",
        name = ccb.content.plural_text("large clay pot", "large clay pots"),
        looks_like = "bowl_clay",
        description = ccb.content.text("A bulky and heavy clay pot with a waterproofed hide lid, meant to store water, but can carry other liquids in a pinch."),
        ascii_picture = "clay_watercont",
        mass_milligrams = 4887000,
        volume_ml = 44250,
        price_cents = 10000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 37500, max_weight_milligrams = 50000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_watercont_no_lid",
        name = ccb.content.plural_text("large clay pot (no lid)", "large clay pots (no lid)"),
        description = ccb.content.text("A bulky and heavy clay pot, meant to store water, but can carry other liquids in a pinch."),
        copy_from = "clay_watercont",
        looks_like = "clay_watercont",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 37500,
        max_weight_milligrams = 50000000,
        rigid = true,
        open_container = true,
        watertight = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "cup_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic cup", "plastic cups"),
        description = ccb.content.text("A small, vacuum-formed cup."),
        ascii_picture = "cup_plastic",
        mass_milligrams = 6000,
        volume_ml = 262,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
        sealed_spoil_multiplier = 0.0,
    }
    content.add(item)
end

do
    -- This is necessary because cup_plastic is also used for shelf-stable puddings
    local item = content.Item {
        id = "cup_plastic_yoghurt",
        category = "container",
        name = ccb.content.plural_text("plastic cup", "plastic cups"),
        copy_from = "cup_plastic",
        looks_like = "cup_plastic",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
        sealed_spoil_multiplier = 0.1,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "cup_foil",
        category = "container",
        name = ccb.content.plural_text("foil cup", "foil cups"),
        description = ccb.content.text("An improvised foldable cup made from aluminum foil.  It can contain liquid and is usable for boiling water."),
        ascii_picture = "cup_foil",
        mass_milligrams = 24000,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 250, max_weight_milligrams = 300000, watertight = true, open_container = true }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("SOFT")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "flask_glass",
        category = "container",
        name = ccb.content.plural_text("glass flask", "glass flasks"),
        looks_like = "bottle_glass",
        description = ccb.content.text("A 250 mL laboratory conical flask, with a rubber stopper."),
        ascii_picture = "flask_glass",
        mass_milligrams = 48000,
        volume_ml = 360,
        longest_side_mm = 132,
        price_cents = 400,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:material("rubber", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1250000,
        rigid = true,
        watertight = true,
        transparent = true,
    }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    content.add(item)
end

do
    local item = content.Item {
        id = "test_tube",
        category = "container",
        name = ccb.content.plural_text("test tube", "test tubes"),
        looks_like = "flask_glass",
        description = ccb.content.text("A 10 mL laboratory cylindrical test tube, with a rubber stopper."),
        ascii_picture = "test_tube",
        mass_milligrams = 11000,
        volume_ml = 20,
        longest_side_mm = 100,
        price_cents = 300,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 90)
    item:material("rubber", 10)
    item:container_pocket {
        max_volume_ml = 10,
        max_weight_milligrams = 50000,
        rigid = true,
        watertight = true,
        transparent = true,
    }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "beaker",
        category = "container",
        name = ccb.content.plural_text("beaker", "beakers"),
        looks_like = "flask_glass",
        description = ccb.content.text("A 250 mL laboratory beaker.  Basically a cup with delusions of grandeur."),
        ascii_picture = "beaker",
        mass_milligrams = 150000,
        volume_ml = 251,
        longest_side_mm = 72,
        price_cents = 500,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- sealed_data is here so the container can be sealed to avoid spilling
    local item = content.Item {
        id = "gradcylinder",
        category = "container",
        name = ccb.content.plural_text("graduated cylinder", "graduated cylinders"),
        looks_like = "flask_glass",
        description = ccb.content.text("A tall, narrow glass cylinder with precise markings for measuring fluid quantities.  An important science tool, it is also useful for anal-retentive chefs."),
        ascii_picture = "gradcylinder",
        mass_milligrams = 150000,
        volume_ml = 177,
        longest_side_mm = 250,
        price_cents = 500,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = "|",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 100,
        max_weight_milligrams = 500000,
        rigid = true,
        watertight = true,
        open_container = true,
        sealed_spoil_multiplier = 1.0,
    }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B074Y6GD2R
    local item = content.Item {
        id = "petri_dish",
        category = "container",
        name = ccb.content.plural_text("Petri dish", "Petri dishes"),
        description = ccb.content.text("A 90 mm Petri dish, commonly used in labs dealing with microorganisms or tissue samples."),
        mass_milligrams = 25000,
        volume_ml = 145,
        longest_side_mm = 96,
        price_cents = 400,
        price_postapoc_cents = 2,
        symbol = "u",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 93,
        max_weight_milligrams = 450000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0936RC7M1
    local item = content.Item {
        id = "jar_3l_glass_sealed",
        category = "container",
        name = ccb.content.plural_text("3 L glass jar", "3 L glass jars"),
        looks_like = "jar_glass_sealed",
        description = ccb.content.text("A three-liter glass jar with a metal screw top lid, used for canning.  Preserves its contents from rot until opened (assuming it was sterile before sealing)."),
        ascii_picture = "jar_3l_glass_sealed",
        mass_milligrams = 953000,
        volume_ml = 3530,
        longest_side_mm = 200,
        price_cents = 2000,
        price_postapoc_cents = 60,
        melee_to_hit = -5,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 6000000,
        rigid = true,
        watertight = true,
        transparent = true,
        sealed_spoil_multiplier = 0.0,
    }
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Weight taken from https://www.amazon.co.uk/dp/B0030G0FG0/ref=twister_B09TQ861T8?_encoding=UTF8&psc=1
    -- Based on https://www.kilnerjar.co.uk/0025400-preserve-jar-05-litre/
    local item = content.Item {
        id = "jar_glass_sealed",
        category = "container",
        name = ccb.content.plural_text("0.5 L glass jar", "0.5 L glass jars"),
        description = ccb.content.text("A half-liter glass jar with a metal screw top lid, used for canning.  Preserves its contents from rot until opened (assuming it was sterile before sealing)."),
        ascii_picture = "jar_glass_sealed",
        mass_milligrams = 277000,
        volume_ml = 690,
        longest_side_mm = 127,
        price_cents = 500,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        transparent = true,
        sealed_spoil_multiplier = 0.0,
    }
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "jerrycan",
        category = "container",
        name = ccb.content.plural_text("plastic jerrycan", "plastic jerrycans"),
        description = ccb.content.text("A bulky plastic jerrycan, meant to carry fuel, but can carry other liquids in a pinch."),
        ascii_picture = "jerrycan",
        mass_milligrams = 1587000,
        volume_ml = 10500,
        longest_side_mm = 330,
        price_cents = 1250,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ")",
        color = "green",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 10000,
        max_weight_milligrams = 15000000,
        rigid = true,
        watertight = true,
        transparent = true,
        max_item_volume_ml = 32,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "jerrycan_big",
        category = "container",
        name = ccb.content.plural_text("steel jerrycan", "steel jerrycans"),
        looks_like = "jerrycan",
        description = ccb.content.text("A steel jerrycan, meant to carry fuel, but can carry other liquids in a pinch."),
        ascii_picture = "jerrycan_big",
        mass_milligrams = 4300000,
        volume_ml = 26750,
        longest_side_mm = 470,
        price_cents = 5000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = ")",
        color = "green",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 20000,
        max_weight_milligrams = 25000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
    }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "jug_clay",
        category = "container",
        name = ccb.content.plural_text("clay jug", "clay jugs"),
        looks_like = "bowl_clay",
        description = ccb.content.text("A clay container with a waterproofed hide lid, used to hold and pour liquids."),
        ascii_picture = "jug_clay",
        mass_milligrams = 400000,
        volume_ml = 1180,
        price_cents = 100,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 1000, max_weight_milligrams = 2000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "jug_plastic_glue",
        copy_from = "jug_plastic",
        category = "container",
        name = ccb.content.plural_text("gallon glue jug", "gallon glue jugs"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A standard plastic jug that can hold 3750 mL of glue.  Cannot be reused or refilled."),
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    content.add(item)
end

do
    -- Price calculated from https://www.uline.com/Product/Detail/S-22157/Hazardous-Materials-Packaging/Metal-F-Style-Can-with-Cap-1-Gallon
    -- Based on https://www.pipelinepackaging.com/1-gallon-f-style-can-unlined-42-mm-rel-610x907-un-rated-bulk-pallet
    local item = content.Item {
        id = "fuel_tin",
        category = "container",
        name = ccb.content.plural_text("gallon can", "gallon cans"),
        looks_like = "jerrycan_big",
        description = ccb.content.text("A large tin with a handle and a cap, meant for holding camp fuel or some other oil.  Looks like it could store just over a gallon."),
        ascii_picture = "fuel_tin",
        mass_milligrams = 363000,
        volume_ml = 4290,
        price_cents = 1200,
        price_postapoc_cents = 400,
        melee_to_hit = -2,
        longest_side_mm = 240,
        symbol = ")",
        color = "red",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 3800,
        max_weight_milligrams = 14000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 32,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "keg",
        category = "container",
        name = ccb.content.plural_text("aluminum keg", "aluminum kegs"),
        looks_like = "30l_barrel",
        description = ccb.content.text("A reusable lightweight aluminum keg, used for shipping beer.  It has a capacity of 50 liters."),
        ascii_picture = "keg",
        mass_milligrams = 5040000,
        volume_ml = 50050,
        price_cents = 10000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 50000,
        max_weight_milligrams = 100000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 50,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "keg_steel",
        category = "container",
        name = ccb.content.plural_text("steel keg", "steel kegs"),
        looks_like = "keg",
        description = ccb.content.text("A reusable heavy steel keg, used for shipping beer.  It has a capacity of 50 liters."),
        ascii_picture = "keg",
        mass_milligrams = 12600000,
        volume_ml = 52500,
        price_cents = 8000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 50000,
        max_weight_milligrams = 120000000,
        rigid = true,
        watertight = true,
        max_item_volume_ml = 50,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_stomach_sealed",
        category = "container",
        name = ccb.content.plural_text("large sealed stomach", "large sealed stomachs"),
        description = ccb.content.text("The stomach of a large creature, cleaned and sealed with strings.  It can hold 3 liters of water."),
        ascii_picture = "large_stomach_sealed",
        mass_milligrams = 783000,
        volume_ml = 500,
        price_cents = 4000,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("gutskin", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 6000000,
        watertight = true,
        magazine_well_ml = 250,
        max_item_volume_ml = 17,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_tank",
        category = "container",
        looks_like = "keg",
        name = ccb.content.plural_text("metal tank (60 L)", "metal tanks (60 L)"),
        description = ccb.content.text("A large metal tank for holding liquids.  Useful for crafting."),
        ascii_picture = "metal_tank",
        mass_milligrams = 5668000,
        volume_ml = 60050,
        price_cents = 10000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "}",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 60000, max_weight_milligrams = 600000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    -- 230 x 116 mm cylinder, 2.5mm thickness with some additional weight for attachments
    local item = content.Item {
        id = "metal_tank_little",
        category = "container",
        looks_like = "keg",
        name = ccb.content.plural_text("metal tank (2 L)", "metal tanks (2 L)"),
        description = ccb.content.text("A small metal tank for gasoline or other liquids.  Useful for crafting."),
        ascii_picture = "metal_tank_little",
        mass_milligrams = 992000,
        volume_ml = 2430,
        longest_side_mm = 230,
        price_cents = 1000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = "}",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 2000, max_weight_milligrams = 20000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "stomach_sealed",
        category = "container",
        name = ccb.content.plural_text("sealed stomach", "sealed stomachs"),
        description = ccb.content.text("The stomach of a creature, cleaned and sealed with a string.  It can hold 1.5 liters of water."),
        ascii_picture = "stomach_sealed",
        mass_milligrams = 453000,
        volume_ml = 250,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("gutskin", 1)
    item:container_pocket { max_volume_ml = 1500, max_weight_milligrams = 3000000, watertight = true, max_item_volume_ml = 17 }
    content.add(item)
end

do
    local item = content.Item {
        id = "waterproof_smart_phone_case",
        category = "container",
        name = ccb.content.plural_text("waterproof smartphone case", "waterproof smartphone cases"),
        looks_like = "smart_phone",
        description = ccb.content.text("A waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."),
        ascii_picture = "waterproof_smart_phone_case",
        mass_milligrams = 50000,
        volume_ml = 150,
        longest_side_mm = 160,
        price_cents = 1000,
        price_postapoc_cents = 20,
        symbol = ";",
        color = "light_gray",
        variant_kind = "generic",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:variants {
        { id = "black_smart_phone_case", name = ccb.content.plural_text("black smartphone case", "black smartphone cases"), description = ccb.content.text("A black waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "black_smart_phone_case", weight = 10 },
        { id = "pink_smart_phone_case", name = ccb.content.plural_text("pink smartphone case", "pink smartphone cases"), description = ccb.content.text("A pink waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "pink_smart_phone_case", weight = 10 },
        { id = "red_smart_phone_case", name = ccb.content.plural_text("red smartphone case", "red smartphone cases"), description = ccb.content.text("A red waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "red_smart_phone_case", weight = 10 },
        { id = "dblue_smart_phone_case", name = ccb.content.plural_text("dark blue smartphone case", "dark blue smartphone cases"), description = ccb.content.text("A dark blue waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "dblue_smart_phone_case", weight = 10 },
        { id = "lblue_smart_phone_case", name = ccb.content.plural_text("light blue smartphone case", "light blue smartphone cases"), description = ccb.content.text("A light blue waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "lblue_smart_phone_case", weight = 10 },
        { id = "cyan_smart_phone_case", name = ccb.content.plural_text("cyan smartphone case", "cyan smartphone cases"), description = ccb.content.text("A cyan waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "cyan_smart_phone_case", weight = 10 },
        { id = "brown_smart_phone_case", name = ccb.content.plural_text("brown smartphone case", "brown smartphone cases"), description = ccb.content.text("A brown waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "brown_smart_phone_case", weight = 10 },
        { id = "white_smart_phone_case", name = ccb.content.plural_text("white smartphone case", "white smartphone cases"), description = ccb.content.text("A white waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "white_smart_phone_case", weight = 10 },
        { id = "gray_smart_phone_case", name = ccb.content.plural_text("gray smartphone case", "gray smartphone cases"), description = ccb.content.text("A gray waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "gray_smart_phone_case", weight = 10 },
        { id = "orange_smart_phone_case", name = ccb.content.plural_text("orange smartphone case", "orange smartphone cases"), description = ccb.content.text("An orange waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "orange_smart_phone_case", weight = 10 },
        { id = "lgreen_smart_phone_case", name = ccb.content.plural_text("light green smartphone case", "light green smartphone cases"), description = ccb.content.text("A light green waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "lgreen_smart_phone_case", weight = 10 },
        { id = "dgreen_smart_phone_case", name = ccb.content.plural_text("dark green smartphone case", "dark green smartphone cases"), description = ccb.content.text("A dark green waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "dgreen_smart_phone_case", weight = 10 },
        { id = "violet_smart_phone_case", name = ccb.content.plural_text("violet smartphone case", "violet smartphone cases"), description = ccb.content.text("A violet waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "violet_smart_phone_case", weight = 10 },
        { id = "purple_smart_phone_case", name = ccb.content.plural_text("purple smartphone case", "purple smartphone cases"), description = ccb.content.text("A purple waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "purple_smart_phone_case", weight = 10 },
        { id = "yellow_smart_phone_case", name = ccb.content.plural_text("yellow smartphone case", "yellow smartphone cases"), description = ccb.content.text("A yellow waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "yellow_smart_phone_case", weight = 10 },
        { id = "bejeweled_smart_phone_case", name = ccb.content.plural_text("golden smartphone case", "golden smartphone cases"), description = ccb.content.text("A shiny, expensive-looking golden colored waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "bejeweled_smart_phone_case", weight = 5 },
        { id = "bejeweled_smart_phone_case1", name = ccb.content.plural_text("silver smartphone case", "silver smartphone cases"), description = ccb.content.text("A shiny, expensive-looking silver waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "bejeweled_smart_phone_case1", weight = 5 },
        { id = "bejeweled_smart_phone_case2", name = ccb.content.plural_text("bronze smartphone case", "bronze smartphone cases"), description = ccb.content.text("A shiny, not so expensive-looking bronze waterproof case designed for a standard smartphone.  Will protect your smartphone from water damage entirely."), ascii_picture = "bejeweled_smart_phone_case2", weight = 5 },
        { id = "hello_kitty_case", name = ccb.content.plural_text("Hello Kitty smartphone case", "Hello Kitty smartphone cases"), description = ccb.content.text("This waterproof smartphone case has numerous versions of Hello Kitty posing on it."), ascii_picture = "hello_kitty_case", weight = 5 },
        { id = "dollar_case", name = ccb.content.plural_text("One Hundred Dollars smartphone case", "One Hundred Dollars smartphone cases"), description = ccb.content.text("This waterproof smartphone case has numerous one-hundred dollar bills printed on it."), ascii_picture = "dollar_case", weight = 5 },
        { id = "mech_case", name = ccb.content.plural_text("Mechanical Gear smartphone case", "Mechanical Gear smartphone cases"), description = ccb.content.text("This waterproof smartphone case has numerous mechanical gears of various sizes and styles printed on it."), ascii_picture = "mech_case", weight = 5 },
        { id = "ace_case", name = ccb.content.plural_text("Ace of Spades smartphone case", "Ace of Spades smartphone cases"), description = ccb.content.text("This black waterproof smartphone case has the print of a large white Ace of Spades in the back.  Looks good."), ascii_picture = "ace_case", weight = 5 },
        { id = "insta_case", name = ccb.content.plural_text("Instagram Overlay smartphone case", "Instagram Overlay smartphone cases"), description = ccb.content.text("Inspired by Instagram's popular filter overlays, this waterproof smartphone case features a colorful gradient background with geometric shapes layered over it.  The colors of these shapes are similar to those found in Instagram's color palette.  The overlay design gives the case an interesting depth and texture, and the colors make it stand out."), ascii_picture = "insta_case", weight = 5 },
        { id = "zombie_case", name = ccb.content.plural_text("zombie smartphone case", "zombie smartphone cases"), description = ccb.content.text("This waterproof smartphone case has a green zombie on its reverse side.  Would using this be in poor taste now?"), weight = 1 },
    }
    item:container_pocket {
        max_volume_ml = 111,
        max_weight_milligrams = 233000,
        max_item_length_mm = 150,
        moves = 100,
        watertight = true,
        rigid = true,
        transparent = true,
        allowed_items = {
            "smart_phone",
            "smart_phone_flashlight",
            "smartphone_music",
            "smart_phone_locked",
            "smart_phone_locked_flashlight",
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "waterproof_camera_case",
        category = "container",
        name = ccb.content.plural_text("waterproof camera case", "waterproof camera cases"),
        looks_like = "camera",
        description = ccb.content.text("A waterproof case designed for a standard camera.  Will protect your camera from water damage entirely."),
        ascii_picture = "waterproof_camera_case",
        mass_milligrams = 50000,
        volume_ml = 275,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 907000,
        moves = 100,
        watertight = true,
        rigid = true,
        transparent = true,
        allowed_items = { "camera" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_barrel",
        category = "container",
        name = ccb.content.plural_text("wooden barrel", "wooden barrels"),
        looks_like = "30l_barrel",
        description = ccb.content.text("Traditionally made of white oak; these vessels are known for delivering delicious whiskey to the future.  It has a capacity of 100 liters."),
        ascii_picture = "wooden_barrel",
        mass_milligrams = 42408000,
        volume_ml = 110000,
        price_cents = 12000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 100000, max_weight_milligrams = 200000000, watertight = true, rigid = true }
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_barrel_rotten",
        category = "container",
        name = ccb.content.plural_text("rotten barrel", "rotten barrels"),
        looks_like = "wooden_barrel",
        description = ccb.content.text("Traditionally made of white oak; these vessels are known for delivering delicious whiskey to the future.  It has a capacity of 100 liters, or would if it weren't so rotten that it can't possibly contain anything."),
        ascii_picture = "wooden_barrel",
        mass_milligrams = 42408000,
        volume_ml = 110000,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = ")",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "wrapper",
        category = "container",
        name = ccb.content.plural_text("paper wrapper", "paper wrappers"),
        description = ccb.content.text("Just a piece of butcher's paper.  Good for starting fires."),
        ascii_picture = "wrapper",
        mass_milligrams = 3000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("paper", 1)
    item:container_pocket { max_volume_ml = 2500, max_weight_milligrams = 6000000, magazine_well_ml = 45 }
    item:clear_flags()
    item:flag("TINDER")
    content.add(item)
end

do
    -- 50 cm length, 30 cm width, 0.02 mm thickness - 3ml, but without wrapper roll 4 times as much
    -- mathematically perfect sphere out of sheet is 2110 ml, but we are less than perfect
    local item = content.Item {
        id = "wrapper_foil",
        category = "container",
        name = ccb.content.plural_text("foil wrapper", "foil wrappers"),
        description = ccb.content.text("A piece of aluminum foil, large enough to wrap around something.  You could also cook food in it."),
        ascii_picture = "wrapper_foil",
        mass_milligrams = 8000,
        volume_ml = 12,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 1500, max_weight_milligrams = 6000000 }
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SOFT")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    -- 20 m of aluminum foil, 40 units
    local item = content.Item {
        id = "wrapper_foil_roll",
        category = "other",
        name = ccb.content.plural_text("aluminum foil roll", "aluminum foil rolls"),
        description = ccb.content.text("Long tube of cardboard, used to conveniently store long sheets of foil."),
        mass_milligrams = 52000,
        volume_ml = 96,
        longest_side_mm = 300,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "o",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket {
        max_volume_ml = 480,
        max_weight_milligrams = 1000000,
        allowed_items = { "wrapper_foil" },
        volume_multiplier = 0.25,
    }
    item:clear_flags()
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "wrapper_bar",
        name = ccb.content.plural_text("wrapper", "wrappers"),
        description = ccb.content.text("A wrapper for some kind of snack bar."),
        copy_from = "wrapper",
        looks_like = "wrapper",
        mass_milligrams = 1000,
        volume_ml = 5,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 175, max_weight_milligrams = 1000000, magazine_well_ml = 4 }
    content.add(item)
end

do
    -- Daizu is Japanese for soy, hence DaiZoom
    local item = content.Item {
        id = "wrapper_pr",
        name = ccb.content.plural_text("wrapper", "wrappers"),
        copy_from = "wrapper_bar",
        looks_like = "wrapper_bar",
        ascii_picture = "wrapper_pr",
        description = ccb.content.text("\"DaiZoom Protein Bar, brought to you by SoyPelusa\" is emblazoned proudly upon this greaseproof wrapper."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "styrofoam_cup",
        category = "container",
        name = ccb.content.plural_text("styrofoam cup", "styrofoam cups"),
        looks_like = "cup_plastic",
        description = ccb.content.text("A cheap, disposable cup with a plastic lid and straw."),
        ascii_picture = "styrofoam_cup",
        mass_milligrams = 7000,
        volume_ml = 650,
        price_cents = 55,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
        replace_pockets = true,
    }
    item:material("styrofoam", 1)
    item:container_pocket { max_volume_ml = 500, max_weight_milligrams = 1000000, watertight = true, rigid = true }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_bucket",
        category = "container",
        name = ccb.content.plural_text("plastic tub", "plastic tubs"),
        description = ccb.content.text("A big, square plastic bucket usually used for carrying ice cream."),
        ascii_picture = "plastic_bucket",
        mass_milligrams = 260000,
        volume_ml = 4500,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 4250, max_weight_milligrams = 9000000, watertight = true, rigid = true }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    -- delete condom variants
    local item = content.Item {
        id = "balloon",
        looks_like = "condom",
        name = ccb.content.plural_text("balloon", "balloons"),
        description = ccb.content.text("A deflated balloon.  This could be used as a makeshift water container."),
        ascii_picture = "balloon",
        copy_from = "condom",
    }
    item:variants {}
    content.add(item)
end

do
    local item = content.Item {
        id = "can_food_big",
        category = "container",
        name = ccb.content.plural_text("large tin can", "large tin cans"),
        looks_like = "can_food",
        description = ccb.content.text("A large tin can, like what beans come in.  Holds a substantial amount of food."),
        ascii_picture = "can_food_big",
        mass_milligrams = 350000,
        volume_ml = 3003,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -2,
        symbol = ")",
        color = "blue",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 6000000,
        watertight = true,
        rigid = true,
        open_container = true,
        sealed_spoil_multiplier = 0.0,
    }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "survival_kit_box",
        category = "container",
        name = ccb.content.plural_text("survival kit box", "survival kit boxes"),
        looks_like = "box_small",
        description = ccb.content.text("An aluminum box designed to contain a small survival kit."),
        ascii_picture = "survival_kit_box",
        mass_milligrams = 800000,
        volume_ml = 2300,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        symbol = "!",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 2100, max_weight_milligrams = 4000000, rigid = true, watertight = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_survival_kit_box",
        category = "container",
        name = ccb.content.plural_text("survival kit box", "survival kit boxes"),
        looks_like = "box_small",
        description = ccb.content.text("The ultimate survival kit purchased either by the wealthy or the dedicated urban survivalist.  It contains tools and items to help you survive in case of an emergency."),
        ascii_picture = "large_survival_kit_box",
        mass_milligrams = 850000,
        volume_ml = 8900,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 8500, max_weight_milligrams = 20000000, rigid = true }
    item:material("cardboard", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "box_tea",
        category = "container",
        name = ccb.content.plural_text("small cardboard box of tea bags", "small cardboard boxes of tea bags"),
        looks_like = "box_small",
        description = ccb.content.text("A very small cardboard box with a tea brand's logo on it."),
        ascii_picture = "box_tea",
        mass_milligrams = 10000,
        volume_ml = 105,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "green",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 100, max_weight_milligrams = 200000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "stand_flyer",
        category = "container",
        name = ccb.content.plural_text("flier stand", "flier stands"),
        description = ccb.content.text("A small stand made to show off various fliers."),
        ascii_picture = "stand_flyer",
        mass_milligrams = 326000,
        volume_ml = 5962,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "H",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 90000,
        open_container = true,
        allowed_flags = { "PAPER_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 90000,
        open_container = true,
        allowed_flags = { "PAPER_SHAPED" },
    }
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 90000,
        open_container = true,
        allowed_flags = { "PAPER_SHAPED" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "1st_aid_box",
        category = "container",
        name = ccb.content.plural_text("first aid kit box", "first aid kit boxes"),
        looks_like = "ifak_pouch",
        description = ccb.content.text("A plastic box designed to contain a first aid kit."),
        ascii_picture = "1st_aid_box",
        mass_milligrams = 200000,
        volume_ml = 2900,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 2700,
        max_weight_milligrams = 3000000,
        max_item_length_mm = 200,
        rigid = true,
        transparent = true,
        moves = 100,
    }
    content.add(item)
end

do
    -- Was introduced without anchoring to a real example, but is similar to this: https://www.amazon.com/Livans-Tactical-Rip-Away-Military-Emergency/dp/B07Y7BRB83
    local item = content.Item {
        id = "ifak_pouch",
        category = "container",
        name = ccb.content.plural_text("IFAK pouch", "IFAK pouches"),
        looks_like = "1st_aid_box",
        description = ccb.content.text("A fabric pouch designed to contain a personalized trauma kit.  These supplies are used to address immediate life-threatening conditions."),
        ascii_picture = "ifak_pouch",
        mass_milligrams = 329000,
        volume_ml = 1250,
        price_cents = 0,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = ")",
        color = "red",
    }
    item:material("cotton", 1)
    item:material("neoprene", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("PALS_MEDIUM")
    item:container_pocket {
        max_volume_ml = 3200,
        max_weight_milligrams = 4000000,
        magazine_well_ml = 400,
        max_item_length_mm = 200,
        moves = 100,
        volume_encumber_modifier = 0.3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "rc_car_box",
        category = "container",
        name = ccb.content.plural_text("radio car box", "radio car boxes"),
        description = ccb.content.text("A small box with an image of a toy car printed on the front.  The text written on the side says it comes with a remote control and batteries included."),
        ascii_picture = "rc_car_box",
        mass_milligrams = 400000,
        volume_ml = 3200,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "red",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 2900, max_weight_milligrams = 4000000, rigid = true, moves = 100 }
    content.add(item)
end

do
    local item = content.Item {
        id = "stirling_kit_box",
        category = "container",
        name = ccb.content.plural_text("STEM kit box", "STEM kit boxes"),
        description = ccb.content.text("A small box with an image of children building things."),
        ascii_picture = "stirling_kit_box",
        mass_milligrams = 400000,
        volume_ml = 3200,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white_cyan",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 2900, max_weight_milligrams = 4000000, rigid = true, moves = 100 }
    content.add(item)
end

do
    local item = content.Item {
        id = "maker_kit_box",
        category = "container",
        name = ccb.content.plural_text("maker kit box", "maker kit boxes"),
        description = ccb.content.text("A small box with an image of children building things.  It's labeled 'Makerspace Learner Kit'."),
        ascii_picture = "maker_kit_box",
        mass_milligrams = 400000,
        volume_ml = 3200,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white_cyan",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 2900, max_weight_milligrams = 4000000, rigid = true, moves = 100 }
    content.add(item)
end

do
    local item = content.Item {
        id = "robot_kit_box",
        category = "container",
        name = ccb.content.plural_text("robot kit box", "robot kit boxes"),
        description = ccb.content.text("A small box with an image of children building robots."),
        ascii_picture = "robot_kit_box",
        mass_milligrams = 400000,
        volume_ml = 3200,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "white_cyan",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 2900, max_weight_milligrams = 4000000, rigid = true, moves = 100 }
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_bag_small",
        category = "container",
        name = ccb.content.plural_text("small MRE bag", "small MRE bags"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A small, sturdy, plastic and aluminum container of multi-layered construction, with detailed nutritional information about its contents."),
        ascii_picture = "mre_bag_small",
        mass_milligrams = 70000,
        volume_ml = 100,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1500000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_bag",
        category = "container",
        name = ccb.content.plural_text("MRE bag", "MRE bags"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A sturdy plastic and aluminum container of multi-layered construction, with detailed nutritional information about its contents."),
        ascii_picture = "mre_bag",
        mass_milligrams = 180000,
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 510,
        max_weight_milligrams = 3000000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_package",
        category = "container",
        name = ccb.content.plural_text("MRE package", "MRE packages"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("The Meal, Ready-to-Eat - also known as the MRE - is the individual field ration of the United States Armed Forces.  It is in a lightweight yet sturdy multi-layered plastic and aluminum foil container - essentially a flexible can."),
        ascii_picture = "mre_package",
        mass_milligrams = 320000,
        volume_ml = 450,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 1625,
        max_weight_milligrams = 4000000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_bag_dessert",
        category = "container",
        name = ccb.content.plural_text("MRE dessert bag", "MRE dessert bags"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A small, sturdy, plastic and aluminum container of multi-layered construction, with detailed nutritional information about its contents."),
        ascii_picture = "mre_bag_dessert",
        mass_milligrams = 35000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 125,
        max_weight_milligrams = 750000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_bag_spread",
        category = "container",
        name = ccb.content.plural_text("MRE spread bag", "MRE spread bags"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A small, sturdy, plastic and aluminum container of multi-layered construction, with detailed nutritional information about its contents."),
        ascii_picture = "mre_bag_spread",
        mass_milligrams = 10000,
        volume_ml = 12,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 31,
        max_weight_milligrams = 180000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mre_bag_jam",
        category = "container",
        name = ccb.content.plural_text("MRE jam bag", "MRE jam bags"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A small, sturdy, plastic and aluminum container of multi-layered construction, with detailed nutritional information about its contents."),
        ascii_picture = "mre_bag_spread",
        mass_milligrams = 10000,
        volume_ml = 12,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 32,
        max_weight_milligrams = 180000,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    -- https://www.narescue.com/individual-patrol-officer-kit.html
    local item = content.Item {
        id = "ipok",
        category = "container",
        name = ccb.content.plural_text("individual patrol officer kit", "individual patrol officer kits"),
        looks_like = "mre_beef_box",
        description = ccb.content.text("A first aid kit designed for patrolling police officers, contents selected for dealing with hemorrhaging injuries such as gunshot wounds.  Comes in a sealed pouch."),
        ascii_picture = "ipok",
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 1500000,
        transparent = true,
        moves = 50,
        sealed_spoil_multiplier = 0.0,
        watertight = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_medium",
        category = "container",
        name = ccb.content.plural_text("50 gallon aquarium", "50 gallon aquariums"),
        description = ccb.content.text("A 50-gallon glass aquarium, used for safely storing small animals for use as pets or food."),
        ascii_picture = "aquarium_medium",
        mass_milligrams = 45000000,
        volume_ml = 222000,
        longest_side_mm = 910,
        price_cents = 10000,
        price_postapoc_cents = 1500,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 189000,
        max_weight_milligrams = 300000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_small",
        category = "container",
        name = ccb.content.plural_text("30 gallon aquarium", "30 gallon aquariums"),
        description = ccb.content.text("A 30-gallon glass aquarium, used for safely storing small animals for use as pets or food."),
        ascii_picture = "aquarium_small",
        mass_milligrams = 22000000,
        volume_ml = 133000,
        longest_side_mm = 910,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 113000,
        max_weight_milligrams = 180000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_large",
        category = "container",
        name = ccb.content.plural_text("100 gallon aquarium", "100 gallon aquariums"),
        description = ccb.content.text("A 100-gallon glass aquarium, used for safely storing small animals for use as pets or food."),
        ascii_picture = "aquarium_large",
        mass_milligrams = 80000000,
        volume_ml = 400000,
        longest_side_mm = 1830,
        price_cents = 50000,
        price_postapoc_cents = 2500,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 378000,
        max_weight_milligrams = 500000000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end

do
    local item = content.Item {
        id = "shot_glass",
        category = "container",
        name = ccb.content.plural_text("shot glass", "shot glasses"),
        description = ccb.content.text("A standard 1.5 ounce shot glass."),
        ascii_picture = "shot_glass",
        mass_milligrams = 100000,
        volume_ml = 116,
        longest_side_mm = 58,
        price_cents = 300,
        price_postapoc_cents = 5,
        symbol = "v",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 44,
        max_weight_milligrams = 500000,
        watertight = true,
        rigid = true,
        open_container = true,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "30gal_drum_aluminum",
        category = "container",
        looks_like = "30gal_barrel",
        name = ccb.content.plural_text("aluminum tank (100 L)", "aluminum tanks (100 L)"),
        description = ccb.content.text("A large aluminum tank, traditionally used to store fuel."),
        ascii_picture = "30gal_drum_aluminum",
        mass_milligrams = 2565000,
        volume_ml = 130000,
        price_cents = 8000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "0",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 100000, max_weight_milligrams = 250000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "55gal_drum_aluminum",
        category = "container",
        looks_like = "30gal_drum",
        name = ccb.content.plural_text("aluminum tank (200 L)", "aluminum tanks (200 L)"),
        description = ccb.content.text("A massive aluminum tank, traditionally used to store fuel."),
        ascii_picture = "55gal_drum_aluminum",
        mass_milligrams = 10000000,
        volume_ml = 230000,
        price_cents = 10000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "0",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 500000000, watertight = true, rigid = true }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "squeeze_tube",
        category = "container",
        name = ccb.content.plural_text("10.1 ounce squeeze tube", "10.1 ounce squeeze tubes"),
        description = ccb.content.text("A 10.1 ounce squeeze tube, used for storing the likes of silicone caulk, paint, or food dressing."),
        ascii_picture = "squeeze_tube",
        mass_milligrams = 8150,
        volume_ml = 221,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "t",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 299, max_weight_milligrams = 2500000, watertight = true, transparent = true }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "squeeze_tube_small",
        category = "container",
        name = ccb.content.plural_text("2.8 ounce squeeze tube", "2.8 ounce squeeze tubes"),
        description = ccb.content.text("A 2.8 ounce squeeze tube, used for storing the likes of silicone caulk, paint, or food dressing."),
        ascii_picture = "squeeze_tube_small",
        mass_milligrams = 3500,
        volume_ml = 95,
        price_cents = 50,
        price_postapoc_cents = 5,
        symbol = "t",
        color = "light_cyan",
        looks_like = "squeeze_tube",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 82, max_weight_milligrams = 500000, watertight = true, transparent = true }
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "paint_can_steel",
        category = "container",
        name = ccb.content.plural_text("metal paint can", "metal paint cans"),
        description = ccb.content.text("A metal paint can, able to hold a gallon of liquid."),
        ascii_picture = "paint_can_steel",
        mass_milligrams = 400000,
        volume_ml = 4325,
        longest_side_mm = 210,
        price_cents = 10,
        price_postapoc_cents = 3,
        symbol = "o",
        color = "light_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 3785, max_weight_milligrams = 10000000, watertight = true, rigid = true }
    item:quality("BOIL", 1)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "paint_can_plastic",
        category = "container",
        name = ccb.content.plural_text("plastic paint can", "plastic paint cans"),
        description = ccb.content.text("A plastic paint can, able to hold a gallon of liquid."),
        ascii_picture = "paint_can_plastic",
        mass_milligrams = 50000,
        volume_ml = 4325,
        longest_side_mm = 210,
        price_cents = 10,
        price_postapoc_cents = 3,
        symbol = "o",
        color = "green",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 3785,
        max_weight_milligrams = 10000000,
        watertight = true,
        rigid = true,
        transparent = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "lunchbox",
        category = "container",
        name = ccb.content.plural_text("lunchbox", "lunchboxes"),
        description = ccb.content.text("A plastic box, commonly used to store lunch and utensils to eat it with."),
        ascii_picture = "lunchbox",
        mass_milligrams = 282000,
        volume_ml = 2050,
        longest_side_mm = 210,
        price_cents = 1400,
        price_postapoc_cents = 100,
        symbol = "l",
        color = "green",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 1100, max_weight_milligrams = 2000000, rigid = true }
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "pencil_case",
        category = "container",
        name = ccb.content.plural_text("pencil case", "pencil cases"),
        description = ccb.content.text("A small fabric container with a zipper.  Commonly used by children to store school supplies."),
        ascii_picture = "pencil_case",
        mass_milligrams = 200000,
        volume_ml = 1730,
        price_cents = 900,
        price_postapoc_cents = 5,
        symbol = "p",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("cotton", 1)
    item:container_pocket { max_volume_ml = 1000, max_weight_milligrams = 2000000, max_item_length_mm = 200 }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "cardboard_roll",
        category = "container",
        name = ccb.content.plural_text("cardboard roll", "cardboard rolls"),
        description = ccb.content.text("A small cardboard roll used to conveniently store materials such as tape or toilet paper."),
        ascii_picture = "cardboard_roll",
        mass_milligrams = 1000,
        volume_ml = 6,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "o",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        max_item_length_mm = 300,
        allowed_items = { "duct_tape", "medical_tape" },
        volume_multiplier = 0.75,
    }
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    -- https://www.amazon.com/Handmade-Wooden-Coffee-Unique-Glasses/dp/B07GWB6R3P/
    -- requested by Myfharad
    local item = content.Item {
        id = "tankard_wooden",
        category = "container",
        name = ccb.content.plural_text("wooden tankard", "wooden tankards"),
        description = ccb.content.text("A low-tech solution for all your guzzling needs.  Drink responsibly."),
        mass_milligrams = 181000,
        volume_ml = 724,
        longest_side_mm = 100,
        price_cents = 1500,
        price_postapoc_cents = 50,
        looks_like = "ceramic_mug",
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 341,
        max_weight_milligrams = 1150000,
        watertight = true,
        rigid = true,
        open_container = true,
        max_item_volume_ml = 250,
        moves = 400,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    -- https://www.kultofathena.com/product/stainless-steel-tankard/
    local item = content.Item {
        id = "tankard_metal",
        category = "container",
        name = ccb.content.plural_text("steel tankard", "steel tankards"),
        description = ccb.content.text("While not as historic as one may think, it's considered a finer luxury in these trying times.  Drink responsibly."),
        mass_milligrams = 181000,
        volume_ml = 724,
        longest_side_mm = 100,
        price_cents = 3000,
        price_postapoc_cents = 50,
        looks_like = "ceramic_mug",
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 341,
        max_weight_milligrams = 1150000,
        watertight = true,
        rigid = true,
        open_container = true,
        max_item_volume_ml = 250,
        moves = 400,
    }
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 2)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "pillbox",
        category = "container",
        name = ccb.content.plural_text("pillbox", "pillboxes"),
        description = ccb.content.text("A simple plastic pill organizer with a small compartment for each day of the week."),
        mass_milligrams = 40000,
        volume_ml = 200,
        longest_side_mm = 150,
        price_cents = 200,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 20, max_weight_milligrams = 40000, rigid = true, transparent = true, moves = 150 }
    content.add(item)
end

do
    local item = content.Item {
        id = "pillbox_large",
        copy_from = "pillbox",
        looks_like = "pillbox",
        name = ccb.content.plural_text("large pillbox", "large pillboxes"),
        description = ccb.content.text("A large plastic pill organizer with compartments for two weeks of daily medication."),
        mass_milligrams = 120000,
        volume_ml = 500,
        longest_side_mm = 220,
        price_cents = 500,
        price_postapoc_cents = 25,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    item:container_pocket { max_volume_ml = 30, max_weight_milligrams = 60000, rigid = true, transparent = true, moves = 150 }
    content.add(item)
end

do
    local item = content.Item {
        id = "nic_pouch_can",
        category = "container",
        name = ccb.content.plural_text("nicotine pouch can", "nicotine pouch cans"),
        looks_like = "box_small",
        description = ccb.content.text("TYNN 15 NICOTINE POUCHES WARNING: This product contains an addictive chemical, nicotine."),
        ascii_picture = "nic_pouch_can",
        mass_milligrams = 17000,
        volume_ml = 90,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "o",
        color = "white",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 45, max_weight_milligrams = 30000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_chips_small",
        copy_from = "bag_plastic_small",
        looks_like = "bag_plastic_small",
        name = ccb.content.plural_text("small chips bag", "small chips bags"),
        description = ccb.content.text("A small plastic bag made to contain chips."),
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 200, max_weight_milligrams = 1000000, watertight = true, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_chips_medium",
        copy_from = "bag_chips_small",
        looks_like = "bag_chips_small",
        name = ccb.content.plural_text("chips bag", "chips bags"),
        description = ccb.content.text("A plastic bag made to contain chips."),
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 400, max_weight_milligrams = 1000000, watertight = true, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bag_chips_large",
        copy_from = "bag_chips_small",
        looks_like = "bag_chips_small",
        name = ccb.content.plural_text("large chips bag", "large chips bags"),
        description = ccb.content.text("A large plastic bag made to contain chips."),
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 600, max_weight_milligrams = 1000000, watertight = true, moves = 400 }
    content.add(item)
end

do
    local item = content.Item {
        id = "six_pack_rings",
        category = "container",
        name = ccb.content.plural_text("six-pack rings", "six-pack rings"),
        description = ccb.content.text("A set of plastic rings meant to hold aluminum cans."),
        symbol = "8",
        color = "light_cyan",
        price_postapoc_cents = 1,
        mass_milligrams = 1000,
        volume_ml = 1,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 2500, max_weight_milligrams = 10000000, transparent = true }
    item:clear_flags()
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    -- 0.5 lbs or 3 ft of solder
    -- spool itself is 200 ml, but volume is reduced if empty
    local item = content.Item {
        id = "spool_small",
        category = "container",
        name = ccb.content.plural_text("small spool", "small spools"),
        description = ccb.content.text("A small plastic spool designed to hold various materials."),
        mass_milligrams = 20000,
        volume_ml = 50,
        symbol = "=",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 200,
        max_weight_milligrams = 1000000,
        rigid = false,
        max_item_length_mm = 500,
        allowed_items = { "solder_wire", "cable", "copper_wire" },
        transparent = true,
        moves = 200,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "spool_welding",
        category = "container",
        name = ccb.content.plural_text("wire spool", "wire spools"),
        description = ccb.content.text("A large plastic spool designed to hold welding wire."),
        mass_milligrams = 400000,
        volume_ml = 1600,
        symbol = "=",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 6000000,
        rigid = false,
        allowed_items = { "welding_wire_steel", "welding_wire_alloy" },
        transparent = true,
        moves = 800,
        volume_multiplier = 0.3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "tube_welding_rod",
        category = "container",
        name = ccb.content.plural_text("welding rod tube", "welding rod tubes"),
        description = ccb.content.text("A long, clear plastic canister with a threaded cap.  It is designed to hold heavy stacks of welding and brazing rods."),
        mass_milligrams = 250000,
        volume_ml = 4200,
        symbol = "|",
        color = "light_cyan",
        longest_side_mm = 480,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 4000, max_weight_milligrams = 12000000, max_item_length_mm = 470, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "six_bottle_box",
        category = "container",
        name = ccb.content.plural_text("six-bottle box", "six-bottle boxes"),
        description = ccb.content.text("An open-top cardboard box, featuring a handle and six partitioned slots meant for small beverage bottles."),
        looks_like = "box_small",
        mass_milligrams = 50000,
        volume_ml = 3500,
        longest_side_mm = 220,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = "8",
        color = "brown",
    }
    item:material("cardboard", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 600000,
        holster = true,
        rigid = true,
        max_item_length_mm = 220,
        moves = 100,
    }
    content.add(item)
end
