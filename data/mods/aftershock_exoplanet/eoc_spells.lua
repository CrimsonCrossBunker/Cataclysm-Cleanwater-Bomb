local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H.char_snap == nil then
H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end
end
if H.char_spell_level == nil then
H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end
end
if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end
end
if H.creature_effect_intensity == nil then
H.creature_effect_intensity = function(actor, effect_id, body_part)
    if not actor then return -1 end
    local gid = H.safe_id("effect", effect_id)
    if not gid then return -1 end
    local r
    if body_part then
        local bp_gid = H.safe_id("body_part", body_part)
        if not bp_gid then return -1 end
        r = services.effects.exact_intensity(actor, gid, bp_gid)
    else
        r = services.effects.exact_intensity(actor, gid)
    end
    if not r.ok or r.value == nil then return -1 end
    return r.value
end
end
if H.creature_snap == nil then
H.creature_snap = function(actor)
    if not actor then return nil end
    local r = services.creatures.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end
end
if H.ctx_new == nil then
H.ctx_new = function(u, npc, vars, extra)
    local c = { u = u, npc = npc, vars = vars or {}, _conds = {} }
    if extra then
        for k, v in pairs(extra) do c[k] = v end
    end
    local function _disp(a)
        if not a then return "" end
        local r = services.creatures.snapshot(a)
        if r and r.ok and r.value then return r.value.display_name or r.value.name or "" end
        local ir = services.items.snapshot(a)
        if ir and ir.ok and ir.value then return ir.value.display_name or ir.value.name or "" end
        return ""
    end
    return setmetatable(c, {
        __index = {
            speaker = function(self) return self.u end,
            interlocutor = function(self) return self.npc end,
            alpha = function(self) return self.u end,
            beta = function(self) return self.npc end,
            has_speaker = function(self) return self.u ~= nil end,
            has_interlocutor = function(self) return self.npc ~= nil end,
            by_radio = function(self) return self._by_radio == true end,
            has_reason = function(self) return self._has_reason == true end,
            topic_item = function(self) return self._topic_item end,
            assigned_mission_count = function(self)
                if not self.u then return 0 end
                local r = services.missions.active(self.u, { limit = 64 })
                if not r or not r.items then return 0 end
                return #r.items
            end,
            context_value = function(self, k)
                if self.vars[k] ~= nil then return self.vars[k] end
                if self._raw_dlg and self._raw_dlg.get then return self._raw_dlg:get(k) end
                return nil
            end,
            set_context_value = function(self, k, v)
                self.vars[k] = v
                if self._raw_dlg then
                    if v == nil and self._raw_dlg.remove then self._raw_dlg:remove(k)
                    elseif self._raw_dlg.set then self._raw_dlg:set(k, v) end
                end
            end,
            get = function(self, k) return self:context_value(k) end,
            get_number = function(self, k)
                local v = self:context_value(k)
                return tonumber(v) or 0
            end,
            get_string = function(self, k)
                local v = self:context_value(k)
                return v == nil and "" or tostring(v)
            end,
            set = function(self, k, v) self:set_context_value(k, v) end,
            remove = function(self, k) self:set_context_value(k, nil) end,
            conditional = function(self, k) return self._conds[k] == true end,
            evaluate_conditional = function(self, k) return self._conds[k] == true end,
            set_conditional = function(self, k, v) self._conds[k] = (v == true) end,
            expand_text = function(self, text)
                if type(text) ~= "string" then return "" end
                if self._raw_dlg and self._raw_dlg.expand_text then
                    return self._raw_dlg:expand_text(text)
                end
                local out = string.gsub(text, "<context_val:([^>]+)>", function(k)
                    local v = self.vars[k]
                    return v == nil and "" or tostring(v)
                end)
                out = string.gsub(out, "<u_name>", function() return _disp(self.u) end)
                out = string.gsub(out, "<my_name>", function() return _disp(self.u) end)
                out = string.gsub(out, "<npc_name>", function() return _disp(self.npc) end)
                return out
            end,
        }
    })
end
end
if H.npc == nil then
H.npc = function(ctx)
    return ctx:interlocutor()
end
end
if H.run_eoc == nil then
H.run_eoc = function(eid, ctx, vars_ovr, alpha_ovr, beta_ovr)
    if not eid or eid == "" then return end
    local vars = {}
    if ctx and ctx.vars then
        for k, v in pairs(ctx.vars) do vars[k] = v end
    end
    if vars_ovr then
        for k, v in pairs(vars_ovr) do vars[k] = v end
    end
    local ctx_u = ctx and (ctx.u or (ctx.speaker and ctx:speaker())) or nil
    local ctx_npc = ctx and (ctx.npc or (ctx.interlocutor and ctx:interlocutor())) or nil
    local u = (alpha_ovr ~= nil) and alpha_ovr or ctx_u or services.characters.avatar()
    local npc = (beta_ovr ~= nil) and beta_ovr or ctx_npc or nil
    local extra = nil
    if ctx then
        extra = {
            prevent_death_fn = ctx.prevent_death_fn,
            avatar_death = ctx.avatar_death,
            proxy_pos = ctx.proxy_pos,
            proxy_teleport = ctx.proxy_teleport,
            _raw_dlg = (not ctx.vars and ctx.get) and ctx or ctx._raw_dlg,
        }
    end
    local sub = H.ctx_new(u, npc, vars, extra)
    local fn = E.run[eid]
    if fn then
        return fn(sub)
    end
    if type(ccb.runtime.call_eoc) == "function" then
        local u_c = (u and H.creature_snap(u)) and u or nil
        local npc_c = (npc and H.creature_snap(npc)) and npc or nil
        local flat_vars = {}
        for k, v in pairs(vars) do
            if type(k) == "string" then
                local vt = type(v)
                if vt == "boolean" or vt == "number" or vt == "string" then
                    flat_vars[k] = v
                elseif vt == "userdata" and v.x ~= nil and v.y ~= nil and v.z ~= nil then
                    flat_vars[k] = v
                end
            end
        end
        local ok = pcall(ccb.runtime.call_eoc, "eoc:" .. tostring(eid), { u = u_c, npc = npc_c, vars = flat_vars })
        if ok and vars_ovr == nil and ctx and ctx.vars then
            for k, v in pairs(flat_vars) do ctx.vars[k] = v end
        end
    elseif u and H.creature_snap(u) then
        pcall(ccb.runtime.call_creature, "eoc:" .. tostring(eid), u)
    end
end
end
if H.test_eoc == nil then
H.test_eoc = function(eid, ctx)
    if not eid or eid == "" then return false end
    local cfn = E.cond[eid]
    if cfn then
        if ctx and not ctx.context_value and ctx.get then
            local wrapped = H.ctx_new(ctx:speaker(), ctx:interlocutor(), {}, { _raw_dlg = ctx })
            return cfn(wrapped) == true
        end
        return cfn(ctx) == true
    end
    if type(ccb.runtime.call_eoc) == "function" then
        local u = ctx and (ctx.u or (ctx.speaker and ctx:speaker())) or nil
        local npc = ctx and (ctx.npc or (ctx.interlocutor and ctx:interlocutor())) or nil
        local u_c = (u and H.creature_snap(u)) and u or nil
        local npc_c = (npc and H.creature_snap(npc)) and npc or nil
        local flat_vars = {}
        if ctx and ctx.vars then
            for k, v in pairs(ctx.vars) do
                if type(k) == "string" then
                    local vt = type(v)
                    if vt == "boolean" or vt == "number" or vt == "string" then
                        flat_vars[k] = v
                    elseif vt == "userdata" and v.x ~= nil and v.y ~= nil and v.z ~= nil then
                        flat_vars[k] = v
                    end
                end
            end
        end
        local ok, res = pcall(ccb.runtime.call_eoc, "eoc_test:" .. tostring(eid), { u = u_c, npc = npc_c, vars = flat_vars })
        return ok and res == true
    end
    return false
end
end
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end
if H._jm_int_to_level == nil then
H._jm_int_to_level = function(ctx, _a0)
    return (((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) * 1.5) * _a0)
end
end
if H._jm_scaling_factor == nil then
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
end
end

ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_88055f2d9f6f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("afs_cryosuit_ui_eoc", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_6683a9b08ada", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SHOCK_MINE_CONTROL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_c9857e9c31c8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_3bc4670dab17", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 15000) + 90000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_0c54f04c794b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 30000) + 180000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_127b6da29cdb", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_electrokin_see_electricity") > (-1))) and (0) or (math.max((2000 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 75)), 750))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_47a6ac95789b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return (H._jm_int_to_level(ctx, 1))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_9ea528b5de57", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_electrokin_see_electricity") > (-1))) and (10) or (math.max((150 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 6)), 80))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_09a8abfd66f9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_480dee216b22", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 4500) + 60000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_25a035782a64", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 9000) + 180000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_81660f15b2e0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_electrokin_hacking_interface") > 0)) and (0) or (math.max((6500 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 150)), 3500))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_8da9ef32c2db", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_electrokin_hacking_interface") > 0)) and (10) or (math.max((350 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 9)), 150))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_83199e6519e6", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_ELECTROKIN_HACKING_INTERFACE_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_f66cfc987f66", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_electrokin_personal_battery") > 0)) and (0) or (math.max((6500 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 150)), 3500))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_859fd6ff849d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_electrokin_personal_battery") > 0)) and (10) or (math.max((350 - (H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 9)), 150))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_a508242b35de", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_2abb638e76ae", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 30300) + 117400) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_bbc90a79a641", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 100200) + 223200) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_a66e10dcaaa9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_premonition") > (-1))) and (0) or (math.max((2250 - ((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 85)), 850))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_2b14926816b9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_premonition") > (-1))) and (10) or (math.max((85 - (H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 7)), 25))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_7afa1d362bd0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_PRECOG_DANGER_SENSE_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_fe8fe05d1a8f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 800) + 21000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_d3111342fc43", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 2500) + 64000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_057516fa93ee", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_ranged_enhance") > (-1))) and (0) or (math.max((4500 - (H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 135)), 2250))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_65a3a5e8d24a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_ranged_enhance") > (-1))) and (10) or (math.max((200 - (H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 6)), 125))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_a0db8d2848e5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_PRECOG_RANGED_ENHANCE_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_945db23938c5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 25000) + 121500) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_dc09eab32a66", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 60000) + 270000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_9b20e8af13c8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_craft_bonus") > (-1))) and (0) or (math.max((6500 - (H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 145)), 3250))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_167d8a81a9b8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_craft_bonus") > (-1))) and (10) or (math.max((500 - (H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 3)), 300))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_96d46cf4e0b1", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_PRECOG_CRAFT_BONUS_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_fb031577589d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 900) + 12000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_c59b0dd95721", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 1700) + 45000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_470ed5857222", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_dodge_bonus") > (-1))) and (0) or (math.max((5500 - (H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 145)), 2750))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_479766dd3a22", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_dodge_bonus") > (-1))) and (10) or (math.max((150 - (H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 9)), 70))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_7ed511703cbf", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_PRECOG_DODGE_BONUS_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_d620491205a7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 900) + 24000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_17082b27794b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 2800) + 69000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_4c73374d5a2a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_melee_enhance") > (-1))) and (0) or (math.max((3500 - (H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 135)), 1750))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_5b5f3025d37a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_precog_melee_enhance") > (-1))) and (10) or (math.max((200 - (H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 6)), 125))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_e8980a31643f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_PRECOG_MELEE_ENHANCE_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_8cf5c742a7ab", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 1000) + 9000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_cf569ff7e8f4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 2000) + 60000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_5dfd83c18817", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telekinetic_momentum") > (-1))) and (0) or (math.max((3500 - (H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 125)), 1750))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_bf9d59a04a9e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telekinetic_momentum") > (-1))) and (10) or (math.max((300 - (H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 7.5)), 125))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_545b64477a99", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKIN_MOMENTUM_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_65a6bd3d995a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return (math.min((((H.char_spell_level(H.u(ctx), "afs_telekinetic_wave") * 0.2) + 1) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 4))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_c5a7b7fb320a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKIN_WAVE_TARGETS", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_c600c89a0c09", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_431718bc2b59", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_a2028a4d9f57", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return (math.min((((H.char_spell_level(H.u(ctx), "afs_telekinetic_move_creature") * 0.9) + 2) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 40))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_ab78e91393ce", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKINETIC_FORCE_SHOVE_PUSH_CHECKER", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_bc8350841ba2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEKINETIC_FORCE_SHOVE_PULL_CHECKER", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_8c5586316516", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 1500) + 18000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_929e342ce5fe", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 3600) + 72000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_72ca327fc30e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepathic_psi_armor") > (-1))) and (0) or (math.max((2500 - (H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 125)), 500))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_4a50feda0b31", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepathic_psi_armor") > (-1))) and (10) or (math.max((100 - (H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 6.5)), 10))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_8b15655655cd", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEPATH_SHIELD_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_1aa90031cacc", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 2600) + 9000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_4ef2ea07ff14", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 13100) + 60000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_f92cf150f632", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepath_sense_minds") > (-1))) and (0) or (math.max((3500 - (H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 115)), 1500))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_7880815587af", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepath_sense_minds") > (-1))) and (10) or (500)))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_7635194fddfd", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEPATH_SENSE_MINDS_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_6f54706ae510", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 38100) + 98100) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_1b1797e83627", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 89900) + 252000) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_2455504b152d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepathic_suggestion") > (-1))) and (0) or (math.max((5000 - (H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 125)), 2000))))
end)
ccb.runtime.handler("w16b_sp_stat_aftershock_exoplanet_72a01a10871d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_afs_telepathic_suggestion") > (-1))) and (10) or (math.max((300 - (H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 9.5)), 150))))
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_7ae166bfa075", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AFS_TELEPATH_SUGGESTION_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_aftershock_exoplanet_fcbf2b2f725b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("afs_motion_sensor_eoc", ctx)
end)
