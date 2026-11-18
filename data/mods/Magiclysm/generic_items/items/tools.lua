local ccb = require("ccb")
local content = ccb.content

do
    -- I went ahead and gave this a level of 2 for when magical mutagens become a thing as I figured dragonblood for instance should need different tools than making alpha mutagen.
    local item = content.Item {
        id = "cauldron_demon_chitin",
        category = "container",
        name = ccb.content.plural_text("cauldron of purification", "cauldrons of purification"),
        description = ccb.content.text("This cauldron made of demon spider chitin seems to absorb the light.  It will hold 16 liters of material and will absorb poisons from it.  It may have other properties that require discovery."),
        mass_milligrams = 1424000,
        volume_ml = 20000,
        price_cents = 2000,
        melee_to_hit = -1,
        looks_like = "clay_hydria",
        symbol = ")",
        color = "red",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("demon_chitin", 1)
    item:container_pocket { max_volume_ml = 16000, max_weight_milligrams = 50000000, open_container = true, watertight = true }
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("MAGIC_MUTAGEN", 2)
    item:quality("MAGIC_CAULDRON", 1)
    item:clear_use_actions()
    item:native_use("HEAT_FOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- This is a pot made with a metal as dense as steel, it should have same weight/volume ratio as canning pot.
    local item = content.Item {
        id = "cauldron_orichalcum",
        category = "container",
        name = ccb.content.plural_text("orichalcum cauldron", "orichalcum cauldrons"),
        description = ccb.content.text("This is an alchemical cauldron made of orichalcum.  The metal is especially resistant to the unique types of corrosion caused by alchemy."),
        mass_milligrams = 3212000,
        volume_ml = 20000,
        price_cents = 75000,
        melee_to_hit = -4,
        looks_like = "canning_pot",
        symbol = "U",
        color = "yellow",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("orichalcum_metal", 1)
    item:container_pocket { max_volume_ml = 16000, max_weight_milligrams = 50000000, open_container = true, watertight = true }
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("MAGIC_MUTAGEN", 1)
    item:quality("MAGIC_CAULDRON", 2)
    item:clear_use_actions()
    item:native_use("HEAT_FOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "fireproof_mortar",
        symbol = "%",
        color = "light_red",
        name = ccb.content.plural_text("fireproof mortar", "fireproof mortar"),
        description = ccb.content.text("Some alchemical mortar, ready to be used in building projects expecting temperatures on par with dragonbreath."),
        category = "spare_parts",
        default_container = "bag_canvas",
        price_cents = 500000,
        mass_milligrams = 2340000,
        volume_ml = 1000,
    }
    item:material("powder_nonflam", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
