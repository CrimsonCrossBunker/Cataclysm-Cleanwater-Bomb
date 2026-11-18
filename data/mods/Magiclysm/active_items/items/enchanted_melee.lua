local ccb = require("ccb")
local content = ccb.content

do
    -- Effectively a durable knife spear +2 and a barb launcher that shoots sharpened bone, will have less dps because it has reach and is capable of morphing into a gun
    local item = content.Item {
        id = "rune_biomancer_weapon_adept",
        copy_from = "spear_knife",
        looks_like = "spear_knife",
        name = ccb.content.plural_text("Biomancer shifting spear", "Biomancer shifting spears"),
        description = ccb.content.text("A grotesque bone spearhead on a hardened flesh pole.  There is a Biomancer rune embedded in the middle.  You feel this spear squirming in your hand as if alive."),
        mass_milligrams = 1422000,
        volume_ml = 1350,
        longest_side_mm = 1300,
        price_cents = 3900,
        melee_to_hit = 3,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "IMPALE", "MOUNTED_CHARGE" },
        replace_qualities = true,
    }
    item:material("hflesh", 1)
    item:material("bone", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "rune_biomancer_gun_adept_trans" },
        menu_text = ccb.content.text("Extend"),
        message = ccb.content.text("You feel the spear rapidly contracting and squirming for ranged combat"),
        need_wielding = true,
        moves = 400,
    }
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("stab", 25)
    content.add(item)
end

do
    local item = content.Item {
        id = "springstaff-retracted",
        category = "weapons",
        name = ccb.content.plural_text("springstaff(baton)", "springstaves(baton)"),
        description = ccb.content.text("This versatile weapon uses Technomancy-enhanced springs to keep the staff tips retracted while in baton configuration.  Activate to extend."),
        mass_milligrams = 1800000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "RAPID" },
        weapon_categories = { "BATONS" },
        volume_ml = 750,
        longest_side_mm = 600,
        price_cents = 34000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "springstaff-extended" },
        menu_text = ccb.content.text("Extend to staff"),
        message = ccb.content.text("You snap open your springstaff into staff mode."),
        moves = 50,
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:fault_group("batons", {  })
    item:fault_group("steel_pipe_long", { weight_multiplier = 0 })
    content.add(item)
end

do
    local item = content.Item {
        id = "springstaff-extended",
        category = "weapons",
        name = ccb.content.plural_text("springstaff(staff)", "springstaves(staff)"),
        description = ccb.content.text("This versatile weapon uses Technomancy-enhanced springs to keep the staff tips from retracting while in staff configuration.  Activate to extend."),
        mass_milligrams = 1800000,
        melee_to_hit = 4,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_2", "RAPID", "SWEEP" },
        weapon_categories = { "QUARTERSTAVES" },
        volume_ml = 3000,
        longest_side_mm = 1500,
        price_cents = 34000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "springstaff-retracted" },
        menu_text = ccb.content.text("Retract to baton"),
        message = ccb.content.text("You collapse your springstaff into baton mode."),
        moves = 200,
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 29)
    item:fault_group("batons", { weight_multiplier = 0 })
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end
