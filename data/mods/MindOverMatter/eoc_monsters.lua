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
if H.char_has_flag == nil then
H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
    return r.ok and r.value == true
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
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end

ccb.runtime.handler("w16b_mon_when_mindovermatter_eb30c877ac7c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS")))) == true
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_da185f3b02a1", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_CRAZY_VITAKINETIC_INFLICT_LIGMA", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_c4cce8a29bc8", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_CRAZY_VITAKINETIC_INFLICT_LIGMA_EXTREME", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_6cf230094803", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_VITAKIN2_ENERVATING_TOUCH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_6986d99a6519", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.test_eoc("is_disarmed", ctx) and ((function() local eg = H.safe_id('effect', "effect_psi_biokin3_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_8a7174e1823a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_psi_biokin3_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.npc(ctx), "TELEKIN_SHIELD"))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_fb72296512b9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_psi_biokin3_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_4d92a16fa162", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_hardened_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "effect_psi_biokin3_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_a3eae0f26df3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_heightened_reflex_enhanced"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_10c7bd6453e1", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (H.char_has_flag(H.npc(ctx), "TELEKIN_SHIELD"))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_3df3bbb22100", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_momentum_alteration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_6bb95bd15562", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_inertial_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_e53c732a5619", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_feral_regeneration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_83e63041f3d4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (H.char_has_flag(H.npc(ctx), "TELEKIN_SHIELD"))) and (not (H.char_has_flag(H.npc(ctx), "TELEKIN_PUSH_PULL_IMMUNE"))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_8534ea177917", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_inertial_barrier_improved"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_21f53da13125", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and ((((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true)) and (not (((function() local eg = H.safe_id('effect', "effect_monster_aegis_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_0a1289ec67cd", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.test_eoc("is_disarmed", ctx) and (not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and ((function() local eg = H.safe_id('effect', "effect_monster_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 1))) == true
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_84c4704b4e03", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_TELEPORTER_TELEPORTION_TOUCH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_f4d948af1e5e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement_monster"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_23492a7c8bd0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and (not (((function() local eg = H.safe_id('effect', "effect_monster_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_a65057752e92", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_PSIONICS"))) and ((function() local eg = H.safe_id('effect', "effect_monster_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 1))) == true
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_ad33afa22983", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_VITAKIN1_ENERVATING_TOUCH", ctx)
end)
ccb.runtime.handler("w16b_mon_die_mindovermatter_3585af2523f2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_VITAKIN3_DEATH_EFFECT", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_5ec492fc68aa", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_VITAKIN3_ENERVATING_TOUCH", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_1ebccc34ce71", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_VITAKIN_FERAL_VITA3_DEGENERATING_TOUCH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_22fe335795fb", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "effect_hound_extended_speed_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_mindovermatter_118c53782a77", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_MOM_HOUND_SPEED_ADJUSTMENT", ctx)
end)
ccb.runtime.handler("w16b_mon_when_mindovermatter_f95e310c1a27", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "effect_hound_extended_speed_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
end)
