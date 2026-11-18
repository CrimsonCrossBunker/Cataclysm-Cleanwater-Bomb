local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "shrink_wrap",
        category = "container",
        name = ccb.content.plural_text("shrink wrapping", "shrink wrappings"),
        looks_like = "bag_plastic",
        description = ccb.content.text("Polymer plastic material, that shrinks tightly over whatever it is covering.  Disposable."),
        mass_milligrams = 50000,
        volume_ml = 50,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket { max_volume_ml = 20000, max_weight_milligrams = 50000000, moves = 400 }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    -- Weight taken from https://www.amazon.com/dp/B08PDQDBFL - roughly the same size but actually has specified weight in the listing.
    -- Based on https://www.amazon.com/dp/B00030L5HY.
    local item = content.Item {
        id = "trashcan",
        category = "container",
        name = ccb.content.plural_text("trash can", "trash cans"),
        looks_like = "f_trashcan",
        description = ccb.content.text("A big trashcan in which you can store, you guessed it, trash.  Made out of plastic, so it's watertight but fragile and won't survive if you try to carry something really heavy in it."),
        mass_milligrams = 1021000,
        volume_ml = 56228,
        longest_side_mm = 510,
        price_cents = 1200,
        replace_pockets = true,
        replace_qualities = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 38000,
        max_weight_milligrams = 50000000,
        open_container = true,
        rigid = true,
        watertight = true,
    }
    item:quality("CONTAIN", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_trashcan")
    content.add(item)
end

do
    -- Weight taken from https://www.uline.com/Product/Detail/H-7938BL/Trash-Cans-with-Wheels/Uline-Trash-Can-with-Wheels-95-Gallon-Black?pricode=WB3072&utm_source=Bing&utm_medium=pla&utm_term=H-7938BL&utm_campaign=Facilities%2BMaintenance&utm_source=Bing&utm_medium=pla&utm_term=H-7938BL&utm_campaign=Facilities%2BMaintenance&msclkid=d3c8827d02691eb87066e72c65ff5790
    -- Based on above link.
    local item = content.Item {
        id = "trashcan_large",
        category = "container",
        name = ccb.content.plural_text("industrial trash can", "industrial trash cans"),
        looks_like = "f_recycle_bin",
        description = ccb.content.text("A really big trashcan in which you can store, you guessed it, trash, ready for the garbage truck to pick up.  Made out of thick plastic, this can was meant for household or industrial use, something you roll up to the curb once a week."),
        mass_milligrams = 15000000,
        volume_ml = 400000,
        longest_side_mm = 1140,
        price_cents = 15000,
        price_postapoc_cents = 7500,
        replace_pockets = true,
        replace_qualities = true,
        symbol = ")",
        color = "light_gray",
    }
    item:container_pocket {
        max_volume_ml = 360000,
        max_weight_milligrams = 149000000,
        open_container = true,
        rigid = true,
        watertight = true,
    }
    item:quality("CONTAIN", 2)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "saline_bag_250_empty",
        category = "container",
        name = ccb.content.plural_text("small liquid bag", "small liquid bags"),
        description = ccb.content.text("Small bag, similar to an IV bag, that previously stored a sterilized saline solution.  Whatever it stores now, it is not safe to put in your veins."),
        looks_like = "bag_iv",
        mass_milligrams = 5000,
        volume_ml = 35,
        price_cents = 50,
        price_postapoc_cents = 1,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 700000,
        watertight = true,
        max_item_volume_ml = 17,
        moves = 1000,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    content.add(item)
end

do
    local item = content.Item {
        id = "saline_bag_500_empty",
        name = ccb.content.plural_text("medium liquid bag", "medium liquid bags"),
        description = ccb.content.text("Bag, similar to an IV bag, that previously stored a sterilized saline solution.  Whatever it stores now, it is not safe to put in your veins."),
        copy_from = "saline_bag_250_empty",
        looks_like = "saline_bag_250_empty",
        mass_milligrams = 10000,
        volume_ml = 70,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1400000,
        watertight = true,
        max_item_volume_ml = 17,
        moves = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "saline_bag_1000_empty",
        name = ccb.content.plural_text("large liquid bag", "large liquid bags"),
        description = ccb.content.text("Large bag, similar to an IV bag, that previously stored a sterilized saline solution.  Whatever it stores now, it is not safe to put in your veins."),
        copy_from = "saline_bag_250_empty",
        looks_like = "saline_bag_250_empty",
        mass_milligrams = 20000,
        volume_ml = 140,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 2800000,
        watertight = true,
        max_item_volume_ml = 17,
        moves = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "saline_bag_2000_empty",
        name = ccb.content.plural_text("huge liquid bag", "huge liquid bags"),
        description = ccb.content.text("Huge bag, similar to an IV bag, that previously stored a sterilized saline solution.  Whatever it stores now, it is not safe to put in your veins."),
        copy_from = "saline_bag_250_empty",
        looks_like = "saline_bag_250_empty",
        mass_milligrams = 40000,
        volume_ml = 280,
        symbol = ")",
        color = "light_gray",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 5600000,
        watertight = true,
        max_item_volume_ml = 17,
        moves = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "outfit_storage",
        category = "container",
        name = ccb.content.plural_text("set of clothes", "sets of clothes"),
        description = ccb.content.text("A bundle of presses, coat hangars, and other miscellaneous items needed to store and keep a good change of clothes.  You can interact with it to swap to the clothes it's currently containing, or put your current clothes in if there's nothing already inside."),
        mass_milligrams = 1000000,
        volume_ml = 1000,
        longest_side_mm = 1500,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = "#",
        color = "dark_gray",
    }
    item:clear_use_actions()
    item:native_use("CHANGE_OUTFIT")
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 1000000, max_weight_milligrams = 1000000000, rigid = false, moves = 1000 }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("NO_SALVAGE")
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "box_paper_small",
        category = "container",
        name = ccb.content.plural_text("small paper box", "small paper boxes"),
        looks_like = "box_tea",
        description = ccb.content.text("A very small paper box."),
        mass_milligrams = 20000,
        volume_ml = 210,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "white",
        replace_pockets = true,
    }
    item:material("paper", 1)
    item:container_pocket { max_volume_ml = 200, max_weight_milligrams = 400000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "wrapping_vacuumed",
        category = "container",
        looks_like = "bag_plastic",
        name = ccb.content.plural_text("vacuum-sealed package", "vacuum-sealed packages"),
        description = ccb.content.text("A hermetically sealed article of packaging, made from thick plastic, designed to keep the contents isolated from atmospheric contact.  Shame that its properties melt away after you tear it open to get at the goodies within."),
        mass_milligrams = 6000,
        volume_ml = 25,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "%",
        color = "red",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 2000000,
        watertight = true,
        sealed_spoil_multiplier = 0.5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "basket_laundry",
        category = "container",
        name = ccb.content.plural_text("laundry basket", "laundry baskets"),
        description = ccb.content.text("A plastic basket meant for storing and hauling clothing."),
        mass_milligrams = 680000,
        volume_ml = 52500,
        price_cents = 75,
        price_postapoc_cents = 10,
        symbol = ")",
        looks_like = "plastic_shopping_bag",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 50000,
        max_weight_milligrams = 12000000,
        rigid = true,
        max_item_length_mm = 800,
        moves = 300,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "wicker_basket_large",
        category = "container",
        name = ccb.content.plural_text("large wicker basket", "large wicker baskets"),
        description = ccb.content.text("A large handmade straw basket.  Unwieldy but spacious."),
        mass_milligrams = 400000,
        volume_ml = 52500,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = ")",
        looks_like = "straw_basket",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("dry_plant", 1)
    item:container_pocket {
        max_volume_ml = 50000,
        max_weight_milligrams = 30000000,
        rigid = true,
        max_item_length_mm = 800,
        moves = 300,
    }
    content.add(item)
end

do
    -- for 16 lbs of charcoal (6978 units, rounded up to 7000)
    local item = content.Item {
        id = "bag_paper_charcoal",
        category = "container",
        name = ccb.content.plural_text("paper sack", "paper sacks"),
        looks_like = "bag_plastic",
        description = ccb.content.text("Bulky paper bag, generally used to store light materials like charcoal."),
        mass_milligrams = 300000,
        volume_ml = 600,
        price_cents = 85,
        price_postapoc_cents = 1,
        replace_pockets = true,
        symbol = ")",
        color = "white",
    }
    item:material("paper", 1)
    item:container_pocket { max_volume_ml = 40000, max_weight_milligrams = 13000000, moves = 500 }
    content.add(item)
end

do
    local item = content.Item {
        id = "blister_pack_small",
        category = "container",
        name = ccb.content.plural_text("drug blister pack", "drug blister packs"),
        looks_like = "bag_plastic",
        description = ccb.content.text("This is a thin piece of plastic and foil, with tiny bubbles meant to hold onto individual pills.  Often used for anti-depressants or more dangerous drugs to reduce the likelihood of purposeful overdose by making taking the individual pills out a pain in the ass."),
        mass_milligrams = 5000,
        volume_ml = 7,
        longest_side_mm = 102,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "light_gray",
    }
    item:variants {
        { id = "blister_pack_bc", name = ccb.content.plural_text("birth control pack", "birth control packs"), description = ccb.content.text("A thin piece of plastic and foil, with tiny bubbles meant for pills.  This one is for birth control, with 28 sections for pills in it."), weight = 0 },
        { id = "blister_pack_gum", name = ccb.content.plural_text("pack of chewing gum", "packs of chewing gum"), description = ccb.content.text("A thin piece of plastic and foil, with tiny bubbles meant for chewing gum."), weight = 0 },
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 50, max_weight_milligrams = 50000, transparent = true, moves = 400 }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("NO_RELOAD")
    content.add(item)
end

do
    local item = content.Item {
        id = "primer_tray",
        category = "container",
        name = ccb.content.plural_text("primer tray", "primer trays"),
        looks_like = "box_small",
        description = ccb.content.text("A small, flat plastic tray meant to hold primers encased in a cardboard sleeve."),
        mass_milligrams = 2000,
        volume_ml = 26,
        longest_side_mm = 98,
        price_cents = 85,
        price_postapoc_cents = 1,
        replace_pockets = true,
        symbol = ")",
        color = "blue",
    }
    item:material("plastic", 1)
    item:material("cardboard", 1)
    item:container_pocket {
        max_volume_ml = 150,
        max_weight_milligrams = 200000,
        allowed_items = {
            "smpistol_primer",
            "lgpistol_primer",
            "smrifle_primer",
            "lgrifle_primer",
            "shotgun_primer",
            "spent_smpistol_primer",
            "spent_lgpistol_primer",
            "spent_smrifle_primer",
            "spent_lgrifle_primer",
            "spent_shotgun_primer",
        },
    }
    content.add(item)
end
