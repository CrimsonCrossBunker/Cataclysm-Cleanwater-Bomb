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

ccb.content.add(ccb.content.Bionic {
    id = "mountain_tattoo_two",
    name = "Base of the Mountain",
    description = "The second element of the mountain pattern, the lower paths and foothills of a mountain on the lower back.  When activated, your unarmed attacks hit harder.  The damage increases as you complete more of the mountain pattern.",
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 35000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 10 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_mountain_tattoo_two_0" },
    required_bionic = "mountain_tattoo_one",
})
ccb.content.add(ccb.content.Bionic {
    id = "mountain_tattoo_six",
    name = "The Crown of the Mountain",
    description = "The sixth element of the mountain pattern, the lofty summit beneath the sky.  You may activate this element to turn your skin into stone, slowing you slightly but greatly increasing your resilience",
    activation_energy_millijoules = 195000,
    over_time_energy_millijoules = 195000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 25 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_mountain_tattoo_six_0" },
    required_bionic = "mountain_tattoo_five",
})
ccb.runtime.handler("w16b_xedrawood_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "mountain_tattoo_two" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_TWO_ON", ctx)
    elseif bid == "mountain_tattoo_six" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_SIX_ON", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_xedrawood_on_bionic_activated")
ccb.runtime.handler("w16b_xedrawood_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "mountain_tattoo_two" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_TWO_OFF", ctx)
    elseif bid == "mountain_tattoo_six" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_MOUNTAIN_SIX_OFF", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_xedrawood_on_bionic_deactivated")
