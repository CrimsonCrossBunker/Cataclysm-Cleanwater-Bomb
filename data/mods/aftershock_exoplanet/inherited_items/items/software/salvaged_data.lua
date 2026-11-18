local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "afs_software_materialized",
        abstract = true,
        category = "chems",
        name = content.plural_text("Software Materialized", "Software Materializeds"),
        looks_like = "c4armed",
        description = content.text("It'd be great if this was actually software, but NPCs can't trade that yet."),
        mass_milligrams = 10000,
        volume_ml = 5,
        price_cents = 200,
        melee_to_hit = -5,
        symbol = "(",
        color = "light_red",
    }
    item:material("steel", 1)
    item:tool()
    content.add(item)
end
