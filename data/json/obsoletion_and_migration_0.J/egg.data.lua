local ccb = require("ccb")

-- 30 minutes
ccb.content.define_item {
    id = "curing_roe",
    copy_from = "egg_fish",
    name = ccb.content.plural_text("curing roe (obsolete)", "curing roe (obsolete)"),
    description = ccb.content.text("Roe in the process of becoming fully cured with salt, capable of becoming homemade caviar.  The flavor is slowly developing at this stage, and is currently significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    mass = "96 g",
    volume = "500ml",
    stack_size = 4,
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    phase = "liquid",
    comestible = { servings = 1, calories = 68, fun = -15 },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "cured_roe",
            message = ccb.content.text("You remove the roe from the brine and now have post apocalypse caviar."),
            moves = 150,
            age = 1800,
            not_ready_message = ccb.content.text("The roe isn't fully cured yet."),
        },
    },
}
