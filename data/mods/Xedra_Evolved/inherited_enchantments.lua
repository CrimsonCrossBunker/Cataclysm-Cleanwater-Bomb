local content = require("ccb").content

-- mutations/paraclesians/homullus_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_HOMULLUS_BACKSTAGE_active_0" }
    :value("SOCIAL_LIE", { add = -20 })
    :value("SOCIAL_PERSUADE", { add = -20 })
    :value("SOCIAL_INTIMIDATE", { add = -30 }))
