local ccb = require("ccb")

ccb.content.define_item {
    id = "venom_paralytic",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("sac of paralytic venom", "sacs of paralytic venom"),
    description = ccb.content.text("A grayish, flexible vesicle filled to the brim with the potent paralytic agent the triffids use to subdue still-moving fertilizer such as yourself.  If you know your way around poisons you might be able to find a use for it."),
    materials = { "veggy" },
    color = "light_gray",
    comestible = { fun = -50, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "triffid_fungicide",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("sac of triffid fungicide", "sacs of triffid fungicide"),
    description = ccb.content.text("A triffid sac filled with what appears to be a triffid-produced antifungal agent.  It will likely already work as an antifungal compound for more offensive applications, but requires further refining before it can be used as a medical drug."),
    materials = { "veggy" },
    color = "light_blue",
    comestible = { fun = -50, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}
