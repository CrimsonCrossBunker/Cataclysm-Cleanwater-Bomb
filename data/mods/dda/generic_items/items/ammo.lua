local ccb = require("ccb")
local content = ccb.content

do
    -- Density of 2.7 g/cm3
    local item = content.Item {
        id = "aluminum_foil",
        stackable = true,
        stack_size = 200,
        category = "spare_parts",
        price_cents = 648,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("aluminum foil", "aluminum foil"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A sheet of thin foil made of aluminum.  Sometimes called 'tin foil' due to being made of tin in the past."),
        volume_ml = 10,
        mass_milligrams = 135,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    -- 12 AWG copper wire plus 0.5 mm of wrap, so 7.364 mm2 * 30 cm (2.2092 ml).
    local item = content.Item {
        id = "cable",
        category = "spare_parts",
        price_cents = 96,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("copper wire", "copper wires"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A length of plastic-jacketed copper cable, of the type used in small electronics."),
        volume_ml = 2,
        mass_milligrams = 10000,
        longest_side_mm = 300,
        display_type = "BY_LENGTH",
        stackable = true,
    }
    item:material("copper", 67)
    item:material("plastic", 33)
    content.add(item)
end

do
    -- 12 AWG copper wire, 3.34 mm2 * 30 cm (1.002 ml), 30.6 kg/km (9.18 grams).
    local item = content.Item {
        id = "copper_wire",
        category = "spare_parts",
        price_cents = 47,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("raw copper wire", "raw copper wires"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A length of copper wire ready to be covered with plastic."),
        volume_ml = 1,
        mass_milligrams = 9000,
        longest_side_mm = 300,
        display_type = "BY_LENGTH",
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "feather",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("feather", "feathers"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A feather from a bird.  Useful for fletching arrows."),
        volume_ml = 50,
        mass_milligrams = 500,
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "down_feather",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("handful of down feathers", "handfuls of down feather"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A handful of fluffy down feather from a bird.  Useful for making cozy bedclothes."),
        volume_ml = 102,
        mass_milligrams = 102,
        stackable = true,
    }
    item:material("down_feathers", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_shotgun",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("smokeless shotgun powder", "smokeless shotgun powder"),
        description = ccb.content.text("Firearm-quality gunpowder intended for use in shotgun shells."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_pistol",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("smokeless pistol powder", "smokeless pistol powder"),
        description = ccb.content.text("Firearm-quality gunpowder intended for use in pistol ammunition."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_magnum_pistol",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("smokeless magnum powder", "smokeless magnum powder"),
        description = ccb.content.text("Firearm-quality gunpowder intended for use in magnum pistol ammunition."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_rifle",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("smokeless rifle powder", "smokeless rifle powder"),
        description = ccb.content.text("Firearm-quality gunpowder intended for use in rifle ammunition."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_large_rifle",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("smokeless overbore rifle powder", "smokeless overbore rifle powder"),
        description = ccb.content.text("Firearm-quality gunpowder intended for use in large rifle ammunition."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gunpowder_artillery",
        copy_from = "gunpowder",
        looks_like = "gunpowder",
        price_cents = 3000,
        price_postapoc_cents = 2500,
        name = ccb.content.plural_text("artillery propellant", "artillery propellant"),
        description = ccb.content.text("Single base smokeless gunpowder intended for use in artillery propelling charges."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lye_powder",
        stackable = true,
        category = "chems",
        price_cents = 3000,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("lye powder", "lye powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("Powdered caustic soda, also known as sodium hydroxide."),
        volume_ml = 1,
        mass_milligrams = 2662,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spent_shotgun_primer",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("spent shotgun primer", "spent shotgun primers"),
        symbol = "-",
        color = "dark_gray",
        description = ccb.content.text("A primer from a shotgun shell.  It has been fired, and must be cleaned and reloaded to use again."),
        volume_ml = 1,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spent_smpistol_primer",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("spent small pistol primer", "spent small pistol primers"),
        symbol = "-",
        color = "dark_gray",
        description = ccb.content.text("A primer from a small-caliber pistol round.  It has been fired, and must be cleaned and reloaded to use again."),
        volume_ml = 1,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spent_lgpistol_primer",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("spent large pistol primer", "spent large pistol primers"),
        symbol = "-",
        color = "dark_gray",
        description = ccb.content.text("A primer from a large-caliber pistol round.  It has been fired, and must be cleaned and reloaded to use again."),
        volume_ml = 1,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("steel", 1)
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spent_smrifle_primer",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("spent small rifle primer", "spent small rifle primers"),
        symbol = "-",
        color = "dark_gray",
        description = ccb.content.text("A primer from a small-caliber rifle round.  It has been fired, and must be cleaned and reloaded to use again."),
        volume_ml = 1,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "spent_lgrifle_primer",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("spent large rifle primer", "spent large rifle primers"),
        symbol = "-",
        color = "dark_gray",
        description = ccb.content.text("A primer from a large-caliber rifle round.  It has been fired, and must be cleaned and reloaded to use again."),
        volume_ml = 1,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rubber_slug",
        category = "spare_parts",
        price_cents = 1000,
        price_postapoc_cents = 250,
        name = ccb.content.plural_text("rubber slug", "rubber slugs"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A rubber slug from a shotgun beanbag round.  You could use it to make a new beanbag round."),
        volume_ml = 250,
        mass_milligrams = 2000,
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chunk_rubber",
        category = "spare_parts",
        price_cents = 75,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("chunk of rubber", "chunks of rubber"),
        symbol = "*",
        color = "dark_gray",
        description = ccb.content.text("A chunk of useful rubber that can be molded easily."),
        volume_ml = 250,
        mass_milligrams = 38000,
        stackable = true,
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- 200*5g / 8.63g/ml = ~115.87ml. Add 10% to take an uneven chunk into account = 127.46ml rounded upwards to 128ml.
    local item = content.Item {
        id = "copper",
        stackable = true,
        stack_size = 200,
        category = "spare_parts",
        price_cents = 7,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("copper", "copper"),
        symbol = "=",
        color = "yellow",
        description = ccb.content.text("Some scrap bits of copper.  Could be used to craft things, such as makeshift ammunition."),
        volume_ml = 1,
        mass_milligrams = 5000,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    -- 25 x 200 x 0.2 mm per unit, 5 meters roll is 25 units
    local item = content.Item {
        id = "medical_tape",
        category = "spare_parts",
        price_cents = 2000,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("medical tape", "medical tape"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A roll of semi-opaque medical tape, intended to hold bandages in place.  Not as versatile as duct tape."),
        display_type = "BY_LENGTH",
        volume_ml = 1,
        mass_milligrams = 1000,
        longest_side_mm = 200,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- An individual lamella is roughly 3cm x 6cm x 1mm in size.
    local item = content.Item {
        id = "lamellae_lc",
        category = "spare_parts",
        name = ccb.content.plural_text("mild steel lamella", "mild steel lamellae"),
        description = ccb.content.text("A pile of small 3 cm by 6 cm steel rectangles with a pattern of holes drilled into it.  For use in creating or repairing lamellar armor."),
        mass_milligrams = 14000,
        volume_ml = 100,
        price_cents = 1000,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "light_gray",
        stackable = true,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- An individual lamella is roughly 3cm x 6cm x 1mm in size.
    local item = content.Item {
        id = "lamellae_ch",
        category = "spare_parts",
        name = ccb.content.plural_text("hardened steel lamella", "hardened steel lamellae"),
        description = ccb.content.text("A pile of small 3 cm by 6 cm steel rectangles with a pattern of holes drilled into it, then hardened.  For use in creating or repairing hardened lamellar armor."),
        mass_milligrams = 14000,
        volume_ml = 100,
        price_cents = 1000,
        price_postapoc_cents = 60,
        symbol = ",",
        color = "light_gray",
        stackable = true,
    }
    item:material("ch_steel", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- link weighs 1/3 gram or so, make 425 links per 150 gram wire to account for loss
    local item = content.Item {
        id = "lc_chain_link",
        category = "spare_parts",
        price_cents = 150,
        price_postapoc_cents = 50,
        name = ccb.content.plural_text("mild steel chain link", "mild steel chain links"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A small metal ring, suitable for constructing chainmail."),
        volume_ml = 1,
        mass_milligrams = 320,
        stackable = true,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_chain_link",
        copy_from = "lc_chain_link",
        looks_like = "lc_chain_link",
        name = ccb.content.plural_text("medium steel chain link", "medium steel chain links"),
        stackable = true,
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_chain_link",
        copy_from = "lc_chain_link",
        looks_like = "lc_chain_link",
        name = ccb.content.plural_text("high steel chain link", "high steel chain links"),
        stackable = true,
    }
    item:material("hc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_chain_link",
        copy_from = "lc_chain_link",
        looks_like = "lc_chain_link",
        name = ccb.content.plural_text("hardened steel chain link", "hardened steel chain links"),
        stackable = true,
    }
    item:material("ch_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_chain_link",
        copy_from = "lc_chain_link",
        looks_like = "lc_chain_link",
        name = ccb.content.plural_text("tempered steel chain link", "tempered steel chain links"),
        stackable = true,
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    -- 300g / 8.8g/ml = ~34.1ml. Add 10% to take an uneven chunk into account = 37.5ml rounded upwards to 38ml.
    local item = content.Item {
        id = "scrap_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("chunk of bronze", "chunks of bronze"),
        description = ccb.content.text("Some decent-sized chunks of scrap bronze, for fashioning some old-school items."),
        mass_milligrams = 300000,
        volume_ml = 38,
        price_cents = 169,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "yellow",
        stackable = true,
    }
    item:material("bronze", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Price will be a complete guestimation, this wouldn't be worth that much to survivors because its not really worth it to handload ap bullets or bullets in general.  Volume is derived from ~8g/ml steel density.
    -- Weight is meant to exactly match the weight of a 9x18 bullet taking into account all the materials so that the uncraft would not spout errors.  The weight of this would be 7.45 grams in the real world.  This is why there are multiple steel core defs.
    -- Length is 1.6cm
    local item = content.Item {
        id = "9x18_steel_core",
        category = "spare_parts",
        name = ccb.content.plural_text("9x18 steel core", "9x18 steel core"),
        description = ccb.content.text("A stainless steel core that has been machined on a lathe by a survivor.  This one is meant to be used to reload a 9x18m bullet."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 500,
        price_postapoc_cents = 5,
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Price will be a complete guestimation, this wouldn't be worth that much to survivors because its not really worth it to handload ap bullets or bullets in general. Volume is derived from ~8g/ml steel density.
    -- Weight is meant to exactly match the weight of a 3006fmj bullet taking into account all the materials so that the uncraft would not spout errors.  They are also within 1 gram of the actual bullets.  This is why there are multiple steel core defs.
    -- Length is 3.35 cm
    local item = content.Item {
        id = "3006_steel_core",
        category = "spare_parts",
        name = ccb.content.plural_text(".30-06 steel core", ".30-06 steel core"),
        description = ccb.content.text("A stainless steel core that has been machined on a lathe by a survivor.  This one is meant to be used to reload a .30-06 bullet."),
        mass_milligrams = 9000,
        volume_ml = 2,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Price will be a complete guestimation, this wouldn't be worth that much to survivors because its not really worth it to handload ap bullets or bullets in general. Volume is derived from ~8g/ml steel density.
    -- Weight is meant to exactly match the weight of a 123ap bullet taking into account all the materials so that the uncraft would not spout errors.  They are also within 1 gram of the actual bullets.  This is why there are multiple steel core defs.
    -- Length is 3.03 cm
    -- This one has a lower barter price because almost no one is handloading the exotic exodii cartridge besides the pc.
    -- source for bullet length of a 303 bullet https://barnesbullets.com/0-311-303-7-65mm-tsx-150-gr-fb/
    local item = content.Item {
        id = "123_steel_core",
        category = "spare_parts",
        name = ccb.content.plural_text("12.3 steel core", "12.3 steel core"),
        description = ccb.content.text("A stainless steel core that has been machined on a lathe by a survivor.  This one is meant to be used to reload a 12.3 bullet."),
        mass_milligrams = 9000,
        volume_ml = 2,
        price_cents = 1000,
        price_postapoc_cents = 1,
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Price will be a complete guestimation, this wouldn't be worth that much to survivors because its not really worth it to handload ap bullets or bullets in general. Volume is derived from ~8g/ml steel density.
    -- Weight is meant to exactly match the weight of a 123ap bullet taking into account all the materials so that the uncraft would not spout errors.  Weight doesn't make sense so the uncraft doesn't throw errors.  This is why there are multiple steel core defs.
    -- Length is 2.5 cm
    local item = content.Item {
        id = "545_steel_core",
        category = "spare_parts",
        name = ccb.content.plural_text("5.45 steel core", "5.45 steel core"),
        description = ccb.content.text("A stainless steel core that has been machined on a lathe by a survivor.  This one is meant to be used to reload a 5.45 bullet."),
        mass_milligrams = 2000,
        volume_ml = 2,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    -- Price will be a complete guestimation, this wouldn't be worth that much to survivors because its not really worth it to handload ap bullets or bullets in general. Volume is derived from ~8g/ml steel density.
    -- Weight is meant to exactly match the weight of a 50bmg bullet taking into account all the materials so that the uncraft would not spout errors.  Weight doesn't make sense so the uncraft doesn't throw errors.  This is why there are multiple steel core defs.
    -- Length is 4.8 cm.  https://barnesbullets.com/0-510-50-bmg-tsx-647-gr-fb/
    local item = content.Item {
        id = "50_steel_core",
        category = "spare_parts",
        name = ccb.content.plural_text(".50 BMG steel core", ".50 BMG steel core"),
        description = ccb.content.text("A stainless mild steel core that has been machined on a lathe by a survivor.  This one is meant to be used to reload a .50 BMG bullet."),
        mass_milligrams = 54000,
        volume_ml = 8,
        price_cents = 1000,
        price_postapoc_cents = 1,
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end
