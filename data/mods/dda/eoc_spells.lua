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

ccb.runtime.handler("w16b_sp_imp_dda_e7276a100109", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AO_SPATIAL_ANCHOR", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_3e3851b7d965", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AO_SPATIAL_ANCHOR_SLOW", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_dc45c4be89fa", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_AO_SURFACE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_19f00d256aea", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BOOK_FAR_TP", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_b31a4fb3e1d2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BOOK_COMBUSTION", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_0240443f212a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGIC_CASCADE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_8394d1c0f288", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BANISH_MONSTERS_AROUND_MANSION_CENTER", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_df14c525adb8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BANISH_SELF", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_bc131e866afc", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_NL_PHASE_GOO", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_a6367bbee809", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_cellar_spider_leg", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_ba42177bae6f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_524665f3baae", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_HAUNTING_QUEUE_STOP", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_321a1ae0df67", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_PORTAL_STORM_SHADOW_RESPAWN", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_ea5c7fd5f297", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FEAR_PARALYZE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_b17489876567", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_STARE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_5cc4b498ce51", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BLANK_BODY_AVATAR_COPY", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_db98276fff7d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_veiled_butterfly_irradiate", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_26c4e01c0faf", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_ZOMBIE_SUMMONER_SUMMON_HORDES", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_9666e364e037", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_QUADRAPHRACT_CONTROL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_3d7c5813cf5e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("YELLOW_MAINTENANCE_ALARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_adc6b30fc1d5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("BLUE_MAINTENANCE_ALARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_c35f22b19969", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("BLUE_MAINTENANCE_ALARM2", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_5be4cecec09d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("GREEN_RESEARCHER_ALARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_101a0512a08d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("BLACK_SECURITY_ALARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_4f13e241e51a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("GREEN_MAINTENANCE_ALARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_dfa1f5d72601", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_LIEUTENANT_DRAIN_LIFE_TERRAIN", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_4b201e0f6068", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_RECLAIMER_CREATE_SPAWN", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_545341de83e1", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_ink_grand_spray", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_dda_347de7b10c96", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_PORTAL_STORM_DUNGEON_REFLECTION_RESPAWN", ctx)
end)
