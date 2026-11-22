local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_03"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_03_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_03_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_03_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_3", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_3", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_04"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 3)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_04"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 3)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_04"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_04"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_4>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_4>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_04" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_04"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_04"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_04" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_04"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_04"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_4"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_04"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_04_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_04_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_04_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_4", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_4", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_05"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 4)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_05"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 4)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_05"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_05"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_5>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_5>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_05" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_05"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_05"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_05" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_05"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_05"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_5"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_05"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_05_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_05_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_05_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_5", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_5", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_06"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 5)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_06"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 5)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_06"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_06"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_6>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_6>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_06" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_06"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_06"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_06" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_06"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_06"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_6"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_06"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_06_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_06_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_06_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_6", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_6", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_07"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 6)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_07"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 6)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_07"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_07"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_7>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_7>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_07" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_07"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_07"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_07" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_07"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_07"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_7"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_07"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_07_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_07_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_07_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_7", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_7", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_08"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 7)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_08"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 7)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_08"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_08"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_8>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_8>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_08" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_08"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_08"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_08" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_08"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_08"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_8"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_08"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_08_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_08_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_08_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_8", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_8", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_09"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 8)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_09"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 8)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_09"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_09"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_9>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_9>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_09" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_09"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_09"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_09" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_09"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_09"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_9"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_09"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_09_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_09_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_09_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_9", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_9", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_10"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 9)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_10"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 9)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_10"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_10"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_10>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_10>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_10" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_10"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_10"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_10" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_10"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_10"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_10"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_10"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_10_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_10_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_10_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_10", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_10", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_01"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_1>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_dilated_gateway_SELECT_01" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_02"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_2>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_dilated_gateway_SELECT_02" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_03"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_3>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_TELEPORT_dilated_gateway_SELECT_03" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_04"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_04"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_4>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_TELEPORT_dilated_gateway_SELECT_04" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_05"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_05"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_5>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_TELEPORT_dilated_gateway_SELECT_05" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_06"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_06"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_6>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_TELEPORT_dilated_gateway_SELECT_06" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_07"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_07"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_7>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_TELEPORT_dilated_gateway_SELECT_07" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_08"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_08"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_8>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "EOC_TELEPORT_dilated_gateway_SELECT_08" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_09"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_09"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_9>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "EOC_TELEPORT_dilated_gateway_SELECT_09" end end
        do local _en = (E.cond["EOC_TELEPORT_dilated_gateway_SELECT_10"] == nil or E.cond["EOC_TELEPORT_dilated_gateway_SELECT_10"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Dilated Gateway: <u_val:gateway_destination_name_10>")), description = ctx:expand_text(services.translate("Teleport target to a destination.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_TELEPORT_dilated_gateway_SELECT_10" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_DILATED_GATEWAY_ACTIVATE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "teleport_dilated_gateway_teleport_others", false, { message = ctx:expand_text(services.translate("")) })
    H.eoc_cast_spell(H.u(ctx), "teleport_dilated_gateway_teleport_self", false, { message = ctx:expand_text(services.translate("")) })
    return true
    end
    EOC["EOC_TELEPORT_EXTERNAL_TELEPORT"] = function(ctx)
    do local _p = H.get_tripoint_var("actor", H.npc(ctx), ctx, "dilated_gateway_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force_safe = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force_safe = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force_safe = true }) end end end
    services.messages.add(ctx:expand_text(services.translate("<u_name> vanishes!")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_01"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_01"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_1", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_02"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_02"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_2", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_03"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_03"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_3", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_04"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_04"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_4", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_05"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_05"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_5", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_06"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_06"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_6", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_07"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_07"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_7", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_08"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_08"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_8", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_09"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_09"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_9", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_dilated_gateway_SELECT_10"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_dilated_gateway_SELECT_10"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) then
        H.copy_var("actor", H.npc(ctx), "gateway_destination_10", "actor", H.u(ctx), "dilated_gateway_location", ctx)
        H.run_eoc("EOC_DILATED_GATEWAY_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_NO_HELD_ITEM_PRE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Try as you might, you cannot teleport nothing.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_PRE_CHECK"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return ((H.creature_volume(H.npc(ctx)) > 0)) end } }, { "EOC_TELEPORT_RELOCATION_SELECTOR" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_NO_HELD_ITEM_PRE" })
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_01"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_1>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_RELOCATION_SELECT_01" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_02"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_2>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_RELOCATION_SELECT_02" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_03"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_3>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_TELEPORT_RELOCATION_SELECT_03" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_04"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_04"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_4>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_TELEPORT_RELOCATION_SELECT_04" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_05"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_05"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_5>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_TELEPORT_RELOCATION_SELECT_05" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_06"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_06"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_6>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_TELEPORT_RELOCATION_SELECT_06" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_07"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_07"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_7>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_TELEPORT_RELOCATION_SELECT_07" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_08"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_08"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_8>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "EOC_TELEPORT_RELOCATION_SELECT_08" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_09"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_09"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_9>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "EOC_TELEPORT_RELOCATION_SELECT_09" end end
        do local _en = (E.cond["EOC_TELEPORT_RELOCATION_SELECT_10"] == nil or E.cond["EOC_TELEPORT_RELOCATION_SELECT_10"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Item Portal: <u_val:gateway_destination_name_10>")), description = ctx:expand_text(services.translate("Teleport items to a destination.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_TELEPORT_RELOCATION_SELECT_10" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_01"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_1"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_01"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_01"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_01"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_01" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_01" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_02"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_2"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_02"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_02"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_02"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_02" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_02" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_03"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_3"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_03"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_03"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_03"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_03" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_03" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_04"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_4"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_04"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_04"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_04"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_4") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_04" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_04" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_05"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_5"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_05"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
end
