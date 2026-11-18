local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fcl_bio_whip_weapon",
        symbol = "/",
        color = "red",
        name = ccb.content.plural_text("monofilament whip", "monofilament whips"),
        description = ccb.content.text("A long filament of nested carbon nanotubes only a few microns in diameter.  In essence a very thin, very strong and very sharp blade that you throw at a moment's notice."),
        mass_milligrams = 40000,
        volume_ml = 200,
        price_cents = 3500,
        price_postapoc_cents = 500,
        techniques = { "WBLOCK_1", "WIDE", "SPIN", "RAPID" },
        melee_to_hit = -2,
        weapon_categories = { "BIONIC_WEAPONRY" },
    }
    item:material("nanotubes", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("BIONIC_WEAPON")
    item:flag("BIONIC_WEAPON_MELEE")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("TRADER_AVOID")
    item:flag("USE_UPS")
    item:clear_melee_damage()
    item:melee_damage("cut", 27)
    content.add(item)
end
