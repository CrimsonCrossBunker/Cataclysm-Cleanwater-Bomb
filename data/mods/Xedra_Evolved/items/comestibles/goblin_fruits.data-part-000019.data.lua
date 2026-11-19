local ccb = require("ccb")

ccb.content.define_item {
    id = "shadow_fruit",
    name = ccb.content.plural_text("shadowy goblin fruit", "shadowy goblin fruits"),
    description = ccb.content.text("This greyish goblin fruit is shaped like a pear, if pears had scales like a pinecone.  There is a pulpy meat underneath the scales."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "118 g",
    volume = "151 ml",
    comestible = { kind = "FOOD", on_consume = "consume_shadow_fruit" },
}
