local ccb = require("ccb")

-- another high level component, 'mana' related
ccb.content.define_item {
    id = "golden_reed_stalk",
    copy_from = "platonic_flower",
    name = ccb.content.plural_text("golden reed stalks", "golden reed stalks"),
    color = "yellow",
    symbol = "%",
    looks_like = "wheat",
    description = ccb.content.text("Stalks cut from a golden reed.  They have a strong, spiced aroma."),
    survival_price = "7 USD 80 cent",
    comestible = {
        calories = 63,
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 12 },
            { id = "vitC", amount = 3 },
            { id = "redcells", amount = 2 },
        },
    },
}

-- 'duration' and 'sustaining'
ccb.content.define_item {
    id = "wood_barnacle",
    copy_from = "platonic_flower",
    name = ccb.content.text("wood barnacle"),
    symbol = "o",
    color = "brown",
    looks_like = "egg",
    description = ccb.content.text("Heavy wooden shells surrounding a diminutive white fruit."),
    survival_price = "10 USD",
    comestible = {
        calories = 64,
        kind = "FOOD",
        vitamins = {
            { id = "calcium", amount = 8 },
            { id = "vitC", amount = 5 },
            { id = "redcells", amount = 3 },
        },
    },
}

-- 'range', 'area', 'aoe'
ccb.content.define_item {
    id = "dragon_nail",
    copy_from = "platonic_flower",
    name = ccb.content.text("dragonail"),
    color = "brown",
    symbol = "o",
    looks_like = "egg",
    description = ccb.content.text("Knife sharp thorns from a dragonail bush.  Eating them raw would be a dangerous challenge."),
    survival_price = "8 USD 90 cent",
    comestible = {
        calories = 85,
        kind = "FOOD",
        vitamins = { { id = "iron", amount = 7 }, { id = "vitC", amount = 4 }, { id = "calcium", amount = 1 } },
    },
}

-- breaks magic enchantments (whatever that means), used to make magic armor, maybe 'breaks' related (like increasing the damage/armor penetration abilities)
ccb.content.define_item {
    id = "moly_tuber",
    copy_from = "platonic_flower",
    name = ccb.content.text("moly tuber"),
    color = "blue",
    symbol = "%",
    description = ccb.content.text("The black root of a moly plant, extracted from the ground through great effort.  Rumored to grant protection to those who consume it."),
    survival_price = "3 USD",
    comestible = {
        calories = 67,
        kind = "FOOD",
        vitamins = { { id = "calcium", amount = 13 }, { id = "iron", amount = 7 } },
    },
}
