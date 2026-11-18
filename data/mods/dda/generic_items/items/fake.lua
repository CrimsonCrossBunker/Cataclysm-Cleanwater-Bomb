local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fake_milling_item",
        copy_from = "fake_item",
        name = ccb.content.plural_text("semi ground grains", "semi ground grains"),
        description = ccb.content.text("A paste of half-finished milled grains, not yet flour."),
    }
    item:clear_flags()
    item:flag("DEBUG_ONLY")
    item:flag("FAKE_MILL")
    item:flag("TRADER_AVOID")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "debug_item_search",
        name = content.plural_text("debug item search", "debug item searchs"),
        symbol = "?",
        description = content.text("This is a dummy item used by item search.  You should never see it outside of debug."),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end
