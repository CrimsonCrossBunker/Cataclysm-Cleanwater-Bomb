local ccb = require("ccb")

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
