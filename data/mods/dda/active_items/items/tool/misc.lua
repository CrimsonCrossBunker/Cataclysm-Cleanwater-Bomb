local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "teleumbrella-extended",
        category = "tools",
        name = ccb.content.plural_text("telescoping umbrella (extended)", "telescoping umbrellas (extended)"),
        description = ccb.content.text("A telescoping umbrella currently in its extended form, useful for keeping dry when wielded.  May be collapsed down for easy storage."),
        mass_milligrams = 411000,
        volume_ml = 1500,
        longest_side_mm = 1010,
        price_cents = 12000,
        price_postapoc_cents = 100,
        melee_to_hit = -1,
        symbol = ",",
        ascii_picture = "umbrella",
        looks_like = "umbrella",
        color = "dark_gray",
        techniques = { "WBLOCK_1" },
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("RAIN_PROTECT")
    item:flag("SHEATH_SWORD")
    item:flag("FRAGILE_MELEE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "teleumbrella" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You collapse your umbrella."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 4)
    content.add(item)
end
