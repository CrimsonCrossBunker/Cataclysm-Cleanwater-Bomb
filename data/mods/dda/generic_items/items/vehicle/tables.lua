local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "v_table",
        name = ccb.content.plural_text("fancy table", "fancy tables"),
        description = ccb.content.text("A very fancy table for those with fancy lives.  If times were better, it might be useful for something other than firewood."),
        mass_milligrams = 9071000,
        melee_to_hit = -2,
        color = "red",
        symbol = "0",
        volume_ml = 13500,
        longest_side_mm = 1100,
        category = "veh_parts",
        price_cents = 20000,
        price_postapoc_cents = 100,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:deploy_furniture("f_table_fancy")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "w_table",
        name = ccb.content.plural_text("wooden table", "wooden tables"),
        description = ccb.content.text("A crude wooden table."),
        mass_milligrams = 10071000,
        copy_from = "v_table",
        looks_like = "v_table",
    }
    item:clear_use_actions()
    item:deploy_furniture("f_table")
    content.add(item)
end

do
    -- 73.3044 cm D x 76.962 cm W x 79.248 cm H, 447 L unfolded, assumed folding shave it to 10% of original volume
    local item = content.Item {
        id = "workbench",
        name = ccb.content.plural_text("workbench (folded)", "workbenches (folded)"),
        description = ccb.content.text("A sturdy workbench built out of metal.  It is perfect for crafting large and heavy things, when unfolded."),
        mass_milligrams = 18370000,
        volume_ml = 44700,
        longest_side_mm = 800,
        price_cents = 12000,
        copy_from = "v_table",
        looks_like = "v_table",
    }
    item:material("wood", 1)
    item:material("lc_steel", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_workbench")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "workbench_with_recharger",
        name = ccb.content.plural_text("workbench with battery recharger (folded)", "workbenches with battery rechargers (folded)"),
        description = ccb.content.text("A sturdy workbench built out of metal.  It is perfect for crafting large and heavy things, when unfolded.  It also has a built-in battery charger for your phone."),
        mass_milligrams = 20370000,
        price_cents = 40000,
        price_postapoc_cents = 100,
        copy_from = "workbench",
        looks_like = "workbench",
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:deploy_appliance("workbench_with_recharger")
    content.add(item)
end
