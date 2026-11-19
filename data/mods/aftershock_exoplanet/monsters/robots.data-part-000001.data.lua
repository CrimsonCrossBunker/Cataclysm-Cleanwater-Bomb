local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_migoturret_whately",
    name = ccb.content.plural_text("Whately family brain blaster", "Whately family brain blasters"),
    description = ccb.content.text("The Whately family deploys mi-go style techno-organic defensive turrets.  They claim that these turrets are made from family members near death, but you have doubts."),
    default_faction = "whately",
    copy_from = "afs_mon_migoturret",
    aggression = 1,
}
