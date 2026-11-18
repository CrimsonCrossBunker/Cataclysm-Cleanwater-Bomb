local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cestus_plus_one",
        copy_from = "cestus",
        looks_like = "cestus",
        name = ccb.content.plural_text("cestus +1", "cesti +1"),
    }
    item:adjust_measurements {
        price_cents = { factor = 3.0 },
        price_postapoc_cents = { factor = 3.0 },
        mass_milligrams = { factor = 0.9 },
        melee_to_hit = { offset = 1 },
    }
    item:adjust_melee_damage { factors = { all = 1.1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "cestus_plus_two",
        copy_from = "cestus",
        looks_like = "cestus",
        name = ccb.content.plural_text("cestus +2", "cesti +2"),
    }
    item:adjust_measurements {
        price_cents = { factor = 6.0 },
        price_postapoc_cents = { factor = 6.0 },
        mass_milligrams = { factor = 0.8 },
        melee_to_hit = { offset = 2 },
    }
    item:adjust_melee_damage { factors = { all = 1.2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "flaming_fist_plus_one",
        copy_from = "flaming_fist",
        looks_like = "flaming_fist",
        name = ccb.content.plural_text("flaming fist +1", "flaming fists +1"),
    }
    item:adjust_measurements { price_cents = { factor = 3.0 }, mass_milligrams = { factor = 0.9 }, melee_to_hit = { offset = 1 } }
    item:adjust_melee_damage { factors = { all = 1.5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "flaming_fist_plus_two",
        copy_from = "flaming_fist",
        looks_like = "flaming_fist",
        name = ccb.content.plural_text("flaming fist +2", "flaming fists +2"),
    }
    item:adjust_measurements { price_cents = { factor = 6.0 }, mass_milligrams = { factor = 0.8 }, melee_to_hit = { offset = 2 } }
    item:adjust_melee_damage { factors = { all = 2 } }
    content.add(item)
end
