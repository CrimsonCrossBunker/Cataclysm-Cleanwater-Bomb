local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function minutes(n)
    return services.time.duration(n, "minute")
end

local function add_effect(actor, effect_id, duration, opts)
    local applied = services.effects.add(actor, id("effect", effect_id), duration, opts)
    if not applied.ok and applied.error.code ~= "rejected" then
        error(applied.error.message)
    end
end

local function add_permanent_random_part_effect(actor, effect_id)
    local part = checked(services.characters.random_body_part(actor, true))
    add_effect(actor, effect_id, services.time.duration(1, "turn"), {
        body_part = part,
        permanent = true,
        intensity = 1,
    })
end

local function add_morale(actor, bonus, max_bonus, duration_min, decay_min)
    checked(services.morale.add(actor, id("morale", "morale_feeling_bad"), bonus, max_bonus, {
        duration = minutes(duration_min),
        decay_start = minutes(decay_min),
    }))
end

local function assign_mission(actor, mission_id)
    local reserved = checked(services.missions.reserve(id("mission", mission_id)))
    checked(services.missions.assign(actor, reserved.token))
end

local function run_mapgen_update_at(omt, update_id)
    local tile = checked(services.overmap.tile_token(omt))
    local update = checked(services.mapgen.update_token(id("update_mapgen", update_id)))
    checked(services.mapgen.run_update(tile, update))
end

local function popup_message(actor, text, severity)
    if actor.subtype ~= "avatar" then
        return
    end
    local translated = services.translate(text)
    ccb.presentation.notice(translated)
    services.activities.offer_interruption("")
    if severity then
        services.messages.add(translated, severity)
    else
        services.messages.add(translated)
    end
end

local function set_global(key, value)
    checked(services.variables.set_global(key, value, { include_before = false }))
end

local function bind_scenario(scenario_id, start_handler, due_handler, callback)
    ccb.runtime.handler(due_handler, callback)
    ccb.runtime.handler(start_handler, function(payload)
        ccb.tasks.after_character_turn(payload.character, 0, due_handler)
    end)
    content.replace(content.Scenario {
        id = scenario_id,
        inherits = scenario_id,
        on_start = start_handler,
    })
end

local function start_infected(actor)
    add_permanent_random_part_effect(actor, "infected")
    assign_mission(actor, "MISSION_INFECTED_START_FIND_ANTIBIOTICS")
end

bind_scenario("infected", "scenario_infected_start", "scenario_infected_due", function(payload)
    start_infected(payload.character)
end)

bind_scenario("fungal_start", "scenario_fungal_start", "scenario_fungal_due", function(payload)
    add_permanent_random_part_effect(payload.character, "fungus")
end)

bind_scenario("fire", "scenario_fire_start", "scenario_fire_due", function(payload)
    local actor_omt = checked(services.creatures.snapshot(payload.character)).position:project_to("omt")
    run_mapgen_update_at(actor_omt, "SCENARIO_FIRE")
    run_mapgen_update_at(actor_omt, "SCENARIO_SMOKE")
end)

bind_scenario("bad_day", "scenario_bad_day_start", "scenario_bad_day_due", function(payload)
    local actor = payload.character
    start_infected(actor)
    add_effect(actor, "flu", minutes(1000), { intensity = 1 })
    add_effect(actor, "drunk", minutes(270), { intensity = 1 })
    add_morale(actor, -100, -100, 50, 50)
end)

bind_scenario("faction_camp_start", "scenario_faction_camp_start", "scenario_faction_camp_due", function(payload)
    local actor_omt = checked(services.creatures.snapshot(payload.character)).position:project_to("omt")
    run_mapgen_update_at(actor_omt, "faction_start_add")
end)

bind_scenario("trapped_in_labyrinth", "scenario_trapped_in_labyrinth_start", "scenario_trapped_in_labyrinth_due", function(payload)
    local actor = payload.character
    checked(services.variables.set_string_notifying(actor, "scenario_trapped_in_labyrinth", "yes"))
    local travel = checked(services.relocation.travel_to_dimension("scarlet", {
        npc_travel_radius = 0,
        npc_travel_filter = "none",
    }))
    if actor.subtype == "avatar" then
        services.messages.add(services.translate(travel.accepted
            and "Your surroundings warp and fold into the recesses of another world."
            or "You feel a prickle at the edge of your senses."))
    end
    assign_mission(actor, "MISSION_FIND_LABYRINTH_SPIRE")

    local origin_omt = checked(services.creatures.snapshot(actor)).position:project_to("omt")
    local omt1 = services.overmap.find_target(origin_omt, "scarlet_sea_reverberation", {
        z = 0,
        min_distance = 0,
        search_range = 5,
        random = true,
    })
    local ms1 = omt1:project_to("ms")
    local loc1 = services.world.find_location(ms1, { kind = "terrain", id = id("terrain", "t_sand_scarlet") }, {
        target_max_radius = 20,
        min_radius = 0,
        max_radius = 0,
    })
    local anchor = (loc1.found and loc1.position) or ms1
    actor = checked(services.relocation.teleport_creature(actor, anchor)).handle

    local omt2 = services.overmap.find_target(
        checked(services.creatures.snapshot(actor)).position:project_to("omt"),
        "scarlet_scrap_metal_spire",
        { special = id("overmap_special", "scarlet_scrap_metal_spire"), create_special = true })
    local loc2 = services.world.find_location(omt2:project_to("ms"), nil)
    local spire = (loc2.found and loc2.position) or omt2:project_to("ms")
    checked(services.variables.set(actor, "scarlet_scrap_metal_spire_loc", spire, { include_before = false }))
    actor = checked(services.relocation.teleport_creature(actor, spire, { force = true })).handle

    local omt3 = services.overmap.find_target(
        checked(services.creatures.snapshot(actor)).position:project_to("omt"),
        "scarlet_sea_reverberation",
        { min_distance = 10, search_range = 15, random = true })
    local loc3 = services.world.find_location(omt3:project_to("ms"), nil)
    local start_pos = (loc3.found and loc3.position) or omt3:project_to("ms")
    checked(services.variables.set(actor, "scenario_trapped_in_labyrinth_start_location", start_pos,
        { include_before = false }))
    actor = checked(services.relocation.teleport_creature(actor, start_pos, { force = true })).handle

    popup_message(actor,
        "During the worst of the portal storms you found yourself exposed, and existence as you knew it folded in upon itself.  It's hard to know how long you were floating through a clawing nothingness.  But you've now come to your senses… somewhere else.\n\nAll around you is a shallow sea, expanding endlessly under a harsh air and a scarlet sky.\n\nAfter regaining your footing, you notice something in the distance: a tall, jagged spire, and a green light atop it.\n\nCould this be your salvation?")
end)

bind_scenario("lone_survivor_start", "scenario_lone_survivor_start", "scenario_lone_survivor_due", function(payload)
    local actor = payload.character
    popup_message(actor,
        "They are all dead.  The group you were surviving with has been annihilated.  Their bodies are still nearby.  You are the last one left alive and their screams will haunt you.",
        "warning")
    add_morale(actor, -100, -100, 1440, 180)
end)

bind_scenario("low_profile_start", "scenario_low_profile_start", "scenario_low_profile_due", function(payload)
    local actor = payload.character
    add_effect(actor, "drunk", minutes(270), { intensity = 1 })
    add_morale(actor, -50, -50, 50, 50)
end)

ccb.runtime.handler("scenario_moonlit_deactivate_due", function()
    set_global("is_moonlit_scenario", 0)
    checked(services.weather.refresh())
end)

bind_scenario("a_moonlit_night_start", "scenario_a_moonlit_night_start", "scenario_a_moonlit_night_due", function(payload)
    local actor = payload.character
    if actor.subtype == "avatar" then
        services.messages.add(services.translate("The moon shines brightly."))
    end
    set_global("is_moonlit_scenario", 1)
    checked(services.weather.refresh())
    ccb.tasks.after_character_turn(actor, services.time.duration(4, "hour").turns,
        "scenario_moonlit_deactivate_due")
end)

bind_scenario("friend_liam", "scenario_friend_liam_start", "scenario_friend_liam_due", function(payload)
    local actor = payload.character
    checked(services.characters.open_topic(actor, "TALK_Liam_Introdialogue"))
    local origin_omt = checked(services.creatures.snapshot(actor)).position:project_to("omt")
    local target_omt = services.overmap.find_target(origin_omt, "cabin_liam")
    run_mapgen_update_at(target_omt, "scenario_spawn_liam")
end)

-- WAVE16B_START
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

bind_scenario("lab_cargo_mutant", "w16b_scen_lab_cargo_mutant_start", "w16b_scen_lab_cargo_mutant_due", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("EOC_LAB_MUTANT_FRIENDS", ctx)
    E.H.run_eoc("EOC_LAB_MUTANT_NO_MUTAGENS", ctx)
    E.H.run_eoc("EOC_MUTE_BIRD_START", ctx)
    E.H.run_eoc("EOC_MUTE_CEPHALOPOD_START", ctx)
    E.H.run_eoc("EOC_MUTE_INSECT_START", ctx)
end)

bind_scenario("Mansion", "w16b_scen_mansion_start", "w16b_scen_mansion_due", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("scenario_paralyzepoison", ctx)
    E.H.run_eoc("scenario_mansion_pursuit", ctx)
end)

bind_scenario("close_encounter_start", "w16b_scen_close_encounter_start_start", "w16b_scen_close_encounter_start_due", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("scenario_surrounded_zombie", ctx)
    E.H.run_eoc("EOC_scenario_fire", ctx)
    E.H.run_eoc("EOC_scenario_smoke", ctx)
end)

bind_scenario("camp_attack_start", "w16b_scen_camp_attack_start_start", "w16b_scen_camp_attack_start_due", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("scenario_surrounded_zombie_heavy", ctx)
end)

bind_scenario("rock_hard_place_start", "w16b_scen_rock_hard_place_start_start", "w16b_scen_rock_hard_place_start_due", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("scenario_surrounded_zombie", ctx)
end)
-- WAVE16B_END
