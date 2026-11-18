local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "anvil",
        name = ccb.content.plural_text("anvil", "anvils"),
        description = ccb.content.text("A heavy block of oddly-shaped steel complete with a pritchel hole and hardy hole.  Once installed, it can be used in most metalworking fabrication recipes."),
        mass_milligrams = 26000000,
        volume_ml = 12000,
        price_cents = 100000,
        price_postapoc_cents = 2000,
        melee_to_hit = -4,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 40)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "anvil_bronze",
        name = ccb.content.plural_text("bronze anvil", "bronze anvils"),
        description = ccb.content.text("A block of oddly-shaped bronze complete with a pritchel hole and hardy hole.  Once installed, it can be used in most metalworking fabrication recipes."),
        mass_milligrams = 26000000,
        volume_ml = 12000,
        price_cents = 60000,
        price_postapoc_cents = 750,
        melee_to_hit = -4,
        symbol = ";",
        color = "yellow",
    }
    item:material("bronze", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 35)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "anvil_heavy",
        name = ccb.content.plural_text("heavy anvil", "heavy anvils"),
        description = ccb.content.text("An absolutely enormous block of oddly-shaped steel with all the bells and whistles a blacksmith could ask for on an anvil.  Necessary for heavy-duty metalworking or dropping on roadrunners."),
        mass_milligrams = 225000000,
        volume_ml = 110000,
        price_cents = 100000,
        price_postapoc_cents = 2000,
        melee_to_hit = -4,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 40)
    item:tool()
    content.add(item)
end

do
    -- 30 cm of railroad track, minus roughly 400 ml for different chunks of metal.
    local item = content.Item {
        id = "anvil_crude",
        name = ccb.content.plural_text("small anvil", "small anvils"),
        description = ccb.content.text("A proper, albeit small, anvil.  Pretty handy."),
        mass_milligrams = 14827000,
        volume_ml = 1901,
        longest_side_mm = 300,
        price_cents = 100000,
        price_postapoc_cents = 2000,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 40)
    item:tool()
    content.add(item)
end

do
    -- Represents any number of heavy machinery parts that serve this purpose.
    local item = content.Item {
        id = "anvil_scavenged",
        name = ccb.content.plural_text("scavenger's anvil", "scavenger's anvils"),
        description = ccb.content.text("A portion of heavy steel machinery that has been smoothed and shaped to form a very adequate anvil.  If it were mounted onto a good solid log, it would be adequate for any task."),
        mass_milligrams = 50000000,
        volume_ml = 30000,
        longest_side_mm = 400,
        price_cents = 100000,
        price_postapoc_cents = 2000,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 40)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "anvil_stump",
        name = ccb.content.plural_text("makeshift stump anvil", "makeshift stump anvils"),
        description = ccb.content.text("A heavy, thick log to which several flat steel bits have been bolted to serve as an anvil.  Not sufficient for detailed nor heavy work."),
        mass_milligrams = 30000000,
        volume_ml = 25000,
        longest_side_mm = 300,
        price_cents = 2500,
        price_postapoc_cents = 1000,
        melee_to_hit = -5,
        replace_qualities = true,
        symbol = "n",
        color = "brown",
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("ANVIL", 2)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B09YH5T9DV
    local item = content.Item {
        id = "boltcutters",
        name = ccb.content.plural_text("bolt cutters", "bolt cutters"),
        description = ccb.content.text("A large pair of bolt cutters.  You could use them to cut padlocks or heavy gauge wire."),
        mass_milligrams = 1560000,
        volume_ml = 2750,
        longest_side_mm = 460,
        price_cents = 2200,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "red",
        melee_to_hit = -1,
    }
    item:material("steel", 17)
    item:material("plastic", 3)
    item:clear_use_actions()
    item:native_use("BOLTCUTTERS")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "char_forge",
        name = ccb.content.plural_text("charcoal forge", "charcoal forges"),
        description = ccb.content.text("A portable, charcoal-fired metalworking forge.  With the right tools, you could use this for metalworking."),
        mass_milligrams = 8600000,
        volume_ml = 8000,
        melee_to_hit = -3,
        price_cents = 20000,
        price_postapoc_cents = 3000,
        symbol = ";",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:ammo_pocket("charcoal", 500)
    item:ammo_pocket("coal", 2500)
    item:tool { ammo_types = { "charcoal", "coal" }, crafting_subtype = "forge" }
    content.add(item)
end

do
    local item = content.Item {
        id = "chisel",
        name = ccb.content.plural_text("metalworking chisel", "metalworking chisels"),
        description = ccb.content.text("A short, stout metalworking chisel.  It's used in some metalworking fabrication recipes."),
        mass_milligrams = 660000,
        volume_ml = 250,
        price_cents = 1600,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("CHISEL", 3)
    item:quality("CHISEL_WOOD", 3)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "chisel_bronze",
        copy_from = "chisel",
        looks_like = "chisel",
        name = ccb.content.plural_text("bronze chisel", "bronze chisels"),
        description = ccb.content.text("A short, stout metalworking chisel made of bronze.  It's used in some metalworking fabrication recipes.  Bronze chisels spark less than their steel counterparts, but are less durable."),
        mass_milligrams = 735000,
        price_cents = 2000,
        replace_qualities = true,
    }
    item:material("bronze", 1)
    item:quality("CHISEL", 2)
    item:quality("CHISEL_WOOD", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crucible",
        name = ccb.content.plural_text("crucible", "crucibles"),
        description = ccb.content.text("A small metalworking crucible.  Looks like a stout drink tumbler.  It's used in some metalworking fabrication recipes."),
        mass_milligrams = 1400000,
        volume_ml = 2000,
        price_cents = 100000,
        price_postapoc_cents = 750,
        symbol = ";",
        color = "dark_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("ceramic", 1)
    item:container_pocket {
        max_volume_ml = 1750,
        max_weight_milligrams = 1200000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("COOK", 1)
    item:quality("CHEM", 1)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crucible_clay",
        name = ccb.content.plural_text("clay crucible", "clay crucibles"),
        description = ccb.content.text("A primitive metalworking crucible made of clay.  Looks like a stout drink tumbler.  You could use it for metalworking."),
        mass_milligrams = 1642000,
        volume_ml = 2500,
        price_cents = 60000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket {
        max_volume_ml = 1750,
        max_weight_milligrams = 1200000,
        rigid = true,
        watertight = true,
        open_container = true,
    }
    item:quality("COOK", 1)
    item:quality("CHEM", 1)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "link_sheet",
        category = "spare_parts",
        name = ccb.content.plural_text("chainmail sheet", "chainmail sheets"),
        description = ccb.content.text("A sheet of riveted chainmail.  With some skill, several of these sheets could be connected to make effective armor."),
        mass_milligrams = 1000000,
        volume_ml = 500,
        price_cents = 1000,
        price_postapoc_cents = 500,
        symbol = ",",
        color = "light_gray",
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_link_sheet",
        category = "spare_parts",
        name = ccb.content.plural_text("mild steel chainmail sheet", "mild steel chainmail sheets"),
        description = ccb.content.text("A sheet of riveted chainmail.  With some skill, several of these sheets could be connected to make effective armor."),
        mass_milligrams = 1000000,
        volume_ml = 500,
        price_cents = 1000,
        price_postapoc_cents = 500,
        symbol = ",",
        color = "light_gray",
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_link_sheet",
        copy_from = "lc_link_sheet",
        looks_like = "lc_link_sheet",
        name = ccb.content.plural_text("medium steel chainmail sheet", "medium steel chainmail sheets"),
    }
    item:material("mc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_link_sheet",
        copy_from = "lc_link_sheet",
        looks_like = "lc_link_sheet",
        name = ccb.content.plural_text("high steel chainmail sheet", "high steel chainmail sheets"),
    }
    item:material("hc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_link_sheet",
        copy_from = "lc_link_sheet",
        looks_like = "lc_link_sheet",
        name = ccb.content.plural_text("hardened steel chainmail sheet", "hardened steel chainmail sheets"),
    }
    item:material("ch_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_link_sheet",
        copy_from = "lc_link_sheet",
        looks_like = "lc_link_sheet",
        name = ccb.content.plural_text("tempered steel chainmail sheet", "tempered steel chainmail sheets"),
    }
    item:material("qt_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "swage",
        name = ccb.content.plural_text("swage and die set", "swage and die sets"),
        description = ccb.content.text("A set of swages and dies for metalsmithing.  These loops and metal blocks are used in some metalworking fabrication recipes."),
        mass_milligrams = 2620000,
        volume_ml = 2000,
        price_cents = 16000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hotcut_bronze",
        copy_from = "hotcut",
        looks_like = "hotcut",
        name = ccb.content.plural_text("hotcut", "hotcuts"),
    }
    item:material("bronze", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hotcut",
        name = ccb.content.plural_text("hotcut", "hotcuts"),
        description = ccb.content.text("A hardened chisel-like object for metalsmithing.  It's used to cut lengths of metal in some metalworking fabrication recipes."),
        mass_milligrams = 800000,
        volume_ml = 500,
        price_cents = 1600,
        price_postapoc_cents = 200,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "drift",
        name = ccb.content.plural_text("punch & drift set", "punch & drift sets"),
        description = ccb.content.text("A set of hardened spiky metal pins used to make holes in hot metal.  The punch is used to create the initial hole, and the drift is used to then enlarge and shape it. This set includes various shapes and sizes for different applications, from tapering to delicate socketing."),
        mass_milligrams = 4000000,
        volume_ml = 750,
        longest_side_mm = 400,
        price_cents = 2400,
        price_postapoc_cents = 200,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07Q5CJDM9
    local item = content.Item {
        id = "tongs",
        ascii_picture = "kitchen_tongs",
        name = ccb.content.plural_text("kitchen tongs", "kitchen tongs"),
        description = ccb.content.text("A pair of long, metal tongs.  They are commonly used for cooking."),
        mass_milligrams = 167000,
        volume_ml = 210,
        longest_side_mm = 300,
        price_cents = 1300,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metalworking_tongs_bronze",
        copy_from = "metalworking_tongs",
        looks_like = "metalworking_tongs",
        name = ccb.content.plural_text("flatjaw bronze tongs", "flatjaw bronze tongs"),
    }
    item:material("bronze", 1)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B0BGPJ5HQD
    local item = content.Item {
        id = "metalworking_tongs",
        name = ccb.content.plural_text("flatjaw tongs", "flatjaw tongs"),
        description = ccb.content.text("A pair of flatjaw tongs.  They are commonly used for metalworking, fabrication, or forging recipes."),
        mass_milligrams = 730000,
        volume_ml = 662,
        longest_side_mm = 440,
        price_cents = 3900,
        price_postapoc_cents = 300,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sandpaper",
        name = ccb.content.plural_text("sandpaper", "sheets of sandpaper"),
        description = ccb.content.text("A sheet of rough paper.  It is commonly used in metalworking and carpentry."),
        mass_milligrams = 10000,
        volume_ml = 50,
        price_cents = 1600,
        price_postapoc_cents = 10,
        symbol = "`",
        color = "brown",
        replace_qualities = true,
    }
    item:material("paper", 1)
    item:quality("FILE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "leather_filing",
        name = ccb.content.plural_text("sandleather", "sandleathers"),
        description = ccb.content.text("A patch of leather paired with a handful of sand.  Works as a substitute for sandpaper."),
        mass_milligrams = 25160,
        volume_ml = 23,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "`",
        color = "brown",
        replace_qualities = true,
    }
    item:material("leather", 1)
    item:quality("FILE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "draw_plate",
        name = ccb.content.plural_text("draw plate", "draw plates"),
        description = ccb.content.text("A piece of metal with holes of varying size drilled into it.  Used as part of wire drawing."),
        mass_milligrams = 200000,
        volume_ml = 250,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = "]",
        color = "light_cyan",
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "casting_mold_large",
        copy_from = "casting_mold",
        looks_like = "casting_mold",
        name = ccb.content.plural_text("large sandcasting mold", "large sandcasting molds"),
        description = ccb.content.text("A large mold for casting molten metals into different shapes."),
        volume_ml = 150000,
        mass_milligrams = 76600000,
        longest_side_mm = 600,
    }
    item:tool { crafting_subtype = "casting_mold" }
    content.add(item)
end

do
    local item = content.Item {
        id = "casting_mold_long",
        copy_from = "casting_mold",
        looks_like = "casting_mold",
        name = ccb.content.plural_text("long sandcasting mold", "long sandcasting molds"),
        description = ccb.content.text("A large, long, mold for casting molten metals into different shapes."),
        volume_ml = 69000,
        mass_milligrams = 37000000,
        longest_side_mm = 1100,
    }
    item:tool { crafting_subtype = "casting_mold" }
    content.add(item)
end

do
    local item = content.Item {
        id = "stone_polishing",
        name = ccb.content.plural_text("polishing stone", "polishing stones"),
        description = ccb.content.text("A large natural stone with a flat surface to grind against."),
        mass_milligrams = 8000000,
        volume_ml = 3000,
        melee_to_hit = -4,
        price_cents = 400,
        price_postapoc_cents = 15,
        color = "dark_gray",
        symbol = ";",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("GRIND", 2)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pedal_grindstone",
        name = ccb.content.plural_text("pedal powered grindstone", "pedal powered grindstones"),
        description = ccb.content.text("A round, pedal-powered grindstone, useful for grinding metal."),
        mass_milligrams = 15000000,
        volume_ml = 4000,
        price_cents = 1500,
        price_postapoc_cents = 35,
        melee_to_hit = -3,
        color = "dark_gray",
        symbol = ";",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("GRIND", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scraper_steel",
        name = ccb.content.plural_text("steel scraper", "steel scrapers"),
        description = ccb.content.text("A hardened steel tool similar to a drawknife, but for metal."),
        mass_milligrams = 500000,
        volume_ml = 500,
        price_cents = 1200,
        price_postapoc_cents = 20,
        melee_to_hit = -2,
        color = "brown",
        symbol = ";",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("GRIND", 2)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    -- Based on the Whisper Daddy 3 Burner Forge, large enough to craft tools and small weapons.
    local item = content.Item {
        id = "gas_forge",
        name = ccb.content.plural_text("gas forge", "gas forges"),
        description = ccb.content.text("A gas-fueled metalworking forge.  With the right tools, you could use this for metalworking."),
        mass_milligrams = 32205000,
        volume_ml = 8000,
        price_cents = 80000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = ";",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:magazine_well { flags = { "GAS_TANK" }, default_magazine = "large_propane_tank" }
    item:tool { ammo_types = { "propane" }, crafting_subtype = "forge" }
    content.add(item)
end

do
    local item = content.Item {
        id = "temper_block",
        name = ccb.content.plural_text("tempering block set", "tempering block sets"),
        description = ccb.content.text("Two square blocks of steel used for tempering metal via heating the blocks and sandwiching the metal between them."),
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 1000,
        price_postapoc_cents = 200,
        color = "dark_gray",
        symbol = "B",
        replace_qualities = true,
    }
    item:material("mc_steel", 1)
    item:quality("TEMPER", 1, 1.2)
    item:tool()
    content.add(item)
end
