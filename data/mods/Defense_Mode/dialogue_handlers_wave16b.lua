local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

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
if H.safe_id == nil then
H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
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
if H.global_var_num == nil then
H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
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

ccb.runtime.handler("w16b_p_defense_mode_7701335cfe5a", function(ctx)
    return (H.global_var_num("trading_allowed") == 0)
end)
ccb.runtime.handler("w16b_p_defense_mode_dae3c9a0a9a2", function(ctx)
    return ((H.global_var_num("regular_zombies_allowed") == 1) or (H.global_var_num("special_zombies_allowed") == 1) or (H.global_var_num("spiders_allowed") == 1) or (H.global_var_num("triffids_allowed") == 1) or (H.global_var_num("robots_allowed") == 1) or (H.global_var_num("subspace_allowed") == 1) or (H.global_var_num("dinos_allowed") == 1) or (H.global_var_num("lizardfolk_allowed") == 1) or (H.global_var_num("goblins_allowed") == 1) or (H.global_var_num("golems_allowed") == 1) or (H.global_var_num("orcs_allowed") == 1) or (H.global_var_num("megafauna_allowed") == 1) or (H.global_var_num("mindovermatter_allowed") == 1) or (H.global_var_num("candymonsters_allowed") == 1) or (H.global_var_num("mythos_allowed") == 1) or (H.global_var_num("exodii_allowed") == 1) or (H.global_var_num("xedra_allowed") == 1) or (H.global_var_num("aftershock_allowed") == 1))
end)
ccb.runtime.handler("w16b_a_defense_mode_93e67421ae14", function(ctx)
    H.run_eoc("defense_mode_money_add_npc", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_e7361c1a4278", function(ctx)
    local _n1, _u2 = H.npc(ctx), H.u(ctx)
    if _n1 and _u2 then
        local _pay3 = services.trade.pay(_n1, _u2, math.floor(50000))
        if _pay3.ok and _pay3.value == true then
            H.receive_item(_u2, "mercenary_contract", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
    H.run_eoc("defense_mode_money_add_npc", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_d4141f5f8a77", function(ctx)
    local _n4, _u5 = H.npc(ctx), H.u(ctx)
    if _n4 and _u5 then
        local _pay6 = services.trade.pay(_n4, _u5, math.floor(50000))
        if _pay6.ok and _pay6.value == true then
            H.receive_item(_u5, "mercenary_contract", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
    H.run_eoc("defense_mode_money_add_npc", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_6c98740d08ea", function(ctx)
    local _n7, _u8 = H.npc(ctx), H.u(ctx)
    if _n7 and _u8 then
        local _pay9 = services.trade.pay(_n7, _u8, math.floor(50000))
        if _pay9.ok and _pay9.value == true then
            H.receive_item(_u8, "mercenary_contract", 1, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
    H.run_eoc("defense_mode_money_add_npc", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_1fa21d483221", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 1)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "your_spawnpoint", { terrain = "bar" }, { z = math.floor(0) }, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
end)
ccb.runtime.handler("w16b_a_defense_mode_296a9ff5a306", function(ctx)
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_0d6d2f53de6e", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 1)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_f0fe268dafaa", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 1)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_cb8db5532f28", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 1)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "your_spawnpoint", { terrain = "dm_mansion_e2" }, { z = math.floor(0) }, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_90d5bf0fcf83", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 1)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
ccb.runtime.handler("w16b_a_defense_mode_37ee9666505a", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
    H.set_var("global", nil, ctx, "subspace_allowed", 1)
    H.run_eoc("defense_mode_game_start_final_setup", ctx, nil, nil, nil)
end)
