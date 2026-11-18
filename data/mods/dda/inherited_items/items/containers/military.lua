local ccb = require("ccb")
local content = ccb.content

do
    -- 84mm heat 551 container, 265x700x124mm
    local item = content.Item {
        id = "ammunition_can_carlgustav",
        category = "container",
        name = ccb.content.plural_text("double 84mm HEDP container", "double 84mm HEDP containers"),
        description = ccb.content.text("Huge metal container, in a shape of two massive rockets."),
        mass_milligrams = 1400000,
        volume_ml = 23000,
        replace_pockets = true,
        symbol = "8",
        color = "dark_gray",
        variant_kind = "gun",
    }
    item:container_pocket {
        max_volume_ml = 2422,
        max_weight_milligrams = 5000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 437,
    }
    item:container_pocket {
        max_volume_ml = 2422,
        max_weight_milligrams = 5000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 437,
    }
    item:material("steel", 1)
    item:variants {
        { id = "ammunition_can_carlgustav_hedp", name = ccb.content.plural_text("double 84mm HEDP container", "double 84mm HEDP containers"), weight = 0, description = ccb.content.text("A heavy and bulky container in a shape of two recoilless rifle rounds.  Text on the front says:\n<color_yellow>1 RD\n84MM HEDP 502\n1315-01-343-1944</color>\n\n<color_red>EXPLOSIVE</color>") },
        { id = "ammunition_can_carlgustav_he", name = ccb.content.plural_text("double 84mm HE container", "double 84mm HE containers"), weight = 0, description = ccb.content.text("A heavy and bulky container in a shape of two recoilless rifle rounds.  Text on the front says:\n<color_yellow>1 RD\n84MM HE 441D</color>\n\n<color_red>EXPLOSIVE</color>") },
    }
    content.add(item)
end

do
    -- M19A1
    -- <https://www.cleanammocans.com/new-m19a1-30-cal-ammo-can.html>
    -- External: 29.85 x 9.53 x 17.78 cm, Internal: 25.4 x 8.9 x 16.5 cm
    -- every ammo can contain o-ring, which should've been reflected by 1/50 of rubber material, but in this case the thing simply burn out into pure scrap, and there is no flag to prevent it
    -- dodic code is unknown
    -- LDD stands for LOADED
    local item = content.Item {
        id = "ammunition_can_30",
        category = "container",
        name = ccb.content.plural_text("small ammo can", "small ammo cans"),
        looks_like = "box_small_metal",
        description = ccb.content.text("A solid metal ammo box with a small handle on top and shabby yellow text printed on the side."),
        mass_milligrams = 1680000,
        volume_ml = 5058,
        longest_side_mm = 299,
        price_cents = 1930,
        price_postapoc_cents = 10,
        replace_pockets = true,
        symbol = "#",
        color = "light_gray",
        variant_kind = "gun",
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:container_pocket {
        max_volume_ml = 3730,
        max_weight_milligrams = 50000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 254,
    }
    item:material("steel", 1)
    item:variants {
        { id = "ammunition_can_30_9mm_fmj_1000", name = ccb.content.plural_text("1000 9x19mm FMJ ammo can", "1000 9x19mm FMJ ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-172-9558 A363\n1000 CRTG 9 MM\nBALL M882</color>") },
        { id = "ammunition_can_30_9mm_P_1000", name = ccb.content.plural_text("1000 9x19mm FMJ ammo can", "1000 9x19mm FMJ ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-663-9409\n1000 CRTG 9 MM\nBALL M1152</color>") },
        { id = "ammunition_can_30_9mm_jhp_1000", name = ccb.content.plural_text("1000 9x19mm JHP ammo can", "1000 9x19mm JHP ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-357-8488 A260\n1000 CARTRIDGES 9 MM\nSUBSONIC</color>") },
        { id = "ammunition_can_30_300AAC_otmss_720", name = ccb.content.plural_text("720 .300 AAC ammo can", "720 .300 AAC ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-651-3478 A001\n720 CARTRIDGES 7.62 x 35mm (300AAC)\n125 OTMSS OPEN TIP MATCH SUBSONIC</color>") },
        { id = "ammunition_can_30_308_1tracer4ap_200", name = ccb.content.plural_text("200 7.62mm ammo can", "200 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-398-1449 AA04\n200 CARTRIDGES 7.62 mm\n4 AP M993\n1 TRACER M62\nON LINK M13</color>") },
        { id = "ammunition_can_30_308ap_240", name = ccb.content.plural_text("240 7.62mm ammo can", "240 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-398-1450 AA03\n240 CARTRIDGES 7.62 mm\nAP M993</color>") },
        { id = "ammunition_can_30_308_4fmj1tracer_200", name = ccb.content.plural_text("200 7.62mm ammo can", "200 7.62mm ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-00-892-2150\n200 CARTRIDGES 7.62 mm\n4 BALL M80\n1 TRACER M62\nON LINK M13</color>") },
        { id = "ammunition_can_30_shot_120", name = ccb.content.plural_text("120 slug ammo can", "120 slug ammo cans"), weight = 0, description = ccb.content.text("A solid metal ammo box with a small handle on top.  Front side has printed:\n<color_yellow>1305-01-386-5604 A023\n120 CRTGS 12 GA\n1 OZ SLUG LDD</color>") },
    }
    content.add(item)
end

do
    -- cylinder of 393.7 mm H x 76.2 mm W
    local item = content.Item {
        id = "ammunition_tube_mortar",
        category = "container",
        name = ccb.content.plural_text("mortar container", "mortar containers"),
        description = ccb.content.text("A small, thick cylindrical container.  Designed to store a single mortar round."),
        mass_milligrams = 272000,
        volume_ml = 1795,
        replace_pockets = true,
        symbol = "0",
        color = "dark_gray",
        variant_kind = "gun",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 1500, max_weight_milligrams = 3000000, rigid = true, max_item_length_mm = 390 }
    item:variants {
        { id = "ammunition_tube_mortar_m720a1", name = ccb.content.plural_text("mortar container", "mortar containers"), weight = 0, description = ccb.content.text("A long, thick cylindrical container.  Dark, shabby surface has printed:\nCOMP B\nB643\nCARTRIDGE 60MM HE\nW/FUZE MO M734A1\nFOR M224 MORTAR") },
        { id = "ammunition_tube_mortar_m768", name = ccb.content.plural_text("mortar container", "mortar containers"), weight = 0, description = ccb.content.text("A long, thick cylindrical container.  Dark, shabby surface has printed:\nCOMP B\nB643\nCARTRIDGE 60MM HE\nW/FUZE PD M783\nFOR M224 MORTAR") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ammunition_box_grenade",
        category = "container",
        name = ccb.content.plural_text("grenade container", "grenade containers"),
        description = ccb.content.text("A small, thick cylindrical container.  Designed to store a single grenade, it seems."),
        mass_milligrams = 411000,
        volume_ml = 590,
        replace_pockets = true,
        symbol = "0",
        color = "dark_gray",
        variant_kind = "gun",
    }
    item:material("cardboard", 1)
    item:container_pocket { max_volume_ml = 550, max_weight_milligrams = 5000000, rigid = true }
    item:variants {
        { id = "ammunition_box_grenade_m67", name = ccb.content.plural_text("grenade container", "grenade containers"), weight = 0, description = ccb.content.text("A small, thick cylindrical container.  Dark, shabby surface has printed:\n1330-00-133-8244 G881\nCOMP B 1 GRENADE HAND FRAG DELAY M67 W/FUZE M213\nCONTAINER M415A1 UAC") },
    }
    content.add(item)
end
