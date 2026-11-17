local content = require("ccb").content

content.add(content.AmmoEffect { id = "EXPLOSIVE_HUGE" }
    :explosion{ power = 1200, distance_factor = 0.75 })

content.add(content.AmmoEffect { id = "CLEAN_DUST" }
    :cast_spells_on_miss(true)
    :spell("spell_clean_dust"))

content.add(content.AmmoEffect { id = "CLEAN_SPLINTERS" }
    :cast_spells_on_miss(true)
    :spell("spell_clean_splinters"))

content.add(content.AmmoEffect { id = "CLEAN_BLOOD" }
    :cast_spells_on_miss(true)
    :spell("spell_clean_blood"))
