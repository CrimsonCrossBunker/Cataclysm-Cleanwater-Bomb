local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_money_maker_merc",
    name = ccb.content.text("Money Makin' Mercenary"),
    points = 0,
    description = ccb.content.text("You've always had a knack for finding the value in life, whether it's $200 or $50 for a life.  You get more money from completing hordes."),
    categories = { "perk" },
    on_process = "money_maker_setup",
}
