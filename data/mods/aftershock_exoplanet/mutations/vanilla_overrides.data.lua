local ccb = require("ccb")

ccb.content.define_mutation {
    id = "AFS_NIGHTVISION",
    name = ccb.content.text("High Night Vision"),
    points = 2,
    description = ccb.content.text("You can see incredibly well in the dark!  Activate to toggle NV-visible areas on or off."),
    enchantments = { "INLINE_ENCH_AFS_NIGHTVISION_0" },
    categories = { "COMBAT_BRUTE" },
}

ccb.content.define_mutation {
    id = "DISRESISTANT",
    copy_from = "DISRESISTANT",
    add = { categories = { "COMBAT_BRUTE", "MIGO" } },
}

ccb.content.define_mutation { id = "DISIMMUNE", copy_from = "DISIMMUNE", add = { categories = { "COMBAT_BRUTE", "MIGO" } } }

ccb.content.define_mutation {
    id = "AFS_UNCARING",
    name = ccb.content.text("Uncaring"),
    points = 1,
    description = ccb.content.text("The suffering of others does not affect you, they either serve a purpose or they do not.  It's pragmatism, nothing more."),
    flags = { "PSYCHOPATH" },
    categories = { "COMBAT_BRUTE" },
}

ccb.content.define_mutation { id = "AFS_QUICK", copy_from = "QUICK", categories = { "COMBAT_BRUTE" } }

ccb.content.define_mutation { id = "INFRESIST", copy_from = "INFRESIST", add = { categories = { "COMBAT_BRUTE", "MIGO" } } }

ccb.content.define_mutation { id = "AFS_INFIMMUNE", copy_from = "INFIMMUNE", categories = { "COMBAT_BRUTE", "MIGO" } }

ccb.content.define_mutation { id = "AFS_PAINRESIST", copy_from = "PAINRESIST", categories = { "COMBAT_BRUTE" } }

ccb.content.define_mutation { id = "AFS_GOODCARDIO", copy_from = "GOODCARDIO", categories = { "COMBAT_BRUTE" } }
