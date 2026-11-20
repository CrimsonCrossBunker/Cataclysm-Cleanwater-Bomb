local ccb = require("ccb")
local content = ccb.content

-- Native shopkeeper blacklist/whitelist definitions
do
local definition = content.ShopkeeperWhitelist {
    id = "FORGE_ALCHEMIST_WHITELIST",
    message = ccb.content.text("<npcname> is only interested in alchemy."),
}
definition:entry("denarius", "", "", "")
definition:entry("", "", "magic_plants_common", "")
definition:entry("", "", "magic_plants_uncommon", "")
definition:entry("", "", "magic_plants_rare", "")
definition:entry("", "", "potions_common", "")
definition:entry("", "", "potions_uncommon", "")
definition:entry("", "", "potions_rare", "")
definition:entry("", "", "potions_illegal", "")
content.add(definition)
end
do
local definition = content.ShopkeeperWhitelist {
    id = "FORGE_LIBRARIAN_WHITELIST",
    message = ccb.content.text("<npcname> does not want this in the library."),
}
definition:entry("denarius", "", "", "")
definition:entry("", "", "spellcraft_books", "")
definition:entry("", "", "dragon_books", "")
definition:entry("", "", "religious_books", "")
definition:entry("", "", "magic_recipe_basic", "")
definition:entry("", "", "magic_recipe_advanced", "")
definition:entry("", "", "magic_shop_books", "")
definition:entry("", "", "book_military", "")
definition:entry("", "", "book_gunref", "")
definition:entry("", "", "boxing_books", "")
definition:entry("", "", "book_survival", "")
definition:entry("", "", "book_school", "")
definition:entry("", "", "hardware_books", "")
definition:entry("", "", "ranch_homebooks", "")
definition:entry("", "", "manuals", "")
definition:entry("", "", "textbooks", "")
definition:entry("", "", "lab_bookshelves", "")
definition:entry("", "", "exotic_books", "")
definition:entry("", "", "esoteric_books", "")
definition:entry("", "", "dojo_manuals", "")
definition:entry("", "", "doctors_books", "")
definition:entry("", "", "fireman_doc", "")
definition:entry("", "", "tailorbooks", "")
definition:entry("", "", "carpentrybooks", "")
definition:entry("", "", "magazines", "")
definition:entry("", "", "forge_of_wonders_tradeables", "")
definition:entry("", "", "forge_lord_ardelia_loved_items", "")
content.add(definition)
end
do
local definition = content.ShopkeeperWhitelist {
    id = "FORGE_REAGENT_WHITELIST",
    message = ccb.content.text("<npcname> does not care for this."),
}
definition:entry("denarius", "", "", "")
definition:entry("", "", "NC_FORGE_LORD_STORE_REAGENT", "")
definition:entry("", "", "NC_FORGE_PIRATE_wield", "")
definition:entry("", "guns", "", "")
definition:entry("", "ammo", "", "")
definition:entry("", "", "forge_of_wonders_tradeables", "")
definition:entry("", "", "forge_lord_pirate_treasure", "")
content.add(definition)
end
do
local definition = content.ShopkeeperWhitelist {
    id = "NC_FORGE_LORD_WHITELIST",
    message = ccb.content.text("<npcname> is thoroughly uninterested in this."),
}
definition:entry("denarius", "", "", "")
definition:entry("", "", "NC_FORGE_LORD_SHOP", "")
definition:entry("", "", "NC_FORGE_LORD_ACCEPTED_BOOKS", "")
definition:entry("forge_of_wonders_tradeables", "", "", "")
content.add(definition)
end
