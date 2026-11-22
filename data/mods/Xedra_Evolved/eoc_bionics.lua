local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

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

ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_calorie_storage",
    name = "Calorie Etherealization System",
    description = "The best place to store calories is inside your own body.  Unfortunately, caloric oversaturation causes issues that impede this perfect storage.  Thanks to magnets, orbital trajectories and your own ingenuity, your calories are now close to you and will be consumed as needed without penalties.  The process is imperfect and the orbit can't be maintained without power, but nothing preserves calories this well.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 100000,
    charge_time_turns = 10,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 8 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_creative_fuel",
    name = "Creative-Electric Converter",
    description = "Blood is fuel?  More like everything is fuel.  This device drains your very creativity to produce power for your bionics.  It's somehow simultaneously among your best and worst ideas.",
    activation_energy_millijoules = 1000,
    occupied_bodyparts = {
        { bodypart = "head", slots = 4 },
    },
    flags = { "BIONIC_FUEL_SOURCE" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_book_burn_boost",
    name = "Book Burner's Buddy",
    description = "Probably the most selfish thing you ever made, constantly burning countless pieces of written media for fleeting knowledge.  You might think it is worth the price, but the false knowledge this so-called buddy fills you with will leave little room to learn anything else, coercing you to burn books further and forevermore for a simulacrum of smarts.",
    activation_energy_millijoules = 15000000,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 6 },
    },
    enchantments = {
        "BIONIC_ENCH_bio_inventor_book_burn_boost_0",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_1",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_2",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_3",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_4",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_5",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_6",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_7",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_8",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_9",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_10",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_11",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_12",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_13",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_14",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_15",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_16",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_17",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_18",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_19",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_20",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_21",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_22",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_23",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_24",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_25",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_26",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_27",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_28",
    },
})
ccb.runtime.handler("w16b_xedra_evolved_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_inventor_calorie_storage" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_calorie_storage_activated", ctx)
    elseif bid == "bio_inventor_creative_fuel" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_inventor_creative_fuel", ctx)
    elseif bid == "bio_inventor_book_burn_boost" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_book_burn_boost_activated", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_xedra_evolved_on_bionic_activated")
ccb.runtime.handler("w16b_xedra_evolved_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_inventor_calorie_storage" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_calorie_storage_deactivated", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_xedra_evolved_on_bionic_deactivated")
