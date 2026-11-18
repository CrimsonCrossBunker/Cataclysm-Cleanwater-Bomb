local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("spin_fidget_spinner", function(ctx)
    ctx:message(ccb.services.translate("You spin your fidget spinner."))
    return 0
end)

do
    local item = content.Item {
        id = "fidget_spinner",
        name = ccb.content.plural_text("fidget spinner", "fidget spinners"),
        description = ccb.content.text("A fidget spinner.  An artifact from when the times were simpler."),
        category = "other",
        mass_milligrams = 75000,
        volume_ml = 185,
        longest_side_mm = 100,
        price_cents = 500,
        price_postapoc_cents = 5,
        symbol = "/",
        color = "green",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:on_use("spin_fidget_spinner", ccb.content.text("Spin"))
    content.add(item)
end
