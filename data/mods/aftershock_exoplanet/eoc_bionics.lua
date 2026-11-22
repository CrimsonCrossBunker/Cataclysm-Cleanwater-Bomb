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

local EOC = E.run
local COND = E.cond
EOC["bio_shield_weak_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 120, ["shield_regen"] = 1, ["shield_regen_rate"] = 2, ["success_message"] = "The shield activates.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_weak_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_weak_activate"](H.ctx_new(u, npc, vars))
end)
EOC["bio_shield_medium_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 550, ["shield_regen"] = 2, ["shield_regen_rate"] = 1, ["success_message"] = "The shield activates.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_medium_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_medium_activate"](H.ctx_new(u, npc, vars))
end)
EOC["bio_shield_heavy_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 10000, ["shield_regen"] = 20, ["shield_regen_rate"] = 1, ["success_message"] = "All surrounding noise is muted as the barrier coalesces.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_heavy_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_heavy_activate"](H.ctx_new(u, npc, vars))
end)

ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_chemical_enhancement_rig",
    name = "Chemical Enhancement Rig and computer",
    description = "An implanted AI module and medication dispenser calculates the optimal chemical mix to keep you on your toes and ready for combat.  This bionic must be active to function and while it functions your body is at a heightened performance but if it turns off it will take you several days to get back to normal.  There are a significant number of baseline bonuses granted by this setup but people around will notice your junkie behavior.  This bionic must be active to function.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    occupied_bodyparts = {
        { bodypart = "head", slots = 5 },
        { bodypart = "torso", slots = 10 },
        { bodypart = "arm_l", slots = 3 },
        { bodypart = "arm_r", slots = 3 },
        { bodypart = "leg_l", slots = 3 },
        { bodypart = "leg_r", slots = 3 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "heightened_performance" },
    included_bionics = { "afs_speed_injection", "afs_healing_injection", "afs_strength_injection" },
    activated_on_install = true,
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_speed_injection",
    name = "Speed Injection System",
    description = "The chemical injection system and microcomputer that when activated greatly enhances your reaction times and overall speed.  Upon deactivation, the user may experience dizziness, heart palpitations and ravenous appetites.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_speed_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_healing_injection",
    name = "Pain Suppression Injection System",
    description = "The chemical injection system and microcomputer that when activated gives a burst of chemicals that allows your blood to work a little harder at stabilizing the body and then flushes your system with a powerful anesthetic that allows you to continue operating at high capacity.  Upon deactivation, the user may experience extreme lethargy, sudden loss of consciousness, among other symptoms that may prove potentially fatal if not in a safe location.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_healing_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_strength_injection",
    name = "Strength Injection System",
    description = "The chemical injection system and microcomputer that, when activated, provides a steroid burst, significantly enhancing strength and stamina while accelerating metabolism.  Upon deactivation, the user may experience sleepiness and feel worn down.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_strength_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_weak",
    name = "HawkingCorps Mark I Shield",
    description = "Imagine a computer inside your body playing pong against the universe.  The paddles are made of -color glass condensate- and any and all of their specific functions are the intellectual property of the Hawking Corporation and/or its local subsidiaries.\n-From the owners manual of HawkingCorps Mark I Shield.\n\nActivating the shield will create an energy shield capable of negating a modest amount of damage from weak or improvised weapons.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 8 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    available_upgrades = { "bio_shield_medium", "bio_shield_heavy" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_medium",
    name = "HawkingCorps Mark V Shield",
    description = "Powerful and covert, the Mark V Shield is a military-grade shielding system developed for use within UICA's special service branches.  Although much more effective than anything that could be conceived with current technology, it remains a pale imitation of the Hyperspace Age systems it was reverse-engineered from.\n\nActivating the shield will create an energy barrier capable of withstanding a modest amount of melee and ranged damage.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 2000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 12 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    upgraded_bionic = "bio_shield_weak",
    available_upgrades = { "bio_shield_heavy" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_heavy",
    name = "Kinetic Annulment System",
    description = "A powerful shielding system salvaged from a pre-Discontinuity robotic warframe, crudely adapted for compatibility with biological hosts.  Powerful enough to withstand prolonged assault from anti-vehicle weaponry.",
    activation_energy_millijoules = 1500000000,
    over_time_energy_millijoules = 100000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 14 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    enchantments = { "BIONIC_ENCH_bio_shield_heavy_0" },
    upgraded_bionic = "bio_shield_medium",
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_blade_fire",
    name = "Bioweapon Thermal Conduits",
    description = "An improved ulnar sheath equipped with thermal inductors allows for the super heating of all types of implanted bladed weaponry.  While this bionic is active, any deployed bionic blades will deal additional fire damage to targets.",
    activation_energy_millijoules = 1500000,
    over_time_energy_millijoules = 250000,
    occupied_bodyparts = {
        { bodypart = "arm_r", slots = 7 },
    },
    encumbrance = {
        { bodypart = "arm_r", amount = 2 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    enchantments = { "BIONIC_ENCH_afs_bio_blade_fire_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_blade_electric",
    name = "Bioweapon Superconductive Channels",
    description = "Paired capacitor banks maintain implanted bladed weaponry under constant electrical charge.  While this bionic is active, any deployed bionic blades will deal additional electric damage with a chance of the damage arcing to other nearby targets.",
    activation_energy_millijoules = 1500000,
    over_time_energy_millijoules = 1000000,
    occupied_bodyparts = {
        { bodypart = "arm_r", slots = 7 },
    },
    encumbrance = {
        { bodypart = "arm_r", amount = 2 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    enchantments = { "BIONIC_ENCH_afs_bio_blade_electric_0" },
})
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_bio_chemical_enhancement_rig" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chembaseline", ctx)
    elseif bid == "afs_speed_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemspeed", ctx)
    elseif bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemhealing", ctx)
    elseif bid == "afs_strength_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemstrength", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_weak_activate", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_medium_activate", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_heavy_activate", ctx)
    elseif bid == "afs_bio_blade_fire" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_superheater_on", ctx)
    elseif bid == "afs_bio_blade_electric" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_blade_electric_on", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_aftershock_exoplanet_on_bionic_activated")
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_bio_chemical_enhancement_rig" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_baseline", ctx)
    elseif bid == "afs_speed_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_speed", ctx)
    elseif bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_healing", ctx)
    elseif bid == "afs_strength_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_strength", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "afs_bio_blade_fire" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_superheater_off", ctx)
    elseif bid == "afs_bio_blade_electric" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_blade_electric_off", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_aftershock_exoplanet_on_bionic_deactivated")
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_processed", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemhealing_pkill", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    end
end)
ccb.runtime.hook("on_bionic_processed", "w16b_aftershock_exoplanet_on_bionic_processed")
