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
if H.add_bionic == nil then
H.add_bionic = function(actor, bid)
    if not actor then return end
    local gid = H.safe_id("bionic", bid)
    if not gid then return end
    services.bionics.grant(actor, gid)
end
end
if H.add_proficiency_progress == nil then
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
end
if H.char_bionic_power == nil then
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
end
if H.char_snap == nil then
H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end
end
if H.char_cash == nil then
H.char_cash = function(actor)
    local s = H.char_snap(actor)
    if not s then return 0 end
    return s.cash or 0
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
if H.char_has_item == nil then
H.char_has_item = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_type(actor, gid)
    return r.ok and r.value == true
end
end
if H.char_has_items == nil then
H.char_has_items = function(actor, item_id, count, charges)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_items(actor, gid, count, charges)
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
if H.char_has_trait == nil then
H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end
end
if H.char_mana == nil then
H.char_mana = function(actor, which)
    if not actor then return 0 end
    local r = services.spells.mana(actor)
    if not r.ok or not r.value then return 0 end
    return r.value[which] or 0
end
end
if H.char_pain == nil then
H.char_pain = function(actor)
    local s = H.char_snap(actor)
    if not s or not s.creature then return 0 end
    return s.creature.pain or 0
end
end
if H.char_proficiency == nil then
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
end
if H.char_school_level == nil then
H.char_school_level = function(actor, school_id)
    if not actor then return -1 end
    local gid = H.safe_id("mutation", school_id)
    if not gid then return -1 end
    local r = services.spells.school_level(actor, gid)
    if not r.ok or r.value == nil then return -1 end
    return r.value
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
if H.char_spell_exp == nil then
H.char_spell_exp = function(actor, spell_id)
    if not actor then return -1 end
    local gid = H.safe_id("spell", spell_id)
    if not gid then return -1 end
    local r = services.spells.get(actor, gid)
    if not r.ok or not r.value then return -1 end
    return r.value.experience or 0
end
end
if H.char_spell_level == nil then
H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end
end
if H.char_stat == nil then
H.char_stat = function(actor, field)
    local s = H.char_snap(actor)
    if not s then return 0 end
    return s.stats[field] or 0
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
if H.consume_item == nil then
H.consume_item = function(actor, item_id, count, charges)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    services.inventory.consume_by_type(actor, gid, math.floor(count or 0), math.floor(charges or 0))
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
if H.eoc_loc_var == nil then
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
if H.faction_food == nil then
H.faction_food = function(fac_id, vit_id)
    local gid = H.safe_id("faction", fac_id)
    if not gid then return 0 end
    if not vit_id or vit_id == "" then
        local r = services.factions.food(gid, { offset = 0, limit = 1 })
        if not r.ok or not r.value then return 0 end
        return r.value.kcal or 0
    end
    local offset = 0
    while true do
        local r = services.factions.food(gid, { offset = offset, limit = 128 })
        if not r.ok or not r.value or not r.value.vitamins then return 0 end
        local page = r.value.vitamins
        for _, item in ipairs(page.items or {}) do
            if item.id and item.id.value == vit_id then
                return item.amount or 0
            end
        end
        if not page.has_more then break end
        offset = offset + (page.returned or 128)
    end
    return 0
end
end
if H.npc_snap == nil then
H.npc_snap = function(npc)
    if not npc then return nil end
    local r = services.npcs.get(npc)
    if not r.ok then return nil end
    return r.value
end
end
if H.rl_dist == nil then
H.rl_dist = function(a, b)
    if not a or not b or a.z ~= b.z then return 999999 end
    return math.max(math.abs(a.x - b.x), math.abs(a.y - b.y))
end
end
if H.follower_present == nil then
H.follower_present = function(npc, class_id)
    local nsnap = H.npc_snap(npc)
    if not nsnap then return false end
    local fl = services.followers.list()
    if not fl.ok or not fl.value or not fl.value.items then return false end
    for _, entry in ipairs(fl.value.items) do
        if entry.available and entry.handle then
            local esnap = H.npc_snap(entry.handle)
            if esnap and esnap.class and esnap.class.value == class_id and esnap.following then
                if H.rl_dist(entry.position, nsnap.position) < 5 then
                    local los = services.creatures.has_line_of_sight(entry.handle, npc)
                    if los.ok and los.value == true then
                        return true
                    end
                end
            end
        end
    end
    return false
end
end
if H.global_var_num == nil then
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
end
if H.lose_trait == nil then
H.lose_trait = function(actor, trait_id)
    if not actor then return end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return end
    services.mutations.erase(actor, gid)
end
end
if H.npc_faction_trust == nil then
H.npc_faction_trust = function(npc)
    local s = H.npc_snap(npc)
    if not s or not s.faction then return 0 end
    local r = services.factions.get(s.faction)
    if not r.ok or not r.value or not r.value.reputation then return 0 end
    return r.value.reputation.trusts or 0
end
end
if H.npc_mood_read == nil then
H.npc_mood_read = function(actor, field)
    local ns = H.npc_snap(actor)
    if not ns or not ns.opinion then return 0 end
    return ns.opinion[field] or 0
end
end
if H.npc_opinion == nil then
H.npc_opinion = function(npc, field)
    local s = H.npc_snap(npc)
    if not s or not s.opinion then return 0 end
    return s.opinion[field] or 0
end
end
if H.receive_item == nil then
H.receive_item = function(actor, item_id, count, container_id, flags)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    local opts = nil
    if container_id and container_id ~= "" then
        local cgid = H.safe_id("item", container_id)
        if cgid then opts = { container = cgid } end
    end
    services.inventory.receive_item(actor, gid, math.floor(count or 1), opts)
end
end
if H.round_half_away == nil then
H.round_half_away = function(v)
    if v >= 0 then return math.floor(v + 0.5) end
    return math.ceil(v - 0.5)
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
if H.set_bionic_power == nil then
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
if H.time_since == nil then
H.time_since = function(point_turns, unit_div)
    if point_turns == nil then return -1 end
    local diff = services.turn() - point_turns
    if unit_div and unit_div ~= 1 then return diff / unit_div end
    return diff
end
end
if H.transfer_item == nil then
H.transfer_item = function(u, npc, item_id, count)
    if not u or not npc then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    services.inventory.transfer_by_type(u, npc, gid, math.floor(count or 1))
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
if H.var_num_opt == nil then
H.var_num_opt = function(actor, key)
    if not actor then return nil end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return nil end
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
if H.weather_val == nil then
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
end

local EOC = E.run
local COND = E.cond
COND["EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP"] = function(ctx)
    return ((H.global_var_num("free_merchants_hub_trade_route") == 1)) == true
end
ccb.runtime.handler("eoc_test:" .. "EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP"](H.ctx_new(u, npc, vars)) == true
end)
EOC["EOC_BARRY_TELEPORT_HOME"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "barry_return_home_map", { terrain = "horse_farm_isherwood_14" }, { special = H.safe_id('overmap_special', "Isherwood Farm Mutable"), z = math.floor(0) }, { kind = "terrain", id = H.safe_id("terrain", "t_dirt") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "barry_return_home_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_BARRY_TELEPORT_HOME", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_BARRY_TELEPORT_HOME"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP"] = function(ctx)
    if ((H.global_var_num("free_merchants_hub_trade_route") == 1)) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_parking"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_robofac_add_free_merchant_camp" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "free_merchants_hub_trade_route", 2)
        H.eoc_add_effect(H.u(ctx), "robofac_surveillance", 1209600, nil, nil, nil)
        return true
    else
        H.eoc_add_effect(H.u(ctx), "robofac_surveillance", 1209600, nil, nil, nil)
        return false
    end
end
ccb.runtime.handler("eoc:" .. "EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_p_dda_b12e6dcfc828", function(ctx)
    return (((function() local g = H.safe_id('limb_score', "reaction"); if not H.u(ctx) or not g then return 0 end; local r = services.characters.limb_score(H.u(ctx), g, "head"); return (r.ok and r.value) or 0 end)()) < 0.3)
end)
ccb.runtime.handler("w16b_p_dda_4e415c428af8", function(ctx)
    return (((function() local g = H.safe_id('limb_score', "reaction"); if not H.u(ctx) or not g then return 0 end; local r = services.characters.limb_score(H.u(ctx), g, "head"); return (r.ok and r.value) or 0 end)()) >= 0.3)
end)
ccb.runtime.handler("w16b_p_dda_f49cb36318c1", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_BGSS_hospital_2_started_quest", "")))))) and (not ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_BGSS_hospital_2_asked_about_quest", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_timers_hospital_2_asked_about_quest"), 1) < 28800)))))
end)
ccb.runtime.handler("w16b_p_dda_72804463a175", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "directions_prepper_1_SHELTER"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_BGSS_prepper_1_found_computer", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_BGSS_prepper_1_finished_quest", "")))))) and (not ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_BGSS_prepper_1_asked_about_quest", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_timers_prepper_1_asked_about_quest"), 1) < 28800)))))
end)
ccb.runtime.handler("w16b_p_dda_90b0afd7b6d0", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_BGSS_rural_1_started_quest", "")))))) and (not ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_BGSS_rural_1_asked_about_quest", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_timers_rural_1_asked_about_quest"), 1) < 28800)))))
end)
ccb.runtime.handler("w16b_p_dda_1c58771228a9", function(ctx)
    return (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "test_var_time_test_test") and 1 or 0)))
end)
ccb.runtime.handler("w16b_p_dda_ea5bf90cef0b", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).stats or {}).strength or 0) == 5)
end)
ccb.runtime.handler("w16b_p_dda_6fea91d5bb4d", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).stats or {}).dexterity or 0) == 6)
end)
ccb.runtime.handler("w16b_p_dda_43e22f7e9eae", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) == 7)
end)
ccb.runtime.handler("w16b_p_dda_a08e07d0fdc4", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0) == 8)
end)
ccb.runtime.handler("w16b_p_dda_b42a5c8ace2d", function(ctx)
    return ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).strength or 0) == 9)
end)
ccb.runtime.handler("w16b_p_dda_3a23bb33cc46", function(ctx)
    return ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).dexterity or 0) == 10)
end)
ccb.runtime.handler("w16b_p_dda_e23e09fa3832", function(ctx)
    return ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) == 11)
end)
ccb.runtime.handler("w16b_p_dda_22ead6136828", function(ctx)
    return ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).perception or 0) == 12)
end)
ccb.runtime.handler("w16b_p_dda_802fe4499a68", function(ctx)
    return (H.var_num(H.u(ctx), "test_var_compare_test_test") == 1)
end)
ccb.runtime.handler("w16b_p_dda_996003377408", function(ctx)
    return (H.var_num(H.npc(ctx), "test_var_compare_test_test") == 2)
end)
ccb.runtime.handler("w16b_p_dda_731030200866", function(ctx)
    return (H.var_num(H.u(ctx), "test_var_time_test_test") > 259200)
end)
ccb.runtime.handler("w16b_p_dda_a5d0be804693", function(ctx)
    return (services.time.calendar().now.turns_since_cataclysm > 259200)
end)
ccb.runtime.handler("w16b_p_dda_97a897240b77", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) > 3)
end)
ccb.runtime.handler("w16b_p_dda_dacccbaaba96", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "test_var_time_test_test"), 86400) > 3)
end)
ccb.runtime.handler("w16b_p_dda_d6a4df3bce6d", function(ctx)
    return ((services.npcs.count_allies(false) or 0) == 1)
end)
ccb.runtime.handler("w16b_p_dda_ea38d9832630", function(ctx)
    return (H.char_cash(H.u(ctx)) == 13)
end)
ccb.runtime.handler("w16b_p_dda_2b1254eb4fba", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") == 14)
end)
ccb.runtime.handler("w16b_p_dda_cb4aa6b41926", function(ctx)
    return (H.char_skill(H.u(ctx), "driving") >= 5)
end)
ccb.runtime.handler("w16b_p_dda_2563f67083af", function(ctx)
    local tf = (((H.weather_val("temperature")) - 273.15) * 9 / 5 + 32)
    return (math.abs(tf - 21) < 1e-4)
end)
ccb.runtime.handler("w16b_p_dda_8ce79186006d", function(ctx)
    return (H.weather_val("windpower") == 15)
end)
ccb.runtime.handler("w16b_p_dda_62fb6ceaf359", function(ctx)
    return (H.weather_val("humidity") == 16)
end)
ccb.runtime.handler("w16b_p_dda_f59862852067", function(ctx)
    return (H.weather_val("pressure") == 17)
end)
ccb.runtime.handler("w16b_p_dda_95289e55d756", function(ctx)
    return (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.x or 0 end)()) == (-1))
end)
ccb.runtime.handler("w16b_p_dda_27758327e663", function(ctx)
    return (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.y or 0 end)()) == (-2))
end)
ccb.runtime.handler("w16b_p_dda_8dfc2fdf3dfd", function(ctx)
    return (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-3))
end)
ccb.runtime.handler("w16b_p_dda_a04859da77d7", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) == 21)
end)
ccb.runtime.handler("w16b_p_dda_a2c57ec76b37", function(ctx)
    return (H.char_bionic_power(H.u(ctx), "power") == 22)
end)
ccb.runtime.handler("w16b_p_dda_88a96a2e8c2c", function(ctx)
    return (H.char_bionic_power(H.u(ctx), "power_max") == 44)
end)
ccb.runtime.handler("w16b_p_dda_f209a481c625", function(ctx)
    return (H.char_bionic_power(H.u(ctx), "power_percentage") == 50)
end)
ccb.runtime.handler("w16b_p_dda_688b0787b602", function(ctx)
    return (H.char_val_extra(H.u(ctx), "morale") == 23)
end)
ccb.runtime.handler("w16b_p_dda_436f11a7f423", function(ctx)
    return (H.char_val_extra(H.u(ctx), "focus") == 24)
end)
ccb.runtime.handler("w16b_p_dda_416c48f74e8b", function(ctx)
    return (H.char_mana(H.u(ctx), "current") == 25)
end)
ccb.runtime.handler("w16b_p_dda_732f5d5dda9a", function(ctx)
    return (H.char_mana(H.u(ctx), "maximum") == 900)
end)
ccb.runtime.handler("w16b_p_dda_46a1e9e55a4d", function(ctx)
    return (H.round_half_away(((function() local m, mx = H.char_mana(H.u(ctx), 'current'), H.char_mana(H.u(ctx), 'maximum'); if mx == 0 then return 0 end; return m * 100.0 / mx end)())) == 3)
end)
ccb.runtime.handler("w16b_p_dda_735386b579a6", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).needs or {}).hunger or 0) == 26)
end)
ccb.runtime.handler("w16b_p_dda_cb3105d35e85", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) == 27)
end)
ccb.runtime.handler("w16b_p_dda_4441a42133a8", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) == 118169)
end)
ccb.runtime.handler("w16b_p_dda_16e4aaba5202", function(ctx)
    return (((function() local g = H.safe_id('item', "bottle_glass"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.resources(H.u(ctx), g, 0); return (r.ok and r.value and r.value.amount) or 0 end)()) == 3)
end)
ccb.runtime.handler("w16b_p_dda_7ef5417321f1", function(ctx)
    return (H.char_val_extra(H.u(ctx), "exp") >= 35)
end)
ccb.runtime.handler("w16b_p_dda_1435fe7e1b0b", function(ctx)
    return (H.char_school_level(H.u(ctx), "test_trait") == 1)
end)
ccb.runtime.handler("w16b_p_dda_8b9b62c0ddf5", function(ctx)
    return (H.char_spell_level(H.u(ctx), "test_spell_pew") == 4)
end)
ccb.runtime.handler("w16b_p_dda_e8aa589e96a3", function(ctx)
    return (H.char_spell_level(H.u(ctx), "null") == 12)
end)
ccb.runtime.handler("w16b_p_dda_2b2853b944ac", function(ctx)
    return (H.char_spell_exp(H.u(ctx), "test_spell_pew") == (-1))
end)
ccb.runtime.handler("w16b_p_dda_fdb201c824ef", function(ctx)
    return (H.char_spell_exp(H.u(ctx), "test_spell_pew") == 11006)
end)
ccb.runtime.handler("w16b_p_dda_5f16cecb862b", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_test", "percent") == 50)
end)
ccb.runtime.handler("w16b_p_dda_8bf1238481f0", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_test", "time_spent") == 43200)
end)
ccb.runtime.handler("w16b_p_dda_6c23c0fa4fb9", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_test", "permille") == 500)
end)
ccb.runtime.handler("w16b_p_dda_862d6e58552b", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_test", "total_time_required") == 86400)
end)
ccb.runtime.handler("w16b_p_dda_d2df3b5af968", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_test", "time_left") == 43200)
end)
ccb.runtime.handler("w16b_p_dda_de8f08751c84", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (20))
end)
ccb.runtime.handler("w16b_p_dda_dea9207e769e", function(ctx)
    return services.gameplay.mods.is_loaded("test_data")
end)
ccb.runtime.handler("w16b_p_dda_0997d9a9b6c0", function(ctx)
    return services.gameplay.mods.is_loaded("innawood")
end)
ccb.runtime.handler("w16b_p_dda_f87ec3601d53", function(ctx)
    return (not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx)))
end)
ccb.runtime.handler("w16b_p_dda_037554c6f987", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))))
end)
ccb.runtime.handler("w16b_p_dda_a76cf81eed9a", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))) and (not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))))
end)
ccb.runtime.handler("w16b_p_dda_c2e678cb6658", function(ctx)
    return ((H.char_stat(H.u(ctx), "intelligence") >= (9)) and (not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))))
end)
ccb.runtime.handler("w16b_p_dda_dc51ec3d87da", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))) and (H.char_stat(H.u(ctx), "perception") >= (6)))
end)
ccb.runtime.handler("w16b_p_dda_de1e55061561", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_exodii_seen_zomborg", "")))))
end)
ccb.runtime.handler("w16b_p_dda_5b9226edb420", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_found_string_dimension_exodii", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knowledge_exodii_transdimensional_u_knows_exodiilore", "")))) and (not (H.char_has_mission(H.u(ctx), "EXODII_MISSION_STRING_DIMENSION_EXODII"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_returned_string_dimension_data", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_f3d7c0356e2f", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and (H.global_var_num("labyrinth_access_points") == 0) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_exodii_wrist_computer", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "encountered_labyrinth_entry_error", "")))))
end)
ccb.runtime.handler("w16b_p_dda_aef38dda53d8", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_started_rubik_intro", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_midpoint_rubik_intro", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_1710f68df35f", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_started_rubik_intro", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_midpoint_rubik_intro", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_completed_rubik_intro", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_7d64cdd41d7f", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "Rubik_promised_cyberframe", "")))))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (((function() local g = H.safe_id('faction', "exodii"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0 end)()) < 40))
end)
ccb.runtime.handler("w16b_p_dda_3aac3d7c917f", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "Rubik_promised_cyberframe", "")))))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (((function() local g = H.safe_id('faction', "exodii"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0 end)()) >= 40))
end)
ccb.runtime.handler("w16b_p_dda_de8b9088eb74", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (H.npc_faction_trust(H.npc(ctx)) >= (2)) and H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") and (H.global_var_num("isherwood_gear_status") < 1) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "npc_dialogue_exodii_npc_bought_riot_gear", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_1e86b617dd38", function(ctx)
    return H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx)
end)
ccb.runtime.handler("w16b_p_dda_f8ac3175f0cf", function(ctx)
    return H.test_eoc("EOC_CONDITION_EXODII_MERCHANT_HATES_HUB_CYBORGS", ctx)
end)
ccb.runtime.handler("w16b_p_dda_e40c0706bcf4", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "sold") >= 20) and (not ((H.npc_faction_trust(H.npc(ctx)) >= (20)))))
end)
ccb.runtime.handler("w16b_p_dda_8a0ddf33a30b", function(ctx)
    return (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm") or H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg") or H.char_has_bionic(H.u(ctx), "bio_robofac_xmback") or H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))
end)
ccb.runtime.handler("w16b_p_dda_439c117de034", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "scenario_trapped_in_labyrinth", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_b8a61b70c35e", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "scenario_trapped_in_labyrinth", "")))))
end)
ccb.runtime.handler("w16b_p_dda_49b3fd9b74fd", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))
end)
ccb.runtime.handler("w16b_p_dda_3f1f3df96845", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))
end)
ccb.runtime.handler("w16b_p_dda_26458169301f", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_cybor_rescue_operating"), 1) < 86400) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_exodii_cybor_rescue_ongoing", "")))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))
end)
ccb.runtime.handler("w16b_p_dda_49b6a452e65e", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_cybor_rescue_operating"), 1) > 86400) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_exodii_cybor_rescue_ongoing", "")))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))
end)
ccb.runtime.handler("w16b_p_dda_c54f80cbe79c", function(ctx)
    return ((not (H.test_eoc("EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK", ctx))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_exodii_cybor_rescue_ongoing", "")))))) and (H.char_has_items(H.u(ctx), "bot_broken_cyborg", math.floor(1), math.floor(0)) or H.char_has_items(H.u(ctx), "bot_prototype_cyborg", math.floor(1), math.floor(0))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmarm"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmleg"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmback"))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))
end)
ccb.runtime.handler("w16b_p_dda_80b5b0d720d2", function(ctx)
    return H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx)
end)
ccb.runtime.handler("w16b_p_dda_0bba7149a4ea", function(ctx)
    return (not (H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx)))
end)
ccb.runtime.handler("w16b_p_dda_866fa9af59a5", function(ctx)
    return (H.npc_mood_read(H.u(ctx), "anger") >= 5)
end)
ccb.runtime.handler("w16b_p_dda_68bfd4661f4b", function(ctx)
    return ((H.npc_mood_read(H.u(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_food_guard", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_2d84e4efe5a2", function(ctx)
    return ((H.npc_mood_read(H.u(ctx), "anger") >= 5) or ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))
end)
ccb.runtime.handler("w16b_p_dda_1992fc90a741", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_fixing_records"), 1) >= 172800)
end)
ccb.runtime.handler("w16b_p_dda_a3b7bae96d63", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_ISHERWOOD_BARRY")
end)
ccb.runtime.handler("w16b_p_dda_e2c5118024d8", function(ctx)
    return ((H.global_var_num("isherwood_family_coming") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_barry_following", "")))))
end)
ccb.runtime.handler("w16b_p_dda_80c4c2e841bf", function(ctx)
    return (H.global_var_num("isherwood_gear_status") < 1)
end)
ccb.runtime.handler("w16b_p_dda_c2662bc2e1a2", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS"))) and (H.global_var_num("isherwood_wall_status") < 1))
end)
ccb.runtime.handler("w16b_p_dda_32f199590268", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_weapon"), 86400) >= H.var_num(H.u(ctx), "number_artisans_blacksmith_weapon_wait"))
end)
ccb.runtime.handler("w16b_p_dda_7a7e2f4c6908", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_5d4551e0e533", function(ctx)
    return ((H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") > 0) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_28fd8e34d739", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") == 0)
end)
ccb.runtime.handler("w16b_p_dda_861af27f2207", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (55 / 2))
end)
ccb.runtime.handler("w16b_p_dda_5dc618fe9ff6", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (77 / 2))
end)
ccb.runtime.handler("w16b_p_dda_11c5cc03e2e7", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (33 / 2))
end)
ccb.runtime.handler("w16b_p_dda_66e64e5662e5", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (22 / 2))
end)
ccb.runtime.handler("w16b_p_dda_0bec469baad8", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (25 / 2))
end)
ccb.runtime.handler("w16b_p_dda_b14850e0e087", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (28 / 2))
end)
ccb.runtime.handler("w16b_p_dda_5388395cedb3", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (12 / 2))
end)
ccb.runtime.handler("w16b_p_dda_d9e47d35f199", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (38 / 2))
end)
ccb.runtime.handler("w16b_p_dda_a8b0bed64712", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (30 / 2))
end)
ccb.runtime.handler("w16b_p_dda_e8a731c09208", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (14 / 2))
end)
ccb.runtime.handler("w16b_p_dda_2b602775fa98", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (16 / 2))
end)
ccb.runtime.handler("w16b_p_dda_b720d09d6e36", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (27 / 2))
end)
ccb.runtime.handler("w16b_p_dda_2c6e26f233eb", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (24 / 2))
end)
ccb.runtime.handler("w16b_p_dda_5700f9e32497", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (26 / 2))
end)
ccb.runtime.handler("w16b_p_dda_581f2e41dad7", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (52 / 2))
end)
ccb.runtime.handler("w16b_p_dda_5d904ebfe258", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (58 / 2))
end)
ccb.runtime.handler("w16b_p_dda_c20e69f0c19b", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (154 / 2))
end)
ccb.runtime.handler("w16b_p_dda_f1799b0ea08a", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= (231 / 2))
end)
ccb.runtime.handler("w16b_p_dda_c440239d00c0", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_rounds"), 3600) >= H.var_num(H.u(ctx), "number_artisans_gunsmith_wait"))
end)
ccb.runtime.handler("w16b_p_dda_f3512244819a", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_price") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_b44d0ed910c9", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_2x4") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_1f18058dc2f7", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_plank_short") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_8ce0fa17f798", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_plank_long") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_a98905572bea", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wooden_post") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_f843738f852c", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wooden_post_short") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_faf9ad0ea1e3", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wooden_post_long") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_beb9347a6c6c", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wood_panel") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_3383b84f4e86", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wood_sheet") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_fbcbf08e9e22", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_wood_beam") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_6877a61d1f1b", function(ctx)
    return (H.var_num(H.npc(ctx), "number_fabricate_log") ~= 0)
end)
ccb.runtime.handler("w16b_p_dda_42ad73717088", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "timer_fabricate_waiting"), 86400) >= H.var_num(H.npc(ctx), "number_fabricate_wait"))
end)
ccb.runtime.handler("w16b_p_dda_13cced564466", function(ctx)
    return ((H.npc_mood_read(H.u(ctx), "trust") >= 2) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_first_meeting_talked_to_logger", "")))))
end)
ccb.runtime.handler("w16b_p_dda_b49f7ca57e70", function(ctx)
    return ((H.npc_mood_read(H.u(ctx), "trust") >= 2) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_first_meeting_knows_u", "")))))
end)
ccb.runtime.handler("w16b_p_dda_8fcd96d5462f", function(ctx)
    return ((not H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "timer_teamster_directions_recycler") and 1 or 0))) or (H.time_since(H.var_num_opt(H.npc(ctx), "timer_teamster_directions_recycler"), 1) >= 172800))
end)
ccb.runtime.handler("w16b_p_dda_eab15290189e", function(ctx)
    return ((H.global_var_num("godco_freemerch_representative_dead") ~= 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_trade_u_think_suspicious_price", "")))) and (not (H.char_has_mission(H.u(ctx), "MISSION_INVESTIGATE_TRADER"))))
end)
ccb.runtime.handler("w16b_p_dda_62e742a59346", function(ctx)
    return ((H.global_var_num("godco_freemerch_representative_dead") ~= 1) and H.char_has_mission(H.u(ctx), "MISSION_INVESTIGATE_TRADER") and H.char_has_item(H.u(ctx), "godcotrader_accounting_records_dirty"))
end)
ccb.runtime.handler("w16b_p_dda_9a64a4490965", function(ctx)
    return ((H.global_var_num("godco_freemerch_representative_dead") ~= 1) and H.char_has_mission(H.u(ctx), "MISSION_INVESTIGATE_TRADER") and H.char_has_item(H.u(ctx), "godcotrader_accounting_records_clean"))
end)
ccb.runtime.handler("w16b_p_dda_c49833a17225", function(ctx)
    return (H.global_var_num("exodii_FM_antagonized") >= 5)
end)
ccb.runtime.handler("w16b_p_dda_679bee254e20", function(ctx)
    return (H.global_var_num("exodii_FM_annoyed") >= 3)
end)
ccb.runtime.handler("w16b_p_dda_b4a71b11572d", function(ctx)
    return ((not ((H.global_var_num("exodii_FM_antagonized") >= 5))) and (H.global_var_num("exodii_FM_annoyed") >= 3))
end)
ccb.runtime.handler("w16b_p_dda_7676c8d1ead1", function(ctx)
    return ((not ((H.global_var_num("exodii_FM_antagonized") >= 5))) and (not ((H.global_var_num("exodii_FM_annoyed") >= 3))) and (H.global_var_num("exodii_FM_balance") <= 0))
end)
ccb.runtime.handler("w16b_p_dda_73f94f9c82ab", function(ctx)
    return ((not ((H.global_var_num("exodii_FM_antagonized") >= 5))) and (not ((H.global_var_num("exodii_FM_annoyed") >= 3))) and (H.global_var_num("exodii_FM_balance") > 0))
end)
ccb.runtime.handler("w16b_p_dda_8b2c9e90f0af", function(ctx)
    return (H.faction_food("free_merchants", "human_flesh_vitamin") < 1)
end)
ccb.runtime.handler("w16b_p_dda_05358c4abb14", function(ctx)
    return (H.global_var_num("hub01_intercom_locked") == 1)
end)
ccb.runtime.handler("w16b_p_dda_a851a16c0202", function(ctx)
    return (((not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) or ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_knows_about_u_cyberframe", "")))))) and (not ((H.global_var_num("hub01_intercom_locked") == 1))) and (((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))
end)
ccb.runtime.handler("w16b_p_dda_9212c5541e94", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_knows_about_u_cyberframe", ""))))))) and (not ((H.global_var_num("hub01_intercom_locked") == 1))) and (((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))
end)
ccb.runtime.handler("w16b_p_dda_b23e0697bc03", function(ctx)
    return ((not ((H.global_var_num("hub01_intercom_locked") == 1))) and (not ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_1"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_informed_robofac_of_exodii", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_50779c75cf34", function(ctx)
    return ((not ((H.global_var_num("hub01_intercom_locked") == 1))) and (not ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))) and H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_1"))
end)
ccb.runtime.handler("w16b_p_dda_08c1915085bb", function(ctx)
    return ((not ((H.global_var_num("hub01_intercom_locked") == 1))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_informed_robofac_of_exodii", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_give_robofac_exodii_info", "")))))) and (not ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))))
end)
ccb.runtime.handler("w16b_p_dda_405869359679", function(ctx)
    return ((not ((H.global_var_num("hub01_intercom_locked") == 1))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_give_robofac_exodii_info", "")))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_1"))) and (not ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_trade_unlocked", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_intercom_npc_intercom_trade", ""))))))))
end)
ccb.runtime.handler("w16b_p_dda_fcab9102c2fe", function(ctx)
    return ((not ((H.global_var_num("hub01_intercom_locked") == 1))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_u_met_robofac_intercom", "")))))))
end)
ccb.runtime.handler("w16b_p_dda_1a48db796a76", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_armor"), 1) >= 86400)
end)
ccb.runtime.handler("w16b_p_dda_7ece59ddc907", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_armor"), 1) >= 86400) and H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(6), math.floor(0)))
end)
ccb.runtime.handler("w16b_p_dda_55a9c64ca06c", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_hub"), 1) >= 86400)
end)
ccb.runtime.handler("w16b_p_dda_b48c54e1e2a9", function(ctx)
    return ((H.global_var_num("hub01_uhmwpe_researched") ~= 1) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_gave_armor_disk") and 1 or 0)))
end)
ccb.runtime.handler("w16b_p_dda_51aa2fb965a7", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(6), math.floor(0)) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_can_buy_armor") and 1 or 0)))
end)
ccb.runtime.handler("w16b_p_dda_f21d2511f384", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_robofac_merc_1_robofac_merc_1_HWP") and 1 or 0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_24d90ed9d882", function(ctx)
    return H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_gun") and 1 or 0))
end)
ccb.runtime.handler("w16b_p_dda_690ac67f75b5", function(ctx)
    return H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_armor_type") and 1 or 0))
end)
ccb.runtime.handler("w16b_p_dda_bfd9d51e57e1", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_completed_anchor_pt_1") and 1 or 0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_3c717f06f9ce", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_completed_resonance_suit_pt_1") and 1 or 0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_a6e0a06374ab", function(ctx)
    return (H.char_has_items(H.u(ctx), "phase_immersion_suit", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_be11e37ce5f8", function(ctx)
    return (H.char_has_items(H.u(ctx), "rm13_armor", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_2db687ba25ae", function(ctx)
    return (H.char_has_items(H.u(ctx), "combat_exoskeleton_light_salvaged", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_8434301dc662", function(ctx)
    return (H.char_has_items(H.u(ctx), "robofac_resonance_suit", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_4c3b44384355", function(ctx)
    return (H.char_has_items(H.u(ctx), "dimensional_anchor", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_completed_anchor_pt_1") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_11f1425194b0", function(ctx)
    return (H.char_has_items(H.u(ctx), "xedra_artifact_cleansuit", math.floor(1), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_completed_resonance_suit_pt_1") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_c54cbad21301", function(ctx)
    return (H.char_has_items(H.u(ctx), "xedra_mobile_weather_station", math.floor(1), math.floor(0)) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_accepted_robofac_intercom_mws_4", "")))) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_completed_mws") and 1 or 0))))
end)
ccb.runtime.handler("w16b_p_dda_bb9ae721a5aa", function(ctx)
    return ((H.global_var_num("hub01_hwp_exotic_researched") ~= 1) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_project_ongoing") and 1 or 0))) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_has_researched_gun") and 1 or 0)) and (H.char_has_items(H.u(ctx), "pamd68", math.floor(1), math.floor(0)) or H.char_has_items(H.u(ctx), "pamd71z", math.floor(1), math.floor(0))))
end)
ccb.runtime.handler("w16b_a_dda_552b8eb02578", function(ctx)
    H.run_eoc("EOC_PORTAL_INNER_CABINS", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_bff2189d5b26", function(ctx)
    H.run_eoc("EOC_HOSPITAL_2_MAKE_MISSION", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> marks the location of the cabin on your map.")))
end)
ccb.runtime.handler("w16b_a_dda_e1e3d10f9e00", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_timers_hospital_2_asked_about_quest", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_7f8ee2dc5183", function(ctx)
    H.run_eoc("EOC_PREPPER_1_MAKE_MISSION", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> marks the location of the LMOE shelter on your map.")))
end)
ccb.runtime.handler("w16b_a_dda_4bccdb13b4fc", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_timers_prepper_1_asked_about_quest", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_31d3731a9cd1", function(ctx)
    H.run_eoc("EOC_RURAL_1_MAKE_MISSION", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> marks the location of the farm on your map.")))
end)
ccb.runtime.handler("w16b_a_dda_73816ff3f794", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_timers_rural_1_asked_about_quest", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_89685fa0d951", function(ctx)
    H.run_eoc("reset_all_artificial_hair_types", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_927fd590eb13", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_buzzcut" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7101b99cd6e7", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_crewcut" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8df49b5239c1", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_short" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_125491ba34d2", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_short_no_fringe" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_199810340b53", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_short_over_eye" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_44cf34ec31cd", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_modern" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_19842edbd1cb", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_detective" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6bb38f99499c", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_medium" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ae4f09621b8d", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_puff" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7d7818269974", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_mohawk" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_beeb9578c166", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_beaded" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_afa389ee0c22", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_curls" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6a29c531bde1", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_super_princess" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_aa0a3011d93b", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_long_mohawk" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1f6bcc97bfcf", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_long" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_fabecba9acab", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_long_over_eye" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_9d371d21babd", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_mullet" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b90c499c9a51", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_bun" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_fb902a490826", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_messy" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_02bf275f2fe5", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_punk_long" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_3e32ada01034", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_very_long" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b248c4d056e6", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_twintails" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_0bd3fa962f5a", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_braid" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6e7dfa84b913", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_extremely_long" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b06d7a75c135", function(ctx)
    H.run_eoc("reset_all_hair_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_body_length" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6425c454723d", function(ctx)
    H.run_eoc("reset_all_beard_types", ctx, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_shave"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(5), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
end)
ccb.runtime.handler("w16b_a_dda_bbba2c52d514", function(ctx)
    H.run_eoc("EOC_swap_glass_book_for_eyes", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8aa0c6c12124", function(ctx)
    H.run_eoc("EOC_swap_glass_boat_for_legs", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_310c8f069d11", function(ctx)
    H.run_eoc("EOC_swap_glass_apple_for_arms", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_436f6f0b54ed", function(ctx)
    H.run_eoc("EOC_repair_imperfect_doll", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_5d4a44ef57cd", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(20), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HAUNTING"), nil) end end
    H.run_eoc("EOC_HAUNTING_SPAWN", ctx, nil, nil, nil)
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "merc_spike_transform"); if _p and _g then services.world.transform_radius(_p, math.floor(5), _g, nil) end end
end)
ccb.runtime.handler("w16b_a_dda_48b645e592e5", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "test_var_compare_test_test", (H.var_num(H.u(ctx), "test_var_compare_test_test")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_a1814a6695f8", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "test_var_compare_test_test", (H.var_num(H.npc(ctx), "test_var_compare_test_test")) + (2))
end)
ccb.runtime.handler("w16b_a_dda_2894c75d3664", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "test_var_time_test_test", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_d1b62e3589c1", function(ctx)
    do local _cur = services.turn(); local _nxt = (services.time.calendar().start_of_cataclysm.turn + 1); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.time.set_now(services.time.point(math.floor(_val + 0.5))) end
end)
ccb.runtime.handler("w16b_a_dda_0a83d28d6f7b", function(ctx)
    do local _cur = H.weather_val('temperature'); local _nxt = ((((2) - 32) * 5 / 9) + 273.15); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_current_temperature(services.units.new('temperature', _val, 'kelvin')) end
end)
ccb.runtime.handler("w16b_a_dda_845b8147c0bb", function(ctx)
    do local _cur = H.weather_val('windpower'); local _nxt = 3; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_windpower(_val) end
end)
ccb.runtime.handler("w16b_a_dda_4902b8ddc893", function(ctx)
    do local _cur = H.weather_val('humidity'); local _nxt = 4; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_humidity(_val) end
end)
ccb.runtime.handler("w16b_a_dda_623880eb6250", function(ctx)
    do local _cur = H.weather_val('pressure'); local _nxt = 5; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_pressure(_val) end
end)
ccb.runtime.handler("w16b_a_dda_207fb41f2b18", function(ctx)
    do local _a = H.u(ctx); if _a then local _cur = H.char_stat(_a, "strength_base"); local _nxt = 6; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.characters.set_attributes(_a, { strength_base = math.modf(_val) }) end end
end)
ccb.runtime.handler("w16b_a_dda_b4c9a0a7674c", function(ctx)
    do local _a = H.u(ctx); if _a then local _cur = H.char_stat(_a, "dexterity_base"); local _nxt = 7; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.characters.set_attributes(_a, { dexterity_base = math.modf(_val) }) end end
end)
ccb.runtime.handler("w16b_a_dda_5aa773b4f295", function(ctx)
    do local _a = H.u(ctx); if _a then local _cur = H.char_stat(_a, "intelligence_base"); local _nxt = 8; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.characters.set_attributes(_a, { intelligence_base = math.modf(_val) }) end end
end)
ccb.runtime.handler("w16b_a_dda_e7347f90de1f", function(ctx)
    do local _a = H.u(ctx); if _a then local _cur = H.char_stat(_a, "perception_base"); local _nxt = 9; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.characters.set_attributes(_a, { perception_base = math.modf(_val) }) end end
end)
ccb.runtime.handler("w16b_a_dda_c1e2b4e0ad3c", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "test_var_time_test_test", 10)
end)
ccb.runtime.handler("w16b_a_dda_0670d453bcdc", function(ctx)
    do local _a = H.npc(ctx); if _a then local _cur = H.npc_opinion(_a, 'owed'); local _nxt = 12; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.npcs.add_debt(_a, math.modf(_val) - math.modf(_cur)) end end
end)
ccb.runtime.handler("w16b_a_dda_d4b4d11c521c", function(ctx)
    local _a1 = H.u(ctx)
    local _skg2 = H.safe_id("skill", "driving")
    if _a1 and _skg2 then
        local _lv3 = math.max(0, math.min(10, math.floor(10)))
        local _sr4 = services.skills.get(_a1, _skg2)
        local _kv5 = (_sr4.ok and _sr4.value and _sr4.value.knowledge) or 0
        services.skills.set(_a1, _skg2, { practical = _lv3, knowledge = math.max(_kv5, _lv3) })
    end
end)
ccb.runtime.handler("w16b_a_dda_e2904fa1c74d", function(ctx)
    do local _a = H.u(ctx); local _cs = H.creature_snap(_a); local _p = _cs and _cs.position; if _a and _p then local _cur = _p.x; local _nxt = (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.x or 0 end)()) - 1); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); local _iv = math.modf(_val); services.relocation.set_position(_a, services.coords.tripoint_abs_ms(_iv, _p.y, _p.z)) end end
end)
ccb.runtime.handler("w16b_a_dda_bb4395a11939", function(ctx)
    do local _a = H.u(ctx); local _cs = H.creature_snap(_a); local _p = _cs and _cs.position; if _a and _p then local _cur = _p.y; local _nxt = (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.y or 0 end)()) + 2); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); local _iv = math.modf(_val); services.relocation.set_position(_a, services.coords.tripoint_abs_ms(_p.x, _iv, _p.z)) end end
end)
ccb.runtime.handler("w16b_a_dda_120d234f7206", function(ctx)
    do local _a = H.u(ctx); local _cs = H.creature_snap(_a); local _p = _cs and _cs.position; if _a and _p then local _cur = _p.z; local _nxt = (-3); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); local _iv = math.modf(_val); services.relocation.set_position(_a, services.coords.tripoint_abs_ms(_p.x, _p.y, _iv)) end end
end)
ccb.runtime.handler("w16b_a_dda_df8e5d0d7318", function(ctx)
    local _a6 = H.u(ctx)
    if _a6 then services.characters.adjust(_a6, { pain = math.floor((17) - (H.char_pain(_a6))) }) end
end)
ccb.runtime.handler("w16b_a_dda_65d858935d6c", function(ctx)
    H.set_bionic_power(H.u(ctx), 18, "=")
end)
ccb.runtime.handler("w16b_a_dda_d3af9b5c9cbc", function(ctx)
    do local _a = H.u(ctx); if _a then local _cur = H.char_bionic_power(_a, 'power_percentage'); local _nxt = 20; local _pct = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); local _tv = math.modf((H.char_bionic_power(_a, 'power_max') * _pct) / 100); H.set_bionic_power(_a, _tv, '=') end end
end)
ccb.runtime.handler("w16b_a_dda_13c496b2fe31", function(ctx)
    H.set_char_val_extra(H.u(ctx), "focus", 19, "=")
end)
ccb.runtime.handler("w16b_a_dda_5d09447434f1", function(ctx)
    local _a7 = H.u(ctx)
    if _a7 then services.spells.set_mana_raw(_a7, math.floor(21)) end
end)
ccb.runtime.handler("w16b_a_dda_a0cda0deda0a", function(ctx)
    do local _a = H.u(ctx); if _a then local _mx = H.char_mana(_a, 'maximum'); local _cur = (_mx == 0) and 0 or (H.char_mana(_a, 'current') * 100.0 / _mx); local _nxt = 25; local _pct = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); local _tv = math.modf((_mx * _pct) / 100); services.spells.set_mana_raw(_a, _tv) end end
end)
ccb.runtime.handler("w16b_a_dda_6b06b9425874", function(ctx)
    H.set_char_val_extra(H.u(ctx), "thirst", 22, "=")
end)
ccb.runtime.handler("w16b_a_dda_84c70d28f09e", function(ctx)
    do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(23 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 23; local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
end)
ccb.runtime.handler("w16b_a_dda_cb127a1d7bb8", function(ctx)
    local _a8 = H.u(ctx)
    local _sn9 = "test_spell_pew"
    local _sg10 = (_sn9 ~= "") and H.safe_id("spell", _sn9) or nil
    if _a8 and _sg10 then services.spells.set_level(_a8, _sg10, math.floor((-1))) end
end)
ccb.runtime.handler("w16b_a_dda_5f2e824e1b69", function(ctx)
    local _a11 = H.u(ctx)
    local _sn12 = "test_spell_pew"
    local _sg13 = (_sn12 ~= "") and H.safe_id("spell", _sn12) or nil
    if _a11 and _sg13 then services.spells.set_level(_a11, _sg13, math.floor(4)) end
end)
ccb.runtime.handler("w16b_a_dda_573593b7ac2b", function(ctx)
    do local _a, _sp = H.u(ctx), "test_spell_pew"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = (-1); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
end)
ccb.runtime.handler("w16b_a_dda_b98cfb2839e4", function(ctx)
    do local _a, _sp = H.u(ctx), "test_spell_pew"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = 11006; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
end)
ccb.runtime.handler("w16b_a_dda_55a47adcb2f3", function(ctx)
    H.add_proficiency_progress(H.u(ctx), "prof_test", 43200, "time_spent", true, "=")
end)
ccb.runtime.handler("w16b_a_dda_ebeafd012f70", function(ctx)
    H.add_proficiency_progress(H.u(ctx), "prof_test", (-1), "time_spent", true, "=")
end)
ccb.runtime.handler("w16b_a_dda_5be3277e80d1", function(ctx)
    H.add_proficiency_progress(H.u(ctx), "prof_test", 86400, "time_spent", true, "=")
end)
ccb.runtime.handler("w16b_a_dda_1027aa3dacc5", function(ctx)
    H.add_proficiency_progress(H.u(ctx), "prof_test", 3600, "time_spent", false, "+=")
end)
ccb.runtime.handler("w16b_a_dda_38fb458cc012", function(ctx)
    local _n14, _u15 = H.npc(ctx), H.u(ctx)
    if _n14 and _u15 then
        local _pay16 = services.trade.pay(_n14, _u15, math.floor(1000))
        if _pay16.ok and _pay16.value == true then
            H.receive_item(_u15, "bandages", 20, "bag_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_31798cba046f", function(ctx)
    local _n17, _u18 = H.npc(ctx), H.u(ctx)
    if _n17 and _u18 then
        local _pay19 = services.trade.pay(_n17, _u18, math.floor(4000))
        if _pay19.ok and _pay19.value == true then
            H.receive_item(_u18, "aspirin", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_bef675a8b944", function(ctx)
    local _n20, _u21 = H.npc(ctx), H.u(ctx)
    if _n20 and _u21 then
        local _pay22 = services.trade.pay(_n20, _u21, math.floor(5000))
        if _pay22.ok and _pay22.value == true then
            H.receive_item(_u21, "gas_fungicidal", 1500, "jug_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_90b121a26a40", function(ctx)
    local _n23, _u24 = H.npc(ctx), H.u(ctx)
    if _n23 and _u24 then
        local _pay25 = services.trade.pay(_n23, _u24, math.floor(5000))
        if _pay25.ok and _pay25.value == true then
            H.receive_item(_u24, "fungicide", 1500, "bottle_twoliter")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_699951ea0282", function(ctx)
    local _n26, _u27 = H.npc(ctx), H.u(ctx)
    if _n26 and _u27 then
        local _pay28 = services.trade.pay(_n26, _u27, math.floor(5000))
        if _pay28.ok and _pay28.value == true then
            H.receive_item(_u27, "disinfectant", 20, "bottle_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_5ec2560186ec", function(ctx)
    local _n29, _u30 = H.npc(ctx), H.u(ctx)
    if _n29 and _u30 then
        local _pay31 = services.trade.pay(_n29, _u30, math.floor(12000))
        if _pay31.ok and _pay31.value == true then
            H.receive_item(_u30, "antibiotics", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_5a05faa5ecf4", function(ctx)
    local _n32, _u33 = H.npc(ctx), H.u(ctx)
    if _n32 and _u33 then
        local _pay34 = services.trade.pay(_n32, _u33, math.floor(14000))
        if _pay34.ok and _pay34.value == true then
            H.receive_item(_u33, "antifungal", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_92d3caf53017", function(ctx)
    local _n35, _u36 = H.npc(ctx), H.u(ctx)
    if _n35 and _u36 then
        local _pay37 = services.trade.pay(_n35, _u36, math.floor(20000))
        if _pay37.ok and _pay37.value == true then
            H.receive_item(_u36, "chem_black_powder", 10000, "jar_3l_glass_sealed")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_11d21b998c8f", function(ctx)
    local _n38, _u39 = H.npc(ctx), H.u(ctx)
    if _n38 and _u39 then
        local _pay40 = services.trade.pay(_n38, _u39, math.floor(30000))
        if _pay40.ok and _pay40.value == true then
            H.receive_item(_u39, "napalm", 10000, "jerrycan")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_d4fd5df8fea1", function(ctx)
    local _n41, _u42 = H.npc(ctx), H.u(ctx)
    if _n41 and _u42 then
        local _pay43 = services.trade.pay(_n41, _u42, math.floor(1000))
        if _pay43.ok and _pay43.value == true then
            H.receive_item(_u42, "bandages", 20, "bag_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_e7223a8a52ba", function(ctx)
    local _n44, _u45 = H.npc(ctx), H.u(ctx)
    if _n44 and _u45 then
        local _pay46 = services.trade.pay(_n44, _u45, math.floor(4000))
        if _pay46.ok and _pay46.value == true then
            H.receive_item(_u45, "aspirin", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_6beb02908b54", function(ctx)
    local _n47, _u48 = H.npc(ctx), H.u(ctx)
    if _n47 and _u48 then
        local _pay49 = services.trade.pay(_n47, _u48, math.floor(5000))
        if _pay49.ok and _pay49.value == true then
            H.receive_item(_u48, "gas_fungicidal", 1500, "jug_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_e72cb0ba728b", function(ctx)
    local _n50, _u51 = H.npc(ctx), H.u(ctx)
    if _n50 and _u51 then
        local _pay52 = services.trade.pay(_n50, _u51, math.floor(5000))
        if _pay52.ok and _pay52.value == true then
            H.receive_item(_u51, "fungicide", 1500, "bottle_twoliter")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_0bc8fa32c4cc", function(ctx)
    local _n53, _u54 = H.npc(ctx), H.u(ctx)
    if _n53 and _u54 then
        local _pay55 = services.trade.pay(_n53, _u54, math.floor(5000))
        if _pay55.ok and _pay55.value == true then
            H.receive_item(_u54, "disinfectant", 20, "bottle_plastic")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_1e4def38fe67", function(ctx)
    local _n56, _u57 = H.npc(ctx), H.u(ctx)
    if _n56 and _u57 then
        local _pay58 = services.trade.pay(_n56, _u57, math.floor(12000))
        if _pay58.ok and _pay58.value == true then
            H.receive_item(_u57, "antibiotics", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_1b27e0514798", function(ctx)
    local _n59, _u60 = H.npc(ctx), H.u(ctx)
    if _n59 and _u60 then
        local _pay61 = services.trade.pay(_n59, _u60, math.floor(14000))
        if _pay61.ok and _pay61.value == true then
            H.receive_item(_u60, "antifungal", 20, "bottle_plastic_pill_prescription")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_543125a2c97e", function(ctx)
    local _n62, _u63 = H.npc(ctx), H.u(ctx)
    if _n62 and _u63 then
        local _pay64 = services.trade.pay(_n62, _u63, math.floor(20000))
        if _pay64.ok and _pay64.value == true then
            H.receive_item(_u63, "chem_black_powder", 10000, "jar_3l_glass_sealed")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_5abd30583796", function(ctx)
    local _n65, _u66 = H.npc(ctx), H.u(ctx)
    if _n65 and _u66 then
        local _pay67 = services.trade.pay(_n65, _u66, math.floor(30000))
        if _pay67.ok and _pay67.value == true then
            H.receive_item(_u66, "napalm", 10000, "jerrycan")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_e3b47843f525", function(ctx)
    H.run_eoc("capture_generic_nre_anomaly", ctx, nil, nil, nil)
    H.eoc_spawn_item(H.u(ctx), "melchior_science_doc", 1, false, false, nil)
    H.set_var("actor", H.u(ctx), ctx, "counter_robofac_knowledge_dimensional_heuristics", (H.var_num(H.u(ctx), "counter_robofac_knowledge_dimensional_heuristics")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_26a76d0c6d1d", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(100), math.floor(140); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_HATES_YOU"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_3bad465bd877", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(40000) }) end
end)
ccb.runtime.handler("w16b_a_dda_6232d39e724f", function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special = H.safe_id('overmap_special', "exodii_base") }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = math.floor(250) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
end)
ccb.runtime.handler("w16b_a_dda_fb6c2131bf11", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_first_meeting_u_met_Rubik", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_5874f511da07", function(ctx)
    local _a68 = H.npc(ctx)
    if _a68 then services.npcs.modify_opinion(_a68, { sold = math.floor(-(20)) }) end
end)
ccb.runtime.handler("w16b_a_dda_09221323f43d", function(ctx)
    do local _g = H.safe_id('activity', "ACT_CBM_SURGERY"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(7200)))) end end
    H.lose_trait(H.u(ctx), "Hub01_CBM_Interface")
end)
ccb.runtime.handler("w16b_a_dda_7a90366fcd0b", function(ctx)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_cable")
end)
ccb.runtime.handler("w16b_a_dda_21d1c1428822", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(500), math.floor(700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_HATES_YOU"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_9ce35a2a90df", function(ctx)
    do local _g = H.safe_id('activity', "ACT_CBM_SURGERY"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(43200)))) end end
end)
ccb.runtime.handler("w16b_a_dda_93293e0035eb", function(ctx)
    H.add_bionic(H.u(ctx), "bio_exodii_cyberframe_1a")
    H.add_bionic(H.u(ctx), "bio_exodii_leg_bionic_basic_armored_left")
    H.add_bionic(H.u(ctx), "bio_exodii_leg_bionic_basic_armored_right")
    H.add_bionic(H.u(ctx), "bio_exodii_arm_bionic_basic_armored_left")
    H.add_bionic(H.u(ctx), "bio_exodii_arm_bionic_basic_armored_right")
    do local _t = math.max(1, math.floor(43200)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_MERCHANT_Exodize_Cyberframe_done"), nil) end end
    H.run_eoc("EOC_ROBOFAC_HATES_EXODII_CYBORGS", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_644db66b5949", function(ctx)
    H.add_bionic(H.u(ctx), "bio_exodii_cyberframe_1b")
    H.add_bionic(H.u(ctx), "bio_exodii_leg_bionic_basic_left")
    H.add_bionic(H.u(ctx), "bio_exodii_leg_bionic_basic_right")
    H.add_bionic(H.u(ctx), "bio_exodii_arm_bionic_basic_left")
    H.add_bionic(H.u(ctx), "bio_exodii_arm_bionic_basic_right")
    do local _t = math.max(1, math.floor(43200)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_MERCHANT_Exodize_Cyberframe_done"), nil) end end
    H.run_eoc("EOC_ROBOFAC_HATES_EXODII_CYBORGS", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_183f08bf4e45", function(ctx)
    H.set_var("global", nil, ctx, "labyrinth_access_points", (H.global_var_num("labyrinth_access_points")) - (1))
    H.set_var("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown", services.turn())
    H.run_eoc("EOC_LS_Teleport_to_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_22211a43a198", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_Exit_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_96f1fcebedd8", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_Exit_labyrinth_temp", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c965521e93b8", function(ctx)
    H.run_eoc("EOC_LS_Unlock", ctx, nil, nil, nil)
    H.run_eoc("EOC_LS_Passcode_Generator", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_602258923b5d", function(ctx)
    H.run_eoc("EOC_LS_Lock", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ab90db3ee21f", function(ctx)
    H.run_eoc("EOC_LS_ReallyUnlock", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4a09dc5c1966", function(ctx)
    H.run_eoc("EOC_LS_Bridge_control_deadend_1_Passcode0", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_95ccc09db2d6", function(ctx)
    H.run_eoc("EOC_LS_Bridge_control_deadend_1_Passcode1", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_0fe6fdd500c8", function(ctx)
    H.run_eoc("EOC_LS_Bridge_control_deadend_1_Passcode2", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_87ad9d7f3c89", function(ctx)
    H.run_eoc("EOC_LS_Bridge_control_deadend_1_Passcode3", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_508f5a2dd523", function(ctx)
    H.run_eoc("EOC_LS_mission_boiler_teleport_to_safehouse", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_975fced2d368", function(ctx)
    H.run_eoc("EOC_LS_mission_water_cooler_teleport_to_safehouse", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b8aaa3e916db", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_Teleport_to_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f5a658ff055c", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_Teleport_to_labyrinth_reenter", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_0a191ced8577", function(ctx)
    H.run_eoc("EOC_LS_mission_boiler_teleport_to_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ae5f66bc2c88", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_UPDATE_UTILITY_SPACE_OBELISK", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("The ground shakes for a moment, then you hear a distant, mechanical grinding.")))
end)
ccb.runtime.handler("w16b_a_dda_2569dac3f303", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_UPDATE_AUTODOC_OBELISK", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("The ground shakes for a moment, then you hear a distant, mechanical grinding.")))
end)
ccb.runtime.handler("w16b_a_dda_f36272c2c226", function(ctx)
    H.run_eoc("EOC_LS_mission_water_coolor_teleport_to_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_efee32ac911a", function(ctx)
    H.run_eoc("EOC_LS_SAFEHOUSE_UPDATE_LIVING_SPACE_1_OBELISK", ctx, nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("The ground shakes for a moment, then you hear a distant, mechanical grinding.")))
end)
ccb.runtime.handler("w16b_a_dda_813d2b91872f", function(ctx)
    do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
end)
ccb.runtime.handler("w16b_a_dda_93b9ffb868d3", function(ctx)
    H.run_eoc("EOC_LS_earth_jaunt_4hours", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6783710c7166", function(ctx)
    H.run_eoc("EOC_LS_SD_enter_tunnel", ctx, nil, nil, nil)
    H.lose_trait(H.u(ctx), "LS_Passcode_string_dimension")
end)
ccb.runtime.handler("w16b_a_dda_aa509652e8e5", function(ctx)
    H.run_eoc("EOC_LS_SD_Teleport_to_labyrinth", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_63cfbf23b6ac", function(ctx)
    H.run_eoc("GODCO_EDDIE_CANNING_MISSION_ADD", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4f624905997f", function(ctx)
    local _n69, _u70 = H.npc(ctx), H.u(ctx)
    if _n69 and _u70 then
        local _pay71 = services.trade.pay(_n69, _u70, math.floor(15000))
        if _pay71.ok and _pay71.value == true then
            H.receive_item(_u70, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_d1372e13dffc", function(ctx)
    local _n72, _u73 = H.npc(ctx), H.u(ctx)
    if _n72 and _u73 then
        local _pay74 = services.trade.pay(_n72, _u73, math.floor(2000))
        if _pay74.ok and _pay74.value == true then
            H.receive_item(_u73, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_843591da9c04", function(ctx)
    local _n75, _u76 = H.npc(ctx), H.u(ctx)
    if _n75 and _u76 then
        local _pay77 = services.trade.pay(_n75, _u76, math.floor(15000))
        if _pay77.ok and _pay77.value == true then
            H.receive_item(_u76, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_bf616f7e2638", function(ctx)
    local _n78, _u79 = H.npc(ctx), H.u(ctx)
    if _n78 and _u79 then
        local _pay80 = services.trade.pay(_n78, _u79, math.floor(5000))
        if _pay80.ok and _pay80.value == true then
            H.receive_item(_u79, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_ff5d4687cda9", function(ctx)
    local _n81, _u82 = H.npc(ctx), H.u(ctx)
    if _n81 and _u82 then
        local _pay83 = services.trade.pay(_n81, _u82, math.floor(15000))
        if _pay83.ok and _pay83.value == true then
            H.receive_item(_u82, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_905330b7b16a", function(ctx)
    local _n84, _u85 = H.npc(ctx), H.u(ctx)
    if _n84 and _u85 then
        local _pay86 = services.trade.pay(_n84, _u85, math.floor(2000))
        if _pay86.ok and _pay86.value == true then
            H.receive_item(_u85, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_fef3fda7ed0f", function(ctx)
    local _n87, _u88 = H.npc(ctx), H.u(ctx)
    if _n87 and _u88 then
        local _pay89 = services.trade.pay(_n87, _u88, math.floor(5000))
        if _pay89.ok and _pay89.value == true then
            H.receive_item(_u88, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_dc7499dbfcd6", function(ctx)
    local _n90, _u91 = H.npc(ctx), H.u(ctx)
    if _n90 and _u91 then
        local _pay92 = services.trade.pay(_n90, _u91, math.floor(15000))
        if _pay92.ok and _pay92.value == true then
            H.receive_item(_u91, "godcotrader_accounting_records_dirty", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_6dc89c37aece", function(ctx)
    H.eoc_spawn_item(H.u(ctx), "godcotrader_accounting_records_clean", 1, false, false, nil)
end)
ccb.runtime.handler("w16b_a_dda_bf57c07d7299", function(ctx)
    H.set_var("global", nil, ctx, "barry_travelling_home", 1)
    do for _, _uid in ipairs({ "BARRY_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_BARRY_TELEPORT_HOME" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
    H.eoc_loc_var(H.u(ctx), ctx, "global", "isherwood_mission_success_return_map", { terrain = "horse_farm_isherwood_13" }, { z = math.floor(0) }, { kind = "furniture", id = H.safe_id("furniture", "f_chair") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "isherwood_mission_success_return_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    H.eoc_spawn_item(H.u(ctx), "hsurvivor_jumpsuit", 1, false, false, nil)
end)
ccb.runtime.handler("w16b_a_dda_3a151799f896", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 0)
    H.run_eoc("isherwood_mission_initialization_eoc", ctx, nil, nil, nil)
    H.set_var("global", nil, ctx, "npc_isherwood_barry_rescue_attempts", (H.global_var_num("npc_isherwood_barry_rescue_attempts")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_3463a68f7091", function(ctx)
    H.set_var("global", nil, ctx, "timer_chris_talked_to_lisa", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_d6314d3ea231", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 0)
    do local _t = math.max(1, math.floor(3600)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("isherwood_mission_lisa_coming"), nil) end end
    H.run_eoc("isherwood_mission_initialization_eoc", ctx, nil, nil, nil)
    H.set_var("global", nil, ctx, "npc_isherwood_barry_rescue_attempts", (H.global_var_num("npc_isherwood_barry_rescue_attempts")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_a205c9aeeaa7", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 0)
    do local _t = math.max(1, math.floor(3600)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("isherwood_mission_lisa_coming"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_be75d0d448ce", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 1)
    H.run_eoc("isherwood_mission_initialization_eoc", ctx, nil, nil, nil)
    H.set_var("global", nil, ctx, "npc_isherwood_barry_rescue_attempts", (H.global_var_num("npc_isherwood_barry_rescue_attempts")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_617ec9bf0096", function(ctx)
    H.run_eoc("isherwood_mission_initialization_eoc", ctx, nil, nil, nil)
    H.set_var("global", nil, ctx, "npc_isherwood_barry_rescue_attempts", (H.global_var_num("npc_isherwood_barry_rescue_attempts")) + (1))
end)
ccb.runtime.handler("w16b_a_dda_89f0361aa577", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "mace", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_700d7ef9bffb", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "warhammer", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4169a5712356", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "steel_staff", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_2229dd3b8561", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "battleaxe", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f934a9ca1a8a", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "longsword", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_aa4b676392ac", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "nodachi", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_5e934a89998e", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "zweihander", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ed1833396d01", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "arming_sword", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_de77851253a6", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "broadsword", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c7c30547d83a", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "cavalry_sabre", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_395a239c0ce5", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "cutlass", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_fa203ada633b", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "katana", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_399d99743ac8", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "wakizashi", ["cost"] = 170, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_fb3b5ea761eb", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "kukri", ["cost"] = 150, ["wait"] = 2 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_dccd4e701312", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "estoc", ["cost"] = 250, ["wait"] = 4 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1b67f85762e7", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "rapier", ["cost"] = 200, ["wait"] = 3 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_43313c5b582e", function(ctx)
    H.run_eoc("EOC_blacksmith_weapon_choose_type", ctx, { ["name"] = "knife_trench", ["cost"] = 70, ["wait"] = 2 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_a8019ce83bf5", function(ctx)
    H.eoc_spawn_item(H.u(ctx), H.var_str("actor", H.u(ctx), ctx, "general_artisans_blacksmith_weapon", ""), 1, false, false, nil)
    H.run_eoc("EOC_blacksmith_weapon_cleanup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e9ddc67ae509", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "223", ["coeff"] = 48 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_79212c3ff836", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6ac71407936e", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556_incendiary", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6211eb674e31", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556_mk262", ["coeff"] = 52 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1237fd6e1321", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556_mk318", ["coeff"] = 52 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_27195c8fa3d4", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556_m855a1", ["coeff"] = 56 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ca390656923c", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "556_m995", ["coeff"] = 70 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_64cd945404a3", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "308", ["coeff"] = 65 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_84b2b8ca832c", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "762_51", ["coeff"] = 70 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e362edfc7675", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "762_51_incendiary", ["coeff"] = 70 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_277d0077326e", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "762_51_m993", ["coeff"] = 90 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_d9293ea86833", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "300blk_ss", ["coeff"] = 30 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_01060b28f486", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "300blk", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c97ea341d70c", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "9mm", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_693199f8f925", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "9mmfmj", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_cbb7ea63bfa2", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "9mmP", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_78f2ec6dd351", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "9mmP2", ["coeff"] = 26 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_9c960f12de69", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "22_lr", ["coeff"] = 10 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6c4c55c31a76", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "22_fmj", ["coeff"] = 11 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_d78c7597abd7", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "545", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_75147dad61bb", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "545_ap", ["coeff"] = 70 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_43ae0a5c753b", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "762_jhp", ["coeff"] = 80 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ced07f12f698", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "762_m87", ["coeff"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c7391b96dc82", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "shot_bird", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_94e8445caa84", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "shot_00", ["coeff"] = 35 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_cd6dbf53cc12", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "shot_slug", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7e3a8f1f66b0", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "40sw", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e2b9757d71c9", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "40fmj", ["coeff"] = 26 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c61f47038c13", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "44magnum", ["coeff"] = 30 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_d450bdb8689f", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "44fmj", ["coeff"] = 35 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1848c0eb7f84", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "45_jhp", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_84b08f2138b6", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "45_acp", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_23e3939d7656", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "45_super", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_220de471911b", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "380_JHP", ["coeff"] = 13 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_d743f1f96056", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "380_FMJ", ["coeff"] = 13 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_cefee69944f2", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "380_p", ["coeff"] = 15 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_28292c576cdd", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "57mm_ss", ["coeff"] = 15 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_cf356a208741", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "57mm_lf", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6801c3643760", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "57mm", ["coeff"] = 30 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f772c305fa26", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "10mm_jhp", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_3d52fb7cf779", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "10mm_fmj", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e37a8125d51e", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "10mmP", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_213318be9385", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "38_special", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_037170eaf66b", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "38_fmj", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f944a53dabf1", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "38_special_p", ["coeff"] = 24 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1884f9385ee3", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "357sig_jhp", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e59399b21249", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "357sig_fmj", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8a93234a2307", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "357mag_jhp", ["coeff"] = 23 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_391cfef60814", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "357mag_fmj", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_cb0548783ba9", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "460sw", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_36bca69c23d1", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "500_Magnum", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_820b75a8de6d", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "270win_jsp", ["coeff"] = 48 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_689b3d008319", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "300_winmag", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b39e38269b83", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "458wm", ["coeff"] = 80 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1d19ecdb539a", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "454_Casull", ["coeff"] = 48 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1f762a3590b0", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "3006_jsp", ["coeff"] = 48 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_02396e79da02", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "3006", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_aaab8cd70a6f", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "3006_incendiary", ["coeff"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_bcba1987ce7e", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "3006fmj", ["coeff"] = 53 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6a51f53091b7", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "410shot_bird", ["coeff"] = 15 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_475aaa470968", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "410shot_000", ["coeff"] = 20 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_895c82966e56", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "410shot_slug", ["coeff"] = 30 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_879bb01923d8", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "50bmg", ["coeff"] = 140 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8ff36662559d", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "50_incendiary", ["coeff"] = 140 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_2cfb974fdd9e", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "50match", ["coeff"] = 140 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_013ffdd9dfd9", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "50ss", ["coeff"] = 210 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_858c67f7fb08", function(ctx)
    H.run_eoc("EOC_gunsmith_source", ctx, { ["item"] = "50_mk211", ["coeff"] = 210 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7c5b3e62ae79", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_556", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7799863209ca", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_762_51", ["coeff"] = 77 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_358181ea5b4a", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_300blk", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_a15445bee44b", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_300blk_ss", ["coeff"] = 33 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6c3861b3b046", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_9mm", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_90fc9e3652e3", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_9mmfmj", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6e3d25175c06", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_9mmP2", ["coeff"] = 28 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_06a57fb5b73a", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "22_fmj", ["coeff"] = 12 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_0c2563ae054e", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_545", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4c9d5a7228a9", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_545_ap", ["coeff"] = 77 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b0003b290b15", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_shot_bird", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c79e5aa4faf2", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_shot_00", ["coeff"] = 38 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_2aefa6944125", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_shot_slug", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e9733b2c748e", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_shot_dragon", ["coeff"] = 30 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_70f3ac953410", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_40sw", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_32bea31a6348", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_40fmj", ["coeff"] = 28 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b0f009094f17", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_44magnum", ["coeff"] = 33 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_20f5ec241833", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_44fmj", ["coeff"] = 38 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e2fb74fd8493", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_45_jhp", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_63cb5f216029", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_45_acp", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f70c066cada0", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_45_super", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1d43f6c6f128", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_380_JHP", ["coeff"] = 14 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_5340d6614ce4", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_380_FMJ", ["coeff"] = 14 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_eca5bf9e5804", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_380_p", ["coeff"] = 16 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_7fd5f0112989", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_57mm", ["coeff"] = 33 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b16e0fdb7be5", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_10mm_jhp", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_6b227ab9fd25", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_10mm_fmj", ["coeff"] = 25 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_a980973947ef", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_10mmP", ["coeff"] = 27 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4cfbc005fa3d", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_38_special", ["coeff"] = 22 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_760873151326", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_38_fmj", ["coeff"] = 24 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c2b5c76640c3", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_38_special_p", ["coeff"] = 26 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c5ad94d2e943", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_270win_jsp", ["coeff"] = 52 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_5d34578286b1", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_270win_fmj", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8bee0977bc42", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_300_winmag", ["coeff"] = 55 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_bce172bedf67", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_3006_jsp", ["coeff"] = 52 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_08c24fe3ecbe", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_3006fmj", ["coeff"] = 58 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8a79093b7f8e", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_50bmg", ["coeff"] = 154 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_38f7a3256bc8", function(ctx)
    H.run_eoc("EOC_gunsmith_target", ctx, { ["item"] = "reloaded_50ss", ["coeff"] = 231 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_159ca3fcbc8f", function(ctx)
    H.eoc_spawn_item(H.u(ctx), H.var_str("actor", H.u(ctx), ctx, "general_artisans_gunsmith_ammo", ""), math.ceil((H.var_num(H.u(ctx), "number_artisans_gunsmith_wait") * 8.333)), false, false, nil)
    H.run_eoc("EOC_gunsmith_cleanup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_8073edf737e3", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "2x4", ["max"] = 200 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_4c42faf7ba13", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "plank_short", ["max"] = 200 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_2a998e303525", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "plank_long", ["max"] = 200 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_e2174ea841c3", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wooden_post", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_19c8bfcf25b9", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wooden_post_short", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_c10b2fabee74", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wooden_post_long", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_1dcc08912fd4", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wood_panel", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_ab5661818100", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wood_sheet", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_53561ab2ad95", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "wood_beam", ["max"] = 50 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_9ebac9e5e76a", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_order", ctx, { ["name"] = "log", ["max"] = 100 }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_88871dfa336c", function(ctx)
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_cleanup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_2ea665c78060", function(ctx)
    local _n93, _u94 = H.npc(ctx), H.u(ctx)
    if _n93 and _u94 then
        local _pay95 = services.trade.pay(_n93, _u94, math.floor((H.var_num(H.npc(ctx), "number_fabricate_price") * 100)))
        if _pay95.ok and _pay95.value == true then
            H.receive_item(_u94, "file", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)
ccb.runtime.handler("w16b_a_dda_ee6ccdac8907", function(ctx)
    do
        local _arr = { "2x4", "plank_short", "plank_long", "wooden_post", "wooden_post_short", "wooden_post_long", "wood_panel", "wood_sheet", "wood_beam", "log" }
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "name", _v)
            H.set_var("context", nil, ctx, "item", ctx:expand_text("n_number_fabricate_<context_val:name>"))
            if (H.global_var_num("v_item") ~= 0) then
                H.eoc_spawn_item(H.u(ctx), H.var_str("context", nil, ctx, "name", ""), (tonumber(H.resolve_var_get(ctx, (H.resolve_var_get(ctx, "item", false) or (ctx and ctx:get("item"))), false)) or 0), false, false, nil)
            end
        end
    end
    H.run_eoc("EOC_LUMBERMILL_FABRICATE_cleanup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_9812bef589e2", function(ctx)
    H.run_eoc("EOC_exodii_mission_wh_directions_chance", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_f1418abfd320", function(ctx)
    H.set_var("global", nil, ctx, "npc_randomize_dialogue_direction", services.random.native_int(0, H.round_half_away(3)))
end)
ccb.runtime.handler("w16b_a_dda_8585463a3e0a", function(ctx)
    do for _, _uid in ipairs({ "TRAVELER" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_traveler_random_destination_direction" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
end)
ccb.runtime.handler("w16b_a_dda_ee5ac56a72a9", function(ctx)
    H.run_eoc("EOC_BEGGAR_TEST_IF_FOOD_CANNIBAL", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_346a0ec563b7", function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "refcenter_nunez_departure", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.set_var("context", nil, ctx, "travel_time", ((services.time.calendar().now.turns_since_cataclysm / 86400) + 2))
    do local _t = math.max(1, math.floor((ctx:get_number("travel_time") or 0))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_Nunez_Travel_To_Tacoma"), { ["refcenter_nunez_departure"] = H.var_str("context", nil, ctx, "refcenter_nunez_departure", ""), ["tacoma_nunez_trailer_arrive"] = H.var_str("actor", H.u(ctx), ctx, "tacoma_nunez_trailer_arrive", "") }) end end
end)
ccb.runtime.handler("w16b_a_dda_6f156aa98a67", function(ctx)
    H.set_var("global", nil, ctx, "npc_randomize_dialogue_direction", services.random.native_int(0, H.round_half_away(4)))
    H.set_var("actor", H.npc(ctx), ctx, "timer_teamster_directions_recycler", services.turn())
end)
ccb.runtime.handler("w16b_a_dda_df2b41f36920", function(ctx)
    H.set_var("global", nil, ctx, "exodii_FM_negotiation_failed", 1)
end)
ccb.runtime.handler("w16b_a_dda_6b33ca9a0565", function(ctx)
    H.set_var("global", nil, ctx, "exodii_FM_negotiation_success", 1)
    do local _t = math.max(1, math.floor(518400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_FM_UPDATES"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_4548838cb2cf", function(ctx)
    do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_GAVE_BEGGAR_CANNIBAL_PROOF"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_10371ccaec0c", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(0), math.floor(0); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BEM_ANCHOR_SELLER_GONE"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_48c301d35711", function(ctx)
    H.eoc_spawn_item(H.u(ctx), "dimensional_anchor", 1, false, false, nil)
end)
ccb.runtime.handler("w16b_a_dda_437a457cc817", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(0), math.floor(0); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BEM_BEM_CHATTING_VETERANS_DRUNK_TP"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_f6d831e35749", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(0), math.floor(0); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BEM_BEM_CHATTING_VETERANS_DRUNK_MESSAGE"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_44ca1332f016", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BEM_HUMAN_SAMPLE_BUY"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_9d667fd980a9", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(120); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_HATES_YOU"), nil) end end
    H.set_var("global", nil, ctx, "robofac_chop_shop_mercs_spotted", 1)
    if ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_kill_orders") == 1)))) then
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        H.run_eoc("EOC_ROBOFAC_LOCK_INTERCOM", ctx, nil, nil, nil)
    end
end)
ccb.runtime.handler("w16b_a_dda_745865974c3d", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n96 = H.npc(ctx)
    if _n96 then services.npcs.add_faction_rep(_n96, math.floor(-100)) end
    if ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_kill_orders") == 1)))) then
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        H.run_eoc("EOC_ROBOFAC_LOCK_INTERCOM", ctx, nil, nil, nil)
    end
end)
ccb.runtime.handler("w16b_a_dda_dd0badb4aabd", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n97 = H.npc(ctx)
    if _n97 then services.npcs.add_faction_rep(_n97, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_35c88564e93a", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n98 = H.npc(ctx)
    if _n98 then services.npcs.add_faction_rep(_n98, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_ec688fccf9b6", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n99 = H.npc(ctx)
    if _n99 then services.npcs.add_faction_rep(_n99, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_d9a597053fde", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n100 = H.npc(ctx)
    if _n100 then services.npcs.add_faction_rep(_n100, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_a97d0be01535", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n101 = H.npc(ctx)
    if _n101 then services.npcs.add_faction_rep(_n101, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_93367a8c1117", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Fuck this, this hellhole isn't worth it.  Let's get out of here.\"  The group unceremoniously packs up and leaves.")))
    do local _t = math.max(1, math.floor(5)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_CLEAN_UP_MERCS"), nil) end end
    do local _g = H.safe_id('activity', "ACT_GENERIC_EOC"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(10)))) end end
end)
ccb.runtime.handler("w16b_a_dda_e9ec6878b6ec", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n102 = H.npc(ctx)
    if _n102 then services.npcs.add_faction_rep(_n102, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_0f501b39b0a4", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n103 = H.npc(ctx)
    if _n103 then services.npcs.add_faction_rep(_n103, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_b08aa8604017", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The mercenary makes a quick hand motion and shouts \"Kill'em!\"")), "neutral")
    local _n104 = H.npc(ctx)
    if _n104 then services.npcs.add_faction_rep(_n104, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_a31f883c77dc", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(120), math.floor(240); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_REPORTED_YOU_TO_HUB"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_26bbdddd7140", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(120), math.floor(240); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_SCIENTIST_1_REPORTED_YOU_TO_HUB"), nil) end end
    local _n105 = H.npc(ctx)
    if _n105 then services.npcs.add_faction_rep(_n105, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_55aff17d03e3", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(120); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_HATES_YOU"), nil) end end
end)
ccb.runtime.handler("w16b_a_dda_7ba43a77c10e", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(120), math.floor(240); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ROBOFAC_CHOP_SHOP_SCIENTIST_1_REPORTED_YOU_TO_HUB"), nil) end end
    local _n106 = H.npc(ctx)
    if _n106 then services.npcs.add_faction_rep(_n106, math.floor(-100)) end
end)
ccb.runtime.handler("w16b_a_dda_6aa122c05524", function(ctx)
    H.run_eoc("EOC_INTERCOM_MAYBE_ADD_FREE_MERCHANT_CAMP", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b5a2696d95dd", function(ctx)
    H.set_var("global", nil, ctx, "hub01_uhmwpe_researched", 1)
end)
ccb.runtime.handler("w16b_a_dda_64a68bf9b5df", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 6, 0)
    H.run_eoc("EOC_INTERCOM_SPAWN_ARMOR_SET", ctx, { ["armor_type"] = "robofac_armor_pieces_military" }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_b6833dfd9ade", function(ctx)
    H.run_eoc("EOC_INTERCOM_SPAWN_ARMOR_SET", ctx, { ["armor_type"] = H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_armor_type", "") }, nil, nil)
end)
ccb.runtime.handler("w16b_a_dda_59c325f690c7", function(ctx)
    H.transfer_item(H.u(ctx), H.npc(ctx), "FMCNote", 3)
end)
ccb.runtime.handler("w16b_a_dda_bf2f802de4c4", function(ctx)
    H.transfer_item(H.u(ctx), H.npc(ctx), "FMCNote", 6)
end)
