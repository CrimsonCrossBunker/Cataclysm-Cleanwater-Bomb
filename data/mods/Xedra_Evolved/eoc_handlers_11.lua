local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM_REMOVABLE"] = function(ctx)
    do local _g = H.safe_id('json_flag', "NO_TAKEOFF"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "SHAPESHIFTED_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    COND["EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM"] = function(ctx)
        return (((("item_hedge_turn_into_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM"] = function(ctx)
    if (((("item_hedge_turn_into_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("As you put the mantle on, your skin writhes, your limbs twist, and thick fur sprouts from your body as you fall onto all fours.")), "neutral")
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw85 = H.var_num(H.u(ctx), "preshift_size")
            if _sw85 == 1 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw85 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw85 == 3 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw85 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw85 == 5 then
            end
        end
        H.run_eoc("EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM", ctx, nil, nil, nil)
        do local _g = H.safe_id('mutation', "TURN_INTO_BEAR_TRAITS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { worn_only = true } }, { "EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM_INTANGIBLE" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { worn_only = true } }, { "EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM_REMOVABLE" }, {  })
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM_FOLLOWUP_2"] = function(ctx)
    H.consume_item(H.u(ctx), "item_hedge_turn_into_bear", 1, 0)
    H.eoc_spawn_item(H.u(ctx), "item_hedge_turn_into_bear_off", 1, false, false, nil)
    return true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM_FOLLOWUP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_hedge_turn_into_bear" } }, { "EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM_FOLLOWUP_2" }, {  })
    return true
    end
    COND["EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM"] = function(ctx)
        return (((("item_hedge_turn_into_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM"] = function(ctx)
    if (((("item_hedge_turn_into_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        H.lose_trait(H.u(ctx), "TURN_INTO_BEAR_TRAITS")
        do
            local _sw86 = H.var_num(H.u(ctx), "preshift_size")
            if _sw86 == 1 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw86 == 2 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw86 == 3 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw86 == 4 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw86 == 5 then
            end
        end
        H.run_eoc("EOC_SHAPESHIFTING_ARMOR_CHECK_RETURN_ARMOR_TO_NORMAL", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS"] = function(ctx)
        return ((H.u(ctx) ~= nil and H.safe_id('json_flag', "SKINCHANGED") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "SKINCHANGED")).value == true)) == true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS"] = function(ctx)
    if ((H.u(ctx) ~= nil and H.safe_id('json_flag', "SKINCHANGED") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "SKINCHANGED")).value == true)) then
        H.eoc_add_effect(H.u(ctx), "effect_skinchanged_penalties", (services.random.native_int(0, H.round_half_away(10800)) + 3600), nil, (H.creature_effect_intensity(H.u(ctx), "effect_skinchanged_penalties") + 1), nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(2700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS_CURE_FAST"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS"), nil) end end
        if ((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) <= 3) then
            H.eoc_add_effect(H.u(ctx), "effect_skinchanged_animalistic_mind", 604800, nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("It would be so easy to walk off into the forest and forget you had ever been human.")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS_CURE_FAST"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "SKINCHANGED") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "SKINCHANGED")).value == true))) and ((function() local eg = H.safe_id('effect', "effect_skinchanged_penalties"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS_CURE_FAST"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "SKINCHANGED") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "SKINCHANGED")).value == true))) and ((function() local eg = H.safe_id('effect', "effect_skinchanged_penalties"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "skinchanged_penalty", H.creature_effect_intensity(H.u(ctx), "effect_skinchanged_penalties"))
        do local _eg = H.safe_id('effect', "effect_skinchanged_penalties"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_skinchanged_penalties", 3600, nil, (H.var_num(H.u(ctx), "skinchanged_penalty") - 1), nil)
        if (((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) >= 4) and ((function() local eg = H.safe_id('effect', "effect_skinchanged_animalistic_mind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _eg = H.safe_id('effect', "effect_skinchanged_animalistic_mind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("You remember your childhood.  The sound of your mother's voice.  You are not a wild beast!")), "good")
        end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(2700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_TURN_INTO_BEAR_SIDE_EFFECTS_CURE_FAST"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_REMOVE_ITEM"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your nonexistence arms somehow remove the mantle and return to your old shape.")), "neutral")
    H.lose_trait(H.u(ctx), "TURN_INTO_BEAR_TRAITS")
    do
        local _sw87 = H.var_num(H.u(ctx), "preshift_size")
        if _sw87 == 1 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw87 == 2 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw87 == 3 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw87 == 4 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw87 == 5 then
        end
    end
    H.consume_item(H.u(ctx), "item_hedge_turn_into_bear", 1, 0)
    H.eoc_spawn_item(H.u(ctx), "item_hedge_turn_into_bear_off", 1, false, false, nil)
    return true
    end
    COND["EOC_HEDGE_WALK_ON_WATER"] = function(ctx)
        return (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) == true
    end
    EOC["EOC_HEDGE_WALK_ON_WATER"] = function(ctx)
    if (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) then
        services.messages.add(ctx:expand_text(services.translate("You drop the bark on the water and recite the words of the charm, and as you take your first step, the water feels firm under your feet.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_hedge_walk_on_water", 1, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing on water or the charm will have no effect.")), "bad")
        return false
    end
    end
    COND["EOC_HEDGE_WALK_ON_WATER_CONTINUANCE_2"] = function(ctx)
        return (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) == true
    end
    EOC["EOC_HEDGE_WALK_ON_WATER_CONTINUANCE_2"] = function(ctx)
    if (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) then
        if (H.char_effect_dur(H.u(ctx), "effect_hedge_walk_on_water", "") <= 2) then
            H.eoc_add_effect(H.u(ctx), "effect_hedge_walk_on_water", 2, nil, nil, nil)
        else
            H.eoc_add_effect(H.u(ctx), "effect_hedge_walk_on_water", 1, nil, nil, nil)
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you step on solid ground again, the charm fades.")), "neutral")
        do local _eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_HEDGE_WALK_ON_WATER_CONTINUANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_WALK_ON_WATER_CONTINUANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_HEDGE_WALK_ON_WATER_CONTINUANCE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_WALK_ON_WATER_RUNNING_CANCEL"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) == true
    end
    EOC["EOC_HEDGE_WALK_ON_WATER_RUNNING_CANCEL"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) then
        do local _eg = H.safe_id('effect', "effect_hedge_walk_on_water"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_BLESS_STEEL_WEAPON_EFFECT"] = function(ctx)
    do local _g = H.safe_id('json_flag', "BLESSED_WEAPON"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    do local _g = H.safe_id('json_flag', "HEDGE_ENCHANTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    services.messages.add(ctx:expand_text(services.translate("You pass the weapon through the candleflame after rubbing the mixture of salt and herbs on it while slowly reciting the words of the charm, and when you have finished you feel a sense of surety while holding it")), "good")
    return true
    end
    EOC["EOC_HEDGE_BLESS_STEEL_WEAPON"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true } }, { "EOC_HEDGE_BLESS_STEEL_WEAPON_EFFECT" }, {  })
    return true
    end
    COND["EOC_BLESSED_WEAPON_ATTACKS_2"] = function(ctx)
        return (((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) == true
    end
    EOC["EOC_BLESSED_WEAPON_ATTACKS_2"] = function(ctx)
    if (((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "nether_hellbeast", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.eoc_cast_spell(H.u(ctx), "hedge_blessed_weapon_nether_damage", false, { target = H.get_tripoint_var("context", nil, ctx, "nether_hellbeast") })
        H.run_eoc("EOC_HEDGE_BLESSED_WEAPON_LOSE_CHARM", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_HEDGE_BLESSED_WEAPON_LOSE_CHARM", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BLESSED_WEAPON_ATTACKS"] = function(ctx)
        return ((((function() local fg = H.safe_id('json_flag', "BLESSED_WEAPON"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) == true
    end
    EOC["EOC_BLESSED_WEAPON_ATTACKS"] = function(ctx)
    if ((((function() local fg = H.safe_id('json_flag', "BLESSED_WEAPON"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) then
        H.run_eoc("EOC_BLESSED_WEAPON_ATTACKS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_BLESS_STEEL_WEAPON_ATTACKS_CHECK_DAMAGE"] = function(ctx)
        return ((H.char_hp(H.npc(ctx), "ALL", false) < (H.char_hp(H.npc(ctx), "bp_null", true) * 0.9))) == true
    end
    EOC["EOC_HEDGE_BLESS_STEEL_WEAPON_ATTACKS_CHECK_DAMAGE"] = function(ctx)
    if ((H.char_hp(H.npc(ctx), "ALL", false) < (H.char_hp(H.npc(ctx), "bp_null", true) * 0.9))) then
        do local _g = H.safe_id('json_flag', "BLESSED_WEAPON"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
        do local _g = H.safe_id('json_flag', "HEDGE_ENCHANTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
        services.messages.add(ctx:expand_text(services.translate("You no longer feel a sense of purity from your weapon")), "bad")
        return true
    end
    return false
    end
    COND["EOC_HEDGE_BLESSED_WEAPON_LOSE_CHARM"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "HEDGE_ENCHANTED"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_HEDGE_BLESSED_WEAPON_LOSE_CHARM"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "HEDGE_ENCHANTED"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { wielded_only = true } }, { "EOC_HEDGE_BLESS_STEEL_WEAPON_ATTACKS_CHECK_DAMAGE" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "hedge_astral_projection_original_location", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.eoc_add_effect(H.u(ctx), "effect_hedge_astral_projection", -1, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "incorporeal", -1, nil, nil, nil)
    services.messages.add(ctx:expand_text(services.translate("As you meditate, you feel your spirit slipping free from your body.")), "good")
    do local _g = H.safe_id('mutation', "ASTRAL_PROJECTION_APPEARANCE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    H.eoc_spawn_item(H.u(ctx), "body_astral_projection", 1, false, false, nil)
    H.eoc_spawn_item(H.u(ctx), "item_hedge_astral_projection_cord", 1, false, true, nil)
    local _a88 = H.u(ctx)
    local _sn89 = "hedge_astral_projection_return"
    local _sg90 = (_sn89 ~= "") and H.safe_id("spell", _sn89) or nil
    if _a88 and _sg90 then services.spells.set_level(_a88, _sg90, math.floor(0)) end
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_RECURRING"), nil) end end
    return true
    end
    COND["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_RECURRING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_RECURRING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_APPLICATION", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_RECURRING"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_ON_MOVE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_ON_MOVE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("context", nil, ctx, "calorie_amount", services.random.native_int(0, H.round_half_away(8)))
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("calorie_amount") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("calorie_amount") or 0); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("calorie_amount") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("calorie_amount") or 0); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_APPLICATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_APPLICATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("context", nil, ctx, "calorie_amount", services.random.native_int(0, H.round_half_away(8)))
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("calorie_amount") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("calorie_amount") or 0); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("calorie_amount") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("calorie_amount") or 0); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_ASTRAL_PROJECTION_TOO_MUCH_WEARINESS_ENDS"] = function(ctx)
        return (((((("weary_5") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_6") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_7") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_8") == (H.var_str("context", nil, ctx, "effect", ""))))) and (H.char_has_trait(H.u(ctx), "ASTRAL_PROJECTION_APPEARANCE") == 1))) == true
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_TOO_MUCH_WEARINESS_ENDS"] = function(ctx)
    if (((((("weary_5") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_6") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_7") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_8") == (H.var_str("context", nil, ctx, "effect", ""))))) and (H.char_has_trait(H.u(ctx), "ASTRAL_PROJECTION_APPEARANCE") == 1))) then
        H.run_eoc("EOC_HEDGE_ASTRAL_PROJECTION_DEACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_DEACTIVATE_REMOVE_BODY"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_HEDGE_ASTRAL_PROJECTION_DEACTIVATE"] = function(ctx)
    do local g = H.safe_id('item', "item_hedge_astral_projection_cord"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local _eg = H.safe_id('effect', "effect_hedge_astral_projection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "incorporeal"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    H.lose_trait(H.u(ctx), "ASTRAL_PROJECTION_APPEARANCE")
    local _a91 = H.u(ctx)
    local _sn92 = "hedge_astral_projection_return"
    local _sg93 = (_sn92 ~= "") and H.safe_id("spell", _sn92) or nil
    if _a91 and _sg93 then services.spells.set_level(_a91, _sg93, math.floor((-1))) end
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "hedge_astral_projection_original_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 0, nil, { { id = "body_astral_projection" } }, { "EOC_HEDGE_ASTRAL_PROJECTION_DEACTIVATE_REMOVE_BODY" })
    return true
    end
    COND["EOC_HEDGE_PROTECT_THE_MIND_FROM_PSYCHIC_ASSAULT"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_hedge_protect_the_mind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) >= 30))) == true
    end
    EOC["EOC_HEDGE_PROTECT_THE_MIND_FROM_PSYCHIC_ASSAULT"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_hedge_protect_the_mind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) >= 30))) then
        do local _eg = H.safe_id('effect', "effect_hedge_protect_the_mind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("Your mental defenses break under the pain!")), "bad")
        return true
    end
    return false
    end
    COND["EOC_HEDGE_CHICKEN_SACRIFICE_MAKE_RAIN"] = function(ctx)
        return ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) == true
    end
    EOC["EOC_HEDGE_CHICKEN_SACRIFICE_MAKE_RAIN"] = function(ctx)
    if ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) then
        if H.u(ctx) then services.characters.die(H.u(ctx)) end
        H.run_eoc("EOC_HEDGE_CHICKEN_SACRIFICE_MAKE_RAIN_CASTER", ctx, nil, "npc", nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("With a quick cut, you slice the chicken's throat and, as you gut it and fill the corpse with the herbs, honey, and milk, you recite the names of the angels seven times.  Despite the sacrifice, nothing happens.  The temperature must be above freezing to call the rains.")), "bad")
        return false
    end
    end
    EOC["EOC_HEDGE_CHICKEN_SACRIFICE_MAKE_RAIN_CASTER"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    services.messages.add(ctx:expand_text(services.translate("With a quick cut, you slice the chicken's throat and, as you gut it and fill the corpse with the herbs, honey, and milk, you recite the names of the angels seven times.")), "good")
    H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 3)
    H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_lower_bound", 120)
    H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_upper_bound", 480)
    H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_rains", 21600, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", services.random.native_float(1800, 10800), nil, nil, nil)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_INITIATE"), nil) end end
    return true
    end
    COND["EOC_HEDGE_PREVENT_WILD_ANIMAL_ATTACKS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_HEDGE_PREVENT_WILD_ANIMAL_ATTACKS"] = function(ctx)
    if (ctx:has_speaker()) then
        H.set_char_val_extra(H.u(ctx), "morale", 50, "-=")
        H.set_char_val_extra(H.u(ctx), "anger", 50, "-=")
        H.eoc_add_effect(H.u(ctx), "effect_hedge_prevent_wild_animal_attacks", services.random.native_float(300, 900), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_PREVENT_WILD_ANIMAL_ATTACKS_EXPLOIT_PREVENTER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_prevent_wild_animal_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_PREVENT_WILD_ANIMAL_ATTACKS_EXPLOIT_PREVENTER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_prevent_wild_animal_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_char_val_extra(H.u(ctx), "anger", 100, "+=")
        do local _eg = H.safe_id('effect', "effect_hedge_prevent_wild_animal_attacks"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_WEARING_RAZIEL_PROTECTIVE_AMULET"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_hedge_magic_kamea_of_protection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_HEDGE_WEARING_RAZIEL_PROTECTIVE_AMULET"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_hedge_magic_kamea_of_protection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if services.random.native_probability((1), (100)) then
            H.consume_item(H.u(ctx), "item_hedge_raziel_amulet_protection", 1, 0)
            H.eoc_spawn_item(H.u(ctx), "item_hedge_raziel_amulet_protection_done", 1, false, true, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_SCARE_SHABRIRI"] = function(ctx)
        return ((H.u(ctx) ~= nil and ((H.safe_id('species', "SHABRIRI") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SHABRIRI")).value == true)))) == true
    end
    EOC["EOC_HEDGE_SCARE_SHABRIRI"] = function(ctx)
    if ((H.u(ctx) ~= nil and ((H.safe_id('species', "SHABRIRI") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SHABRIRI")).value == true)))) then
        H.set_char_val_extra(H.u(ctx), "morale", 200, "-=")
        H.set_char_val_extra(H.u(ctx), "anger", 200, "-=")
        return true
    end
    return false
    end
    EOC["hedge_see_fae_necklace"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "hedge_see_fae_necklace", 1, true, false, nil)
    return true
    end
    COND["EOC_LILIN_RUACH_DRAIN"] = function(ctx)
        return (((not ((H.char_has_trait(H.npc(ctx), "TURN_INTO_OWL_TRAITS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "LILIN_WAR_OWL_FORM_TRAITS") == 1))))) == true
    end
    EOC["EOC_LILIN_RUACH_DRAIN"] = function(ctx)
    if (((not ((H.char_has_trait(H.npc(ctx), "TURN_INTO_OWL_TRAITS") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "LILIN_WAR_OWL_FORM_TRAITS") == 1))))) then
        H.run_eoc("EOC_LILIN_RUACH_DRAIN_REAL", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You cannot absorb ruach in this form.")), "bad")
        return false
    end
    end
    COND["EOC_LILIN_RUACH_DRAIN_REAL"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_LILIN_RUACH_DRAIN_REAL"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        if ((H.char_has_trait(H.npc(ctx), "LILIN_GAIN_EXTRA_RUACH_FROM_SLEEPY_PEOPLE") == 1) and ((function() local eg = H.safe_id('effect', "asleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_float(200, 300) * 1.5); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        else
            do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(200, 300); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        services.messages.add(ctx:expand_text(services.translate("You feel a rush of warmth as you absorb the ruach.")), "good")
        H.set_var("actor", H.u(ctx), ctx, "lilin_ruach_drained_recently", 1)
        H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
        if (H.char_has_trait(H.npc(ctx), "LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN") == 1) then
            H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_GAIN_SUSTENANCE", ctx, nil, nil, nil)
        end
        return true
    else
        if (H.char_has_trait(H.npc(ctx), "LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN") == 1) then
            H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_GAIN_SUSTENANCE", ctx, nil, nil, nil)
        end
        if ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and ((H.u(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HUMAN")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true))) or H.test_eoc("EOC_CONDITIONS_LILIN_FANTASY_SPECIES_RUACH_DRAIN", ctx))) then
            if ((H.char_has_trait(H.npc(ctx), "LILIN_GAIN_EXTRA_RUACH_FROM_SLEEPY_PEOPLE") == 1) and ((function() local eg = H.safe_id('effect', "asleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
                do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_float(200, 300) * 1.5); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            else
                do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(200, 300); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            end
            services.messages.add(ctx:expand_text(services.translate("You feel a rush of warmth as you absorb the ruach.")), "good")
            H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
        else
            if ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true)))) then
                do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 400); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                services.messages.add(ctx:expand_text(services.translate("You feel a rush of warmth as you absorb the ruach, though your skin breaks out in goosebumps afterward.")), "good")
                H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
            else
                if (H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true))) then
                    H.set_var("actor", H.u(ctx), ctx, "ruach_random_nether_amount", services.random.native_float((-800), 800))
                    if (H.var_num(H.u(ctx), "ruach_random_nether_amount") > 0) then
                        services.messages.add(ctx:expand_text(services.translate("You feel a moment of white heat as you absorb the ruach.")), "good")
                    else
                        services.messages.add(ctx:expand_text(services.translate("You attempt to absorb the being's ruach but encounter only a yawning void that drains some of your own ruach back to it!")), "bad")
                    end
                    do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "ruach_random_nether_amount"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                    H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
                else
                    if ((H.u(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "UNDINE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true)))) then
                        do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(20, 60); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                        services.messages.add(ctx:expand_text(services.translate("You feel a moment of warmth as you absorb the ruach.")), "good")
                        H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
                    else
                        if ((H.u(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CYBORG")).value == true))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MAMMAL")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "BIRD")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "REPTILE")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FISH")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "KRAKEN")).value == true))) or H.test_eoc("EOC_CONDITIONS_LILIN_DINOMOD_RUACH_DRAIN", ctx)) then
                            do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(5, 15); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                            services.messages.add(ctx:expand_text(services.translate("You feel a brief tingle as you absorb the animal's ruach.  Weak, but better than nothing.")), "good")
                            H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
                        else
                            if ((H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CENTIPEDE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SPIDER")).value == true)))) then
                                do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(2, 7); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                                services.messages.add(ctx:expand_text(services.translate("You feel a slight prickling as you absorb the insect's ruach.  Barely worth bothering with.")), "good")
                                H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS", ctx, nil, nil, nil)
                            else
                                services.messages.add(ctx:expand_text(services.translate("You try to absorb the <u_name>'s ruach but get only fragments.  Not enough to for a mouthful.")), "bad")
                            end
                        end
                    end
                end
            end
        end
        return false
    end
    end
    EOC["EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_lilin_ruach_drain_side_effects", (function() local a, b = math.floor(259200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") + 1), nil)
    if ((H.u(ctx) ~= nil) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 2)) then
        if ((services.random.native_int(0, H.round_half_away(2)) == 2) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 1)) then
            H.npc_mood_write(H.npc(ctx), "fear", 1, "+=")
        end
        if ((services.random.native_int(0, H.round_half_away(2)) == 2) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 3)) then
            H.npc_mood_write(H.npc(ctx), "trust", 1, "-=")
        end
        if ((services.random.native_int(0, H.round_half_away(2)) == 2) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 5)) then
            H.npc_mood_write(H.npc(ctx), "value", 1, "-=")
        end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "head") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_l") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_r") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "torso") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_r") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_l") }) end end
        if ((services.random.native_int(0, H.round_half_away(1)) == 1) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 2)) then
            H.set_char_val_extra(H.u(ctx), "sleepiness", (2 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 1.5)), "+=")
        end
        if (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 4) then
            H.eoc_add_effect(H.u(ctx), "staggered_character", math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") - 3) * 2), 0), nil, 1, nil)
        end
    else
        if (((H.creature_snap(H.u(ctx)) or {}).kind == 'monster') and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 2)) then
            H.set_char_val_extra(H.u(ctx), "morale", (5 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 3)), "-=")
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 1.5) - 3), 0), nil) end end
        end
        if (((H.creature_snap(H.u(ctx)) or {}).kind == 'monster') and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 4)) then
            H.eoc_add_effect(H.u(ctx), "staggered", math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") - 3) * 2), 0), nil, 1, nil)
        end
    end
    return true
    end
    COND["EOC_LILIN_RUACH_DRAIN_SIDE_GAIN_SUSTENANCE"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_LILIN_RUACH_DRAIN_SIDE_GAIN_SUSTENANCE"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.eoc_add_effect(H.npc(ctx), "effect_xe_hidden_hunger", (function() local a, b = math.floor(5400), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
            do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(200, 300) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(200, 300); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        end
        if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
            H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float(10, 25), "-=")
        end
        do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        if ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and ((H.u(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HUMAN")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true))) or H.test_eoc("EOC_CONDITIONS_LILIN_FANTASY_SPECIES_RUACH_DRAIN", ctx))) then
            H.eoc_add_effect(H.npc(ctx), "effect_xe_hidden_hunger", (function() local a, b = math.floor(5400), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
                do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(200, 300) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(200, 300); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            end
            if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
                H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float(10, 25), "-=")
            end
            do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(15, 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        else
            if ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true)))) then
                H.eoc_add_effect(H.npc(ctx), "effect_xe_hidden_hunger", (function() local a, b = math.floor(5400), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
                if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
                    do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(0, 250) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(0, 250); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                end
                if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
                    H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float(0, 15), "-=")
                end
                do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(0, 10); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(0, 10); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(0, 10); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            else
                if (H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true))) then
                    if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
                        do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float((-500), 500) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float((-500), 500); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                    end
                    if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
                        H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float((-25), 25), "-=")
                    end
                    do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float((-30), 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                    do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float((-30), 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                    do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float((-30), 30); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                else
                    if ((H.u(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "UNDINE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true)))) then
                        if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
                            do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(65, 125) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(65, 125); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                        end
                        if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
                            H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float(2, 6), "-=")
                        end
                        do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 8); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                        do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 8); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                        do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 8); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                    else
                        if ((H.u(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CYBORG")).value == true))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MAMMAL")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "BIRD")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "REPTILE")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FISH")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "KRAKEN")).value == true))) or H.test_eoc("EOC_CONDITIONS_LILIN_DINOMOD_RUACH_DRAIN", ctx)) then
                            if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).stored_kcal or 0) <= 118000) then
                                do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(20, 40) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(20, 40); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                            end
                            if ((((H.char_snap(H.npc(ctx)) or {}).needs or {}).thirst or 0) >= (-60)) then
                                H.set_char_val_extra(H.npc(ctx), "thirst", services.random.native_float(1, 3), "-=")
                            end
                            do local _a, _v = H.npc(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 4); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                            do local _a, _v = H.npc(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 4); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                            do local _a, _v = H.npc(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(1, 4); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                        end
                    end
                end
            end
        end
        return false
    end
    end
    COND["EOC_LILIN_BLINDING_TARGET"] = function(ctx)
        return ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.var_num(H.npc(ctx), "lilit_is_in_civilization") == 0)) or (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))))) == true
    end
    EOC["EOC_LILIN_BLINDING_TARGET"] = function(ctx)
    if ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.var_num(H.npc(ctx), "lilit_is_in_civilization") == 0)) or (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))))) then
        H.eoc_add_effect(H.u(ctx), "blind", services.random.native_float((((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 8) * (H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.03)) * (H.char_has_trait(H.npc(ctx), "THRESH_LILIN") + 1)), (((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 24) * (H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.075)) * (H.char_has_trait(H.npc(ctx), "THRESH_LILIN") + 1))), nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("<u_name>'s eyes film over with darkness.")), "good")
        return true
    else
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.var_num(H.npc(ctx), "lilit_is_in_civilization") == 1)) then
            services.messages.add(ctx:expand_text(services.translate("You cannot call up the darkness outdoors in a city.")), "bad")
        end
        return false
    end
    end
    COND["EOC_LILIN_MESMERIZE_TARGET_2"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_LILIN_MESMERIZE_TARGET_2"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        if (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "WARDING_SYMBOL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "WARDING_SYMBOL")).value == true))) then
            H.eoc_add_effect(H.u(ctx), "stunned", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_lilin_mesmerize_tracker", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You beguile <u_name> and they stand in a daze.")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("Your target's protective charm means the beguilement fails to take effect!")), "bad")
        end
        return true
    else
        if ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CYBORG")).value == true)))) then
            H.eoc_add_effect(H.u(ctx), "stunned", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_lilin_mesmerize_tracker", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You beguile <u_name> and they stand in a daze.")), "good")
        else
            if ((H.u(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "BIRD")).value == true)))) then
                H.set_var("actor", H.u(ctx), ctx, "lilin_mesmerize_duration", (H.var_num(H.u(ctx), "lilin_mesmerize_duration") * 2))
                H.eoc_add_effect(H.u(ctx), "stunned", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
                H.eoc_add_effect(H.u(ctx), "effect_lilin_mesmerize_tracker", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
                services.messages.add(ctx:expand_text(services.translate("You beguile <u_name> and they stand in a daze.")), "good")
            else
                if ((H.u(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "UNDINE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true)))) then
                    H.set_var("actor", H.u(ctx), ctx, "lilin_mesmerize_duration", (H.var_num(H.u(ctx), "lilin_mesmerize_duration") * 0.75))
                    H.eoc_add_effect(H.u(ctx), "stunned", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
                    H.eoc_add_effect(H.u(ctx), "effect_lilin_mesmerize_tracker", H.var_num(H.u(ctx), "lilin_mesmerize_duration"), nil, nil, nil)
                    services.messages.add(ctx:expand_text(services.translate("You beguile <u_name> and they stand in a daze.")), "good")
                end
            end
        end
        return false
    end
    end
    EOC["EOC_LILIN_MESMERIZE_TARGET"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "lilin_mesmerize_duration", services.random.native_float(((48 + (H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 13)) + (H.char_has_trait(H.npc(ctx), "BEAUTIFUL3") * services.random.native_float(60, 180))), ((96 + (H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 27)) + (H.char_has_trait(H.npc(ctx), "BEAUTIFUL3") * services.random.native_float(120, 360)))))
    H.run_eoc("EOC_LILIN_MESMERIZE_TARGET_2", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_LILIN_MESMERISM_REMOVAL_CHARACTER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_LILIN_MESMERISM_REMOVAL_CHARACTER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_LILIN_MESMERISM_REMOVAL_MONSTER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_LILIN_MESMERISM_REMOVAL_MONSTER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_lilin_mesmerize_tracker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_LILIN_AOE_DAZE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "lilin_aoe_daze_spell_real", false, nil)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(20), "alert", ctx:expand_text(services.translate("You let out a piercing cry!")), false) end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(35), "alert", ctx:expand_text(services.translate("You let out a piercing cry!")), false) end end
    services.messages.add(ctx:expand_text(services.translate("You let out a piercing cry!")), "neutral")
    return true
    end
    COND["EOC_LILIN_AOE_LINE_DISEASE"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_LILIN_AOE_LINE_DISEASE"] = function(ctx)
    if (ctx:has_speaker()) then
        services.messages.add(ctx:expand_text(services.translate("You summon a wind filled with pestilence.")), "neutral")
        H.eoc_add_effect(H.u(ctx), "effect_lilin_supernatural_disease", (function() local a, b = math.floor((1 + ((((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.09) * ((H.char_has_trait(H.npc(ctx), "INFIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "DISIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "LILIN_DISEASE_DAMAGE_STRIKES") * 0.35) + 1)))), math.floor((15 + ((((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.24) * ((H.char_has_trait(H.npc(ctx), "INFIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "DISIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "LILIN_DISEASE_DAMAGE_STRIKES") * 0.35) + 1)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_LILIN_DISEASE_ENHANCEMENT_DAMAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You infuse your ruach into the plague-infected <u_name>.")), "neutral")
    H.eoc_add_effect(H.u(ctx), "effect_lilin_supernatural_disease_focused", (function() local a, b = math.floor((1 + ((((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.03) * ((H.char_has_trait(H.npc(ctx), "INFIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "DISIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "LILIN_DISEASE_DAMAGE_STRIKES") * 0.35) + 1)))), math.floor((15 + ((((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") * 0.09) * ((H.char_has_trait(H.npc(ctx), "INFIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "DISIMMUNE") * 0.25) + 1)) * ((H.char_has_trait(H.npc(ctx), "LILIN_DISEASE_DAMAGE_STRIKES") * 0.35) + 1)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    if (H.u(ctx) ~= nil) then
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "head") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "arm_l") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "arm_r") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "torso") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "leg_r") }) end end
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(4, 8) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), { body_part = H.safe_id('body_part', "leg_l") }) end end
    else
        do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (services.random.native_float(10, 35) * math.max((H.char_vitamin(H.npc(ctx), "lilin_ruach_vitamin") / 3000), 1)), nil) end end
    end
    return true
    end
    EOC["EOC_LILIN_AVOID_SLEEP"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "sleepiness", services.random.native_float(200, 350), "-=")
    if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) < 0) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", 0, "=")
    end
    H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 0, "=")
    services.messages.add(ctx:expand_text(services.translate("As a cool breeze touches your skin, you feel much more awake.")), "good")
    return true
    end
    COND["EOC_LILIN_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") ~= 1)) == true
    end
    EOC["EOC_LILIN_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") ~= 1)) then
        services.messages.add(ctx:expand_text(services.translate("A thick fog begins to rise.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 1)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_fog", 21600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((450 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 10)) + ((((H.moon_phase() > 4)) and ((H.moon_phase() - 4)) or (((H.moon_phase() - 4) * (-1)))) * 360))), math.floor(((1800 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 3)) + ((((H.moon_phase() > 4)) and ((H.moon_phase() - 4)) or (((H.moon_phase() - 4) * (-1)))) * 600))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LILIN_CHANGE_WEATHER_DENSE_FOG_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You release your command over the fog and it begins to disperse.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        return false
    end
    end
    COND["EOC_LILIN_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") == 1)) == true
    end
    EOC["EOC_LILIN_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") == 1)) then
        services.messages.add(ctx:expand_text(services.translate("The thick fog begins to disperse.")), "neutral")
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        return true
    end
    return false
    end
    COND["EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_ON"] = function(ctx)
        return ((((("effect_lilin_speed_boost") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "LILIN_UNCANNY_DODGE_WHILE_REAPING") == 1))) == true
    end
    EOC["EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_ON"] = function(ctx)
    if ((((("effect_lilin_speed_boost") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "LILIN_UNCANNY_DODGE_WHILE_REAPING") == 1))) then
        do local _g = H.safe_id('mutation', "GENERIC_UNCANNY_DODGE_TRAIT"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_OFF"] = function(ctx)
        return ((((("effect_lilin_speed_boost") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "LILIN_UNCANNY_DODGE_WHILE_REAPING") == 1))) == true
    end
    EOC["EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_OFF"] = function(ctx)
    if ((((("effect_lilin_speed_boost") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "LILIN_UNCANNY_DODGE_WHILE_REAPING") == 1))) then
        H.lose_trait(H.u(ctx), "GENERIC_UNCANNY_DODGE_TRAIT")
        return true
    end
    return false
    end
    COND["EOC_LILIN_INSTANT_HEAL"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))) and (not ((H.moon_phase() == 0))) and (((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear")))) == true
    end
    EOC["EOC_LILIN_INSTANT_HEAL"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))) and (not ((H.moon_phase() == 0))) and (((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear")))) then
        do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1200 * H._jm_lilin_has_ruach_efficiency(ctx)); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("Your wounded flesh knits together in moments.")), "neutral")
        if (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) then
            H.set_char_hp(H.u(ctx), "torso", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        if (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)) then
            H.set_char_hp(H.u(ctx), "head", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) then
            H.set_char_hp(H.u(ctx), "arm_l", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        if (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) then
            H.set_char_hp(H.u(ctx), "arm_r", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) then
            H.set_char_hp(H.u(ctx), "leg_l", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) then
            H.set_char_hp(H.u(ctx), "leg_r", (25 * math.min((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 4000), 1)), "+=")
        end
        return true
    else
        if (H.moon_phase() == 0) then
            services.messages.add(ctx:expand_text(services.translate("You cannot heal yourself during the new moon!")), "bad")
        else
            if ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or (not services.gameplay.environment.is_night())) then
                services.messages.add(ctx:expand_text(services.translate("You must be outside in direct moonlight to heal yourself!")), "bad")
            else
                if (not ((((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear")))) then
                    services.messages.add(ctx:expand_text(services.translate("The moon is obscured by clouds and you cannot draw on its light to heal yourself!")), "bad")
                else
                    services.messages.add(ctx:expand_text(services.translate("[Debug] For some unknown reason you cannot heal yourself.")), "bad")
                end
            end
        end
        return false
    end
    end
    EOC["EOC_XE_NETHER_SORCERY_SUMMON_KRECK_PACK"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Call the hounds")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "summoning_loc") and 1 or 0)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_xe_kreck_summoned") or H.safe_id('monster_group', "mon_xe_kreck_summoned"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(((H.char_spell_level(H.u(ctx), "xe_nether_sorcery_summon_kreck_pack") * 0.6) + 3)), max_radius = math.floor(3), lifespan = services.time.duration_from_turns(math.floor(((H.char_spell_level(H.u(ctx), "xe_nether_sorcery_summon_kreck_pack") * 680) + 6800))) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("With a baying sound, otherworldly shapes appear!")), 'warning') end
        end end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled.")), "neutral")
    end
    if (((((services.random.native_int(0, H.round_half_away(H.char_skill(H.u(ctx), "deduction"))) + services.random.native_int(0, H.round_half_away(H.char_spell_level(H.u(ctx), "xe_nether_sorcery_summon_kreck_pack")))) + services.random.native_int(0, H.round_half_away(8))) + services.random.native_int(0, H.round_half_away(8))) + (H.creature_effect_intensity(H.u(ctx), "effect_xe_nether_resonance_consequences") / 500)) > 11) then
        H.eoc_cast_spell(H.u(ctx), "xe_nether_sorcery_summoning_successful_control", false, { target = H.get_tripoint_var("context", nil, ctx, "summoning_loc") })
    else
        services.messages.add(ctx:expand_text(services.translate("The things you called up resist your attempt to control them!")), "bad")
    end
    return true
    end
    COND["EOC_XE_GETTING_HIT_WHILE_USING_NETHER_SORCERY_WIND_DODGE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_xe_nether_sorcery_wind_dodge_shell"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_XE_GETTING_HIT_WHILE_USING_NETHER_SORCERY_WIND_DODGE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_xe_nether_sorcery_wind_dodge_shell"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if services.random.native_probability((1), (4)) then
            do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_flying_polyp") or H.safe_id('monster_group', "mon_flying_polyp"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), max_radius = math.floor(3), lifespan = { minimum = services.time.duration_from_turns(math.floor(2592000)), maximum = services.time.duration_from_turns(math.floor(5184000)) } }); 
                if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("You hear a tuneless piping sound!")), 'warning') end
            end end
        end
        return true
    end
    return false
    end
    COND["EOC_DREAMER_ARTIFACT_SPAWN"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "dreamer_vit") >= 600)) == true
    end
    EOC["EOC_DREAMER_ARTIFACT_SPAWN"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "dreamer_vit") >= 600)) then
        H.eoc_spawn_item(H.u(ctx), "dreamer_artifact", 1, true, false, nil)
        do local _a, _v = H.u(ctx), "dreamer_vit"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 600; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("You pull your power into this world, and something outside of it places an object in your hand.")), "info")
        return true
    else
        H.run_eoc("EOC_DREAMER_ARTIFACT_FAIL_MESSAGE", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_DREAMER_ARTIFACT_FAIL_MESSAGE"] = function(ctx)
    do
        local _sw94 = H.char_vitamin(H.u(ctx), "dreamer_vit")
        if _sw94 == 0 then
            services.messages.add(ctx:expand_text(services.translate("Your impatience is apparently a defining feature.  You're going to need a lot more time connecting with the universe to make this happen.")), "bad")
        elseif _sw94 == 150 then
            services.messages.add(ctx:expand_text(services.translate("You try to connect the item with another dimension, but everything goes wrong from the very beginning.  You feel you need much more patience to finish this.")), "bad")
        elseif _sw94 == 300 then
            services.messages.add(ctx:expand_text(services.translate("You try to connect the item with another dimension, but something interrupts you in the middle of your attempt.  You need just a bit more time to make this work.")), "bad")
        elseif _sw94 == 450 then
            services.messages.add(ctx:expand_text(services.translate("You try to connect the item with another dimension, but in the end it fails.  It was close though, so you think you need to try it again tomorrow.")), "bad")
        end
    end
    return true
    end
    EOC["EOC_EATER_DROSS_FUN_1"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_ate_dross"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(1), math.floor(200), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
    return true
    end
    EOC["EOC_EATER_DROSS_FUN_2"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_ate_dross"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(200), { duration = services.time.duration_from_turns(math.floor(72000)), decay_start = services.time.duration_from_turns(math.floor(36000)) }) end end
    return true
    end
    EOC["EOC_EATER_DROSS_FUN_3"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_ate_dross"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(100), math.floor(200), { duration = services.time.duration_from_turns(math.floor(432000)), decay_start = services.time.duration_from_turns(math.floor(216000)) }) end end
    return true
    end
    COND["EOC_GENERATE_ACCELERATED_TIME_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_GENERATE_ACCELERATED_TIME_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("<color_light_gray>Grey</color> fields of time start seeping from your body.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_xedra_dreamer_generate_accelerated_time", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "xedra_dreamer_generate_accelerated_time") + 1) * 750))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_GENERATE_ACCELERATED_TIME_CONTINUE"), nil) end end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("The world regains color as it speeds up.")), "neutral")
        return false
    end
    end
    COND["EOC_GENERATE_ACCELERATED_TIME_CONTINUE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_mana(H.u(ctx), "current") >= 200))) == true
    end
    EOC["EOC_GENERATE_ACCELERATED_TIME_CONTINUE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_mana(H.u(ctx), "current") >= 200))) then
        local _a95 = H.u(ctx)
        if _a95 then services.spells.set_mana_raw(_a95, math.floor((H.char_mana(_a95, "current")) - (200))) end
        services.messages.add(ctx:expand_text(services.translate("The grayscale starts to recede from your vision before it quickly reverts.")), "good")
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "xedra_dreamer_generate_accelerated_time") + 1) * 750))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_GENERATE_ACCELERATED_TIME_CONTINUE"), nil) end end
        do local _a, _sp = H.u(ctx), "xedra_dreamer_generate_accelerated_time"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = ((((function() local _g = H.safe_id('spell', "xedra_dreamer_generate_accelerated_time"); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), "xedra_dreamer_generate_accelerated_time") + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', "xedra_dreamer_generate_accelerated_time"); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), "xedra_dreamer_generate_accelerated_time")))) or 0 end)())) / H._jm_spell_train_factor(ctx, 200)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_xedra_dreamer_generate_accelerated_time"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("The world regains color as it speeds up.")), "neutral")
        return false
    end
    end
end
