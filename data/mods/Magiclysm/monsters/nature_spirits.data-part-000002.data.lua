local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_treant_druid",
    copy_from = "mon_treant",
    name = ccb.content.plural_text("treant", "treants"),
    default_faction = "player",
}
