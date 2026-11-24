local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

H.add_trait = function(actor, trait_id)
    if not actor then return end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return end
    services.mutations.replace(actor, gid)
end

H.char_age = function(actor)
    local s = H.char_snap(actor)
    if not s or not s.demographics then return 0 end
    return s.demographics.age or 0
end

H.char_dodge = function(actor)
    local s = H.char_snap(actor)
    if not s or not s.combat then return 0 end
    return s.combat.dodge or 0
end

H.char_has_item_cat = function(actor, cat_id, count)
    if not actor then return false end
    local gid = H.safe_id("item_category", cat_id)
    if not gid then return false end
    local r = services.inventory.category_count(actor, gid)
    return r.ok and (r.value or 0) >= count
end

H.char_has_items_sum = function(actor, spec)
    if not actor then return false end
    local entries = {}
    for _, e in ipairs(spec) do
        local gid = H.safe_id("item", e.item)
        if gid then
            table.insert(entries, { item = gid, amount = e.amount })
        end
    end
    if #entries == 0 then return false end
    local r = services.inventory.has_items_sum(actor, entries)
    return r.ok and r.value == true
end

H.char_has_wielded_cat = function(actor, cat_id)
    if not actor then return false end
    local gid = H.safe_id("weapon_category", cat_id)
    if not gid then return false end
    local r = services.inventory.wielded_matches(actor, gid)
    return r.ok and r.value == true
end

H.char_near_om_location = function(actor, loc_id, radius)
    local s = H.char_snap(actor)
    if not s or not s.creature then return false end
    return services.overmap.matches_location_near(s.creature.position:project_to("omt"), loc_id, radius)
end

H.consume_item_sum = function(u, npc, spec)
    local entries = {}
    for _, e in ipairs(spec) do
        local gid = H.safe_id("item", e.item)
        if gid then
            table.insert(entries, { item = gid, amount = e.amount })
        end
    end
    if #entries == 0 then return end
    services.inventory.consume_dialogue_sum(u, npc, "alpha", entries)
end

H.faction_trust = function(fac_id)
    local gid = H.safe_id("faction", fac_id)
    if not gid then return 0 end
    local r = services.factions.get(gid)
    if not r.ok or not r.value or not r.value.reputation then return 0 end
    return r.value.reputation.trusts or 0
end

H.global_var_num_opt = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return nil end
    return r.value.value
end

H.mapgen_update = function(actor, upd_id, om_terrain, origin_npc, dx, dy, reveal_radius)
    local origin_omt = nil
    if origin_npc then
        local ns = H.npc_snap(actor)
        if ns then origin_omt = ns.position:project_to("omt") end
    elseif actor then
        local s = H.char_snap(actor)
        if s and s.creature then origin_omt = s.creature.position:project_to("omt") end
    end
    if not origin_omt then return end
    if om_terrain and om_terrain ~= "" then
        origin_omt = services.overmap.find_target(origin_omt, om_terrain, { fallback_to_origin = false })
        if not origin_omt then return end
    end
    if dx ~= 0 or dy ~= 0 then
        origin_omt = origin_omt:add(services.coords.tripoint_rel_omt(dx, dy, 0))
    end
    local tok_r = services.overmap.tile_token(origin_omt)
    if not tok_r.ok or not tok_r.value then return end
    local ugid = H.safe_id("update_mapgen", upd_id)
    if ugid then
        local ur = services.mapgen.update_token(ugid)
        if ur.ok and ur.value then
            services.mapgen.run_update(tok_r.value, ur.value)
        end
    end
    if reveal_radius and reveal_radius > 0 then
        services.overmap.reveal_native(origin_omt, math.floor(reveal_radius))
    end
end

H.mapgen_update_list = function(actor, upd_ids, om_terrain, origin_npc, dx, dy, reveal_radius)
    local origin_omt = nil
    if origin_npc then
        local ns = H.npc_snap(actor)
        if ns then origin_omt = ns.position:project_to("omt") end
    elseif actor then
        local s = H.char_snap(actor)
        if s and s.creature then origin_omt = s.creature.position:project_to("omt") end
    end
    if not origin_omt then return end
    if om_terrain and om_terrain ~= "" then
        origin_omt = services.overmap.find_target(origin_omt, om_terrain, { fallback_to_origin = false })
        if not origin_omt then return end
    end
    if dx ~= 0 or dy ~= 0 then
        origin_omt = origin_omt:add(services.coords.tripoint_rel_omt(dx, dy, 0))
    end
    local tok_r = services.overmap.tile_token(origin_omt)
    if not tok_r.ok or not tok_r.value then return end
    for _, upd_id in ipairs(upd_ids) do
        local ugid = H.safe_id("update_mapgen", upd_id)
        if ugid then
            local ur = services.mapgen.update_token(ugid)
            if ur.ok and ur.value then
                services.mapgen.run_update(tok_r.value, ur.value)
            end
        end
    end
    if reveal_radius and reveal_radius > 0 then
        services.overmap.reveal_native(origin_omt, math.floor(reveal_radius))
    end
end

H.npc_has_class = function(npc, cls)
    local s = H.npc_snap(npc)
    if not s or not s.class then return false end
    return s.class.value == cls
end

H.npc_has_rule = function(npc, kind, rule)
    local s = H.npc_snap(npc)
    if not s or not s.ai_rules then return false end
    if kind == "aim" then return s.ai_rules.aim == rule end
    if kind == "engagement" then return s.ai_rules.engagement == rule end
    local allies = s.ai_rules.allies or {}
    for _, v in ipairs(allies) do
        if v == rule then return true end
    end
    return false
end

H.npc_has_visible_trait = function(observed, observer, trait_id)
    if not observed or not observer then return false end
    local gid = H.safe_id("mutation", trait_id)
    if not gid then return false end
    local r = services.mutations.is_visible_to(observed, observer, gid)
    return r.ok and r.value == true
end

H.npc_role_nearby = function(actor, role)
    if not actor then return false end
    local r = services.npcs.has_role_nearby(actor, role, 48)
    return r.ok and r.value == true
end

H.receive_group = function(actor, group_id, count)
    if not actor then return end
    local gid = H.safe_id("item_group", group_id)
    if not gid then return end
    local n = math.max(1, math.floor(count or 1))
    for _ = 1, n do
        services.inventory.receive_group(actor, gid)
    end
end

ccb.runtime.handler("dlg_p_dda_2019ca9934b5", function(ctx)
    return ((H.char_need(H.npc(ctx), "thirst") > (80)) or (H.char_need(H.npc(ctx), "hunger") > (160)) or (H.char_need(H.npc(ctx), "sleepiness") > (191)) or H.creature_has_effect(H.npc(ctx), "asked_to_hint", nil, nil) or (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true) or (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true))
end)

ccb.runtime.handler("dlg_p_dda_0a469b3f65f6", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "FACTION_CAMP_START")
end)

ccb.runtime.handler("dlg_p_dda_717555b46202", function(ctx)
    return (not (H.char_at_om_location(H.npc(ctx), "FACTION_CAMP_START")))
end)

ccb.runtime.handler("dlg_p_dda_c5904e1a60f2", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "FACTION_CAMP_ANY")
end)

ccb.runtime.handler("dlg_p_dda_c51cb610e41e", function(ctx)
    return (0 > 1)
end)

ccb.runtime.handler("dlg_p_dda_f27c7fa135d4", function(ctx)
    return (H.char_cash(H.u(ctx)) >= (500))
end)

ccb.runtime.handler("dlg_p_dda_87ccf0c55585", function(ctx)
    return ((not H.creature_has_effect(H.npc(ctx), "currently_busy")) and (H.char_cash(H.u(ctx)) >= (500)))
end)

ccb.runtime.handler("dlg_p_dda_7efddb1bb928", function(ctx)
    return H.char_at_om_location(H.u(ctx), "field")
end)

ccb.runtime.handler("dlg_p_dda_1dd60607d899", function(ctx)
    return H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY")
end)

ccb.runtime.handler("dlg_p_dda_984ab760e381", function(ctx)
    return H.char_at_om_location(H.u(ctx), "evac_center_7")
end)

ccb.runtime.handler("dlg_p_dda_7413844009f7", function(ctx)
    return H.npc_role_nearby(H.u(ctx), "TEST_ROLE")
end)

ccb.runtime.handler("dlg_p_dda_48323e72abf5", function(ctx)
    return H.npc_has_class(H.npc(ctx), "NC_TEST_CLASS")
end)

ccb.runtime.handler("dlg_p_dda_430389987a1c", function(ctx)
    return (services.npcs.count_allies(false) >= (1))
end)

ccb.runtime.handler("dlg_p_dda_c64ba9d1f4e7", function(ctx)
    return (services.npcs.count_allies(false) >= (2))
end)

ccb.runtime.handler("dlg_p_dda_e858505b4f4f", function(ctx)
    return H.npc_has_rule(H.npc(ctx), "engagement", "ENGAGE_ALL")
end)

ccb.runtime.handler("dlg_p_dda_3053cf449896", function(ctx)
    return H.npc_has_rule(H.npc(ctx), "aim", "AIM_SPRAY")
end)

ccb.runtime.handler("dlg_p_dda_7464481c8b48", function(ctx)
    return H.npc_has_rule(H.npc(ctx), "ally", "avoid_doors")
end)

ccb.runtime.handler("dlg_p_dda_116846416c99", function(ctx)
    return (H.char_need(H.npc(ctx), "thirst") > (75))
end)

ccb.runtime.handler("dlg_p_dda_b661ecaa4a50", function(ctx)
    return (H.char_need(H.npc(ctx), "hunger") > (75))
end)

ccb.runtime.handler("dlg_p_dda_db3bbd60cd2c", function(ctx)
    return (H.char_need(H.npc(ctx), "sleepiness") > (383))
end)

ccb.runtime.handler("dlg_p_dda_1236053a2f9b", function(ctx)
    return (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_ASSASSINATE").value == true)
end)

ccb.runtime.handler("dlg_p_dda_d7c0a82ef9e4", function(ctx)
    return (services.time_snapshot().season_id == string.lower("spring"))
end)

ccb.runtime.handler("dlg_p_dda_37c4c4e2de83", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 30)
end)

ccb.runtime.handler("dlg_p_dda_e13e38001d0d", function(ctx)
    return (services.time_snapshot().season_id == string.lower("summer"))
end)

ccb.runtime.handler("dlg_p_dda_1a1ea07b65c8", function(ctx)
    return (services.time.calendar().now.turns_since_cataclysm >= 10368000)
end)

ccb.runtime.handler("dlg_p_dda_c76eb4551f41", function(ctx)
    return (services.time_snapshot().season_id == string.lower("autumn"))
end)

ccb.runtime.handler("dlg_p_dda_0cab2db62407", function(ctx)
    return (services.time.calendar().now.turns_since_cataclysm >= 18144000)
end)

ccb.runtime.handler("dlg_p_dda_0b5c98d989be", function(ctx)
    return (services.time_snapshot().season_id == string.lower("winter"))
end)

ccb.runtime.handler("dlg_p_dda_8ed8637b0254", function(ctx)
    return (services.time.calendar().now.turns_since_cataclysm >= 25920000)
end)

ccb.runtime.handler("dlg_p_dda_62effbaca8e0", function(ctx)
    return (H.char_cash(H.u(ctx)) >= (50))
end)

ccb.runtime.handler("dlg_p_dda_46e65cabf8d0", function(ctx)
    return (H.char_cash(H.u(ctx)) >= (5))
end)

ccb.runtime.handler("dlg_p_dda_761103366401", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }) or (not H.creature_has_effect(H.npc(ctx), "currently_busy")) or (H.char_cash(H.u(ctx)) >= (500)))
end)

ccb.runtime.handler("dlg_p_dda_bab18533190c", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }) and (not H.creature_has_effect(H.npc(ctx), "currently_busy")) and (H.char_cash(H.u(ctx)) >= (500)))
end)

ccb.runtime.handler("dlg_p_dda_5748f934bde7", function(ctx)
    return ((not (((H.char_stat(H.u(ctx), "strength") >= (10)) or (H.char_stat(H.u(ctx), "dexterity") >= (10))))) and ((not ((not H.creature_has_effect(H.npc(ctx), "currently_busy")))) or (H.char_stat(H.u(ctx), "intelligence") >= (10))) and (H.char_cash(H.u(ctx)) >= (500)))
end)

ccb.runtime.handler("dlg_p_dda_c34f43472834", function(ctx)
    return H.char_has_item_cat(H.u(ctx), "manuals", (1))
end)

ccb.runtime.handler("dlg_p_dda_2097f4abd0ce", function(ctx)
    return H.char_has_item_cat(H.u(ctx), "manuals", (2))
end)

ccb.runtime.handler("dlg_p_dda_acda17fe95ce", function(ctx)
    return H.char_has_item_cat(H.u(ctx), "manuals", (3))
end)

ccb.runtime.handler("dlg_p_dda_5a2e2bb9902f", function(ctx)
    return H.char_has_wielded_cat(H.u(ctx), "LONG_SWORDS")
end)

ccb.runtime.handler("dlg_p_dda_79acc4f3a7ea", function(ctx)
    return H.char_has_wielded_cat(H.u(ctx), "KNIVES")
end)

ccb.runtime.handler("dlg_p_dda_39c984351a3f", function(ctx)
    return (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "test_var_time_test_test") and 1 or 0)))
end)

ccb.runtime.handler("dlg_p_dda_2cf14bc9b169", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "test_var_time_test_test"), 1) > 259200)
end)

ccb.runtime.handler("dlg_p_dda_47d2b82345f3", function(ctx)
    return H.char_has_bionic(H.u(ctx), "bio_ads")
end)

ccb.runtime.handler("dlg_p_dda_02144db8685d", function(ctx)
    return H.char_has_bionic(H.npc(ctx), "bio_ads")
end)

ccb.runtime.handler("dlg_p_dda_40cd89da0fd5", function(ctx)
    return H.char_has_bionic(H.npc(ctx), "ANY")
end)

ccb.runtime.handler("dlg_p_dda_6b4f20e24d78", function(ctx)
    return (H.char_cash(H.u(ctx)) >= (750))
end)

ccb.runtime.handler("dlg_p_dda_da708d01c100", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (750))
end)

ccb.runtime.handler("dlg_p_dda_4d28545eb132", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (1500))
end)

ccb.runtime.handler("dlg_p_dda_6403ff9d30c2", function(ctx)
    return (H.char_skill(H.u(ctx), "driving") >= 7)
end)

ccb.runtime.handler("dlg_p_dda_d0df4f6aff30", function(ctx)
    return (H.char_skill(H.u(ctx), "driving") < 7)
end)

ccb.runtime.handler("dlg_p_dda_ce4c1dc2145d", function(ctx)
    return (2 == 5)
end)

ccb.runtime.handler("dlg_p_dda_bb158f4d9754", function(ctx)
    return (2 ~= 5)
end)

ccb.runtime.handler("dlg_p_dda_c1731e2fa3b9", function(ctx)
    return (2 <= 5)
end)

ccb.runtime.handler("dlg_p_dda_24a5044163c9", function(ctx)
    return (2 >= 5)
end)

ccb.runtime.handler("dlg_p_dda_f4b958fc8ef3", function(ctx)
    return (2 < 5)
end)

ccb.runtime.handler("dlg_p_dda_6288704ce042", function(ctx)
    return (2 > 5)
end)

ccb.runtime.handler("dlg_p_dda_22605a00be9f", function(ctx)
    return (5 == 5)
end)

ccb.runtime.handler("dlg_p_dda_77c226e13c5a", function(ctx)
    return (5 ~= 5)
end)

ccb.runtime.handler("dlg_p_dda_37248ea12a17", function(ctx)
    return (5 <= 5)
end)

ccb.runtime.handler("dlg_p_dda_5399cdd1bdb2", function(ctx)
    return (5 >= 5)
end)

ccb.runtime.handler("dlg_p_dda_fb3111db504f", function(ctx)
    return (5 < 5)
end)

ccb.runtime.handler("dlg_p_dda_041ace24eff5", function(ctx)
    return (5 > 5)
end)

ccb.runtime.handler("dlg_p_dda_2ad236a7138a", function(ctx)
    return (5 == 2)
end)

ccb.runtime.handler("dlg_p_dda_e36c8ed15a11", function(ctx)
    return (5 ~= 2)
end)

ccb.runtime.handler("dlg_p_dda_ac70001677cd", function(ctx)
    return (5 <= 2)
end)

ccb.runtime.handler("dlg_p_dda_c8d1256a1445", function(ctx)
    return (5 >= 2)
end)

ccb.runtime.handler("dlg_p_dda_e83c8a5dc991", function(ctx)
    return (5 < 2)
end)

ccb.runtime.handler("dlg_p_dda_f1643b5e2873", function(ctx)
    return (5 > 2)
end)

ccb.runtime.handler("dlg_p_dda_570f78b53fd8", function(ctx)
    return (1 > 0)
end)

ccb.runtime.handler("dlg_p_dda_92305705c4d3", function(ctx)
    return (services.random.native_int(0, H.round_half_away(10)) > 5)
end)

ccb.runtime.handler("dlg_p_dda_726627078ec1", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) < 90)
end)

ccb.runtime.handler("dlg_p_dda_3b14879c9833", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 90)
end)

ccb.runtime.handler("dlg_p_dda_baba7b359c8f", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 14)
end)

ccb.runtime.handler("dlg_p_dda_6e953b181395", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 21)
end)

ccb.runtime.handler("dlg_p_dda_e48f5767fe4f", function(ctx)
    return (H.char_cash(H.u(ctx)) >= (100000))
end)

ccb.runtime.handler("dlg_p_dda_bfd92f9f6491", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (H.char_has_trait(H.npc(ctx), "BOSS_Brigitte_LaCroix_01") == 1) and (not (((("Brigitte_LaCroix") == (H.var_str("actor", H.u(ctx), ctx, "BOSS_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_ff5d62955c4b", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (H.char_has_trait(H.npc(ctx), "BOSS_Lapin_01") == 1) and (not (((("lapin") == (H.var_str("actor", H.u(ctx), ctx, "BOSS_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_ee75ba89fa07", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (H.char_has_trait(H.npc(ctx), "BOSS_NC_FARMER_01") == 1) and (not (((("farmer") == (H.var_str("actor", H.u(ctx), ctx, "BOSS_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_0af60ccedec1", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (H.char_has_trait(H.npc(ctx), "BOSS_NC_SURVIVOR_CHEF_01") == 1) and (not (((("chef") == (H.var_str("actor", H.u(ctx), ctx, "BOSS_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_24352433e095", function(ctx)
    return ((H.char_need(H.npc(ctx), "thirst") > (80)) or (H.char_need(H.npc(ctx), "hunger") > (160)) or (H.char_need(H.npc(ctx), "sleepiness") > (191)) or H.creature_has_effect(H.npc(ctx), "asked_to_train", nil, nil) or (H.char_has_trait(H.npc(ctx), "HALLUCINATION") == 1) or (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true) or (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true))
end)

ccb.runtime.handler("dlg_p_dda_6df687e81cfd", function(ctx)
    return ((H.char_need(H.npc(ctx), "thirst") > (80)) or (H.char_need(H.npc(ctx), "hunger") > (160)) or (H.char_need(H.npc(ctx), "sleepiness") > (191)) or H.creature_has_effect(H.npc(ctx), "asked_to_train", nil, nil) or (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true) or (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true))
end)

ccb.runtime.handler("dlg_p_dda_6347d53c499b", function(ctx)
    return ((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))) and (not ((((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true))) and (not (ctx:by_radio())) and (not (H.creature_has_effect(H.u(ctx), "asked_to_train", nil, nil))) and (not ((H.char_has_trait(H.npc(ctx), "HALLUCINATION") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_e15f2a008540", function(ctx)
    return ((not ((((H.char_snap(H.npc(ctx)) or {}).movement or {}).mounted == true))) and (not ((H.char_has_trait(H.npc(ctx), "HALLUCINATION") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_dc5e444f6fd5", function(ctx)
    return (((H.char_snap(H.npc(ctx)) or {}).movement or {}).mounted == true)
end)

ccb.runtime.handler("dlg_p_dda_5d493fb3087d", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and (not (ctx:by_radio())))
end)

ccb.runtime.handler("dlg_p_dda_f7417ddd0af4", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "lighthouse_ground")
end)

ccb.runtime.handler("dlg_p_dda_372a8aa8260c", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "time_survivors_wait"), 1) >= 1209600)
end)

ccb.runtime.handler("dlg_p_dda_fec335eb9be6", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 0) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_ground"))
end)

ccb.runtime.handler("dlg_p_dda_68b8f4637593", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 1) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_z1"))
end)

ccb.runtime.handler("dlg_p_dda_29d23b48e708", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 2) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_z2"))
end)

ccb.runtime.handler("dlg_p_dda_98ac3e0825da", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 3) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_z3"))
end)

ccb.runtime.handler("dlg_p_dda_da9c2bf37a4d", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 4) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_z4"))
end)

ccb.runtime.handler("dlg_p_dda_b06a4ea01e6e", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 5) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_z5"))
end)

ccb.runtime.handler("dlg_p_dda_2a9fd24c7bad", function(ctx)
    return ((H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man") == 6) and (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and H.char_at_om_location(H.npc(ctx), "lighthouse_ground"))
end)

ccb.runtime.handler("dlg_p_dda_f0bf0c5e00c6", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "lighthouse_z4")
end)

ccb.runtime.handler("dlg_p_dda_efaaa03c052f", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "time_lighthouse_wait"), 1) > 172800)
end)

ccb.runtime.handler("dlg_p_dda_cbf4b887e941", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "time_lighthouse_wait"), 1) > 172800) and (not (H.char_has_any_trait(H.npc(ctx), { "Exp_Eng_Electrical1Fake2", "Exp_Eng_Electrical0Fake2" }))))
end)

ccb.runtime.handler("dlg_p_dda_692f1fbb5052", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "time_lighthouse_wait"), 1) > 172800) and ((not (H.char_has_mission(H.u(ctx), "MISSION_lighthouse_man_5"))) or H.char_has_any_trait(H.npc(ctx), { "Exp_Eng_Electrical1Fake2", "Exp_Eng_Electrical0Fake2" })))
end)

ccb.runtime.handler("dlg_p_dda_d928477b785d", function(ctx)
    return (H.global_var_num("balthazar_power") < 50)
end)

ccb.runtime.handler("dlg_p_dda_f72fc90979eb", function(ctx)
    return (H.char_has_items_sum(H.u(ctx), { { item = "ground_solar_panel", amount = 12 } }) and (H.var_num(H.u(ctx), "negotiated_balthazar_solar") < 1))
end)

ccb.runtime.handler("dlg_p_dda_d930ca90f1e9", function(ctx)
    return (H.char_has_items_sum(H.u(ctx), { { item = "ground_solar_panel", amount = 12 } }) and (H.var_num(H.u(ctx), "negotiated_balthazar_solar") <= 1))
end)

ccb.runtime.handler("dlg_p_dda_e34b358e0efc", function(ctx)
    return (H.char_has_items_sum(H.u(ctx), { { item = "ground_solar_panel", amount = 12 } }) and (H.var_num(H.u(ctx), "negotiated_balthazar_solar") == 3))
end)

ccb.runtime.handler("dlg_p_dda_afc82d95f444", function(ctx)
    return (H.var_num(H.u(ctx), "knowns_control_center_balthazar") == 1)
end)

ccb.runtime.handler("dlg_p_dda_a29af93c992a", function(ctx)
    return (H.var_num(H.u(ctx), "negotiated_balthazar_solar") == 2)
end)

ccb.runtime.handler("dlg_p_dda_2c514690302b", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "trust") >= 2) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_first_meeting_knows_u", "")))))
end)

ccb.runtime.handler("dlg_p_dda_92e5a7678228", function(ctx)
    return ((H.npc_snap(H.npc(ctx)) or {}).has_assigned_camp == true)
end)

ccb.runtime.handler("dlg_p_dda_88e0075084ad", function(ctx)
    return ((((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true) and (H.char_has_flag(H.npc(ctx), "BG_SURVIVAL_STORY") or H.char_has_flag(H.npc(ctx), "BG_OTHER_SURVIVORS_STORY") or (H.char_has_trait(H.npc(ctx), "NPC_STATIC_NPC") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_9860d3f75191", function(ctx)
    return (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true)
end)

ccb.runtime.handler("dlg_p_dda_b241b3fc7b62", function(ctx)
    return (not ((((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true)))
end)

ccb.runtime.handler("dlg_p_dda_2379dbeda833", function(ctx)
    return (((H.char_snap(H.npc(ctx)) or {}).travel or {}).has_path == true)
end)

ccb.runtime.handler("dlg_p_dda_d03e6b7290e6", function(ctx)
    return (H.char_need(H.npc(ctx), "sleepiness") > (575))
end)

ccb.runtime.handler("dlg_p_dda_ea60ec832f23", function(ctx)
    return (H.char_need(H.npc(ctx), "sleepiness") > (191))
end)

ccb.runtime.handler("dlg_p_dda_41e985c27ed5", function(ctx)
    return ((services.inventory.weapon_state(H.u(ctx)).value or {}).armed == true and (services.inventory.weapon_state(H.u(ctx)).value or {}).can_stow == true)
end)

ccb.runtime.handler("dlg_p_dda_3985a08230de", function(ctx)
    return ((services.inventory.weapon_state(H.u(ctx)).value or {}).armed == true and (services.inventory.weapon_state(H.u(ctx)).value or {}).can_drop == true)
end)

ccb.runtime.handler("dlg_p_dda_b5438c3b18da", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "incomplete").value == true) and ((services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_ASSASSINATE").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER_SPEC").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER_TYPE").value == true)))
end)

ccb.runtime.handler("dlg_p_dda_9df400458154", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and ((services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_ITEM").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_ANY_ITEM").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_ITEM_GROUP").value == true)))
end)

ccb.runtime.handler("dlg_p_dda_6b028eae1cf6", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_GO_TO_TYPE").value == true))
end)

ccb.runtime.handler("dlg_p_dda_735c3ce07a5e", function(ctx)
    return (((services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_GO_TO").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_NPC").value == true)) and (services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true))
end)

ccb.runtime.handler("dlg_p_dda_aaeabe75dc28", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_TALK_TO_NPC").value == true))
end)

ccb.runtime.handler("dlg_p_dda_da2dac1c4495", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_MONSTER").value == true))
end)

ccb.runtime.handler("dlg_p_dda_d7d86c55d371", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_ASSASSINATE").value == true))
end)

ccb.runtime.handler("dlg_p_dda_61b3cdccfe99", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER").value == true))
end)

ccb.runtime.handler("dlg_p_dda_1d08495c348b", function(ctx)
    return (((services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER_SPEC").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_KILL_MONSTER_TYPE").value == true)) and (services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true))
end)

ccb.runtime.handler("dlg_p_dda_5c7f7def7d93", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_RECRUIT_NPC").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_RECRUIT_NPC_CLASS").value == true))
end)

ccb.runtime.handler("dlg_p_dda_e1ce49b951c6", function(ctx)
    return ((services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true) and (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_COMPUTER_TOGGLE").value == true))
end)

ccb.runtime.handler("dlg_p_dda_198cb07b916b", function(ctx)
    return (((services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_ITEM").value == true) or (services.npcs.missions.selected_has_goal(H.npc(ctx), "MGOAL_FIND_ANY_ITEM").value == true)) and (services.npcs.missions.selected_condition(H.npc(ctx), H.u(ctx), "complete").value == true))
end)

ccb.runtime.handler("dlg_p_dda_8baf563d07a6", function(ctx)
    return (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true)
end)

ccb.runtime.handler("dlg_p_dda_11f4fe0cf4dc", function(ctx)
    return (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true)
end)

ccb.runtime.handler("dlg_p_dda_7d19faa96245", function(ctx)
    return (H.char_need(H.npc(ctx), "thirst") > (80))
end)

ccb.runtime.handler("dlg_p_dda_43c2f4328d3c", function(ctx)
    return (H.char_need(H.npc(ctx), "hunger") > (160))
end)

ccb.runtime.handler("dlg_p_dda_378775caa047", function(ctx)
    return false
end)

ccb.runtime.handler("dlg_p_dda_9dc70a1dd705", function(ctx)
    return (services.inventory.has_stolen_from(H.u(ctx), H.npc(ctx)).value == true)
end)

ccb.runtime.handler("dlg_p_dda_d89fcfbd2941", function(ctx)
    return (not ((services.inventory.has_stolen_from(H.u(ctx), H.npc(ctx)).value == true)))
end)

ccb.runtime.handler("dlg_p_dda_4af84673eeb8", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 100)
end)

ccb.runtime.handler("dlg_p_dda_42ddc9da4019", function(ctx)
    return (H.global_var_num("find_refugee_center") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_93430a4f1409", function(ctx)
    return (H.global_var_num("find_refugee_center") == 1)
end)

ccb.runtime.handler("dlg_p_dda_e9d71f52da0b", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_STARTINGNPC_LIAM")
end)

ccb.runtime.handler("dlg_p_dda_bac2d697a2af", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_SCAVENGER_MERC")
end)

ccb.runtime.handler("dlg_p_dda_f796115021ee", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_BEGGAR_5")
end)

ccb.runtime.handler("dlg_p_dda_6a9f959762b2", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_ISHERWOOD_CHRIS")
end)

ccb.runtime.handler("dlg_p_dda_9ceba3cb700d", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_name_u_luliya_name", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_meeting_luliya_music_timer"), 1) >= 259200))
end)

ccb.runtime.handler("dlg_p_dda_bb99692097c5", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 28)
end)

ccb.runtime.handler("dlg_p_dda_1a47555b13ec", function(ctx)
    return (H.global_var_num("talked_to_hub") == 1)
end)

ccb.runtime.handler("dlg_p_dda_0f3fab873de7", function(ctx)
    return (H.global_var_num("exodii_knows_hub01") == 1)
end)

ccb.runtime.handler("dlg_p_dda_af0d147a6715", function(ctx)
    return ((H.global_var_num("hub01_stole_warehouse") ~= 1) and (H.global_var_num("hub01_bought_exodii_warehouse") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_3118207dac64", function(ctx)
    return (H.global_var_num("hub01_stole_warehouse") == 1)
end)

ccb.runtime.handler("dlg_p_dda_e180e3e44181", function(ctx)
    return (H.global_var_num("hub01_bought_exodii_warehouse") == 1)
end)

ccb.runtime.handler("dlg_p_dda_8b9c6170c186", function(ctx)
    return (H.var_num(H.u(ctx), "rebooted_locator") == 1)
end)

ccb.runtime.handler("dlg_p_dda_249de356eba3", function(ctx)
    return (H.var_num(H.u(ctx), "rebooted_locator") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_f1aec37706ce", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (H.faction_trust("exodii") < 20))
end)

ccb.runtime.handler("dlg_p_dda_3f9b38cb4654", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (H.faction_trust("exodii") >= 20))
end)

ccb.runtime.handler("dlg_p_dda_28a006214a5d", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (H.global_var_num("exodii_knows_u_double_crossed") == 1))
end)

ccb.runtime.handler("dlg_p_dda_29c3b08650ee", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))) and (H.global_var_num("exodii_knows_u_double_crossed") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_44a013be011b", function(ctx)
    return (H.char_skill(H.u(ctx), "social") < 3)
end)

ccb.runtime.handler("dlg_p_dda_2279cdadb63f", function(ctx)
    return ((H.char_skill(H.u(ctx), "social") > 2) and (H.char_skill(H.u(ctx), "social") < 5))
end)

ccb.runtime.handler("dlg_p_dda_aef2ed885b5d", function(ctx)
    return ((H.char_skill(H.u(ctx), "social") > 4) and (H.char_skill(H.u(ctx), "social") < 7))
end)

ccb.runtime.handler("dlg_p_dda_2e007446fed9", function(ctx)
    return ((H.char_skill(H.u(ctx), "social") > 6) and (H.char_skill(H.u(ctx), "social") < 9))
end)

ccb.runtime.handler("dlg_p_dda_4863760f1f04", function(ctx)
    return (H.char_skill(H.u(ctx), "social") > 8)
end)

ccb.runtime.handler("dlg_p_dda_da66e2d84e95", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "sold") >= 20) and (not ((H.npc_faction_trust(H.npc(ctx)) >= (21)))))
end)

ccb.runtime.handler("dlg_p_dda_103fd2568028", function(ctx)
    return ((not ((H.global_var_num("exodii_FM_annoyed") >= 3))) and (H.global_var_num("exodii_FM_negotiation_success") == 1) and H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS"))
end)

ccb.runtime.handler("dlg_p_dda_5246ac7028f5", function(ctx)
    return ((H.global_var_num("exodii_FM_annoyed") >= 3) and (H.global_var_num("exodii_FM_negotiation_success") == 1) and H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS"))
end)

ccb.runtime.handler("dlg_p_dda_9ea6d88123e8", function(ctx)
    return ((H.global_var_num("exodii_FM_negotiation_failed") == 1) and H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS"))
end)

ccb.runtime.handler("dlg_p_dda_a88b1d9a27dc", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (30000))
end)

ccb.runtime.handler("dlg_p_dda_e1b6dba94f89", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (20000))
end)

ccb.runtime.handler("dlg_p_dda_bf2e523c29cd", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (9500))
end)

ccb.runtime.handler("dlg_p_dda_3e621d135700", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "owed") >= (2500))
end)

ccb.runtime.handler("dlg_p_dda_d292f701cba7", function(ctx)
    return services.gameplay.mods.is_loaded("catalegacy_future")
end)

ccb.runtime.handler("dlg_p_dda_814187ad8ba4", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "EXODII_MISSION_CONTACT_HUB"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_scouted_bunker", "")))))) and (H.global_var_num("exodii_knows_hub01") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_589f4090ddc0", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "EXODII_MISSION_WAREHOUSE"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_found_warehouse", "")))))) and (H.global_var_num("warehouse_was_found") ~= 1) and (H.global_var_num("exodii_knows_hub01") == 1))
end)

ccb.runtime.handler("dlg_p_dda_ba181616e62b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "EXODII_MISSION_CHOP_SHOP"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_exodii_mission_chop_shop", "")))))) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (H.global_var_num("warehouse_was_found") == 1) and (H.global_var_num("exodii_knows_hub01") == 1))
end)

ccb.runtime.handler("dlg_p_dda_2e2b48a542d0", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_exodii_mission_meet_free_merchants", "")))))) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (H.global_var_num("warehouse_was_found") == 1) and (H.global_var_num("exodii_knows_u_double_crossed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 14) and (H.global_var_num("FM_exodii_caravan_placed") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_8d831997809d", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "sold") >= 100)
end)

ccb.runtime.handler("dlg_p_dda_ef264459b360", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (5))
end)

ccb.runtime.handler("dlg_p_dda_973b457b3cfa", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "sold") >= 100) or (H.npc_faction_trust(H.npc(ctx)) >= (5)))
end)

ccb.runtime.handler("dlg_p_dda_f0e3a14b36fb", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "sold") < 100) and (not ((H.npc_faction_trust(H.npc(ctx)) >= (5)))))
end)

ccb.runtime.handler("dlg_p_dda_63b529d40afa", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "decisions_blobpsychosis_u_declined_exodization", "")))))) or (H.time_since(H.var_num_opt(H.u(ctx), "timer_blobpsychosis_u_declined_exodization"), 1) >= 172800))
end)

ccb.runtime.handler("dlg_p_dda_a3af36b24f10", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "decisions_blobpsychosis_u_declined_exodization", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_blobpsychosis_u_declined_exodization"), 1) < 172800))
end)

ccb.runtime.handler("dlg_p_dda_f1f6c2ddcc67", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_exodii_wrist_computer", "")))))) and (H.global_var_num("labyrinth_access_points") > 0) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and ((not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown") and 1 or 0)))) or (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_labyrinth_cooldown"), 1) >= 432000)))
end)

ccb.runtime.handler("dlg_p_dda_e783bd9bfc06", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_exodii_wrist_computer", "")))) and (H.char_has_item(H.u(ctx), "exodii_wrist_computer") or H.char_has_item(H.u(ctx), "exodii_wrist_computer_on")) and (H.global_var_num("labyrinth_access_points") > 0) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and ((not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown") and 1 or 0)))) or (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_labyrinth_cooldown"), 1) >= 432000)))
end)

ccb.runtime.handler("dlg_p_dda_fb8cfccc393d", function(ctx)
    return (((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_exodii_wrist_computer", "")))))) or ((not (H.char_has_item(H.u(ctx), "exodii_wrist_computer"))) and (not (H.char_has_item(H.u(ctx), "exodii_wrist_computer_on"))))) and (H.global_var_num("labyrinth_access_points") == 0) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and ((not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown") and 1 or 0)))) or (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_labyrinth_cooldown"), 1) >= 432000)))
end)

ccb.runtime.handler("dlg_p_dda_7ea5db69a1b4", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_exodii_wrist_computer", "")))) and (H.char_has_item(H.u(ctx), "exodii_wrist_computer") or H.char_has_item(H.u(ctx), "exodii_wrist_computer_on")) and (H.global_var_num("labyrinth_access_points") == 0) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and ((not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown") and 1 or 0)))) or (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_labyrinth_cooldown"), 1) >= 432000)))
end)

ccb.runtime.handler("dlg_p_dda_a0f94d6967b0", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "rubik_told_about_labyrinth", "")))) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_exodii_labyrinth_cooldown") and 1 or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_exodii_labyrinth_cooldown"), 1) < 432000))
end)

ccb.runtime.handler("dlg_p_dda_71a22aa1f1e5", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_door_requests") < 1)
end)

ccb.runtime.handler("dlg_p_dda_030d3a2a8399", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_door_requests") == 1)
end)

ccb.runtime.handler("dlg_p_dda_2cae08f533b6", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_door_requests") == 2)
end)

ccb.runtime.handler("dlg_p_dda_01a3d73e8fc7", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_door_requests") == 3)
end)

ccb.runtime.handler("dlg_p_dda_d7ff7f872ba8", function(ctx)
    return ((H.var_num(H.npc(ctx), "LS_bridge_requests") < 1) and (H.char_has_trait(H.u(ctx), "LS_Passcode_0") == 1))
end)

ccb.runtime.handler("dlg_p_dda_5297030f1842", function(ctx)
    return ((H.var_num(H.npc(ctx), "LS_bridge_requests") < 1) and (H.char_has_trait(H.u(ctx), "LS_Passcode_1") == 1))
end)

ccb.runtime.handler("dlg_p_dda_b1655aa596fc", function(ctx)
    return ((H.var_num(H.npc(ctx), "LS_bridge_requests") < 1) and (H.char_has_trait(H.u(ctx), "LS_Passcode_2") == 1))
end)

ccb.runtime.handler("dlg_p_dda_509946616d1f", function(ctx)
    return ((H.var_num(H.npc(ctx), "LS_bridge_requests") < 1) and (H.char_has_trait(H.u(ctx), "LS_Passcode_3") == 1))
end)

ccb.runtime.handler("dlg_p_dda_c0a8dade4e0d", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_bridge_requests") < 1)
end)

ccb.runtime.handler("dlg_p_dda_7feef9b48ebf", function(ctx)
    return (H.var_num(H.npc(ctx), "LS_bridge_requests") > 1)
end)

ccb.runtime.handler("dlg_p_dda_7bda4c3336de", function(ctx)
    return ((H.char_skill(H.u(ctx), "computer") > 2) and (H.var_num(H.npc(ctx), "LS_bridge_requests") == 2))
end)

ccb.runtime.handler("dlg_p_dda_0149c21f0837", function(ctx)
    return (H.global_var_num("nl_boiler_placed") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_3ab4e518ac76", function(ctx)
    return ((H.global_var_num("nl_autodoc_obelisk_placed") ~= 1) and (H.global_var_num("nl_boiler_placed") == 1))
end)

ccb.runtime.handler("dlg_p_dda_b7bda76e75e3", function(ctx)
    return ((H.global_var_num("nl_utility_space_obelisk_placed") ~= 1) and (H.global_var_num("nl_boiler_placed") == 1))
end)

ccb.runtime.handler("dlg_p_dda_75e73dcead33", function(ctx)
    return ((H.global_var_num("nl_water_cooler_placed") ~= 1) and (H.global_var_num("nl_boiler_placed") == 1))
end)

ccb.runtime.handler("dlg_p_dda_ded7872af108", function(ctx)
    return ((H.global_var_num("nl_living_space_1_obelisk_placed") ~= 1) and (H.global_var_num("nl_boiler_placed") == 1) and (H.global_var_num("nl_water_cooler_placed") == 1))
end)

ccb.runtime.handler("dlg_p_dda_3ecc492a505d", function(ctx)
    return (not ((H.global_var_num("string_dimension_flipped_switched") >= 1)))
end)

ccb.runtime.handler("dlg_p_dda_a9d7b442011c", function(ctx)
    return (H.global_var_num("string_dimension_flipped_switched") == 1)
end)

ccb.runtime.handler("dlg_p_dda_2d0e96f50ccd", function(ctx)
    return (H.global_var_num("string_dimension_flipped_switched") == 2)
end)

ccb.runtime.handler("dlg_p_dda_8057a2507437", function(ctx)
    return (H.global_var_num("string_dimension_flipped_switched") == 3)
end)

ccb.runtime.handler("dlg_p_dda_f98058ef3692", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "value") >= 3)
end)

ccb.runtime.handler("dlg_p_dda_8a1122999849", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "value") >= 2)
end)

ccb.runtime.handler("dlg_p_dda_3ae720d7aecb", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "anger") >= 5)
end)

ccb.runtime.handler("dlg_p_dda_8ca9b00d29dd", function(ctx)
    return (services.random.native_probability((1), (4)) and (not (H.creature_has_effect(H.npc(ctx), "Arturo_visions_timer", nil, nil))))
end)

ccb.runtime.handler("dlg_p_dda_637b4ce53f79", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_arturo", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_5e2ab24f1845", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_arturo", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_56f3a4b9bb1e", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_scarf", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_9dec920460e6", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_blanket", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 172800))
end)

ccb.runtime.handler("dlg_p_dda_5f469fab0828", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_quilt", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 604800))
end)

ccb.runtime.handler("dlg_p_dda_d637ce500b4a", function(ctx)
    return (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60) and (H.npc_opinion(H.npc(ctx), "value") >= 3))
end)

ccb.runtime.handler("dlg_p_dda_651c5ad5121f", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_theresa", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_470036d03c11", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_theresa", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_b39f59d33e4f", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_af294cdc5175", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))
end)

ccb.runtime.handler("dlg_p_dda_8213427bad25", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_chloe", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_948fd1983114", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_chloe", "")))))
end)

ccb.runtime.handler("dlg_p_dda_65e116ddf480", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_chloe", "")))))
end)

ccb.runtime.handler("dlg_p_dda_bcd6b4e1bd5b", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "told_backstory_second_attempt", "")))) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_told_backstory", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_737f2e47701d", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_told_about_sonia", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_386abab4facf", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_told_about_sonia", "")))))
end)

ccb.runtime.handler("dlg_p_dda_06a93d0b5574", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_corrie", "")))))
end)

ccb.runtime.handler("dlg_p_dda_7dcd2efc660f", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_corrie", "")))))
end)

ccb.runtime.handler("dlg_p_dda_46b33dcc78ef", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("in-progress") == (H.var_str("actor", H.npc(ctx), ctx, "mission_completed_godco_darryl_mission1", "")))))
end)

ccb.runtime.handler("dlg_p_dda_66dc1578f526", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_darryl", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_146b37bb9c95", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_darryl", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_d20fc79f5ca2", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and (H.global_var_num("darryl_building_coop") == 2) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_darryl", "")))))
end)

ccb.runtime.handler("dlg_p_dda_5ebd062782a3", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) or ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))
end)

ccb.runtime.handler("dlg_p_dda_085a734e2c49", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "anger") >= 8)
end)

ccb.runtime.handler("dlg_p_dda_5646b391242e", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 8) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))
end)

ccb.runtime.handler("dlg_p_dda_9632f2278fb1", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 8) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_greenwood", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_f99453b5c14d", function(ctx)
    return (H.global_var_num("godco_julian_wedding") == 0)
end)

ccb.runtime.handler("dlg_p_dda_e994ba98f6c9", function(ctx)
    return (H.global_var_num("godco_julian_wedding") == 1)
end)

ccb.runtime.handler("dlg_p_dda_1ef53835301b", function(ctx)
    return (H.global_var_num("godco_julian_wedding") == 2)
end)

ccb.runtime.handler("dlg_p_dda_4b170013d58b", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_writing_manuscript"), 1) < 2592000)
end)

ccb.runtime.handler("dlg_p_dda_d71ced0bb43b", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_writing_manuscript"), 1) >= 2592000) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_gave_u_manuscript", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_f9d159e20386", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_felicity", "")))))
end)

ccb.runtime.handler("dlg_p_dda_3b46a78bb7af", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_felicity", "")))))
end)

ccb.runtime.handler("dlg_p_dda_b0d2ab06f9d5", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_gemma", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_godco_joinee", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_812ec78644bd", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_gemma", "")))))
end)

ccb.runtime.handler("dlg_p_dda_b25b2ee6efa9", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_gemma", "")))))
end)

ccb.runtime.handler("dlg_p_dda_e12a216748aa", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_helena", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_godco_joinee", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_e67b4a947328", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_helena", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_3b94acd27179", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))) and (H.npc_opinion(H.npc(ctx), "anger") >= 5))
end)

ccb.runtime.handler("dlg_p_dda_449f69e62f09", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))) and (H.npc_opinion(H.npc(ctx), "anger") < 5))
end)

ccb.runtime.handler("dlg_p_dda_40d168d78a5b", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))) or (H.npc_opinion(H.npc(ctx), "anger") >= 5))
end)

ccb.runtime.handler("dlg_p_dda_07592b4ecdd4", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_jane", "")))))
end)

ccb.runtime.handler("dlg_p_dda_4f8893d03f0a", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_jane", "")))))
end)

ccb.runtime.handler("dlg_p_dda_6a5418e02494", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_godco_jeremiah", "")))))
end)

ccb.runtime.handler("dlg_p_dda_6c9f3c8e5e82", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_godco_jeremiah", "")))))
end)

ccb.runtime.handler("dlg_p_dda_17ef1b259c2c", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "anger") < 5)
end)

ccb.runtime.handler("dlg_p_dda_4a3f3f2c8c2b", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_julian", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_godco_joinee", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_ed54f56716f3", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_julian", "")))))
end)

ccb.runtime.handler("dlg_p_dda_84616cfc7457", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_julian", "")))))
end)

ccb.runtime.handler("dlg_p_dda_de17284a0857", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_katherine", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_a5ec6d0947e2", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_8b79c1f17396", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_kostas", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_5fe76c7704cf", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_kostas", "")))) and H.creature_has_effect(H.npc(ctx), "godco_kostas_trade", nil, nil))
end)

ccb.runtime.handler("dlg_p_dda_447ecf8e75e4", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_kostas", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_ca7e572fd51b", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_kostas", "")))) and H.creature_has_effect(H.npc(ctx), "godco_kostas_trade", nil, nil))
end)

ccb.runtime.handler("dlg_p_dda_59256ea374c7", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_tshirt", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_170ed5de53b8", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_pants", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_4b4f81870ac1", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_jacket", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_6458309178f7", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_dress", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_f12224d21e87", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_duster", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 345600))
end)

ccb.runtime.handler("dlg_p_dda_9a97176136e0", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_trenchcoat", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 345600))
end)

ccb.runtime.handler("dlg_p_dda_0137e622fe39", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_backpack", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 345600))
end)

ccb.runtime.handler("dlg_p_dda_83af47bef271", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_gambeson", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 518400))
end)

ccb.runtime.handler("dlg_p_dda_64d6b0dd5a5b", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_pouches", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 172800))
end)

ccb.runtime.handler("dlg_p_dda_4a28600a12c5", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_leather_pants", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 172800))
end)

ccb.runtime.handler("dlg_p_dda_33d2373df3aa", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_cloak", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 345600))
end)

ccb.runtime.handler("dlg_p_dda_007f7691adf8", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_jacket_thick", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 345600))
end)

ccb.runtime.handler("dlg_p_dda_44eb7ec73bee", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_want_body_armor", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_trade_knitting"), 1) >= 518400))
end)

ccb.runtime.handler("dlg_p_dda_71af41b625da", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_maria", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_7d65e3e31354", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_maria", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_8c6148cf7b57", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_olwen", "")))))
end)

ccb.runtime.handler("dlg_p_dda_1811b3ed1781", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_olwen", "")))))
end)

ccb.runtime.handler("dlg_p_dda_1edc8717c0eb", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_russell", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_1885ec9fcf06", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_sonia", "")))))
end)

ccb.runtime.handler("dlg_p_dda_50d7905c11f8", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_sonia", "")))))
end)

ccb.runtime.handler("dlg_p_dda_bff6e448efd8", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_tom", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_21271b12063e", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") >= 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_tom", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_e044ff8b2e0f", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_zachary", "")))))
end)

ccb.runtime.handler("dlg_p_dda_9aeef99033a0", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_chef", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_b9e1e88d4a2b", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_chef", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_godco_joinee", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_0a0c74d1dca5", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and (not (H.creature_has_effect(H.npc(ctx), "u_got_meal", nil, nil))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_godco_joinee", "")))))
end)

ccb.runtime.handler("dlg_p_dda_4cb2c3f2db3c", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "anger") < 5) and ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_meeting_u_met_godco_chef", "")))))
end)

ccb.runtime.handler("dlg_p_dda_1e018699ec48", function(ctx)
    return ((H.npc_opinion(H.npc(ctx), "value") >= 3) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_u_know_about_family", "")))))
end)

ccb.runtime.handler("dlg_p_dda_25f8b6ccfbd6", function(ctx)
    return (H.global_var_num("isherwood_family_coming") == 1)
end)

ccb.runtime.handler("dlg_p_dda_79ff390b1048", function(ctx)
    return (H.global_var_num("isherwood_family_coming") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_645e47120623", function(ctx)
    return ((H.global_var_num("isherwood_family_coming") ~= 1) and H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1"))
end)

ccb.runtime.handler("dlg_p_dda_83412419eedf", function(ctx)
    return (((("unclear") == (H.var_str("actor", H.u(ctx), ctx, "too_short_to_be_a_stormtrooper", "")))) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_61f35a916aef", function(ctx)
    return ((H.var_num(H.u(ctx), "timer_barry_rescue") < 432000) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_fce8b3e8f29e", function(ctx)
    return ((H.var_num(H.u(ctx), "timer_barry_rescue") > 432000) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_40f45cad35d8", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_knowledge_u_dont_know_about_farm", "")))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"))) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_90081a4518b7", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_knowledge_u_thinking_about_farm", "")))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"))) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_72f3f2dcc42f", function(ctx)
    return ((H.global_var_num("barry_PTSD_freakouts") >= 1) and ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)))))
end)

ccb.runtime.handler("dlg_p_dda_a3533956124c", function(ctx)
    return ((not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3))) and (not (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3))))
end)

ccb.runtime.handler("dlg_p_dda_ed841dee1cbd", function(ctx)
    return (H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3) or H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3) or H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3) or H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3))
end)

ccb.runtime.handler("dlg_p_dda_f09586a92822", function(ctx)
    return H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_1", 3)
end)

ccb.runtime.handler("dlg_p_dda_a1724e70f34f", function(ctx)
    return H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_2", 3)
end)

ccb.runtime.handler("dlg_p_dda_8ea3f4781fac", function(ctx)
    return H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_3", 3)
end)

ccb.runtime.handler("dlg_p_dda_2ca4afb3a151", function(ctx)
    return H.char_near_om_location(H.npc(ctx), "barry_mi-go_scout_tower_4", 3)
end)

ccb.runtime.handler("dlg_p_dda_97cadd917dd3", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "carlos_has_anvil", "")))) and (H.time_since(H.global_var_num_opt("timer_carlos_has_anvil"), 1) <= 432000))
end)

ccb.runtime.handler("dlg_p_dda_e8988dc59f31", function(ctx)
    return (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "carlos_has_anvil", "")))) and (H.time_since(H.global_var_num_opt("timer_carlos_has_anvil"), 1) > 432000))
end)

ccb.runtime.handler("dlg_p_dda_a01355dd84c8", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.global_var_num("isherwood_barry_rescued") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_4a15715ed8e3", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.global_var_num("isherwood_barry_rescued") ~= 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_heard_about_chris_ideas", "")))))
end)

ccb.runtime.handler("dlg_p_dda_3563a6faba65", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.global_var_num("isherwood_barry_rescued") == 1))
end)

ccb.runtime.handler("dlg_p_dda_c60e2fef403c", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.global_var_num("isherwood_barry_rescued") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_heard_about_chris_ideas", "")))))
end)

ccb.runtime.handler("dlg_p_dda_e23779bc32b5", function(ctx)
    return ((H.global_var_num("npc_timer_thinking_about_plan") >= 3600) and (H.global_var_num("isherwood_barry_rescued") == 0))
end)

ccb.runtime.handler("dlg_p_dda_9a6581117466", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("isherwood_family_coming") == 0) and (H.global_var_num("isherwood_barry_rescued") ~= 1) and (H.global_var_num("npc_isherwood_barry_rescue_attempts") >= 1))
end)

ccb.runtime.handler("dlg_p_dda_1b4379fba2e7", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("isherwood_family_coming") == 1) and (H.global_var_num("isherwood_barry_rescued") ~= 1) and (H.global_var_num("npc_isherwood_barry_rescue_attempts") >= 1))
end)

ccb.runtime.handler("dlg_p_dda_352673c69d29", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") and (H.char_has_item(H.u(ctx), "armor_riot") or H.char_has_item(H.u(ctx), "helmet_riot") or H.char_has_item(H.u(ctx), "armor_riot_arm") or H.char_has_item(H.u(ctx), "armor_riot_leg")) and (H.global_var_num("isherwood_gear_status") < 1))
end)

ccb.runtime.handler("dlg_p_dda_58b387811876", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") and ((H.global_var_num("isherwood_gear_retrival_armor_body_count") == 5) and (H.global_var_num("isherwood_gear_retrival_helmet_count") == 5) and (H.global_var_num("isherwood_gear_retrival_armor_arm_count") == 5) and (H.global_var_num("isherwood_gear_retrival_armor_leg_count") == 5)) and (H.global_var_num("isherwood_gear_status") < 1))
end)

ccb.runtime.handler("dlg_p_dda_f3dffbfae44f", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") and ((not ((H.global_var_num("isherwood_gear_retrival_armor_body_count") >= 1))) and (not ((H.global_var_num("isherwood_gear_retrival_helmet_count") >= 1))) and (not ((H.global_var_num("isherwood_gear_retrival_armor_arm_count") >= 1))) and (not ((H.global_var_num("isherwood_gear_retrival_armor_leg_count") >= 1)))) and (H.global_var_num("isherwood_gear_status") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c74ca0bd1916", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS") and H.char_has_items(H.u(ctx), "bag_canvas", math.floor(20), math.floor(0)) and (H.global_var_num("isherwood_wall_status") < 1))
end)

ccb.runtime.handler("dlg_p_dda_4018badfc82f", function(ctx)
    return ((H.global_var_num("isherwood_barry_rescued") ~= 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1"))))
end)

ccb.runtime.handler("dlg_p_dda_1cb9d4920113", function(ctx)
    return (not ((services.npcs.count_allies(false) >= (1))))
end)

ccb.runtime.handler("dlg_p_dda_58b78813d1ec", function(ctx)
    return (H.global_var_num("isherwood_gear_status") < 1)
end)

ccb.runtime.handler("dlg_p_dda_d878d0dca848", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS"))) and (H.global_var_num("isherwood_wall_status") < 1))
end)

ccb.runtime.handler("dlg_p_dda_f53210a49dbf", function(ctx)
    return (H.char_has_item(H.u(ctx), "armor_riot") and (H.global_var_num("isherwood_gear_retrival_armor_body_count") < 5))
end)

ccb.runtime.handler("dlg_p_dda_683b81f6faa8", function(ctx)
    return (H.char_has_item(H.u(ctx), "helmet_riot") and (H.global_var_num("isherwood_gear_retrival_helmet_count") < 5))
end)

ccb.runtime.handler("dlg_p_dda_657aabd51a14", function(ctx)
    return (H.char_has_item(H.u(ctx), "armor_riot_arm") and (H.global_var_num("isherwood_gear_retrival_armor_arm_count") < 5))
end)

ccb.runtime.handler("dlg_p_dda_60d6d15b9b8b", function(ctx)
    return (H.char_has_item(H.u(ctx), "armor_riot_leg") and (H.global_var_num("isherwood_gear_retrival_armor_leg_count") < 5))
end)

ccb.runtime.handler("dlg_p_dda_35ada2d8d64b", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.char_skill(H.u(ctx), "speech") >= 3))
end)

ccb.runtime.handler("dlg_p_dda_76314c46821c", function(ctx)
    return ((not (H.char_is_wearing(H.u(ctx), "badge_marshal"))) and (H.char_skill(H.u(ctx), "speech") < 3))
end)

ccb.runtime.handler("dlg_p_dda_c82f3dfba09e", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("timer_chris_talked_to_lisa") >= 3600))
end)

ccb.runtime.handler("dlg_p_dda_6ddab87473f0", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("timer_chris_talked_to_lisa") < 3600))
end)

ccb.runtime.handler("dlg_p_dda_da2ff9750594", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "chris_planned_for_bomb", "")))) and ((not (H.char_has_mission(H.u(ctx), "MISSION_LUKE_RETRIEVE_TRUCK"))) and (H.global_var_num("isherwood_luke_truck_status") < 1)))
end)

ccb.runtime.handler("dlg_p_dda_06109bce9e89", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and ((not (H.char_has_mission(H.u(ctx), "MISSION_LUKE_RETRIEVE_TRUCK_EXPLOSIVES"))) and (H.global_var_num("isherwood_luke_truck_coming") < 1) and (H.global_var_num("isherwood_luke_truck_status") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_17932503160e", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_did_luke_missions", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_saved_barry_isherwood", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_luke_isherwood_books"), 1) <= 604800) and (H.var_num(H.u(ctx), "timer_barry_rescue") <= 432000))
end)

ccb.runtime.handler("dlg_p_dda_a0ce66305f5e", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_did_luke_missions", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_saved_barry_isherwood", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_luke_isherwood_books"), 1) > 604800) and (H.var_num(H.u(ctx), "timer_barry_rescue") > 432000))
end)

ccb.runtime.handler("dlg_p_dda_7fe93cb81db6", function(ctx)
    return (H.char_skill(H.u(ctx), "survival") >= 2)
end)

ccb.runtime.handler("dlg_p_dda_b9a36d7530d8", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_blacksmith_wait") == 3)
end)

ccb.runtime.handler("dlg_p_dda_b595ec4ab494", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_blacksmith_wait") == 4)
end)

ccb.runtime.handler("dlg_p_dda_4d44d70c6ce3", function(ctx)
    return H.char_has_items(H.u(ctx), "FMCNote", math.floor(H.var_num(H.u(ctx), "number_artisans_blacksmith_armor_cost")), math.floor(0))
end)

ccb.runtime.handler("dlg_p_dda_409771bcffe0", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_armor"), 86400) >= (H.var_num(H.u(ctx), "number_artisans_blacksmith_wait") * 7))
end)

ccb.runtime.handler("dlg_p_dda_9928daec618a", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) < 604800) and ((("obrez") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_a37af3e3e24f", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) > 604800) and ((("obrez") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_01614f70a4ef", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) < 604800) and ((("pressin") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_bb43aaaa8cd6", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) > 604800) and ((("pressin") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_2ed50ba0e45a", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) < 1209600) and ((("LOUVERTURE") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_a3da54055121", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) > 1209600) and ((("LOUVERTURE") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_589176981e2b", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) < 1209600) and ((("DISORDER") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_585fcebeaadb", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_artisans_u_waiting_on_prototype"), 1) > 1209600) and ((("DISORDER") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_u_current_project", "")))))
end)

ccb.runtime.handler("dlg_p_dda_d1ef82a2d0b8", function(ctx)
    return H.char_has_items(H.u(ctx), "FMCNote", math.floor(H.var_num(H.u(ctx), "number_artisans_blacksmith_weapon_cost")), math.floor(0))
end)

ccb.runtime.handler("dlg_p_dda_0bf3200b5d1a", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= H.var_num(H.u(ctx), "number_artisans_gunsmith_sum0"))
end)

ccb.runtime.handler("dlg_p_dda_3af1e0350a42", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= H.var_num(H.u(ctx), "number_artisans_gunsmith_sum1"))
end)

ccb.runtime.handler("dlg_p_dda_1ccca473ad19", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= H.var_num(H.u(ctx), "number_artisans_gunsmith_sum3"))
end)

ccb.runtime.handler("dlg_p_dda_d2761de8f6a8", function(ctx)
    return (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit") >= H.var_num(H.u(ctx), "number_artisans_gunsmith_sum5"))
end)

ccb.runtime.handler("dlg_p_dda_df5563c8a03b", function(ctx)
    return H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_09d75b71ed57", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_artisans_gunsmith_knows_about_conversion", "")))) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds") and 1 or 0))))
end)

ccb.runtime.handler("dlg_p_dda_89916db0b2be", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "dialogue_first_meeting_talked_to_merchant") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_10f926b68b74", function(ctx)
    return (not H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "dialogue_first_meeting_talked_to_merchant") and 1 or 0)))
end)

ccb.runtime.handler("dlg_p_dda_a1e6553c880f", function(ctx)
    return (not H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "timer_fabricate_waiting") and 1 or 0)))
end)

ccb.runtime.handler("dlg_p_dda_e6af57b8eff7", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "timer_fabricate_waiting") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_f855db4d8b27", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "time_mission_meteorologist_wait"), 1) >= 172800)
end)

ccb.runtime.handler("dlg_p_dda_f67f3b47ebe4", function(ctx)
    return (H.char_at_om_location(H.npc(ctx), "FACTION_CAMP_ANY") or H.char_at_om_location(H.npc(ctx), "evac_center_18") or H.char_at_om_location(H.npc(ctx), "robofachq_surface_entrance"))
end)

ccb.runtime.handler("dlg_p_dda_93de4f1e1331", function(ctx)
    return (H.global_var_num("npc_randomize_dialogue_direction") == 0)
end)

ccb.runtime.handler("dlg_p_dda_2fad9a32b6ea", function(ctx)
    return (H.global_var_num("npc_randomize_dialogue_direction") == 1)
end)

ccb.runtime.handler("dlg_p_dda_ffef735f5e6b", function(ctx)
    return (H.global_var_num("npc_randomize_dialogue_direction") == 2)
end)

ccb.runtime.handler("dlg_p_dda_c854bbaab2c0", function(ctx)
    return (H.global_var_num("npc_randomize_dialogue_direction") == 3)
end)

ccb.runtime.handler("dlg_p_dda_965ef3fae5ff", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (not (((("isherwood") == (H.var_str("actor", H.npc(ctx), ctx, "camper_van_traveler_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_730976137644", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 2) and (not (((("chem_chabin") == (H.var_str("actor", H.npc(ctx), ctx, "camper_van_traveler_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_676606e9ce0a", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 3) and (not (((("cowboy") == (H.var_str("actor", H.npc(ctx), ctx, "camper_van_traveler_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_fd9e247d105f", function(ctx)
    return (H.global_var_num("npc_John_Bailey_taught") <= 3)
end)

ccb.runtime.handler("dlg_p_dda_5a268b8b89b9", function(ctx)
    return true
end)

ccb.runtime.handler("dlg_p_dda_19ac42f5fa83", function(ctx)
    return (not ((services.camps.has_player_owned_camp().value == true)))
end)

ccb.runtime.handler("dlg_p_dda_ee51db677ef6", function(ctx)
    return ((services.camps.has_player_owned_camp().value == true) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_recruit_reena_recruited", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_453225921210", function(ctx)
    return ((services.camps.has_player_owned_camp().value == true) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_recruit_luo_recruited", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_451497940a38", function(ctx)
    return (services.camps.has_player_owned_camp().value == true)
end)

ccb.runtime.handler("dlg_p_dda_1e3f5a885a23", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 265)
end)

ccb.runtime.handler("dlg_p_dda_2abaf18a0216", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 630)
end)

ccb.runtime.handler("dlg_p_dda_78ae1d01ea65", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "PRETTY") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL2") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL3") == 1)) and H.creature_has_effect(H.npc(ctx), "Alonso_pants_restored", nil, nil) and (H.char_age(H.u(ctx)) >= 18) and H.char_has_item(H.u(ctx), "condom"))
end)

ccb.runtime.handler("dlg_p_dda_70c3c5fe68ba", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "PRETTY") == 1))) and (not ((H.char_has_trait(H.u(ctx), "BEAUTIFUL") == 1))) and (not ((H.char_has_trait(H.u(ctx), "BEAUTIFUL2") == 1))) and (not ((H.char_has_trait(H.u(ctx), "BEAUTIFUL3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "UGLY") == 1))) and (not ((H.char_has_trait(H.u(ctx), "DEFORMED") == 1))) and (not ((H.char_has_trait(H.u(ctx), "DEFORMED2") == 1))) and (not ((H.char_has_trait(H.u(ctx), "DEFORMED3") == 1))) and H.creature_has_effect(H.npc(ctx), "Alonso_pants_restored", nil, nil) and (H.char_age(H.u(ctx)) >= 18) and H.char_has_item(H.u(ctx), "condom"))
end)

ccb.runtime.handler("dlg_p_dda_a48324f18173", function(ctx)
    return (((H.char_has_trait(H.u(ctx), "UGLY") == 1) or (H.char_has_trait(H.u(ctx), "DEFORMED") == 1) or (H.char_has_trait(H.u(ctx), "DEFORMED2") == 1) or (H.char_has_trait(H.u(ctx), "DEFORMED3") == 1)) and H.creature_has_effect(H.npc(ctx), "Alonso_pants_restored", nil, nil) and (H.char_age(H.u(ctx)) >= 18) and H.char_has_item(H.u(ctx), "condom"))
end)

ccb.runtime.handler("dlg_p_dda_4a83d5269f04", function(ctx)
    return (H.char_age(H.u(ctx)) < 18)
end)

ccb.runtime.handler("dlg_p_dda_681194643ca7", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_REFUGEE_Boris_CLEANUP") and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "mission_Boris_mission_1_cleanup_asked", "")))))) and (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1") == 2))
end)

ccb.runtime.handler("dlg_p_dda_7ee9ed104324", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_REFUGEE_Boris_CLEANUP") and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "mission_Boris_mission_1_cleanup_asked", "")))))) and (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1") == 3))
end)

ccb.runtime.handler("dlg_p_dda_b5e60d60a9f0", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_REFUGEE_Boris_CLEANUP") and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "mission_Boris_mission_1_cleanup_asked", "")))))) and (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1") == 4))
end)

ccb.runtime.handler("dlg_p_dda_7202e00080e0", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_Boris_mission_2", "")))) and (H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Boris_teach"), 1) > 86400))
end)

ccb.runtime.handler("dlg_p_dda_e94432d8e8ca", function(ctx)
    return (((("in_progress") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_dave_u_cardboard_gift", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_dave_creating_gift"), 1) > 86400))
end)

ccb.runtime.handler("dlg_p_dda_6f5900f35a2a", function(ctx)
    return ((H.var_num(H.u(ctx), "general_meeting_Draco_Dune_convo_depth") ~= 3) and (H.var_num(H.u(ctx), "general_meeting_Draco_Dune_convo_depth") ~= 7))
end)

ccb.runtime.handler("dlg_p_dda_dd80a02d9880", function(ctx)
    return (H.var_num(H.u(ctx), "general_meeting_Draco_Dune_convo_depth") == 3)
end)

ccb.runtime.handler("dlg_p_dda_0b77d9b346c2", function(ctx)
    return (H.var_num(H.u(ctx), "general_meeting_Draco_Dune_convo_depth") == 7)
end)

ccb.runtime.handler("dlg_p_dda_a34118e38e05", function(ctx)
    return (H.char_dodge(H.u(ctx)) < 1)
end)

ccb.runtime.handler("dlg_p_dda_9623c8d7a546", function(ctx)
    return (H.char_dodge(H.u(ctx)) < 6)
end)

ccb.runtime.handler("dlg_p_dda_f008b74ca526", function(ctx)
    return (H.char_dodge(H.u(ctx)) < 10)
end)

ccb.runtime.handler("dlg_p_dda_507a9328c34f", function(ctx)
    return (H.char_dodge(H.u(ctx)) < 15)
end)

ccb.runtime.handler("dlg_p_dda_228162772555", function(ctx)
    return (H.char_dodge(H.u(ctx)) < 20)
end)

ccb.runtime.handler("dlg_p_dda_e3c0424690ab", function(ctx)
    return (H.char_dodge(H.u(ctx)) > 20)
end)

ccb.runtime.handler("dlg_p_dda_891d2a7e9528", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Fatima_barter_fail"), 1) > 86400) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "barter_flag_Fatima_barter_success", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_Fatima_Mission1", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_28ad79fe4659", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Fatima_barter_fail"), 1) > 86400) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "barter_flag_Fatima_barter_success", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_Fatima_Mission1", "")))))
end)

ccb.runtime.handler("dlg_p_dda_f4f8d93f10a9", function(ctx)
    return (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness") >= 7)
end)

ccb.runtime.handler("dlg_p_dda_dc1bf359f426", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Jenny_teach"), 1) > 86400) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knowledge_flag_Jenny_teach", "")))))
end)

ccb.runtime.handler("dlg_p_dda_40f96f0660d7", function(ctx)
    return ((H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Jenny_teach"), 1) > 86400) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knowledge_flag_Jenny_teach", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_c0d07b73df17", function(ctx)
    return ((H.char_skill(H.u(ctx), "computer") >= 2) or (H.char_skill(H.u(ctx), "electronics") >= 2) or (H.char_skill(H.u(ctx), "mechanics") >= 2))
end)

ccb.runtime.handler("dlg_p_dda_54492866b5b0", function(ctx)
    return ((H.char_skill(H.u(ctx), "computer") < 2) and (H.char_skill(H.u(ctx), "electronics") < 2) and (H.char_skill(H.u(ctx), "mechanics") < 2))
end)

ccb.runtime.handler("dlg_p_dda_7ae74f090fb2", function(ctx)
    return ((H.char_skill(H.u(ctx), "computer") < 2) and (H.char_skill(H.u(ctx), "electronics") < 2) and (H.char_skill(H.u(ctx), "mechanics") < 2) and (H.char_stat(H.u(ctx), "intelligence") >= (10)))
end)

ccb.runtime.handler("dlg_p_dda_14d6d86ed426", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60)
end)

ccb.runtime.handler("dlg_p_dda_ec4cf1c5815e", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_REFUGEE_Jenny_GET_PNEUMATICS"))) and (not (((("mission_complete") == (H.var_str("actor", H.u(ctx), ctx, "Jenny_pneumatics", "")))))) and ((services.time.calendar().now.turns_since_cataclysm / 86400) < 60))
end)

ccb.runtime.handler("dlg_p_dda_f8ea0408a5a9", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Jenny_project_timer"), 1) >= 604800)
end)

ccb.runtime.handler("dlg_p_dda_f7b8fa61ed7a", function(ctx)
    return (H.time_since(H.var_num_opt(H.npc(ctx), "timer_flag_Jenny_project_timer"), 1) >= 1209600)
end)

ccb.runtime.handler("dlg_p_dda_179329b6cb3b", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 120)
end)

ccb.runtime.handler("dlg_p_dda_fe3a896fea99", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 80)
end)

ccb.runtime.handler("dlg_p_dda_defb5ab5fdd2", function(ctx)
    return (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness") >= 5)
end)

ccb.runtime.handler("dlg_p_dda_0878c016a807", function(ctx)
    return (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_d82dc5cb5113", function(ctx)
    return (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness") >= 3)
end)

ccb.runtime.handler("dlg_p_dda_3845f6520b02", function(ctx)
    return (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness") >= 6)
end)

ccb.runtime.handler("dlg_p_dda_aea23a04550e", function(ctx)
    return (H.global_var_num("npc_randomize_dialogue_direction") == 4)
end)

ccb.runtime.handler("dlg_p_dda_a1b66fb7c4f1", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (not (H.char_has_mission(H.u(ctx), "directions_isherwood"))))
end)

ccb.runtime.handler("dlg_p_dda_873376a17718", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 2) and (not (H.char_has_mission(H.u(ctx), "directions_hub01"))))
end)

ccb.runtime.handler("dlg_p_dda_a2718e906bff", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 3) and (not (H.char_has_mission(H.u(ctx), "directions_exodii"))))
end)

ccb.runtime.handler("dlg_p_dda_09f33bbde74b", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 4) and (not (H.char_has_mission(H.u(ctx), "directions_artisans"))))
end)

ccb.runtime.handler("dlg_p_dda_9aa5249d2b43", function(ctx)
    return ((H.global_var_num("FM_exodii_autodoc_placed") == 1) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_e65b26caff69", function(ctx)
    return (H.global_var_num("free_merchants_hub_trade_route") == 1)
end)

ccb.runtime.handler("dlg_p_dda_5376c19ccc7f", function(ctx)
    return (H.faction_food("free_merchants", "human_flesh_vitamin") < 1)
end)

ccb.runtime.handler("dlg_p_dda_a42ad18468ec", function(ctx)
    return (H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS") and H.char_has_item(H.u(ctx), "exodii_portable_tv") and (H.global_var_num("exodii_FM_negotiation_failed") ~= 1) and (H.global_var_num("exodii_FM_negotiation_success") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_9e0a72bc07b7", function(ctx)
    return (H.char_has_mission(H.u(ctx), "EXODII_MISSION_MEET_FREE_MERCHANTS") and (not (H.char_has_item(H.u(ctx), "exodii_portable_tv"))) and (H.global_var_num("exodii_FM_negotiation_failed") ~= 1) and (H.global_var_num("exodii_FM_negotiation_success") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_e5d79fed3b60", function(ctx)
    return (H.char_skill(H.u(ctx), "speech") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_1580c9fd076b", function(ctx)
    return H.follower_present(H.npc(ctx), "NC_BEGGAR_3")
end)

ccb.runtime.handler("dlg_p_dda_e3eb48cfc8df", function(ctx)
    return H.npc_has_visible_trait(H.npc(ctx), H.u(ctx), "FELINE_EARS")
end)

ccb.runtime.handler("dlg_p_dda_b80a3ce20b48", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 1) and (not (((("lapin") == (H.var_str("actor", H.u(ctx), ctx, "teamster_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_8b6492c5cbde", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 2) and (not (((("isherwood") == (H.var_str("actor", H.u(ctx), ctx, "teamster_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_636a261c1cba", function(ctx)
    return ((H.global_var_num("npc_randomize_dialogue_direction") == 3) and (not (((("exodii") == (H.var_str("actor", H.u(ctx), ctx, "teamster_mission_directions", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_d2342c198178", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_robofac_merc_1_helped_with_missions", "")))) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_robofac_merc_1_temporal_follower", "")))))) and (not (false)) and (not ((ctx:assigned_mission_count() == 1))))
end)

ccb.runtime.handler("dlg_p_dda_2c20491e4c6b", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_robofac_merc_1_has_gold_deal", "")))))) and (not (false)) and (not ((ctx:assigned_mission_count() == 1))))
end)

ccb.runtime.handler("dlg_p_dda_507b4950adea", function(ctx)
    return (((H.char_stat(H.u(ctx), "perception") >= (10)) or (H.char_skill(H.u(ctx), "mechanics") >= 4) or (H.char_skill(H.u(ctx), "gun") >= 2)) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_robofac_merc_1_robofac_merc_1_HWP", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_11254f2d418d", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_robofac_merc_1_robofac_merc_1_HWP", "")))) and (H.var_num(H.u(ctx), "favor_owed_to_u_robofac_merc_1_favor") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_can_research_rifle", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_f782335365a7", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_robofac_merc_1_robofac_merc_1_HWP", "")))) and (H.var_num(H.u(ctx), "favor_owed_to_u_robofac_merc_1_favor") ~= 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_can_research_rifle", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_e9c924b77994", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_robofac_merc_1_asked_gender", "")))))) and (H.npc_opinion(H.npc(ctx), "trust") >= 3))
end)

ccb.runtime.handler("dlg_p_dda_83478589bcf4", function(ctx)
    return (H.var_num(H.u(ctx), "favor_owed_to_u_robofac_merc_1_favor") == 1)
end)

ccb.runtime.handler("dlg_p_dda_5518106cf401", function(ctx)
    return ((not (false)) and (not ((ctx:assigned_mission_count() == 1))))
end)

ccb.runtime.handler("dlg_p_dda_6bb028d8c1c4", function(ctx)
    return (not (((not (false)) and (not ((ctx:assigned_mission_count() == 1))))))
end)

ccb.runtime.handler("dlg_p_dda_2e6ab3005522", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (10))
end)

ccb.runtime.handler("dlg_p_dda_d5a685558a07", function(ctx)
    return H.char_has_items_sum(H.u(ctx), { { item = "broken_exodii_worker", amount = 1 } })
end)

ccb.runtime.handler("dlg_p_dda_4c42079ffa99", function(ctx)
    return H.char_has_items_sum(H.u(ctx), { { item = "broken_exodii_quad", amount = 1 } })
end)

ccb.runtime.handler("dlg_p_dda_c7eeecf43eb7", function(ctx)
    return H.char_has_items_sum(H.u(ctx), { { item = "broken_exodii_turret", amount = 1 } })
end)

ccb.runtime.handler("dlg_p_dda_4004e2d04b14", function(ctx)
    return H.char_has_items_sum(H.u(ctx), { { item = "broken_exodii_sniper_drone", amount = 1 } })
end)

ccb.runtime.handler("dlg_p_dda_a5d50abe7c2d", function(ctx)
    return (H.global_var_num("robofac_exodii_cbm_knowledge") > 50)
end)

ccb.runtime.handler("dlg_p_dda_57545b08208f", function(ctx)
    return (H.var_num(H.u(ctx), "counter_BEM_BEM_human_sample_reward_owed") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_fc580c0c78bf", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (20))
end)

ccb.runtime.handler("dlg_p_dda_017a226b8b3c", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))) and (not ((H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1))) and (not (H.char_has_flag(H.u(ctx), "NO_CBM_INSTALLATION"))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_71404101a080", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and (not ((H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_73e629c1159d", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and (not ((H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))) and (not (H.char_has_flag(H.u(ctx), "NO_CBM_INSTALLATION"))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_cf7380580dbd", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_ddc54381dd18", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))) and (not (H.char_has_flag(H.u(ctx), "NO_CBM_INSTALLATION"))))
end)

ccb.runtime.handler("dlg_p_dda_15f8651f5dcf", function(ctx)
    return ((H.global_var_num("hub01_promised_cbm_reward") == 1) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface_brain_lesion") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_6293b1c7fa21", function(ctx)
    return (H.global_var_num("hub01_found_u_exodii_interface") == 1)
end)

ccb.runtime.handler("dlg_p_dda_6291656cdf4e", function(ctx)
    return (H.global_var_num("hub01_found_u_exodii_interface") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_70bb50a96013", function(ctx)
    return (H.global_var_num("robofac_exodii_cbm_knowledge") >= 20)
end)

ccb.runtime.handler("dlg_p_dda_799f35256c4a", function(ctx)
    return ((H.global_var_num("robofac_exodii_cbm_knowledge") >= 20) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_ancilla_doctor_u_learned_about_bionic_limbs", "")))))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_a9060f5caa99", function(ctx)
    return ((H.global_var_num("robofac_exodii_cbm_knowledge") >= 20) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_ancilla_doctor_u_learned_about_bionic_limbs", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_ancilla_doctor_u_asked_about_swapping_limbs", "")))))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_dbc8f5960e8c", function(ctx)
    return ((H.global_var_num("robofac_exodii_cbm_knowledge") >= 20) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_ancilla_doctor_u_learned_about_bionic_limbs", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_ancilla_doctor_u_asked_about_swapping_limbs", "")))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_f684f7d3a2ec", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (15))
end)

ccb.runtime.handler("dlg_p_dda_b67aadf18b30", function(ctx)
    return (not ((H.char_has_any_trait(H.u(ctx), { "PROF_FED" }) or (H.npc_faction_trust(H.npc(ctx)) >= (15)))))
end)

ccb.runtime.handler("dlg_p_dda_5957e2c14a79", function(ctx)
    return (H.global_var_num("visited_a_portal_dungeon") == 1)
end)

ccb.runtime.handler("dlg_p_dda_ad5089f7518c", function(ctx)
    return (H.var_num(H.u(ctx), "mininuke_activated") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_5e3595b3966d", function(ctx)
    return (H.char_proficiency(H.u(ctx), "prof_wp_basic_bug", "percent") >= 50)
end)

ccb.runtime.handler("dlg_p_dda_722a72f0080f", function(ctx)
    return (H.var_num(H.u(ctx), "string_dimension_visits") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_25c93988a340", function(ctx)
    return (H.var_num(H.u(ctx), "string_dimension_ziggurat_exit") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_20bee21da2dc", function(ctx)
    return (H.global_var_num("ancilla_autodoc_placed") == 1)
end)

ccb.runtime.handler("dlg_p_dda_f8514680dee5", function(ctx)
    return (H.global_var_num("ancilla_autodoc_placed") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_86c977e8ade1", function(ctx)
    return (not (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "dialog_negotiated") and 1 or 0))))
end)

ccb.runtime.handler("dlg_p_dda_7392ada3461d", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_started_earpiece", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_waiting_on_pat", "")))) and (H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 172800) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_85398ce4b99c", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1) and H.char_has_items(H.u(ctx), "integrated_ar", math.floor(1), math.floor(0)) and H.char_has_bionic(H.u(ctx), "bio_radio") and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_said_use_the_earpiece", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_knows_u_cyborg", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_knows_u_hub01_cyborg", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_gave_transponder_CBM", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_fec1631c1c08", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_started_earpiece", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_finished_earpiece", "")))))) and (H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 86400) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_b0a97945d8c8", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_partners", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_mws_4", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_talked_about_recon", "")))) and (H.time_since(H.global_var_num_opt("robofac_timer_pat_recon"), 1) < 259200))
end)

ccb.runtime.handler("dlg_p_dda_e22805bf79d4", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_partners", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_mws_4", "")))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_talked_about_recon", "")))) and (H.time_since(H.global_var_num_opt("robofac_timer_pat_recon"), 1) >= 259200))
end)

ccb.runtime.handler("dlg_p_dda_fc9dd853bbdf", function(ctx)
    return ((H.global_var_num("robofac_pat_lost_signal_highlands") == 1) or (H.global_var_num("robofac_pat_lost_signal_string_dimension") == 1) or (H.global_var_num("robofac_pat_lost_signal_radiosphere") == 1) or (H.global_var_num("robofac_pat_lost_signal_spider_dimension") == 1) or (H.global_var_num("robofac_pat_lost_signal_cabin_reverb") == 1) or (H.global_var_num("robofac_pat_lost_signal_labyrinth") == 1) or (H.global_var_num("robofac_pat_lost_signal_portal_storm_dungeon") == 1))
end)

ccb.runtime.handler("dlg_p_dda_19cbab0e7514", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_highlands") == 1)
end)

ccb.runtime.handler("dlg_p_dda_5e2c0afc04fc", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_portal_storm_dungeon") == 1)
end)

ccb.runtime.handler("dlg_p_dda_4943c9783c0f", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_spider_dimension") == 1)
end)

ccb.runtime.handler("dlg_p_dda_77b8094442b1", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_cabin_reverb") == 1)
end)

ccb.runtime.handler("dlg_p_dda_76542a1b502d", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_radiosphere") == 1)
end)

ccb.runtime.handler("dlg_p_dda_32a33c437308", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_labyrinth") == 1)
end)

ccb.runtime.handler("dlg_p_dda_c289cf76d6f0", function(ctx)
    return (H.global_var_num("robofac_pat_lost_signal_string_dimension") == 1)
end)

ccb.runtime.handler("dlg_p_dda_4b66d64ac935", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_started_earpiece", "")))))) and (not ((H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 1209600))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_talked_about_gear_improvement", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_e0727570d7c1", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_started_earpiece", "")))))) and (H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 1209600) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_talked_about_gear_improvement", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_68566bece6a5", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_remaking_glasses", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and (H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_33d334fd0cea", function(ctx)
    return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_remaking_earpiece", "")))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and (H.time_since(H.global_var_num_opt("robofac_timer_waiting_on_pat"), 1) >= 86400))
end)

ccb.runtime.handler("dlg_p_dda_80af6556c707", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_radio"))
end)

ccb.runtime.handler("dlg_p_dda_72b8a19c68d6", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_fingerhack"))
end)

ccb.runtime.handler("dlg_p_dda_e962ad0af22f", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_tattoo_led"))
end)

ccb.runtime.handler("dlg_p_dda_ab82dca84eb2", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_lockpick"))
end)

ccb.runtime.handler("dlg_p_dda_a1150702cf50", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_shotgun"))
end)

ccb.runtime.handler("dlg_p_dda_44c74770e2b9", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_alarm"))
end)

ccb.runtime.handler("dlg_p_dda_e3b016def5dc", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_claws"))
end)

ccb.runtime.handler("dlg_p_dda_55c5c3002c81", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_uncanny_dodge"))
end)

ccb.runtime.handler("dlg_p_dda_7867852f4ce5", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_emp_armgun"))
end)

ccb.runtime.handler("dlg_p_dda_4215f45fca37", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_lighter"))
end)

ccb.runtime.handler("dlg_p_dda_268bb7bcbc95", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_ankles"))
end)

ccb.runtime.handler("dlg_p_dda_d2a1e7e5e1e4", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_taser"))
end)

ccb.runtime.handler("dlg_p_dda_86ad941963b9", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_meteorologist"))
end)

ccb.runtime.handler("dlg_p_dda_30939c5bf4f6", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_cloak"))
end)

ccb.runtime.handler("dlg_p_dda_1f63a4ba4885", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_chain_lightning"))
end)

ccb.runtime.handler("dlg_p_dda_7d717bbd7627", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_razors"))
end)

ccb.runtime.handler("dlg_p_dda_102670331900", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_armor_eyes"))
end)

ccb.runtime.handler("dlg_p_dda_51e6bdc8575d", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_face_mask"))
end)

ccb.runtime.handler("dlg_p_dda_4c999bc5d4ed", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_probability_travel"))
end)

ccb.runtime.handler("dlg_p_dda_c6d96b776296", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_blade"))
end)

ccb.runtime.handler("dlg_p_dda_24f55b5d7727", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_cable"))
end)

ccb.runtime.handler("dlg_p_dda_c75ea311f6cc", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_laser"))
end)

ccb.runtime.handler("dlg_p_dda_d5f2a8f74049", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_syringe"))
end)

ccb.runtime.handler("dlg_p_dda_0513e239e925", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_multimeter"))
end)

ccb.runtime.handler("dlg_p_dda_df9541c49459", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_night"))
end)

ccb.runtime.handler("dlg_p_dda_8eae28e0437c", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_electrokit"))
end)

ccb.runtime.handler("dlg_p_dda_273cf9ed3600", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_surgical_razor"))
end)

ccb.runtime.handler("dlg_p_dda_fb0498f374e3", function(ctx)
    return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "")))))) and H.char_has_bionic(H.u(ctx), "bio_tools"))
end)

ccb.runtime.handler("dlg_p_dda_1b302d251b08", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_EXODII_WAREHOUSE") and (H.time_since(H.global_var_num_opt("robofac_timer_pat_warehouse"), 1) < 604800))
end)

ccb.runtime.handler("dlg_p_dda_8149944efd8f", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_EXODII_WAREHOUSE") and (H.time_since(H.global_var_num_opt("robofac_timer_pat_warehouse"), 1) >= 604800))
end)

ccb.runtime.handler("dlg_p_dda_a3d6e4384be8", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 1) and (H.global_var_num("HEW_vitrified_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_1"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_vitrified", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_1c05067be15a", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 2) and (H.global_var_num("HEW_lixa_data_sold") < 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_lixa", "")))))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_2"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_lixa_sm_1", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_62a9119d72be", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 3) and (H.global_var_num("HEW_temple_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_3"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_strange_temple", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_06a68a2bea7f", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 4) and (H.global_var_num("HEW_amigara_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_4"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_amigara", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_0cf126c72708", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 5) and (H.global_var_num("HEW_exodii_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_5"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_exodii", "")))))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_b3e08a2ee841", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 6) and (H.global_var_num("HEW_physics_lab_data_sold") < 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_physics_lab", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_4d3ff720fdff", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 7) and (H.global_var_num("HEW_monster_corpse_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_7"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_monster_corpse", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_ebb60da2c217", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 8) and (H.global_var_num("HEW_barricaded_church_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_8"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_rural_church", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_d0462abad931", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 9) and (H.global_var_num("HEW_morgantown_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_9"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_morgantown", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_fb7ee155fe94", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 10) and (H.global_var_num("HEW_cabin_reverb_data_sold") < 1) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_10"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_cabin_reverb", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_5cbf7f6a57a4", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 11) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_11"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_radio_tower_reverberation_mp3", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_9c0b06ae2d63", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 12) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_12"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_spiral_mine", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_65d1ba71c183", function(ctx)
    return ((H.global_var_num("robofac_pat_recon_random_loc") == 13) and (not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_PAT_RECON_13"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_scarlet_storm", "")))))) and (H.global_var_num("player_saw_scarlet_storm") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_81e6f79d27c9", function(ctx)
    return ((H.npc_faction_trust(H.npc(ctx)) >= (5)) and H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") and (H.global_var_num("isherwood_gear_status") < 1) and (not ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_bought_riot_gear", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "npc_dialogue_exodii_npc_bought_riot_gear", ""))))))))
end)

ccb.runtime.handler("dlg_p_dda_1e75107c89bd", function(ctx)
    return ((((("yes") == (H.var_str("global", nil, ctx, "hub01_intercom_pay_back_on_specimens", "")))) or ((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "npc_dialogue_intercom_u_pay_back_on_specimens", ""))))) and (H.global_var_num("isherwood_barry_rescued") == 1) and H.char_has_mission(H.u(ctx), "MISSION_HUB01_PAY_BACK_RIOT_GEAR"))
end)

ccb.runtime.handler("dlg_p_dda_da644a19c6d8", function(ctx)
    return ((H.global_var_num("hub01_knows_exodii") == 1) and (not ((H.global_var_num("hub01_bought_exodii_warehouse") == 1))) and (H.char_has_mission(H.u(ctx), "EXODII_MISSION_WAREHOUSE") or (H.global_var_num("warehouse_was_found") == 1) or ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_found_warehouse", "")))) or (H.var_num(H.u(ctx), "rebooted_locator") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_6d11e6c2a474", function(ctx)
    return ((not ((H.global_var_num("hub01_knows_exodii") == 1))) and (not ((H.global_var_num("hub01_bought_exodii_warehouse") == 1))) and (H.char_has_mission(H.u(ctx), "EXODII_MISSION_WAREHOUSE") or (H.global_var_num("warehouse_was_found") == 1) or ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_found_warehouse", "")))) or (H.var_num(H.u(ctx), "rebooted_locator") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_9f5d87c4d5d0", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_waiting_on_warehouse") and 1 or 0)) and (H.global_var_num("hub01_promised_warehouse_info") ~= 1) and (H.global_var_num("hub01_stole_warehouse") == 1))
end)

ccb.runtime.handler("dlg_p_dda_fbf314db7395", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_waiting_on_warehouse") and 1 or 0)) and (H.global_var_num("hub01_promised_warehouse_info") == 1) and (H.global_var_num("hub01_stole_warehouse") == 1))
end)

ccb.runtime.handler("dlg_p_dda_2adf51ff1726", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_waiting_on_warehouse") and 1 or 0)) and (H.global_var_num("hub01_stole_warehouse") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_fdfcb8f5ce03", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_waiting_on_autodoc") and 1 or 0)) and (H.global_var_num("hub01_told_u_about_warehouse_autodoc") ~= 1))
end)

ccb.runtime.handler("dlg_p_dda_1fbf45f854de", function(ctx)
    return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_hub_waiting_on_autodoc") and 1 or 0)) and (H.global_var_num("hub01_told_u_about_warehouse_autodoc") == 1))
end)

ccb.runtime.handler("dlg_p_dda_8fcbe2fd16ae", function(ctx)
    return (H.global_var_num("hub01_knows_exodii") == 1)
end)

ccb.runtime.handler("dlg_p_dda_22c8f45ae117", function(ctx)
    return (H.global_var_num("hub01_knows_exodii") ~= 1)
end)

ccb.runtime.handler("dlg_p_dda_88b494c31259", function(ctx)
    return ((H.global_var_num("warehouse_was_found") == 1) or ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_completed_u_found_warehouse", "")))))
end)

ccb.runtime.handler("dlg_p_dda_656434aaa958", function(ctx)
    return ((H.global_var_num("warehouse_was_found") == 1) or (H.var_num(H.u(ctx), "rebooted_locator") == 1))
end)

ccb.runtime.handler("dlg_p_dda_6b2a493d9e87", function(ctx)
    return ((not ((H.global_var_num("warehouse_was_found") == 1))) and (not ((H.var_num(H.u(ctx), "rebooted_locator") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_a73b7872f690", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_warehouse"), 1) >= 86400)
end)

ccb.runtime.handler("dlg_p_dda_b7d7d0397e2b", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1209600)
end)

ccb.runtime.handler("dlg_p_dda_a8aa712606ab", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1036800)
end)

ccb.runtime.handler("dlg_p_dda_4c0d289091f3", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 604800)
end)

ccb.runtime.handler("dlg_p_dda_98d2c880556a", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) < 1209600)
end)

ccb.runtime.handler("dlg_p_dda_bb45537eefe5", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1209600) and ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) and (not ((H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_604824d886c4", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1209600) and (H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1))
end)

ccb.runtime.handler("dlg_p_dda_d98308d74f14", function(ctx)
    return ((H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1209600) and (not ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1))) and (not ((H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1))))
end)

ccb.runtime.handler("dlg_p_dda_ac36be63f1e3", function(ctx)
    return (H.global_var_num("hub01_told_u_about_warehouse_autodoc") == 1)
end)

ccb.runtime.handler("dlg_p_dda_361ee57aaaf3", function(ctx)
    return (H.global_var_num("HEW_lixa_data_sold") > 0)
end)

ccb.runtime.handler("dlg_p_dda_ca5cbcdbc6ec", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1") and H.char_has_items_sum(H.u(ctx), { { item = "bot_yrax_trifacet", amount = 1 } }))
end)

ccb.runtime.handler("dlg_p_dda_be7465adaf56", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP") and (H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1))
end)

ccb.runtime.handler("dlg_p_dda_f050b705a514", function(ctx)
    return (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI") and H.char_has_items_sum(H.u(ctx), { { item = "broken_exodii_worker", amount = 1 } }))
end)

ccb.runtime.handler("dlg_p_dda_37b4cd82ab6b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_MWS_1"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_mws_1", "")))))) and (H.var_num(H.u(ctx), "portal_storm_recordings_sold") >= 1))
end)

ccb.runtime.handler("dlg_p_dda_0a6e3394d56b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_mws_monster_corpse", "")))))) and (H.global_var_num("HEW_monster_corpse_data_sold") > 0))
end)

ccb.runtime.handler("dlg_p_dda_2cf035a086a1", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_IVAS"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_ivas", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_3", "")))) and (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_mws_4", "")))) or (H.var_num(H.u(ctx), "portal_storm_recordings_sold") > 2) or (H.global_var_num("ancilla_autodoc_placed") == 1)))
end)

ccb.runtime.handler("dlg_p_dda_4e2c00e5869b", function(ctx)
    return ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_lixa_sm_1", "")))))) and (not (((("no") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_lixa_sm_1", "")))))) and ((H.var_num(H.u(ctx), "portal_storm_recordings_sold") > 2) or (H.global_var_num("HEW_lixa_data_sold") > 0)))
end)

ccb.runtime.handler("dlg_p_dda_de25ca4967a5", function(ctx)
    return (((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_chop_shop", "")))))) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1))) and (H.global_var_num("hub01_stole_warehouse") == 1) and (not ((H.global_var_num("ancilla_autodoc_placed") == 1)))) or ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_chop_shop", "")))))) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1))) and (H.global_var_num("ancilla_fortress_placed") == 1) and (not ((H.global_var_num("ancilla_autodoc_placed") == 1)))))
end)

ccb.runtime.handler("dlg_p_dda_b6e5b246be96", function(ctx)
    return (((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_circuit_safari", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_robot_sm_1", "")))) and (H.global_var_num("hub01_stole_warehouse") == 1) and (H.global_var_num("hub01_told_u_about_warehouse") == 1) and (not ((H.global_var_num("ancilla_autodoc_placed") == 1)))) or ((not (H.char_has_mission(H.u(ctx), "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI"))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_circuit_safari", "")))))) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_intercom_completed_robofac_intercom_robot_sm_1", "")))) and (H.global_var_num("ancilla_fortress_placed") == 1) and (not ((H.global_var_num("ancilla_autodoc_placed") == 1)))))
end)

ccb.runtime.handler("dlg_p_dda_b386bedc4d2b", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_gun"), 1) >= 604800)
end)

ccb.runtime.handler("dlg_p_dda_e6b3652800e3", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(12), math.floor(0)) and (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_can_buy_armor") and 1 or 0))) and (H.global_var_num("hub01_uhmwpe_researched") == 1))
end)

ccb.runtime.handler("dlg_p_dda_07ee052fc1bb", function(ctx)
    return (H.var_num(H.u(ctx), "timer_hub_rnd_u_waiting_on_hub") < services.turn())
end)

ccb.runtime.handler("dlg_p_dda_7c999ab7cbdb", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "phase_suit_reverse_engineered") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_3b1a765dcf23", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(10), math.floor(0)) and (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "phase_suit_reverse_engineered") and 1 or 0)) or ((("yes") == (H.var_str("global", nil, ctx, "hub01_phase_suit_reverse_engineered", ""))))))
end)

ccb.runtime.handler("dlg_p_dda_40cd2f4cf3d5", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(12), math.floor(0)) and (not (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "phase_suit_reverse_engineered") and 1 or 0)))) and (not (((("yes") == (H.var_str("global", nil, ctx, "hub01_phase_suit_reverse_engineered", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_f22e5ca0a36c", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "rm13_reverse_engineered") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_6e3e9a555c13", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(10), math.floor(0)) and H.char_has_items(H.u(ctx), "rm13_battery", math.floor(1), math.floor(0)) and (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "rm13_reverse_engineered") and 1 or 0)) or ((("yes") == (H.var_str("global", nil, ctx, "hub01_rm13_reverse_engineered", ""))))))
end)

ccb.runtime.handler("dlg_p_dda_727ceaec8cd8", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(12), math.floor(0)) and H.char_has_items(H.u(ctx), "rm13_battery", math.floor(1), math.floor(0)) and (not (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "rm13_reverse_engineered") and 1 or 0)))) and (not (((("yes") == (H.var_str("global", nil, ctx, "hub01_rm13_reverse_engineered", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_d68c81abc701", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "combat_exoskeleton_reverse_engineered") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_c8e4d322606c", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(10), math.floor(0)) and (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "combat_exoskeleton_reverse_engineered") and 1 or 0)) or ((("yes") == (H.var_str("global", nil, ctx, "hub01_combat_exoskeleton_reverse_engineered", ""))))))
end)

ccb.runtime.handler("dlg_p_dda_6cb731e3bdd9", function(ctx)
    return (H.char_has_items(H.u(ctx), "RobofacCoin", math.floor(12), math.floor(0)) and (not (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "combat_exoskeleton_reverse_engineered") and 1 or 0)))) and (not (((("yes") == (H.var_str("global", nil, ctx, "hub01_combat_exoskeleton_reverse_engineered", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_479e16cc31b2", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_hub"), 1) >= 432000)
end)

ccb.runtime.handler("dlg_p_dda_6e573fdc7475", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_hub"), 1) >= 172800)
end)

ccb.runtime.handler("dlg_p_dda_2271d9d05c70", function(ctx)
    return (not H.truthy((H.var_exists("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik") and 1 or 0)))
end)

ccb.runtime.handler("dlg_p_dda_87d61a034b3e", function(ctx)
    return H.truthy((H.var_exists("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_dda_f6a45ea987e4", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_rnd_u_waiting_on_hub"), 1) >= 259200)
end)

ccb.runtime.handler("dlg_p_dda_516caf4fa5ec", function(ctx)
    return (H.char_has_items(H.u(ctx), "medium_printout_portal_storm_data", math.floor(1), math.floor(0)) and (H.global_var_num("portal_storm_medium_data_sold") < 15))
end)

ccb.runtime.handler("dlg_p_dda_2ac1991513ff", function(ctx)
    return (H.char_has_items(H.u(ctx), "small_printout_portal_storm_data", math.floor(1), math.floor(0)) and (H.global_var_num("portal_storm_medium_data_sold") < 15) and (H.global_var_num("portal_storm_small_data_sold") < 3))
end)

ccb.runtime.handler("dlg_p_dda_9ce50d3ad911", function(ctx)
    return (H.global_var_num("portal_storm_small_data_sold") >= 3)
end)

ccb.runtime.handler("dlg_p_dda_1bc8ba6fed47", function(ctx)
    return (H.global_var_num("portal_storm_medium_data_sold") >= 15)
end)

ccb.runtime.handler("dlg_p_dda_aac75cf8768a", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_portal", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_portal_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c2a99b57a75a", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_portal_storm", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_portal_storm_data_sold") < 15))
end)

ccb.runtime.handler("dlg_p_dda_d2f986e3ea6d", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_vitrified", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_vitrified_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_fa1a5afc547e", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_exodii", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_exodii_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_f1dd7b15c41d", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_strange_temple", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_temple_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_a157c71e578f", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_lixa", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_lixa_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c17431e270ac", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_highlands", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_highlands_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_b47377db4daf", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_labyrinth", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_labyrinth_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_0e0ef696abb0", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_physics_lab", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_physics_lab_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_25dafcc3ab88", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_amigara", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_amigara_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c93719a0ba1a", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_radiosphere", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_radiosphere_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_911ebc8a27b4", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_monster_corpse", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_monster_corpse_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_3cfc230a3afb", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_cabin_reverb", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_cabin_reverb_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_f15dff4d4a58", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_cabin_reverb_dimension", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_cabin_reverb_dimension_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_d7ee61bf7e06", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_barricaded_church", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_barricaded_church_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_6b0652c15d96", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_morgantown", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_morgantown_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c3dc3402ba5e", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_string_dimension", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_string_dimension_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_a3d245331fd2", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_spiral_mine", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_spiral_mine_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_ba009730232b", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_void_spider_lair", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_void_spider_lair_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_a417252a70db", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_portal_storm_dungeon", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_portal_storm_dungeon_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_fd7aecf5a7d0", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_inner_cabins_open_field", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_inner_cabins_alpha_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_c4801519cf29", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_inner_cabins_warped_cabin", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_inner_cabins_beta_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_7cf23cfab2c6", function(ctx)
    return (H.char_has_items(H.u(ctx), "HEW_printout_data_inner_cabins_home_cabin", math.floor(1), math.floor(0)) and (H.global_var_num("HEW_inner_cabins_gamma_data_sold") < 1))
end)

ccb.runtime.handler("dlg_p_dda_f5179cb22d81", function(ctx)
    return (H.global_var_num("HEW_portal_storm_data_sold") >= 15)
end)

ccb.runtime.handler("dlg_p_dda_2facb0b881bc", function(ctx)
    return (H.global_var_num("HEW_inner_cabins_data_sold") >= 2)
end)

ccb.runtime.handler("dlg_p_dda_bff2be0ec026", function(ctx)
    return (H.global_var_num("HEW_cabin_reverb_dimension_data_sold") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_ccdeb4054639", function(ctx)
    return H.char_has_bionic(H.u(ctx), "ANY")
end)

ccb.runtime.handler("dlg_p_dda_d84e565d8670", function(ctx)
    return (not (H.char_has_bionic(H.u(ctx), "ANY")))
end)

ccb.runtime.handler("dlg_p_dda_2a7e7eb6a6b0", function(ctx)
    return ((H.char_skill(H.u(ctx), "survival") >= 4) and (H.char_skill(H.u(ctx), "fabrication") >= 4) and ((("known") == (H.var_str("actor", H.u(ctx), ctx, "rootcellar_tacoma_bakery", "")))) and (not (((("helped") == (H.var_str("actor", H.npc(ctx), ctx, "rootcellar_tacoma_bakery", "")))))))
end)

ccb.runtime.handler("dlg_p_dda_9183061634b4", function(ctx)
    return (H.var_num(H.u(ctx), "hub01_completed_missions") >= 1)
end)

ccb.runtime.handler("dlg_p_dda_68153d1aa270", function(ctx)
    return ((H.char_skill(H.npc(ctx), "mechanics") >= 5) or (H.char_skill(H.npc(ctx), "electronics") >= 5))
end)

ccb.runtime.handler("dlg_p_dda_a8b242afed9f", function(ctx)
    return (not (((H.char_skill(H.npc(ctx), "mechanics") >= 5) or (H.char_skill(H.npc(ctx), "electronics") >= 5))))
end)

ccb.runtime.handler("dlg_a_dda_5c7b220017bf", function(ctx)
    H.consume_item(H.u(ctx), "usb_drive_nano", 1, 0)
    H.receive_item(H.u(ctx), "lixa_data", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_ccc2d6c9a534", function(ctx)
    H.receive_item(H.u(ctx), "marloss_berry", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_81754e5a66d5", function(ctx)
    H.lose_trait(H.u(ctx), "PROF_FED")
end)

ccb.runtime.handler("dlg_a_dda_50d73d468457", function(ctx)
    H.lose_trait(H.npc(ctx), "PROF_FED")
end)

ccb.runtime.handler("dlg_a_dda_3ffe591790ad", function(ctx)
    local _n1, _u2 = H.npc(ctx), H.u(ctx)
    if _n1 and _u2 then
        local _pay3 = services.trade.pay(_n1, _u2, math.floor(500))
        if _pay3.ok and _pay3.value == true then
            H.receive_item(_u2, "beer", 2, "bottle_glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_c17bb5b48c99", function(ctx)
    H.receive_item(H.u(ctx), "bottle_plastic", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_2a7fd01d93e5", function(ctx)
    local _n4, _u5 = H.npc(ctx), H.u(ctx)
    if _n4 and _u5 then services.trade.pay(_n4, _u5, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_5b6b079d9623", function(ctx)
    local _n6, _u7 = H.npc(ctx), H.u(ctx)
    if _n6 and _u7 then services.trade.pay(_n6, _u7, math.floor(1000)) end
    H.receive_item(H.u(ctx), "manual_speech", 1, nil)
    H.receive_item(H.u(ctx), "dnd_handbook", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_61f5fdbd8492", function(ctx)
    H.consume_item(H.npc(ctx), "beer", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_35a16c3a35d1", function(ctx)
    H.receive_item(H.u(ctx), "beer", 1, "bottle_glass")
end)

ccb.runtime.handler("dlg_a_dda_9f653c35ee47", function(ctx)
    H.consume_item(H.u(ctx), "beer", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_6ec52d7e8a4b", function(ctx)
    local _n8 = H.npc(ctx)
    local _cls9 = H.safe_id("npc_class", "NC_NONE")
    if _n8 and _cls9 then services.npcs.set_class(_n8, _cls9) end
end)

ccb.runtime.handler("dlg_a_dda_0800348406d2", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "test_var_time_test_test", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_251811359f38", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "test_var_time_test_test", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_a80805708528", function(ctx)
    local _n10, _u11 = H.npc(ctx), H.u(ctx)
    if _n10 and _u11 then services.trade.pay(_n10, _u11, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_6f2ec01fa962", function(ctx)
    local _n12, _u13 = H.npc(ctx), H.u(ctx)
    if _n12 and _u13 then services.trade.pay(_n12, _u13, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_aa997daca7f5", function(ctx)
    local _n14, _u15 = H.npc(ctx), H.u(ctx)
    if _n14 and _u15 then services.trade.pay(_n14, _u15, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_235092572aa0", function(ctx)
    local _n16, _u17 = H.npc(ctx), H.u(ctx)
    if _n16 and _u17 then services.trade.pay(_n16, _u17, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_592da6fe3d02", function(ctx)
    local _n18, _u19 = H.npc(ctx), H.u(ctx)
    if _n18 and _u19 then services.trade.pay(_n18, _u19, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_86691d1371f8", function(ctx)
    local _n20, _u21 = H.npc(ctx), H.u(ctx)
    if _n20 and _u21 then services.trade.pay(_n20, _u21, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_d43155ec8917", function(ctx)
    local _n22, _u23 = H.npc(ctx), H.u(ctx)
    if _n22 and _u23 then services.trade.pay(_n22, _u23, math.floor(1000)) end
end)

ccb.runtime.handler("dlg_a_dda_df5564bf69d7", function(ctx)
    local _n24, _u25 = H.npc(ctx), H.u(ctx)
    if _n24 and _u25 then services.trade.pay(_n24, _u25, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_be9ba3691f85", function(ctx)
    local _n26, _u27 = H.npc(ctx), H.u(ctx)
    if _n26 and _u27 then services.trade.pay(_n26, _u27, math.floor(250)) end
end)

ccb.runtime.handler("dlg_a_dda_05ace2c4f108", function(ctx)
    local _n28, _u29 = H.npc(ctx), H.u(ctx)
    if _n28 and _u29 then services.trade.pay(_n28, _u29, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_398033f945ab", function(ctx)
    local _n30, _u31 = H.npc(ctx), H.u(ctx)
    if _n30 and _u31 then services.trade.pay(_n30, _u31, math.floor(250)) end
end)

ccb.runtime.handler("dlg_a_dda_e027d7a1d297", function(ctx)
    local _n32, _u33 = H.npc(ctx), H.u(ctx)
    if _n32 and _u33 then services.trade.pay(_n32, _u33, math.floor(500)) end
end)

ccb.runtime.handler("dlg_a_dda_61bf0c87d3ec", function(ctx)
    H.mapgen_update(H.npc(ctx), "faction_wall_level_N_0", nil, true, 0, 0, 0)
end)

ccb.runtime.handler("dlg_a_dda_d0e782f9bda5", function(ctx)
    H.mapgen_update(H.npc(ctx), "faction_wall_level_E_0", nil, true, 0, 1, 0)
    H.mapgen_update(H.npc(ctx), "faction_wall_level_W_0", nil, true, 1, 0, 0)
end)

ccb.runtime.handler("dlg_a_dda_a474cd6dbb19", function(ctx)
    H.mapgen_update_list(H.npc(ctx), { "faction_wall_level_S_1", "faction_wall_level_N_1" }, nil, true, 0, -1, 0)
end)

ccb.runtime.handler("dlg_a_dda_ba7d9970962a", function(ctx)
    H.set_var("global", nil, ctx, "key1", (ctx:topic_item() or ""))
end)

ccb.runtime.handler("dlg_a_dda_59e0479701fb", function(ctx)
    local _n34, _u35 = H.npc(ctx), H.u(ctx)
    if _n34 and _u35 then services.trade.pay(_n34, _u35, math.floor(100000)) end
end)

ccb.runtime.handler("dlg_a_dda_5f087cab1ae3", function(ctx)
    H.receive_item(H.u(ctx), "survivormap", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_81e6145c1e01", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "time_survivors_wait", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_a7048e987687", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "count_cleaning_lighthouse_man", (H.var_num(H.npc(ctx), "count_cleaning_lighthouse_man")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_796e46b31c4a", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "time_lighthouse_wait", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_5aa3e3b65e71", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "balthazar_small_rewards", (H.var_num(H.u(ctx), "balthazar_small_rewards")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_d6b240115975", function(ctx)
    H.receive_group(H.u(ctx), "nested_m4_carbine", 1)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "ground_solar_panel", amount = 12 } })
end)

ccb.runtime.handler("dlg_a_dda_2ac011cb8367", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "balthazar_medium_rewards", (H.var_num(H.u(ctx), "balthazar_medium_rewards")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_fcbb73a97021", function(ctx)
    H.receive_group(H.u(ctx), "guns_rifle_milspec", 2)
    H.receive_item(H.u(ctx), "stanag30", 2, nil)
    H.receive_group(H.u(ctx), "MRE", 5)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "ground_solar_panel", amount = 12 } })
end)

ccb.runtime.handler("dlg_a_dda_c677088fadf6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "balthazar_big_rewards", (H.var_num(H.u(ctx), "balthazar_big_rewards")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_395bc59621fd", function(ctx)
    H.receive_group(H.u(ctx), "guns_rifle_milspec", 2)
    H.receive_item(H.u(ctx), "stanag30", 2, nil)
    H.receive_group(H.u(ctx), "MRE", 5)
    H.receive_item(H.u(ctx), "bot_grenade_hack", 1, nil)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "ground_solar_panel", amount = 12 } })
end)

ccb.runtime.handler("dlg_a_dda_ad980b24ebca", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "negotiated_balthazar_solar", 1)
end)

ccb.runtime.handler("dlg_a_dda_48f3c26bafa2", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "negotiated_balthazar_solar", 2)
end)

ccb.runtime.handler("dlg_a_dda_219009214fa4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "knowns_control_center_balthazar", 1)
end)

ccb.runtime.handler("dlg_a_dda_cfe8d38967d1", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "negotiated_balthazar_solar", 3)
end)

ccb.runtime.handler("dlg_a_dda_22a5bb9a10f5", function(ctx)
    H.lose_trait(H.npc(ctx), "RETURN_TO_START_POS")
    H.lose_trait(H.npc(ctx), "NO_BASH")
    H.lose_trait(H.npc(ctx), "IGNORE_SOUND")
end)

ccb.runtime.handler("dlg_a_dda_bf9db73e0c3c", function(ctx)
    local _n36 = H.npc(ctx)
    if _n36 then services.npcs.add_faction_rep(_n36, math.floor(-2)) end
end)

ccb.runtime.handler("dlg_a_dda_f10f6ee920dd", function(ctx)
    local _n37 = H.npc(ctx)
    if _n37 then services.npcs.add_faction_rep(_n37, math.floor(-75)) end
end)

ccb.runtime.handler("dlg_a_dda_e9283e68fc6a", function(ctx)
    local _n38 = H.npc(ctx)
    if _n38 then services.npcs.add_faction_rep(_n38, math.floor(-1)) end
end)

ccb.runtime.handler("dlg_a_dda_2a428b0a450a", function(ctx)
    local _n39 = H.npc(ctx)
    if _n39 then services.npcs.add_faction_rep(_n39, math.floor(-15)) end
end)

ccb.runtime.handler("dlg_a_dda_f3817b1673db", function(ctx)
    local _n40 = H.npc(ctx)
    if _n40 then services.npcs.add_faction_rep(_n40, math.floor(-5)) end
end)

ccb.runtime.handler("dlg_a_dda_5052c3e074b4", function(ctx)
    H.set_var("global", nil, ctx, "find_refugee_center", 1)
end)

ccb.runtime.handler("dlg_a_dda_33a0dce1e002", function(ctx)
    H.receive_item(H.u(ctx), "schematics_secubot", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_da0c407d533c", function(ctx)
    H.consume_item(H.u(ctx), "usb_drive_nano", 1, 0)
    H.receive_group(H.u(ctx), "mission_science_rep_2_secure_usb_download", 1)
end)

ccb.runtime.handler("dlg_a_dda_43677bf6ed9b", function(ctx)
    H.consume_item(H.u(ctx), "usb_drive_nano", 1, 0)
    H.receive_group(H.u(ctx), "mission_science_rep_3_secure_usb_download", 1)
end)

ccb.runtime.handler("dlg_a_dda_381a2ebd1766", function(ctx)
    H.consume_item(H.u(ctx), "usb_drive_nano", 1, 0)
    H.receive_group(H.u(ctx), "mission_science_rep_4_secure_usb_download", 1)
end)

ccb.runtime.handler("dlg_a_dda_22362a6fdec4", function(ctx)
    H.consume_item(H.u(ctx), "usb_drive_nano", 1, 0)
    H.receive_group(H.u(ctx), "mission_science_rep_5_secure_usb_download", 1)
end)

ccb.runtime.handler("dlg_a_dda_399f0cdb5f50", function(ctx)
    H.set_var("global", nil, ctx, "exodii_mission_wh_chance", (H.global_var_num("exodii_mission_wh_chance")) - (1))
    H.set_var("global", nil, ctx, "exodii_mission_wh_chance", math.max(H.global_var_num("exodii_mission_wh_chance"), 1))
end)

ccb.runtime.handler("dlg_a_dda_7e3dd5075416", function(ctx)
    local _sw41 = services.random.native_float(1, 3)
    if _sw41 == 1 then
        local _n42, _u43 = H.npc(ctx), H.u(ctx)
        local _mg44 = H.safe_id("mission", "mission_exodii_wh_bad_directions1")
        if _n42 and _u43 and _mg44 then services.npcs.missions.assign(_n42, _u43, _mg44) end
    elseif _sw41 == 2 then
        local _n45, _u46 = H.npc(ctx), H.u(ctx)
        local _mg47 = H.safe_id("mission", "mission_exodii_wh_bad_directions2")
        if _n45 and _u46 and _mg47 then services.npcs.missions.assign(_n45, _u46, _mg47) end
    elseif _sw41 == 3 then
        local _n48, _u49 = H.npc(ctx), H.u(ctx)
        local _mg50 = H.safe_id("mission", "mission_exodii_wh_bad_directions3")
        if _n48 and _u49 and _mg50 then services.npcs.missions.assign(_n48, _u49, _mg50) end
    end
end)

ccb.runtime.handler("dlg_a_dda_1b60f4c40dad", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_meeting_luliya_music_timer", services.turn())
    H.lose_trait(H.npc(ctx), "NPC_STASIS")
end)

ccb.runtime.handler("dlg_a_dda_b37aabecb038", function(ctx)
    H.add_morale(H.u(ctx), "morale_music", 5, 10, nil, nil)
    local _s51 = H.char_snap(H.u(ctx))
    if _s51 and _s51.creature then services.sound.emit(_s51.creature.position, math.floor(10), "music", ctx:expand_text(services.translate("music")), false) end
end)

ccb.runtime.handler("dlg_a_dda_e3d719172842", function(ctx)
    H.set_var("global", nil, ctx, "exodii_knows_hub01", 1)
end)

ccb.runtime.handler("dlg_a_dda_13efa4e52843", function(ctx)
    local _n52, _u53 = H.npc(ctx), H.u(ctx)
    if _n52 and _u53 then services.trade.pay(_n52, _u53, math.floor(-50000)) end
end)

ccb.runtime.handler("dlg_a_dda_c9b772244028", function(ctx)
    H.set_var("global", nil, ctx, "know_jaryi", 1)
end)

ccb.runtime.handler("dlg_a_dda_d05d0c5b676b", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_GENERIC_EOC", 600)
end)

ccb.runtime.handler("dlg_a_dda_6a114d22da22", function(ctx)
    H.set_var("global", nil, ctx, "exodii_knows_u_double_crossed", 1)
end)

ccb.runtime.handler("dlg_a_dda_eb9951a4ce11", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_purifier")
end)

ccb.runtime.handler("dlg_a_dda_ab4fcf6183c6", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_blood_anal")
end)

ccb.runtime.handler("dlg_a_dda_b9aab0564e57", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_radscrubber")
end)

ccb.runtime.handler("dlg_a_dda_9aa5aeb741c9", function(ctx)
    local _n54, _u55 = H.npc(ctx), H.u(ctx)
    if _n54 and _u55 then services.trade.pay(_n54, _u55, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_cdaebc5e6ffd", function(ctx)
    local _n56, _u57 = H.npc(ctx), H.u(ctx)
    if _n56 and _u57 then services.trade.pay(_n56, _u57, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_b40d86db77e7", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special_id = "exodii_base", search_range = 250 }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = 250 })
    local _a59 = H.u(ctx)
    local _pos58 = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc")
    if _a59 and _pos58 then services.relocation.teleport_character(_a59, _pos58, nil) end
end)

ccb.runtime.handler("dlg_a_dda_435a1df53793", function(ctx)
    local _n60, _u61 = H.npc(ctx), H.u(ctx)
    if _n60 and _u61 then services.trade.pay(_n60, _u61, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_4b8688f52f05", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_eye_enhancer")
end)

ccb.runtime.handler("dlg_a_dda_6d1032b61ca8", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_str_enhancer")
end)

ccb.runtime.handler("dlg_a_dda_2752f0af69e9", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_int_enhancer")
end)

ccb.runtime.handler("dlg_a_dda_6968b05d882b", function(ctx)
    local _n62, _u63 = H.npc(ctx), H.u(ctx)
    if _n62 and _u63 then services.trade.pay(_n62, _u63, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_8e2f3cd3d303", function(ctx)
    local _n64, _u65 = H.npc(ctx), H.u(ctx)
    if _n64 and _u65 then services.trade.pay(_n64, _u65, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_a6cbeb01e188", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special_id = "exodii_base", search_range = 250 }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = 250 })
    local _a67 = H.u(ctx)
    local _pos66 = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc")
    if _a67 and _pos66 then services.relocation.teleport_character(_a67, _pos66, nil) end
end)

ccb.runtime.handler("dlg_a_dda_cf641f8b6e7e", function(ctx)
    local _n68, _u69 = H.npc(ctx), H.u(ctx)
    if _n68 and _u69 then services.trade.pay(_n68, _u69, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_c5a3adb40afa", function(ctx)
    H.receive_item(H.u(ctx), "exodii_portable_tv", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4b6b808ad998", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special_id = "exodii_base", search_range = 250 }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = 250 })
    local _a71 = H.u(ctx)
    local _pos70 = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc")
    if _a71 and _pos70 then services.relocation.teleport_character(_a71, _pos70, nil) end
end)

ccb.runtime.handler("dlg_a_dda_ab5ed3715805", function(ctx)
    local _n72, _u73 = H.npc(ctx), H.u(ctx)
    if _n72 and _u73 then services.trade.pay(_n72, _u73, math.floor(-250000)) end
end)

ccb.runtime.handler("dlg_a_dda_ff7fed64ffd0", function(ctx)
    local _n74, _u75 = H.npc(ctx), H.u(ctx)
    if _n74 and _u75 then services.trade.pay(_n74, _u75, math.floor(-100000)) end
end)

ccb.runtime.handler("dlg_a_dda_574864f90d13", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_teleport")
end)

ccb.runtime.handler("dlg_a_dda_1204c1f36db7", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_time_freeze")
end)

ccb.runtime.handler("dlg_a_dda_b700a894f435", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_probability_travel")
end)

ccb.runtime.handler("dlg_a_dda_2d750802791c", function(ctx)
    local _n76, _u77 = H.npc(ctx), H.u(ctx)
    if _n76 and _u77 then services.trade.pay(_n76, _u77, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_0d001ec716bc", function(ctx)
    local _n78, _u79 = H.npc(ctx), H.u(ctx)
    if _n78 and _u79 then services.trade.pay(_n78, _u79, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_598c69d2b0a0", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special_id = "exodii_base", search_range = 250 }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = 250 })
    local _a81 = H.u(ctx)
    local _pos80 = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc")
    if _a81 and _pos80 then services.relocation.teleport_character(_a81, _pos80, nil) end
end)

ccb.runtime.handler("dlg_a_dda_bfd095415577", function(ctx)
    local _n82, _u83 = H.npc(ctx), H.u(ctx)
    if _n82 and _u83 then services.trade.pay(_n82, _u83, math.floor(-150000)) end
end)

ccb.runtime.handler("dlg_a_dda_88ab5cdd0752", function(ctx)
    local _a84 = H.npc(ctx)
    if _a84 then services.npcs.modify_opinion(_a84, { sold = math.floor(-(20)) }) end
end)

ccb.runtime.handler("dlg_a_dda_ca47b5501c73", function(ctx)
    H.set_var("global", nil, ctx, "warehouse_was_found", 1)
end)

ccb.runtime.handler("dlg_a_dda_d1be8bff804a", function(ctx)
    H.consume_item(H.u(ctx), "exodii_chop_shop_head", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_cac82ea89c70", function(ctx)
    H.consume_item(H.u(ctx), "exodii_usb_stick_full", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_fa45b3adc710", function(ctx)
    H.receive_group(H.u(ctx), "bionics_pulled_out_prototype", 1)
    H.spawn_npc(H.u(ctx), "BEM_prototype_cyborg_with_yonked_bionics", { min_radius = math.floor(1), max_radius = math.floor(3), outdoor_only = false }, "Rubik leads a person to you.")
end)

ccb.runtime.handler("dlg_a_dda_441dbf0d2d0d", function(ctx)
    H.spawn_npc(H.u(ctx), "BEM_prototype_cyborg_with_bionics", { min_radius = math.floor(1), max_radius = math.floor(3), outdoor_only = false }, "Rubik leads a person to you.")
end)

ccb.runtime.handler("dlg_a_dda_ba9865e060b2", function(ctx)
    H.spawn_npc(H.u(ctx), "BEM_prototype_cyborg_with_yonked_bionics", { min_radius = math.floor(1), max_radius = math.floor(3), outdoor_only = false }, "Rubik leads a person to you.")
end)

ccb.runtime.handler("dlg_a_dda_32d0bdeebb48", function(ctx)
    H.receive_item(H.u(ctx), "ruined_chunks", 20, nil)
    H.receive_group(H.u(ctx), "bionics_pulled_out_prototype", 1)
end)

ccb.runtime.handler("dlg_a_dda_c0c90eb7d35f", function(ctx)
    H.receive_item(H.u(ctx), "corpse_generic_human", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_2172f5c1c7c0", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n85, _u86 = H.npc(ctx), H.u(ctx)
    if _n85 and _u86 then services.trade.pay(_n85, _u86, math.floor(30000)) end
end)

ccb.runtime.handler("dlg_a_dda_822f4d122b5f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_exodii_cybor_rescue_operating", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_04c92d015381", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n87, _u88 = H.npc(ctx), H.u(ctx)
    if _n87 and _u88 then services.trade.pay(_n87, _u88, math.floor(20000)) end
end)

ccb.runtime.handler("dlg_a_dda_f11832a75b0b", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n89, _u90 = H.npc(ctx), H.u(ctx)
    if _n89 and _u90 then services.trade.pay(_n89, _u90, math.floor(9500)) end
end)

ccb.runtime.handler("dlg_a_dda_fbd68f46e57c", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n91, _u92 = H.npc(ctx), H.u(ctx)
    if _n91 and _u92 then services.trade.pay(_n91, _u92, math.floor(-20000)) end
end)

ccb.runtime.handler("dlg_a_dda_53c8e22fd393", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n93, _u94 = H.npc(ctx), H.u(ctx)
    if _n93 and _u94 then services.trade.pay(_n93, _u94, math.floor(20000)) end
end)

ccb.runtime.handler("dlg_a_dda_d71efea66826", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n95, _u96 = H.npc(ctx), H.u(ctx)
    if _n95 and _u96 then services.trade.pay(_n95, _u96, math.floor(2500)) end
end)

ccb.runtime.handler("dlg_a_dda_99d373d5ee50", function(ctx)
    H.consume_item(H.u(ctx), "bot_prototype_cyborg", 1, 0)
    local _n97, _u98 = H.npc(ctx), H.u(ctx)
    if _n97 and _u98 then services.trade.pay(_n97, _u98, math.floor(-15000)) end
end)

ccb.runtime.handler("dlg_a_dda_f3ca9f11fc01", function(ctx)
    H.receive_item(H.u(ctx), "rubik_farthing", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_d62a3b691c5f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_exodii_exodii_psychosis_judgment", (H.var_num(H.u(ctx), "counter_exodii_exodii_psychosis_judgment")) + (2))
end)

ccb.runtime.handler("dlg_a_dda_93f3ca32d409", function(ctx)
    H.receive_item(H.u(ctx), "armor_riot", 5, nil)
    H.receive_item(H.u(ctx), "helmet_riot", 5, nil)
    H.receive_item(H.u(ctx), "armor_riot_arm", 5, nil)
    H.receive_item(H.u(ctx), "armor_riot_leg", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_cf12cf160f61", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 7200)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_cable")
end)

ccb.runtime.handler("dlg_a_dda_0ee4f18310e0", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 1800)
    H.add_bionic(H.u(ctx), "bio_power_storage_mkII")
end)

ccb.runtime.handler("dlg_a_dda_9910aee7f205", function(ctx)
    local _n99, _u100 = H.npc(ctx), H.u(ctx)
    if _n99 and _u100 then services.trade.pay(_n99, _u100, math.floor(-40000)) end
end)

ccb.runtime.handler("dlg_a_dda_0ef3f45fa682", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_exodii_exodii_psychosis_judgment", (H.var_num(H.u(ctx), "counter_exodii_exodii_psychosis_judgment")) - (2))
end)

ccb.runtime.handler("dlg_a_dda_7e656488b422", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_blobpsychosis_u_declined_exodization", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_dd8915c46668", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "exodii_autodoc_couch_loc", { terrain = "exodii_base_x2y1z1" }, { special_id = "exodii_base", search_range = 250 }, { kind = "furniture", id = H.safe_id("furniture", "f_autodoc_couch") }, { target_max_radius = 250 })
    local _a102 = H.u(ctx)
    local _pos101 = H.get_tripoint_var("actor", H.u(ctx), ctx, "exodii_autodoc_couch_loc")
    if _a102 and _pos101 then services.relocation.teleport_character(_a102, _pos101, nil) end
end)

ccb.runtime.handler("dlg_a_dda_24c42f18ee3c", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 7200)
end)

ccb.runtime.handler("dlg_a_dda_95371a187a54", function(ctx)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_cable")
end)

ccb.runtime.handler("dlg_a_dda_fed44208bf32", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_exodii_exodii_psychosis_judgment", (H.var_num(H.u(ctx), "counter_exodii_exodii_psychosis_judgment")) + (4))
end)

ccb.runtime.handler("dlg_a_dda_b2da7a0b0214", function(ctx)
    H.set_var("global", nil, ctx, "labyrinth_access_points", 1)
end)

ccb.runtime.handler("dlg_a_dda_b66461188429", function(ctx)
    H.receive_item(H.u(ctx), "exodii_wrist_computer", 1, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Rubik shows you how to operate the Exodii wrist computer.  Turn it on, and leave it on, to run the \"wobble door scanner\" -- some sort of program that tries to locate Labyrinths, through some unknown dimension in space.  Who knows where you may find them?")))
end)

ccb.runtime.handler("dlg_a_dda_f8667a737fe5", function(ctx)
    local _a103 = H.u(ctx)
    local _vg104 = H.safe_id("vitamin", "blood")
    if _a103 and _vg104 then services.needs.modify_vitamin(_a103, _vg104, math.floor(-(6250))) end
    local _a105 = H.u(ctx)
    local _vg106 = H.safe_id("vitamin", "redcells")
    if _a105 and _vg106 then services.needs.modify_vitamin(_a105, _vg106, math.floor(-(6250))) end
    H.find_and_store_loc(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil)
    local _pos107 = H.get_tripoint_var("context", nil, ctx, "loc")
    if _pos107 then services.overmap.reveal_native(_pos107:project_to("omt"), math.floor(30)) end
    services.messages.add(ctx:expand_text(services.translate("You place your hand on the stone.  There is a pinch, then a wet, mechanical hiss, as something draws a lot of blood.  The terminal immediately displays a topological map of the surrounding labyrinthian structures.")), "neutral")
end)

ccb.runtime.handler("dlg_a_dda_a367c3d39b59", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_door_requests", 1)
end)

ccb.runtime.handler("dlg_a_dda_d9abc3d845b3", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_door_requests", (H.var_num(H.npc(ctx), "LS_door_requests")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_3844a4c79ca6", function(ctx)
    local _a108 = H.u(ctx)
    local _vg109 = H.safe_id("vitamin", "blood")
    if _a108 and _vg109 then services.needs.modify_vitamin(_a108, _vg109, math.floor(-((-12500)))) end
    local _a110 = H.u(ctx)
    local _vg111 = H.safe_id("vitamin", "redcells")
    if _a110 and _vg111 then services.needs.modify_vitamin(_a110, _vg111, math.floor(-((-12500)))) end
    H.set_var("actor", H.npc(ctx), ctx, "LS_door_requests", (H.var_num(H.npc(ctx), "LS_door_requests")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_b9e11b3b4756", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_bridge_requests", 1)
    H.lose_trait(H.u(ctx), "LS_Passcode_0")
end)

ccb.runtime.handler("dlg_a_dda_6015d8edf9b2", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_bridge_requests", 1)
    H.lose_trait(H.u(ctx), "LS_Passcode_1")
end)

ccb.runtime.handler("dlg_a_dda_511bfe0a2f04", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_bridge_requests", 1)
    H.lose_trait(H.u(ctx), "LS_Passcode_2")
end)

ccb.runtime.handler("dlg_a_dda_fae4b4269f34", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_bridge_requests", 1)
    H.lose_trait(H.u(ctx), "LS_Passcode_3")
end)

ccb.runtime.handler("dlg_a_dda_bbdf5436f867", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "LS_bridge_requests", 2)
end)

ccb.runtime.handler("dlg_a_dda_eee2a7701d07", function(ctx)
    local _a112 = H.u(ctx)
    local _vg113 = H.safe_id("vitamin", "blood")
    if _a112 and _vg113 then services.needs.modify_vitamin(_a112, _vg113, math.floor(-(500))) end
    local _a114 = H.u(ctx)
    local _vg115 = H.safe_id("vitamin", "redcells")
    if _a114 and _vg115 then services.needs.modify_vitamin(_a114, _vg115, math.floor(-(500))) end
end)

ccb.runtime.handler("dlg_a_dda_78acb5e38a82", function(ctx)
    local _a116 = H.u(ctx)
    local _vg117 = H.safe_id("vitamin", "blood")
    if _a116 and _vg117 then services.needs.modify_vitamin(_a116, _vg117, math.floor(-(250))) end
    local _a118 = H.u(ctx)
    local _vg119 = H.safe_id("vitamin", "redcells")
    if _a118 and _vg119 then services.needs.modify_vitamin(_a118, _vg119, math.floor(-(250))) end
end)

ccb.runtime.handler("dlg_a_dda_2382c546991c", function(ctx)
    H.consume_item(H.u(ctx), "exodii_usb_stick", 1, 0)
    H.receive_item(H.u(ctx), "exodii_usb_stick_full", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4410e4b406f7", function(ctx)
    H.set_var("global", nil, ctx, "string_dimension_flipped_switched", 1)
    H.transform_radius(H.u(ctx), 2, "ter_local_sd_distress_beacon_1")
end)

ccb.runtime.handler("dlg_a_dda_604b9f532b04", function(ctx)
    H.set_var("global", nil, ctx, "string_dimension_flipped_switched", 2)
    H.transform_radius(H.u(ctx), 2, "ter_local_sd_distress_beacon_2")
end)

ccb.runtime.handler("dlg_a_dda_b8f9bf4cb80b", function(ctx)
    H.set_var("global", nil, ctx, "string_dimension_flipped_switched", 3)
    H.transform_radius(H.u(ctx), 2, "ter_local_sd_distress_beacon_3")
end)

ccb.runtime.handler("dlg_a_dda_b3da69c687e2", function(ctx)
    H.transform_radius(H.u(ctx), 2, "ter_local_sd_distress_beacon_3")
end)

ccb.runtime.handler("dlg_a_dda_e1af90ce9574", function(ctx)
    local _n120 = H.npc(ctx)
    if _n120 then services.npcs.modify_opinion(_n120, { value = math.floor(1) }) end
end)

ccb.runtime.handler("dlg_a_dda_4e9bbce8c9e2", function(ctx)
    H.receive_item(H.u(ctx), "long_knit_scarf", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_a026e5b0762a", function(ctx)
    H.receive_item(H.u(ctx), "blanket", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_cae2469c91fb", function(ctx)
    H.receive_item(H.u(ctx), "quilt", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_d384e3101085", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_trade_knitting", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_bc30246b108a", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_knitting", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_7ce525ad4b34", function(ctx)
    H.receive_item(H.u(ctx), "jerky", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_a4b64a894b0d", function(ctx)
    H.receive_item(H.u(ctx), "egg_chicken", 12, nil)
end)

ccb.runtime.handler("dlg_a_dda_6c850cbcb4f3", function(ctx)
    H.receive_item(H.u(ctx), "seed_cucumber", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_e3e9d30006d6", function(ctx)
    H.receive_item(H.u(ctx), "seed_barley", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_d8dfb1090c0c", function(ctx)
    H.receive_item(H.u(ctx), "seed_blackberries", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_c60894d72732", function(ctx)
    H.receive_item(H.u(ctx), "seed_carrot", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_24f8b2f15533", function(ctx)
    H.receive_item(H.u(ctx), "seed_buckwheat", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_bd6e4ac73144", function(ctx)
    H.receive_item(H.u(ctx), "seed_cranberries", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_194ff38eda8d", function(ctx)
    H.receive_item(H.u(ctx), "seed_oats", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_3131e9fb995f", function(ctx)
    H.receive_item(H.u(ctx), "seed_sugar_beet", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_c048c0261c0a", function(ctx)
    H.receive_item(H.u(ctx), "seed_potato_raw", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_cebc6d85dfd0", function(ctx)
    H.receive_item(H.u(ctx), "book_fict_soft_docu_AWT", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_5b6141887928", function(ctx)
    H.receive_item(H.u(ctx), "icon", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_1af3223913ba", function(ctx)
    H.receive_item(H.u(ctx), "icon", 5, nil)
    H.assign_activity(H.u(ctx), "ACT_WAIT_NPC", 1800)
end)

ccb.runtime.handler("dlg_a_dda_7cc77414dbc2", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_GENERIC_GAME", 2700)
end)

ccb.runtime.handler("dlg_a_dda_5e691b19a919", function(ctx)
    H.receive_item(H.u(ctx), "icon", 4, nil)
end)

ccb.runtime.handler("dlg_a_dda_bdc407533a0b", function(ctx)
    local _u121, _n122 = H.u(ctx), H.npc(ctx)
    if _u121 and _n122 then services.characters.set_faction_relationship(_u121, _n122, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_f8bf9c2ba3b5", function(ctx)
    local _n123 = H.npc(ctx)
    if _n123 then services.npcs.modify_opinion(_n123, { anger = math.floor(1) }) end
end)

ccb.runtime.handler("dlg_a_dda_517739bde778", function(ctx)
    H.learn_recipe(H.u(ctx), "pine_tea")
    ccb.presentation.notice(ctx:expand_text(services.translate("You learn how to craft pine tea.")))
    H.receive_item(H.u(ctx), "pine_tea", 1, "bottle_plastic")
end)

ccb.runtime.handler("dlg_a_dda_1164db67331e", function(ctx)
    H.receive_item(H.u(ctx), "tshirt", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_35cbaacd9e02", function(ctx)
    H.receive_item(H.u(ctx), "pants", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_ffd8e3ec9202", function(ctx)
    H.receive_item(H.u(ctx), "jacket_leather", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_7cc387b0bfbd", function(ctx)
    H.receive_item(H.u(ctx), "dress", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_a20b6c27cb1c", function(ctx)
    H.receive_item(H.u(ctx), "duster", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_a855c3058f95", function(ctx)
    H.receive_item(H.u(ctx), "trenchcoat", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4565df971ccb", function(ctx)
    H.receive_item(H.u(ctx), "backpack", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_c809816b2535", function(ctx)
    H.receive_item(H.u(ctx), "gambeson", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_cf8715923c26", function(ctx)
    H.receive_item(H.u(ctx), "leather_pouch", 4, nil)
end)

ccb.runtime.handler("dlg_a_dda_8e7f02feef9a", function(ctx)
    H.receive_item(H.u(ctx), "pants_leather", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_ce0f31c5a4db", function(ctx)
    H.receive_item(H.u(ctx), "cloak_leather", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_affaa2da3c28", function(ctx)
    H.receive_item(H.u(ctx), "leather_police_jacket", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_9bf56bd8a629", function(ctx)
    H.receive_item(H.u(ctx), "armor_larmor", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_da267392f0c1", function(ctx)
    H.receive_item(H.u(ctx), "meat_smoked", 3, nil)
end)

ccb.runtime.handler("dlg_a_dda_fa9ebfeb6877", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_GENERIC_EOC", 240)
    H.add_morale(H.u(ctx), "morale_feeling_good", 20, 20, 600, 600)
end)

ccb.runtime.handler("dlg_a_dda_d450420170b3", function(ctx)
    H.receive_item(H.u(ctx), "macaroni_helper", 1, "can_food")
    H.receive_item(H.u(ctx), "toast", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_71e2f9ff2d65", function(ctx)
    local _n124 = H.npc(ctx)
    if _n124 then services.npcs.modify_opinion(_n124, { anger = math.floor(1) }) end
end)

ccb.runtime.handler("dlg_a_dda_8dfe391a29e6", function(ctx)
    local _n125 = H.npc(ctx)
    if _n125 then services.npcs.modify_opinion(_n125, { anger = math.floor(2) }) end
end)

ccb.runtime.handler("dlg_a_dda_5ebf903ac122", function(ctx)
    H.receive_item(H.u(ctx), "can_beans", 1, "can_medium")
    H.receive_item(H.u(ctx), "water_clean", 2, "bottle_plastic")
end)

ccb.runtime.handler("dlg_a_dda_5dbea276c605", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_trade_fixing_records", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_120c74150ad9", function(ctx)
    H.receive_item(H.u(ctx), "godcotrader_accounting_records_dirty", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_2effb650b682", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 50, nil)
end)

ccb.runtime.handler("dlg_a_dda_ae8215ae9312", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_barry_rescue", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_0f0f5ab4b53f", function(ctx)
    H.set_var("global", nil, ctx, "barry_PTSD_freakouts", (H.global_var_num("barry_PTSD_freakouts")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_6a23459ec0bd", function(ctx)
    H.set_var("global", nil, ctx, "npc_timer_thinking_about_plan", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_ccd3f3c98ae9", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 1)
end)

ccb.runtime.handler("dlg_a_dda_f193e384473c", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_family_coming", 0)
end)

ccb.runtime.handler("dlg_a_dda_ac36764419c7", function(ctx)
    H.consume_item(H.u(ctx), "armor_riot", 1, 0)
    H.set_var("global", nil, ctx, "isherwood_gear_retrival_armor_body_count", (H.global_var_num("isherwood_gear_retrival_armor_body_count")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_5bcc06cfd5dd", function(ctx)
    H.consume_item(H.u(ctx), "helmet_riot", 1, 0)
    H.set_var("global", nil, ctx, "isherwood_gear_retrival_helmet_count", (H.global_var_num("isherwood_gear_retrival_helmet_count")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_a11617c84486", function(ctx)
    H.consume_item(H.u(ctx), "armor_riot_arm", 1, 0)
    H.set_var("global", nil, ctx, "isherwood_gear_retrival_armor_arm_count", (H.global_var_num("isherwood_gear_retrival_armor_arm_count")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_e5ad87d70cd3", function(ctx)
    H.consume_item(H.u(ctx), "armor_riot_leg", 1, 0)
    H.set_var("global", nil, ctx, "isherwood_gear_retrival_armor_leg_count", (H.global_var_num("isherwood_gear_retrival_armor_leg_count")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_4a6eb839c8e7", function(ctx)
    H.set_var("global", nil, ctx, "isherwood_lisa_coming", 1)
end)

ccb.runtime.handler("dlg_a_dda_5c74191e029c", function(ctx)
    H.receive_item(H.u(ctx), "id_artisan_member", 1, nil)
    local _u126, _n127 = H.u(ctx), H.npc(ctx)
    if _u126 and _n127 then services.characters.set_faction_relationship(_u126, _n127, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_01edabb98966", function(ctx)
    H.receive_item(H.u(ctx), "trade_writ", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_b93f2c539aff", function(ctx)
    H.receive_item(H.u(ctx), "id_artisan_member", 1, nil)
    local _u128, _n129 = H.u(ctx), H.npc(ctx)
    if _u128 and _n129 then services.characters.set_faction_relationship(_u128, _n129, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_db2166a6ab20", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_thickness", 1.2)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_armor_cost", 350)
end)

ccb.runtime.handler("dlg_a_dda_97b074dc81c4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_thickness", 2)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_armor_cost", 400)
end)

ccb.runtime.handler("dlg_a_dda_3786795f0a8c", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_thickness", 4)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_armor_cost", 500)
end)

ccb.runtime.handler("dlg_a_dda_0cd5a7b2ebaa", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_thickness", 6)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_armor_cost", 600)
end)

ccb.runtime.handler("dlg_a_dda_bde9f93a7629", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_wait", 3)
end)

ccb.runtime.handler("dlg_a_dda_ca27ab412f95", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_wait", 4)
end)

ccb.runtime.handler("dlg_a_dda_316a3462afa6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_wait", 5)
end)

ccb.runtime.handler("dlg_a_dda_5861f17f7748", function(ctx)
    H.transfer_item(H.u(ctx), H.npc(ctx), "FMCNote", H.var_num(H.u(ctx), "number_artisans_blacksmith_armor_cost"))
end)

ccb.runtime.handler("dlg_a_dda_40a7125572e6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_armor", services.turn())
    H.assign_activity(H.u(ctx), "ACT_MEASURE", 600)
end)

ccb.runtime.handler("dlg_a_dda_eea221b4f115", function(ctx)
    local _sw130 = H.var_num(H.u(ctx), "number_artisans_blacksmith_wait")
    if _sw130 == 3 then
        local _sw131 = H.var_num(H.u(ctx), "number_artisans_blacksmith_thickness")
        if _sw131 == 1.2 then
            H.receive_item(H.u(ctx), "hc_chainmail_suit", 1, nil)
        elseif _sw131 == 2 then
            H.receive_item(H.u(ctx), "armor_hc_lightplate", 1, nil)
        elseif _sw131 == 4 then
            H.receive_item(H.u(ctx), "armor_hc_plate", 1, nil)
        elseif _sw131 == 6 then
            H.receive_item(H.u(ctx), "armor_hc_heavyplate", 1, nil)
        end
    elseif _sw130 == 4 then
        local _sw132 = H.var_num(H.u(ctx), "number_artisans_blacksmith_thickness")
        if _sw132 == 1.2 then
            H.receive_item(H.u(ctx), "qt_chainmail_suit", 1, nil)
        elseif _sw132 == 2 then
            H.receive_item(H.u(ctx), "armor_qt_lightplate", 1, nil)
        elseif _sw132 == 4 then
            H.receive_item(H.u(ctx), "armor_qt_plate", 1, nil)
        elseif _sw132 == 6 then
            H.receive_item(H.u(ctx), "armor_qt_heavyplate", 1, nil)
        end
    elseif _sw130 == 5 then
        local _sw133 = H.var_num(H.u(ctx), "number_artisans_blacksmith_thickness")
        if _sw133 == 1.2 then
            H.receive_item(H.u(ctx), "armor_nomad_chainmail", 1, nil)
        elseif _sw133 == 2 then
            H.receive_item(H.u(ctx), "armor_nomad_lightplate", 1, nil)
        elseif _sw133 == 4 then
            H.receive_item(H.u(ctx), "armor_nomad_plate", 1, nil)
        elseif _sw133 == 6 then
            H.receive_item(H.u(ctx), "armor_nomad_heavyplate", 1, nil)
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_30d1c7bc6287", function(ctx)
    H.consume_item(H.u(ctx), "exodii_ac_kit", 1, 0)
    H.consume_item(H.u(ctx), "exodii_wire_kit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_08be531f0d9f", function(ctx)
    H.consume_item(H.u(ctx), "mosin44", 1, 0)
    H.consume_item(H.u(ctx), "FMCNote", 50, 0)
end)

ccb.runtime.handler("dlg_a_dda_37df5b1b43c7", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_prototype", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_3aaefcbaf2dc", function(ctx)
    H.consume_item(H.u(ctx), "mosin91_30", 1, 0)
    H.consume_item(H.u(ctx), "FMCNote", 50, 0)
end)

ccb.runtime.handler("dlg_a_dda_65d478d2c372", function(ctx)
    H.receive_item(H.u(ctx), "obrez", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_983c2a6eee35", function(ctx)
    H.consume_item(H.u(ctx), "walther_ppk", 1, 0)
    H.consume_item(H.u(ctx), "switchblade", 1, 0)
    H.consume_item(H.u(ctx), "FMCNote", 20, 0)
end)

ccb.runtime.handler("dlg_a_dda_8433ca3fd914", function(ctx)
    H.consume_item(H.u(ctx), "lws32", 1, 0)
    H.consume_item(H.u(ctx), "switchblade", 1, 0)
    H.consume_item(H.u(ctx), "FMCNote", 20, 0)
end)

ccb.runtime.handler("dlg_a_dda_31bf1034fb5b", function(ctx)
    H.receive_item(H.u(ctx), "pressin", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_e0047564db97", function(ctx)
    H.consume_item(H.u(ctx), "flamethrower", 1, 0)
    H.consume_item(H.u(ctx), "mace", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_85290486bb5f", function(ctx)
    H.receive_item(H.u(ctx), "louverture", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_0fa0528165b4", function(ctx)
    H.consume_item(H.u(ctx), "hammer_sledge", 1, 0)
    H.consume_item(H.u(ctx), "FMCNote", 80, 0)
    H.consume_item(H.u(ctx), "22_lr", 20, 0)
end)

ccb.runtime.handler("dlg_a_dda_2ddd12328402", function(ctx)
    H.receive_item(H.u(ctx), "pulverizer", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_5c8c216dbf3f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_weapon_cost", (H.var_num(H.u(ctx), "number_artisans_blacksmith_weapon_cost")) + (50))
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_blacksmith_weapon_wait", (H.var_num(H.u(ctx), "number_artisans_blacksmith_weapon_wait")) + (2))
end)

ccb.runtime.handler("dlg_a_dda_2865e9cfc962", function(ctx)
    H.transfer_item(H.u(ctx), H.npc(ctx), "FMCNote", H.var_num(H.u(ctx), "number_artisans_blacksmith_weapon_cost"))
end)

ccb.runtime.handler("dlg_a_dda_520abba74b5a", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_weapon", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_fb9c00491f16", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_credit", (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit")) - (H.var_num(H.u(ctx), "number_artisans_gunsmith_sum0")))
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_wait", 6)
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_1de84d8c84eb", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_credit", (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit")) - (H.var_num(H.u(ctx), "number_artisans_gunsmith_sum1")))
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_wait", 24)
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_1142e0b26599", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_credit", (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit")) - (H.var_num(H.u(ctx), "number_artisans_gunsmith_sum3")))
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_wait", (3 * 24))
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_a9eb69af0032", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_credit", (H.var_num(H.u(ctx), "number_artisans_gunsmith_credit")) - (H.var_num(H.u(ctx), "number_artisans_gunsmith_sum5")))
    H.set_var("actor", H.u(ctx), ctx, "number_artisans_gunsmith_wait", (5 * 24))
    H.set_var("actor", H.u(ctx), ctx, "timer_artisans_u_waiting_on_rounds", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_f6aa485bf437", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "dialogue_first_meeting_talked_to_merchant", H.global_var_num("yes"))
end)

ccb.runtime.handler("dlg_a_dda_da9f396845ea", function(ctx)
    H.consume_item(H.u(ctx), "cake2", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_cda1365f4ecb", function(ctx)
    local _u134, _n135 = H.u(ctx), H.npc(ctx)
    if _u134 and _n135 then services.characters.set_faction_relationship(_u134, _n135, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_e9a3927a8073", function(ctx)
    H.receive_item(H.u(ctx), "adv_chemistry", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_b1ea186390a0", function(ctx)
    local _u136, _n137 = H.u(ctx), H.npc(ctx)
    if _u136 and _n137 then services.characters.set_faction_relationship(_u136, _n137, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_c65cf13e1f16", function(ctx)
    local _n138, _u139 = H.npc(ctx), H.u(ctx)
    if _n138 and _u139 then
        local _pay140 = services.trade.pay(_n138, _u139, math.floor(2000))
        if _pay140.ok and _pay140.value == true then
            H.receive_item(_u139, "meat_smoked", 10, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_842cd0c2c186", function(ctx)
    local _n141, _u142 = H.npc(ctx), H.u(ctx)
    if _n141 and _u142 then
        local _pay143 = services.trade.pay(_n141, _u142, math.floor(4000))
        if _pay143.ok and _pay143.value == true then
            H.receive_item(_u142, "meat_smoked", 20, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_6cb0766f5089", function(ctx)
    local _n144, _u145 = H.npc(ctx), H.u(ctx)
    if _n144 and _u145 then
        local _pay146 = services.trade.pay(_n144, _u145, math.floor(10000))
        if _pay146.ok and _pay146.value == true then
            H.receive_item(_u145, "meat_smoked", 50, nil)
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_fbd5e2022429", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "zkc_john", (2 * (services.time.calendar().now.turns_since_cataclysm / 86400)))
    H.set_var("actor", H.npc(ctx), ctx, "zkc_john", (H.var_num(H.npc(ctx), "zkc_john")) + (services.random.native_int(0, H.round_half_away(10))))
end)

ccb.runtime.handler("dlg_a_dda_2558df1b1d33", function(ctx)
    H.set_var("global", nil, ctx, "npc_John_Bailey_taught", (H.global_var_num("npc_John_Bailey_taught")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_4add61d2f558", function(ctx)
    local _a148 = H.npc(ctx)
    local _pos147 = H.get_tripoint_var("global", nil, ctx, "dave_castle")
    if _a148 and _pos147 then services.relocation.teleport_character(_a148, _pos147, nil) end
end)

ccb.runtime.handler("dlg_a_dda_e1b9d929b004", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_refugee_center_refugee_happiness", (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_13914f18c2f0", function(ctx)
    H.add_morale(H.u(ctx), "morale_feeling_good", 20, 30, 420, 360)
    H.consume_item(H.u(ctx), "condom", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_4482b3fae01c", function(ctx)
    H.add_morale(H.u(ctx), "morale_feeling_good", 20, 30, 360, 300)
    H.consume_item(H.u(ctx), "condom", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_725517b225b5", function(ctx)
    H.add_morale(H.u(ctx), "morale_feeling_good", 20, 30, 300, 240)
    H.consume_item(H.u(ctx), "condom", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_0957c05f4b74", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_flag_Boris_teach", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_d027843b7b0d", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + (3))
    H.assign_activity(H.u(ctx), "ACT_GENERIC_EOC", 18000)
end)

ccb.runtime.handler("dlg_a_dda_6f847e7a3114", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + (2))
    H.assign_activity(H.u(ctx), "ACT_GENERIC_EOC", 14400)
end)

ccb.runtime.handler("dlg_a_dda_1771a2e9be11", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + 1)
end)

ccb.runtime.handler("dlg_a_dda_070edb08b9e3", function(ctx)
    H.receive_item(H.u(ctx), "sourdough_bread", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_e61dd25a5265", function(ctx)
    H.receive_item(H.u(ctx), "Dana_sourdough_bread", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_0e3c1ae98309", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_dave_creating_gift", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_4db2f5d30388", function(ctx)
    H.receive_item(H.u(ctx), "recipe_dave_manual", 1, nil)
    H.receive_item(H.u(ctx), "badge_cardboard", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4776232023da", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "general_meeting_Draco_Dune_convo_depth", 3)
end)

ccb.runtime.handler("dlg_a_dda_e06c65c8caa1", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "general_meeting_Draco_Dune_convo_depth", 7)
end)

ccb.runtime.handler("dlg_a_dda_9fa754efa91b", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 4, nil)
end)

ccb.runtime.handler("dlg_a_dda_16fda14fd72a", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 6, nil)
end)

ccb.runtime.handler("dlg_a_dda_430b6c31392c", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_flag_Fatima_barter_fail", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_9c8e651a478c", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_flag_Guneet_ideas", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_d8be20af72a2", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "timer_flag_Jenny_teach", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_d8cf71f883be", function(ctx)
    H.lose_trait(H.u(ctx), "natural_hair_growth")
end)

ccb.runtime.handler("dlg_a_dda_c4a0ea5c8862", function(ctx)
    H.lose_trait(H.u(ctx), "natural_beard_growth")
end)

ccb.runtime.handler("dlg_a_dda_3e3cfcb1ca64", function(ctx)
    local _n149 = H.npc(ctx)
    local _fac150 = H.safe_id("faction", "hells_raiders")
    if _n149 and _fac150 then services.npcs.set_faction(_n149, _fac150) end
end)

ccb.runtime.handler("dlg_a_dda_08eb32f903c4", function(ctx)
    local _n151 = H.npc(ctx)
    local _fac152 = H.safe_id("faction", "hells_raiders")
    if _n151 and _fac152 then services.npcs.set_faction(_n151, _fac152) end
end)

ccb.runtime.handler("dlg_a_dda_8224d2ff1410", function(ctx)
    H.set_var("global", nil, ctx, "freemerch_godco_trader_investigated", 1)
end)

ccb.runtime.handler("dlg_a_dda_9d4a5a864597", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 20, nil)
end)

ccb.runtime.handler("dlg_a_dda_151c8a5d8b85", function(ctx)
    H.set_var("global", nil, ctx, "exodii_FM_balance", 0)
end)

ccb.runtime.handler("dlg_a_dda_52b6d7dd05e0", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You succeed in antagonizing both parties.")))
    H.set_var("global", nil, ctx, "exodii_FM_antagonized", (H.global_var_num("exodii_FM_antagonized")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_6bd097eca79f", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You fail to antagonize them.")))
    H.set_var("global", nil, ctx, "exodii_FM_annoyed", (H.global_var_num("exodii_FM_annoyed")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_66dc51fce0db", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You feel that the deal favors the Exodii a bit more.")))
    H.set_var("global", nil, ctx, "exodii_FM_balance", (H.global_var_num("exodii_FM_balance")) - (1))
end)

ccb.runtime.handler("dlg_a_dda_7cfb491fa9a3", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("Your attempts at swaying the negotiation annoys both parties.")))
    if services.random.native_probability(1, (2)) then
        H.set_var("global", nil, ctx, "exodii_FM_antagonized", (H.global_var_num("exodii_FM_antagonized")) + (1))
    end
    H.set_var("global", nil, ctx, "exodii_FM_annoyed", (H.global_var_num("exodii_FM_annoyed")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_c82aefea1f07", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You feel that the deal favors the Free Merchants a bit more.")))
    H.set_var("global", nil, ctx, "exodii_FM_balance", (H.global_var_num("exodii_FM_balance")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_f6d504f6b67f", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("Your fail to antagonize them.")))
    H.set_var("global", nil, ctx, "exodii_FM_annoyed", (H.global_var_num("exodii_FM_annoyed")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_3a5986f50373", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("Rubik agrees to selling the Free Merchants a medical robot.  You feel that the deal favors the Free Merchants a bit more.")))
    H.set_var("global", nil, ctx, "exodii_FM_balance", (H.global_var_num("exodii_FM_balance")) - (1))
    H.set_var("global", nil, ctx, "exodii_FM_autodoc", 1)
end)

ccb.runtime.handler("dlg_a_dda_c3dbed4b8a47", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("Rubik agrees that the Free Merchants can take over a nearby Exodii warehouse.  You feel that the deal favors the Free Merchants a bit more.")))
    H.set_var("global", nil, ctx, "exodii_FM_balance", (H.global_var_num("exodii_FM_balance")) + (1))
    H.set_var("global", nil, ctx, "exodii_FM_butte_building", 1)
end)

ccb.runtime.handler("dlg_a_dda_7ac8c914e00e", function(ctx)
    local _n153, _u154 = H.npc(ctx), H.u(ctx)
    if _n153 and _u154 then services.trade.pay(_n153, _u154, math.floor(-10000)) end
end)

ccb.runtime.handler("dlg_a_dda_0a12ed09c118", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 5, 0)
end)

ccb.runtime.handler("dlg_a_dda_b041becec6c3", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + (3))
end)

ccb.runtime.handler("dlg_a_dda_73da091850f1", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 10, 0)
end)

ccb.runtime.handler("dlg_a_dda_0b1562fc78f3", function(ctx)
    H.receive_item(H.u(ctx), "antibiotics", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_70d7de14f9c9", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + (2))
end)

ccb.runtime.handler("dlg_a_dda_fe6648a62eb4", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 750, 0)
end)

ccb.runtime.handler("dlg_a_dda_c231e68b393b", function(ctx)
    H.set_var("global", nil, ctx, "npc_randomize_dialogue_direction", services.random.native_int(0, H.round_half_away(3)))
end)

ccb.runtime.handler("dlg_a_dda_33259372cede", function(ctx)
    H.consume_item(H.u(ctx), "gold_small", 200, 0)
    H.receive_item(H.u(ctx), "RobofacCoin", 8, nil)
    local _n155 = H.npc(ctx)
    if _n155 then services.npcs.modify_opinion(_n155, { trust = math.floor(1) }) end
    local _n156 = H.npc(ctx)
    if _n156 then services.npcs.modify_opinion(_n156, { value = math.floor(1) }) end
end)

ccb.runtime.handler("dlg_a_dda_ecb25882f709", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.receive_item(H.u(ctx), "military_papr_mask", 1, nil)
    H.receive_item(H.u(ctx), "basic_papr_belt_off", 1, nil)
    H.receive_item(H.u(ctx), "robofac_head_rig", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4c91eb166453", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "broken_exodii_worker", amount = 1 } })
    H.receive_item(H.u(ctx), "RobofacCoin", 1, nil)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_f7a1fbc5f069", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "broken_exodii_quad", amount = 1 } })
    H.receive_item(H.u(ctx), "RobofacCoin", 2, nil)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_6d2f64f6260e", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "broken_exodii_turret", amount = 1 } })
    H.receive_item(H.u(ctx), "RobofacCoin", 2, nil)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_49ea36d673a8", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "broken_exodii_sniper_drone", amount = 1 } })
    H.receive_item(H.u(ctx), "RobofacCoin", 4, nil)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_1dfd46df0f2b", function(ctx)
    H.receive_item(H.u(ctx), "water_clean", 2, "glass")
end)

ccb.runtime.handler("dlg_a_dda_d3d52e8fe965", function(ctx)
    local _n157, _u158 = H.npc(ctx), H.u(ctx)
    if _n157 and _u158 then
        local _pay159 = services.trade.pay(_n157, _u158, math.floor(200))
        if _pay159.ok and _pay159.value == true then
            H.receive_item(_u158, "water_clean", 2, "glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_4269fb161103", function(ctx)
    local _n160, _u161 = H.npc(ctx), H.u(ctx)
    if _n160 and _u161 then
        local _pay162 = services.trade.pay(_n160, _u161, math.floor(300))
        if _pay162.ok and _pay162.value == true then
            H.receive_item(_u161, "beer", 2, "glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_9b2df95177fe", function(ctx)
    local _n163, _u164 = H.npc(ctx), H.u(ctx)
    if _n163 and _u164 then
        local _pay165 = services.trade.pay(_n163, _u164, math.floor(300))
        if _pay165.ok and _pay165.value == true then
            H.receive_item(_u164, "wine_cabernet", 1, "wine_glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_9c107a61ce55", function(ctx)
    local _n166, _u167 = H.npc(ctx), H.u(ctx)
    if _n166 and _u167 then
        local _pay168 = services.trade.pay(_n166, _u167, math.floor(300))
        if _pay168.ok and _pay168.value == true then
            H.receive_item(_u167, "rum", 1, "glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_80d2569046d0", function(ctx)
    local _n169, _u170 = H.npc(ctx), H.u(ctx)
    if _n169 and _u170 then
        local _pay171 = services.trade.pay(_n169, _u170, math.floor(300))
        if _pay171.ok and _pay171.value == true then
            H.receive_item(_u170, "whiskey", 1, "glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_1b4ead6a5a99", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_BEM_BEM_human_sample_reward_owed", (H.var_num(H.u(ctx), "counter_BEM_BEM_human_sample_reward_owed")) - 1)
end)

ccb.runtime.handler("dlg_a_dda_3cea5fb343d4", function(ctx)
    H.receive_item(H.u(ctx), "RobofacCoin", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_41fa82e14390", function(ctx)
    if ((H.char_has_trait(H.u(ctx), "CBM_Interface") == 1) or (H.char_has_trait(H.u(ctx), "NL_CBM_Interface") == 1)) then
        H.lose_trait(H.u(ctx), "CBM_Interface")
        H.lose_trait(H.u(ctx), "NL_CBM_Interface")
        H.add_trait(H.u(ctx), "CBM_Interface_brain_lesion")
        H.set_var("global", nil, ctx, "hub01_found_u_exodii_interface", 1)
        H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
    end
end)

ccb.runtime.handler("dlg_a_dda_5e6f32226d3b", function(ctx)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_batteries")
    H.add_bionic(H.u(ctx), "bio_radio")
    H.consume_item(H.u(ctx), "RobofacCoin", 20, 0)
end)

ccb.runtime.handler("dlg_a_dda_98f3b3c746be", function(ctx)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_batteries")
    H.add_bionic(H.u(ctx), "bio_radio")
end)

ccb.runtime.handler("dlg_a_dda_e0dc47445c10", function(ctx)
    H.set_var("global", nil, ctx, "hub01_found_u_exodii_interface", 1)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_23c9930d5b44", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 7200)
    H.lose_trait(H.u(ctx), "CBM_Interface")
    H.lose_trait(H.u(ctx), "NL_CBM_Interface")
end)

ccb.runtime.handler("dlg_a_dda_ae248b091eef", function(ctx)
    H.add_bionic(H.u(ctx), "bio_power_storage")
    H.add_bionic(H.u(ctx), "bio_batteries")
    H.add_bionic(H.u(ctx), "bio_radio")
    H.receive_item(H.u(ctx), "RobofacCoin", 10, nil)
end)

ccb.runtime.handler("dlg_a_dda_bc4b9c66e736", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 7200)
    H.lose_trait(H.u(ctx), "CBM_Interface")
    H.lose_trait(H.u(ctx), "CBM_Interface_brain_lesion")
end)

ccb.runtime.handler("dlg_a_dda_41d893b6e4fb", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
end)

ccb.runtime.handler("dlg_a_dda_4a00e32b9c37", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 4, 0)
end)

ccb.runtime.handler("dlg_a_dda_8948663cd33d", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 8, 0)
end)

ccb.runtime.handler("dlg_a_dda_3b0f6c80d508", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 21600)
    H.lose_bionic(H.u(ctx), "bio_robofac_xmarm")
    H.lose_bionic(H.u(ctx), "bio_armor_arms")
end)

ccb.runtime.handler("dlg_a_dda_8db1b51edca3", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 20, 0)
end)

ccb.runtime.handler("dlg_a_dda_5eb7d97f57e0", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 21600)
    H.lose_trait(H.u(ctx), "BIONIC_ARM_BASIC_LEFT")
    H.lose_trait(H.u(ctx), "BIONIC_ARM_BASIC_RIGHT")
end)

ccb.runtime.handler("dlg_a_dda_abe9cab787b0", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 21600)
    H.lose_bionic(H.u(ctx), "bio_robofac_xmleg")
    H.lose_bionic(H.u(ctx), "bio_armor_legs")
end)

ccb.runtime.handler("dlg_a_dda_27cd72b84fb0", function(ctx)
    H.assign_activity(H.u(ctx), "ACT_CBM_SURGERY", 21600)
    H.lose_trait(H.u(ctx), "BIONIC_LEG_BASIC_LEFT")
    H.lose_trait(H.u(ctx), "BIONIC_LEG_BASIC_RIGHT")
end)

ccb.runtime.handler("dlg_a_dda_e77729ae12dd", function(ctx)
    local _ach172 = H.safe_id("achievement", "achievement_exodii_hub_autodoc_death")
    if _ach172 then services.achievements.complete(_ach172) end
end)

ccb.runtime.handler("dlg_a_dda_b6b8885af26b", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 12, 0)
end)

ccb.runtime.handler("dlg_a_dda_18cd15f0e566", function(ctx)
    H.receive_item(H.u(ctx), "id_science", 2, nil)
    H.receive_item(H.u(ctx), "id_military", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_02f789c7714b", function(ctx)
    H.receive_item(H.u(ctx), "standard_template_construct", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_26eafe050b55", function(ctx)
    H.receive_item(H.u(ctx), "exodii_chop_shop_head", 1, nil)
    H.consume_item(H.npc(ctx), "exodii_chop_shop_head", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_243d28d9cb71", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    local _n173 = H.npc(ctx)
    if _n173 then services.npcs.add_faction_rep(_n173, math.floor(-100)) end
end)

ccb.runtime.handler("dlg_a_dda_685ad03514ae", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    local _n174 = H.npc(ctx)
    if _n174 then services.npcs.add_faction_rep(_n174, math.floor(-100)) end
end)

ccb.runtime.handler("dlg_a_dda_638146741a89", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    local _n175 = H.npc(ctx)
    if _n175 then services.npcs.add_faction_rep(_n175, math.floor(-100)) end
end)

ccb.runtime.handler("dlg_a_dda_fcae718a6085", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The scientist covers their face with their arms \"No, please!\"")), "neutral")
    local _n176 = H.npc(ctx)
    if _n176 then services.npcs.add_faction_rep(_n176, math.floor(-100)) end
end)

ccb.runtime.handler("dlg_a_dda_cd911d038159", function(ctx)
    H.consume_item(H.u(ctx), "cig", 2, 0)
end)

ccb.runtime.handler("dlg_a_dda_fee2c81e6a6b", function(ctx)
    H.consume_item(H.u(ctx), "eink_tablet_pc", 2, 0)
    H.consume_item(H.u(ctx), "ar_glasses_advanced", 1, 0)
    H.consume_item(H.u(ctx), "two_way_radio", 2, 0)
end)

ccb.runtime.handler("dlg_a_dda_d14a2f08c2a5", function(ctx)
    H.consume_item(H.u(ctx), "eink_tablet_pc", 1, 0)
    H.consume_item(H.u(ctx), "military_vis_aug_system", 1, 0)
    H.consume_item(H.u(ctx), "two_way_radio", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_772d908bcb93", function(ctx)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_63177be5ac0c", function(ctx)
    H.consume_item(H.u(ctx), "eink_tablet_pc", 1, 0)
    H.consume_item(H.u(ctx), "robofac_head_rig_ar", 1, 0)
    H.consume_item(H.u(ctx), "two_way_radio", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_f47d75eca5b8", function(ctx)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
    H.receive_item(H.u(ctx), "ar_glasses_advanced_pat", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4d6dcc7a7ee5", function(ctx)
    if ((("military_vis_aug_system") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_is_holding", "")))) then
        H.receive_item(H.u(ctx), "military_vis_aug_system", 1, nil)
        H.receive_item(H.u(ctx), "pat_earpiece", 1, nil)
        H.set_var("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "yes")
    else
        H.receive_item(H.u(ctx), "robofac_head_rig_ar", 1, nil)
        H.receive_item(H.u(ctx), "pat_earpiece", 1, nil)
        H.set_var("actor", H.u(ctx), ctx, "robofac_pat_gave_gear", "yes")
    end
end)

ccb.runtime.handler("dlg_a_dda_0885d61f61ec", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_recon_random_loc", services.random.native_int(0, H.round_half_away(13)))
    H.set_var("global", nil, ctx, "robofac_timer_pat_recon", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_e3a1db2717d2", function(ctx)
    H.consume_item(H.u(ctx), "eink_tablet_pc", 2, 0)
    H.consume_item(H.u(ctx), "ar_glasses_advanced", 1, 0)
    H.consume_item(H.u(ctx), "two_way_radio", 2, 0)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_7f503ec6d52a", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_e0e8bc2bd0a2", function(ctx)
    H.receive_item(H.u(ctx), "ar_glasses_advanced_pat", 1, nil)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_d95d58a657a5", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 2, 0)
end)

ccb.runtime.handler("dlg_a_dda_6803713d7a4a", function(ctx)
    H.receive_item(H.u(ctx), "pat_earpiece", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_ea81fc86a3a3", function(ctx)
    H.lose_bionic(H.u(ctx), "bio_radio")
    H.add_bionic(H.u(ctx), "bio_radio_pat")
end)

ccb.runtime.handler("dlg_a_dda_bf1fc7827640", function(ctx)
    H.consume_item(H.u(ctx), "military_vis_aug_system", 1, 0)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_333a45f80cf4", function(ctx)
    H.consume_item(H.u(ctx), "robofac_head_rig_ar", 1, 0)
    H.set_var("global", nil, ctx, "robofac_timer_waiting_on_pat", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_01132165fc15", function(ctx)
    H.consume_item(H.u(ctx), "robofac_lens_helmet", 1, 0)
    H.receive_item(H.u(ctx), "robofac_lens_helmet_pat", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_09d8d955a248", function(ctx)
    H.set_var("global", nil, ctx, "robofac_timer_pat_recon", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_b35540f5ff02", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_string_dimension", 0)
end)

ccb.runtime.handler("dlg_a_dda_8772355d2832", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_labyrinth", 0)
end)

ccb.runtime.handler("dlg_a_dda_c75ba8b85585", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_radiosphere", 0)
end)

ccb.runtime.handler("dlg_a_dda_f8ae05bc885e", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_cabin_reverb", 0)
end)

ccb.runtime.handler("dlg_a_dda_f376975a2e26", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_spider_dimension", 0)
end)

ccb.runtime.handler("dlg_a_dda_42d5089e8159", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_portal_storm_dungeon", 0)
end)

ccb.runtime.handler("dlg_a_dda_c2b615800f06", function(ctx)
    H.set_var("global", nil, ctx, "robofac_pat_lost_signal_highlands", 0)
end)

ccb.runtime.handler("dlg_a_dda_faece938f91c", function(ctx)
    H.receive_item(H.u(ctx), "manual_electronics", 1, nil)
    H.receive_item(H.u(ctx), "mag_electronics", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_4d9369728ac2", function(ctx)
    H.receive_item(H.u(ctx), "grenade", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_0a0865d35a87", function(ctx)
    H.set_var("global", nil, ctx, "robofac_timer_pat_warehouse", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_5eabcb8a3b97", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "talked_to_hub", 1)
end)

ccb.runtime.handler("dlg_a_dda_419b707aa4cf", function(ctx)
    H.set_var("global", nil, ctx, "hub01_knows_exodii", 1)
end)

ccb.runtime.handler("dlg_a_dda_6174ecbde742", function(ctx)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_54d5f5b21399", function(ctx)
    H.receive_item(H.u(ctx), "armor_riot", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_1abaa1b8273b", function(ctx)
    H.receive_item(H.u(ctx), "usp_9mm", 1, nil)
    H.receive_item(H.u(ctx), "usp9mag", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_a1cb2e64d7fa", function(ctx)
    H.consume_item(H.u(ctx), "template_armor", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_efd74ae5915b", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_armor", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_4ba535467f39", function(ctx)
    H.consume_item(H.u(ctx), "fema_data", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_ae90e528a11f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "hub01_good_candidate", 1)
end)

ccb.runtime.handler("dlg_a_dda_b452b1ce4f53", function(ctx)
    H.receive_item(H.u(ctx), "robofac_basic_vambraces", 1, nil)
    H.receive_item(H.u(ctx), "robofac_basic_greaves", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_687c0fab6ae8", function(ctx)
    H.set_var("global", nil, ctx, "hub01_knows_exodii", 1)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_17ca1cc4d07b", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
end)

ccb.runtime.handler("dlg_a_dda_3c564ddaa56c", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_729e39bdeb38", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
    H.set_var("global", nil, ctx, "hub01_promised_warehouse_info", 1)
end)

ccb.runtime.handler("dlg_a_dda_7ece42511df9", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 10, nil)
end)

ccb.runtime.handler("dlg_a_dda_383f4e5a2e01", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
    H.set_var("global", nil, ctx, "hub01_promised_warehouse_info", 1)
end)

ccb.runtime.handler("dlg_a_dda_1de9d516ef01", function(ctx)
    H.set_var("global", nil, ctx, "hub01_bought_exodii_warehouse", 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 10, nil)
    H.set_var("global", nil, ctx, "hub01_promised_warehouse_info", 1)
end)

ccb.runtime.handler("dlg_a_dda_bb58c961d492", function(ctx)
    H.set_var("global", nil, ctx, "hub01_and_exodii_found_warehouse", 1)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_waiting_on_warehouse", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_4b808a776918", function(ctx)
    H.set_var("global", nil, ctx, "hub01_stole_warehouse", 1)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_waiting_on_warehouse", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_2675ed36767c", function(ctx)
    H.set_var("global", nil, ctx, "hub01_told_u_about_warehouse", 1)
end)

ccb.runtime.handler("dlg_a_dda_74f94310dceb", function(ctx)
    H.set_var("global", nil, ctx, "hub01_told_u_about_warehouse", 1)
    H.set_var("global", nil, ctx, "hub01_told_u_about_warehouse_autodoc", 1)
end)

ccb.runtime.handler("dlg_a_dda_aaefecbdde37", function(ctx)
    H.set_var("global", nil, ctx, "hub01_promised_cbm_reward", 1)
end)

ccb.runtime.handler("dlg_a_dda_a757f4a3a655", function(ctx)
    H.consume_item(H.u(ctx), "robofac_test_data", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_ea2ba23445ef", function(ctx)
    H.receive_item(H.u(ctx), "UPS_OFF", 1, nil)
    H.receive_item(H.u(ctx), "heavy_battery_cell", 1, nil)
    H.receive_item(H.u(ctx), "robofac_yrax_trifacet_deactivation_manual", 1, nil)
    H.receive_item(H.u(ctx), "hm12", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_bfa0da4ca246", function(ctx)
    H.receive_item(H.u(ctx), "nre_recorder", 1, nil)
    H.receive_item(H.u(ctx), "medium_battery_cell", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_7f37f3e7ae70", function(ctx)
    H.receive_item(H.u(ctx), "mobile_weather_station", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_55aec7df7093", function(ctx)
    H.receive_item(H.u(ctx), "xedra_mobile_weather_station", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_e0b22c7c9d72", function(ctx)
    H.receive_item(H.u(ctx), "hub_meteorology_pack", 1, nil)
    H.receive_item(H.u(ctx), "folding_solar_panel", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_32fed1313479", function(ctx)
    H.receive_item(H.u(ctx), "id_anduril_ar", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_f6e107a6ca8f", function(ctx)
    H.receive_item(H.u(ctx), "bot_robofac_hound", 1, nil)
    H.receive_item(H.u(ctx), "powered_earplugs", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_2f5e615d151c", function(ctx)
    H.receive_item(H.u(ctx), "id_LIXA", 1, nil)
    H.receive_item(H.u(ctx), "usb_drive_nano", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_97a98b37e4a2", function(ctx)
    H.consume_item(H.u(ctx), "robofac_hardcase", 1, 0)
    H.receive_item(H.u(ctx), "RobofacCoin", 4, nil)
end)

ccb.runtime.handler("dlg_a_dda_e60854e28f18", function(ctx)
    H.consume_item(H.u(ctx), "lixa_data", 1, 0)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_1d69328e3153", function(ctx)
    H.consume_item(H.u(ctx), "template_photonics", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_57fc2fc62bb9", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "bot_yrax_trifacet", amount = 1 } })
    H.consume_item(H.u(ctx), "bot_yrax_trifacet", 1, 0)
    H.receive_item(H.u(ctx), "RobofacCoin", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_a773511d99e2", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_trifacet", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_47c31d449f38", function(ctx)
    H.consume_item(H.u(ctx), "mws_portal_storm_weather_data", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_fcd2e40a4a2f", function(ctx)
    H.consume_item(H.u(ctx), "xedra_mobile_weather_station", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_fddffa8eba7a", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_portal_storm", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_b197d5c1b644", function(ctx)
    H.consume_item(H.u(ctx), "mws_monster_corpse_weather_data", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_a331a1f04941", function(ctx)
    H.consume_item(H.u(ctx), "military_vis_aug_system", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_1f0e3eeb9ce5", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_hub", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_03dcd9c43e61", function(ctx)
    H.consume_item_sum(H.u(ctx), H.npc(ctx), { { item = "broken_exodii_worker", amount = 1 } })
end)

ccb.runtime.handler("dlg_a_dda_9b39ae23c06a", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_waiting_on_autodoc", services.turn())
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
end)

ccb.runtime.handler("dlg_a_dda_55e0caefb02f", function(ctx)
    H.consume_item(H.u(ctx), "xedra_microphone", 1, 0)
    H.receive_item(H.u(ctx), "nre_recorder", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_390efe4feee0", function(ctx)
    H.receive_item(H.u(ctx), "robofac_gun", 1, nil)
    H.receive_item(H.u(ctx), "robofac_gun_ar", 1, nil)
    H.receive_item(H.u(ctx), "robofac_gun_smg", 1, nil)
    H.receive_item(H.u(ctx), "robofac_gun_dmr", 1, nil)
    H.receive_item(H.u(ctx), "robofac_gun_shotgun", 1, nil)
    H.receive_item(H.u(ctx), "robofac_gun_kit", 1, nil)
    H.receive_item(H.u(ctx), "robofac40", 2, nil)
    H.receive_item(H.u(ctx), "robofac60", 2, nil)
    H.receive_item(H.u(ctx), "robofac20", 2, nil)
    H.receive_item(H.u(ctx), "robofac10", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_3b89db9308f4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_gun", services.turn())
end)

ccb.runtime.handler("dlg_a_dda_f989a6e61ab9", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 3, 0)
end)

ccb.runtime.handler("dlg_a_dda_4ad38383ecfb", function(ctx)
    if ((("phase_immersion_suit") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_current_project", "")))) then
        H.set_var("actor", H.npc(ctx), ctx, "phase_suit_reverse_engineered", "yes")
        H.set_var("global", nil, ctx, "hub01_phase_suit_reverse_engineered", "yes")
        H.receive_item(H.u(ctx), "phase_immersion_suit", 1, nil)
    end
    if ((("rm13_armor") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_current_project", "")))) then
        H.set_var("actor", H.npc(ctx), ctx, "rm13_reverse_engineered", "yes")
        H.set_var("global", nil, ctx, "hub01_rm13_reverse_engineered", "yes")
        H.receive_item(H.u(ctx), "rm13_armor", 1, nil)
        H.receive_item(H.u(ctx), "rm13_battery", 1, nil)
    end
    if ((("combat_exoskeleton_light_salvaged") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_current_project", "")))) then
        H.set_var("actor", H.npc(ctx), ctx, "combat_exoskeleton_reverse_engineered", "yes")
        H.set_var("global", nil, ctx, "hub01_combat_exoskeleton_reverse_engineered", "yes")
        H.receive_item(H.u(ctx), "combat_exoskeleton_light", 1, nil)
    end
    if ((("resonance_suit") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_hub_rnd_u_current_project", "")))) then
        H.receive_item(H.u(ctx), "robofac_resonance_suit", 1, nil)
    end
end)

ccb.runtime.handler("dlg_a_dda_a46ac05ebff8", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.consume_item(H.u(ctx), "phase_immersion_suit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_29d31aae2139", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_hub", (services.turn() + 1209600))
end)

ccb.runtime.handler("dlg_a_dda_ac6ebea88ba9", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 12, 0)
    H.consume_item(H.u(ctx), "phase_immersion_suit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_9539ce7778ec", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_hub", (services.turn() + 3801600))
end)

ccb.runtime.handler("dlg_a_dda_c9937f9c6197", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.consume_item(H.u(ctx), "rm13_armor", 1, 0)
    H.consume_item(H.u(ctx), "rm13_battery", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_7b1d398e0165", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 12, 0)
    H.consume_item(H.u(ctx), "rm13_armor", 1, 0)
    H.consume_item(H.u(ctx), "rm13_battery", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_f5261b4bc601", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.consume_item(H.u(ctx), "combat_exoskeleton_light_salvaged", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_hub", (services.turn() + 1209600))
end)

ccb.runtime.handler("dlg_a_dda_78fa94826a02", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 12, 0)
    H.consume_item(H.u(ctx), "combat_exoskeleton_light_salvaged", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "timer_hub_rnd_u_waiting_on_hub", (services.turn() + 3801600))
end)

ccb.runtime.handler("dlg_a_dda_b9f5c369fc72", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 10, 0)
    H.consume_item(H.u(ctx), "robofac_resonance_suit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_7b93e757fb8e", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 2, 0)
    H.consume_item(H.u(ctx), "dimensional_anchor", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_03ba7e1acdef", function(ctx)
    H.receive_item(H.u(ctx), "dimensional_anchor", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_a6f3892b29aa", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 1, 0)
    H.consume_item(H.u(ctx), "dimensional_anchor", 1, 0)
    H.consume_item(H.u(ctx), "robofac_armor_rig", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_b6aa2a600d2f", function(ctx)
    H.receive_item(H.u(ctx), "robofac_armor_anchor", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_fde17be1a40f", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 2, 0)
    H.consume_item(H.u(ctx), "xedra_artifact_cleansuit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_9cd1e2a69204", function(ctx)
    H.receive_item(H.u(ctx), "xedra_artifact_cleansuit", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_270a3b7a0f3e", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 1, 0)
    H.consume_item(H.u(ctx), "xedra_artifact_cleansuit", 1, 0)
    H.consume_item(H.u(ctx), "robofac_enviro_suit", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_d28f3867bd3a", function(ctx)
    H.receive_item(H.u(ctx), "robofac_resonance_suit", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_51de27d579cc", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 3, 0)
    H.consume_item(H.u(ctx), "xedra_mobile_weather_station", 1, 0)
    H.consume_item(H.u(ctx), "nre_recorder", 1, 0)
end)

ccb.runtime.handler("dlg_a_dda_26411ca6123b", function(ctx)
    H.receive_item(H.u(ctx), "robofac_mobile_weather_station", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_3f4de49eb783", function(ctx)
    H.receive_item(H.u(ctx), "robofac_head_rig_ar", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_851bba12780b", function(ctx)
    H.consume_item(H.u(ctx), "pamd68", 1, 0)
    H.consume_item(H.u(ctx), "exodiiBRmag", 1, 0)
    H.consume_item(H.u(ctx), "123ln", 5, 0)
end)

ccb.runtime.handler("dlg_a_dda_4b2a0f82b77b", function(ctx)
    H.consume_item(H.u(ctx), "pamd71z", 1, 0)
    H.consume_item(H.u(ctx), "exodiiminimag", 1, 0)
    H.consume_item(H.u(ctx), "123ln", 5, 0)
end)

ccb.runtime.handler("dlg_a_dda_3e7802f824a8", function(ctx)
    H.set_var("global", nil, ctx, "hub01_hwp_exotic_researched", 1)
end)

ccb.runtime.handler("dlg_a_dda_7bdb5baa184c", function(ctx)
    H.receive_item(H.u(ctx), "robofac_gun_exodii", 1, nil)
    H.receive_item(H.u(ctx), "robofac60_123ln", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_77e2cf4040b1", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 1, 0)
    H.mapgen_update(H.u(ctx), "robofachq_surface_entrance", nil, false, 0, 0, 40)
end)

ccb.runtime.handler("dlg_a_dda_0b73973a513f", function(ctx)
    H.consume_item(H.u(ctx), "nre_anomaly_printout_data", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "portal_storm_recordings_sold", (H.var_num(H.u(ctx), "portal_storm_recordings_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 10, nil)
end)

ccb.runtime.handler("dlg_a_dda_c424948a0318", function(ctx)
    H.consume_item(H.u(ctx), "large_printout_portal_storm_data", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "portal_storm_recordings_sold", (H.var_num(H.u(ctx), "portal_storm_recordings_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 18, nil)
end)

ccb.runtime.handler("dlg_a_dda_6c27eeafdb86", function(ctx)
    H.consume_item(H.u(ctx), "medium_printout_portal_storm_data", 1, 0)
    H.set_var("global", nil, ctx, "portal_storm_medium_data_sold", (H.global_var_num("portal_storm_medium_data_sold")) + 1)
    H.set_var("actor", H.u(ctx), ctx, "portal_storm_recordings_sold", (H.var_num(H.u(ctx), "portal_storm_recordings_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_9ce16051e93c", function(ctx)
    H.consume_item(H.u(ctx), "small_printout_portal_storm_data", 1, 0)
    H.set_var("global", nil, ctx, "portal_storm_small_data_sold", (H.global_var_num("portal_storm_small_data_sold")) + 1)
    H.set_var("actor", H.u(ctx), ctx, "portal_storm_recordings_sold", (H.var_num(H.u(ctx), "portal_storm_recordings_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_1a1507c0fc87", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 8, 0)
    H.receive_item(H.u(ctx), "armor_riot", 5, nil)
    H.receive_item(H.u(ctx), "helmet_riot", 5, nil)
    H.receive_item(H.u(ctx), "armor_riot_arm", 5, nil)
    H.receive_item(H.u(ctx), "armor_riot_leg", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_d134bbc1a0ec", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_trifacet", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_yrax_trifacet_sold", (H.var_num(H.u(ctx), "broken_yrax_trifacet_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_7de768356dce", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_triakis", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_yrax_triakis_sold", (H.var_num(H.u(ctx), "broken_yrax_triakis_sold")) + 1)
    local _n177, _u178 = H.npc(ctx), H.u(ctx)
    if _n177 and _u178 then services.trade.pay(_n177, _u178, math.floor(-1000)) end
end)

ccb.runtime.handler("dlg_a_dda_482889d0a465", function(ctx)
    H.consume_item(H.u(ctx), "broken_golden_monolith", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_golden_monolith_sold", (H.var_num(H.u(ctx), "broken_golden_monolith_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 7, nil)
end)

ccb.runtime.handler("dlg_a_dda_d81f3b78e058", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_delta", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_yrax_delta_sold", (H.var_num(H.u(ctx), "broken_yrax_delta_sold")) + 1)
    local _n179, _u180 = H.npc(ctx), H.u(ctx)
    if _n179 and _u180 then services.trade.pay(_n179, _u180, math.floor(-200)) end
end)

ccb.runtime.handler("dlg_a_dda_5188f4918353", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_quadraphract_leg", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_yrax_quadraphract_leg_sold", (H.var_num(H.u(ctx), "broken_yrax_quadraphract_leg_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_1107ada30080", function(ctx)
    H.consume_item(H.u(ctx), "broken_yrax_quadraphract", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "broken_yrax_quadraphract_sold", (H.var_num(H.u(ctx), "broken_yrax_quadraphract_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_9ba1a784cc90", function(ctx)
    H.consume_item(H.u(ctx), "bot_yrax_trifacet", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "bot_yrax_trifacet_sold", (H.var_num(H.u(ctx), "bot_yrax_trifacet_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 2, nil)
end)

ccb.runtime.handler("dlg_a_dda_6326394a9290", function(ctx)
    H.consume_item(H.u(ctx), "bot_yrax_triakis", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "bot_yrax_triakis_sold", (H.var_num(H.u(ctx), "bot_yrax_triakis_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_f1359c393a58", function(ctx)
    H.consume_item(H.u(ctx), "bot_golden_monolith", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "bot_golden_monolith_sold", (H.var_num(H.u(ctx), "bot_golden_monolith_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 16, nil)
end)

ccb.runtime.handler("dlg_a_dda_91d78fc5eb37", function(ctx)
    H.consume_item(H.u(ctx), "bot_yrax_delta", 1, 0)
    H.set_var("actor", H.u(ctx), ctx, "bot_yrax_delta_sold", (H.var_num(H.u(ctx), "bot_yrax_delta_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_754d7f875bd1", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_portal", 1, 0)
    H.set_var("global", nil, ctx, "HEW_portal_data_sold", (H.global_var_num("HEW_portal_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_af49f71339ee", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_portal_storm", 1, 0)
    H.set_var("global", nil, ctx, "HEW_portal_storm_data_sold", (H.global_var_num("HEW_portal_storm_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_4751aabc51ba", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_vitrified", 1, 0)
    H.set_var("global", nil, ctx, "HEW_vitrified_data_sold", (H.global_var_num("HEW_vitrified_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_c9cda4679366", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_exodii", 1, 0)
    H.set_var("global", nil, ctx, "HEW_exodii_data_sold", (H.global_var_num("HEW_exodii_data_sold")) + 1)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_2e9eea0a3fa5", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_strange_temple", 1, 0)
    H.set_var("global", nil, ctx, "HEW_temple_data_sold", (H.global_var_num("HEW_temple_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_7febbe92e1db", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_lixa", 1, 0)
    H.set_var("global", nil, ctx, "HEW_lixa_data_sold", (H.global_var_num("HEW_lixa_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_c2f7a8139984", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_highlands", 1, 0)
    H.set_var("global", nil, ctx, "HEW_highlands_data_sold", (H.global_var_num("HEW_highlands_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_78bc9cadb9aa", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_labyrinth", 1, 0)
    H.set_var("global", nil, ctx, "HEW_labyrinth_data_sold", (H.global_var_num("HEW_labyrinth_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_780722f802a0", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_physics_lab", 1, 0)
    H.set_var("global", nil, ctx, "HEW_physics_lab_data_sold", (H.global_var_num("HEW_physics_lab_data_sold")) + 1)
    H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_7517b5e57697", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_amigara", 1, 0)
    H.set_var("global", nil, ctx, "HEW_amigara_data_sold", (H.global_var_num("HEW_amigara_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_5d72456d1ad5", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_radiosphere", 1, 0)
    H.set_var("global", nil, ctx, "HEW_radiosphere_data_sold", (H.global_var_num("HEW_radiosphere_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_60f9f01fb672", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_monster_corpse", 1, 0)
    H.set_var("global", nil, ctx, "HEW_monster_corpse_data_sold", (H.global_var_num("HEW_monster_corpse_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_c796f2e12fa3", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_cabin_reverb", 1, 0)
    H.set_var("global", nil, ctx, "HEW_cabin_reverb_data_sold", (H.global_var_num("HEW_cabin_reverb_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_7b88d52e4d58", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_cabin_reverb_dimension", 1, 0)
    H.set_var("global", nil, ctx, "HEW_cabin_reverb_dimension_data_sold", (H.global_var_num("HEW_cabin_reverb_dimension_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_efab7034dde2", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_barricaded_church", 1, 0)
    H.set_var("global", nil, ctx, "HEW_barricaded_church_data_sold", (H.global_var_num("HEW_barricaded_church_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_fb214d511ce0", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_morgantown", 1, 0)
    H.set_var("global", nil, ctx, "HEW_morgantown_data_sold", (H.global_var_num("HEW_morgantown_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_49a658f92ec7", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_string_dimension", 1, 0)
    H.set_var("global", nil, ctx, "HEW_string_dimension_data_sold", (H.global_var_num("HEW_string_dimension_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_5c2cdab017b9", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_spiral_mine", 1, 0)
    H.set_var("global", nil, ctx, "HEW_spiral_mine_data_sold", (H.global_var_num("HEW_spiral_mine_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_e9b68481bb9b", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_void_spider_lair", 1, 0)
    H.set_var("global", nil, ctx, "HEW_void_spider_lair_data_sold", (H.global_var_num("HEW_void_spider_lair_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_8b17fea9c83e", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_portal_storm_dungeon", 1, 0)
    H.set_var("global", nil, ctx, "HEW_portal_storm_dungeon_data_sold", (H.global_var_num("HEW_portal_storm_dungeon_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_f89b78acaa19", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_inner_cabins_open_field", 1, 0)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_alpha_data_sold", (H.global_var_num("HEW_inner_cabins_alpha_data_sold")) + 1)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_data_sold", (H.global_var_num("HEW_inner_cabins_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_e0b08fee1722", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_inner_cabins_warped_cabin", 1, 0)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_beta_data_sold", (H.global_var_num("HEW_inner_cabins_beta_data_sold")) + 1)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_data_sold", (H.global_var_num("HEW_inner_cabins_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_7236e065e066", function(ctx)
    H.consume_item(H.u(ctx), "HEW_printout_data_inner_cabins_home_cabin", 1, 0)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_gamma_data_sold", (H.global_var_num("HEW_inner_cabins_gamma_data_sold")) + 1)
    H.set_var("global", nil, ctx, "HEW_inner_cabins_data_sold", (H.global_var_num("HEW_inner_cabins_data_sold")) + 1)
    H.receive_item(H.u(ctx), "RobofacCoin", 5, nil)
end)

ccb.runtime.handler("dlg_a_dda_079275754668", function(ctx)
    H.consume_item(H.u(ctx), "RobofacCoin", 2, 0)
    H.receive_item(H.u(ctx), "mask_gas_half", 1, nil)
    H.receive_item(H.u(ctx), "robofac_enviro_suit", 1, nil)
    H.receive_item(H.u(ctx), "gasfilter_med", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_ce94fef0571f", function(ctx)
    local _u181, _n182 = H.u(ctx), H.npc(ctx)
    if _u181 and _n182 then services.characters.set_faction_relationship(_u181, _n182, "share public goods", true) end
end)

ccb.runtime.handler("dlg_a_dda_3e95a51957d9", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 10, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glasses back.")))
end)

ccb.runtime.handler("dlg_a_dda_162b8f5bd295", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 5, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glasses back.")))
end)

ccb.runtime.handler("dlg_a_dda_80e62868d654", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 4, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glasses back.")))
end)

ccb.runtime.handler("dlg_a_dda_c1052b9b0e46", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 3, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glasses back.")))
end)

ccb.runtime.handler("dlg_a_dda_dfd1b92f2682", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 2, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glasses back.")))
end)

ccb.runtime.handler("dlg_a_dda_d27e8c4e9fd4", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 1, nil)
    ccb.presentation.notice(ctx:expand_text(services.translate("Thanks for bringing the glass back.")))
end)

ccb.runtime.handler("dlg_a_dda_df0892817ffd", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> sets a glass of water on the counter.")))
end)

ccb.runtime.handler("dlg_a_dda_22a7b1bd6868", function(ctx)
    local _n183, _u184 = H.npc(ctx), H.u(ctx)
    if _n183 and _u184 then
        local _pay185 = services.trade.pay(_n183, _u184, math.floor(800))
        if _pay185.ok and _pay185.value == true then
            H.receive_item(_u184, "beer", 2, "bottle_glass")
        else
            ccb.presentation.notice(services.translate("You can't afford it!"))
        end
    end
end)

ccb.runtime.handler("dlg_a_dda_120b90d90d9e", function(ctx)
    local _n186, _u187 = H.npc(ctx), H.u(ctx)
    if _n186 and _u187 then services.trade.pay(_n186, _u187, math.floor(1200)) end
end)

ccb.runtime.handler("dlg_a_dda_376c24fc937b", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> sets a shot and a token on the counter…")))
end)

ccb.runtime.handler("dlg_a_dda_13aed4f4da60", function(ctx)
    local _n188, _u189 = H.npc(ctx), H.u(ctx)
    if _n188 and _u189 then services.trade.pay(_n188, _u189, math.floor(1200)) end
end)

ccb.runtime.handler("dlg_a_dda_5adf4fb1b6c9", function(ctx)
    local _n190, _u191 = H.npc(ctx), H.u(ctx)
    if _n190 and _u191 then services.trade.pay(_n190, _u191, math.floor(1500)) end
end)

ccb.runtime.handler("dlg_a_dda_7768cd91cb4b", function(ctx)
    local _n192 = H.npc(ctx)
    if _n192 then services.npcs.open_companion_missions(_n192, "COMMUNE CROPS") end
end)

ccb.runtime.handler("dlg_a_dda_d1786efd3b7e", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> jots your name down on a ledger and yells out to nearby laborers to begin plowing your new field.")))
end)

ccb.runtime.handler("dlg_a_dda_dff7082eac58", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("After counting your money, <npc_name> directs a nearby laborer to begin constructing a fence around your plot…")))
end)

ccb.runtime.handler("dlg_a_dda_03a40bed2326", function(ctx)
    H.lose_trait(H.npc(ctx), "NPC_CONSTRUCTION_LEV_1")
    H.lose_trait(H.npc(ctx), "NPC_CONSTRUCTION_LEV_2")
end)

ccb.runtime.handler("dlg_a_dda_c4d2591970dd", function(ctx)
    H.lose_trait(H.npc(ctx), "NPC_CONSTRUCTION_LEV_1")
end)

ccb.runtime.handler("dlg_a_dda_d4729b31132d", function(ctx)
    local _n193 = H.npc(ctx)
    if _n193 then services.npcs.open_companion_missions(_n193, "PLANT FIELD") end
end)

ccb.runtime.handler("dlg_a_dda_8d92a1464a92", function(ctx)
    local _n194 = H.npc(ctx)
    if _n194 then services.npcs.open_companion_missions(_n194, "HARVEST FIELD") end
end)

ccb.runtime.handler("dlg_a_dda_d1e14371ac3a", function(ctx)
    H.consume_item(H.u(ctx), "makeshift_crutches", 1, 0)
    ccb.presentation.notice(ctx:expand_text(services.translate("These will have to do…")))
end)

ccb.runtime.handler("dlg_a_dda_c9a8f16599db", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 80, 0)
end)

ccb.runtime.handler("dlg_a_dda_4e70409e125d", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 200, 0)
end)

ccb.runtime.handler("dlg_a_dda_057883a7b153", function(ctx)
    local _n195 = H.npc(ctx)
    if _n195 then services.npcs.open_companion_missions(_n195, "FOREMAN") end
end)

ccb.runtime.handler("dlg_a_dda_18ae4cdcf60d", function(ctx)
    H.find_and_store_loc(H.u(ctx), ctx, "actor", "tacoma_nunez_trailer_arrive", nil, nil, nil, nil)
end)

ccb.runtime.handler("dlg_a_dda_0d12bbe84a7a", function(ctx)
    H.receive_item(H.u(ctx), "commune_prospectus", 1, nil)
end)

ccb.runtime.handler("dlg_a_dda_74a06dbaf8f4", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 75, nil)
end)

ccb.runtime.handler("dlg_a_dda_b97e0f4a1de0", function(ctx)
    H.receive_item(H.u(ctx), "FMCNote", 25, nil)
end)

ccb.runtime.handler("dlg_a_dda_fa123fbbeb4e", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 40, 0)
end)

ccb.runtime.handler("dlg_a_dda_3c7b9f950bdf", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 100, 0)
end)

ccb.runtime.handler("dlg_a_dda_cae9c6cdf218", function(ctx)
    local _n196 = H.npc(ctx)
    if _n196 then services.npcs.open_companion_missions(_n196, "SCAVENGER") end
end)

ccb.runtime.handler("dlg_a_dda_7c9def81e689", function(ctx)
    local _n197 = H.npc(ctx)
    if _n197 then services.npcs.open_companion_missions(_n197, "SCAVENGER") end
end)

ccb.runtime.handler("dlg_a_dda_ff51821394a0", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 800, 0)
end)

ccb.runtime.handler("dlg_a_dda_1229c4bb1f11", function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<npc_name> drops the logs off in the garage…")))
end)

ccb.runtime.handler("dlg_a_dda_7e3a40e0c789", function(ctx)
    H.consume_item(H.u(ctx), "FMCNote", 4800, 0)
end)

ccb.runtime.handler("dlg_a_dda_ec2c95793aea", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mission_cleanup_promises_Boris_mission_1", (H.var_num(H.u(ctx), "mission_cleanup_promises_Boris_mission_1")) + (1))
end)
