local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_kitchen_knife",
        abstract = true,
        name = content.plural_text("generic kitchen knife", "generic kitchen knives"),
        description = content.text("generic item template"),
        category = "weapons",
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_small",
        name = ccb.content.plural_text("small kitchen knife", "small kitchen knives"),
        copy_from = "base_kitchen_knife",
        mass_milligrams = 112000,
        volume_ml = 100,
        longest_side_mm = 250,
        price_cents = 250,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:variants {
        { id = "knife_steak", name = ccb.content.plural_text("steak knife", "steak knives"), description = ccb.content.text("A sharp knife designed for cutting meat.  It makes a poor melee weapon, but is decent at butchering corpses."), ascii_picture = "knife_steak" },
        { id = "knife_paring", name = ccb.content.plural_text("paring knife", "paring knives"), description = ccb.content.text("A short-bladed knife with a sharp blade, made for fine controlled cuts to vegetables without using a cutting board."), ascii_picture = "knife_paring" },
    }
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 15)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_large",
        name = ccb.content.plural_text("large kitchen knife", "large kitchen knives"),
        copy_from = "base_kitchen_knife",
        mass_milligrams = 140000,
        volume_ml = 200,
        longest_side_mm = 300,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:variants {
        { id = "knife_chef", name = ccb.content.plural_text("chef knife", "chef knives"), description = ccb.content.text("A long-bladed kitchen knife.  The blade is wider than the handle, giving room for the wielder's knuckles, and it has a characteristic curve for a fast rocking action for chopping vegetables.  It makes an acceptable melee weapon, but the wide blade is unwieldy for butchering."), ascii_picture = "knife_chef" },
        { id = "knife_carving", name = ccb.content.plural_text("carving knife", "carving knives"), description = ccb.content.text("A long-bladed kitchen knife with a thin, slightly curved blade for deftly slicing meat either in flat sheets or around the bone.  It makes a decent melee weapon, and is excellent for butchery."), ascii_picture = "knife_carving" },
        { id = "knife_bread", name = ccb.content.plural_text("bread knife", "bread knives"), description = ccb.content.text("This knife has quite a long blade with a scalloped edge for cutting bread.  It's not that sharp, but its length and heft mean it could do a bit of damage and cause some nasty tearing."), ascii_picture = "knife_bread" },
    }
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 22)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 18)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_huge",
        name = ccb.content.plural_text("huge kitchen knife", "huge kitchen knives"),
        copy_from = "base_kitchen_knife",
        mass_milligrams = 380000,
        volume_ml = 300,
        longest_side_mm = 350,
        price_cents = 3000,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:variants {
        { id = "knife_butcher", name = ccb.content.plural_text("butcher knife", "butcher knives"), description = ccb.content.text("A sharp, heavy knife.  It makes a good melee weapon, and is an ideal item for butchering corpses."), ascii_picture = "knife_butcher" },
    }
    item:quality("CUT", 2)
    item:quality("BUTCHER", 25)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_cleaver",
        name = ccb.content.plural_text("cleaver", "cleavers"),
        copy_from = "base_kitchen_knife",
        mass_milligrams = 450000,
        volume_ml = 1000,
        longest_side_mm = 300,
        price_cents = 3500,
        price_postapoc_cents = 50,
        melee_to_hit = 0,
        replace_qualities = true,
    }
    item:variants {
        { id = "knife_meat_cleaver", name = ccb.content.plural_text("meat cleaver", "meat cleavers"), description = ccb.content.text("A menacing-looking knife with a broad, square-shaped blade.  Its heft and sharpness would make it a very effective melee weapon and an excellent butchering tool."), ascii_picture = "knife_meat_cleaver" },
        { id = "knife_vegetable_cleaver", name = ccb.content.plural_text("vegetable cleaver", "vegetable cleavers"), description = ccb.content.text("A menacing-looking knife with a broad, square shaped blade, curved for fast vegetable chopping.  Its heft and sharpness make it a decent weapon as well, although not as good as a meat cleaver."), ascii_picture = "knife_vegetable_cleaver" },
    }
    item:quality("CUT", 2)
    item:quality("BUTCHER", 25)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 16)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "copper_knife",
        name = ccb.content.plural_text("copper knife", "copper knives"),
        description = ccb.content.text("A knife made of crudely-worked copper with a simple handle.  Primitive, but a step above stone-age."),
        mass_milligrams = 200000,
        volume_ml = 300,
        longest_side_mm = 250,
        price_cents = 3000,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("copper", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 11)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 11)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_knife",
        category = "weapons",
        name = ccb.content.plural_text("bronze knife", "bronze knives"),
        description = ccb.content.text("A cast bronze knife with a full tang, with a handle wrapped in cord and leather, lovingly work-hardened and sharpened to a fine edge."),
        mass_milligrams = 450000,
        volume_ml = 250,
        longest_side_mm = 200,
        price_cents = 4000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = "/",
        color = "yellow",
        looks_like = "copper_knife",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("bronze", 1)
    item:material("leather", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 19)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 14)
    item:tool()
    content.add(item)
end

do
    -- Too small to be effectively used for butchering, still not bad at it due to serrated edge.
    local item = content.Item {
        id = "diveknife",
        category = "weapons",
        name = ccb.content.plural_text("dive knife", "dive knives"),
        description = ccb.content.text("A short, sturdy knife with a serrated edge for cutting lines and straps, and a blunt tip for prying.  Used primarily by divers, this knife has been fitted with cork to slow its descent if dropped underwater, so it takes up more space than usual."),
        mass_milligrams = 226000,
        volume_ml = 250,
        price_cents = 14000,
        price_postapoc_cents = 300,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("PRY", 1)
    item:quality("BUTCHER", 15)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "honey_scraper",
        name = ccb.content.plural_text("honey scraper", "honey scrapers"),
        description = ccb.content.text("A sharp, knife-like tool used for harvesting honey from beehives.  Makes a passable melee weapon."),
        mass_milligrams = 580000,
        volume_ml = 250,
        longest_side_mm = 460,
        price_cents = 1000,
        price_postapoc_cents = 100,
        melee_to_hit = -2,
        symbol = ",",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 3)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pockknife",
        name = ccb.content.plural_text("pocket knife", "pocket knives"),
        description = ccb.content.text("A small pocket knife.  It isn't great for combat, but it's better than nothing.  It's sharp enough to butcher with."),
        mass_milligrams = 161000,
        volume_ml = 125,
        longest_side_mm = 110,
        price_cents = 1000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 11)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "primitive_knife",
        name = ccb.content.plural_text("stone knife", "stone knives"),
        description = ccb.content.text("A sharpened stone set into a hollowed handle.  Not nearly as usable as a proper knife, but it's better than nothing."),
        mass_milligrams = 453000,
        volume_ml = 250,
        longest_side_mm = 250,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 11)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "boxcutter",
        name = ccb.content.plural_text("boxcutter knife", "boxcutter knives"),
        description = ccb.content.text("A small knife designed for opening boxes.  It could cause some damage, but it really should be used against inanimate objects.  It is too small to effectively butcher corpses with."),
        mass_milligrams = 23000,
        volume_ml = 20,
        longest_side_mm = 120,
        price_cents = 400,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 8)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "stone_chopper",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("stone chopper", "stone choppers"),
        description = ccb.content.text("A rock with sharpened edges, produced by knapping.  Works as a crude cutting and butchering tool, if nothing else is available."),
        mass_milligrams = 500000,
        volume_ml = 250,
        longest_side_mm = 80,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", -18)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 3)
    item:tool()
    content.add(item)
end
