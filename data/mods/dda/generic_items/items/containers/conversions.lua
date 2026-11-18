local ccb = require("ccb")
local content = ccb.content

do
    -- External dimensions, (10x16x71)
    local item = content.Item {
        id = "box_retool_huge",
        category = "container",
        looks_like = "box_small",
        name = ccb.content.plural_text("marksmen's conversion kit", "marksmen's conversion kits"),
        description = ccb.content.text("This is an expansive cardboard box, stamped with manufacturer markings and emblazoned with the stylized image of an assembled high-caliber rifle.  Containing appropriate retool components for a larger than typical given weapon platform, including big-bore upper receiver assemblies, quick-swap sniper barrels, and assorted extras (such as magazines), its contents could be used to rechamber a compatible rifle."),
        mass_milligrams = 600000,
        volume_ml = 11360,
        longest_side_mm = 710,
        price_cents = 15,
        price_postapoc_cents = 15,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 7728, max_weight_milligrams = 35000000, rigid = true, max_item_length_mm = 690 }
    content.add(item)
end

do
    -- External dimensions, (10x16x56)
    local item = content.Item {
        id = "box_retool_large",
        category = "container",
        looks_like = "box_small",
        name = ccb.content.plural_text("large rifle conversion kit", "large rifle conversion kits"),
        description = ccb.content.text("This is a large cardboard box, stamped with manufacturer markings and emblazoned with the stylized image of a large, assembled rifle.  Containing appropriate retool components for a given weapon platform, including high-caliber upper receiver assemblies, quick-swap marksman barrels, and assorted extras (such as magazines), its contents could be used to rechamber a compatible rifle."),
        mass_milligrams = 500000,
        volume_ml = 8960,
        longest_side_mm = 560,
        price_cents = 15,
        price_postapoc_cents = 15,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 6272, max_weight_milligrams = 30000000, rigid = true, max_item_length_mm = 540 }
    content.add(item)
end

do
    -- External dimensions, (10x16x43)
    local item = content.Item {
        id = "box_retool",
        category = "container",
        name = ccb.content.plural_text("standard rifle conversion kit", "standard rifle conversion kits"),
        looks_like = "box_small",
        description = ccb.content.text("This is a sturdy cardboard box, stamped with manufacturer markings and emblazoned with the stylized image of an assembled rifle.  Containing appropriate retool components for an average weapon platform, including upper receiver assemblies, swappable barrels, and assorted extras (such as magazines), its contents could be used to rechamber a compatible rifle."),
        mass_milligrams = 400000,
        volume_ml = 6880,
        longest_side_mm = 430,
        price_cents = 15,
        price_postapoc_cents = 15,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 4592, max_weight_milligrams = 25000000, rigid = true, max_item_length_mm = 410 }
    content.add(item)
end

do
    -- External dimensions, (10x16x37)
    local item = content.Item {
        id = "box_retool_sbr",
        category = "container",
        name = ccb.content.plural_text("SBR conversion kit", "SBR conversion kits"),
        looks_like = "box_small",
        description = ccb.content.text("This is a modestly proportioned cardboard box, stamped with manufacturer markings and emblazoned with the stylized image of an assembled, short-barreled rifle.  Containing appropriate retool components for a given weapon platform, including compact upper receiver assemblies, short quick-swap barrels, and assorted extras (such as magazines), its contents could be used to rechamber a compatible rifle."),
        mass_milligrams = 350000,
        volume_ml = 5920,
        longest_side_mm = 370,
        price_cents = 15,
        price_postapoc_cents = 15,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 3920, max_weight_milligrams = 20000000, rigid = true, max_item_length_mm = 350 }
    content.add(item)
end

do
    -- External dimensions, (10x16x27)
    local item = content.Item {
        id = "box_retool_sbr_micro",
        category = "container",
        name = ccb.content.plural_text("micro-carbine conversion kit", "micro-carbine conversion kits"),
        looks_like = "box_small",
        description = ccb.content.text("This is a relatively small cardboard box, stamped with manufacturer markings and emblazoned with the stylized image of an assembled, extremely compact carbine.  Containing appropriate retool components for a given weapon platform, including adorably small upper receiver assemblies, pistol-length swappable barrels, and assorted extras (such as magazines), its contents could be used to rechamber a compatible rifle."),
        mass_milligrams = 280000,
        volume_ml = 4320,
        longest_side_mm = 270,
        price_cents = 15,
        price_postapoc_cents = 15,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 2800, max_weight_milligrams = 15000000, rigid = true, max_item_length_mm = 250 }
    content.add(item)
end
