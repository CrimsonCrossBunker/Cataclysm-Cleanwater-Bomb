local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "motor",
        name = ccb.content.plural_text("electric motor", "electric motors"),
        description = ccb.content.text("A medium-duty electrical motor, suitable for powering ultra-light vehicles, or as part of a hybrid gas-electric drivetrain."),
        mass_milligrams = 46000000,
        color = "light_cyan",
        symbol = ",",
        volume_ml = 30000,
        category = "veh_parts",
        price_cents = 12000,
        price_postapoc_cents = 1500,
    }
    item:material("lc_steel", 1)
    item:material("copper", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:fault_group("electronic_general", {  })
    content.add(item)
end
