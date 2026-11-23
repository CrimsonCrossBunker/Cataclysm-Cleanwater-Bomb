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
if H.char_effect_dur == nil then
H.char_effect_dur = function(actor, eff_id, bp)
    if not actor then return 0 end
    local gid = H.safe_id("effect", eff_id)
    if not gid then return 0 end
    local bpg = (bp and bp ~= "") and H.safe_id("body_part", bp) or nil
    local r = services.effects.get(actor, gid, bpg)
    if not r.ok or not r.value or not r.value.duration then return 0 end
    return r.value.duration.turns or 0
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
if H.char_skill_exp == nil then
H.char_skill_exp = function(actor, skill_id, raw)
    if not actor then return 0 end
    local gid = H.safe_id("skill", skill_id)
    if not gid then return 0 end
    local r = services.skills.get(actor, gid)
    if not r.ok or not r.value then return 0 end
    if raw then return r.value.practical_exercise_raw or 0 end
    return r.value.practical_exercise_percent or 0
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
if H.eoc_add_effect == nil then
H.eoc_add_effect = function(actor, eff_id, turns, bp, intensity, force)
    if not actor then return end
    local gid = H.safe_id("effect", eff_id)
    if not gid then return end
    local opts = {}
    if bp and bp ~= "" then opts.body_part = H.safe_id("body_part", bp) end
    if intensity ~= nil then opts.intensity = math.floor(intensity) end
    if force ~= nil then opts.force = (force == true) end
    if turns < 0 then
        opts.permanent = true
        services.effects.add(actor, gid, services.time.duration_from_turns(1), opts)
    else
        services.effects.add(actor, gid, services.time.duration_from_turns(math.floor(turns)), opts)
    end
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
if H.eoc_map_run_item_eocs == nil then
H.eoc_map_run_item_eocs = function(actor, ctx, mode, pos, min_r, max_r, title, search_list, true_eocs)
    local origin = pos
    if not origin then
        local cs = H.creature_snap(actor)
        origin = cs and cs.position
    end
    if not origin then return end
    local r = services.items.on_map(origin, math.floor(min_r or 0), math.floor(max_r or 0))
    if not r.ok or not r.value then return end
    local matches = {}
    for _, item in ipairs(r.value) do
        local ok_match = (not search_list or #search_list == 0)
        if not ok_match then
            local sr = services.items.snapshot(item)
            local snap = sr.ok and sr.value or {}
            for _, crit in ipairs(search_list) do
                if H.item_matches_search(snap, crit, item) then ok_match = true break end
            end
        end
        if ok_match then table.insert(matches, item) end
    end
    local picked = matches
    if mode == "manual" then
        local cr = services.inventory.choose_map(actor, matches, title and { title = title } or nil)
        picked = (cr.ok and cr.value and cr.value.item) and { cr.value.item } or {}
    elseif mode == "manual_mult" then
        local cr = services.inventory.choose_many_map(actor, matches, title and { title = title } or nil)
        picked = (cr.ok and cr.value and cr.value.items) or {}
    elseif mode == "random" and #matches > 0 then
        picked = { matches[services.random.native_int(1, #matches)] }
    end
    for _, item in ipairs(picked) do
        for _, te in ipairs(true_eocs or {}) do
            H.run_eoc(te, ctx, nil, ctx.u, item)
        end
    end
end
end
if H.eoc_spawn_item == nil then
H.eoc_spawn_item = function(actor, id_str, cnt, use_group, force_eq, cont_str)
    if not actor then return end
    local opts = {}
    if force_eq then opts.force_equip = true end
    if cont_str and cont_str ~= "" then
        local cgid = H.safe_id("item", cont_str)
        if cgid then opts.container = cgid end
    end
    if use_group then
        local gid = H.safe_id("item_group", id_str)
        if gid then
            for _ = 1, math.max(1, math.floor(cnt or 1)) do
                services.inventory.receive_group(actor, gid, opts)
            end
        end
    else
        local gid = H.safe_id("item", id_str)
        if gid then services.inventory.receive_item(actor, gid, math.floor(cnt or 1), opts) end
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

local EOC = E.run
local COND = E.cond
EOC["EOC_ACTIVATE_MAP"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_ACTIVATE_MAP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_ACTIVATE_MAP"](H.ctx_new(u, npc, vars))
end)
EOC["eoc_pick_and_read_map"] = function(ctx)
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", H.get_tripoint_var("context", nil, ctx, "pos"), 0, 0, nil, { { category = "maps" } }, { "EOC_ACTIVATE_MAP" })
    return true
end
ccb.runtime.handler("eoc:" .. "eoc_pick_and_read_map", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["eoc_pick_and_read_map"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_60MM_SHOT"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "aimed_60mm", 180, nil, nil, nil)
    local _a1 = H.u(ctx)
    local _sg2 = H.safe_id("skill", "launcher")
    if _a1 and _sg2 then services.skills.set(_a1, _sg2, { exercise_percent = math.floor((H.char_skill_exp(_a1, "launcher", false)) + 1) }) end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 400) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 1340) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2150) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2890) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_60MM_SHOT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_60MM_SHOT"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_tile_ex_dda_f87909e875f4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("eoc_pick_and_read_map", ctx)
end)
ccb.runtime.handler("w16b_mortar_c_dda_d4f8a86bd18c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return ((H.char_skill(H.u(ctx), "launcher") >= 1)) == true
end)
ccb.runtime.handler("w16b_mortar_dur_dda_0e910b3b75ac", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return ((((H.char_effect_dur(H.u(ctx), "aimed_60mm", "") > 1)) and (math.max(5, (16 / H.char_skill(H.u(ctx), "launcher")))) or (math.max(60, (190 / H.char_skill(H.u(ctx), "launcher"))))))
end)
ccb.runtime.handler("w16b_mortar_dev_dda_908d8984994c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return (math.max(0.02, (0.1 / H.char_skill(H.u(ctx), "launcher"))))
end)
ccb.runtime.handler("w16b_mortar_f_m224_mortar_fired", function(payload)
    if not payload or not payload.furniture or payload.furniture.value ~= "f_m224_mortar" then return end
    local t = payload.target
    local tpos = t and services.coords.tripoint_abs_ms(t.x, t.y, t.z) or nil
    local ctx = E.H.ctx_new(payload.character, nil, { target = tpos })
    E.H.run_eoc("EOC_60MM_SHOT", ctx)
end)
ccb.runtime.hook("on_mortar_fired", "w16b_mortar_f_m224_mortar_fired")
