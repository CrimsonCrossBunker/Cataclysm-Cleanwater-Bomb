local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "golden_bridle",
        name = ccb.content.plural_text("golden bridle", "golden bridles"),
        description = ccb.content.text("A golden bridle made of spun moon tears, gold, and incredibly strong hair including associated tack that can be placed on a tamed mythical animal that is capable of being ridden."),
        mass_milligrams = 2000000,
        volume_ml = 7000,
        price_cents = 0,
        price_postapoc_cents = 1000,
        symbol = "M",
        color = "yellow",
    }
    item:material("moon_tears", 1)
    item:material("fae_fur", 1)
    item:material("gold", 1)
    item:clear_flags()
    item:flag("TACK")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end
