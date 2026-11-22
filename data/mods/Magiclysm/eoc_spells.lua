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
if H.char_spell_level == nil then
H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
    return r.value
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
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end
if H._jm_enhancement_proficiency_modifier == nil then
H._jm_enhancement_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_enhancement_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_master", "percent") / 1000)))
end
end

ccb.runtime.handler("w16b_sp_imp_magiclysm_f0193c799283", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_random_mi_go_fleshwarper_mutate", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_b405595872a8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SUMMON_ZOMBIE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_ef45c13b909d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SUMMON_ZOMBIE_SWARM", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_611021790624", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_ANIMIST_SPIRIT_WALKING", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_3a6825a92341", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_ANIMIST_SLOW_FOOD_ROTTING_SPELL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_ab8e05771f9e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_DEMON_POSSESSION", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_magiclysm_5d46ffb57ea5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_burning_trail") > (-1))) and (0) or (50)))
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_60fd72496d14", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_1770b81c5ed4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_DUST_REBORN_INITIAL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_9c91c0357a44", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SOUL_AFTERBURNER", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_765e88261046", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_GIANT_GROWTH_MUTATION", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_02db1834e02d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BIOMANCER_SLOW_BLEEDING", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_2c3e2ed6d8d4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BIO_GET_MORE_BLOOD", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_magiclysm_6352c099802f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((1 + math.max(((H.char_spell_level(H.u(ctx), "biomancer_baleful_polymorph") - 10) * 0.25), 0)))
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_662757fed712", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_BIOMANCER_BALEFUL_POLYMORPH_NPCS", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_magiclysm_caf1330d758d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return ((((H.creature_effect_intensity(H.u(ctx), "effect_classless_magic_light") > (-1))) and (0) or (200)))
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_044686a0360c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CLASSLESS_CREATE_ORB_OF_LIGHT", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_056b97690d34", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CLASSLESS_ETHEREAL_GRASP", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_1cb60e37062d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CLASSLESS_CLEAN_CLOTHING_AND_SELF", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_a248dc9ec300", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("eoc_crystal_spawn", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_ea149b70b466", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_UTILITY_MOLDING", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_e1745265d6df", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_MAP", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_3ef0816f7d17", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_DANGERSENSE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_5e3c72c0037e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_GRANITE_AEGIS", ctx)
end)
ccb.runtime.handler("w16b_sp_stat_magiclysm_d681c41866f4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return (((H.truthy(H.char_has_trait(H.u(ctx), "EARTHSHAPER_STONE_SLEEP"))) and (0) or ((800 * (1 / H._jm_enhancement_proficiency_modifier(ctx))))))
end)
ccb.runtime.handler("w16b_sp_stat_magiclysm_a7a2677dd087", function(payload)
    local ctx = E.H.ctx_new(payload and payload.has_speaker and payload.speaker or nil, payload and payload.has_interlocutor and payload.interlocutor or nil, {})
    return (((H.truthy(H.char_has_trait(H.u(ctx), "EARTHSHAPER_STONE_SLEEP"))) and (0) or ((6000 * (1 / H._jm_enhancement_proficiency_modifier(ctx))))))
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_c016ea9ae3ac", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_SLEEP_IN_EARTH", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_5329e1c89f2f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_REPAIR_METAL_STONE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_d9a8eaa65ddb", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_EARTH_GATE_TELEPORT_CHECK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_cddc5164f6d7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_EARTHSHAPER_REMOVE_CORPSES", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_c66a7a8f98b3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FERAL_MAGUS_PUSH_NEARBY_ENEMIES_BACK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_c6964f19fa6f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FORGE_TELEPORT", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_5b9cd920bb87", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FORGE_RETURN_TELEPORT", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_7f2fbf5cba0d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MANA_LEECH_UNLOCK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_bd7abc88e736", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_STAG_BEETLE_SELECTOR", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_8667424d29d4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_KELVINIST_HEAT_FOOD_SPELL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_a5cfbc8df903", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_KELVINIST_SET_EVERYONE_ON_FIRE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_3a359415f5f5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGUS_MARK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_fb8e81f41fe7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGUS_RECALL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_1f1abf99c3e9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGUS_FAR_HAND_PULL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_0ce87083a8db", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGUS_DIAMOND_IMBUEMENT", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_df1ddfed09ea", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGUS_PUSH_NEARBY_ENEMIES_BACK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_115163fc645e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_ADD1", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_f47539edc48c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_ADD2", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_b8c0c041d5a9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_REGEN1", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_ca9c8980eba4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_REGEN2", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_4b7875944bd3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_MULT1", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_7d4446fcdea5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_SPELL_GRANT_MANA_MULT2", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_df42cb6e6d49", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CATOBLEPAS_GAZE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_256d41a1eb72", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FERAL_DABBLE_SPELLS_SELECTOR_SPELL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_a462961d419e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_MAGICLYSM_WILL_O_THE_WISP_DRAINING_ATTACK", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_5332ae20b626", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_RUST_MONSTER_DETECT_METAL", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_c7c41b231122", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_RUST_MONSTER_INCREASE_AGGRESSION", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_78cfe1e30897", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_GAIN_CLOAK_OF_FROG_MUTATIONS", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_5210a0417178", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_CONJURE_UPS_INITIATE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_2ee93df0c0c7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_TECHNOMANCER_POWER_LINKAGE", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_1289c8fc51e9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_DRUID_SHIFTER_RAVEN_FORM_ASCEND", ctx)
end)
ccb.runtime.handler("w16b_sp_imp_magiclysm_a843d3eb9713", function(payload)
    local ctx = E.H.ctx_new(payload and payload.caster or nil, payload and payload.target_creature or nil, { spell_level = payload and payload.level or 0 })
    E.H.run_eoc("EOC_FORGE_LOCKDOWN", ctx)
end)
