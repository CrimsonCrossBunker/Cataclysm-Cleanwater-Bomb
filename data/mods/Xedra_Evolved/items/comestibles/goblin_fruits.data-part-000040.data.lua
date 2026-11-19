local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_social_boost",
    name = ccb.content.plural_text("arguing goblin fruit", "arguing goblin fruits"),
    description = ccb.content.text("This fruit reminds you of a small bowling ball.  You can hear it as it tries to convince you to not eat it.  It won't succeed, right?"),
    copy_from = "goblin_fruit_abstract",
    color = "blue_red",
    mass = "221 g",
    volume = "221 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_social_boost" },
}
