local ccb = require("ccb")

ccb.content.define_item {
    id = "mre_carrot_cake",
    name = ccb.content.text("carrot pound cake"),
    copy_from = "mre_dessert",
    description = ccb.content.text("Delicious cake with carrots blended seamlessly."),
    comestible = {},
}

ccb.content.define_item {
    id = "mre_poppyseed_cake",
    copy_from = "mre_carrot_cake",
    name = ccb.content.text("lemon poppy seed pound cake"),
    description = ccb.content.text("Cake filled with the goodness of lemon and poppy seeds."),
    comestible = { calories = 290 },
}

ccb.content.define_item {
    id = "mre_chocolate_pudding",
    copy_from = "mre_dessert",
    name = ccb.content.plural_text("chocolate pudding", "chocolate pudding"),
    mass = "75 g",
    description = ccb.content.text("Pudding made with chocolate.  Yummy!"),
    comestible = { calories = 300 },
}

ccb.content.define_item {
    id = "mre_chocolate_cake",
    copy_from = "toastem",
    name = ccb.content.plural_text("MRE toaster pastry", "MRE toaster pastries"),
    description = ccb.content.text("A toaster pastry that has been specially sterilized to last longer."),
    variants = {
        {
            id = "chocolate",
            name = ccb.content.plural_text("chocolate MRE toaster pastry", "chocolate MRE toaster pastries"),
            expand_snippets = true,
            description = ccb.content.text("This one has a chocolate filling."),
        },
        {
            id = "strawberry",
            name = ccb.content.plural_text("strawberry MRE toaster pastry", "strawberry MRE toaster pastries"),
            expand_snippets = true,
            description = ccb.content.text("This one has a strawberry filling."),
        },
    },
    comestible = {},
    inheritance = { add = { flags = { "RAD_STERILIZED", "DECAY_EXPOSED_ATMOSPHERE" } } },
}
