local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "baton",
        category = "weapons",
        name = ccb.content.plural_text("expandable baton", "expandable batons"),
        description = ccb.content.text("A telescoping baton that collapses for easy storage.  Right now, it's collapsed.  Activate to expand."),
        mass_milligrams = 606000,
        volume_ml = 140,
        longest_side_mm = 240,
        color = "dark_gray",
        price_postapoc_cents = 750,
        symbol = "/",
        melee_to_hit = 0,
        price_cents = 22900,
    }
    item:material("steel", 7)
    item:material("plastic", 3)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "baton-extended" },
        menu_text = ccb.content.text("Expand"),
        message = ccb.content.text("You snap open your baton."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:fault_group("batons", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "baton-extended",
        copy_from = "baton",
        looks_like = "baton",
        name = ccb.content.plural_text("expandable baton (extended)", "expandable batons (extended)"),
        description = ccb.content.text("A telescoping baton that collapses for easy storage.  Makes a good melee weapon.  Activate to collapse."),
        volume_ml = 260,
        longest_side_mm = 600,
        melee_to_hit = 2,
        techniques = { "WBLOCK_1", "RAPID", "PRECISE", "MOUNTED_CHARGE" },
        weapon_categories = { "BATONS" },
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "baton" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You collapse your baton."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    content.add(item)
end

do
    local item = content.Item {
        id = "PR24-extended",
        category = "weapons",
        name = ccb.content.plural_text("PR-24 baton (extended)", "PR-24 batons (extended)"),
        description = ccb.content.text("The Monadnock PR-24 baton is a collapsible, lightweight, side-handle baton used by law enforcement all over the world.  The PR designation is rumored to mean Public Relations.  Activate to retract."),
        mass_milligrams = 680000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_2", "RAPID", "PRECISE", "MOUNTED_CHARGE" },
        weapon_categories = { "BATONS" },
        volume_ml = 2000,
        longest_side_mm = 600,
        melee_to_hit = 3,
        price_cents = 30000,
        price_postapoc_cents = 750,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "PR24-retracted" },
        menu_text = ccb.content.text("Retract"),
        message = ccb.content.text("You collapse your baton."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("batons", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "PR24-retracted",
        category = "weapons",
        name = ccb.content.plural_text("PR-24 baton (retracted)", "PR-24 batons (retracted)"),
        description = ccb.content.text("The Monadnock PR-24 baton is a collapsible, lightweight, side-handle baton used by law enforcement all over the world.  The PR designation is rumored to mean Public Relations.  Activate to extend."),
        mass_milligrams = 680000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 1000,
        longest_side_mm = 200,
        melee_to_hit = 1,
        price_cents = 30000,
        price_postapoc_cents = 750,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "PR24-extended" },
        menu_text = ccb.content.text("Extend"),
        message = ccb.content.text("You snap open your baton."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:fault_group("batons", {  })
    content.add(item)
end
