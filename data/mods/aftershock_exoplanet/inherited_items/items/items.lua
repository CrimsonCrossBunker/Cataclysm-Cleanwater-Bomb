local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nanomaterial",
        copy_from = "nanomaterial",
        looks_like = "nanomaterial",
        price_cents = 5500,
        price_postapoc_cents = 5500,
        name = ccb.content.plural_text("nanomaterial canister", "nanomaterial canisters"),
        description = ccb.content.text("A steel canister containing carbon, iron, titanium, copper, and other elements in specifically engineered atomic-scale configurations.  Feedstock for most modern industrial processes, a nanofabricator can assemble them into usable items."),
    }
    content.replace(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "atomic_pseudo_churn",
        name = content.plural_text("pseudo atomic butter churn", "pseudo atomic butter churns"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 20000,
        replace_qualities = true,
        symbol = "H",
        color = "light_cyan",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:quality("CONTAIN", 1)
    item:quality("CHURN", 2)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end
