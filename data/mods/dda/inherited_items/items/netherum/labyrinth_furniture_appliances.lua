local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nl_safehouse_boiler",
        name = ccb.content.plural_text("disconnected otherworldly boiler", "disconnected otherworldly boilers"),
        description = ccb.content.text("A huge, pot-bellied device that resembles something between a coal-burning stove and a boiler, with a wide, hinged cage covering the combustion chamber.  Three unmarked gauges sit like alien eyes upon its face.  A side-mounted crank is its only visible control.  In defiance of its apparent function, it has no exhaust vent; in its place is a hose twisted on itself several times, coiled in copper, and terminating in a bulbous back-mounted battery pack."),
        mass_milligrams = 400000000,
        volume_ml = 200000,
        longest_side_mm = 2000,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        symbol = "&",
        color = "red",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:ammo_pocket("battery", 10000)
    item:tool()
    content.add(item)
end
