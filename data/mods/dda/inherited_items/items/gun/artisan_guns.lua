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

do
    local item = content.Item {
        id = "louverture",
        copy_from = "mace",
        looks_like = "mace",
        name = ccb.content.plural_text("the Louverture", "the Louverture"),
        description = ccb.content.text("An oddly-vented mace with an internal fuel reservoir built into the pommel.  Can be engaged to ignite large puffs of gasoline and start fires."),
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "bring_the_sun", no_fail = true, level = 1, need_wielding = true, mundane = true }
    item:flag("FIRESTARTER")
    item:adjust_measurements { volume_ml = { factor = 1.1 }, mass_milligrams = { factor = 1.2 } }
    item:tool { charges_per_use = 100 }
    item:magazine_pocket { ammo_capacities = { gasoline = 500 }, rigid = true, watertight = true }
    content.add(item)
end
