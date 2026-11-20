local ccb = require("ccb")
local content = ccb.content

-- Native shopkeeper blacklist/whitelist definitions
do
local definition = content.ShopkeeperBlacklist {
    id = "rubik_shopkeep_blacklist",
}
definition:entry("", "", "exodii_do_not_buy_currency_blacklist", ccb.content.text("Will not accept currency"))
definition:entry("", "", "exodii_do_not_buy_ammo_blacklist", "")
definition:entry("", "clothing", "", "")
definition:entry("", "", "SUS_bathroom_sink", "")
definition:entry("", "", "exodii_unwanted_bathroom_medicine", "")
definition:entry("", "", "exodii_do_not_pay_extra_for_exodii_metal", "")
definition:entry("", "", "exodii_do_not_pay_extra_for_makeshift_medicine", "")
definition:entry("", "", "SUS_toilet", "")
definition:entry("", "", "SUS_bathroom_cabinet", "")
definition:entry("", "", "SUS_dishes", "")
definition:entry("", "", "SUS_cookware", "")
definition:entry("", "", "SUS_utensils", "")
definition:entry("", "", "SUS_junk_drawer", "")
definition:entry("", "", "SUS_junk_drawer_messy", "")
definition:entry("", "", "SUS_junk_drawer_artsy", "")
definition:entry("", "", "SUS_kitchen_sink", "")
definition:entry("", "", "Exodii_mod_blacklist_items", "")
content.add(definition)
end
do
local definition = content.ShopkeeperBlacklist {
    id = "cyborg_type_9_shopkeep_blacklist",
}
definition:entry("", "", "exodii_do_not_buy_currency_blacklist", ccb.content.text("Will not accept currency"))
definition:entry("", "", "exodii_do_not_buy_ammo_blacklist", "")
definition:entry("", "clothing", "", "")
definition:entry("", "", "SUS_bathroom_sink", "")
definition:entry("", "", "exodii_unwanted_bathroom_medicine", "")
definition:entry("", "", "exodii_do_not_pay_extra_for_exodii_metal", "")
definition:entry("", "", "exodii_do_not_pay_extra_for_makeshift_medicine", "")
definition:entry("", "", "SUS_toilet", "")
definition:entry("", "", "SUS_bathroom_cabinet", "")
definition:entry("", "", "SUS_dishes", "")
definition:entry("", "", "SUS_cookware", "")
definition:entry("", "", "SUS_utensils", "")
definition:entry("", "", "SUS_junk_drawer", "")
definition:entry("", "", "SUS_junk_drawer_messy", "")
definition:entry("", "", "SUS_junk_drawer_artsy", "")
definition:entry("", "", "SUS_kitchen_sink", "")
content.add(definition)
end
do
local definition = content.ShopkeeperBlacklist {
    id = "LUMBERMILL_MERCHANT_blacklist",
}
definition:entry("", "", "LUMBERMILL_MERCHANT_trade", "")
content.add(definition)
end
do
local definition = content.ShopkeeperBlacklist {
    id = "robofac_blacklist",
}
definition:entry("", "", "NC_ROBOFAC_gear", ccb.content.text("Will not buy back their own gear"))
definition:entry("", "clothing", "", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "novels", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "novel_pulp", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "literature", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "cookbooks", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "religious_books", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "nonfiction_hardback_fluff", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_book_nonf_hard_homemk", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_book_nonf_soft", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_book_nonf_hard_dodge", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_book_fict_soft_ya", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "book_judaica_hardcover", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "book_judaica_softcover", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "theater_props", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "phonebook", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "boxing_books", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "games", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_bathroom_sink", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_bathroom_medicine", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_toilet", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_bathroom_cabinet", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_dishes", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_cookware", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_utensils", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_junk_drawer", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_kitchen_sink", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "stoner", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "SUS_oven", ccb.content.text("The Hub has no interest in this"))
definition:entry("", "", "garden_shed", ccb.content.text("The Hub has no interest in this"))
content.add(definition)
end
do
local definition = content.ShopkeeperConsumptionRates {
    id = "basic_shop_rates",
    default_rate = 5,
    junk_threshold_cents = 10,
}
definition:entry("", "currency", "", "", 10)
definition:entry("", "spare_parts", "", "", 100)
content.add(definition)
end
do
local definition = content.ShopkeeperConsumptionRates {
    id = "elvira_shop_rates",
    default_rate = 5,
    junk_threshold_cents = 10,
}
definition:entry("", "currency", "", "", 10)
definition:entry("", "spare_parts", "", "", 100)
definition:entry("FMCNote", "", "", "", -1)
content.add(definition)
end
do
local definition = content.ShopkeeperConsumptionRates {
    id = "smokes_shop_rates",
    default_rate = 5,
    junk_threshold_cents = 10,
}
definition:entry("", "currency", "", "", 10)
definition:entry("", "spare_parts", "", "", 100)
definition:entry("FMCNote", "", "", "", -1)
content.add(definition)
end
