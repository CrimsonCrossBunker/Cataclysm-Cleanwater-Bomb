local ccb = require("ccb")

ccb.content.define_item {
    id = "curing_roe_active",
    copy_from = "egg_fish",
    name = ccb.content.plural_text("curing roe", "curing roe"),
    description = ccb.content.text("Roe in the process of becoming fully cured with salt, capable of becoming homemade caviar.  The flavor is slowly developing at this stage, and is currently significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    mass = "96 g",
    volume = "500ml",
    stack_size = 4,
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    phase = "liquid",
    revert_to = "cured_roe",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    comestible = { servings = 1, calories = 68, fun = -15 },
    countdown_interval = "30 minutes",
}
