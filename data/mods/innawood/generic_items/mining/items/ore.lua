local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "iron_ore",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("iron ore", "iron ores"),
        category = "spare_parts",
        description = ccb.content.text("A chunk of iron-rich earth.  Could be refined with a bloomery."),
        price_cents = 531,
        price_postapoc_cents = 10,
        mass_milligrams = 1000000,
        volume_ml = 235,
    }
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    -- Density of one liter of copper, item is native metal.
    local item = content.Item {
        id = "chunk_copper",
        category = "spare_parts",
        price_cents = 100,
        name = ccb.content.plural_text("chunk of native copper", "chunks of native copper"),
        symbol = "*",
        color = "light_red",
        description = ccb.content.text("A large chunk of copper, in its native state.  It only needs to be worked into a more usable shape."),
        volume_ml = 1000,
        mass_milligrams = 8960000,
    }
    item:material("copper", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- Density of one liter of silver, item is native metal.
    local item = content.Item {
        id = "chunk_silver",
        category = "spare_parts",
        price_cents = 500,
        name = ccb.content.plural_text("chunk of native silver", "chunks of native silver"),
        symbol = "*",
        color = "light_gray",
        description = ccb.content.text("A large chunk of silver, in its native state.  It only needs to be molded into a more usable shape."),
        volume_ml = 1000,
        mass_milligrams = 10490000,
    }
    item:material("silver", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    -- Density of one liter of gold, item is native metal.  Massively heavy.
    local item = content.Item {
        id = "chunk_gold",
        category = "spare_parts",
        price_cents = 1500,
        name = ccb.content.plural_text("chunk of native gold", "chunks of native gold"),
        symbol = "*",
        color = "yellow",
        description = ccb.content.text("A large chunk of native gold, a rare find.  It only needs to be molded into a more usable shape."),
        volume_ml = 1000,
        mass_milligrams = 19320000,
    }
    item:material("gold", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Density of one liter of aluminum, item is native metal.
    local item = content.Item {
        id = "chunk_aluminum",
        category = "spare_parts",
        price_cents = 100,
        name = ccb.content.plural_text("chunk of native aluminum", "chunks of native aluminum"),
        symbol = "*",
        color = "white",
        description = ccb.content.text("A large chunk of native aluminum, which would have been priceless before other ways to obtain aluminum were invented.  It needs to be cast into an ingot."),
        volume_ml = 1000,
        mass_milligrams = 2700000,
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- One liter, roughly 6.26 grams per cubic centimeter.
    local item = content.Item {
        id = "chunk_cassiterite",
        category = "spare_parts",
        price_cents = 300,
        name = ccb.content.plural_text("chunk of cassiterite", "chunks of cassiterite"),
        symbol = "*",
        color = "brown",
        description = ccb.content.text("A large chunk of cassiterite, an ore of tin.  It only needs to be smelted into a usable form."),
        volume_ml = 1000,
        mass_milligrams = 6260000,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- One liter, roughly 7.6 grams per cubic centimeter.
    local item = content.Item {
        id = "chunk_galena",
        category = "spare_parts",
        price_cents = 250,
        name = ccb.content.plural_text("chunk of galena", "chunks of galena"),
        symbol = "*",
        color = "white",
        description = ccb.content.text("A large chunk of galena, a lead ore with small amounts of silver.  It only needs to be smelted into a usable form."),
        volume_ml = 1000,
        mass_milligrams = 7600000,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    -- One liter, roughly 5.04 grams per cubic centimeter.
    local item = content.Item {
        id = "chunk_hematite",
        category = "spare_parts",
        price_cents = 250,
        name = ccb.content.plural_text("chunk of hematite", "chunks of hematite"),
        symbol = "*",
        color = "brown",
        description = ccb.content.text("A large chunk of hematite, an ore of iron.  It only needs to be smelted into a usable form."),
        volume_ml = 1000,
        mass_milligrams = 5040000,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- One liter, roughly 5.04 grams per cubic centimeter.
    local item = content.Item {
        id = "chunk_magnetite",
        category = "spare_parts",
        price_cents = 250,
        name = ccb.content.plural_text("chunk of magnetite", "chunks of magnetite"),
        symbol = "U",
        color = "brown",
        description = ccb.content.text("A large chunk of magnetite, a ferrimagnetic oxide of iron.  It can be magnetized to become a permanent magnet itself."),
        volume_ml = 1000,
        mass_milligrams = 5040000,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- One liter, roughly 8.1 grams per cubic centimeter.
    local item = content.Item {
        id = "chunk_cinnabar",
        category = "spare_parts",
        price_cents = 250,
        name = ccb.content.plural_text("chunk of cinnabar ", "chunks of cinnabar"),
        symbol = "*",
        color = "brown",
        description = ccb.content.text("A large chunk of cinnabar, an ore of mercury.  It is also the historic source for vermilion pigment."),
        volume_ml = 1000,
        mass_milligrams = 8100000,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end
