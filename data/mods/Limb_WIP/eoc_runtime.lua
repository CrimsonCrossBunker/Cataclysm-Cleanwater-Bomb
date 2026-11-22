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
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
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
H.item_matches_search = function(snap, crit)
    if not crit then return true end
    if crit.id and snap.id and snap.id.value ~= crit.id then return false end
    if crit.category and snap.category ~= crit.category then return false end
    if crit.worn_only and snap.location_kind ~= "worn" then return false end
    if crit.wielded_only and snap.location_kind ~= "wielded" then return false end
    return true
end
H.eoc_run_inv_eocs = function(actor, ctx, mode, title, search_list, true_eocs, false_eocs)
    if not actor then return end
    local matches = {}
    local cont = nil
    for _ = 1, 32 do
        local p = services.inventory.carried_items(actor)
        local pr = services.items.page({ character = actor }, { page_size = 256 }, cont)
        if not pr.ok or not pr.value then break end
        for _, item in ipairs(pr.value.items or {}) do
            local ok_match = (not search_list or #search_list == 0)
            if not ok_match then
                local sr = services.items.snapshot(item)
                local snap = sr.ok and sr.value or {}
                for _, crit in ipairs(search_list) do
                    if H.item_matches_search(snap, crit) then
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
        if not pr.value.has_more then break end
        cont = pr.value.continuation
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
H.npc = function(ctx)
    return ctx:interlocutor()
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
H.u = function(ctx)
    return ctx:speaker()
end

require("eoc_handlers_01")(E, H)

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
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PROSTHETIC_HIT", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")

return E
