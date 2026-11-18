local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "damaged_shelter_kit",
        name = ccb.content.plural_text("damaged shelter kit", "damaged shelter kits"),
        description = ccb.content.text("A disassembled small shelter made of sticks and skins.  It's been damaged and needs to be repaired before you can set it up."),
        mass_milligrams = 1360000,
        volume_ml = 7500,
        longest_side_mm = 900,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:material("leather", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end
