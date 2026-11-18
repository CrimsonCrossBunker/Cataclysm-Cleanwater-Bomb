local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tinderbox",
        name = ccb.content.plural_text("ember carrier", "ember carriers"),
        description = ccb.content.text("A small container for holding tinder, with holes punched in it to provide a controlled airflow.  It can nurture a smoldering ember for a long time, to start fires without modern tools."),
        mass_milligrams = 40000,
        volume_ml = 263,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tinderbox_on" },
        menu_text = ccb.content.text("Light", "verb"),
        message = ccb.content.text("You light the tinder."),
        need_charges = 1,
        need_fire = 1,
        need_charges_message = ccb.content.text("The ember carrier is out of tinder."),
    }
    item:tool { ammo_types = { "tinder" } }
    item:magazine_pocket { ammo_capacities = { tinder = 50 }, rigid = true }
    content.add(item)
end
