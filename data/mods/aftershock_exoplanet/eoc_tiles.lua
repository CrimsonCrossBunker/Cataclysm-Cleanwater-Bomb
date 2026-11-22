local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

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
if H.var_str == nil then
H.var_str = function(scope, actor, ctx, key, default_val)
    if scope == "context" then
        local v = ctx:get_string(key)
        if v ~= nil and v ~= "" then return v end
        local gv = ctx:get(key)
        if gv ~= nil then return tostring(gv) end
        return default_val or ""
    end
    if scope == "global" then
        local r = services.variables.get_global_string(key)
        if r.ok and r.value and r.value.exists and r.value.value ~= nil then return r.value.value end
        return default_val or ""
    end
    if not actor then return default_val or "" end
    local r = services.variables.get_string(actor, key)
    if r.ok and r.value and r.value.exists and r.value.value ~= nil then return r.value.value end
    return default_val or ""
end
end

local EOC = E.run
local COND = E.cond
EOC["EOC_unlock_afs_crate"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 9, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_crate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_crate"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_display_case"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_display_case", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_display_case"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_security_panel"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 6 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_security_panel", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_security_panel"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_security_panel_10"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 10 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_security_panel_10", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_security_panel_10"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_e_safe"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 3600)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 13, ["t_radius"] = 1 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_e_safe", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_e_safe"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_cryo_storage_unit"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "EOC_hack_cryo_storage_unit_success")
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 8, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_cryo_storage_unit", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_cryo_storage_unit"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_metal_door"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 9, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_metal_door", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_metal_door"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_aae3520fcb96", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_crate", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_8a3072a84d7f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_display_case", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_c0eeb92bea86", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_security_panel", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_d6559b6d06f7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_security_panel_10", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_6524a6a6b6d3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_e_safe", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_48d2ac0397b2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_cryo_storage_unit", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_49d6e9dea68e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_metal_door", ctx)
end)
