local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "pseudo_experimental_crafter",
        symbol = "@",
        copy_from = "fake_item",
        name = content.plural_text("Experimental Crafter Pseudo", "Experimental Crafter Pseudos"),
        description = content.text("Pseudo item to allow players to use the Advanced Recycling and Manufacturing device, seeing this is a bug"),
        replace_qualities = true,
    }
    item:quality("CRAFTING_TERMINAL", 1)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    item:flag("DEBUG_ONLY")
    item:flag("TRADER_AVOID")
    content.add(item)
end
