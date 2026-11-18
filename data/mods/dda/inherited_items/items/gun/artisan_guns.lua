local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "pulverizer",
        copy_from = "hammer_sledge",
        looks_like = "hammer_sledge",
        name = ccb.content.plural_text("the Disorder", "the Disorders"),
        description = ccb.content.text("A large, heavy sledge hammer converted for use as a weapon.  It features a notable safety on the side, and the back of the head has a firing mechanism that can be loaded with rifle blanks.  When the head impacts and the safety is off, the blanks are engaged, sending the moving piston forward and causing massive damage.  Etched into the head are the words 'she's lost control'."),
        techniques = { "WBLOCK_1", "BRUTAL", "WIDE", "SWEEP", "SWEETSPOT" },
        replace_pockets = true,
    }
    item:tool()
    item:ammo_pocket("powder_blank", 1)
    item:flag("RELOAD_EJECT")
    item:flag("DURABLE_MELEE")
    item:adjust_measurements { mass_milligrams = { factor = 1.2 } }
    content.add(item)
end
