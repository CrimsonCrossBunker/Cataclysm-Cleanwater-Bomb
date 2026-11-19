local ccb = require("ccb")

ccb.content.define_item {
    id = "pumpkin_muffins",
    name = ccb.content.text("pumpkin muffin"),
    mass = "30 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A baked pumpkin-apple muffin.  Perfect for a fall feast."),
    price = "2 cent",
    survival_price = "1 cent",
    materials = { "fruit" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "3 days 12 hours",
        kind = "FOOD",
        quench = -1,
        calories = 45,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 2 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hazelnut_cake",
    name = ccb.content.plural_text("slice of hazelnut cake", "slices of hazelnut cake"),
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("This traditional hazelnut cake (or Bagȣnizabȣnak cake in Abenaki) is a nice, protein-rich treat for cold days."),
    price = "2 cent",
    survival_price = "1 cent",
    materials = { "nut" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 72,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 3 },
            { id = "nut_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "baklava",
    name = ccb.content.text("baklava"),
    mass = "50 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A layered pastry dessert made of filo pastry, filled with chopped nuts, and sweetened with syrup or honey."),
    price = "87 cent",
    survival_price = "43 cent",
    materials = { "bread", "nut" },
    volume = "100 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 200,
        vitamins = { { id = "nut_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
        fun = 4,
        quench = -1,
    },
}

ccb.content.define_item {
    id = "religieuse_au_chocolat",
    name = ccb.content.plural_text("religieuse au chocolat", "religieuses au chocolat"),
    mass = "50 g",
    color = "brown",
    symbol = "8",
    description = ccb.content.text("A a French pastry made of a small choux pastry case stacked on top of a larger one, both filled with crème pâtissière, flavored with chocolate.  Each case is topped with a ganache of chocolate, then attached to each other using piped buttercream icing.  Named the religieuse because when made properly, the pastries look like nuns in habits."),
    price = "87 cent",
    survival_price = "43 cent",
    materials = { "bread", "sugar" },
    volume = "100 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 150,
        vitamins = { { id = "bread_allergen", amount = 1 } },
        fun = 7,
    },
}

ccb.content.define_item {
    id = "gateau_st_honore",
    name = ccb.content.plural_text("slice of gateau St. Honore", "slices of gateaux St. Honore"),
    mass = "224 g",
    color = "brown",
    symbol = ">",
    description = ccb.content.text("A gâteau St. Honoré is a French cake that incorporates layers of classic puff pastry, balls of choux pastry, and pastry cream.  This cake originated in nineteenth-century France and was named after Saint Honoré, the French patron saint of bakers and pastry chefs."),
    price = "87 cent",
    survival_price = "43 cent",
    materials = { "bread", "sugar" },
    volume = "300 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 564,
        vitamins = {
            { id = "bread_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
        fun = 9,
    },
}
