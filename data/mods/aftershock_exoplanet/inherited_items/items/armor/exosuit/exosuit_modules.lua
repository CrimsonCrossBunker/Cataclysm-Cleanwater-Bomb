local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "exo_lense_module",
        name = ccb.content.plural_text("exosuit multi-lens zoom module", "exosuit multi-lens zoom modules"),
        description = ccb.content.text("A series of strangely shaped hexagonal lenses that flutter about inside your helmet.  As the lenses shift things around you stay perfectly in focus no matter your eyesight or distance.  It can be mounted to an exosuit helmet."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 1000000,
        symbol = "(",
        color = "yellow",
    }
    item:material("lvl4ballisticglass", 1)
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("CANT_WEAR")
    item:flag("FIX_NEARSIGHT")
    item:flag("FIX_FARSIGHT")
    item:flag("ZOOM")
    item:flag("EXO_HELMET_GADGET")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end
