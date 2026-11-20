local ccb = require("ccb")

-- 8 hours
ccb.content.define_item {
    id = "raw_curing_fatty_meat",
    copy_from = "flesh",
    name = ccb.content.plural_text("slab of raw curing porkbelly (obsolete)", "slabs of raw curing porkbelly (obsolete)"),
    description = ccb.content.text("Porkbelly in the process of becoming fully cured with salt and sugar, capable of becoming bacon.  The flavor is slowly developing at this stage, and is significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    mass = "275 g",
    volume = "250ml",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    flags = {},
    comestible = {
        calories = 1556,
        shelf_life = "14 days",
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 0 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "raw_cured_fatty_meat",
            message = ccb.content.text("You pat off a bit of extra brine from the slice; this piece of meat is now fully cured."),
            moves = 150,
            age = 28800,
            not_ready_message = ccb.content.text("The meat isn't fully cured yet."),
        },
    },
}
