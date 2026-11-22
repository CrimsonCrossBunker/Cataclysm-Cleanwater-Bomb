local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
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
if H.u == nil then
H.u = function(ctx)
    return ctx:speaker()
end
end

ccb.runtime.handler("w16b_mon_hit_xedra_evolved_fa5cd452db4e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_VAMPIRE_DRINK_BLOOD", ctx)
    E.H.run_eoc("EOC_FERAL_VAMPIRE_DRINK_GAIN_RANDOM_BUFF", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_45e65cdb86ff", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "GRAB_FILTER"))) and (not (((function() local eg = H.safe_id('effect', "effect_vampire_monster_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_61dac5e052b4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not ((H.creature_has_effect(H.u(ctx), "effect_vampire_monster_strength") or H.creature_has_effect(H.u(ctx), "effect_vampire_monster_agility") or H.creature_has_effect(H.u(ctx), "effect_vampire_monster_resilience") or H.creature_has_effect(H.u(ctx), "effect_vampire_monster_speed"))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_xedra_evolved_31121f454ad0", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_VAMPIRE_GAIN_RANDOM_BUFF", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_xedra_evolved_64f2f1ddd8da", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_VAMPIRE_DRINK_BLOOD", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_47df1c956c58", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_vampire_monster_speed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_c834f7f30ed5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_vampire_monster_agility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_cdb593e3486c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_vampire_monster_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_afced22116e5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_vampire_monster_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_a91bd9385f75", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((function() local eg = H.safe_id('effect', "effect_vampire_monster_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_8ea0389db125", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((((H.npc(ctx) ~= nil) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true)))) and (not (((function() local eg = H.safe_id('effect', "effect_vampire_fear_gazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_0f5238cc64e4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE") or (H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1) or (H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1) or (H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1) or (H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1) or (H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_2f2ac3732087", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and ((not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true)))))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_xedra_evolved_058bc1866729", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_ARION_DRINK_BLOOD", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_09748b7bcc0f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_has_flag(H.u(ctx), "GRAB_FILTER") and H.char_has_flag(H.npc(ctx), "GRAB") and (H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true))))) == true
end)
ccb.runtime.handler("w16b_mon_die_xedra_evolved_cb768c7fc17c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_THORNHOUND_DEATH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_86ee7d016ae2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((function() local eg = H.safe_id('effect', "disarmed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_e2df8222962f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (H.test_eoc("is_disarmed", ctx)) == true
end)
ccb.runtime.handler("w16b_mon_hit_xedra_evolved_2524c4537484", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_XE_TROLL_HITS_YOU_WITH_GIANT_CLUB", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_d4cd0bcead05", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (H.test_eoc("is_disarmed", ctx)))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_6dbf109294e6", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not ((services.time_snapshot().season_id == string.lower("winter")))) or ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (services.time_snapshot().season_id == string.lower("winter"))))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_d9e93a3f55a3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_monster_a_fire_in_the_blood"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_faca5845ba63", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((H.char_snap(H.npc(ctx)) or {}).avatar == true)) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_27ee8d032652", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((H.time_until_named("noon", true) / 3600) >= 7)) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_b641aeb199f2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((H.time_until_named("noon", false) / 3600) <= 7)) == true
end)
ccb.runtime.handler("w16b_mon_die_xedra_evolved_90651120d48a", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_XE_KRECK_DEATH", ctx)
end)
ccb.runtime.handler("w16b_mon_die_xedra_evolved_10e4860dc65e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_XE_SHOGGOTH_DEATH", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_9790d84ef309", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (((function() local eg = H.safe_id('effect', "effect_werewolf_red_handed_rage_monster"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
end)
ccb.runtime.handler("w16b_mon_hit_xedra_evolved_64ed68f604c3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_WEREWOLF_TRIGGERS_RED_HANDED_RAGE_CHANCE", ctx)
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_f74fd399411f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((function() local eg = H.safe_id('effect', "effect_werewolf_red_handed_rage_monster"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
end)
ccb.runtime.handler("w16b_mon_when_xedra_evolved_7bd1de8d8a44", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.char_hp(H.u(ctx), "ALL", false) < 75)) == true
end)
