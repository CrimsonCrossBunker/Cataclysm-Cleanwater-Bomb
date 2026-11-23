local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end
end
if H.char_has_bionic == nil then
H.char_has_bionic = function(actor, bionic_id)
    if not actor then return false end
    if bionic_id == "ANY" then
        local s = services.bionics.summary(actor)
        return s.ok and s.value and (s.value.installed_count or 0) > 0
    end
    local gid = H.safe_id("bionic", bionic_id)
    if not gid then return false end
    local r = services.bionics.has(actor, gid)
    return r.ok and r.value == true
end
end
if H.char_has_mission == nil then
H.char_has_mission = function(actor, mission_id)
    if not actor then return false end
    local gid = H.safe_id("mission", mission_id)
    if not gid then return false end
    local r = services.missions.has_active(actor, gid)
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
if H.item_matches_search == nil then
H.item_matches_search = function(snap, crit, item)
    if not crit then return true end
    if crit.id and (not snap.id or snap.id.value ~= crit.id) then return false end
    if crit.category then
        local cat = type(snap.category) == "table" and snap.category.id or snap.category
        if cat ~= crit.category then return false end
    end
    if crit.worn_only and snap.location_kind ~= "worn" then return false end
    if crit.wielded_only and snap.location_kind ~= "wielded" then return false end
    if crit.flags and item then
        for _, fl in ipairs(crit.flags) do
            local fg = H.safe_id("json_flag", fl)
            if not fg then return false end
            local fr = services.items.has_flag(item, fg)
            if not fr.ok or fr.value ~= true then return false end
        end
    end
    if crit.excluded_flags and item then
        for _, fl in ipairs(crit.excluded_flags) do
            local fg = H.safe_id("json_flag", fl)
            if fg then
                local fr = services.items.has_flag(item, fg)
                if fr.ok and fr.value == true then return false end
            end
        end
    end
    return true
end
end
if H.eoc_run_inv_eocs == nil then
H.eoc_run_inv_eocs = function(actor, ctx, mode, title, search_list, true_eocs, false_eocs)
    if not actor then return end
    local matches = {}
    local p = services.inventory.carried_items(actor)
    if p.ok and p.value then
        for _, item in ipairs(p.value) do
            local ok_match = (not search_list or #search_list == 0)
            if not ok_match then
                local sr = services.items.snapshot(item)
                local snap = sr.ok and sr.value or {}
                for _, crit in ipairs(search_list) do
                    if H.item_matches_search(snap, crit, item) then
                        local cond_ok = true
                        if crit._cond_fn then
                            cond_ok = crit._cond_fn(H.ctx_new(ctx.u, item, ctx.vars))
                        end
                        if cond_ok then ok_match = true break end
                    end
                end
            end
            if ok_match then table.insert(matches, item) end
        end
    end
    if #matches == 0 then
        for _, fe in ipairs(false_eocs or {}) do H.run_eoc(fe, ctx) end
        return
    end
    local picked = {}
    if mode == "all" then
        picked = matches
    elseif mode == "random" then
        picked = { matches[services.random.native_int(1, #matches)] }
    elseif mode == "manual" then
        local r = services.inventory.choose(actor, matches, title)
        if r.ok and r.value and r.value.item then picked = { r.value.item } end
    elseif mode == "manual_mult" then
        local r = services.inventory.choose_many(actor, matches, title)
        if r.ok and r.value and r.value.items then picked = r.value.items end
    end
    if #picked == 0 then
        for _, fe in ipairs(false_eocs or {}) do H.run_eoc(fe, ctx) end
        return
    end
    for _, item in ipairs(picked) do
        for _, te in ipairs(true_eocs or {}) do
            H.run_eoc(te, ctx, nil, ctx.u, item)
        end
    end
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
if H.global_var_num == nil then
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
end
if H.set_char_hp == nil then
H.set_char_hp = function(actor, bp, val, op)
    if not actor then return end
    local cs = H.creature_snap(actor)
    if cs and cs.kind == "monster" then
        local cur = cs.hp or 0
        local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or (cur - val))
        services.monsters.set_hp(actor, math.floor(nxt + 0.5))
        return
    end
    if bp == "ALL" or bp == "ALL_MAJOR" or bp == "ALL_MINOR" then
        local s = H.char_snap(actor)
        if op == "=" then
            services.characters.set_hp_group(actor, bp, math.floor(val + 0.5))
        elseif s and s.body_parts then
            for _, p in ipairs(s.body_parts) do
                if p.id and (bp == "ALL" or (bp == "ALL_MAJOR" and p.is_main) or (bp == "ALL_MINOR" and not p.is_main)) then
                    local cur = p.hp or 0
                    local nxt = (op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or ((op == "*=") and (cur * val) or (cur / val)))
                    services.characters.set_hp(actor, p.id, math.floor(nxt + 0.5), true)
                end
            end
        end
        return
    end
    local gid = H.safe_id("body_part", bp)
    if not gid then return end
    local cur = H.char_hp(actor, bp, false)
    local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or ((op == "*=") and (cur * val) or (cur / val))))
    services.characters.set_hp(actor, gid, math.floor(nxt + 0.5), true)
end
end
if H.set_char_val_extra == nil then
H.set_char_val_extra = function(actor, aspect, val, op)
    if not actor then return end
    if aspect == "rad" or aspect == "stim" or aspect == "pkill" or aspect == "sleep_deprivation"
       or aspect == "sleepiness" or aspect == "thirst" or aspect == "instant_thirst"
       or aspect == "focus" or aspect == "stamina" then
        local nr = services.needs.get(actor)
        local nkey = (aspect == "rad") and "radiation"
            or ((aspect == "stim") and "stimulant"
            or ((aspect == "pkill") and "painkiller"
            or ((aspect == "instant_thirst") and "thirst" or aspect)))
        local cur = (nr.ok and nr.value and nr.value[nkey]) or 0
        local nxt = val
        if op == "+=" then nxt = cur + val
        elseif op == "-=" then nxt = cur - val
        elseif op == "*=" then nxt = cur * val
        elseif op == "/=" then nxt = cur / val
        end
        services.needs.set(actor, { [nkey] = math.floor(nxt + 0.5) })
        return
    end
    if aspect == "anger" or aspect == "morale" then
        local cs = H.creature_snap(actor)
        if cs and cs.kind == "monster" then
            local cur = cs[aspect] or 0
            local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or (cur - val))
            services.monsters.set_disposition(actor, { [aspect] = math.floor(nxt + 0.5) })
        end
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
if H.truthy == nil then
H.truthy = function(v)
    return v ~= false and v ~= nil and v ~= 0
end
end
if H.var_exists == nil then
H.var_exists = function(scope, actor, ctx, key)
    if scope == "context" then return ctx:get(key) ~= nil end
    if scope == "global" then
        local r = services.variables.get_global(key)
        return r.ok and r.value and r.value.exists == true
    end
    if not actor then return false end
    local r = services.variables.get(actor, key)
    return r.ok and r.value and r.value.exists == true
end
end
if H.var_num == nil then
H.var_num = function(actor, key)
    if not actor then return 0 end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
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
