local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "grinder_blade",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("grinder blade", "grinder blades"),
        description = ccb.content.text("A 125 mm angle grinder blade.  You could make a power tool with it, or throw it.  Wielding it without sturdy gloves is a bad idea."),
        category = "spare_parts",
        price_cents = 20,
        price_postapoc_cents = 500,
        mass_milligrams = 349000,
        volume_ml = 250,
        melee_to_hit = -4,
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    item:clear_melee_damage()
    item:melee_damage("cut", 14)
    content.add(item)
end
