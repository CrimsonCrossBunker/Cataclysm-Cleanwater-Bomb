local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
COND["EOC_activate_robofac_lens_helmet"] = function(ctx)
    return ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "DEAF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DEAF")).value == true))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_activate_robofac_lens_helmet", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_activate_robofac_lens_helmet"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_activate_robofac_lens_helmet_pat"] = function(ctx)
    return ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "DEAF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DEAF")).value == true))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_activate_robofac_lens_helmet_pat", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_activate_robofac_lens_helmet_pat"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_activate_robofac_arm"] = function(ctx)
    return (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm")) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_activate_robofac_arm", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_activate_robofac_arm"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_activate_robofac_back"] = function(ctx)
    return ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmback") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_ARM") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_ARM")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_LEG") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_LEG")).value == true))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_activate_robofac_back", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_activate_robofac_back"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_activate_robofac_leg"] = function(ctx)
    return (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg")) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_activate_robofac_leg", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_activate_robofac_leg"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_BALTHAZAR_RADIO_FALSE"] = function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_FIND_BALTHAZAR_BUNKER")) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_BALTHAZAR_RADIO_FALSE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_BALTHAZAR_RADIO_FALSE"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_BALTHAZAR_RADIO_TRUE"] = function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_FIND_BALTHAZAR_BUNKER")))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_BALTHAZAR_RADIO_TRUE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_BALTHAZAR_RADIO_TRUE"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_INTEREST_SLIGHT"] = function(ctx)
    return ((not (services.random.native_probability(1, (3))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_INTEREST_SLIGHT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_INTEREST_SLIGHT"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_INTEREST_INTENSE"] = function(ctx)
    return ((not (services.random.native_probability(1, (100))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_INTEREST_INTENSE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_INTEREST_INTENSE"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_SETUP"] = function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function_set", ""))))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_SETUP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_SETUP"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_MORALE"] = function(ctx)
    return (((("morale") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_MORALE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_MORALE"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_FOCUS"] = function(ctx)
    return (((("focus") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_FOCUS", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_FOCUS"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_PAIN"] = function(ctx)
    return (((("pain") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_PAIN", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_PAIN"](H.ctx_new(u, npc, vars)) == true
end)
COND["EOC_MIGO_BIO_TECH_SLEEPINESS"] = function(ctx)
    return (((("sleepiness") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_MIGO_BIO_TECH_SLEEPINESS", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_MIGO_BIO_TECH_SLEEPINESS"](H.ctx_new(u, npc, vars)) == true
end)
EOC["EOC_activate_rm13_sans_rebreather"] = function(ctx)
    do local _g = H.safe_id('item', "rm13_armor_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
    services.messages.add(ctx:expand_text(services.translate("You activate your RM13 combat armor.\nCyclonic air scrubber:          ONLINE.\nRebreather system:             <color_light_red>OFFLINE</color>.\nAcoustic dampening system:      ONLINE.\nDimensional dampening system:   ONLINE.\nThermal regulation system:      ONLINE.\nVision enhancement system:      ONLINE.\nElectro-reactive armor system:  ONLINE.\nAll systems normal.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_activate_rm13_sans_rebreather", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_rm13_sans_rebreather"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_activate_robofac_lens_helmet"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "DEAF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DEAF")).value == true))) then
        do local _g = H.safe_id('item', "robofac_lens_helmet_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        services.messages.add(ctx:expand_text(services.translate("You flick on your LENS system.\n\"HELLO CEP#03\".\nVisual systems:   ONLINE.\nRadio systems:    ONLINE.\nTargeting HUD:    ONLINE.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR: NO LENS SYSTEM DETECTED")), "neutral")
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_activate_robofac_lens_helmet", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_robofac_lens_helmet"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_activate_robofac_lens_helmet_pat"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "DEAF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DEAF")).value == true))) then
        do local _g = H.safe_id('item', "robofac_lens_helmet_pat_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        services.messages.add(ctx:expand_text(services.translate("You flick on your LENS system.\n\"HELLO CEP#03\".\nVisual systems:   ONLINE.\nRadio systems:    ONLINE.\nPat's Frequency:  ONLINE.\nTargeting HUD:    ONLINE.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR: NO LENS SYSTEM DETECTED")), "neutral")
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_activate_robofac_lens_helmet_pat", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_robofac_lens_helmet_pat"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_activate_robofac_arm"] = function(ctx)
    if (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm")) then
        do local _g = H.safe_id('item', "integrated_bio_robofac_xmarm_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        services.messages.add(ctx:expand_text(services.translate("You activate your Hub 01 XM-ARM system.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR: NO XM-ARM INTERFACE DETECTED")), "neutral")
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_activate_robofac_arm", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_robofac_arm"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_activate_robofac_back"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_robofac_xmback") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_ARM") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_ARM")).value == true) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_LEG") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_LEG")).value == true))) then
        do local _g = H.safe_id('item', "integrated_bio_robofac_xmback_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        services.messages.add(ctx:expand_text(services.translate("You activate your Hub 01 XM-BACK system.")), "neutral")
        return true
    else
        if (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) then
            services.messages.add(ctx:expand_text(services.translate("ERROR: NO XM-BACK INTERFACE DETECTED")), "neutral")
        end
        if (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_ARM") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_ARM")).value == true))) then
            services.messages.add(ctx:expand_text(services.translate("ERROR: NO ARM EXOSKELETON EQUIPPED")), "neutral")
        end
        if (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "ROBOFAC_LEG") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ROBOFAC_LEG")).value == true))) then
            services.messages.add(ctx:expand_text(services.translate("ERROR: NO LEG EXOSKELETON EQUIPPED")), "neutral")
        end
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_activate_robofac_back", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_robofac_back"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_activate_robofac_leg"] = function(ctx)
    if (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg")) then
        do local _g = H.safe_id('item', "integrated_bio_robofac_xmleg_on"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        services.messages.add(ctx:expand_text(services.translate("You activate your Hub 01 XM-LEG system.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR: NO XM-LEG INTERFACE DETECTED")), "neutral")
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_activate_robofac_leg", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_activate_robofac_leg"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_DAMAGE_ITEM_simple"] = function(ctx)
    H.set_var("context", nil, ctx, "hp_before", H.char_hp(H.npc(ctx), "ALL", false))
    H.set_char_hp(H.npc(ctx), "ALL", 1000, "-=")
    H.set_var("context", nil, ctx, "hp_after", H.char_hp(H.npc(ctx), "ALL", false))
    services.messages.add(ctx:expand_text(services.translate("<npc_name> have had <context_val:hp_before> hp, now has <context_val:hp_after> hp.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_DAMAGE_ITEM_simple", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_DAMAGE_ITEM_simple"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_FIND_ITEM_simple"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true } }, { "EOC_DAMAGE_ITEM_simple" }, {  })
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_FIND_ITEM_simple", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_FIND_ITEM_simple"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_DAMAGE_ITEM"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", (services.interaction.input_number(services.translate("Amount of damage, 1000 is one bar of damage."), math.floor(1000)).value), "-=")
    services.messages.add(ctx:expand_text(services.translate("Dealt damage to all items.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_DAMAGE_ITEM", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_DAMAGE_ITEM"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_FIND_ITEM"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", nil, nil, { "EOC_DAMAGE_ITEM" }, {  })
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_FIND_ITEM", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_FIND_ITEM"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_CAUSE_EXPLOSION"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "pos") and 1 or 0)) then
        if H.u(ctx) then services.characters.explosion(H.u(ctx), { power = (services.interaction.input_number(services.translate("explosion power"), math.floor(25000)).value), target = H.get_tripoint_var("context", nil, ctx, "pos") }) end
    end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_CAUSE_EXPLOSION", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_CAUSE_EXPLOSION"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_APPLY_FAULT"] = function(ctx)
    do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("context", nil, ctx, "str", _ir.value) end end
    if (services.interaction.confirm(ctx:expand_text(services.translate("Provided id is fault_type or fault?  \"Yes\" for fault_type, \"No\" for fault_id"))) == true) then
        H.set_var("context", nil, ctx, "is_group", 1)
    end
    if (services.interaction.confirm(ctx:expand_text(services.translate("Forced?"))) == true) then
        H.set_var("context", nil, ctx, "is_force", 1)
    end
    if H.truthy((ctx:get_number("is_group") or 0)) then
        if H.truthy((ctx:get_number("is_force") or 0)) then
            do local _it = H.u(ctx); local _s = _it and services.items.snapshot(_it, 0); if not (_s and _s.ok) then _it = H.npc(ctx) end; if _it then services.items.set_random_fault(_it, H.var_str("context", nil, ctx, "str", ""), { force = true }) end end
        else
            do local _it = H.u(ctx); local _s = _it and services.items.snapshot(_it, 0); if not (_s and _s.ok) then _it = H.npc(ctx) end; if _it then services.items.set_random_fault(_it, H.var_str("context", nil, ctx, "str", ""), nil) end end
        end
        services.messages.add(ctx:expand_text(services.translate("<npc_name> has random fault from fault_type \"<context_val:str>\" added, if such group exists.")), "neutral")
    else
        if H.truthy((ctx:get_number("is_force") or 0)) then
            do local _g = H.safe_id('fault', H.var_str("context", nil, ctx, "str", "")); if H.npc(ctx) and _g then services.items.set_fault(H.npc(ctx), _g, { force = true }) end end
        else
            do local _g = H.safe_id('fault', H.var_str("context", nil, ctx, "str", "")); if H.npc(ctx) and _g then services.items.set_fault(H.npc(ctx), _g, nil) end end
        end
        services.messages.add(ctx:expand_text(services.translate("<npc_name> has \"<context_val:str>\" fault added, if such id exists.")), "neutral")
    end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_APPLY_FAULT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_APPLY_FAULT"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_FIND_ITEM_fault"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", nil, nil, { "EOC_APPLY_FAULT" }, {  })
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_FIND_ITEM_fault", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_FIND_ITEM_fault"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_BALTHAZAR_RADIO_FALSE"] = function(ctx)
    if (H.char_has_mission(H.u(ctx), "MISSION_FIND_BALTHAZAR_BUNKER")) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You turn the radio on.\n\nJust static.")))
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_BALTHAZAR_RADIO_FALSE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_BALTHAZAR_RADIO_FALSE"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_BALTHAZAR_RADIO_TRUE"] = function(ctx)
    if ((not (H.char_has_mission(H.u(ctx), "MISSION_FIND_BALTHAZAR_BUNKER")))) then
        if (H.global_var_num("balthazar_power") < 50) then
            ccb.presentation.notice(ctx:expand_text(services.translate("You turn on the radio.  You hear a broadcast:\n\"If anyone can hear, I'm stuck in a bunker and need help.  I'm also transmitting my coordinates.  This message will repeat.\"\nYou note down the coordinates.")))
        else
            ccb.presentation.notice(ctx:expand_text(services.translate("You turn on the radio.  You hear a broadcast:\n\"If anyone who is listening to this broadcast is willing to do work for weapons, head to the transmitted coordinates.  This message will repeat.\"\nYou write down the coordinates.")))
        end
        do local _g = H.safe_id('mission', "MISSION_FIND_BALTHAZAR_BUNKER"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_BALTHAZAR_RADIO_TRUE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_BALTHAZAR_RADIO_TRUE"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_INTEREST_SLIGHT"] = function(ctx)
    if ((not (services.random.native_probability(1, (3))))) then
        services.messages.add(ctx:expand_text(services.translate("You have a slight feeling of being watched.")), "neutral")
        H.set_var("actor", H.u(ctx), ctx, "migo_interest_interest_migo_interest", (H.var_num(H.u(ctx), "migo_interest_interest_migo_interest")) + (1))
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_INTEREST_SLIGHT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_INTEREST_SLIGHT"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_INTEREST_INTENSE"] = function(ctx)
    if ((not (services.random.native_probability(1, (100))))) then
        services.messages.add(ctx:expand_text(services.translate("You have an intense feeling of being watched.")), "neutral")
        H.set_var("actor", H.u(ctx), ctx, "migo_interest_interest_migo_interest", (H.var_num(H.u(ctx), "migo_interest_interest_migo_interest")) + (10))
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_INTEREST_INTENSE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_INTEREST_INTENSE"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_SETUP"] = function(ctx)
    if ((not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function_set", ""))))))) then
        H.set_var("actor", H.npc(ctx), ctx, "mbt_f_function_set", "yes")
        do local _pv = { "morale", "focus", "pain", "sleepiness" }; local _pick = _pv[services.random.native_int(1, #_pv)]; H.set_var("actor", H.npc(ctx), ctx, "mbt_f_function", _pick) end
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_SETUP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_SETUP"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_MORALE"] = function(ctx)
    if (((("morale") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("You feel amazing!")), "neutral")
        do local _g = H.safe_id('morale', "morale_migo_bio_tech"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(30), math.floor(50), { duration = services.time.duration_from_turns(math.floor(43200)), decay_start = services.time.duration_from_turns(math.floor(36000)) }) end end
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_MORALE", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_MORALE"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_FOCUS"] = function(ctx)
    if (((("focus") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("You feel incredibly focused!")), "neutral")
        H.set_char_val_extra(H.u(ctx), "focus", math.min((H.char_val_extra(H.u(ctx), "focus") + 30), 130), "+=")
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_FOCUS", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_FOCUS"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_PAIN"] = function(ctx)
    if (((("pain") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("You feel your aches and pains fade away!")), "neutral")
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor(-(30)) }) end
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_PAIN", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_PAIN"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_MIGO_BIO_TECH_SLEEPINESS"] = function(ctx)
    if (((("sleepiness") == (H.var_str("actor", H.npc(ctx), ctx, "mbt_f_function", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("You instantly feel more awake!")), "neutral")
        H.set_char_val_extra(H.u(ctx), "sleepiness", 30, "-=")
        return true
    end
    return false
end
ccb.runtime.handler("eoc:" .. "EOC_MIGO_BIO_TECH_SLEEPINESS", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MIGO_BIO_TECH_SLEEPINESS"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_string_dimension_phase_immersion_suit_false_start"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The device emits a whispered word: \"ḫuliam\"")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_string_dimension_phase_immersion_suit_false_start", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_string_dimension_phase_immersion_suit_false_start"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_military_papr_mask_to_scba"] = function(ctx)
    do local _g = H.safe_id('item', "military_papr_mask_asr"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
    services.messages.add(ctx:expand_text(services.translate("You switch airflow to the SCBA regulator.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_military_papr_mask_to_scba", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_military_papr_mask_to_scba"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_military_scba_mask_to_papr"] = function(ctx)
    do local _g = H.safe_id('item', "military_papr_mask"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
    services.messages.add(ctx:expand_text(services.translate("You switch airflow to PAPR mode.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_military_scba_mask_to_papr", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_military_scba_mask_to_papr"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_military_filter_mask_to_papr"] = function(ctx)
    do local _g = H.safe_id('item', "military_papr_mask"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
    services.messages.add(ctx:expand_text(services.translate("You switch airflow to PAPR mode.")), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_military_filter_mask_to_papr", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_military_filter_mask_to_papr"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_iuse_dda_efa717d8c60a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_rm13_sans_rebreather", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_014cd25afacd", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_robofac_lens_helmet", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_0401edb30634", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_robofac_lens_helmet_pat", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_390bf7e0007d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_ROBOFAC_PAT_CHATTING_ON_RADIO", ctx)
    return 0
end)
ccb.runtime.handler("w16b_itick_dda_42a7cfc9ad9a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_pat_AR_activate", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_5754f0aa8b87", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_robofac_arm", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_1168b2a38c8e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_robofac_back", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_797816601d88", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_activate_robofac_leg", ctx)
    return 0
end)
ccb.runtime.handler("w16b_itick_dda_155553e578f3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_pat_advanced_AR_activate", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_16572e29bf68", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_PORTAL_STORM_CELL", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_dda_d0272ca855d7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_PORTAL_TELEPORT_UNSTABLE_RIFT", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_dda_11f9f3f2e28d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_FIND_ITEM_simple", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_3f3cb52afee5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_FIND_ITEM", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_6e4035086fff", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_CAUSE_EXPLOSION", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_4f6176b90cab", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_FIND_ITEM_fault", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_2d2dae10b636", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_dimension_swap_test", ctx)
    return 0
end)
ccb.runtime.handler("w16b_itick_dda_5f60d61cc571", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_exodii_wrist_computer_record_labyrinth_location", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_ef1bc98d9edc", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_BALTHAZAR_RADIO_FALSE", ctx)
    E.H.run_eoc("EOC_BALTHAZAR_RADIO_TRUE", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_c698304a6abf", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_MIGO_BIO_TECH_INTEREST_SLIGHT", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_INTEREST_INTENSE", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_SETUP", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_MORALE", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_FOCUS", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_PAIN", ctx)
    E.H.run_eoc("EOC_MIGO_BIO_TECH_SLEEPINESS", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_67248fc4bfb7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("use_hair_dye_kit", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_2f0b057c9dc9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_string_dimension_phase_immersion_suit_false_start", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_df613b957ff6", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_military_papr_mask_to_scba", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_66e7c34c772f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_military_scba_mask_to_papr", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_dda_515bc1a755af", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_military_filter_mask_to_papr", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "rm13_armor", copy_from = "rm13_armor" }
    item:on_use("w16b_iuse_dda_efa717d8c60a", "Activate armor + cyclonic air scrubber")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "robofac_lens_helmet", copy_from = "robofac_lens_helmet" }
    item:on_use("w16b_iuse_dda_014cd25afacd", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "robofac_lens_helmet_pat", copy_from = "robofac_lens_helmet_pat" }
    item:on_use("w16b_iuse_dda_0401edb30634", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "robofac_lens_helmet_pat_on", copy_from = "robofac_lens_helmet_pat_on" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Hail Pat on the radio")
    item:on_tick("w16b_itick_dda_42a7cfc9ad9a")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_bio_robofac_xmarm", copy_from = "integrated_bio_robofac_xmarm" }
    item:on_use("w16b_iuse_dda_5754f0aa8b87", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_bio_robofac_xmback", copy_from = "integrated_bio_robofac_xmback" }
    item:on_use("w16b_iuse_dda_1168b2a38c8e", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_bio_robofac_xmleg", copy_from = "integrated_bio_robofac_xmleg" }
    item:on_use("w16b_iuse_dda_797816601d88", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_pat_radio", copy_from = "integrated_pat_radio" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Activate", "Hail Pat on the radio")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_pat_transponder", copy_from = "integrated_pat_transponder" }
    item:on_tick("w16b_itick_dda_155553e578f3")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "escape_stone", copy_from = "escape_stone" }
    item:on_use("w16b_iuse_dda_16572e29bf68", "Activate", "Seems like a targeted spatial distortion.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "unstable_rift", copy_from = "unstable_rift" }
    item:on_use("w16b_iuse_dda_d0272ca855d7", "Activate", "Seems like a random spatial distortion.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "debug_item_damager", copy_from = "debug_item_damager" }
    item:on_use("w16b_iuse_dda_11f9f3f2e28d", "Damage item")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "debug_item_damager_adv", copy_from = "debug_item_damager_adv" }
    item:on_use("w16b_iuse_dda_3f3cb52afee5", "Damage item")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "debug_mortar", copy_from = "debug_mortar" }
    item:on_use("w16b_iuse_dda_6e4035086fff", "Cause explosion")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "debug_apply_fault", copy_from = "debug_apply_fault" }
    item:on_use("w16b_iuse_dda_4f6176b90cab", "Damage item")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "debug_dimension_traveller", copy_from = "debug_dimension_traveller" }
    item:on_use("w16b_iuse_dda_2d2dae10b636", ccb.content.text_without_extraction("Change dimension"))
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "exodii_wrist_computer_on", copy_from = "exodii_wrist_computer_on" }
    item:on_tick("w16b_itick_dda_5f60d61cc571")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "pat_earpiece", copy_from = "pat_earpiece" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Hail Pat on the radio")
    item:on_tick("w16b_itick_dda_155553e578f3")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "pat_earpiece_on", copy_from = "pat_earpiece_on" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Hail Pat on the radio")
    item:on_tick("w16b_itick_dda_155553e578f3")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "balthazar_radio", copy_from = "balthazar_radio" }
    item:on_use("w16b_iuse_dda_ef1bc98d9edc", "Use radio")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "migo_bio_tech", copy_from = "migo_bio_tech" }
    item:on_use("w16b_iuse_dda_c698304a6abf", "Activate", "Touch the opening.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "hair_dye_kit", copy_from = "hair_dye_kit" }
    item:on_use("w16b_iuse_dda_67248fc4bfb7", "Activate", "Dye your hair")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "ar_glasses_advanced_pat", copy_from = "ar_glasses_advanced_pat" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Hail Pat on the radio")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "ar_glasses_advanced_pat_on", copy_from = "ar_glasses_advanced_pat_on" }
    item:on_use("w16b_iuse_dda_390bf7e0007d", "Hail Pat on the radio")
    item:on_tick("w16b_itick_dda_42a7cfc9ad9a")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "string_dimension_phase_immersion_suit", copy_from = "string_dimension_phase_immersion_suit" }
    item:on_use("w16b_iuse_dda_2f0b057c9dc9", "Turn on")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "military_papr_mask", copy_from = "military_papr_mask" }
    item:on_use("w16b_iuse_dda_df613b957ff6", "Switch to SCBA mode")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "military_papr_mask_asr", copy_from = "military_papr_mask_asr" }
    item:on_use("w16b_iuse_dda_66e7c34c772f", "Switch to PAPR mode")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "military_papr_mask_gasmask", copy_from = "military_papr_mask_gasmask" }
    item:on_use("w16b_iuse_dda_515bc1a755af", "Switch to PAPR mode")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "integrated_pat_transponder_on", copy_from = "integrated_pat_transponder_on" }
    item:on_tick("w16b_itick_dda_155553e578f3")
    ccb.content.replace(item)
end
