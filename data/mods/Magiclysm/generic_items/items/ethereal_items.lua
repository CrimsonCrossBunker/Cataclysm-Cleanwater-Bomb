local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "magic_lamp",
        category = "tools",
        name = ccb.content.plural_text("enchanted lamp", "enchanted lamps"),
        description = ccb.content.text("A glowing bit of stone or metal that will light up a small area."),
        mass_milligrams = 15000,
        volume_ml = 250,
        price_cents = 1,
        symbol = ",",
        color = "light_green",
        light = 100,
    }
    item:material("magical_material", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "flarewhip",
        symbol = "/",
        color = "light_blue",
        name = ccb.content.plural_text("flarewhip", "flarewhips"),
        description = ccb.content.text("A long whip made of blue-hot magical flames.  The heat is horrendous when touching an enemy."),
        mass_milligrams = 60000,
        volume_ml = 1500,
        longest_side_mm = 400,
        techniques = { "PRECISE", "WIDE", "SWEEP" },
        light = 8,
        melee_to_hit = 3,
        category = "weapons",
        weapon_categories = { "WHIPS" },
    }
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("WHIP")
    item:flag("STURDY")
    item:flag("TRADER_AVOID")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("FIRESTARTER")
    item:flag("FLAMING")
    item:flag("FIRE")
    item:flag("RELIC_PINK")
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    item:melee_damage("heat", 30)
    content.add(item)
end

do
    local item = content.Item {
        id = "flamesword",
        symbol = "/",
        color = "light_gray",
        looks_like = "sword_wood",
        name = ccb.content.plural_text("flaming sword", "flaming swords"),
        description = ccb.content.text("This wooden sword is ablaze!  It seems to be safe-ish to hold, but will burn up soon."),
        weapon_categories = { "MEDIUM_SWORDS" },
        light = 10,
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL" },
        mass_milligrams = 900000,
        volume_ml = 1250,
        longest_side_mm = 1000,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("FIRESTARTER")
    item:flag("FIRE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 2)
    item:melee_damage("heat", 28)
    content.add(item)
end

do
    local item = content.Item {
        id = "decaying_boneclub",
        symbol = "/",
        color = "light_gray",
        looks_like = "bone",
        name = ccb.content.plural_text("decaying boneclub", "decaying boneclubs"),
        description = ccb.content.text("A pulsating club made of bone, stained with an ever-moving blood coating eager to absorb the living."),
        weapon_categories = { "BATONS" },
        max_worn = 1,
        techniques = { "WBLOCK_2", "RAPID", "PRECISE" },
        mass_milligrams = 700000,
        volume_ml = 800,
        longest_side_mm = 700,
        melee_to_hit = 3,
    }
    item:material("bone", 1)
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("MAGIC_FOCUS")
    item:flag("BELT_CLIP")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("biological", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "jar_3l_force",
        category = "container",
        name = ccb.content.plural_text("jar of force", "jars of force"),
        looks_like = "jar_glass_sealed",
        description = ccb.content.text("A three-liter container made out of transparent force.  Can be used to store liquids."),
        mass_milligrams = 1000,
        volume_ml = 3050,
        longest_side_mm = 298,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -1,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("concentrated_mana", 1)
    item:container_pocket { max_volume_ml = 3000, max_weight_milligrams = 6000000, rigid = true, watertight = true }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("pure", 3)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_01",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 15,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_02",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 20,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_03",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 25,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_04",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 30,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_05",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 35,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
            { id = "tream" },
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_earthshaper_map_06",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("earthshaper map", "earthshaper maps"),
        description = content.text("This is a magical map that, if everything works correctly, you'll never actually see."),
        color = "brown",
    }
    item:clear_use_actions()
    item:reveal_map {
        radius = 40,
        message = ccb.content.text("The earth reveals its secrets."),
        terrains = {
            { id = "field", match = "PREFIX" },
            { id = "swamp", match = "TYPE" },
            { id = "forest", match = "PREFIX" },
            { id = "stream", match = "PREFIX" },
            { id = "solid_earth" },
            { id = "empty_rock" },
        },
    }
    content.add(item)
end
