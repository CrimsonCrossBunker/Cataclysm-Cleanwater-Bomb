local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
end
end
if H.char_has_flag == nil then
H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
    return r.ok and r.value == true
end
end
if H.char_snap == nil then
H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
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
if H.char_val_extra == nil then
H.char_val_extra = function(actor, aspect)
    if not actor then return 0 end
    local s = H.char_snap(actor)
    if s then
        if aspect == "fine_detail_vision_mod" then return s.senses and s.senses.fine_detail_vision_modifier or 0 end
        if aspect == "activity_level" then return s.activity and s.activity.level_index or 0 end
        if aspect == "morale" then return s.needs and s.needs.morale or 0 end
        if aspect == "focus" then return s.needs and s.needs.focus or 0 end
        if aspect == "instant_thirst" then return s.needs and (s.needs.instant_thirst or s.needs.thirst) or 0 end
        if aspect == "exp" then return s.progression and s.progression.kill_xp or 0 end
        if aspect == "sleep_deprivation" then
            local nr = services.needs.get(actor)
            return (nr.ok and nr.value and nr.value.sleep_deprivation) or 0
        end
        if aspect == "stim" then
            local nr = services.needs.get(actor)
            return (nr.ok and nr.value and nr.value.stimulant) or 0
        end
        if aspect == "pkill" then
            local nr = services.needs.get(actor)
            return (nr.ok and nr.value and nr.value.painkiller) or 0
        end
    end
    local cs = H.creature_snap(actor)
    if cs then
        if aspect == "size" then
            local sz = { tiny = 1, small = 2, medium = 3, large = 4, huge = 5 }
            return sz[cs.size] or 3
        end
        if aspect == "difficulty" then return cs.difficulty or 0 end
        if aspect == "anger" then return cs.anger or 0 end
        if aspect == "morale" then return cs.morale or 0 end
    end
    return 0
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

ccb.runtime.handler("w16b_mon_when_magiclysm_1a7cb897b668", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_e96b61308c20", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_RADIATION_MAGE_MAGIC_FISSILE_IRRADIATES_YOU", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_055f7663f8f9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_d703c72ddb40", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_140d572c6655", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING")))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_9fe5f25f3a2f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "effect_feral_technomancer_bless"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_a1b4a552975d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "effect_feral_technomancer_bless"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_val_extra(H.u(ctx), "morale") <= (-20)) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_73a01ef3ac0e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "synaptic_stim"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))))) == true
end)
ccb.runtime.handler("w16b_mon_die_magiclysm_7750a01550f3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_ROCK_TROLL_TURN_TO_STONE", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_1569edf3b3ec", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.npc(ctx) ~= nil and ((H.safe_id('species', "IRON_GOLEM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IRON_GOLEM")).value == true)))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_0943fa32b485", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_RUST_MONSTER_RUSTING", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_44bc423eb3b5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and ((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_eb41e6451236", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(2)) end)()))) and (H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_4820b435a624", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)())) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_BURROWING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_BURROWING")).value == true)))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_f48b3c5ac470", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_THAUMIC_ZOMBIE_MANA_DRAIN", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_4d961aaef11f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_THAUMIC_ZOMBIE_MANA_DRAIN_BITE", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_90a8f9dfaf08", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "GRAB_FILTER"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
