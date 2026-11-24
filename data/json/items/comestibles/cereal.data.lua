local ccb = require("ccb")

ccb.content.define_item {
    id = "cereal",
    name = ccb.content.plural_text("sugary cereal", "sugary cereal"),
    description = ccb.content.text("Sugary breakfast cereal.  It takes you back to your childhood."),
    color = "yellow",
    symbol = "%",
    looks_like = "cereal",
    price = "3 USD",
    survival_price = "2 USD",
    mass = "110 g",
    volume = "100 ml",
    materials = { "junk" },
    flags = { "EDIBLE_FROZEN", "USE_EAT_VERB" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "90 days",
        quench = -2,
        fun = 10,
        calories = 354,
        vitamins = { { id = "iron", amount = 47 }, { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cereal2",
    copy_from = "cereal",
    name = ccb.content.plural_text("whole-grain cereal", "whole-grain cereal"),
    description = ccb.content.text("Whole-grain wheat cereal.  It's surprisingly good, and for your heart too, allegedly."),
    materials = { "wheat" },
    comestible = {
        calories = 444,
        vitamins = { { id = "iron", amount = 172 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cereal3",
    copy_from = "cereal",
    name = ccb.content.plural_text("corn flakes", "corn flakes"),
    description = ccb.content.text("Plain cornflake cereal.  They're not that good, but it beats nothing."),
    materials = { "dried_vegetable" },
    comestible = { fun = 6, calories = 402, vitamins = { { id = "iron", amount = 172 } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "cereal_fp1",
    copy_from = "cereal",
    name = ccb.content.text_without_extraction("Foodplace cereal", "Foodplace cereal"),
    description = ccb.content.text_without_extraction("A generic box of Foodplace brand sugary cereal, you shouldn't see this."),
    materials = { "foodplace_foodstuff" },
    variants = {
        {
            id = "snicker",
            name = ccb.content.plural_text("Snicker-Snacks cereal", "Snicker-Snacks cereal"),
            description = ccb.content.text("Foodplace brand Snicker-Snack cereal.  Each tiny \"Snicker-Snack\" is shaped like human food!"),
        },
        {
            id = "brantastic",
            name = ccb.content.plural_text("Brantastic cereal", "Brantastic cereal"),
            description = ccb.content.text("Foodplace brand \"Brantastic\" cereal.  An essential part of a complete Bran breakfast."),
        },
        {
            id = "honey",
            name = ccb.content.plural_text("Honey Pellet cereal", "Honey Pellet cereal"),
            description = ccb.content.text("Foodplace brand \"Amorphous Honey Pellet\" cereal.  The box promises \"Inconceivable sustenance in tiny morsels of yellow honey.\""),
        },
        {
            id = "fructose",
            name = ccb.content.plural_text("Fructose Flakes cereal", "Fructose Flakes cereal"),
            description = ccb.content.text("Foodplace brand Fructose Flakes cereal.  Fortified with energy enriched FoodSyrup™ that supports life most efficiently."),
        },
        {
            id = "foodios",
            name = ccb.content.plural_text("Foodios cereal", "Foodios cereal"),
            description = ccb.content.text("Foodplace brand \"Foodios\" cereal.  Foodios™ are Foodalicious™!"),
        },
    },
    comestible = {
        healthy = -1,
        addiction_potential = 5,
        addiction = "caffeine",
        sleepiness = 25,
        vitamins = { { id = "caffeine", amount = 75 } },
    },
}

ccb.content.define_item {
    id = "cereal_fp2",
    copy_from = "cereal_fp1",
    name = ccb.content.plural_text("Carpenter Crunch cereal", "Carpenter Crunch cereal"),
    description = ccb.content.text("This is Foodplace brand \"Carpenter Crunch\" cereal with the iconic \"Breakfast Beaver\" mascot on the box.  It tastes kind of like nails."),
    variants = {},
    comestible = { fun = -1, shelf_life = "540 days" },
}

ccb.content.define_item {
    id = "cereal_fp4",
    copy_from = "cereal_fp1",
    name = ccb.content.plural_text("Sugar Chomps cereal", "Sugar Chomps cereal"),
    description = ccb.content.text("Foodplace brand \"Sugar Chomps\" cereal.  \"Chocolate Frosted Crunchy Sugar Chomps: 8 essential vitamins packed into that rich, fudgy taste!\""),
    variants = {},
    comestible = {
        addiction_potential = 10,
        vitamins = { { id = "caffeine", amount = 150 } },
        shelf_life = "540 days",
    },
}
