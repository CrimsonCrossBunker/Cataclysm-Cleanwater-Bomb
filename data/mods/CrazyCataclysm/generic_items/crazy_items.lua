local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "battletorch_done",
        name = ccb.content.plural_text("burnt out Louisville Slaughterer", "burnt out Louisville Slaughterers"),
        description = ccb.content.text("A sturdy wood bat, wrapped in flame-resistant Nomex fabric.  Makes a good melee weapon but better be disassembled to recycle the baseball bat and some Nomex patches."),
        mass_milligrams = 1343000,
        melee_to_hit = 3,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 1750,
        price_cents = 18000,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 19)
    content.add(item)
end

do
    local item = content.Item {
        id = "bread_sword",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("Excalibread", "Excalibreads"),
        description = ccb.content.text("A French baguette, sharpened into a blade and toasted for durability.  Truly, the best weapon to smite the gluten-intolerant."),
        volume_ml = 2450,
        mass_milligrams = 250000,
        longest_side_mm = 1000,
        melee_to_hit = -1,
        price_postapoc_cents = 250,
        weapon_categories = { "MEDIUM_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
    }
    item:material("wheat", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:quality("BUTCHER", -50)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "rocket_can_drink",
        copy_from = "can_drink",
        looks_like = "can_drink",
        name = ccb.content.plural_text("rocket can", "rocket cans"),
        description = ccb.content.text("A beverage can shaped like a rocket with a peeling label that reads 'POWERTHIRST: ROCKET CAN EDITION'.  Its tagline claims that it contains everything you've ever wanted."),
        symbol = "^",
        mass_milligrams = 30000,
        volume_ml = 600,
        longest_side_mm = 180,
        color = "dark_gray",
        replace_pockets = true,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        rigid = true,
        watertight = true,
        open_container = false,
        max_item_volume_ml = 10,
        sealed_spoil_multiplier = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "aux_pressurized_tank",
        looks_like = "pressurized_tank",
        name = ccb.content.plural_text("0.5L pressurized fuel tank", "0.5L pressurized fuel tanks"),
        description = ccb.content.text("A pressurized 0.5L canister built crafting into a small auxiliary flamethrower."),
        mass_milligrams = 100000,
        volume_ml = 500,
        price_cents = 3000,
        price_postapoc_cents = 250,
        symbol = "#",
        color = "light_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "diamond_sword",
        symbol = "/",
        color = "blue",
        name = ccb.content.plural_text("Diamond Sword", "Diamond Swords"),
        description = ccb.content.text("A sword made with two diamonds and a stick."),
        volume_ml = 1000,
        mass_milligrams = 1000000,
        longest_side_mm = 1000,
        melee_to_hit = -1,
        price_postapoc_cents = 250,
        weapon_categories = { "MEDIUM_SWORDS" },
    }
    item:material("diamond", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("cut", 7)
    content.add(item)
end
