local ccb = require("ccb")
local content = ccb.content

do
    -- These variants must remain 0 weight, as most ammo boxes copy from this and inherit variants
    local item = content.Item {
        id = "9mm_ammo_box_20",
        category = "container",
        name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of 9mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 6000,
        volume_ml = 70,
        replace_pockets = true,
        symbol = "#",
        color = "brown",
        looks_like = "box_small",
        variant_kind = "generic",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 46, max_weight_milligrams = 240000, rigid = true }
    item:variants {
        { id = "22lr_ammo_box_50", name = ccb.content.plural_text(".22 LR ammo box", ".22 LR ammo boxes"), description = ccb.content.text("This box holds 50 rounds of .22 LR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "9mm_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of 9mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 15000,
        volume_ml = 160,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 115, max_weight_milligrams = 600000, rigid = true }
    item:variants {
        { id = "ammo_box_army_50_9mm_P", name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"), description = ccb.content.text("A small, plain brown ammo box.  Black text printed on the front says \"\n50 CARTRIDGES\n9MM BALL\nM1152\"") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "9mm_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of 9mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 29000,
        volume_ml = 300,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 230, max_weight_milligrams = 1200000, rigid = true }
    item:variants {
        { id = "ammo_box_army_100_9mm_jhp", name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"), description = ccb.content.text("A small, plain brown ammo box.  Black text printed on the front says \"100 ROUNDS 9x19MM PARA JHP JACKED HOLLOW POINT 116GR.\""), weight = 0 },
        { id = "ammo_box_army_100_9mm_fmj", name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"), description = ccb.content.text("A small, plain brown ammo box.  Black text printed on the front says \"100 ROUNDS 9x19MM PARA FMJ FULL METAL JACKED 115GR.\""), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "9mm_ammo_box_250",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("9mm ammo box", "9mm ammo boxes"),
        description = ccb.content.text("This box holds 250 rounds of 9mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 73000,
        volume_ml = 680,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 575, max_weight_milligrams = 3000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "22lr_ammo_tray",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".22 LR ammo tray", ".22 LR ammo trays"),
        description = ccb.content.text("A small plastic tray, meant to hold 50 rounds of .22 LR ammo."),
        mass_milligrams = 5000,
        volume_ml = 46,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket {
        max_volume_ml = 33,
        max_weight_milligrams = 200000,
        max_item_length_mm = 26,
        max_item_volume_ml = 1,
        rigid = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "22lr_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".22 LR ammo box", ".22 LR ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of 22 LR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 11000,
        volume_ml = 117,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 92, max_weight_milligrams = 500000, rigid = true }
    item:variants {
        { id = "380_ammo_box_50", name = ccb.content.plural_text(".380 ACP ammo box", ".380 ACP ammo boxes"), description = ccb.content.text("This box holds 50 rounds of .380 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "22lr_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".22 LR ammo box", ".22 LR ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of 22 LR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 57000,
        volume_ml = 540,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 460, max_weight_milligrams = 2000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "22lr_ammo_box_1000",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".22 LR ammo box", ".22 LR ammo boxes"),
        description = ccb.content.text("This box holds 1000 rounds of 22 LR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 126000,
        volume_ml = 1150,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1100, max_weight_milligrams = 4000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "223_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".223/5.56 ammo box", ".223/5.56 ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .223 or 5.56 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 11000,
        volume_ml = 125,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 83, max_weight_milligrams = 360000, rigid = true, max_item_length_mm = 74 }
    item:variants {
        { id = "300blk_ammo_box_20", name = ccb.content.plural_text(".300 Blackout ammo box", ".300 Blackout ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .300 Blackout ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
        { id = "ammo_box_army_20_223", name = ccb.content.plural_text("5.56x45mm ammo box", "5.56x45mm ammo boxes"), description = ccb.content.text("A small plain brown ammo box.  Black text printed on the front says \"20 CARTRIDGES 5.56MM TRACER M856\""), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "223_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".223/5.56 ammo box", ".223/5.56 ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .223 or 5.56 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 26000,
        volume_ml = 290,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 207, max_weight_milligrams = 900000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "223_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".223/5.56 ammo box", ".223/5.56 ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .223 or 5.56 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 104000,
        volume_ml = 1073,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 826, max_weight_milligrams = 3600000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "45_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 ACP ammo box", ".45 ACP ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .45 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 9000,
        volume_ml = 113,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 75, max_weight_milligrams = 420000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "45_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 ACP ammo box", ".45 ACP ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .45 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 24000,
        volume_ml = 260,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 187, max_weight_milligrams = 1050000, rigid = true }
    item:variants {
        { id = "77x58_ammo_box_20", name = ccb.content.plural_text("7.7x58mm Arisaka ammo box", "7.7x58mm Arisaka ammo boxes"), description = ccb.content.text("This box holds 20 rounds of 7.7x58mm Arisaka ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "45_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 ACP ammo box", ".45 ACP ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .45 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 94000,
        volume_ml = 970,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 747, max_weight_milligrams = 4200000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "45_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 ACP ammo box", ".45 ACP ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of .45 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 236000,
        volume_ml = 2240,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1867, max_weight_milligrams = 10500000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "380_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".380 ACP ammo box", ".380 ACP ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .380 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 5000,
        volume_ml = 54,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 36, max_weight_milligrams = 200000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "380_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".380 ACP ammo box", ".380 ACP ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of .380 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 112000,
        volume_ml = 1060,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 890, max_weight_milligrams = 5000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "40_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".40 S&W ammo box", ".40 S&W ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .40 S&W ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 7000,
        volume_ml = 80,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 53, max_weight_milligrams = 300000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "40_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".40 S&W ammo box", ".40 S&W ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .40 S&W ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 17000,
        volume_ml = 173,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 133, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "40_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".40 S&W ammo box", ".40 S&W ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of .40 S&W ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 167000,
        volume_ml = 1590,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1325, max_weight_milligrams = 7500000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("7.62x39 ammo box", "7.62x39 ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of 7.62x39mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 14000,
        volume_ml = 170,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 114, max_weight_milligrams = 320000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("7.62x39 ammo box", "7.62x39 ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of 7.62x39mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 36000,
        volume_ml = 370,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 284, max_weight_milligrams = 800000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("7.62x39mm ammo box", "7.62x39mm ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of 7.62x39mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 359000,
        volume_ml = 3400,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 2840, max_weight_milligrams = 8000000, rigid = true }
    item:variants {
        { id = "762R_ammo_box_200", name = ccb.content.plural_text("7.62x54mmR ammo box", "7.62x54mmR ammo boxes"), description = ccb.content.text("This box holds 200 rounds of 7.62x54mmR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "357_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".357 Magnum ammo box", ".357 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .357 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 7000,
        volume_ml = 81,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 58, max_weight_milligrams = 260000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "357_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".357 Magnum ammo box", ".357 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .357 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 18000,
        volume_ml = 175,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 145, max_weight_milligrams = 650000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "357_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".357 Magnum ammo box", ".357 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .357 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 73000,
        volume_ml = 640,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 580, max_weight_milligrams = 2600000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "12_ammo_box_5",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"),
        description = ccb.content.text("This box holds 5 rounds of 12 gauge ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 12000,
        volume_ml = 148,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 95, max_weight_milligrams = 400000, rigid = true }
    item:variants {
        { id = "ammo_box_army_5_shot", name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"), description = ccb.content.text("A small plain brown ammo box.  Black text printed on the front says \"5 CARTRIDGES 12 GA SHOTSHELL NO. 00 BUCKSHOT\""), weight = 0 },
        { id = "ammo_box_army_5_slug", name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"), description = ccb.content.text("A small plain brown ammo box.  Black text printed on the front says \"5 CARTRIDGES 12 GA SHOTSHELL SLUG\""), weight = 0 },
        { id = "ammo_box_army_5_beanbag", name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"), description = ccb.content.text("A small plain brown ammo box.  Black text printed on the front says \"5 CARTRIDGES 12 GA SHOTSHELL BEANBAG\""), weight = 0 },
        { id = "20_ammo_box_5", name = ccb.content.plural_text("20 gauge ammo box", "20 gauge ammo boxes"), description = ccb.content.text("This box holds 5 rounds of 20 gauge shells.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo"), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "12_ammo_box_10",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"),
        description = ccb.content.text("This box holds 10 rounds of 12 gauge ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 28000,
        volume_ml = 307,
        variant_kind = "generic",
        replace_pockets = true,
    }
    item:variants {
        { id = "20_ammo_box_10", name = ccb.content.plural_text("20 gauge ammo box", "20 gauge ammo boxes"), description = ccb.content.text("This box holds 10 rounds of 20 gauge shells.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo"), weight = 0 },
    }
    item:container_pocket { max_volume_ml = 190, max_weight_milligrams = 800000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "12_ammo_box_25",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"),
        description = ccb.content.text("This box holds 25 rounds of 12 gauge ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 70000,
        volume_ml = 578,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 472, max_weight_milligrams = 1175000, max_item_length_mm = 140, rigid = true }
    item:variants {
        { id = "ammo_box_army_10_50bmg", name = ccb.content.plural_text(".50 BMG ammo box", ".50 BMG ammo boxes"), description = ccb.content.text("A small painted in white ammo box.  Black text printed on the front says \"10 CARTRIDGES\n12.7x99MM BALL M33\n(50 Browning)\""), weight = 0 },
        { id = "20_ammo_box_25", name = ccb.content.plural_text("20 gauge ammo box", "20 gauge ammo boxes"), description = ccb.content.text("This box holds 25 rounds of 20 gauge shells.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo"), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "12_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("12 gauge ammo box", "12 gauge ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of 12 gauge ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 228000,
        volume_ml = 2400,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1885, max_weight_milligrams = 4700000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "308_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".308/7.62x51 ammo box", ".308/7.62x51 ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .308/7.62x51 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 20000,
        volume_ml = 230,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 158, max_weight_milligrams = 400000, max_item_length_mm = 140, rigid = true }
    item:variants {
        { id = "ammo_box_army_20_308", name = ccb.content.plural_text("7.62x51mm ammo box", "7.62x51mm ammo boxes"), description = ccb.content.text("A small, plain brown ammo box.  Black text printed on the front says:\"20 ROUNDS 7.62MM BALL M80\""), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "308_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".308/7.62x51 ammo box", ".308/7.62x51 ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of .308/7.62x51 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 100000,
        volume_ml = 950,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 790, max_weight_milligrams = 2000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "38_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".38 Special ammo box", ".38 Special ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .38 Special ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 7000,
        volume_ml = 85,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 57, max_weight_milligrams = 300000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "38_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".38 Special ammo box", ".38 Special ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .38 Special ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 18000,
        volume_ml = 200,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 142, max_weight_milligrams = 800000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "38_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".38 Special ammo box", ".38 Special ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .38 Special ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 71000,
        volume_ml = 734,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 565, max_weight_milligrams = 3000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "38_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".38 Special ammo box", ".38 Special ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of .38 Special ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 178000,
        volume_ml = 1550,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1413, max_weight_milligrams = 8000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "44_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".44 Magnum ammo box", ".44 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .44 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 11000,
        volume_ml = 130,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 90, max_weight_milligrams = 500000, max_item_length_mm = 100, rigid = true }
    item:variants {
        { id = "410_ammo_box_10", name = ccb.content.plural_text(".410 bore ammo box", ".410 bore ammo boxes"), description = ccb.content.text("This box holds 10 rounds of .410 bore ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
        { id = "545_ammo_box_20", name = ccb.content.plural_text("5.45x39mm ammo box", "5.45x39mm ammo boxes"), description = ccb.content.text("This box holds 20 rounds of 5.45x39mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "44_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".44 Magnum ammo box", ".44 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of .44 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 55000,
        volume_ml = 570,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 435, max_weight_milligrams = 2500000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "44_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".44 Magnum ammo box", ".44 Magnum ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .44 Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 110000,
        volume_ml = 1050,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 870, max_weight_milligrams = 2500000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "3006_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30-06 Springfield ammo box", ".30-06 Springfield ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .30-06 Springfield ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 24000,
        volume_ml = 288,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 192, max_weight_milligrams = 600000, rigid = true, max_item_length_mm = 160 }
    item:variants {
        { id = "762R_ammo_box_20", name = ccb.content.plural_text("7.62x54mmR ammo box", "7.62x54mmR ammo boxes"), description = ccb.content.text("This box holds 20 rounds of 7.62x54mmR ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
        { id = "270_ammo_box_20", name = ccb.content.plural_text(".270 Winchester ammo box", ".270 Winchester ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .270 Winchester ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "3006_ammo_box_100",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30-06 Springfield ammo box", ".30-06 Springfield ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of .30-06 Springfield ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 121000,
        volume_ml = 1250,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 960, max_weight_milligrams = 3000000, rigid = true }
    item:variants {
        { id = "270_ammo_box_100", name = ccb.content.plural_text(".270 Winchester ammo box", ".270 Winchester ammo boxes"), description = ccb.content.text("This box holds 100 rounds of .270 Winchester ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "3006_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30-06 Springfield ammo box", ".30-06 Springfield ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .30-06 Springfield ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 242000,
        volume_ml = 2300,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 1920, max_weight_milligrams = 6000000, rigid = true }
    item:variants {
        { id = "270_ammo_box_200", name = ccb.content.plural_text(".270 Winchester ammo box", ".270 Winchester ammo boxes"), description = ccb.content.text("This box holds 200 rounds of .270 Winchester ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "45colt_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 Colt ammo box", ".45 Colt ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .45 Colt ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 12000,
        volume_ml = 140,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 97, max_weight_milligrams = 500000, rigid = true }
    item:variants {
        { id = "9x18_ammo_box_50", name = ccb.content.plural_text("9x18mm ammo box", "9x18mm ammo boxes"), description = ccb.content.text("This box holds 50 rounds of 9x18mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "45colt_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45 Colt ammo box", ".45 Colt ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .45 Colt ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 30000,
        volume_ml = 310,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 238, max_weight_milligrams = 1250000, rigid = true }
    item:variants {
        { id = "50beowulf_ammo_box_20", name = ccb.content.plural_text(".50 Beowulf ammo box", ".50 Beowulf ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .50 Beowulf ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "410_ammo_box_5",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".410 bore ammo box", ".410 bore ammo boxes"),
        description = ccb.content.text("This box holds 5 rounds of .410 bore ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 5000,
        volume_ml = 65,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 43, max_weight_milligrams = 135000, rigid = true, max_item_length_mm = 100 }
    content.add(item)
end

do
    local item = content.Item {
        id = "410_ammo_box_25",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".410 bore ammo box", ".410 bore ammo boxes"),
        description = ccb.content.text("This box holds 25 rounds of .410 bore ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 27000,
        volume_ml = 280,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 213, max_weight_milligrams = 700000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "10mm_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("10mm Auto ammo box", "10mm Auto ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of 10mm Auto ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 7000,
        volume_ml = 87,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 59, max_weight_milligrams = 400000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "10mm_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("10mm Auto ammo box", "10mm Auto ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of 10mm Auto ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 19000,
        volume_ml = 206,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 147, max_weight_milligrams = 900000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "10mm_ammo_box_500",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("10mm Auto ammo box", "10mm Auto ammo boxes"),
        description = ccb.content.text("This box holds 500 rounds of 10mm Auto ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 185000,
        volume_ml = 1750,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1463, max_weight_milligrams = 9000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "300_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".300 Winchester Magnum ammo box", ".300 Winchester Magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .300 Winchester Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 43000,
        volume_ml = 316,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 226, max_weight_milligrams = 900000, rigid = true, max_item_length_mm = 110 }
    item:variants {
        { id = "458_ammo_box_20", name = ccb.content.plural_text(".458 Winchester Magnum ammo box", ".458 Winchester Magnum ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .458 Winchester Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
        { id = "ammo_box_army_20_300wm", name = ccb.content.plural_text(".300 Winchester Magnum ammo box", ".300 Winchester Magnum ammo boxes"), description = ccb.content.text("A small, plain brown ammo box.  Black text printed on the front says:\"20 CARTRIDGES  .300 WINCHESTER MAGNUM MATCH MK 248 MOD 1\""), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "303_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".303 British ammo box", ".303 British ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .303 British ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 36000,
        volume_ml = 402,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 287, max_weight_milligrams = 600000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "30carbine_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30 Carbine ammo box", ".30 Carbine ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .30 Carbine ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 20000,
        volume_ml = 208,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 160, max_weight_milligrams = 600000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "32_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".32 ACP ammo box", ".32 ACP ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .32 ACP ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 9000,
        volume_ml = 109,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 73, max_weight_milligrams = 400000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "338_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".338 Lapua Magnum ammo box", ".338 Lapua Magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .338 Lapua Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 41000,
        volume_ml = 458,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 327, max_weight_milligrams = 400000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "357sig_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".357 SIG ammo box", ".357 SIG ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .357 SIG ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 17000,
        volume_ml = 185,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 134, max_weight_milligrams = 750000, rigid = true }
    item:variants {
        { id = "762x25_ammo_box_50", name = ccb.content.plural_text("7.62x25mm ammo box", "7.62x25mm ammo boxes"), description = ccb.content.text("This box holds 50 rounds of 7.62x25mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "38super_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".38 Super ammo box", ".38 Super ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of .38 Super ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 15000,
        volume_ml = 165,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 122, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "450_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".450 Bushmaster ammo box", ".450 Bushmaster ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .450 Bushmaster ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 18000,
        volume_ml = 203,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 145, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "454_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".454 Casull ammo box", ".454 Casull ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .454 Casull ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 13000,
        volume_ml = 157,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 106, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "4570_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".45-70 ammo box", ".45-70 ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .45-70 ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 21000,
        volume_ml = 234,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 167, max_weight_milligrams = 900000, max_item_length_mm = 100, rigid = true }
    item:variants {
        { id = "500_ammo_box_20", name = ccb.content.plural_text(".500 S&W Magnum ammo box", ".500 S&W Magnum ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .500 S&W Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
        { id = "ammo_box_army_10_338", name = ccb.content.plural_text(".338 Lapua Magnum ammo box", ".338 Lapua Magnum ammo boxes"), description = ccb.content.text("A small painted in white ammo box.  Black text printed on the front says:\n10 CARTRIDGES\n.338 LAPUA MAG.\nSWISS P TARGET\nHPBT."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "57_ammo_box_50",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text("5.7x28mm ammo box", "5.7x28mm ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of 5.7x28mm ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 13000,
        volume_ml = 143,
        replace_pockets = true,
        variant_kind = "generic",
    }
    item:container_pocket { max_volume_ml = 102, max_weight_milligrams = 750000, rigid = true }
    item:variants {
        { id = "50AE_ammo_box_20", name = ccb.content.plural_text(".50 Action Express ammo box", ".50 Action Express ammo boxes"), description = ccb.content.text("This box holds 20 rounds of .50 Action Express ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "460_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".460 S&W Magnum ammo box", ".460 S&W Magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .460 S&W Magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 17000,
        volume_ml = 189,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 135, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "3030_ammo_box_20",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30-30 Winchester ammo box", ".30-30 Winchester ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of .30-30 Winchester ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 10000,
        volume_ml = 164,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 117, max_weight_milligrams = 750000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "3030_ammo_box_200",
        copy_from = "9mm_ammo_box_20",
        looks_like = "9mm_ammo_box_20",
        name = ccb.content.plural_text(".30-30 Winchester ammo box", ".30-30 Winchester ammo boxes"),
        description = ccb.content.text("This box holds 200 rounds of .30-30 Winchester ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 100000,
        volume_ml = 1640,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 1170, max_weight_milligrams = 7500000, rigid = true }
    content.add(item)
end
