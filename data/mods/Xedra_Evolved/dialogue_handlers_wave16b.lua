local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H.char_has_trait == nil then
H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end
end
if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
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
if H.char_mana == nil then
H.char_mana = function(actor, which)
    if not actor then return 0 end
    local r = services.spells.mana(actor)
    if not r.ok or not r.value then return 0 end
    return r.value[which] or 0
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
if H.global_var_num == nil then
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
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
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end
if H._jm_vampire_bloodthorne_maximal_cure_damage == nil then
H._jm_vampire_bloodthorne_maximal_cure_damage = function(ctx)
    return ((((((H.char_has_trait(H.u(ctx), "VAMPIRE") * 20) + (H.char_has_trait(H.u(ctx), "VAMPIRE2") * 20)) + (H.char_has_trait(H.u(ctx), "VAMPIRE3") * 20)) + H._jm_vampire_total_tier_one_traits(ctx)) + (H._jm_vampire_total_tier_two_traits(ctx) * 2)) + (H._jm_vampire_total_tier_three_traits(ctx) * 3))
end
end
if H._jm_vampire_total_tier_one_traits == nil then
H._jm_vampire_total_tier_one_traits = function(ctx)
    return ((((((((((H.char_has_trait(H.u(ctx), "EYEGLEAM") + H.char_has_trait(H.u(ctx), "BLOOD_FUN")) + H.char_has_trait(H.u(ctx), "STAMINAFORBLOOD")) + H.char_has_trait(H.u(ctx), "COMMUNE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_RESILIENCE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")) + H.char_has_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_COLD_TEMPS"))
end
end
if H._jm_vampire_total_tier_three_traits == nil then
H._jm_vampire_total_tier_three_traits = function(ctx)
    return ((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHASTE") + H.char_has_trait(H.u(ctx), "HYPNOTIC_GAZE")) + H.char_has_trait(H.u(ctx), "MAGICFORBLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_COMMAND_BEAST")) + H.char_has_trait(H.u(ctx), "VAMPIRE_EARTH_SLUMBER")) + H.char_has_trait(H.u(ctx), "VAMPIRE_CARDIO_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_MOTION_ALARM")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BONUS_HP")) + H.char_has_trait(H.u(ctx), "VAMPIRE_STORE_MORE_BLOOD")) + H.char_has_trait(H.u(ctx), "VAMPIRE_INSTANT_BLEED")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BIG_STOMACH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_DETECT_VAMPIRES")) + H.char_has_trait(H.u(ctx), "DHAMPIR_REDUCED_PAIN")) + H.char_has_trait(H.u(ctx), "DHAMPIR_MEND_WOUNDS_FASTER")) + H.char_has_trait(H.u(ctx), "DHAMPIR_AVOID_EAT_SLEEP_DRINK"))
end
end
if H._jm_vampire_total_tier_two_traits == nil then
H._jm_vampire_total_tier_two_traits = function(ctx)
    return (((((((((((((((((H.char_has_trait(H.u(ctx), "BLOODHEAL") + H.char_has_trait(H.u(ctx), "COAGULANTWEAVE")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_DODGE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALLS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")) + H.char_has_trait(H.u(ctx), "VAMPIRIC_STEALTH_BONUS")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")) + H.char_has_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")) + H.char_has_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPORARY_BOOST")) + H.char_has_trait(H.u(ctx), "EYEGLEAM_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SEE_THROUGH_NIGHT_EYES")) + H.char_has_trait(H.u(ctx), "BLOOD_FUN_UPGRADE")) + H.char_has_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE_UPGRADE")) + H.char_has_trait(H.u(ctx), "DHAMPIR_FANGS")) + H.char_has_trait(H.u(ctx), "DHAMPIR_SLOWFALL")) + H.char_has_trait(H.u(ctx), "DHAMPIR_RESIST_DISEASE_POISON_INFECTION")) + H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION"))
end
end

ccb.runtime.handler("w16b_p_xedra_evolved_a36fde5af7fe", function(ctx)
    return (H.global_var_num("human_blood_vitamin") > 0)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_f917d87baf9c", function(ctx)
    return ((H.global_var_num("human_blood_vitamin") < 1) and (H.char_hp(H.u(ctx), "head", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "torso", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "arm_l", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "arm_r", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "leg_l", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) and (H.char_hp(H.u(ctx), "leg_r", false) >= H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)))
end)
ccb.runtime.handler("w16b_p_xedra_evolved_8a7c92bf3c2d", function(ctx)
    return ((H.global_var_num("human_blood_vitamin") < 1) and ((H.char_hp(H.u(ctx), "head", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "torso", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "arm_l", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "arm_r", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "leg_l", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)) or (H.char_hp(H.u(ctx), "leg_r", false) < H._jm_vampire_bloodthorne_maximal_cure_damage(ctx))))
end)
ccb.runtime.handler("w16b_p_xedra_evolved_952e7812cbf7", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") > 0)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_e23f13094bcb", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") < 1)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_bd4c4a567679", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") >= 1)
end)
ccb.runtime.handler("w16b_p_xedra_evolved_dfec4b4de226", function(ctx)
    return (H.global_var_num("vampire_hunters_owed_help") > 1)
end)
ccb.runtime.handler("w16b_a_xedra_evolved_db67e96e1c73", function(ctx)
    H.run_eoc("EOC_CHANGELING_SUMMER_PROTECT_FROM_HOT_WEATHER", ctx, nil, "u", nil)
    local _a1 = H.npc(ctx)
    if _a1 then services.spells.set_mana_raw(_a1, math.floor((H.char_mana(_a1, "current")) - (math.max(((250 - (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 2)) - (H.char_skill(H.npc(ctx), "gramarye") * 4.5)), 100)))) end
end)
ccb.runtime.handler("w16b_a_xedra_evolved_b286adc5eda4", function(ctx)
    H.run_eoc("EOC_LILIN_RUACH_DRAIN_DIALOGUE", ctx, nil, "npc", services.characters.avatar())
end)
ccb.runtime.handler("w16b_a_xedra_evolved_e185a1582968", function(ctx)
    H.run_eoc("EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM_IN_OTHER", ctx, nil, services.characters.avatar(), nil)
end)
ccb.runtime.handler("w16b_a_xedra_evolved_11c9ecaecc8c", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (10))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_3a02bfb200e3", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) + (3))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_d9fb058089f3", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(2000) }) end
end)
ccb.runtime.handler("w16b_a_xedra_evolved_067e0015be5d", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
    H.eoc_spawn_item(H.u(ctx), "blood_treatment", 3, false, false, "bottle_plastic")
end)
ccb.runtime.handler("w16b_a_xedra_evolved_79c405cd4be8", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_fa5f4419f53a", function(ctx)
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (2))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_cf46f00fa379", function(ctx)
    if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor(-2000) }) end
    H.set_var("global", nil, ctx, "vampire_hunters_owed_help", (H.global_var_num("vampire_hunters_owed_help")) - (1))
end)
ccb.runtime.handler("w16b_a_xedra_evolved_c68b966624c1", function(ctx)
    H.run_eoc("EOC_VAMPIRE_HUNTERS_PERMA_HOSTILE", ctx, nil, nil, nil)
end)
