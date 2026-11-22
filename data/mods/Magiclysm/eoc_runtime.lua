local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }

H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end
H.char_at_om_location = function(actor, loc_id)
    local s = H.char_snap(actor)
    if not s or not s.creature then return false end
    return services.overmap.matches_location(s.creature.position:project_to("omt"), loc_id)
end
H.char_bionic_power = function(actor, which)
    if not actor then return 0 end
    if actor.kind == "item" then
        local ir = services.items.snapshot(actor)
        if not ir.ok or not ir.value or not ir.value.resources then return 0 end
        local res = ir.value.resources
        local cur = res.ammo_remaining or 0
        local mx = cur + (res.ammo_capacity_remaining or 0)
        if which == "power" then return cur end
        if which == "power_max" then return mx end
        if mx == 0 then return 0 end
        return cur * 100.0 / mx
    end
    local r = services.bionics.summary(actor)
    if not r.ok or not r.value then return 0 end
    if which == "power" then return (r.value.power and r.value.power:value("millijoule")) or 0 end
    if which == "power_max" then return (r.value.maximum_power and r.value.maximum_power:value("millijoule")) or 0 end
    local cur = (r.value.power and r.value.power:value("millijoule")) or 0
    local mx = (r.value.maximum_power and r.value.maximum_power:value("millijoule")) or 0
    if mx == 0 then return 0 end
    return cur * 100.0 / mx
end
H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end
H.char_has_any_trait = function(actor, ids)
    if not actor then return false end
    for _, id in ipairs(ids) do
        if H.char_has_trait(actor, id) == 1 then return true end
    end
    return false
end
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
end
H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
    return r.ok and r.value == true
end
H.char_has_item = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_type(actor, gid)
    return r.ok and r.value == true
end
H.char_has_items = function(actor, item_id, count, charges)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_items(actor, gid, count, charges)
    return r.ok and r.value == true
end
H.creature_snap = function(actor)
    if not actor then return nil end
    local r = services.creatures.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end
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
H.char_is_wearing = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.is_wearing(actor, gid)
    return r.ok and r.value == true
end
H.char_mana = function(actor, which)
    if not actor then return 0 end
    local r = services.spells.mana(actor)
    if not r.ok or not r.value then return 0 end
    return r.value[which] or 0
end
H.char_on_furniture = function(actor, furn_id)
    local s = H.char_snap(actor)
    if not s or not s.creature then return false end
    return services.gameplay.environment.furniture_id(s.creature.position) == furn_id
end
H.char_pain = function(actor)
    local s = H.char_snap(actor)
    if not s or not s.creature then return 0 end
    return s.creature.pain or 0
end
H.char_proficiency = function(actor, prof_id, fmt)
    if not actor then return 0 end
    local gid = H.safe_id("proficiency", prof_id)
    if not gid then return 0 end
    if fmt == "total_time_required" then
        local def = services.proficiencies.definition(gid)
        if def and def.time_to_learn then return def.time_to_learn.turns or 0 end
        return 0
    end
    local r = services.proficiencies.get(actor, gid)
    if not r.ok or not r.value then return 0 end
    if fmt == "percent" then return (r.value.practice or 0) * 100 end
    if fmt == "permille" then return math.floor((r.value.practice or 0) * 1000) end
    if fmt == "time_left" then return r.value.remaining and r.value.remaining.turns or 0 end
    return r.value.practiced and r.value.practiced.turns or 0
end
H.char_school_level = function(actor, school_id)
    if not actor then return -1 end
    local gid = H.safe_id("mutation", school_id)
    if not gid then return -1 end
    local r = services.spells.school_level(actor, gid)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end
H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then return 0 end
    return r.value or 0
end
H.char_spell_exp = function(actor, spell_id)
    if not actor then return -1 end
    local gid = H.safe_id("spell", spell_id)
    if not gid then return -1 end
    local r = services.spells.get(actor, gid)
    if not r.ok or not r.value then return -1 end
    return r.value.experience or 0
end
H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end
H.char_spell_level_sum = function(actor, school_id)
    if not actor then return 0 end
    local gid = nil
    if school_id and school_id ~= "" then
        gid = H.safe_id("mutation", school_id)
        if not gid then return 0 end
    end
    local r = services.spells.level_sum(actor, gid, 0)
    if not r.ok then return 0 end
    return r.value or 0
end
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
H.char_vitamin = function(actor, vitamin_id)
    if not actor then return 0 end
    local gid = H.safe_id("vitamin", vitamin_id)
    if not gid then return 0 end
    local r = services.needs.get_vitamin(actor, gid)
    if not r.ok then return 0 end
    return r.value or 0
end
H.chars_nearby = function(actor, rad, attitude)
    local s = H.char_snap(actor)
    if not s or not s.creature then return 0 end
    local r = services.characters.count_nearby(s.creature.position, { radius = math.floor(rad or 1000), attitude = attitude or "any" })
    if not r.ok then return 0 end
    return r.value or 0
end
H.clamp_num = function(v, lo, hi)
    if v < lo then return lo end
    if v > hi then return hi end
    return v
end
H.consume_item = function(actor, item_id, count, charges)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    services.inventory.consume_by_type(actor, gid, math.floor(count or 0), math.floor(charges or 0))
end
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
H.creature_weight = function(actor)
    if not actor then return 0 end
    local s = H.char_snap(actor)
    if s and s.carrying and s.carrying.weight_grams then return s.carrying.weight_grams * 1000 end
    local ir = services.items.snapshot(actor)
    if ir.ok and ir.value and ir.value.weight_grams then return ir.value.weight_grams * 1000 end
    return 0
end
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
H.eoc_cast_spell = function(actor, spell_id, is_monster, opts)
    if not actor then return end
    local gid = H.safe_id("spell", spell_id)
    if not gid then return end
    if is_monster then
        services.monsters.cast_spell(actor, gid, opts)
    else
        services.characters.cast_spell(actor, gid, opts)
    end
end
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
H.u = function(ctx)
    return ctx:speaker()
end
H.npc = function(ctx)
    return ctx:interlocutor()
end
H.resolve_var_ref = function(ctx, vname)
    if type(vname) ~= "string" or vname == "" then return "global", nil, "" end
    if string.sub(vname, 1, 2) == "u_" then return "actor", H.u(ctx), string.sub(vname, 3) end
    if string.sub(vname, 1, 2) == "n_" then return "actor", H.npc(ctx), string.sub(vname, 3) end
    if string.sub(vname, 1, 4) == "npc_" then return "actor", H.npc(ctx), string.sub(vname, 5) end
    if string.sub(vname, 1, 1) == "_" then return "context", nil, string.sub(vname, 2) end
    return "global", nil, vname
end
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
H.eoc_loc_var = function(actor, ctx, dst_scope, dst_key, om_sel, om_opts, wsel, wopts, adj, z_ovr, run_on_found, true_eocs, false_eocs)
    local base_pos = nil
    if ctx and ctx.proxy_pos and (actor == nil or actor == ctx.u) then
        base_pos = ctx.proxy_pos
    else
        local cs = H.creature_snap(actor)
        if not cs then
            for _, fe in ipairs(false_eocs or {}) do H.run_eoc(fe, ctx) end
            return false
        end
        base_pos = cs.position
    end
    local found = true
    if om_sel ~= nil then
        local omt = base_pos:project_to("omt")
        local tgt = services.overmap.find_target(omt, om_sel, om_opts)
        if tgt then
            base_pos = tgt:project_to("ms")
        else
            found = false
        end
    end
    if found and wsel ~= nil then
        local wr = services.world.find_location(base_pos, wsel, wopts or {})
        if wr.ok and wr.value and wr.value.position then
            base_pos = wr.value.position
        else
            found = false
        end
    elseif found and wopts and ((wopts.min_radius and wopts.min_radius > 0) or (wopts.max_radius and wopts.max_radius > 0) or wopts.outdoor_only or wopts.passable_only) then
        local wr = services.world.find_location(base_pos, nil, wopts)
        if wr.ok and wr.value and wr.value.position then
            base_pos = wr.value.position
        else
            found = false
        end
    end
    if not found then
        for _, fe in ipairs(false_eocs or {}) do H.run_eoc(fe, ctx) end
        return false
    end
    if adj then
        local x = (base_pos.x or 0) + (adj.dx or 0)
        local y = (base_pos.y or 0) + (adj.dy or 0)
        local z = z_ovr and (adj.dz or 0) or ((base_pos.z or 0) + (adj.dz or 0))
        base_pos = services.coords.tripoint_abs_ms(x, y, z)
    end
    H.set_var(dst_scope, actor, ctx, dst_key, base_pos)
    for _, te in ipairs(true_eocs or {}) do H.run_eoc(te, ctx) end
    return true
end
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
H.item_matches_search = function(snap, crit)
    if not crit then return true end
    if crit.id and snap.id and snap.id.value ~= crit.id then return false end
    if crit.category and snap.category ~= crit.category then return false end
    if crit.worn_only and snap.location_kind ~= "worn" then return false end
    if crit.wielded_only and snap.location_kind ~= "wielded" then return false end
    return true
end
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
                if H.item_matches_search(snap, crit) then ok_match = true break end
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
H.eoc_run_inv_eocs = function(actor, ctx, mode, title, search_list, true_eocs, false_eocs)
    if not actor then return end
    local matches = {}
    local cont = nil
    for _ = 1, 32 do
        local p = services.inventory.carried_items(actor)
        local pr = services.items.page({ character = actor }, { page_size = 256 }, cont)
        if not pr.ok or not pr.value then break end
        for _, item in ipairs(pr.value.items or {}) do
            local ok_match = (not search_list or #search_list == 0)
            if not ok_match then
                local sr = services.items.snapshot(item)
                local snap = sr.ok and sr.value or {}
                for _, crit in ipairs(search_list) do
                    if H.item_matches_search(snap, crit) then
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
        if not pr.value.has_more then break end
        cont = pr.value.continuation
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
H.field_strength = function(actor, fid, loc)
    local pos = loc
    if not pos then
        local cs = H.creature_snap(actor)
        if cs then pos = cs.position end
    end
    if not pos then return 0 end
    local gid = H.safe_id("field", fid)
    if not gid then return 0 end
    local r = services.world.field_strength(pos, gid)
    return (r.ok and r.value) or 0
end
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
H.lose_trait = function(actor, trait_id)
    if not actor then return end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return end
    services.mutations.erase(actor, gid)
end
H.mutate_towards = function(actor, trait_id, cat_id, use_vitamins)
    if not actor then return end
    local tgid = H.safe_id("mutation", trait_id)
    if not tgid then return end
    local cgid = nil
    if cat_id and cat_id ~= "" and cat_id ~= "ANY" then
        cgid = H.safe_id("mutation_category", cat_id)
    end
    services.mutations.mutate_towards(actor, tgid, cgid, use_vitamins == true)
end
H.resolve_event_actors = function(payload)
    local actors = (payload and payload.actors) or {}
    local u = actors.speaker or actors.avatar_id or actors.character
        or actors.attacker or actors.killer or actors.npc
    if not u then
        u = services.characters.avatar()
    end
    local npc = actors.interlocutor or actors.item or actors.victim or nil
    local vars = {}
    if payload and payload.data then
        for k, v in pairs(payload.data) do
            vars[k] = v
        end
    end
    return u, npc, vars
end
H.round_half_away = function(v)
    if v >= 0 then return math.floor(v + 0.5) end
    return math.ceil(v - 0.5)
end
H.set_bionic_power = function(actor, val, op)
    if not actor then return end
    local cur = H.char_bionic_power(actor, "power")
    local target = val
    if op == "+=" then target = cur + val
    elseif op == "-=" then target = cur - val
    elseif op == "*=" then target = cur * val
    elseif op == "/=" then target = cur / val
    end
    services.bionics.set_power(actor, services.units.new("energy", math.floor(target + 0.5), "millijoule"))
end
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
H.set_spell_adj = function(actor, prop, school, spell_id, mod_op, val, op)
    if not actor then return end
    if prop == "level" and school and school ~= "" and (not mod_op or mod_op == "+") then
        local gid = H.safe_id("mutation", school)
        if gid then
            local cur = 0
            local r = services.spells.school_level_adjustment(actor, gid)
            if r.ok and r.value then cur = r.value end
            local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or (cur - val))
            services.spells.set_school_level_adjustment(actor, gid, nxt)
        end
        return
    end
    local opts = {}
    if mod_op and mod_op ~= "" then opts.op = mod_op end
    if spell_id and spell_id ~= "" then opts.spell = H.safe_id("spell", spell_id) end
    if school and school ~= "" then opts.school = H.safe_id("mutation", school) end
    if opts.mod_op == nil then end
    local delta = (op == "-=") and -val or val
    pcall(services.spells.adjust_casting, actor, prop, delta, opts)
end
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
H.truthy = function(v)
    return v ~= false and v ~= nil and v ~= 0
end
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
H.var_num = function(actor, key)
    if not actor then return 0 end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
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
H.weather_val = function(prop)
    local w = services.weather.current()
    if not w then return 0 end
    if prop == "temperature" then return (w.precise and w.precise.temperature and w.precise.temperature:value("kelvin")) or (w.temperature and w.temperature:value("kelvin")) or 0 end
    if prop == "windpower" or prop == "wind" then return (w.precise and w.precise.wind_speed_mph) or w.wind_speed_mph or 0 end
    if prop == "humidity" then return (w.precise and w.precise.humidity) or 0 end
    if prop == "pressure" then return (w.precise and w.precise.pressure) or 0 end
    if prop == "precipitation" then return (w.precise and w.precise.precipitation_mm_per_hour) or 0 end
    return 0
end
H._jm_channeling_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_channel_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_channel_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_channel_master", "percent") / 1000)))
end
H._jm_enhancement_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_enhancement_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_master", "percent") / 1000)))
end
H._jm_limit_caster_level_boost = function(ctx, _a0, _a1)
    return math.floor(math.min(_a0, (1 + (_a1 / 5))))
end
H._jm_magiclysm_spell_failure_transformation_proficiency_adjustments_damage_npc = function(ctx)
    return (((1 + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_beginner").value) == true) and 1 or 0))) and (0.1) or (0))) + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_apprentice").value) == true) and 1 or 0))) and (0.15) or (0))) + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_master").value) == true) and 1 or 0))) and (0.2) or (0)))
end
H._jm_mc_spell_cost_train_factor = function(ctx, _a0, _a1, _a2)
    return math.max(_a1, math.min(_a2, (_a2 - ((((_a1 * math.max(0, _a0)) / H.char_mana(H.u(ctx), "maximum")) * _a2) / _a1))))
end
H._jm_mc_spell_train_focus_factor = function(ctx, _a0, _a1)
    return (((_a1 > 15)) and ((((math.max(20, _a0) - 50) / 100) + 0.5)) or (1))
end
H._jm_summoning_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_summon_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_summon_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_summon_master", "percent") / 1000)))
end
H._jm_transformation_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_transformation_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_transformation_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_transformation_master", "percent") / 1000)))
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)

-- Generic EOC runtime handlers for cross-mod & scheduled calls
for eid, fn in pairs(E.run) do
    ccb.runtime.handler("eoc:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        fn(H.ctx_new(u, npc, vars))
    end)
end
for eid, cfn in pairs(E.cond) do
    ccb.runtime.handler("eoc_test:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        return cfn(H.ctx_new(u, npc, vars)) == true
    end)
end

-- EVENT triggers
ccb.runtime.handler("eoc_ev:avatar_enters_omt", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DRUID_TRAVERSE_THE_WILDS_REMOVER", ctx)
    H.run_eoc("EOC_EARTHSHAPER_DANGERSENSE_CHECKER", ctx)
    H.run_eoc("EOC_EARTHSHAPER_SLEEP_IN_EARTH_REMOVER", ctx)
    H.run_eoc("EOC_CLOAK_OF_ELVENKIND_TURN_ON", ctx)
    H.run_eoc("EOC_CLOAK_OF_ELVENKIND_TURN_OFF", ctx)
    H.run_eoc("EOC_DRUID_WATERWALKING_REMOVERE", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_casts_spell", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_ATTUNED", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_BIOTEK", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_CLASSLESS", ctx)
end)
ccb.runtime.on("game:character_casts_spell", "eoc_ev:character_casts_spell")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DISPEL_MAGIC_REMOVE_ITEMS", ctx)
    H.run_eoc("EOC_DISJUNCTION_REMOVE_ITEMS", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ANIMIST_SPIRIT_WALKING_LOSE_APPEARANCE", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_MELEE_CHARACTER_REMOVE_INVISIBILITY_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_MELEE_MONSTER_REMOVE_INVISIBILITY_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_takeoff_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_UNWEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_UNWEARING", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_FISH_REMOVE", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR_REMOVE", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_DEER_FOLLOWUP", ctx)
end)
ccb.runtime.on("game:character_takeoff_item", "eoc_ev:character_takeoff_item")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGUS_STOP_ATTACK_SHIELD", ctx)
    H.run_eoc("EOC_MAGICLYSM_ORB_OF_LIGHT_CLASSLESS_REMOVED_ON_DAMAGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wears_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_WEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_WEARING", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_FISH", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_DEER", ctx)
    H.run_eoc("EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE", ctx)
end)
ccb.runtime.on("game:character_wears_item", "eoc_ev:character_wears_item")
ccb.runtime.handler("eoc_ev:character_wields_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_WIELDING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_WIELDING", ctx)
end)
ccb.runtime.on("game:character_wields_item", "eoc_ev:character_wields_item")
ccb.runtime.handler("eoc_ev:game_avatar_new", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MANA_LEECH_START", ctx)
end)
ccb.runtime.on("game:game_avatar_new", "eoc_ev:game_avatar_new")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_RAVENFOLK_HOARDER_UPDATE", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FORGE_GAME_LOAD", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_GAME_START", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_magus_caster_level_boost", ctx)
    H.run_eoc("EOC_kelvinist_caster_level_boost", ctx)
    H.run_eoc("EOC_technomancer_caster_level_boost", ctx)
    H.run_eoc("EOC_biomancer_caster_level_boost", ctx)
    H.run_eoc("EOC_animist_caster_level_boost", ctx)
    H.run_eoc("EOC_stormshaper_caster_level_boost", ctx)
    H.run_eoc("EOC_earthshaper_caster_level_boost", ctx)
    H.run_eoc("EOC_druid_caster_level_boost", ctx)
    H.run_eoc("EOC_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_MAGICLYSM_BROKEN_LIMBS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_THAUMIC_ZOMBIES_INCREASE_DIFFICULTY", ctx)
    H.run_eoc("EOC_NO_CASTING_ENERVATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_CONVEYANCE_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_RESTORATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_TRANSFORMATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_FOR_EMPTY", ctx)
    H.run_eoc("EOC_MANA_OVERLOAD_MAKES_SPELLS_MORE_DIFFICULT", ctx)
    H.run_eoc("EOC_ARCHMAGE_BENEFITS_PROGRESSIVE_SCHOOL_DIFFICULTY_REDUCTIONS", ctx)
    H.run_eoc("EOC_perk_caster_level_up_animist", ctx)
    H.run_eoc("EOC_perk_caster_level_up_biomancer", ctx)
    H.run_eoc("EOC_perk_caster_level_up_druid", ctx)
    H.run_eoc("EOC_perk_caster_level_up_earthshaper", ctx)
    H.run_eoc("EOC_perk_caster_level_up_kelvinist", ctx)
    H.run_eoc("EOC_perk_caster_level_up_magus", ctx)
    H.run_eoc("EOC_perk_caster_level_up_stormshaper", ctx)
    H.run_eoc("EOC_perk_caster_level_up_technomancer", ctx)
    H.run_eoc("EOC_MAGICLYSM_SI_PRE_TELEPORT_LOCATION_CHECKING", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MANA_FLASH_SPELLCASTING_FINISH", ctx)
    H.run_eoc("EOC_MANA_LUM_EXTERNAL_SPELLCASTING_FINISH", ctx)
    H.run_eoc("EOC_technomancer_caster_level_boost_finish_casting", ctx)
    H.run_eoc("EOC_BIOMANCY_IS_DISTURBING", ctx)
    H.run_eoc("EOC_MAGICLYSM_SI_PRE_TELEPORT_POWER_CHECKING", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_DUST_REBORN", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ARTIFICER") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", "eoc_int:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING")
ccb.runtime.handler("eoc_rec:EOC_GIVE_FROZEN_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_FROZEN_PRESSURE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "GLACIER_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_FROZEN_PRESSURE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_FROZEN_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_FROZEN_PRESSURE_OFF", "eoc_int:EOC_GIVE_FROZEN_PRESSURE_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_CLAIRVOYANCE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_CLAIRVOYANCE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "RADIATION_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_CLAIRVOYANCE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_CLAIRVOYANCE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_CLAIRVOYANCE_OFF", "eoc_int:EOC_GIVE_CLAIRVOYANCE_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_MIND_READ", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_MIND_READ"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SHAMAN") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_MIND_READ", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_MIND_READ", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_MIND_READ", "eoc_int:EOC_GIVE_MIND_READ")
ccb.runtime.handler("eoc_rec:EOC_GIVE_SOUL_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_SOUL_PRESSURE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SOULFIRE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_SOUL_PRESSURE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_SOUL_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_SOUL_PRESSURE_OFF", "eoc_int:EOC_GIVE_SOUL_PRESSURE_OFF")
ccb.runtime.handler("eoc_rec:SUN_MAGE_BUFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:SUN_MAGE_BUFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SUN_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("SUN_MAGE_BUFF", ctx)
end)
ccb.runtime.handler("eoc_int:SUN_MAGE_BUFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:SUN_MAGE_BUFF", "eoc_int:SUN_MAGE_BUFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_FREEZING_AURA_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_FREEZING_AURA_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "TUNDRA_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_FREEZING_AURA_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_FREEZING_AURA_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_FREEZING_AURA_OFF", "eoc_int:EOC_GIVE_FREEZING_AURA_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_TOXIC_AURA_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_TOXIC_AURA_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "WITHER_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_TOXIC_AURA_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_TOXIC_AURA_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_TOXIC_AURA_OFF", "eoc_int:EOC_GIVE_TOXIC_AURA_OFF")
ccb.runtime.handler("eoc_rec:EOC_PLAYER_IN_FORGE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PLAYER_IN_FORGE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_PLAYER_IN_FORGE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PLAYER_IN_FORGE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1800)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PLAYER_IN_FORGE", "eoc_int:EOC_PLAYER_IN_FORGE")
ccb.runtime.handler("eoc_rec:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", "eoc_int:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE")
ccb.runtime.handler("eoc_rec:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(10), math.floor(10); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", "eoc_int:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER")
ccb.runtime.handler("eoc_rec:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", "eoc_int:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_MANA_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_mana") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_MANA_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_MANA_MUTATOR")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", function(_)
    local dk = "eoc_deact:EOC_MANA_LEECH_PLAYER_NOT_WORN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_MANA_LEECH_PLAYER_NOT_WORN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_MANA_LEECH_PLAYER_NOT_WORN") then
        ccb.state.world.set("eoc_glob_started:EOC_MANA_LEECH_PLAYER_NOT_WORN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
