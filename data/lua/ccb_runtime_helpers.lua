-- Shared pure-Lua runtime helpers for migrated CCB mods.
local ccb = require("ccb")
local services = ccb.services

local M = {}

function M.attach(H, E)
    if H.add_bionic == nil then
    H.add_bionic = function(actor, bid)
        if not actor then return end
        local gid = H.safe_id("bionic", bid)
        if not gid then return end
        services.bionics.grant(actor, gid)
    end
    end
    if H.add_effect == nil then
    H.add_effect = function(actor, eff_id, turns)
        if not actor then return end
        local gid = H.safe_id("effect", eff_id)
        if not gid then return end
        local dur = turns < 0 and services.time.infinite_duration() or services.time.duration_from_turns(math.floor(turns))
        services.effects.add(actor, gid, dur)
    end
    end
    if H.add_morale == nil then
    H.add_morale = function(actor, mid, bonus, max_bonus, dur_turns, decay_turns)
        if not actor then return end
        local gid = H.safe_id("morale", mid)
        if not gid then return end
        local opts = {}
        if dur_turns then opts.duration = services.time.duration_from_turns(math.floor(dur_turns)) end
        if decay_turns then opts.decay_start = services.time.duration_from_turns(math.floor(decay_turns)) end
        services.morale.add(actor, gid, math.floor(bonus), math.floor(max_bonus), opts)
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
    if H.assign_activity == nil then
    H.assign_activity = function(actor, act_id, turns)
        if not actor then return end
        local gid = H.safe_id("activity", act_id)
        if not gid then return end
        services.activities.assign_timed(actor, gid, services.time.duration_from_turns(math.floor(turns)))
    end
    end
    if H.char_addiction == nil then
    H.char_addiction = function(actor, add_id, field)
        if not actor then return 0 end
        local gid = H.safe_id("addiction", add_id)
        if not gid then return 0 end
        local r = services.addictions.get(actor, gid)
        if not r.ok or not r.value then return 0 end
        if field == "turns" then return r.value.turns or 0 end
        return r.value.intensity or 0
    end
    end
    if H.char_at_om_location == nil then
    H.char_at_om_location = function(actor, loc_id)
        local s = H.char_snap(actor)
        if not s or not s.creature then return false end
        return services.overmap.matches_location(s.creature.position:project_to("omt"), loc_id)
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
    if H.char_cash == nil then
    H.char_cash = function(actor)
        local s = H.char_snap(actor)
        if not s then return 0 end
        return s.cash or 0
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
    if H.char_has_any_trait == nil then
    H.char_has_any_trait = function(actor, ids)
        if not actor then return false end
        for _, id in ipairs(ids) do
            if H.char_has_trait(actor, id) == 1 then return true end
        end
        return false
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
    if H.char_has_flag == nil then
    H.char_has_flag = function(actor, flag_id)
        if not actor then return false end
        local gid = H.safe_id("json_flag", flag_id)
        if not gid then return false end
        local r = services.characters.has_flag(actor, gid)
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
    if H.char_health == nil then
    H.char_health = function(actor)
        if not actor then return 0 end
        local r = services.needs.get(actor)
        return (r.ok and r.value and r.value.lifestyle) or 0
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
    if H.char_is_wearing == nil then
    H.char_is_wearing = function(actor, item_id)
        if not actor then return false end
        local gid = H.safe_id("item", item_id)
        if not gid then return false end
        local r = services.inventory.is_wearing(actor, gid)
        return r.ok and r.value == true
    end
    end
    if H.char_know_recipe == nil then
    H.char_know_recipe = function(actor, recipe_id)
        if not actor then return false end
        local gid = H.safe_id("recipe", recipe_id)
        if not gid then return false end
        local r = services.recipes.knows(actor, gid)
        return r.ok and r.value == true
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
    if H.char_need == nil then
    H.char_need = function(actor, field)
        local s = H.char_snap(actor)
        if not s or not s.needs then return 0 end
        return s.needs[field] or 0
    end
    end
    if H.char_on_furniture == nil then
    H.char_on_furniture = function(actor, furn_id)
        local s = H.char_snap(actor)
        if not s or not s.creature then return false end
        return services.gameplay.environment.furniture_id(s.creature.position) == furn_id
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
    if H.char_spell_count == nil then
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
    end
    if H.char_spell_difficulty == nil then
    H.char_spell_difficulty = function(actor, spell_id, baseline)
        if not actor then return 0 end
        local gid = H.safe_id("spell", spell_id)
        if not gid then return 0 end
        local r = services.spells.difficulty(actor, gid, baseline == true)
        if not r.ok or r.value == nil then return 0 end
        return r.value
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
    if H.char_spell_level_sum == nil then
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
    end
    if H.char_stat == nil then
    H.char_stat = function(actor, field)
        local s = H.char_snap(actor)
        if not s then return 0 end
        return s.stats[field] or 0
    end
    end
    if H.char_sum_traits_cat == nil then
    H.char_sum_traits_cat = function(actor, category_id, count_type)
        if not actor then return 0 end
        local gid = H.safe_id("mutation_category", category_id)
        if not gid then return 0 end
        local r = services.mutations.category_count(actor, gid, count_type or "ALL", true)
        if not r.ok then return 0 end
        return r.value or 0
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
    if H.char_vitamin == nil then
    H.char_vitamin = function(actor, vitamin_id)
        if not actor then return 0 end
        local gid = H.safe_id("vitamin", vitamin_id)
        if not gid then return 0 end
        local r = services.needs.get_vitamin(actor, gid)
        if not r.ok then return 0 end
        return r.value or 0
    end
    end
    if H.chars_nearby == nil then
    H.chars_nearby = function(actor, rad, attitude)
        local s = H.char_snap(actor)
        if not s or not s.creature then return 0 end
        local r = services.characters.count_nearby(s.creature.position, { radius = math.floor(rad or 1000), attitude = attitude or "any" })
        if not r.ok then return 0 end
        return r.value or 0
    end
    end
    if H.clamp_num == nil then
    H.clamp_num = function(v, lo, hi)
        if v < lo then return lo end
        if v > hi then return hi end
        return v
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
    if H.coord_get == nil then
    H.coord_get = function(scope, actor, ctx, key, axis)
        local tp = H.get_tripoint_var(scope, actor, ctx, key)
        if not tp then return 0 end
        return tp[axis] or 0
    end
    end
    if H.coord_set == nil then
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
    end
    if H.copy_var == nil then
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
    if H.creature_has_effect == nil then
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
    end
    if H.creature_snap == nil then
    H.creature_snap = function(actor)
        if not actor then return nil end
        local r = services.creatures.snapshot(actor)
        if not r.ok then return nil end
        return r.value
    end
    end
    if H.creature_volume == nil then
    H.creature_volume = function(actor)
        if not actor then return 0 end
        local r = services.creatures.volume_ml(actor)
        if r.ok and r.value then return r.value end
        local ir = services.items.snapshot(actor)
        if ir.ok and ir.value and ir.value.volume_ml then return ir.value.volume_ml end
        return 0
    end
    end
    if H.creature_weight == nil then
    H.creature_weight = function(actor)
        if not actor then return 0 end
        local s = H.char_snap(actor)
        if s and s.carrying and s.carrying.weight_grams then return s.carrying.weight_grams * 1000 end
        local ir = services.items.snapshot(actor)
        if ir.ok and ir.value and ir.value.weight_grams then return ir.value.weight_grams * 1000 end
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
    if H.eoc_cast_spell == nil then
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
    if H.field_strength == nil then
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
    end
    if H.find_and_store_loc == nil then
    H.find_and_store_loc = function(actor, ctx, dst_scope, dst_key, om_sel, om_opts, world_sel, world_opts)
        local s = H.char_snap(actor)
        if not s or not s.creature then return end
        local origin_ms = s.creature.position
        if om_sel then
            local omt = origin_ms:project_to("omt")
            local resolved_opts = {}
            if om_opts then
                for k, v in pairs(om_opts) do resolved_opts[k] = v end
                if om_opts.special_id then
                    resolved_opts.special = H.safe_id("overmap_special", om_opts.special_id)
                    resolved_opts.special_id = nil
                end
            end
            local target_omt = services.overmap.find_target(omt, om_sel, resolved_opts)
            if not target_omt then return end
            origin_ms = target_omt:project_to("ms")
        end
        if world_sel or world_opts then
            local res = services.world.find_location(origin_ms, world_sel, world_opts)
            if res and res.found and res.position then
                H.set_var(dst_scope, actor, ctx, dst_key, res.position)
            end
        else
            H.set_var(dst_scope, actor, ctx, dst_key, origin_ms)
        end
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
    if H.is_avatar == nil then
    H.is_avatar = function(actor)
        if not actor then return false end
        if actor.subtype ~= nil then return actor.subtype == "avatar" end
        local s = H.char_snap(actor)
        return s ~= nil and s.avatar == true
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
    if H.learn_recipe == nil then
    H.learn_recipe = function(actor, rid)
        if not actor then return end
        local gid = H.safe_id("recipe", rid)
        if not gid then return end
        services.recipes.learn(actor, gid)
    end
    end
    if H.lose_bionic == nil then
    H.lose_bionic = function(actor, bid)
        if not actor then return end
        local gid = H.safe_id("bionic", bid)
        if not gid then return end
        services.bionics.remove_type(actor, gid)
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
    if H.mons_nearby == nil then
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
    end
    if H.moon_phase == nil then
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
    end
    if H.mutate_towards == nil then
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
    end
    if H.npc == nil then
    H.npc = function(ctx)
        return ctx:interlocutor()
    end
    end
    if H.npc_allies_global == nil then
    H.npc_allies_global = function(min_count)
        return services.npcs.count_allies(true) >= min_count
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
    if H.npc_mood_write == nil then
    H.npc_mood_write = function(actor, field, val, op)
        if not actor then return end
        local cur = H.npc_mood_read(actor, field)
        local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or val))
        local delta = math.floor(nxt - cur + 0.5)
        services.npcs.modify_opinion(actor, { [field] = delta })
    end
    end
    if H.npc_opinion == nil then
    H.npc_opinion = function(npc, field)
        local s = H.npc_snap(npc)
        if not s or not s.opinion then return 0 end
        return s.opinion[field] or 0
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
    if H.resolve_event_actors == nil then
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
    if H.rl_dist == nil then
    H.rl_dist = function(a, b)
        if not a or not b or a.z ~= b.z then return 999999 end
        return math.max(math.abs(a.x - b.x), math.abs(a.y - b.y))
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
        local fn = E and E.run and E.run[eid]
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
    if H.safe_id == nil then
    H.safe_id = function(kind, name)
        local ok, gid = pcall(services.types.id, kind, name)
        if not ok or not gid or not gid:is_valid() then return nil end
        return gid
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
    if H.set_char_health == nil then
    H.set_char_health = function(actor, val, op)
        if not actor then return end
        local cur = H.char_health(actor)
        local nxt = (op == "=") and val or ((op == "+=") and (cur + val) or ((op == "-=") and (cur - val) or ((op == "*=") and (cur * val) or (cur / val))))
        services.needs.modify_health(actor, { lifestyle = math.floor(nxt - cur + 0.5) })
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
    if H.set_spell_adj == nil then
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
    if H.set_var_indirect == nil then
    H.set_var_indirect = function(ctx, ind_key, val)
        local sc, act, key = H.resolve_var_ref(ctx, ind_key)
        if key == "" then return end
        return H.set_var(sc, act, ctx, key, val)
    end
    end
    if H.spawn_npc == nil then
    H.spawn_npc = function(actor, tpl_id, opts, msg)
        local s = H.char_snap(actor)
        if not s or not s.creature then return end
        local gid = H.safe_id("npc_template", tpl_id)
        if not gid then return end
        local r = services.spawns.npc(gid, s.creature.position, opts)
        if r.ok and msg and msg ~= "" then
            services.messages.add(msg, "neutral")
        end
    end
    end
    if H.species_nearby == nil then
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
    end
    if H.test_eoc == nil then
    H.test_eoc = function(eid, ctx)
        if not eid or eid == "" then return false end
        local cfn = E and E.cond and E.cond[eid]
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
    if H.time_until_named == nil then
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
    end
    if H.transfer_item == nil then
    H.transfer_item = function(u, npc, item_id, count)
        if not u or not npc then return end
        local gid = H.safe_id("item", item_id)
        if not gid then return end
        services.inventory.transfer_by_type(u, npc, gid, math.floor(count or 1))
    end
    end
    if H.transform_radius == nil then
    H.transform_radius = function(actor, radius, tr_id)
        local s = H.char_snap(actor)
        if not s or not s.creature then return end
        local gid = H.safe_id("terrain_furniture_transform", tr_id)
        if not gid then return end
        services.world.transform_radius(s.creature.position, math.floor(radius), gid)
    end
    end
    if H.truthy == nil then
    H.truthy = function(v)
        return v ~= false and v ~= nil and v ~= 0
    end
    end
    if H.u == nil then
    H.u = function(ctx)
        return ctx:speaker()
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
    return H
end

function M.create(E)
    return M.attach({}, E)
end

return M
