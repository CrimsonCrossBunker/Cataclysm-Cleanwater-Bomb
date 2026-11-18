local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mwhip_iron",
        category = "weapons",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("The Iron Whip", "Iron Whips"),
        description = ccb.content.text("A long braided flexible steel bullwhip that narrows into a sharp blade at the end.  Easily capable of slicing and dicing anything that comes at you.  It transforms back into a belt."),
        mass_milligrams = 2154000,
        volume_ml = 2000,
        price_cents = 350000,
        techniques = { "WBLOCK_1", "SWEEP", "WHIP_DISARM", "WRAP" },
        weapon_categories = { "WHIPS" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("WHIP")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "mbelt_iron_whip" },
        menu_text = ccb.content.text("Collapse"),
        moves = 20,
        message = ccb.content.text("You loop the whip in your hand and it coils back into a belt form in an instant."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 16)
    content.add(item)
end
