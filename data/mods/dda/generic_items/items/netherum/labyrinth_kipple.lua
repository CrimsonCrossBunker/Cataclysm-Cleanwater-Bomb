local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "kipple_wrapper",
        category = "container",
        name = ccb.content.plural_text("paper wrapper", "paper wrappers"),
        description = ccb.content.text("A strange wrapper for candy or gum.  It crinkles like foil but feels similar to a blade of grass.  It reads \"<made_up_colors> <meta_ownership_noun>\"."),
        ascii_picture = "wrapper",
        mass_milligrams = 3000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 0,
        expand_snippets = true,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("monolith", 1)
    item:container_pocket { max_volume_ml = 250, max_weight_milligrams = 1000000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "kipple_object",
        category = "other",
        name = ccb.content.plural_text("strange object", "strange objects"),
        description = ccb.content.text("A <meta_adjective> <meta_noun> of <meta_ownership_noun>."),
        expand_snippets = true,
        mass_milligrams = 5000,
        volume_ml = 50,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "light_gray",
    }
    item:material("monolith", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_steel",
        category = "other",
        name = ccb.content.plural_text("odd steel device", "odd steel devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 200000,
        volume_ml = 520,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "light_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_alu",
        category = "other",
        name = ccb.content.plural_text("odd aluminum device", "odd aluminum devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 500000,
        volume_ml = 200,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "light_gray",
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_copper",
        category = "other",
        name = ccb.content.plural_text("odd copper device", "odd copper devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 500000,
        volume_ml = 60,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "red",
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_unob",
        category = "other",
        name = ccb.content.plural_text("strange metal device", "strange metal devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 5000,
        volume_ml = 50,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "white",
    }
    item:material("unobtanium", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_plastic",
        category = "other",
        name = ccb.content.plural_text("odd plastic device", "odd plastic devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 500000,
        volume_ml = 1000,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "light_blue",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_kipple_scrap_nanotubes",
        category = "other",
        name = ccb.content.plural_text("odd metallic device", "odd metallic devices"),
        description = ccb.content.text("The original purpose of this <meta_adjective> <nl_scrap_object> is unknown to you, if it ever had one."),
        expand_snippets = true,
        mass_milligrams = 5000,
        volume_ml = 50,
        longest_side_mm = 90,
        price_cents = 200,
        price_postapoc_cents = 0,
        symbol = "-",
        color = "blue",
    }
    item:material("nanotubes", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nl_water_bottle",
        category = "container",
        name = ccb.content.plural_text("strange plastic bottle", "strange plastic bottles"),
        looks_like = "bottle_twoliter",
        description = ccb.content.text("A slim, one-and-a-half-liter plastic bottle, made of a metalized plastic.  It has a label, but the characters upon it are unintelligible."),
        ascii_picture = "bottle_twoliter",
        mass_milligrams = 80000,
        volume_ml = 1540,
        longest_side_mm = 310,
        price_cents = 25,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 1500,
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
