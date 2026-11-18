local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "laevateinn",
        copy_from = "i_staff",
        looks_like = "i_staff",
        name = ccb.content.plural_text("Laevateinn", "Laevateinns"),
        description = ccb.content.text("Laevateinn, the staff of Loki.  Said to have been plucked from the gates of Hel by Loki.  Imbued with a mysterious magic, the magic of the trickster god himself."),
        price_cents = 160000,
        techniques = { "WBLOCK_2", "SPIN", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        mass_milligrams = 1860000,
    }
    item:material("steel", 1)
    item:material("gold", 1)
    item:material("orichalcum_metal", 1)
    item:clear_use_actions()
    item:cast_spell { spell = "ethereal_grasp", no_fail = true, level = 10, need_wielding = true }
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:melee_damage("cut", 35)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:flag("MAGIC_FOCUS")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("SPELLCASTING_AID")
    content.add(item)
end
