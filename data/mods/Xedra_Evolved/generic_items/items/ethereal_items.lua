local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "undine_waters_map",
        category = "maps",
        name = content.plural_text("undine waters map", "undine waters maps"),
        description = content.text("The item for ."),
        mass_milligrams = 30000,
        volume_ml = 250,
        price_cents = 1000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "blue",
        copy_from = "abstractmap",
    }
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    item:flag("PRESERVE_SPAWN_LOC")
    item:material("elemental_water", 1)
    item:clear_use_actions()
    item:reveal_map {
        radius = 150,
        message = ccb.content.text("The waters reveal themselves to you."),
        terrains = { { id = "lake" }, { id = "river", match = "PREFIX" }, { id = "ocean", match = "PREFIX" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "arvore_preservation_container",
        category = "container",
        name = ccb.content.plural_text("vegetal sphere", "vegetal spheres"),
        looks_like = "art_sphere",
        description = ccb.content.text("A large, hollow sphere of plant matter, bark, and wood.  Food placed inside will rot one-fifth as fast as it would if left out in the open air."),
        mass_milligrams = 3000000,
        volume_ml = 92000,
        longest_side_mm = 550,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "o",
        color = "green",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("veggy", 1)
    item:material("wood", 1)
    item:container_pocket {
        max_volume_ml = 70000,
        max_weight_milligrams = 70000000,
        rigid = true,
        watertight = true,
        spoil_multiplier = 0.2,
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_ierde_reveal_earth_map_01",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
        id = "item_ierde_reveal_earth_map_02",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
        id = "item_ierde_reveal_earth_map_03",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
        id = "item_ierde_reveal_earth_map_04",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
        id = "item_ierde_reveal_earth_map_05",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
        },
    }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_ierde_reveal_earth_map_06",
        copy_from = "abstractmap",
        category = "maps",
        name = content.plural_text("ierde map", "ierde maps"),
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
