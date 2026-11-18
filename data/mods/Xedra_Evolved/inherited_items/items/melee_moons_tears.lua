local ccb = require("ccb")
local content = ccb.content

do
    -- 1.2 below produces 10% more damage than hardened steel weapons. Otherwise, use 1.1.
    local item = content.Item {
        id = "moons_tears_knife_baselard",
        copy_from = "knife_baselard",
        looks_like = "knife_baselard",
        name = ccb.content.plural_text("moon's tears baselard", "moon's tears baselard"),
        description = ccb.content.text("A dagger forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.56 } }
    item:adjust_melee_damage { factors = { stab = 1.1 } }
    item:replace_material("iron", "moon_tears")
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_broadsword",
        copy_from = "ch_broadsword",
        looks_like = "ch_broadsword",
        name = ccb.content.plural_text("moon's tears broadsword", "moon's tears broadsword"),
        description = ccb.content.text("A broad sword forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.56 } }
    item:adjust_melee_damage { factors = { cut = 1.2 } }
    item:replace_material("ch_steel", "moon_tears")
    item:replace_material("kevlar", "leather")
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_arming_sword",
        copy_from = "ch_arming_sword",
        looks_like = "ch_arming_sword",
        name = ccb.content.plural_text("moon's tears arming sword", "moon's tears arming sword"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed, and forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.56 } }
    item:adjust_melee_damage { factors = { cut = 1.2 } }
    item:replace_material("ch_steel", "moon_tears")
    item:replace_material("kevlar", "leather")
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_mace",
        copy_from = "ch_mace",
        looks_like = "ch_mace",
        name = ccb.content.plural_text("moon's tears mace", "moon's tears mace"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head forged from some silvery metal that seems to shine with a soft internal light.  It looks delicate but hits very hard."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { bash = 1.2 } }
    item:replace_material("ch_steel", "moon_tears")
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_scimitar",
        copy_from = "ch_scimitar",
        looks_like = "ch_scimitar",
        name = ccb.content.plural_text("moon's tears shamshir", "moon's tears shamshir"),
        description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries, forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.6 } }
    item:adjust_melee_damage { factors = { cut = 1.2 } }
    item:replace_material("ch_steel", "moon_tears")
    item:replace_material("kevlar", "leather")
    content.add(item)
end

do
    -- copy from ch_spear once that exists
    local item = content.Item {
        id = "moons_tears_spear",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("moon's tears spear", "moon's tears spear"),
        description = ccb.content.text("A stout wooden pole with a spearhead forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:material("moon_tears", 1)
    item:material("wood", 7)
    item:adjust_measurements { mass_milligrams = { factor = 0.95 } }
    item:adjust_melee_damage { factors = { stab = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_battleaxe",
        copy_from = "ch_battleaxe",
        looks_like = "ch_battleaxe",
        name = ccb.content.plural_text("moon's tears battle axe", "moon's tears battle axe"),
        description = ccb.content.text("A huge axe designed for warfare, forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:material("moon_tears", 1)
    item:material("wood", 4)
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    item:adjust_melee_damage { factors = { cut = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "moons_tears_katana",
        copy_from = "ch_katana",
        looks_like = "ch_katana",
        name = ccb.content.plural_text("moon's tears katana", "moon's tears katana"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier, forged from some silvery metal that seems to shine with a soft internal light.  It's surprisingly sharp."),
    }
    item:adjust_measurements { mass_milligrams = { factor = 0.56 } }
    item:adjust_melee_damage { factors = { stab = 1.2 } }
    item:replace_material("ch_steel", "moon_tears")
    item:replace_material("kevlar", "leather")
    content.add(item)
end
