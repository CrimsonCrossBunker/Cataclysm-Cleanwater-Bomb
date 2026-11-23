local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
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
H.add_proficiency_progress = function(actor, prof_id, val, fmt, is_direct, op)
    if not actor then return end
    local gid = H.safe_id("proficiency", prof_id)
    if not gid then return end
    local def = services.proficiencies.definition(gid)
    local total_turns = (def and def.time_to_learn and def.time_to_learn.turns) or 0
    local delta_or_abs = val
    if fmt == "percent" then
        delta_or_abs = total_turns * val / 100.0
    elseif fmt == "permille" then
        delta_or_abs = total_turns * val / 1000.0
    end
    local cur = H.char_proficiency(actor, prof_id, "time_spent")
    local target = cur
    if op == "=" then target = delta_or_abs
    elseif op == "+=" then target = cur + delta_or_abs
    elseif op == "-=" then target = cur - delta_or_abs
    elseif op == "*=" then target = cur * delta_or_abs
    elseif op == "/=" then target = cur / delta_or_abs
    end
    if not is_direct then
        local delta = target - cur
        if delta < 1 then return end
        local sr = services.characters.snapshot(actor)
        local snap = sr and sr.ok and sr.value or nil
        local eff_focus = (snap and snap.needs and snap.needs.effective_focus) or (snap and snap.needs and snap.needs.focus) or 100
        if not (def and def.ignore_focus) then
            delta = delta * (math.max(0, eff_focus) / 100.0)
        end
        target = cur + delta
    end
    local turns = math.floor(target + 0.5)
    if fmt == "time_left" and total_turns > 0 then
        turns = math.floor(total_turns - target + 0.5)
    end
    services.proficiencies.set_practiced_time(actor, gid, services.time.duration_from_turns(turns))
end
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
H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
    return r.ok and r.value == true
end
H.char_has_items = function(actor, item_id, count, charges)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_items(actor, gid, count, charges)
    return r.ok and r.value == true
end
H.char_has_mission = function(actor, mission_id)
    if not actor then return false end
    local gid = H.safe_id("mission", mission_id)
    if not gid then return false end
    local r = services.missions.has_active(actor, gid)
    return r.ok and r.value == true
end
H.char_health = function(actor)
    if not actor then return 0 end
    local r = services.needs.get(actor)
    return (r.ok and r.value and r.value.lifestyle) or 0
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
H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then return 0 end
    return r.value or 0
end
H.char_skill_exp = function(actor, skill_id, raw)
    if not actor then return 0 end
    local gid = H.safe_id("skill", skill_id)
    if not gid then return 0 end
    local r = services.skills.get(actor, gid)
    if not r.ok or not r.value then return 0 end
    if raw then return r.value.practical_exercise_raw or 0 end
    return r.value.practical_exercise_percent or 0
end
H.char_spell_difficulty = function(actor, spell_id, baseline)
    if not actor then return 0 end
    local gid = H.safe_id("spell", spell_id)
    if not gid then return 0 end
    local r = services.spells.difficulty(actor, gid, baseline == true)
    if not r.ok or r.value == nil then return 0 end
    return r.value
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
H.coord_get = function(scope, actor, ctx, key, axis)
    local tp = H.get_tripoint_var(scope, actor, ctx, key)
    if not tp then return 0 end
    return tp[axis] or 0
end
H.is_avatar = function(actor)
    if not actor then return false end
    if actor.subtype ~= nil then return actor.subtype == "avatar" end
    local s = H.char_snap(actor)
    return s ~= nil and s.avatar == true
end
H.set_var_indirect = function(ctx, ind_key, val)
    local sc, act, key = H.resolve_var_ref(ctx, ind_key)
    if key == "" then return end
    return H.set_var(sc, act, ctx, key, val)
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
H.coord_set = function(scope, actor, ctx, key, axis, val, op)
    local tp = H.get_tripoint_var(scope, actor, ctx, key)
    if not tp then
        tp = services.coords.tripoint_abs_ms(0, 0, 0)
    end
    local x, y, z = tp.x or 0, tp.y or 0, tp.z or 0
    local cur = (axis == "x") and x or ((axis == "y") and y or z)
    local nxt = val
    if op == "+=" then nxt = cur + val
    elseif op == "-=" then nxt = cur - val
    elseif op == "*=" then nxt = cur * val
    elseif op == "/=" then nxt = cur / val
    elseif op == "%=" then nxt = cur % val
    end
    nxt = math.floor(nxt + 0.5)
    if axis == "x" then x = nxt elseif axis == "y" then y = nxt else z = nxt end
    local out = services.coords.tripoint_abs_ms(x, y, z)
    H.set_var(scope, actor, ctx, key, out)
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
H.eoc_run_fixed_zone_eocs = function(actor, ctx, eids, range_val, zmin, zmax)
    local cs = H.creature_snap(actor)
    if not cs then return end
    local apos = cs.position
    local r = services.zones.list({ kind = "global", limit = 256 })
    if not r or not r.ok or not r.value or not r.value.items then return end
    for _, z in ipairs(r.value.items) do
        local zpos = z.start
        if zpos then
            local ok_z = true
            if zmin ~= nil and (zpos.z or 0) < math.floor(zmin) then ok_z = false end
            if zmax ~= nil and (zpos.z or 0) > math.floor(zmax) then ok_z = false end
            if ok_z and range_val ~= nil then
                local dist = math.max(math.abs((apos.x or 0) - (zpos.x or 0)), math.abs((apos.y or 0) - (zpos.y or 0)), math.abs((apos.z or 0) - (zpos.z or 0)))
                if dist > math.floor(range_val) then ok_z = false end
            end
            if ok_z then
                local sub = H.ctx_new(ctx and ctx.u or actor, nil, ctx and ctx.vars or {}, {
                    proxy_pos = zpos,
                    proxy_teleport = function(dest, _)
                        local dx = (dest.x or 0) - (zpos.x or 0)
                        local dy = (dest.y or 0) - (zpos.y or 0)
                        local dz = (dest.z or 0) - (zpos.z or 0)
                        local s = services.coords.tripoint_abs_ms((z.start.x or 0) + dx, (z.start.y or 0) + dy, (z.start.z or 0) + dz)
                        local e_pt = z["end"]
                        local e = services.coords.tripoint_abs_ms((e_pt.x or 0) + dx, (e_pt.y or 0) + dy, (e_pt.z or 0) + dz)
                        services.zones.set_position(z.token, s, e)
                    end
                })
                for _, eid in ipairs(eids) do H.run_eoc(eid, sub) end
            end
        end
    end
end
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
H.eoc_run_vehicle_eocs = function(actor, ctx, eids, range_val, zmin, zmax)
    local cs = H.creature_snap(actor)
    if not cs then return end
    local opts = { center = cs.position }
    if range_val ~= nil then opts.radius = math.floor(range_val) end
    if zmin ~= nil then opts.z_min = math.floor(zmin) end
    if zmax ~= nil then opts.z_max = math.floor(zmax) end
    local r = services.vehicles.loaded(opts)
    if not r or not r.ok or not r.value or not r.value.items then return end
    for _, item in ipairs(r.value.items) do
        local sub = H.ctx_new(ctx and ctx.u or actor, nil, ctx and ctx.vars or {}, {
            proxy_pos = item.position,
            proxy_teleport = function(dest, tp_opts)
                services.vehicles.teleport(item.handle, dest, tp_opts)
            end
        })
        for _, eid in ipairs(eids) do H.run_eoc(eid, sub) end
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
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
H.learn_recipe = function(actor, rid)
    if not actor then return end
    local gid = H.safe_id("recipe", rid)
    if not gid then return end
    services.recipes.learn(actor, gid)
end
H.lose_trait = function(actor, trait_id)
    if not actor then return end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return end
    services.mutations.erase(actor, gid)
end
H.mons_nearby = function(actor, ids, rad, loc)
    local pos = loc
    if not pos then
        local cs = H.creature_snap(actor)
        if cs then pos = cs.position end
    end
    if not pos then return 0 end
    local gids = nil
    if ids and #ids > 0 then
        gids = {}
        for _, id in ipairs(ids) do
            local g = H.safe_id("monster", id)
            if g then table.insert(gids, g) end
        end
    end
    local r = services.monsters.count_nearby(pos, gids, { radius = math.floor(rad or 1000), attitude = "both" })
    return (r.ok and r.value) or 0
end
H.npc_allies_global = function(min_count)
    return services.npcs.count_allies(true) >= min_count
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
H.set_char_health = function(actor, val, op)
    if not actor then return end
    local cur = H.char_health(actor)
    local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or ((op == "*=") and (cur * val) or (cur / val))))
    services.needs.modify_health(actor, { lifestyle = math.floor(nxt - cur + 0.5) })
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
H.time_since = function(point_turns, unit_div)
    if point_turns == nil then return -1 end
    local diff = services.turn() - point_turns
    if unit_div and unit_div ~= 1 then return diff / unit_div end
    return diff
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
H.var_num_opt = function(actor, key)
    if not actor then return nil end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return nil end
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
H._jm_afs_hack_bonus = function(ctx, _a0, _a1)
    return (_a0 + ((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((4 * ((_a1 - 100) / 100)))))
end
H._jm_afs_hack_skill = function(ctx, _a0)
    return (((H.char_skill(H.u(ctx), "computer") + ((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 3)) + H.var_num(H.u(ctx), "hack_bonus")) * _a0)
end
H._jm_afs_hack_time_adjust = function(ctx, _a0, _a1, _a2)
    return ((((_a0 - (_a1 * H._jm_afs_hack_skill(ctx, 1))) < _a2)) and (_a2) or ((_a0 - (_a1 * H._jm_afs_hack_skill(ctx, 1)))))
end
H._jm_concentration_calculations = function(ctx)
    return ((((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 4) + H.var_num(H.u(ctx), "bonus_concentration_powers")) + H._jm_concentration_trait_bonuses(ctx))
end
H._jm_concentration_trait_bonuses = function(ctx)
    return (((((((((((((((((((((((H.char_has_trait(H.u(ctx), "INT_ALPHA") + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD2"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD3"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "PER_SLIME"))) and ((-15)) or (0))) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0) * 2)) + (((H.creature_effect_intensity(H.u(ctx), "hallu") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "winded") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 3)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "cold") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "hot") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "asthma") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "datura") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed_zap") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "downed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "boomered") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "conjunctivitis") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "teargas") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_eyes") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_lungs") > 0)) and ((-2)) or (0)))
end
H._jm_esper_potential_trait_handling = function(ctx)
    return ((H.truthy(H.char_has_trait(H.u(ctx), "ESPER_ADVANCEMENT_OKAY"))) and (1) or (((H.truthy(H.char_has_trait(H.u(ctx), "ESPER_STARTER_ADVANCEMENT_OKAY"))) and (1) or (0))))
end
H._jm_psionic_power_experience_formula_maintenance = function(ctx)
    return ((((((((H.char_snap(H.u(ctx)) or {}).needs or {}).effective_focus or 0) / 100) * 80) * (((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * math.min((0.5 + (H.char_skill(H.u(ctx), "metaphysics") / 20)), 1)) * H._jm_esper_potential_trait_handling(ctx))
end
H._jm_psionics_weariness_calculations = function(ctx, _a0)
    return ((12 * _a0) * services.random.native_float(0.3, 1.6))
end
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
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
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_JETPACK_RUN_ACTIVE", ctx)
    H.run_eoc("EOC_JETPACK_RUN_DEACTIVATE", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:broken_bone", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_ESPER_BROKEN_LIMB_ENDS_POWERS", ctx)
end)
ccb.runtime.on("game:broken_bone", "eoc_ev:broken_bone")
ccb.runtime.handler("eoc_ev:character_armor_destroyed", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_detonate_shield", ctx)
end)
ccb.runtime.on("game:character_armor_destroyed", "eoc_ev:character_armor_destroyed")
ccb.runtime.handler("eoc_ev:character_consumes_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_STIMPACK", ctx)
end)
ccb.runtime.on("game:character_consumes_item", "eoc_ev:character_consumes_item")
ccb.runtime.handler("eoc_ev:character_finished_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_check_drop_shield_gen", ctx)
    H.run_eoc("EOC_AFS_PRECOG_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING", ctx)
end)
ccb.runtime.on("game:character_finished_activity", "eoc_ev:character_finished_activity")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_MEDIGEL_ADD", ctx)
    H.run_eoc("EOC_AFS_ESPER_SLEEP_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_WINDED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_STUNNED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_DAZED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_WEARINESS_ENDS_POWERS", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_MEDIGEL_REMOVE", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_starts_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_PRECOG_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING", ctx)
end)
ccb.runtime.on("game:character_starts_activity", "eoc_ev:character_starts_activity")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_PRECOG_FOREWARNING_REMOVE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_FIND_PORT_AUGUSTMOON", ctx)
    H.run_eoc("EOC_AFS_FIND_LANDING_PAD", ctx)
    H.run_eoc("EOC_AFS_ELECTROKINETIC_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_PRECOG_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_TELEKINETIC_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_TELEPATH_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_ESPER_OLD_EFFECTS_REMOVAL", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_UPGRADE_ESPERS_ON_LOAD", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_UPGRADE_ESPERS_ON_GAME_START", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_ESPER_CHANNEL_COSTS_FOCUS", ctx)
    H.run_eoc("EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER", ctx)
    H.run_eoc("EOC_AFS_PSI_MAKES_YOU_WEARY", ctx)
    H.run_eoc("EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER", ctx)
    H.run_eoc("EOC_AFS_PSIONICS_ADVERSE_EVENTS", ctx)
    H.run_eoc("EOC_AFS_PSI_SKILL_INCREASE_ON_USE_INITIALIZE", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("afs_eoc_blood_brain_heal", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- AVATAR_DEATH subscribers
ccb.runtime.handler("eoc_ev:avatar_death", function(payload)
    local ctx = H.ctx_new(nil, nil, {}, { avatar_death = payload })
    H.run_eoc("EOC_AFS_LEADERSHIP_SWITCH", ctx)
end)
ccb.runtime.on("avatar_death", "eoc_ev:avatar_death")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:afs_spot_spaceport", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:afs_spot_spaceport"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("afs_spot_spaceport", ctx)
end)
ccb.runtime.handler("eoc_int:afs_spot_spaceport", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:afs_spot_spaceport", "eoc_int:afs_spot_spaceport")
ccb.runtime.handler("eoc_rec:afs_night_messages", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:afs_night_messages"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("afs_night_messages", ctx)
end)
ccb.runtime.handler("eoc_int:afs_night_messages", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:afs_night_messages", "eoc_int:afs_night_messages")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", function(_)
    local dk = "eoc_deact:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", function(_)
    local dk = "eoc_deact:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SPAWN_SHADOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(32400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER") then
        ccb.state.world.set("eoc_glob_started:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER") then
        ccb.state.world.set("eoc_glob_started:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
