local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "debug_lux_meter",
        category = "tools",
        name = content.plural_text("debug lux meter", "debug lux meters"),
        description = content.text("This debug tool will tell you about light."),
        mass_milligrams = 1000,
        volume_ml = 1,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("DBG_LUX_METER")
    item:tool()
    content.add(item)
end
