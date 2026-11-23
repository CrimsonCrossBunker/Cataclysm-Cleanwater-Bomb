local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end
H.add_bionic = function(actor, bid)
    if not actor then return end
    local gid = H.safe_id("bionic", bid)
    if not gid then return end
    services.bionics.grant(actor, gid)
end
H.char_addiction = function(actor, add_id, field)
    if not actor then return 0 end
    local gid = H.safe_id("addiction", add_id)
    if not gid then return 0 end
    local r = services.addictions.get(actor, gid)
    if not r.ok or not r.value then return 0 end
    if field == "turns" then return r.value.turns or 0 end
    return r.value.intensity or 0
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
H.char_effect_dur = function(actor, eff_id, bp)
    if not actor then return 0 end
    local gid = H.safe_id("effect", eff_id)
    if not gid then return 0 end
    local bpg = (bp and bp ~= "") and H.safe_id("body_part", bp) or nil
    local r = services.effects.get(actor, gid, bpg)
    if not r.ok or not r.value or not r.value.duration then return 0 end
    return r.value.duration.turns or 0
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
H.char_is_wearing = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.is_wearing(actor, gid)
    return r.ok and r.value == true
end
H.char_know_recipe = function(actor, recipe_id)
    if not actor then return false end
    local gid = H.safe_id("recipe", recipe_id)
    if not gid then return false end
    local r = services.recipes.knows(actor, gid)
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
H.char_spell_count = function(actor, school_id)
    if not actor then return 0 end
    local gid = nil
    if school_id and school_id ~= "" then
        gid = H.safe_id("mutation", school_id)
        if not gid then return 0 end
    end
    local r = services.spells.count(actor, gid)
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
H.char_sum_traits_cat = function(actor, category_id, count_type)
    if not actor then return 0 end
    local gid = H.safe_id("mutation_category", category_id)
    if not gid then return 0 end
    local r = services.mutations.category_count(actor, gid, count_type or "ALL", true)
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
H.consume_item = function(actor, item_id, count, charges)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    services.inventory.consume_by_type(actor, gid, math.floor(count or 0), math.floor(charges or 0))
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
H.copy_var = function(src_scope, src_actor, src_key, dst_scope, dst_actor, dst_key, ctx)
    local val = nil
    if src_scope == "context" then
        val = ctx:get(src_key)
    elseif src_scope == "global" then
        local r = services.variables.get_global(src_key)
        if r.ok and r.value and r.value.exists then val = r.value.value end
    elseif src_actor then
        local r = services.variables.get(src_actor, src_key)
        if r.ok and r.value and r.value.exists then val = r.value.value end
    end
    H.set_var(dst_scope, dst_actor, ctx, dst_key, val)
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
H.creature_volume = function(actor)
    if not actor then return 0 end
    local r = services.creatures.volume_ml(actor)
    if r.ok and r.value then return r.value end
    local ir = services.items.snapshot(actor)
    if ir.ok and ir.value and ir.value.volume_ml then return ir.value.volume_ml end
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
H.lose_bionic = function(actor, bid)
    if not actor then return end
    local gid = H.safe_id("bionic", bid)
    if not gid then return end
    services.bionics.remove_type(actor, gid)
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
H.npc_snap = function(npc)
    if not npc then return nil end
    local r = services.npcs.get(npc)
    if not r.ok then return nil end
    return r.value
end
H.npc_mood_read = function(actor, field)
    local ns = H.npc_snap(actor)
    if not ns or not ns.opinion then return 0 end
    return ns.opinion[field] or 0
end
H.npc_mood_write = function(actor, field, val, op)
    if not actor then return end
    local cur = H.npc_mood_read(actor, field)
    local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or val))
    local delta = math.floor(nxt - cur + 0.5)
    services.npcs.modify_opinion(actor, { [field] = delta })
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
H.time_since = function(point_turns, unit_div)
    if point_turns == nil then return -1 end
    local diff = services.turn() - point_turns
    if unit_div and unit_div ~= 1 then return diff / unit_div end
    return diff
end
H.time_until_named = function(kind, is_since)
    local snap = services.time.snapshot()
    if not snap then return 0 end
    local now = snap.turn or 0
    if kind == "midnight" then
        return is_since and (now % 86400) or (86400 - (now % 86400))
    elseif kind == "noon" then
        local ret = now - ((snap.noon and snap.noon.turn) or 0)
        if not is_since and ret < 0 then ret = ret + 86400 end
        return ret
    end
    local target = nil
    if kind == "sunset" and snap.sunset then target = snap.sunset.turn
    elseif kind == "sunrise" and snap.sunrise then target = snap.sunrise.turn
    elseif kind == "night_time" and snap.nightfall then target = snap.nightfall.turn
    elseif kind == "daylight_time" and snap.daylight then target = snap.daylight.turn
    end
    if not target then return 0 end
    local ret = is_since and (now - target) or (target - now)
    if ret < 0 then ret = ret + 86400 end
    return ret
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
H._jm_addiction_rational = function(ctx, _a0, _a1, _a2)
    return ((_a0 / math.max(1, (_a0 - (_a1 * _a2)))) - 1)
end
H._jm_bloodthorn_druid_traits_sum = function(ctx)
    return (((((((((((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_REGAIN_BLOOD")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_BONUS_MANA_REGEN")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_STOP_BLEEDING")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SUMMON_THORNHOUND")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SLOWER_BLEEDING")) + H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_CREATE_THORN_PRISON"))
end
H._jm_bloodthorn_druid_traits_sum_as_npc = function(ctx)
    return (((((((((((H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_REGAIN_BLOOD")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_BONUS_MANA_REGEN")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_STOP_BLEEDING")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_SUMMON_THORNHOUND")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_SLOWER_BLEEDING")) + H.char_has_trait(H.npc(ctx), "BLOODTHORNE_DRUID_CREATE_THORN_PRISON"))
end
H._jm_lilin_has_ruach_efficiency = function(ctx)
    return (1 - math.min((((H.char_has_trait(H.u(ctx), "LILIN_RUACH_EFFICIENCY") * 0.15) + (H.char_has_trait(H.u(ctx), "LILIN_RUACH_EFFICIENCY_UPGRADE") * 0.15)) + (H.char_has_trait(H.u(ctx), "LILIN_RUACH_EFFICIENCY_UPGRADE") * math.max(((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") - 3500) / 12000), 0))), 0.33))
end
H._jm_paraclesian_post_threshold_doubler = function(ctx, _a0)
    return (_a0 + (1 * (((((H.char_has_trait(H.u(ctx), "THRESH_ARVORE") + H.char_has_trait(H.u(ctx), "THRESH_IERDE")) + H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS")) + H.char_has_trait(H.u(ctx), "THRESH_SALAMANDER")) + H.char_has_trait(H.u(ctx), "THRESH_SYLPH")) + H.char_has_trait(H.u(ctx), "THRESH_UNDINE"))))
end
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
end
H._jm_selkie_has_weather_mastery = function(ctx)
    return (1 + (H.char_has_trait(H.u(ctx), "SELKIE_CHANGE_WEATHER_MASTER") * 1.5))
end
H._jm_spell_train_factor = function(ctx, _a0)
    return (((H.char_has_trait(H.u(ctx), "EATER") * 500) + 1000) / (((_a0 > 0)) and ((_a0 + 40)) or (0)))
end
H._jm_vampire_bloodthorne_maximal_cure_damage = function(ctx)
    return ((((((H.char_has_trait(H.u(ctx), "VAMPIRE") * 20) + (H.char_has_trait(H.u(ctx), "VAMPIRE2") * 20)) + (H.char_has_trait(H.u(ctx), "VAMPIRE3") * 20)) + H._jm_vampire_total_tier_one_traits(ctx)) + (H._jm_vampire_total_tier_two_traits(ctx) * 2)) + (H._jm_vampire_total_tier_three_traits(ctx) * 3))
end
H._jm_vampire_total_tier_five_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND") + H.char_has_trait(H.u(ctx), "VAMPIRE_DISTILLATE_INNER_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SHADOW_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_IRON_MIND")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLIND_THE_SUN")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEAL_IN_DARK")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DRINK_VAMPIRE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_GAIN_BLOOD_GIFTS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE"))
end
H._jm_vampire_total_tier_five_traits_plus_cauldron = function(ctx)
    return (H._jm_vampire_total_tier_five_traits(ctx) + (H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_FOR_POTENCY_REAL") * 10))
end
H._jm_vampire_total_tier_four_traits = function(ctx)
    return ((((((((((((H.char_has_trait(H.u(ctx), "TRUE_VAMPIRE_POWER") + H.char_has_trait(H.u(ctx), "VAMPIRE_TORPOR")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DOMINATE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_BREATHE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_ILLNESS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BAT_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WOLF_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MIST_FORM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INVISIBLE_IN_DARK")) + H.char_has_trait(H.u(ctx), "VAMPIRE_NO_ILLNESS_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FORM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_FOR_POTENCY"))
end
H._jm_vampire_total_tier_four_traits_plus_potence = function(ctx)
    return (H._jm_vampire_total_tier_four_traits(ctx) + (H.char_has_trait(H.u(ctx), "TRUE_VAMPIRE_POWER") * 5))
end
H._jm_vampire_total_tier_one_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "EYEGLEAM") + H.char_has_trait(H.u(ctx), "BLOOD_FUN")) + H.char_has_trait(H.u(ctx), "STAMINAFORBLOOD")) + H.char_has_trait(H.u(ctx), "COMMUNE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_RESILIENCE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_COLD_TEMPS"))
end
H._jm_vampire_total_tier_one_traits_plus_potency = function(ctx)
    return (H._jm_vampire_total_tier_one_traits(ctx) + H.creature_effect_intensity(H.u(ctx), "effect_player_anathema_potency_boost"))
end
H._jm_vampire_total_tier_three_traits = function(ctx)
    return ((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHASTE") + H.char_has_trait(H.u(ctx), "HYPNOTIC_GAZE")) + H.char_has_trait(H.u(ctx), "MAGICFORBLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_COMMAND_BEAST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_EARTH_SLUMBER")) + H.char_has_trait(H.u(ctx), "VAMPIRE_CARDIO_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MOTION_ALARM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BONUS_HP")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INSTANT_BLEED")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BIG_STOMACH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DETECT_VAMPIRES")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_PAIN")) + H.char_has_trait(H.u(ctx), "DHAMPIR_MEND_WOUNDS_FASTER")) + H.char_has_trait(H.u(ctx), "DHAMPIR_AVOID_EAT_SLEEP_DRINK"))
end
H._jm_vampire_total_tier_two_traits = function(ctx)
    return (((((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHEAL") + H.char_has_trait(H.u(ctx), "COAGULANTWEAVE")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_DODGE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALLS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPORARY_BOOST")) + H.char_has_trait(H.u(ctx), "EYEGLEAM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_THROUGH_NIGHT_EYES")) + H.char_has_trait(H.u(ctx), "BLOOD_FUN_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE_UPGRADE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_FANGS")) + H.char_has_trait(H.u(ctx), "DHAMPIR_SLOWFALL")) + H.char_has_trait(H.u(ctx), "DHAMPIR_RESIST_DISEASE_POISON_INFECTION")) + H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION"))
end
H._jm_werewolf_tier_five_traits = function(ctx)
    return (((H.char_has_trait(H.u(ctx), "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM") + H.char_has_trait(H.u(ctx), "WEREWOLF_CLOSE_TEAR_IN_REALITY")) + H.char_has_trait(H.u(ctx), "WEREWOLF_WALK_THROUGH_WALLS")) + H.char_has_trait(H.u(ctx), "WEREWOLF_SUMMON_SHADOW_PACK"))
end
H._jm_werewolf_tier_four_traits = function(ctx)
    return ((H.char_has_trait(H.u(ctx), "WEREWOLF_SUPER_FAST_REGENERATION") + H.char_has_trait(H.u(ctx), "WEREWOLF_SUMMON_FOG")) + H.char_has_trait(H.u(ctx), "WEREWOLF_MOON_ARMOR"))
end
H._jm_werewolf_tier_one_traits = function(ctx)
    return (((((H.char_has_trait(H.u(ctx), "WEREWOLF_SMELL_NEARBY_ENEMIES") + H.char_has_trait(H.u(ctx), "WEREWOLF_NO_SCENT")) + H.char_has_trait(H.u(ctx), "WEREWOLF_ILLUMINATE_TARGET")) + H.char_has_trait(H.u(ctx), "WEREWOLF_FRIEND_TO_ANIMALS")) + H.char_has_trait(H.u(ctx), "WEREWOLF_SMASH_TERRAIN")) + H.char_has_trait(H.u(ctx), "WEREWOLF_CLIMB_IN_WOLF_FORM"))
end
H._jm_werewolf_tier_three_traits = function(ctx)
    return ((((H.char_has_trait(H.u(ctx), "WEREWOLF_PARTIAL_SHIFT") + H.char_has_trait(H.u(ctx), "WEREWOLF_SILVER_CLAWS")) + H.char_has_trait(H.u(ctx), "WEREWOLF_MANA_BONUS_AFTER_KILL")) + H.char_has_trait(H.u(ctx), "WEREWOLF_STRENGTH_BONUS")) + H.char_has_trait(H.u(ctx), "WEREWOLF_BATTLE_FURY"))
end
H._jm_werewolf_tier_two_traits = function(ctx)
    return ((((H.char_has_trait(H.u(ctx), "WEREWOLF_SENSE_SPIRITS_AND_ALIENS") + H.char_has_trait(H.u(ctx), "WEREWOLF_STUN_MACHINE")) + H.char_has_trait(H.u(ctx), "WEREWOLF_EXTRA_WEAKPOINT_HITS")) + H.char_has_trait(H.u(ctx), "WEREWOLF_FAR_JUMP")) + H.char_has_trait(H.u(ctx), "WEREWOLF_CAMOUFLAGE_COAT"))
end
H._jm_xedra_chron_toggled_spell_count = function(ctx)
    return (((((((H.creature_effect_intensity(H.u(ctx), "effect_xedra_chronomancer_chronal_accel") > 0)) and (1) or (0)) + (((H.creature_effect_intensity(H.u(ctx), "effect_xedra_chronomancer_destabilizing_strikes") > 0)) and (1) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_xedra_chronomancer_stabilize_timeline") > 0)) and (1) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_xedra_chronomancer_reverse_entropy") > 0)) and (1) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_xedra_chronomancer_stable_timeloop") > 0)) and (1) or (0)))
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)
require("eoc_handlers_05")(E, H)
require("eoc_handlers_06")(E, H)
require("eoc_handlers_07")(E, H)
require("eoc_handlers_08")(E, H)
require("eoc_handlers_09")(E, H)
require("eoc_handlers_10")(E, H)
require("eoc_handlers_11")(E, H)
require("eoc_handlers_12")(E, H)

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
    H.run_eoc("EOC_UNDINE_WARP_POOL_BOTTOM_FLOOR", ctx)
    H.run_eoc("EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER", ctx)
    H.run_eoc("EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER", ctx)
    H.run_eoc("EOC_CONDITION_CHECK_HOMULLUS_NEAR_FACTION_ON_OMT_ENTER", ctx)
    H.run_eoc("EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER", ctx)
    H.run_eoc("EOC_HOLY_BURN_CHECK", ctx)
    H.run_eoc("EOC_VAST_WATER_BURN_CHECK", ctx)
    H.run_eoc("EOC_CONDITION_CHECK_LILIN_IN_CITY_ON_OMT_ENTER", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_HOMULLUS_RUNNING_GIVE_STAMINA", ctx)
    H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_SET_TO_ZERO", ctx)
    H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_INCREASING", ctx)
    H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_BREAK_CHECKER", ctx)
    H.run_eoc("EOC_IERDE_DETECT_NEARBY_MONSTERS_CHECK", ctx)
    H.run_eoc("EOC_IERDE_SLEEP_IN_EARTH_REMOVER", ctx)
    H.run_eoc("EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES_REMOVE", ctx)
    H.run_eoc("EOC_VAMPIRE_ZEPHYR_WATER_RUN", ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_RUN_FOR_LONG_PERIODS_CONTINUANCE", ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CHECK_MOVEMENT", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_MOVEMENT_CANCEL", ctx)
    H.run_eoc("EOC_HEDGE_WALK_ON_WATER_CONTINUANCE", ctx)
    H.run_eoc("EOC_HEDGE_WALK_ON_WATER_RUNNING_CANCEL", ctx)
    H.run_eoc("EOC_HEDGE_ASTRAL_PROJECTION_WEARINESS_ON_MOVE", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_attempt_to_fall_asleep", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_SLEEP_NEAR_SEVENOCLOCK", ctx)
end)
ccb.runtime.on("game:character_attempt_to_fall_asleep", "eoc_ev:character_attempt_to_fall_asleep")
ccb.runtime.handler("eoc_ev:character_effect_intensity_changed", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("eoc_poppy_intensity_changed", ctx)
end)
ccb.runtime.on("game:character_effect_intensity_changed", "eoc_ev:character_effect_intensity_changed")
ccb.runtime.handler("eoc_ev:character_falls_asleep", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_SLEEPING_SEIZED_BY_LILIT", ctx)
    H.run_eoc("EOC_WAR_FORM_SHIFT_BACK_ON_SLEEP", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_LOSE_EFFECTS_ON_SLEEP", ctx)
end)
ccb.runtime.on("game:character_falls_asleep", "eoc_ev:character_falls_asleep")
ccb.runtime.handler("eoc_ev:character_finished_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_TROW_END_MINING", ctx)
end)
ccb.runtime.on("game:character_finished_activity", "eoc_ev:character_finished_activity")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("eoc_xedra_time_freeze_character_start_activity", ctx)
    H.run_eoc("EOC_XEDRA_TIME_LOOP_START_LOOP", ctx)
    H.run_eoc("EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_GAIN_EFFECT", ctx)
    H.run_eoc("EOC_VAMPIRE_BLEED_CHECK", ctx)
    H.run_eoc("HYDRATING_GOUT_SYMPTOMS_INCUBATION", ctx)
    H.run_eoc("EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL", ctx)
    H.run_eoc("EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION", ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_WARNING", ctx)
    H.run_eoc("EOC_WANTS_TO_TALK", ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_PROTECT_FROM_VAMPIRISM", ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_GAIN_STAY_AWAKE_IN_SUNLIGHT_EFFECT", ctx)
    H.run_eoc("EOC_HEDGE_ASTRAL_PROJECTION_TOO_MUCH_WEARINESS_ENDS", ctx)
    H.run_eoc("EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_ON", ctx)
    H.run_eoc("EOC_LUCID_DREAM_START", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_kills_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_NPC", ctx)
end)
ccb.runtime.on("game:character_kills_character", "eoc_ev:character_kills_character")
ccb.runtime.handler("eoc_ev:character_kills_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_HEARTWHIP", ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_PROGRESSION", ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_MONSTER", ctx)
end)
ccb.runtime.on("game:character_kills_monster", "eoc_ev:character_kills_monster")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("eoc_xedra_time_freeze_character_end_activity", ctx)
    H.run_eoc("EOC_XEDRA_TIME_LOOP_ENDED_LOOP", ctx)
    H.run_eoc("EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_LOSE_EFFECT", ctx)
    H.run_eoc("EOC_WEATHER_CONTROL_LOSE_EFFECT_RESET_VARIABLES", ctx)
    H.run_eoc("EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS", ctx)
    H.run_eoc("EOC_CHANGELING_AUTUMN_FREEZE_IN_PLACE_CANCEL", ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_SUN_GLASSES_REMOVER", ctx)
    H.run_eoc("EOC_CHANGELING_WINTER_FEIGN_DEATH_LIMITER_ON_LOSS", ctx)
    H.run_eoc("EOC_LILIN_SPEED_BOOST_UNCANNY_DODGE_OFF", ctx)
    H.run_eoc("EOC_LUCID_DREAM_END", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MELEE_CHARACTER_CANCEL_TOGGLES", ctx)
    H.run_eoc("EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_CHARACTER", ctx)
    H.run_eoc("EOC_LILIN_DISEASE_MELEE_STRIKES_CHARACTER_ATTACK", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_MELEE_CHARACTER_CANCEL", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MELEE_MONSTER_CANCEL_TOGGLES", ctx)
    H.run_eoc("EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_MONSTER", ctx)
    H.run_eoc("EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_MELEE_MONSTER", ctx)
    H.run_eoc("EOC_LILIN_DISEASE_MELEE_STRIKES_MONSTER_ATTACK", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_MELEE_MONSTER_CANCEL", ctx)
    H.run_eoc("EOC_BLESSED_WEAPON_ATTACKS", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_HOMULLUS_RANGED_CHARACTER_CANCEL_MIEN", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_RANGED_CHARACTER_CANCEL", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_character", "eoc_ev:character_ranged_attacks_character")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_RANGED_MONSTER_CANCEL_TOGGLES", ctx)
    H.run_eoc("EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_RANGED_MONSTER", ctx)
    H.run_eoc("EOC_HEDGE_MAGIC_RANGED_MONSTER_CANCEL", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_monster", "eoc_ev:character_ranged_attacks_monster")
ccb.runtime.handler("eoc_ev:character_smashes_tile", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES", ctx)
end)
ccb.runtime.on("game:character_smashes_tile", "eoc_ev:character_smashes_tile")
ccb.runtime.handler("eoc_ev:character_starts_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XE_SHAPESHIFTED_ANIMALS_CANT_DO_THAT", ctx)
    H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK_CRAFTING", ctx)
    H.run_eoc("EOC_TROW_START_MINING", ctx)
    H.run_eoc("EOC_WAR_FORM_BANNED_ACTIVITY_PHYSICAL", ctx)
    H.run_eoc("EOC_WAR_FORM_BANNED_ACTIVITY_MENTAL", ctx)
    H.run_eoc("EOC_CHANGELING_WINTER_FEIGN_DEATH_LOST_ON_ACTIVITY", ctx)
    H.run_eoc("EOC_HEDGE_ACTIVITY_TYPE_BREAKS_INCREASE_HEALING_RATE", ctx)
end)
ccb.runtime.on("game:character_starts_activity", "eoc_ev:character_starts_activity")
ccb.runtime.handler("eoc_ev:character_takeoff_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XE_IRON_INTOLERANCE_UNWEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_HEDGE_TURN_INTO_BEAR_UNWEAR_ITEM", ctx)
end)
ccb.runtime.on("game:character_takeoff_item", "eoc_ev:character_takeoff_item")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XEDRA_TRACK_LAST_HIT", ctx)
    H.run_eoc("EOC_IERDE_EARTHEN_SHIELD_REDUCER", ctx)
    H.run_eoc("EOC_IERDE_BODY_OF_ADAMANT_LIMB_HEALER", ctx)
    H.run_eoc("EOC_UNDINE_WATER_PUSH_AWAY", ctx)
    H.run_eoc("EOC_UNDINE_WATER_FORM_TRAITS_LOSE_WATER", ctx)
    H.run_eoc("EOC_VAMPIRIC_RESILIENCE_FLESH_OF_MARBLE", ctx)
    H.run_eoc("EOC_LILIN_PREVENT_DEATH_DAMAGE_TRACKER", ctx)
    H.run_eoc("EOC_XE_GETTING_HIT_WHILE_USING_ETHEREAL_WINGS", ctx)
    H.run_eoc("EOC_HEDGE_PROTECT_THE_MIND_FROM_PSYCHIC_ASSAULT", ctx)
    H.run_eoc("EOC_HEDGE_WEARING_RAZIEL_PROTECTIVE_AMULET", ctx)
    H.run_eoc("EOC_LILIN_MESMERISM_REMOVAL_CHARACTER", ctx)
    H.run_eoc("EOC_XE_GETTING_HIT_WHILE_USING_NETHER_SORCERY_WIND_DODGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wakes_up", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_BOOK_LIES_NIGHTMARES", ctx)
    H.run_eoc("EOC_CHECKING_THE_BLACK_HORSE", ctx)
    H.run_eoc("EOC_DREAMS_AND_NIGHTMARES", ctx)
    H.run_eoc("EOC_SLEEPING_SEIZED_BY_LILIT_WARNING", ctx)
    H.run_eoc("EOC_INVENTOR_SLEEP_GAMING", ctx)
    H.run_eoc("EOC_WAKE_UP_FROM_SLEEP_SHIELD", ctx)
    H.run_eoc("EOC_XE_QUEUE_LEVELING", ctx)
    H.run_eoc("EOC_GIVE_NIGHTMARES", ctx)
    H.run_eoc("EOC_XE_ALCHEMY_PERK_WAKE_UP_RUN", ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM", ctx)
    H.run_eoc("EOC_HOMULLUS_DREAMWALKER_GAIN_DREAMDROSS", ctx)
    H.run_eoc("EOC_PARACLESIAN_GOSSAMER_RECIPES", ctx)
    H.run_eoc("EOC_RUACH_DRAINED_AWAKENING_PENALTIES", ctx)
end)
ccb.runtime.on("game:character_wakes_up", "eoc_ev:character_wakes_up")
ccb.runtime.handler("eoc_ev:character_wears_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XE_IRON_INTOLERANCE_WEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM", ctx)
end)
ccb.runtime.on("game:character_wears_item", "eoc_ev:character_wears_item")
ccb.runtime.handler("eoc_ev:character_wields_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XE_IRON_INTOLERANCE_WIELDING_IRON_OR_STEEL", ctx)
end)
ccb.runtime.on("game:character_wields_item", "eoc_ev:character_wields_item")
ccb.runtime.handler("eoc_ev:gains_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_SALAMANDER_WATER_TO_BOOZE", ctx)
    H.run_eoc("EOC_SALAMANDER_WATER_TO_FUEL", ctx)
    H.run_eoc("EOC_UNDINE_LEARN_SALTWATER_TO_FRESHWATER", ctx)
    H.run_eoc("EOC_UNDINE_LEARN_FOUL_WATER", ctx)
    H.run_eoc("EOC_UNDINE_LEARN_LIQUID_TO_WATER", ctx)
    H.run_eoc("EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT", ctx)
    H.run_eoc("EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE", ctx)
    H.run_eoc("EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_INITIAL", ctx)
    H.run_eoc("EOC_LILIN_INCREMENTAL_SPEED_BOOST_SETUP", ctx)
end)
ccb.runtime.on("game:gains_mutation", "eoc_ev:gains_mutation")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("HOMULLUS_MIGRATE_TO_MIMIMIZED_MUTATIONS", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_CHECK_GAMESTART_CHRONOMANCER", ctx)
    H.run_eoc("EOC_XE_XE_OPERATIVE_MAGIC_SQUARES_BOOK_UNDERSTANDING", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:monster_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_BREAK_VAMPIRE_TRUCE", ctx)
    H.run_eoc("EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID", ctx)
    H.run_eoc("EOC_HEDGE_PREVENT_WILD_ANIMAL_ATTACKS_EXPLOIT_PREVENTER", ctx)
    H.run_eoc("EOC_LILIN_MESMERISM_REMOVAL_MONSTER", ctx)
end)
ccb.runtime.on("game:monster_takes_damage", "eoc_ev:monster_takes_damage")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_caster_necklace_boost", ctx)
    H.run_eoc("EOC_XE_SI_PRE_TELEPORT_LOCATION_CHECKING", ctx)
    H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK_SPELLBOOK", ctx)
    H.run_eoc("EOC_SET_VAMPIRE_TRAIT_NUMBERS_FOR_NPC_USE", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")
ccb.runtime.handler("eoc_ev:player_levels_spell", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XE_GOT_A_SPELL_LVL", ctx)
end)
ccb.runtime.on("game:player_levels_spell", "eoc_ev:player_levels_spell")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DREAMS_DEDUCTION_SKILL_EXP", ctx)
    H.run_eoc("EOC_XE_NETHER_SORCERY_WEARINESS_COST", ctx)
    H.run_eoc("EOC_XE_NETHER_SORCERY_RESONANCE_CONSEQUENCES", ctx)
    H.run_eoc("EOC_XE_NETHER_SORCERY_RESONANCE_CONSEQUENCES", ctx)
    H.run_eoc("EOC_XE_SI_PRE_TELEPORT_POWER_CHECKING", ctx)
    H.run_eoc("EOC_FAE_GRAMARYE_SKILL_EXP", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_PREVENT_DEATH", ctx)
    H.run_eoc("EOC_PERENNIAL_REBIRTH", ctx)
    H.run_eoc("EOC_HOMULLUS_DEATH_DOOR_REBIRTH", ctx)
    H.run_eoc("EOC_SALAMANDER_REBORN_IN_FLAMES", ctx)
    H.run_eoc("EOC_last_breath_mist", ctx)
    H.run_eoc("EOC_LILIN_PREVENT_DEATH_INITIATE", ctx)
    H.run_eoc("EOC_LUCID_REBIRTH", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:blood_spiders_itch", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:blood_spiders_itch"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((((function() local eg = H.safe_id('effect', "blood_spiders"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "stim_overdose"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("blood_spiders_itch", ctx)
end)
ccb.runtime.handler("eoc_int:blood_spiders_itch", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1500), math.floor(4500); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:blood_spiders_itch", "eoc_int:blood_spiders_itch")
ccb.runtime.handler("eoc_rec:xe_night_messages", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:xe_night_messages"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("xe_night_messages", ctx)
end)
ccb.runtime.handler("eoc_int:xe_night_messages", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:xe_night_messages", "eoc_int:xe_night_messages")
ccb.runtime.handler("eoc_rec:xe_day_messages", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:xe_day_messages"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("xe_day_messages", ctx)
end)
ccb.runtime.handler("eoc_int:xe_day_messages", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:xe_day_messages", "eoc_int:xe_day_messages")
ccb.runtime.handler("eoc_rec:xe_scraggy-boo_messages", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:xe_scraggy-boo_messages"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("xe_scraggy-boo_messages", ctx)
end)
ccb.runtime.handler("eoc_int:xe_scraggy-boo_messages", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(7200), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:xe_scraggy-boo_messages", "eoc_int:xe_scraggy-boo_messages")
ccb.runtime.handler("eoc_rec:xe_book_lies_carried", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:xe_book_lies_carried"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("xe_book_lies_carried", ctx)
end)
ccb.runtime.handler("eoc_int:xe_book_lies_carried", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1200), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:xe_book_lies_carried", "eoc_int:xe_book_lies_carried")
ccb.runtime.handler("eoc_rec:xe_book_lies_carried_no_tick_down", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:xe_book_lies_carried_no_tick_down"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("xe_book_lies_carried_no_tick_down", ctx)
end)
ccb.runtime.handler("eoc_int:xe_book_lies_carried_no_tick_down", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:xe_book_lies_carried_no_tick_down", "eoc_int:xe_book_lies_carried_no_tick_down")
ccb.runtime.handler("eoc_rec:faeblood_hallu_hard", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:faeblood_hallu_hard"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("faeblood_hallu_hard", ctx)
end)
ccb.runtime.handler("eoc_int:faeblood_hallu_hard", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1740), math.floor(1740); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:faeblood_hallu_hard", "eoc_int:faeblood_hallu_hard")
ccb.runtime.handler("eoc_rec:EOC_discover_jotunn", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_discover_jotunn"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_exodii_seen_jotunn") and 1 or 0))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_discover_jotunn", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_discover_jotunn", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(8)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_discover_jotunn", "eoc_int:EOC_discover_jotunn")
ccb.runtime.handler("eoc_rec:DECREASE_BERSERKER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:DECREASE_BERSERKER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("DECREASE_BERSERKER", ctx)
end)
ccb.runtime.handler("eoc_int:DECREASE_BERSERKER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(25)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:DECREASE_BERSERKER", "eoc_int:DECREASE_BERSERKER")
ccb.runtime.handler("eoc_rec:EOC_FEEDING_THE_BLACK_HORSE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_FEEDING_THE_BLACK_HORSE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_FEEDING_THE_BLACK_HORSE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_FEEDING_THE_BLACK_HORSE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(518400), math.floor(691200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_FEEDING_THE_BLACK_HORSE", "eoc_int:EOC_FEEDING_THE_BLACK_HORSE")
ccb.runtime.handler("eoc_rec:EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (((not (((H.char_snap(H.u(ctx)) or {}).avatar == true))) or (H.char_has_trait(H.u(ctx), "FAE_ENMITY") == 1))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(432000), math.floor(1036800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE", "eoc_int:EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE")
ccb.runtime.handler("eoc_rec:EOC_XE_MAGIC_BAD_DREAMS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_XE_MAGIC_BAD_DREAMS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (((H.global_var_num("eater_dreamer_sequence") < (-1)) and (H.global_var_num("inventor_dreamsmith_sequence") < (-1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_XE_MAGIC_BAD_DREAMS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_XE_MAGIC_BAD_DREAMS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_XE_MAGIC_BAD_DREAMS", "eoc_int:EOC_XE_MAGIC_BAD_DREAMS")
ccb.runtime.handler("eoc_rec:EOC_calorie_storage", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_calorie_storage"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (((function() local eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_calorie_storage", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_calorie_storage", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(50), math.floor(70); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_calorie_storage", "eoc_int:EOC_calorie_storage")
ccb.runtime.handler("eoc_rec:EOC_bio_inventor_book_burn_boost_vitamin_drain", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_bio_inventor_book_burn_boost_vitamin_drain"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_bio_inventor_book_burn_boost_vitamin_drain", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_bio_inventor_book_burn_boost_vitamin_drain", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor((660 - (H.creature_effect_intensity(H.u(ctx), "effect_burned_books") * 60))), math.floor((660 - (H.creature_effect_intensity(H.u(ctx), "effect_burned_books") * 60))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_bio_inventor_book_burn_boost_vitamin_drain", "eoc_int:EOC_bio_inventor_book_burn_boost_vitamin_drain")
ccb.runtime.handler("eoc_rec:EOC_XE_MAGIC_POTENTIAL_CONDUCTS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_XE_MAGIC_POTENTIAL_CONDUCTS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_XE_MAGIC_POTENTIAL_CONDUCTS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_XE_MAGIC_POTENTIAL_CONDUCTS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(57600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_XE_MAGIC_POTENTIAL_CONDUCTS", "eoc_int:EOC_XE_MAGIC_POTENTIAL_CONDUCTS")
ccb.runtime.handler("eoc_rec:EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.char_has_any_trait(H.u(ctx), { "XE_NO_NETHER_SORCERY", "XE_NETHER_SORCERY" }))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP", "eoc_int:EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP")
ccb.runtime.handler("eoc_rec:EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "xedra_revenant_prof").value == true)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS", "eoc_int:EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS")
ccb.runtime.handler("eoc_rec:EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS", "eoc_int:EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS")
ccb.runtime.handler("eoc_rec:EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(3600)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES", "eoc_int:EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES")
ccb.runtime.handler("eoc_rec:EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "DHAMPIR_WEAKNESS_BLOODTHIRST") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(900), math.floor(129600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS", "eoc_int:EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS")
ccb.runtime.handler("eoc_rec:EOC_GRACKEN_CONVERT_RADS_TO_CALORIES", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GRACKEN_CONVERT_RADS_TO_CALORIES"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "RADIOTROPHIC") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GRACKEN_CONVERT_RADS_TO_CALORIES", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GRACKEN_CONVERT_RADS_TO_CALORIES", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(75), math.floor(175); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GRACKEN_CONVERT_RADS_TO_CALORIES", "eoc_int:EOC_GRACKEN_CONVERT_RADS_TO_CALORIES")
ccb.runtime.handler("eoc_rec:eoc_eggsac_host", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_eggsac_host"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1) or (H.char_has_trait(H.u(ctx), "EGGSAC_FATAL") == 1))))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("eoc_eggsac_host", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_eggsac_host", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(18000), math.floor(432000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_eggsac_host", "eoc_int:eoc_eggsac_host")
ccb.runtime.handler("eoc_rec:manifest_destiny_goblin", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:manifest_destiny_goblin"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "MANIFEST_DESTINY_GOBLIN") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("manifest_destiny_goblin", ctx)
end)
ccb.runtime.handler("eoc_int:manifest_destiny_goblin", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(259200), math.floor(432000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:manifest_destiny_goblin", "eoc_int:manifest_destiny_goblin")
ccb.runtime.handler("eoc_rec:manifested_destiny_goblin", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:manifested_destiny_goblin"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_GOBLIN") == 1)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("manifested_destiny_goblin", ctx)
end)
ccb.runtime.handler("eoc_int:manifested_destiny_goblin", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(259200), math.floor(432000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:manifested_destiny_goblin", "eoc_int:manifested_destiny_goblin")
ccb.runtime.handler("eoc_rec:manifest_destiny_spider", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:manifest_destiny_spider"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_SPIDER") == 1)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("manifest_destiny_spider", ctx)
end)
ccb.runtime.handler("eoc_int:manifest_destiny_spider", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(259200), math.floor(432000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:manifest_destiny_spider", "eoc_int:manifest_destiny_spider")
ccb.runtime.handler("eoc_rec:manifested_destiny_spider", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:manifested_destiny_spider"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_SPIDER") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("manifested_destiny_spider", ctx)
end)
ccb.runtime.handler("eoc_int:manifested_destiny_spider", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(259200), math.floor(432000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:manifested_destiny_spider", "eoc_int:manifested_destiny_spider")
ccb.runtime.handler("eoc_rec:EOC_ARVORE_SUN_FOODS_ON_KCAL", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ARVORE_SUN_FOODS_ON_KCAL"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ARVORE_SUN_FOODS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ARVORE_SUN_FOODS_ON_KCAL", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ARVORE_SUN_FOODS_ON_KCAL", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ARVORE_SUN_FOODS_ON_KCAL", "eoc_int:EOC_ARVORE_SUN_FOODS_ON_KCAL")
ccb.runtime.handler("eoc_rec:EOC_ARVORE_TREE_SINGING_LEARN_RECIPES", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ARVORE_TREE_SINGING_LEARN_RECIPES"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ARVORE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ARVORE_TREE_SINGING_LEARN_RECIPES", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ARVORE_TREE_SINGING_LEARN_RECIPES", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(129600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ARVORE_TREE_SINGING_LEARN_RECIPES", "eoc_int:EOC_ARVORE_TREE_SINGING_LEARN_RECIPES")
ccb.runtime.handler("eoc_rec:EOC_ARVORE_TREE_REDUCE_THIRST", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ARVORE_TREE_REDUCE_THIRST"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ARVORE_TREE_FORM_TRAITS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ARVORE_TREE_REDUCE_THIRST", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ARVORE_TREE_REDUCE_THIRST", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(180), math.floor(180); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ARVORE_TREE_REDUCE_THIRST", "eoc_int:EOC_ARVORE_TREE_REDUCE_THIRST")
ccb.runtime.handler("eoc_rec:EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "HOMULLUS_GAIN_BIONIC_POWER", "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(30)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES", "eoc_int:EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES")
ccb.runtime.handler("eoc_rec:EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "HOMULLUS_NO_DOLL_MUTATIONS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(600)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2", "eoc_int:EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2")
ccb.runtime.handler("eoc_rec:EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER", "eoc_int:EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER")
ccb.runtime.handler("eoc_rec:EOC_PARACLESIANS_CANNOT_USE_PURIFIER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PARACLESIANS_CANNOT_USE_PURIFIER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "ARVORE", "HOMULLUS", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PARACLESIANS_CANNOT_USE_PURIFIER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PARACLESIANS_CANNOT_USE_PURIFIER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(600)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PARACLESIANS_CANNOT_USE_PURIFIER", "eoc_int:EOC_PARACLESIANS_CANNOT_USE_PURIFIER")
ccb.runtime.handler("eoc_rec:EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING", "eoc_int:EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING")
ccb.runtime.handler("eoc_rec:EOC_TROW_WHILE_MINING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_TROW_WHILE_MINING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "TROW_WHILE_MINING_NO_EATING_OR_SLEEP") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_TROW_WHILE_MINING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_TROW_WHILE_MINING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(300)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_TROW_WHILE_MINING", "eoc_int:EOC_TROW_WHILE_MINING")
ccb.runtime.handler("eoc_rec:eoc_vampire_blood_to_kcal", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_vampire_blood_to_kcal"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "BLOOD_DRINKER") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("eoc_vampire_blood_to_kcal", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_vampire_blood_to_kcal", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3000), math.floor(4200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_vampire_blood_to_kcal", "eoc_int:eoc_vampire_blood_to_kcal")
ccb.runtime.handler("eoc_rec:EOC_NEED_LIVING_BLOOD_GIVE_EFFECT", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_NEED_LIVING_BLOOD_GIVE_EFFECT"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_NEED_LIVING_BLOOD_GIVE_EFFECT", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_NEED_LIVING_BLOOD_GIVE_EFFECT", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_NEED_LIVING_BLOOD_GIVE_EFFECT", "eoc_int:EOC_NEED_LIVING_BLOOD_GIVE_EFFECT")
ccb.runtime.handler("eoc_rec:EOC_BLOOD_CRAVING_START", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_BLOOD_CRAVING_START"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_BLOOD_CRAVING_START", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_BLOOD_CRAVING_START", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(36000), math.floor(57600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_BLOOD_CRAVING_START", "eoc_int:EOC_BLOOD_CRAVING_START")
ccb.runtime.handler("eoc_rec:EOC_NO_FUN_CHECK", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_NO_FUN_CHECK"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NO_FUN") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_NO_FUN_CHECK", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_NO_FUN_CHECK", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(2), math.floor(4); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_NO_FUN_CHECK", "eoc_int:EOC_NO_FUN_CHECK")
ccb.runtime.handler("eoc_rec:EOC_VAMPIRE_HEAL_IN_DARK", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_VAMPIRE_HEAL_IN_DARK"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE_HEAL_IN_DARK") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_VAMPIRE_HEAL_IN_DARK", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_VAMPIRE_HEAL_IN_DARK", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_VAMPIRE_HEAL_IN_DARK", "eoc_int:EOC_VAMPIRE_HEAL_IN_DARK")
ccb.runtime.handler("eoc_rec:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD", "eoc_int:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD")
ccb.runtime.handler("eoc_rec:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (((function() local eg = H.safe_id('effect', "effect_anathema_need_vampire_blood"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN", "eoc_int:EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN")
ccb.runtime.handler("eoc_rec:EOC_LILIN_RUACH_DRAIN_SELF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_RUACH_DRAIN_SELF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_RUACH_DRAIN_SELF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_RUACH_DRAIN_SELF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(360), math.floor(360); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_RUACH_DRAIN_SELF", "eoc_int:EOC_LILIN_RUACH_DRAIN_SELF")
ccb.runtime.handler("eoc_rec:EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((H.time_until_named("sunset", false) / 1))
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP", "eoc_int:EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP")
ccb.runtime.handler("eoc_rec:EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (((H.char_spell_level(H.u(ctx), "lilin_drain_ruach_long_ranged_spell") >= 0) or (not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(360), math.floor(360); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK", "eoc_int:EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK")
ccb.runtime.handler("eoc_rec:EOC_LILIN_RUACH_UI_UPDATER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_RUACH_UI_UPDATER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_RUACH_UI_UPDATER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_RUACH_UI_UPDATER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_RUACH_UI_UPDATER", "eoc_int:EOC_LILIN_RUACH_UI_UPDATER")
ccb.runtime.handler("eoc_rec:EOC_LILIN_INCREMENTAL_SPEED_BOOST", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_INCREMENTAL_SPEED_BOOST"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_INCREMENTAL_SPEED_BOOST") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_INCREMENTAL_SPEED_BOOST", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_INCREMENTAL_SPEED_BOOST", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_INCREMENTAL_SPEED_BOOST", "eoc_int:EOC_LILIN_INCREMENTAL_SPEED_BOOST")
ccb.runtime.handler("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_ENHANCEMENT_DAMAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE", "eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE")
ccb.runtime.handler("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_STEALTH_MODIFIER_IN_DARKNESS") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS", "eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS")
ccb.runtime.handler("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES", "eoc_int:EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES")
ccb.runtime.handler("eoc_rec:EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "HEDGE_MAGIC") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE", "eoc_int:EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:faeblood_hallu_light", function(_)
    local dk = "eoc_deact:faeblood_hallu_light"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("faeblood_hallu_light", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(1740), math.floor(1740); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:faeblood_hallu_light", {})
end)
ccb.runtime.handler("eoc_glob:EOC_EATER_CHECK", function(_)
    local dk = "eoc_deact:EOC_EATER_CHECK"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.char_has_trait(H.u(ctx), "EATER_SIXTH_SENSE") == 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_EATER_CHECK", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(43200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_EATER_CHECK", {})
end)
ccb.runtime.handler("eoc_glob:EOC_Xedra_Evolved_RandEnc_remove", function(_)
    local dk = "eoc_deact:EOC_Xedra_Evolved_RandEnc_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_Xedra_Evolved_RandEnc_remove", ctx)
    local t = math.max(1, math.floor(200))
    ccb.tasks.after(t, "eoc_glob:EOC_Xedra_Evolved_RandEnc_remove", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_Roadstop_Jotunn", function(_)
    local dk = "eoc_deact:EOC_RandEnc_Roadstop_Jotunn"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_Roadstop_Jotunn", ctx)
    local t = math.max(1, math.floor(43400))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_Roadstop_Jotunn", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_March_Lord_Hunting_Party", function(_)
    local dk = "eoc_deact:EOC_RandEnc_March_Lord_Hunting_Party"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_March_Lord_Hunting_Party", ctx)
    local t = math.max(1, math.floor(27600))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_March_Lord_Hunting_Party", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_XE_Wraiths_On_Dark_Nights", function(_)
    local dk = "eoc_deact:EOC_RandEnc_XE_Wraiths_On_Dark_Nights"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_XE_Wraiths_On_Dark_Nights", ctx)
    local t = math.max(1, math.floor(69480))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_XE_Wraiths_On_Dark_Nights", {})
end)
ccb.runtime.handler("eoc_glob:EOC_INVENTOR_CRAFTED_DEGRADATION", function(_)
    local dk = "eoc_deact:EOC_INVENTOR_CRAFTED_DEGRADATION"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_INVENTOR_CRAFTED_DEGRADATION", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_INVENTOR_CRAFTED_DEGRADATION", {})
end)
ccb.runtime.handler("eoc_glob:EOC_INVENTOR_CBM_DEGRADATION", function(_)
    local dk = "eoc_deact:EOC_INVENTOR_CBM_DEGRADATION"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_INVENTOR_CBM_DEGRADATION", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_INVENTOR_CBM_DEGRADATION", {})
end)
ccb.runtime.handler("eoc_glob:EOC_INVENTOR_CRAFTED_GEAR", function(_)
    local dk = "eoc_deact:EOC_INVENTOR_CRAFTED_GEAR"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_INVENTOR_CRAFTED_GEAR", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_INVENTOR_CRAFTED_GEAR", {})
end)
ccb.runtime.handler("eoc_glob:CHARGE_STORMWROUGHT_BLOOD", function(_)
    local dk = "eoc_deact:CHARGE_STORMWROUGHT_BLOOD"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("CHARGE_STORMWROUGHT_BLOOD", ctx)
    local t = math.max(1, math.floor(300))
    ccb.tasks.after(t, "eoc_glob:CHARGE_STORMWROUGHT_BLOOD", {})
end)
ccb.runtime.handler("eoc_glob:HYDRATING_GOUT_SYMPTOMS", function(_)
    local dk = "eoc_deact:HYDRATING_GOUT_SYMPTOMS"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((function() local eg = H.safe_id('effect', "xe_hydrating_gout"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("HYDRATING_GOUT_SYMPTOMS", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(45), math.floor(75); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:HYDRATING_GOUT_SYMPTOMS", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_ACTIVATE_ANATHEMA", function(_)
    local dk = "eoc_deact:EOC_ACTIVATE_ANATHEMA"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("Anathema_Activated") == 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_ACTIVATE_ANATHEMA", ctx)
    local t = math.max(1, math.floor(86400))
    ccb.tasks.after(t, "eoc_glob:EOC_ACTIVATE_ANATHEMA", {})
end)
ccb.runtime.handler("eoc_glob:EOC_ANATHEMA_WITHDRAWS_FOR_NOW", function(_)
    local dk = "eoc_deact:EOC_ANATHEMA_WITHDRAWS_FOR_NOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_ANATHEMA_WITHDRAWS_FOR_NOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_ANATHEMA_WITHDRAWS_FOR_NOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH", function(_)
    local dk = "eoc_deact:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH", ctx)
    local t = math.max(1, math.floor((((((services.turn() % 86400) / 1) >= 1)) and 1 or 0)))
    ccb.tasks.after(t, "eoc_glob:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH", {})
end)
ccb.runtime.handler("eoc_glob:magic_weather_thunder", function(_)
    local dk = "eoc_deact:magic_weather_thunder"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("magic_weather_thunder", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:magic_weather_thunder", {})
end)
ccb.runtime.handler("eoc_glob:magic_weather_lightning", function(_)
    local dk = "eoc_deact:magic_weather_lightning"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("magic_weather_lightning", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:magic_weather_lightning", {})
end)
ccb.runtime.handler("eoc_glob:EOC_XE_OMINOUS_FOG_WEATHER", function(_)
    local dk = "eoc_deact:EOC_XE_OMINOUS_FOG_WEATHER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("xe_weather_ominous_fog_scenario") == 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_XE_OMINOUS_FOG_WEATHER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(1209600), math.floor(2419200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_XE_OMINOUS_FOG_WEATHER", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:faeblood_hallu_light") then
        ccb.state.world.set("eoc_glob_started:faeblood_hallu_light", true)
        ccb.tasks.after(1, "eoc_glob:faeblood_hallu_light", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_EATER_CHECK") then
        ccb.state.world.set("eoc_glob_started:EOC_EATER_CHECK", true)
        ccb.tasks.after(1, "eoc_glob:EOC_EATER_CHECK", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_Xedra_Evolved_RandEnc_remove") then
        ccb.state.world.set("eoc_glob_started:EOC_Xedra_Evolved_RandEnc_remove", true)
        ccb.tasks.after(1, "eoc_glob:EOC_Xedra_Evolved_RandEnc_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_Roadstop_Jotunn") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_Roadstop_Jotunn", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_Roadstop_Jotunn", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_March_Lord_Hunting_Party") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_March_Lord_Hunting_Party", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_March_Lord_Hunting_Party", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_XE_Wraiths_On_Dark_Nights") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_XE_Wraiths_On_Dark_Nights", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_XE_Wraiths_On_Dark_Nights", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_INVENTOR_CRAFTED_DEGRADATION") then
        ccb.state.world.set("eoc_glob_started:EOC_INVENTOR_CRAFTED_DEGRADATION", true)
        ccb.tasks.after(1, "eoc_glob:EOC_INVENTOR_CRAFTED_DEGRADATION", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_INVENTOR_CBM_DEGRADATION") then
        ccb.state.world.set("eoc_glob_started:EOC_INVENTOR_CBM_DEGRADATION", true)
        ccb.tasks.after(1, "eoc_glob:EOC_INVENTOR_CBM_DEGRADATION", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_INVENTOR_CRAFTED_GEAR") then
        ccb.state.world.set("eoc_glob_started:EOC_INVENTOR_CRAFTED_GEAR", true)
        ccb.tasks.after(1, "eoc_glob:EOC_INVENTOR_CRAFTED_GEAR", {})
    end
    if not ccb.state.world.get("eoc_glob_started:CHARGE_STORMWROUGHT_BLOOD") then
        ccb.state.world.set("eoc_glob_started:CHARGE_STORMWROUGHT_BLOOD", true)
        ccb.tasks.after(1, "eoc_glob:CHARGE_STORMWROUGHT_BLOOD", {})
    end
    if not ccb.state.world.get("eoc_glob_started:HYDRATING_GOUT_SYMPTOMS") then
        ccb.state.world.set("eoc_glob_started:HYDRATING_GOUT_SYMPTOMS", true)
        ccb.tasks.after(1, "eoc_glob:HYDRATING_GOUT_SYMPTOMS", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_ACTIVATE_ANATHEMA") then
        ccb.state.world.set("eoc_glob_started:EOC_ACTIVATE_ANATHEMA", true)
        ccb.tasks.after(1, "eoc_glob:EOC_ACTIVATE_ANATHEMA", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_ANATHEMA_WITHDRAWS_FOR_NOW") then
        ccb.state.world.set("eoc_glob_started:EOC_ANATHEMA_WITHDRAWS_FOR_NOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_ANATHEMA_WITHDRAWS_FOR_NOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH") then
        ccb.state.world.set("eoc_glob_started:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH", true)
        ccb.tasks.after(1, "eoc_glob:EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH", {})
    end
    if not ccb.state.world.get("eoc_glob_started:magic_weather_thunder") then
        ccb.state.world.set("eoc_glob_started:magic_weather_thunder", true)
        ccb.tasks.after(1, "eoc_glob:magic_weather_thunder", {})
    end
    if not ccb.state.world.get("eoc_glob_started:magic_weather_lightning") then
        ccb.state.world.set("eoc_glob_started:magic_weather_lightning", true)
        ccb.tasks.after(1, "eoc_glob:magic_weather_lightning", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_XE_OMINOUS_FOG_WEATHER") then
        ccb.state.world.set("eoc_glob_started:EOC_XE_OMINOUS_FOG_WEATHER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_XE_OMINOUS_FOG_WEATHER", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
