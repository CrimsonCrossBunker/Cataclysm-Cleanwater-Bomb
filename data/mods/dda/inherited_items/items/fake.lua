local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fake_smoke_plume",
        copy_from = "fake_item",
        name = ccb.content.plural_text("smoldering embers", "smoldering embers"),
        description = ccb.content.text("A handful of smoldering embers emitting smoke.  They are fading away before your eyes."),
        field_emissions = { "emit_small_smoke_plume" },
    }
    item:flag("TRADER_AVOID")
    item:flag("FAKE_SMOKE")
    content.add(item)
end
