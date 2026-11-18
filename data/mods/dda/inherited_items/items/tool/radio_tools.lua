local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "radio_mod",
        category = "spare_parts",
        name = ccb.content.plural_text("radio activation mod", "radio activation mods"),
        description = ccb.content.text("A small electronic device that can be attached to certain items to activate them with a radio signal from an RC car controller."),
        mass_milligrams = 142000,
        volume_ml = 250,
        price_cents = 5000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("RADIO_MOD")
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:tool()
    content.add(item)
end
