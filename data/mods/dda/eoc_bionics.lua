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
    id = "bio_adrenaline",
    name = "Adrenaline Pump",
    description = "A stimulator system has been surgically implanted alongside your adrenal glands, allowing you to trigger your body's adrenaline response at the cost of some bionic power.",
    activation_energy_millijoules = 5000,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 4 },
    },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_blood_filter",
    name = "Blood Filter",
    description = "A filtration system near your heart allows you to actively filter out chemical impurities, primarily drugs.  It will have limited impact on viruses.  Note that it is not a targeted filter; ALL drugs in your system will be affected.",
    activation_energy_millijoules = 600000,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 5 },
    },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_mp3",
    name = "WearMan",
    description = "Surgically implanted into your skull near the eardrums are two speakers, as well as a small port behind the left earlobe.  They can pick up local radio waves and play downloaded music in concert hall quality.  It came pre-installed with \"Rubik's Mickse\".",
    activation_energy_millijoules = 1000,
    over_time_energy_millijoules = 1000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "head", slots = 1 },
    },
    flags = { "USES_BIONIC_POWER", "BIONIC_TOGGLED" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_ethanol",
    name = "Ethanol Burner",
    description = "You burn alcohol as fuel in an extremely efficient reaction.",
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 20 },
    },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_SHOCKPROOF", "BIONIC_TOGGLED" },
    fuel_options = { "alcohol" },
    fuel_efficiency = 0.5,
    exothermic_power_gen = true,
    passive_pseudo_items = { "internal_ethanol_tank" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_lampoil",
    name = "Oil Generator",
    description = "Slowly generates bionic power out of kerosene or motor oil.",
    charge_time_turns = 5,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 20 },
    },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_SHOCKPROOF", "BIONIC_TOGGLED" },
    fuel_options = { "lamp_oil", "motor_oil" },
    fuel_efficiency = 0.35,
    exothermic_power_gen = true,
    passive_pseudo_items = { "internal_oil_tank" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_hydraulics",
    name = "Hydraulic Muscles",
    description = "While activated, your muscles will be greatly enhanced, increasing  your strength by 10, with a minimum setting to 20.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 10000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 10 },
        { bodypart = "arm_l", slots = 8 },
        { bodypart = "arm_r", slots = 8 },
        { bodypart = "leg_l", slots = 10 },
        { bodypart = "leg_r", slots = 10 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    enchantments = { "BIONIC_ENCH_bio_hydraulics_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_metabolics",
    name = "Metabolic Interchange",
    description = "Your digestive system and power supply are interconnected; bionic energy is replenished by burning calories.  Can be toggled on and off at will.",
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 20 },
    },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    fuel_options = { "metabolism" },
    fuel_efficiency = 0.25,
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_sonar",
    name = "Subaquatic Navigation System",
    description = "While active, a tiny device in your inner ear periodically generates ultrasonic pulses which aid in navigation, provided you are underwater and able to hear.",
    activation_energy_millijoules = 1000,
    trigger_energy_millijoules = 5000,
    occupied_bodyparts = {
        { bodypart = "head", slots = 1 },
    },
    flags = { "BIONIC_TOGGLED" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_time_freeze",
    name = "Time Dilation",
    description = "At the cost of all stored bionic power, you may increase your body speed and reactions dramatically, essentially freezing time.  You are still delicate, however, and violent or rapid movements may damage you due to friction.",
    activation_energy_millijoules = 50000000,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 12 },
        { bodypart = "head", slots = 3 },
        { bodypart = "arm_l", slots = 3 },
        { bodypart = "arm_r", slots = 3 },
        { bodypart = "hand_l", slots = 1 },
        { bodypart = "hand_r", slots = 1 },
        { bodypart = "leg_l", slots = 4 },
        { bodypart = "leg_r", slots = 4 },
        { bodypart = "foot_l", slots = 1 },
        { bodypart = "foot_r", slots = 1 },
    },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_fuel_cell_gasoline",
    name = "Gasoline Fuel Cell",
    description = "A small gasoline fuel cell fixed to your scapula.  Despite its limited energy output compared to other fuel cells, this device still produces a significant amount of heat dissipated through a heat exhaust protruding from your back.  A diffuse network of bio-plastic bladders has been meshed with your circulatory system and serves as a fuel tank.",
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 8 },
    },
    encumbrance = {
        { bodypart = "torso", amount = 5 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_POWER_SOURCE" },
    fuel_options = { "gasoline" },
    fuel_efficiency = 0.25,
    exothermic_power_gen = true,
    passive_pseudo_items = { "internal_gasoline_tank" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_nl_dimensional_anchor",
    name = "Dimensional Anchor",
    description = "Your body has been wired with advanced technology that locks you into your native dimensionality, protecting you from unwanted teleportation and some other phase altering effects.",
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 50000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 16 },
        { bodypart = "arm_l", slots = 3 },
        { bodypart = "arm_r", slots = 3 },
        { bodypart = "leg_l", slots = 4 },
        { bodypart = "leg_r", slots = 4 },
    },
    flags = { "USES_BIONIC_POWER", "BIONIC_TOGGLED" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_nl_hair",
    name = "Artificial Hair",
    description = "Your hair follicles have been replaced with mechanical sphincters that control the extrusion and retraction of advanced nanotube hair technology.  Activate this to change the style or color of your artificial hair.",
    activation_energy_millijoules = 1000,
    occupied_bodyparts = {
        { bodypart = "head", slots = 1 },
    },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    canceled_mutations = {
        "hair_beaded",
        "hair_body_length",
        "hair_braid",
        "hair_bun",
        "hair_buzzcut",
        "hair_crewcut",
        "hair_curls",
        "hair_detective",
        "hair_extremely_long",
        "hair_fro",
        "hair_long",
        "hair_long_mohawk",
        "hair_long_over_eye",
        "hair_medium",
        "hair_messy",
        "hair_modern",
        "hair_mohawk",
        "hair_mullet",
        "hair_ponytail",
        "hair_puff",
        "hair_punk_long",
        "hair_short",
        "hair_short_no_fringe",
        "hair_short_over_eye",
        "hair_super_princess",
        "hair_twintails",
        "hair_very_long",
        "natural_hair_growth",
        "natural_beard_growth",
        "natural_hair_color_black",
        "natural_hair_color_blond",
        "natural_hair_color_brown",
        "natural_hair_color_gray",
        "natural_hair_color_red",
        "natural_hair_color_white",
    },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_nl_blood_factory",
    name = "Bone Marrow Bio-Factory",
    description = "Your bone marrow is now home to several specialized nanorobots.  Activating them will increase blood cell production at the cost of stored calories and bionic energy.",
    activation_energy_millijoules = 40000,
    over_time_energy_millijoules = 40000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 1 },
        { bodypart = "arm_l", slots = 1 },
        { bodypart = "arm_r", slots = 1 },
        { bodypart = "leg_l", slots = 1 },
        { bodypart = "leg_r", slots = 1 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE", "BIONIC_SLEEP_FRIENDLY", "BIONIC_SHOCKPROOF" },
})
ccb.runtime.handler("w16b_dda_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_adrenaline" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_adrenaline", ctx)
    elseif bid == "bio_blood_filter" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_blood_filter", ctx)
    elseif bid == "bio_mp3" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_BIONIC_WEARMAN_SELECTOR", ctx)
    elseif bid == "bio_hydraulics" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_hydraulics_activated", ctx)
    elseif bid == "bio_sonar" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_BIO_SONAR_activated", ctx)
    elseif bid == "bio_time_freeze" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_time_freeze", ctx)
    elseif bid == "bio_nl_dimensional_anchor" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_nl_dimensional_anchor", ctx)
    elseif bid == "bio_nl_hair" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_nl_hair", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_dda_on_bionic_activated")
ccb.runtime.handler("w16b_dda_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_mp3" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_BIONIC_WEARMAN_REMOVAL", ctx)
    elseif bid == "bio_hydraulics" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_hydraulics_deactivated", ctx)
    elseif bid == "bio_sonar" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_BIO_SONAR_deactivated", ctx)
    elseif bid == "bio_nl_dimensional_anchor" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_nl_dimensional_anchor_removal", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_dda_on_bionic_deactivated")
ccb.runtime.handler("w16b_dda_on_bionic_processed", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_ethanol" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_noise_quiet_burn", ctx)
    elseif bid == "bio_lampoil" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_noise_quiet_burn", ctx)
    elseif bid == "bio_metabolics" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_noise_digestive", ctx)
    elseif bid == "bio_fuel_cell_gasoline" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_noise_gasoline", ctx)
    elseif bid == "bio_nl_blood_factory" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_nl_blood_factory", ctx)
    end
end)
ccb.runtime.hook("on_bionic_processed", "w16b_dda_on_bionic_processed")
