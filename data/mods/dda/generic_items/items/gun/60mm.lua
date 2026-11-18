local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mortar_m224",
        name = ccb.content.plural_text("light mortar", "light mortar"),
        description = ccb.content.text("Lightweight Company Mortar System is a portable mortar that can be carried and used by a one person, even if much slower than with a full crew of three.  Luckily, someone attached a bunch of firing tables to it.  Whoever will use it should be prepared to spend plenty of time estimating distances and calculating correct elevation and rotation angles."),
        category = "other",
        mass_milligrams = 21100000,
        volume_ml = 48000,
        longest_side_mm = 1000,
        price_cents = 1100000,
        price_postapoc_cents = 2000,
        symbol = "q",
        color = "light_gray",
    }
    item:variants {
        { id = "mortar_m224", name = ccb.content.plural_text("60mm M224 mortar", "60mm M224 mortars"), description = ccb.content.text("Lightweight Company Mortar System is a portable mortar that can be carried and used by a one person, even if much slower than with a full crew of three.  Luckily, someone attached a bunch of firing tables to it.  Whoever will use it should be prepared to spend plenty of time estimating distances and calculating correct elevation and rotation angles.") },
    }
    item:clear_use_actions()
    item:deploy_furniture("f_m224_mortar")
    item:material("steel", 1)
    content.add(item)
end
