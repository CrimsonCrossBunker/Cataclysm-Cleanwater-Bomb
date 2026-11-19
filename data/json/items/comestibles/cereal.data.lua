local ccb = require("ccb")

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
