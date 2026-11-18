local ccb = require("ccb")
local content = ccb.content

do
    -- ~7x20x15 or ~4x22x22
    local item = content.Item {
        id = "box_small",
        category = "container",
        name = ccb.content.plural_text("small cardboard box", "small cardboard boxes"),
        description = ccb.content.text("A small cardboard box.  No bigger than a foot in dimension.  Can be folded."),
        ascii_picture = "box_small",
        mass_milligrams = 50000,
        volume_ml = 2250,
        longest_side_mm = 210,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ")",
        color = "brown",
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 2100, max_weight_milligrams = 8000000, rigid = true, max_item_length_mm = 200 }
    item:material("cardboard", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "box_small_folded" },
        message = ccb.content.text("You fold the box."),
        menu_text = ccb.content.text("Fold"),
        moves = 500,
        need_empty = true,
    }
    item:variants {
        { id = "223_ammo_box_500", name = ccb.content.plural_text(".223/5.56 ammo box", ".223/5.56 ammo boxes"), description = ccb.content.text("This box is pretty hefty, holding 500 rounds of .223 or 5.56 ammo.  It's made of a thick cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    -- (25x40x50)
    local item = content.Item {
        id = "box_medium",
        category = "container",
        name = ccb.content.plural_text("cardboard box", "cardboard boxes"),
        looks_like = "box_small",
        description = ccb.content.text("A sturdy cardboard box, about the size of a banana box.  Great for packing.  Can be folded."),
        ascii_picture = "box_medium",
        mass_milligrams = 400000,
        volume_ml = 51000,
        longest_side_mm = 510,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 50000, max_weight_milligrams = 20000000, rigid = true, max_item_length_mm = 500 }
    item:material("cardboard", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "box_medium_folded" },
        message = ccb.content.text("You fold the box."),
        menu_text = ccb.content.text("Fold"),
        moves = 1000,
        need_empty = true,
    }
    content.add(item)
end

do
    -- A box that children could hide in should be big enough to cram a (un)dead child or uncomfortable adult in (90x60x60)
    local item = content.Item {
        id = "box_large",
        category = "container",
        name = ccb.content.plural_text("large cardboard box", "large cardboard boxes"),
        looks_like = "box_medium",
        description = ccb.content.text("A very large cardboard box, the sort children would have loved to hide in, when there were still children.  Can be folded."),
        ascii_picture = "box_large",
        mass_milligrams = 2000000,
        volume_ml = 329000,
        longest_side_mm = 910,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 324000, max_weight_milligrams = 50000000, rigid = true, max_item_length_mm = 900 }
    item:clear_use_actions()
    item:deploy_furniture("f_cardboard_box")
    item:transform_on_use {
        result = { target = "box_large_folded" },
        message = ccb.content.text("You fold the box."),
        menu_text = ccb.content.text("Fold"),
        moves = 1500,
        need_empty = true,
    }
    content.add(item)
end

do
    -- (200x50x20)
    local item = content.Item {
        id = "box_oversize",
        category = "container",
        name = ccb.content.plural_text("oversize cardboard box", "oversize cardboard boxes"),
        looks_like = "box_small",
        description = ccb.content.text("An oversize cardboard box, big enough to fit some longer items.  Great for storage.  Can be folded."),
        ascii_picture = "box_oversize",
        mass_milligrams = 2000000,
        volume_ml = 205000,
        longest_side_mm = 2010,
        price_cents = 0,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = ")",
        color = "brown",
    }
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 50000000, rigid = true, max_item_length_mm = 2000 }
    item:material("cardboard", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "box_oversize_folded" },
        message = ccb.content.text("You fold the box."),
        menu_text = ccb.content.text("Fold"),
        moves = 1500,
        need_empty = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "condom_sealed",
        looks_like = "condom",
        name = ccb.content.plural_text("sealed condom", "sealed condoms"),
        description = ccb.content.text("A sealed condom wrapper, activate to open it."),
        ascii_picture = "condom_sealed",
        mass_milligrams = 5000,
        volume_ml = 15,
        price_cents = 0,
        price_postapoc_cents = 25,
        symbol = ")",
        color = "white",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "condom" },
        menu_text = ccb.content.text("Open"),
        message = ccb.content.text("You rip open the wrapped condom."),
    }
    item:clear_flags()
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_medium_drying_active",
        category = "other",
        name = ccb.content.plural_text("50 gallon aquarium (drying)", "50 gallon aquariums (drying)"),
        description = ccb.content.text("A 50-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_medium",
        mass_milligrams = 45000000,
        volume_ml = 222000,
        longest_side_mm = 910,
        price_cents = 5000,
        price_postapoc_cents = 750,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
        countdown_turns = 604800,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:container_pocket {
        max_volume_ml = 189000,
        max_weight_milligrams = 300000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:transform_into { target = "aquarium_medium" }
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_small_drying_active",
        category = "other",
        name = ccb.content.plural_text("30 gallon aquarium (drying)", "30 gallon aquariums (drying)"),
        description = ccb.content.text("A 30-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_small",
        mass_milligrams = 22000000,
        volume_ml = 133000,
        longest_side_mm = 910,
        price_cents = 1500,
        price_postapoc_cents = 350,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
        countdown_turns = 604800,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:container_pocket {
        max_volume_ml = 113000,
        max_weight_milligrams = 180000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:transform_into { target = "aquarium_small" }
    content.add(item)
end

do
    local item = content.Item {
        id = "aquarium_large_drying_active",
        category = "other",
        name = ccb.content.plural_text("100 gallon aquarium (drying)", "100 gallon aquariums (drying)"),
        description = ccb.content.text("A 100-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_large",
        mass_milligrams = 80000000,
        volume_ml = 400000,
        longest_side_mm = 1830,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
        countdown_turns = 604800,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:container_pocket {
        max_volume_ml = 378000,
        max_weight_milligrams = 500000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:transform_into { target = "aquarium_large" }
    content.add(item)
end
