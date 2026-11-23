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
if H.char_has_flag == nil then
H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
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
if H.char_spell_level == nil then
H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
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
if H.lose_trait == nil then
H.lose_trait = function(actor, trait_id)
    if not actor then return end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return end
    services.mutations.erase(actor, gid)
end
end
if H.npc == nil then
H.npc = function(ctx)
    return ctx:interlocutor()
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
if H.var_num == nil then
H.var_num = function(actor, key)
    if not actor then return 0 end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end
end
if H._jm_scaling_factor == nil then
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
end
end

ccb.runtime.handler("w16b_p_mindovermatter_7086f7c2b4e2", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "ASTHMA") == 1) and (not ((H.char_has_trait(H.u(ctx), "ASTHMA") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_synlungs"))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_6bde1105733e", function(ctx)
    return ((H.char_has_trait(H.npc(ctx), "ASTHMA") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_asthma_disease_absorbed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.char_has_bionic(H.u(ctx), "bio_synlungs"))
end)
ccb.runtime.handler("w16b_p_mindovermatter_5178bf197518", function(ctx)
    return ((((H.char_snap(H.npc(ctx)) or {}).creature or {}).has_weapon == true) and (H.char_spell_level(H.u(ctx), "telekinetic_pull") >= 1))
end)
ccb.runtime.handler("w16b_p_mindovermatter_0e5dd30e7184", function(ctx)
    return ((services.random.native_int(1, math.floor(5)) + (H.char_spell_level(H.u(ctx), "telekinetic_pull"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).strength or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_565c74480300", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "pyrokinetic_flash") >= 1) and (not ((H.npc(ctx) ~= nil and H.safe_id('json_flag', "FLASH_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.npc(ctx), H.safe_id('json_flag', "FLASH_PROTECTION")).value == true))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_09912424515c", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "pyrokinetic_flash"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).perception or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_d5e2d9347d85", function(ctx)
    return (((H.char_spell_level(H.u(ctx), "telepathic_morale") >= 1) or (H.char_spell_level(H.u(ctx), "telepathic_morale_knack") >= 1)) and (not ((H.char_has_trait(H.npc(ctx), "NPC_TELEPATHY_IMMUNE") == 1))) and (not (H.char_has_flag(H.npc(ctx), "TEEPSHIELD"))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_54688e1cd366", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_627938b5e45e", function(ctx)
    return (H.char_spell_level(H.u(ctx), "telepathic_confusion") >= 1)
end)
ccb.runtime.handler("w16b_p_mindovermatter_6efc18558042", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "telepathic_confusion"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).perception or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_4c3b877b2dbf", function(ctx)
    return (H.char_spell_level(H.u(ctx), "electrokinetic_paralysis") >= 1)
end)
ccb.runtime.handler("w16b_p_mindovermatter_f2f0ac88a66c", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "electrokinetic_paralysis"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).strength or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_9ac155185f5f", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "telepathic_blast") >= 1) and (not (H.char_has_flag(H.npc(ctx), "TEEPSHIELD"))) and (not ((H.char_has_trait(H.npc(ctx), "NPC_TELEPATHY_IMMUNE") == 1))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_fdc240a8ecb2", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "telepathic_blast"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_70afe4b589ba", function(ctx)
    return ((services.random.native_int(1, math.floor(5)) + (H.char_school_level(H.u(ctx), "TELEKINETIC"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).strength or 0)))
end)
ccb.runtime.handler("w16b_p_mindovermatter_de50508b98fe", function(ctx)
    return (((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "telepathic_confusion"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).perception or 0))) and (not ((H.char_has_trait(H.npc(ctx), "NPC_TELEPATHY_IMMUNE") == 1))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_5d9f1d316b29", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "telepathic_blast") >= 1))
end)
ccb.runtime.handler("w16b_p_mindovermatter_ad6aaaef15cb", function(ctx)
    return (((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "telepathic_blast"))) > ((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))) and (not ((H.char_has_trait(H.npc(ctx), "NPC_TELEPATHY_IMMUNE") == 1))))
end)
ccb.runtime.handler("w16b_p_mindovermatter_173db33ea2a2", function(ctx)
    return (H.char_spell_level(H.u(ctx), "teleport_transpose") >= 1)
end)
ccb.runtime.handler("w16b_p_mindovermatter_4534f337ac5d", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "teleport_transpose"))) > (10))
end)
ccb.runtime.handler("w16b_p_mindovermatter_9fcc35c61aba", function(ctx)
    return (H.char_spell_level(H.u(ctx), "teleport_banish") >= 1)
end)
ccb.runtime.handler("w16b_p_mindovermatter_69827bfb1407", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_spell_level(H.u(ctx), "teleport_banish"))) > (15))
end)
ccb.runtime.handler("w16b_a_mindovermatter_67b18abdffda", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(64800), math.floor(129600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MINDOVERMATTER_PRE_COLD_TO_COLD"), nil) end end
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_6fe944b01ee5", function(ctx)
    H.eoc_add_effect(H.u(ctx), "common_cold", services.random.native_float(86400, 1209600), nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_85040b4f9c01", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(64800), math.floor(129600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MINDOVERMATTER_PRE_FLU_TO_FLU"), nil) end end
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_b912f8015243", function(ctx)
    H.eoc_add_effect(H.u(ctx), "flu", services.random.native_float(259200, 864000), nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_8876dd159962", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_VIRAL_TO_CONJUNCTIVITIS_VIRAL"), nil) end end
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their eyes, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_32444df216a1", function(ctx)
    H.eoc_add_effect(H.u(ctx), "conjunctivitis_viral", (services.random.native_int(0, H.round_half_away(259200)) + 432000), nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their eyes, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_7cb8bd1885a3", function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_BACTERIAL_TO_CONJUNCTIVITIS_BACTERIAL"), nil) end end
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their eyes, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_5ac08d4c365b", function(ctx)
    H.eoc_add_effect(H.u(ctx), "conjunctivitis_bacterial", (services.random.native_int(0, H.round_half_away(259200)) + 432000), nil, nil, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their eyes, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_c4df3154f023", function(ctx)
    H.lose_trait(H.npc(ctx), "ASTHMA")
end)
ccb.runtime.handler("w16b_a_mindovermatter_7b974b64afc3", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_029b3ef37529", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their lungs, and draw it into yourself.  It tries to find purchase in your lungs, but it can't; plastic and steel are immune to the weaknesses of the flesh.  Denied purchase there, it settles into the surrounding tissue.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_53487ace6c42", function(ctx)
    H.lose_trait(H.npc(ctx), "CHEMIMBALANCE")
end)
ccb.runtime.handler("w16b_a_mindovermatter_c478c0beddda", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their mind, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(900)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_6b444f460865", function(ctx)
    H.lose_trait(H.npc(ctx), "SCHIZOPHRENIC")
end)
ccb.runtime.handler("w16b_a_mindovermatter_8206fef07cc7", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their mind, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(1800)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_5bde1764fcc2", function(ctx)
    H.lose_trait(H.npc(ctx), "JITTERY")
end)
ccb.runtime.handler("w16b_a_mindovermatter_b6aedcb3a17f", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their limbs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(900)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_2d5db4f256aa", function(ctx)
    H.lose_trait(H.npc(ctx), "MOODSWINGS")
end)
ccb.runtime.handler("w16b_a_mindovermatter_16d922d70635", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their mind, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(1200)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_60e8badef7d0", function(ctx)
    H.lose_trait(H.npc(ctx), "ROT1")
end)
ccb.runtime.handler("w16b_a_mindovermatter_3c9e32e96773", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their entire body, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(1200)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_777646196153", function(ctx)
    H.lose_trait(H.npc(ctx), "NARCOLEPTIC")
end)
ccb.runtime.handler("w16b_a_mindovermatter_1f7d7211739d", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their mind, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_c8f3b6789ab0", function(ctx)
    H.lose_trait(H.npc(ctx), "SEASONAL_ALLERGIES")
end)
ccb.runtime.handler("w16b_a_mindovermatter_c2325deeaaf1", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You touch <npc_name> and reach out with your powers, looking for the illness within them.  You soon find it, a shadow over their head and lungs, and draw it into yourself.")))
    do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(600)))) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_12c6ef369316", function(ctx)
    H.lose_trait(H.npc(ctx), "SEASONAL_AFFECTIVE")
end)
ccb.runtime.handler("w16b_a_mindovermatter_88a1e35636f2", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your telekinesis attempt failed!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_7c80882918f6", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<npc_name> looks away as the air erupts in a burst of light!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_d7b3b5a1ce40", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your telepathy attempt failed!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_ef9e812dba71", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You failed to affect <npc_name>'s senses!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_6a0121d8b531", function(ctx)
    H.run_eoc("EOC_ELECTROKIN_PARALYSIS", ctx, nil, "npc", "u")
end)
ccb.runtime.handler("w16b_a_mindovermatter_78222e552e7e", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You failed to paralyze <npc_name>!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_8cda4b563028", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "head_hp", H.char_hp(H.npc(ctx), "head", false))
    H.set_var("actor", H.npc(ctx), ctx, "percentage_damage_low", ((((H.char_spell_level(H.u(ctx), "telepathic_blast") * 3) + 5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")))
    H.set_var("actor", H.npc(ctx), ctx, "percentage_damage_high", ((((H.char_spell_level(H.u(ctx), "telepathic_blast") * 3) + 5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")))
    H.set_var("actor", H.npc(ctx), ctx, "percentage_damage", services.random.native_float(H.var_num(H.npc(ctx), "percentage_damage_low"), H.var_num(H.npc(ctx), "percentage_damage_high")))
    H.set_char_hp(H.npc(ctx), "head", (H.var_num(H.npc(ctx), "head_hp") * ((100 - H.var_num(H.npc(ctx), "percentage_damage")) / 100)), "=")
end)
ccb.runtime.handler("w16b_a_mindovermatter_06ef1401087c", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<npc_name> repelled your attack on their mind!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_8320ce7ac59d", function(ctx)
    H.set_char_hp(H.npc(ctx), "head", (80 - (6 * H.char_spell_level(H.u(ctx), "telepathic_blast"))), "=")
end)
ccb.runtime.handler("w16b_a_mindovermatter_b75defa2996d", function(ctx)
    do local g = H.safe_id('item', "spear_knife_proper"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "spear_pipe"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "spear_homemade_halfpike"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "makeshift_glaive"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "modular_m4_carbine"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "aksemi"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "ar15_50short"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "ar15_223short"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "mp40"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
    do local g = H.safe_id('item', "modular_m16a4"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_d7a86c032c0c", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You failed to teleport <npc_name>'s weapon!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_3c497b6f0cc4", function(ctx)
    do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_REMOVE_REFUGEE_CENTER_TRAITOR_BANISHED"), nil) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_9b073108e17a", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> seems ready to attack you but suddenly freezes in place.  For a moment, caught between worlds, they stare straight ahead.  As the cold and the darkness of a teleport begin to overtake them and the air around them wavers like summer heat, they open their mouth to scream.\n\nAnd then, they are gone.")))
    local _ach1 = H.safe_id("achievement", "mom_oublietted_refugee_center_traitor")
    if _ach1 then services.achievements.complete(_ach1) end
end)
ccb.runtime.handler("w16b_a_mindovermatter_c698f1c12500", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You failed to teleport <npc_name>!")), "bad")
end)
ccb.runtime.handler("w16b_a_mindovermatter_0b6d848660cb", function(ctx)
    do local _t = math.max(1, math.floor(4)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_REMOVE_REFUGEE_CENTER_TRAITOR_BANISHED"), nil) end end
end)
ccb.runtime.handler("w16b_a_mindovermatter_8d82a9a67e04", function(ctx)
    local _n2 = H.npc(ctx)
    local _fac3 = H.safe_id("faction", "hells_raiders")
    if _n2 and _fac3 then services.npcs.set_faction(_n2, _fac3) end
end)
ccb.runtime.handler("w16b_a_mindovermatter_e457d9286bc2", function(ctx)
    H.run_eoc("EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_BIOKINETIC_CRYSTAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_BIOKINETIC_CRYSTAL_CONSUME", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_mindovermatter_c6177b479547", function(ctx)
    H.run_eoc("EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_VITAKINETIC_CRYSTAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_VITAKINETIC_CRYSTAL_CONSUME", ctx, nil, nil, nil)
end)
