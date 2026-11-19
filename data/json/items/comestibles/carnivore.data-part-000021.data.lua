local ccb = require("ccb")

ccb.content.define_item {
    id = "raw_hleather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("raw human skin", "raw human skin"),
    description = ccb.content.text("A carefully folded raw skin harvested from a human.  Despite some dubious historical accounts, the usefulness of human skin is limited, and can't be made into leather.  The skin is still edible, if you're that desperate."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_demihumanleather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("raw demihuman skin", "raw demihuman skin"),
    description = ccb.content.text("A carefully folded raw skin harvested from a demihuman.  Despite being from a human-enough body, the leather has this distinct unnatural and alien feeling to it, and would be a very poor substitute for leather.  The skin is still edible, if you're that desperate."),
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "raw_fur",
    category = "spare_parts",
    name = ccb.content.plural_text("raw pelt", "raw pelt"),
    mass = "114 g",
    volume = "170 ml",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from a fur-bearing animal.  It still has the fur attached.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "1 USD",
    materials = { "fur", "flesh" },
    flags = { "NO_SALVAGE", "TRADER_AVOID" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -20,
        calories = 350,
        fun = -24,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}
