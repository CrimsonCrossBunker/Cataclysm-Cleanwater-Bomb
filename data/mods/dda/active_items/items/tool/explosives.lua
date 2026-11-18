local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "LAW_Packed",
        category = "guns",
        name = ccb.content.plural_text("packed disposable rocket launcher", "packed disposable rocket launchers"),
        description = ccb.content.text("A packed, disposable light anti-tank rocket launcher.  Once fired, it cannot be reloaded and must be disposed of.  Activate it to pop it out and make it ready to fire."),
        variant_kind = "gun",
        mass_milligrams = 2500000,
        volume_ml = 1500,
        longest_side_mm = 630,
        price_cents = 200000,
        price_postapoc_cents = 4000,
        symbol = ")",
        color = "green",
    }
    item:variants {
        { id = "LAW_Packed", name = ccb.content.plural_text("M72 LAW (packed)", "M72 LAWs (packed)"), description = ccb.content.text("The M72 LAW (Light Anti-armor Weapon) is a one-time use lightweight rocket launcher, meant to take out tanks and other armored vehicles.  Designed to replace the earlier Bazookas, it features a shaped-charge warhead to pierce armor.  Though weaker than the more modern and heavier AT4, it's still in service to this day.  Due to its design, you must unpack it to use it, and it cannot be reloaded.  Activate to unpack.") },
    }
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "LAW", charges = 1, ammo_type = "66mm_HEAT" },
        message = ccb.content.text("You pull the activating lever, readying the LAW to fire."),
        menu_text = ccb.content.text("Unpack"),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end
