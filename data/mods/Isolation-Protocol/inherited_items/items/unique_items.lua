local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "iso_sorcerers_staff",
        copy_from = "q_staff",
        looks_like = "q_staff",
        name = ccb.content.plural_text("Blackstaff", "Blackstaff"),
        description = ccb.content.text("An enchanted ebony staff, with diamonds and starmetal on the end to facilitate the channeling of arcane energies.  If lost, it will always return to you.  While wielding the staff, the cost of your enchantments is reduced by 33% and their casting time is reduced by 50%."),
        mass_milligrams = 1530000,
        volume_ml = 1550,
        longest_side_mm = 1850,
        price_cents = 3900,
        symbol = "/",
        color = "white",
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:material("diamond", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("TRADER_AVOID")
    item:flag("RELIC_PINK")
    item:flag("MAGIC_FOCUS")
    item:clear_melee_damage()
    item:melee_damage("bash", 29)
    content.add(item)
end
