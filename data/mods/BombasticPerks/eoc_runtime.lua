local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }

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
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end
H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
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
H.char_pain = function(actor)
    local s = H.char_snap(actor)
    if not s or not s.creature then return 0 end
    return s.creature.pain or 0
end
H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
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
H.chars_nearby = function(actor, rad, attitude)
    local s = H.char_snap(actor)
    if not s or not s.creature then return 0 end
    local r = services.characters.count_nearby(s.creature.position, { radius = math.floor(rad or 1000), attitude = attitude or "any" })
    if not r.ok then return 0 end
    return r.value or 0
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
H.moon_phase = function()
    local cal = services.time.calendar()
    local sl = (cal and cal.season_length and cal.season_length.turns) or 7862400
    local moon_dur = (sl / 7862400.0) * (29.530588 * 86400)
    if moon_dur <= 0 then return 0 end
    local tz = (cal and cal.turn_zero and cal.turn_zero.turn) or 0
    local now = services.turn()
    local num_middays = math.floor((now - tz + 43200) / 86400)
    local nearest_mid = num_middays * 86400
    local phase_change = nearest_mid / moon_dur
    return math.floor(phase_change * 8 + 0.5) % 8
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
H.species_nearby = function(actor, species_ids, rad, loc)
    local pos = loc
    if not pos then
        local cs = H.creature_snap(actor)
        if cs then pos = cs.position end
    end
    if not pos then return 0 end
    local gids = {}
    for _, sp in ipairs(species_ids) do
        local g = H.safe_id("species", sp)
        if g then table.insert(gids, g) end
    end
    if #gids == 0 then return 0 end
    local r = services.monsters.count_species_nearby(pos, gids, { radius = math.floor(rad or 1000), attitude = "both" })
    return (r.ok and r.value) or 0
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

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)

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
    H.run_eoc("EOC_perk_duck_and_weave", ctx)
    H.run_eoc("EOC_perk_duck_and_weave_reset", ctx)
    H.run_eoc("EOC_PERK_PERCUSSIVE_ENTRY_LOSE_BONUS_WHEN_MOVING", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_consumes_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_SOUP_FOR_SOUL_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_consumes_item", "eoc_ev:character_consumes_item")
ccb.runtime.handler("eoc_ev:character_eats_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_blood_drinking_heal", ctx)
end)
ccb.runtime.on("game:character_eats_item", "eoc_ev:character_eats_item")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL", ctx)
    H.run_eoc("EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND", ctx)
    H.run_eoc("EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND_BUT_HAS_DREAM_ARMOR", ctx)
    H.run_eoc("EOC_PERK_QUICK_RECOVERY_INIT", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_kills_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_on_kill_check_exp", ctx)
    H.run_eoc("EOC_empath", ctx)
    H.run_eoc("EOC_praise", ctx)
end)
ccb.runtime.on("game:character_kills_monster", "eoc_ev:character_kills_monster")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_bellringer_application_character", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_character", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_bellringer_application_monster", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_monster", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("event_perk_dice_addition_damage_ranged_attacks_character", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_character_ranged", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_character", "eoc_ev:character_ranged_attacks_character")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("event_perk_dice_addition_damage_ranged_attacks_monster", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_monster_ranged", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_monster", "eoc_ev:character_ranged_attacks_monster")
ccb.runtime.handler("eoc_ev:character_smashes_tile", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_PERCUSSIVE_ENTRY_SMASHING", ctx)
end)
ccb.runtime.on("game:character_smashes_tile", "eoc_ev:character_smashes_tile")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_boomstick_blast_character", ctx)
    H.run_eoc("EOC_PERK_SITUATIONAL_UNCANNY_DODGE_TAKE_DAMAGE", ctx)
    H.run_eoc("EOC_PERK_FIRSTEST_AID", ctx)
    H.run_eoc("EOC_PERK_TWICE_SHY_TAKE_DAMAGE", ctx)
    H.run_eoc("EOC_PERK_UNDYING_LOYALTY", ctx)
    H.run_eoc("EOC_PERK_VENGEFUL_TAKE_DAMAGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wakes_up", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_NETHER_ATTENTION_NIGHTMARES", ctx)
end)
ccb.runtime.on("game:character_wakes_up", "eoc_ev:character_wakes_up")
ccb.runtime.handler("eoc_ev:gains_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_LEARN_EWWWW_DE_ZOMBIE_GAIN_RECIPE", ctx)
end)
ccb.runtime.on("game:gains_mutation", "eoc_ev:gains_mutation")
ccb.runtime.handler("eoc_ev:game_avatar_new", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_bombastic_perks_avatar_new", ctx)
end)
ccb.runtime.on("game:game_avatar_new", "eoc_ev:game_avatar_new")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_bombastic_perks_initialize", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_EXISTING_CHARACTER_UPDATE_BOMBASTIC_PERKS", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:monster_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_boomstick_blast_monster", ctx)
    H.run_eoc("EOC_EWWWW_DE_ZOMBIE_ATTACK_ZOMBIE_SUPPRESSOR", ctx)
    H.run_eoc("EOC_HIVE_QUEEN_ATTACK_INSECT_SUPPRESSOR", ctx)
end)
ccb.runtime.on("game:monster_takes_damage", "eoc_ev:monster_takes_damage")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_PERK_SECOND_CHANCE_PREVENTION", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_PERK_MOONSTRUCK", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_MOONSTRUCK"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_moonstruck") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_MOONSTRUCK", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_MOONSTRUCK", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_MOONSTRUCK", "eoc_int:EOC_PERK_MOONSTRUCK")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_bird") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_feline") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_insect") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_lupine") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_plant") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_spider") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR")

return E
