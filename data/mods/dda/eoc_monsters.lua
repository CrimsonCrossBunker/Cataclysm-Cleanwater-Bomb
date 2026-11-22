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
if H.char_hp == nil then
H.char_hp = function(actor, bp, is_max)
    if not actor then return 0 end
    local cs = H.creature_snap(actor)
    if cs and cs.kind == "monster" then
        return is_max and (cs.hp_max or 0) or (cs.hp or 0)
    end
    if bp == "ALL" or bp == "ALL_MAJOR" or bp == "ALL_MINOR" then
        if is_max then
            local s = H.char_snap(actor)
            local sum = 0
            if s and s.body_parts then
                for _, p in ipairs(s.body_parts) do
                    if bp == "ALL" or (bp == "ALL_MAJOR" and p.is_main) or (bp == "ALL_MINOR" and not p.is_main) then
                        sum = sum + (p.hp_max or 0)
                    end
                end
            end
            return sum
        end
        local r = services.characters.hp_group(actor, bp)
        return (r.ok and r.value) or 0
    end
    local gid = H.safe_id("body_part", bp)
    if not gid then return 0 end
    local r = is_max and services.characters.hp_max(actor, gid) or services.characters.hp(actor, gid)
    return (r.ok and r.value) or 0
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
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end
if H.npc == nil then
H.npc = function(ctx)
    return ctx:interlocutor()
end
end
if H.resolve_var_ref == nil then
H.resolve_var_ref = function(ctx, vname)
    if type(vname) ~= "string" or vname == "" then return "global", nil, "" end
    if string.sub(vname, 1, 2) == "u_" then return "actor", H.u(ctx), string.sub(vname, 3) end
    if string.sub(vname, 1, 2) == "n_" then return "actor", H.npc(ctx), string.sub(vname, 3) end
    if string.sub(vname, 1, 4) == "npc_" then return "actor", H.npc(ctx), string.sub(vname, 5) end
    if string.sub(vname, 1, 1) == "_" then return "context", nil, string.sub(vname, 2) end
    return "global", nil, vname
end
end
if H.resolve_var_get == nil then
H.resolve_var_get = function(ctx, ind_key, as_tripoint)
    local sc, act, key = H.resolve_var_ref(ctx, ind_key)
    if key == "" then return nil end
    if sc == "context" then return ctx and (ctx.context_value and ctx:context_value(key) or (ctx.get and ctx:get(key))) end
    if as_tripoint then
        local r = (sc == "global") and services.variables.get_global_tripoint(key) or (act and services.variables.get_tripoint(act, key))
        return (r and r.ok and r.value and r.value.exists) and r.value.value or nil
    end
    local r = (sc == "global") and services.variables.get_global(key) or (act and services.variables.get(act, key))
    return (r and r.ok and r.value and r.value.exists) and r.value.value or nil
end
end
if H.get_tripoint_var == nil then
H.get_tripoint_var = function(scope, actor, ctx, key)
    if scope == "indirect" then
        return H.resolve_var_get(ctx, key, true)
    elseif scope == "context" then
        return ctx and (ctx.context_value and ctx:context_value(key) or (ctx.get and ctx:get(key))) or nil
    elseif scope == "global" then
        local r = services.variables.get_global_tripoint(key)
        if r.ok and r.value and r.value.exists then return r.value.value end
    elseif actor then
        local r = services.variables.get_tripoint(actor, key)
        if r.ok and r.value and r.value.exists then return r.value.value end
    end
    return nil
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

ccb.runtime.handler("w16b_mon_die_dda_ff5c065ee8cb", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_BALTHAZAR_SECUBOT_DEATH", ctx)
end)
ccb.runtime.handler("w16b_mon_die_dda_2b4325f0fd26", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_BALTHAZAR_TURRET_DEATH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_faf89649dc5f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_mon_feral_serum_user_armus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_act_dda_1cdaa456d5d6", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    E.H.run_eoc("EOC_FERAL_ARMUS_TAKE_ARMUS", ctx)
    return true
end)
ccb.runtime.handler("w16b_mon_die_dda_349bae35910e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_last_amigara_death", ctx)
end)
ccb.runtime.handler("w16b_mon_die_dda_d5ced7e2cd06", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_HURT_WEAVER", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_580b558524a0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (H.test_eoc("target_valid_drink", ctx)))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_d7091a512a5a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and H.test_eoc("target_valid_drink", ctx))) == true
end)
ccb.runtime.handler("w16b_mon_hit_dda_9eeabc287a72", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_STAR_VAMPIRE_FANGED_DRINK_BLOOD", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_df6653f4916a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_dda_8e6606a2eaa5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_STAR_VAMPIRE_COILING_DRINK_BLOOD", ctx)
end)
ccb.runtime.handler("w16b_mon_die_dda_e17433f125e4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_YUGG_DEATH", ctx)
end)
ccb.runtime.handler("w16b_wp_hit_dda_2e713f2b057f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.target or nil, nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_MORALE_SUBTRACT_100", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_1dc0a6a48b7b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm")) or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")))) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_e2eb0ec192ae", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm")) or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm"))) == true
end)
ccb.runtime.handler("w16b_mon_die_dda_4b0ed19737a6", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_QUADRAPHRACT_DIES", ctx)
end)
ccb.runtime.handler("w16b_mon_die_dda_1291fa508cc1", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_QUADRAPHRACT_HURT", ctx)
end)
ccb.runtime.handler("w16b_rev_dda_8cdff51a3b28", function(payload)
    local ctx = E.H.ctx_new(nil, nil, { pos = payload and payload.position or nil, corpse_damage = payload and payload.corpse_damage or 0 })
    return (((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "FUNGUS"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_64dd62fe7d65", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 100)) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_3b15b98d0c92", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 250)) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_a02c014982fb", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 75))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_2d7d926a8d02", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 150))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_38894ffc5cf5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 250))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_59fed3e78217", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 200)) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_6bf0c3272467", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.creature_effect_intensity(H.u(ctx), "grown_of_fuse") > 300)) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_0dd731eb5657", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "maimed_acid_gland"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "absorbed_acidic"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_33e98f0bbc1d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "maimed_acid_gland"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "maimed_claws"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "absorbed_acidic"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "acid_charged"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_61a0abd2c3e5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((function() local eg = H.safe_id('effect', "absorbed_pupating"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
end)
ccb.runtime.handler("w16b_mon_hit_dda_42070f6819f0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_DEVOURER_SPAWN_RAPTORS", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_d1a34240329d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB"))) == true
end)
ccb.runtime.handler("w16b_mon_when_dda_95e7999fef3d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_hp(H.u(ctx), "ALL", false) > 190)) == true
end)
ccb.runtime.handler("w16b_mon_hit_dda_19af43c2a949", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_DAITYA_SPAWN_CLONES", ctx)
end)
ccb.runtime.handler("w16b_mon_when_dda_68e95bb7065a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.char_val_extra(H.npc(ctx), "size") <= 4))) == true
end)
ccb.runtime.handler("w16b_mon_die_dda_838106c5d48b", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_NEMESIS_DIED", ctx)
end)
