local ccb = require("ccb")
local content = ccb.content

do
    -- M2A1/M2A2
    -- <https://www.cleanammocans.com/new-50-cal-m2a1-usgi-ammo-can.html>
    -- External: 29.85 x 15.24 x 19.05 cm, Internal: 27.94 x 13.97 x 17.78 cm
    local item = content.Item {
        id = "ammunition_can_50",
        name = ccb.content.plural_text("ammo can", "ammo cans"),
        copy_from = "ammunition_can_30",
        looks_like = "ammunition_can_30",
        mass_milligrams = 2360000,
        volume_ml = 8666,
        longest_side_mm = 299,
        price_cents = 1999,
        replace_pockets = true,
        variant_kind = "gun",
    }
    item:container_pocket {
        max_volume_ml = 6940,
        max_weight_milligrams = 80000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 279,
    }
    item:variants {
        { id = "ammunition_can_50_556tracer_820", name = ccb.content.plural_text("820 5.56mm ammo can", "820 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-155-5457 A063\n820 CRTGS 5.56MM\nTRACER M856</color>") },
        { id = "ammunition_can_50_50bmg_4fmj1tracer_100", name = ccb.content.plural_text("100 .50 ammo can", "100 .50 ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-00-028-6583 A557\n100 CRTG .50 CAL\nLINK M9\n4-BALL M33\n1-TRACER M17</color>") },
        { id = "ammunition_can_50_50bmg_1tracer4mk211_100", name = ccb.content.plural_text("100 .50 ammo can", "100 .50 ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-249-6888 A607\n100 CRTG .50 CAL\nLINK M9\n4-MK 211 MOD 0\n1-M20 API TRACER</color>") },
        { id = "ammunition_can_50_50bmg_fmj_120", name = ccb.content.plural_text("120 .50 ammo can", "120 .50 ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-00-585-5191 A552\n120 CARTRIDGES\n.50 Browning BALL M33\nFMJ BT 625 gr</color>") },
        { id = "ammunition_can_50_556_m855a1_clipped_840", name = ccb.content.plural_text("840 5.56mm ammo can", "840 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-559-3333 AB57\n840 CARTRIDGES 5.56 MM\nBALL M855A1\n10 ROUND CLIPS</color>") },
        { id = "ammunition_can_50_308_600", name = ccb.content.plural_text("600 7.62mm ammo can", "600 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-00-257-1089 A143\n600 CARTRIDGES\n7.62MM BALL M80\nON LINK M13</color>") },
        { id = "ammunition_can_50_shot_160", name = ccb.content.plural_text("160 00 shot ammo can", "160 00 shot ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-232-8338 A011\n160 CRTGS 12 GA\nNO. 00 BUCKSHOT</color>") },
        { id = "ammunition_can_50_beanbag_160", name = ccb.content.plural_text("160 beanbag ammo can", "160 beanbag ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-454-0191 AA29\n160 CRTGS 12 GA BEAN BAG\nNON-LETHAL</color>") },
        { id = "ammunition_can_50_308fmj_460", name = ccb.content.plural_text("460 7.62mm ammo can", "460 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-41-8202 AA11\n460 CARTRIDGES\n7.62MM BALL M80\nCARTONS</color>") },
        { id = "ammunition_can_50_300jhp_240", name = ccb.content.plural_text("240 .300 win mag ammo can", "240 .300 win mag ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-018-1547 A191\n240 CARTRIDGES .300 WM\nMATCH GRADE\n220 GRAIN BULLET\nMk 248 Mod 1\"</color>") },
    }
    content.add(item)
end

do
    -- PA108 SAW
    -- <https://www.cleanammocans.com/2-pack-new-fat-50-pa108-saw-ammo-cans.html>
    -- External: 31.75 x 18.42 x 21.59 cm, Internal: 29.85 x 17.15 x 20.96 cm
    local item = content.Item {
        id = "ammunition_can_fat_50",
        name = ccb.content.plural_text("big ammo can", "big ammo cans"),
        copy_from = "ammunition_can_30",
        looks_like = "ammunition_can_30",
        mass_milligrams = 2990000,
        volume_ml = 12627,
        longest_side_mm = 318,
        price_cents = 1999,
        replace_pockets = true,
        variant_kind = "gun",
    }
    item:container_pocket {
        max_volume_ml = 10730,
        max_weight_milligrams = 120000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 298,
    }
    item:variants {
        { id = "ammunition_can_fat_50_223_1tracer4ball_800", name = ccb.content.plural_text("800 5.56mm ammo can", "800 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-533-5663 AB03\n800 CRTG 5.56MM\n4 BALL M855\n1 TRACER M856\nM27 LINK</color>") },
        { id = "ammunition_can_fat_50_223_1tracer4ap_800", name = ccb.content.plural_text("800 5.56mm ammo can", "800 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-393-7052 AA02\n800 CRTG 5.56MM\n4 AP M995\n1 TRACER M856\nM27 LINK</color>") },
        { id = "ammunition_can_fat_50_223ap_800", name = ccb.content.plural_text("800 5.56mm ammo can", "800 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-393-7050 AA01\n800 CRTG 5.56MM\n5 AP M995\nM27 LINK</color>") },
        { id = "ammunition_can_fat_50_223fmj_800", name = ccb.content.plural_text("800 5.56mm ammo can", "800 5.56mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-258-8692 A062\n800 CRTG 5.56MM\n BALL M855\nM27 LINK</color>") },
        { id = "ammunition_can_fat_50_308_1tracer4ap_600", name = ccb.content.plural_text("600 7.62mm ammo can", "600 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-00-209-5139 A127\n600 CARTRIDGES 7.62 mm\n4 BALL M80\n1 TRACER M62\nON LINK M13</color>") },
    }
    content.add(item)
end

do
    -- PA-120
    -- <https://www.cleanammocans.com/2-pack-40mm-ammo-cans.html>
    -- External: 46.99 x 15.56 x 25.40 cm, Internal: 43.82 x 13.97 x 24.13 cm
    local item = content.Item {
        id = "ammunition_can_pa120",
        name = ccb.content.plural_text("heavy-duty ammo can", "heavy-duty ammo cans"),
        copy_from = "ammunition_can_30",
        looks_like = "ammunition_can_30",
        description = ccb.content.text("A huge metal box with handles on each end.  It is almost inconveniently big, but can hold a lot of heavy items inside."),
        mass_milligrams = 6350000,
        volume_ml = 18572,
        longest_side_mm = 470,
        price_cents = 2500,
        replace_pockets = true,
        variant_kind = "gun",
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 14772,
        max_weight_milligrams = 160000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 438,
    }
    item:variants {
        { id = "ammunition_can_pa120_40x53_32", name = ccb.content.plural_text("48 40mm ammo can", "48 40mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1310-01-159-8043 B542\n32 CARTRIDGES 40 MM HEDP\nHIGH EXPLOSIVE DUAL PURPOSE M433 LINKED</color>") },
    }
    content.add(item)
end

do
    -- PA-124
    -- 307.34 x 158.75 x 485.14 mm
    local item = content.Item {
        id = "ammunition_can_pa124",
        name = ccb.content.plural_text("heavy-duty ammo can", "heavy-duty ammo cans"),
        copy_from = "ammunition_can_30",
        looks_like = "ammunition_can_30",
        description = ccb.content.text("A huge metal box with handles on each end.  It is almost inconveniently big, but can hold a lot of heavy items inside."),
        mass_milligrams = 4082000,
        volume_ml = 23670,
        longest_side_mm = 470,
        price_cents = 2500,
        replace_pockets = true,
        variant_kind = "gun",
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 14772,
        max_weight_milligrams = 160000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 438,
    }
    item:variants {
        { id = "ammunition_can_pa124_60mm_m720a1_8", name = ccb.content.plural_text("8 60mm ammo can", "8 60mm ammo cans"), weight = 0, description = ccb.content.text("A solid, high metal box with a small handle on top.  Front side has printed:\n<color_yellow>1310-01-418-4362 BA16\n8 CARTRIDGE, 60 MM, HE, M720A1 W/FUZE MO M734A1 FOR\nM224 MORTAR</color>") },
        { id = "ammunition_can_pa124_60mm_m768_8", name = ccb.content.plural_text("8 60mm ammo can", "8 60mm ammo cans"), weight = 0, description = ccb.content.text("A solid, high metal box with a small handle on top.  Front side has printed:\n<color_yellow>1310-01-487-1944 BA17\n8 CARTRIDGE, 60 MM, HE, M768\nW/FUZE, PD/DLY, M783 FOR\nM224 MORTAR</color>") },
    }
    content.add(item)
end

do
    -- 84mm heat551 transport box, 610x400x290mm
    -- found no docs for HEDP crates, hence copy the hedp
    local item = content.Item {
        id = "ammunition_box_carlgustav",
        category = "container",
        name = ccb.content.plural_text("84mm HE crate", "84mm HE crates"),
        description = ccb.content.text("Relatively small metal box.  On one side it has label \"EXPLOSIVE\""),
        looks_like = "box_oversize_metal",
        mass_milligrams = 1400000,
        volume_ml = 70760,
        replace_pockets = true,
        symbol = "#",
        color = "dark_gray",
        variant_kind = "gun",
    }
    item:container_pocket { max_volume_ml = 69000, max_weight_milligrams = 200000000, rigid = true, watertight = true }
    item:material("steel", 1)
    item:variants {
        { id = "ammunition_box_carlgustav_he", name = ccb.content.plural_text("84mm HE crate", "84mm HE crates"), weight = 0, description = ccb.content.text("A big metal crate.  On one side it has label \"EXPLOSIVE\", and on another is written:\n<color_yellow>6 RDS 84MM HE</color>") },
        { id = "ammunition_box_carlgustav_hedp", name = ccb.content.plural_text("84mm HEDP crate", "84mm HEDP crates"), weight = 0, description = ccb.content.text("A big metal crate.  On one side it has label \"EXPLOSIVE\", and on another is written:\n<color_yellow>6 RDS 84MM HEDP</color>") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ammunition_crate_40x46_72",
        copy_from = "box_medium_wood",
        looks_like = "box_medium_wood",
        name = ccb.content.plural_text("wooden crate", "wooden crates"),
        description = ccb.content.text("Huge wooden crate, closed with metal wire."),
        replace_pockets = true,
        color = "light_gray",
        symbol = "#",
        variant_kind = "gun",
    }
    item:container_pocket { max_volume_ml = 10000, max_weight_milligrams = 40000000, rigid = true }
    item:variants {
        { id = "ammunition_crate_40x46_72", name = ccb.content.plural_text("72 40mm ammo crate", "72 40mm ammo crates"), weight = 0, description = ccb.content.text("Huge wooden crate, closed with metal wire.  Front side has printed:\n<color_yellow>1310-00-992-0451 B546\n72 CARTRIDGE COMP A-5\n40 MM HEDP M433</color>") },
    }
    content.add(item)
end

do
    -- 30x223 clips or 50x223 or 20x300
    local item = content.Item {
        id = "ammo_box_army_3_clips",
        name = ccb.content.plural_text("cardboard ammo box", "cardboard ammo boxes"),
        description = ccb.content.text("A small brown box without a cover."),
        category = "container",
        symbol = "#",
        color = "brown",
        mass_milligrams = 28000,
        volume_ml = 235,
        replace_pockets = true,
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 230, max_weight_milligrams = 1600000, rigid = true, max_item_length_mm = 100 }
    content.add(item)
end

do
    -- todo: replace with some better rubber material
    local item = content.Item {
        id = "55gal_drum_rubber",
        category = "container",
        name = ccb.content.plural_text("collapsible drum", "collapsible drums"),
        description = ccb.content.text("A beige collapsible drum with a water valve and D-Rings.  Text on its top clearly says \"POTABLE WATER ONLY\"."),
        mass_milligrams = 16000000,
        volume_ml = 23000,
        price_cents = 39500,
        price_postapoc_cents = 250,
        symbol = "0",
        color = "yellow",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("rubber", 9)
    item:material("steel", 1)
    item:quality("CONTAIN", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 500000000, watertight = true, rigid = false }
    content.add(item)
end

do
    -- todo: replace with some better rubber material
    local item = content.Item {
        id = "432gal_drum_rubber",
        category = "container",
        name = ccb.content.plural_text("big collapsible drum", "big collapsible drums"),
        description = ccb.content.text("A black collapsible drum with a valve and D-Rings.  Yellow text on its top clearly says \"FLAMMABLE\".  Empty and collapsed, it could be moved elsewhere."),
        mass_milligrams = 125000000,
        volume_ml = 180000,
        price_cents = 39500,
        price_postapoc_cents = 250,
        symbol = "0",
    }
    item:clear_use_actions()
    item:deploy_furniture("f_432gal_drum_rubber")
    item:material("rubber", 9)
    item:material("steel", 1)
    content.add(item)
end
