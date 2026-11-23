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
if H.char_cash == nil then
H.char_cash = function(actor)
    local s = H.char_snap(actor)
    if not s then return 0 end
    return s.cash or 0
end
end
if H.char_skill == nil then
H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then return 0 end
    return r.value or 0
end
end
if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end
end
if H.creature_has_effect == nil then
H.creature_has_effect = function(actor, effect_id, body_part, intensity)
    if not actor then return false end
    local gid = H.safe_id("effect", effect_id)
    if not gid then return false end
    local bp_gid = nil
    if body_part and body_part ~= "" then
        bp_gid = H.safe_id("body_part", body_part)
        if not bp_gid then return false end
    end
    local r = services.effects.has(actor, gid, bp_gid, intensity)
    return r.ok and r.value == true
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
if H.global_var_num == nil then
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
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
if H.set_var == nil then
H.set_var = function(scope, actor, ctx, key, val)
    if scope == "indirect" then
        return H.set_var_indirect(ctx, key, val)
    end
    if scope == "context" then
        if ctx then
            if ctx.set_context_value then ctx:set_context_value(key, val)
            elseif val == nil and ctx.remove then ctx:remove(key)
            elseif ctx.set then ctx:set(key, val) end
        end
        return
    end
    if val == nil then
        if scope == "global" then services.variables.remove_global(key)
        elseif actor then services.variables.remove(actor, key) end
        return
    end
    local out = val
    if type(out) == "boolean" then out = out and 1 or 0 end
    if scope == "global" then
        services.variables.set_global(key, out)
    elseif actor then
        services.variables.set(actor, key, out)
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

ccb.runtime.handler("w16b_p_aftershock_exoplanet_bffe506920cd", function(ctx)
    return ((not H.creature_has_effect(H.npc(ctx), "currently_busy")) and (H.char_cash(H.u(ctx)) >= (120000)))
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_a3b5aab47d45", function(ctx)
    return ((not H.creature_has_effect(H.npc(ctx), "currently_busy")) and (H.char_cash(H.u(ctx)) >= (240000)))
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_dd3204339ab9", function(ctx)
    return H.test_eoc("EOC_CONDITION_CAN_DATA_SALVAGE", ctx)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_9c96fef38faa", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "computer"))) > (12))
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_cf103714d71e", function(ctx)
    return (H.global_var_num("computer_salvageable") == 1)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_7a79c7d7cbcf", function(ctx)
    return (H.global_var_num("your_ship_ramp_up") ~= 1)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_36e4be47b755", function(ctx)
    return (H.global_var_num("your_ship_ramp_up") == 1)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_14478cd75069", function(ctx)
    return (H.global_var_num("ship_can_travel") ~= 1)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_4ce94378d266", function(ctx)
    return (H.global_var_num("ship_can_travel") == 1)
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_92b580caf574", function(ctx)
    return (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "high_orbit_salus_4tp", math.floor(2)) end)())))
end)
ccb.runtime.handler("w16b_p_aftershock_exoplanet_d926b2f28ac0", function(ctx)
    return (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "afs_shuttlepad_salvors_a2_2", math.floor(5)) end)())))
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_9b49a23fa9cc", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(120000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_277f1df6f74f", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(240000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_6616d9d8c75f", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(3000000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_7eed23eb2945", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(4000000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_824101549704", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(100000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_b5399379ef32", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(366000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_a8c0944b1770", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(300000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_bc31ed04dad3", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(1250000) }) end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_a78b9e659073", function(ctx)
    H.run_eoc("EOC_COMPUTER_GENERIC_SALVAGE_FAIL", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_2e02c6732904", function(ctx)
    H.set_var("global", nil, ctx, "computer_salvageable", (H.global_var_num("computer_salvageable")) + (1))
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_596ab37fe21f", function(ctx)
    if (H.global_var_num("computer_salvageable") == 1) then
        H.run_eoc("EOC_DATA_SALVAGE", ctx, { ["data_type"] = "generic_ruin" }, nil, nil)
        local _u1 = H.u(ctx)
        if _u1 then services.characters.adjust(_u1, { moves = -math.floor((0.05) * 100) }) end
    end
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_c2ae7fee24ef", function(ctx)
    H.run_eoc("EOC_SHIP_THI_MANUAL_QUERY", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_4fe8bc1c7561", function(ctx)
    H.run_eoc("EOC_SHIP_RAMP", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_6ff86387a35f", function(ctx)
    H.run_eoc("EOC_SHIP_THI_MANUAL_CONTROL", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_069b11697a25", function(ctx)
    H.run_eoc("EOC_SHIP_THI_TO_SALUS_ORBIT", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_aftershock_exoplanet_f1438d0f1249", function(ctx)
    H.run_eoc("EOC_SHIP_THI_TO_SPACEPORT", ctx, nil, nil, nil)
end)
