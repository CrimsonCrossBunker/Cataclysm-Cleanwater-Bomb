local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rubik_farthing",
        name = ccb.content.plural_text("shiny farthing", "shiny farthings"),
        category = "currency",
        description = ccb.content.text("A small, shiny brass coin with a picture of a stern-looking older man on one side and the words 'For all of Angland and her children' in an arc beneath him.  On the other side is a large number '1' wreathed in what appear to be nettle leaves."),
        mass_milligrams = 2000,
        color = "yellow",
        symbol = ".",
        volume_ml = 1,
        price_cents = 1,
        price_postapoc_cents = 1,
    }
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:material("copper", 1)
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end
