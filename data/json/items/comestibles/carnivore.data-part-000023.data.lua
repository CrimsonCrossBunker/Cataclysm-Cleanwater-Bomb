local ccb = require("ccb")

ccb.content.define_item {
    id = "raw_hfur",
    copy_from = "raw_fur",
    name = ccb.content.plural_text("raw human pelt", "raw human pelt"),
    description = ccb.content.text("A carefully folded raw skin harvested from a fur-bearing mutant human.  It still has the fur attached.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    materials = { "fur", "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "flesh_golem_heart",
    name = ccb.content.text("seeping heart"),
    mass = "2035 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A thick mass of flesh superficially resembling a mammalian heart.  It's the size of your fist and covered in dimpled grooves."),
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "flesh" },
    volume = "500 ml",
    flags = { "PREDATOR_FUN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -10,
        calories = 200,
        quench = 10,
        fun = -25,
        vitamins = { { id = "mutagen_beast", amount = 250 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "jabberwock_heart",
    name = ccb.content.text("putrid heart"),
    mass = "4535 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A thick, hulking mass of flesh that's easily the size of your head, superficially resembling a mammalian heart and covered in ribbed grooves.  It's still full of whatever passes for blood in jabberwocks, and is heavy in your hands.  After everything you've seen lately, you can't help but remember old sayings about eating the hearts of your enemies…"),
    price = "65 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    volume = "1 L",
    flags = { "PREDATOR_FUN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -10,
        calories = 347,
        fun = -25,
        vitamins = { { id = "mutagen_beast", amount = 300 }, { id = "meat_allergen", amount = 1 } },
    },
}
