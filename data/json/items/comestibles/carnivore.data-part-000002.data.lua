local ccb = require("ccb")

ccb.content.define_item {
    id = "raw_curing_fatty_meat_active",
    copy_from = "raw_cured_fatty_meat",
    name = ccb.content.plural_text("slab of raw curing porkbelly", "of raw curing porkbelly slabs"),
    description = ccb.content.text("Porkbelly in the process of becoming fully cured with salt and sugar, capable of becoming bacon.  The flavor is slowly developing at this stage, and is significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    flags = { "SPAWN_ACTIVE" },
    revert_to = "raw_cured_fatty_meat",
    comestible = { fun = -15 },
    countdown_interval = "8 hours",
}

-- Meat that is still in the timed curing stage; distinct from fully cured raw meat.
ccb.content.define_item {
    id = "raw_curing_meat_active",
    copy_from = "flesh",
    name = ccb.content.plural_text("raw meat (curing)", "raw meat (curing)"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("raw human meat (curing)", "raw human meat (curing)"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("raw demihuman meat (curing)", "raw demihuman meat (curing)"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("raw mutant meat (curing)", "raw mutant meat (curing)"),
        },
    },
    description = ccb.content.text("Raw meat packed in salt and undergoing a week-long cure.  It is unpleasantly salty and cannot be cooked normally until the cure finishes and the meat is washed."),
    looks_like = "raw_curing_fatty_meat_active",
    display_type = "BY_WEIGHT",
    mass = "275 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "1 USD",
    flags = { "RAW", "SPAWN_ACTIVE" },
    revert_to = "raw_cured_meat",
    comestible = {
        shelf_life = "21 days",
        calories = 402,
        quench = -15,
        fun = -10,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    countdown_interval = "7 days",
}
