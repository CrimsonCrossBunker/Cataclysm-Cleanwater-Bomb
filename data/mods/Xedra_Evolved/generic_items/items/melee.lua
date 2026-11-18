local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "salamagman_macuahuitl",
        name = ccb.content.plural_text("obsidian macuahuitl", "obsidian macuahuitls"),
        description = ccb.content.text("Astute observers of Mesoamerican history may recognize this as a macuahuitl, the favored weapon of the Aztecs.  This macuahuitl looks as though it was made deep inside of a black mirror."),
        copy_from = "lc_aztec_sword",
        looks_like = "lc_aztec_sword",
        price_cents = 400000,
        price_postapoc_cents = 120000,
    }
    item:material("tezcatlipocas_blood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 30)
    item:melee_damage("heat", 21)
    content.add(item)
end
