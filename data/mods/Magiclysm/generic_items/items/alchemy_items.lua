local ccb = require("ccb")
local content = ccb.content

do
    -- Potion recipes that require a full owlbear egg could also instead require larger amounts of stone shell.  Since 1 egg gives 3 shells, you could perhaps have 1 egg be equivalent to 5 or more shells when making potions.
    local item = content.Item {
        id = "stone_shell",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("stone shell", "stone shells"),
        description = ccb.content.text("The broken fragment of an owlbear egg.  With luck it might still contain some of its former power, though if nothing else it's still a bit sharp."),
        mass_milligrams = 250000,
        volume_ml = 150,
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("BUTCHER", -50)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "crystallized_mana_raw",
        category = "spare_parts",
        name = ccb.content.plural_text("raw mana crystal", "raw mana crystals"),
        description = ccb.content.text("A large chunk of crystal, removed from a leyline nexus.  It requires alchemical processing to transform into crystallized mana."),
        mass_milligrams = 10325000,
        volume_ml = 5000,
        price_cents = 5000,
        price_postapoc_cents = 350,
        symbol = "=",
        color = "cyan",
    }
    item:material("crystallized_mana", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glow_dust",
        symbol = "*",
        color = "yellow",
        name = ccb.content.plural_text("glow dust", "glow dusts"),
        description = ccb.content.text("The powdered remains of a will-o-wisps's physical form.  It seems to still possess an otherworldly glow."),
        price_cents = 3800,
        mass_milligrams = 5000,
        volume_ml = 250,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bulette_plate",
        symbol = ")",
        color = "light_gray",
        name = ccb.content.plural_text("bulette plate", "bulette plates"),
        description = ccb.content.text("The great plates from behind a bulette's head have always been prized for use in shield and armor making."),
        price_cents = 48000,
        mass_milligrams = 30000000,
        volume_ml = 3000,
    }
    item:material("arcane_skin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bulette_pearl",
        symbol = "*",
        color = "red",
        name = ccb.content.plural_text("bulette pearl", "bulette pearls"),
        description = ccb.content.text("As a bulette burrows through the earth its gills collect minute amounts of precious metals and gems which slowly aggregate into lustrous gemstones prized for their beauty and power."),
        price_cents = 10000,
        mass_milligrams = 120000,
        volume_ml = 250,
    }
    item:material("gemstone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "stirge_proboscis",
        name = ccb.content.plural_text("stirge proboscis", "stirge proboscises"),
        description = ccb.content.text("A long sucking apparatus harvested from stirge corpse.  Makes a poor melee weapon."),
        volume_ml = 100,
        mass_milligrams = 100000,
        price_cents = 2000,
        symbol = ",",
        color = "red",
        melee_to_hit = -1,
        weapon_categories = { "SHIVS" },
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("stab", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "demon_chitin_plate",
        category = "spare_parts",
        symbol = "/",
        color = "red",
        name = ccb.content.plural_text("demon chitin plate", "demon chitin plates"),
        price_cents = 15225,
        mass_milligrams = 1424000,
        volume_ml = 4000,
        melee_to_hit = -4,
        description = ccb.content.text("A large piece of demon spider exoskeleton, painstakingly cut from the corpse of an adult demon spider.  A plate of this size can be used to create armor plating."),
    }
    item:material("demon_chitin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "demon_spider_fang",
        name = ccb.content.plural_text("demon spider fang", "demon spider fangs"),
        description = ccb.content.text("A fang from a demon spider.  It seems to still drip with poison; you might be able to use this in some alchemical recipe?"),
        mass_milligrams = 270000,
        color = "green",
        symbol = ",",
        volume_ml = 250,
        weapon_categories = { "SHIVS" },
        price_cents = 1500,
        melee_to_hit = -3,
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("stab", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "mana_dust",
        symbol = "*",
        color = "blue",
        name = ccb.content.plural_text("mana dust", "mana dusts"),
        description = ccb.content.text("Crystallized mana in powdered form.  It faintly pulses with arcane energy."),
        volume_ml = 100,
    }
    item:material("powder", 1)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    content.add(item)
end

do
    local item = content.Item {
        id = "mana_pearl",
        symbol = "*",
        color = "blue",
        name = ccb.content.plural_text("mana pearl", "mana pearls"),
        description = ccb.content.text("A gemstone created by alchemy.  You can feel it attract surrounding mana."),
        mass_milligrams = 120000,
        volume_ml = 60,
    }
    item:material("gemstone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "enchanted_wood",
        symbol = "/",
        color = "blue",
        name = ccb.content.plural_text("enchanted wood", "enchanted wood"),
        description = ccb.content.text("Wood that has been infused with mana."),
        techniques = { "WBLOCK_1" },
        mass_milligrams = 1500000,
        volume_ml = 2500,
        longest_side_mm = 1300,
        melee_to_hit = 1,
        category = "spare_parts",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    -- The embers are preserved and can be used to craft a candle.
    local item = content.Item {
        id = "sealed_fading_embers",
        name = ccb.content.plural_text("fading embers (sealed)", "fading embers (sealed)"),
        description = ccb.content.text("A small fragment of an otherworldly flame, sealed into a jar for preservation."),
        ascii_picture = "jar_glass_sealed",
        mass_milligrams = 277000,
        volume_ml = 690,
        longest_side_mm = 127,
        price_cents = 100,
        symbol = ")",
        color = "red",
        category = "spare_parts",
    }
    item:material("glass", 1)
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- Copied from jar_glass_sealed.
    local item = content.Item {
        id = "enchanted_jar",
        category = "container",
        name = ccb.content.plural_text("0.5 L enchanted glass jar", "0.5 L enchanted glass jars"),
        description = ccb.content.text("A half-liter glass jar with a metal screw top lid, used for canning.  This one has been enchanted and is ready to preserve some exotic alchemy ingredients."),
        ascii_picture = "jar_glass_sealed",
        mass_milligrams = 277000,
        volume_ml = 690,
        longest_side_mm = 127,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        transparent = true,
        sealed_spoil_multiplier = 0.0,
    }
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 1)
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end
