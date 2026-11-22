local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and (((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PSYCHIC_KNACK") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and (((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PSYCHIC_KNACK") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5"))) == true
    end
    EOC["EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5"))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_neg_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_neg_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_elevator_physics_glass", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted_hallway", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_elevator_physics_glass", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_surface", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_right", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_left", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_edge_center", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_rcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_lcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_empty_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_mid", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle_entry", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle_surface_entry", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_tentacle_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_empty_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_brain", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_under_brain", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_fin", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_lcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_rcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_l", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_center", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_l_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_center_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_crystal_field", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockB1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockD1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockB3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockD3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_surface_1b_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_roof_1a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_stairshaft_1a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_stairshaft_2a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_device_2_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_device_unfolded_noaccess_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_entry_2_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_road_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_road_guard_north", math.floor(2)) end)()))) == true
    end
    EOC["EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_neg_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_neg_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "vitrified_farm_2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_elevator_physics_glass", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted_hallway", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_distorted_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_elevator_physics_glass", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_surface", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_right", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_left", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_neck_edge_center", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_rcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_lcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_empty_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_mid", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle_entry", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_tentacle_surface_entry", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_tentacle_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_bowels_empty_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_brain", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_under_brain", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_edge", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_fin", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_lcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_rcorner", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_l", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_center", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_l_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_r_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_head_neck_center_decap", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_crystal_field", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockB1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockD1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockB3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_blockD3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block2D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block3D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block4D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5B1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5D1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5B3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "psi_phavian_lab_block5D3", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_surface_1b_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_roof_1a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_stairshaft_1a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_stairshaft_2a_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_device_2_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_device_unfolded_noaccess_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_entry_2_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_road_north", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_road_guard_north", math.floor(2)) end)()))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_glass_deep", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_glass", math.floor(2)) end)()) or H.char_at_om_location(H.u(ctx), "microlab_portal_elevator_nether_glass") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "void_spider_lair", math.floor(2)) end)()) or (services.gameplay.environment.dimension() == "string_dimension") or (services.gameplay.environment.dimension() == "netherum_labyrinth") or (services.gameplay.environment.dimension() == "netherum_labyrinth2") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "inner_cabins_depths", math.floor(2)) end)()) or ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_floor_warped" end)())) or (H.char_has_trait(H.u(ctx), "DEFORMED_INTERSTICE") == 1))) == true
    end
    EOC["EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_glass_deep", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "nether_glass", math.floor(2)) end)()) or H.char_at_om_location(H.u(ctx), "microlab_portal_elevator_nether_glass") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "void_spider_lair", math.floor(2)) end)()) or (services.gameplay.environment.dimension() == "string_dimension") or (services.gameplay.environment.dimension() == "netherum_labyrinth") or (services.gameplay.environment.dimension() == "netherum_labyrinth2") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "inner_cabins_depths", math.floor(2)) end)()) or ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_floor_warped" end)())) or (H.char_has_trait(H.u(ctx), "DEFORMED_INTERSTICE") == 1))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_perfect_shot"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or H.char_has_item(H.npc(ctx), "pyrokinetic_torch_weld") or ((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_1") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_2") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_3") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_4") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_5") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_6") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_7") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_8") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_9") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_10") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_11") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_12") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_13") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_14") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_15") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_16") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_17") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_18") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_19") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_20") or ((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_clair_perfect_shot"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or H.char_has_item(H.npc(ctx), "pyrokinetic_torch_weld") or ((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_1") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_2") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_3") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_4") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_5") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_6") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_7") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_8") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_9") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_10") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_11") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_12") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_13") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_14") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_15") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_16") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_17") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_18") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_19") or H.char_has_item(H.npc(ctx), "telekin_lifting_jack_20") or ((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true))) and (not (H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION"))) and (not ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_spell_level(H.u(ctx), "telepathic_shield") >= (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 10) + (math.max(H.char_school_level(H.u(ctx), "BIOKINETIC"), H.char_school_level(H.u(ctx), "CLAIRSENTIENT"), H.char_school_level(H.u(ctx), "ELECTROKINETIC"), H.char_school_level(H.u(ctx), "PHOTOKINETIC"), H.char_school_level(H.u(ctx), "PYROKINETIC"), H.char_school_level(H.u(ctx), "TELEPATH"), H.char_school_level(H.u(ctx), "TELEKINETIC"), H.char_school_level(H.u(ctx), "TELEPORTER"), H.char_school_level(H.u(ctx), "VITAKINETIC")) / 3)) + (H.var_num(H.u(ctx), "awakening_countup") / 3)))))))) == true
    end
    EOC["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true))) and (not (H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION"))) and (not ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_spell_level(H.u(ctx), "telepathic_shield") >= (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 10) + (math.max(H.char_school_level(H.u(ctx), "BIOKINETIC"), H.char_school_level(H.u(ctx), "CLAIRSENTIENT"), H.char_school_level(H.u(ctx), "ELECTROKINETIC"), H.char_school_level(H.u(ctx), "PHOTOKINETIC"), H.char_school_level(H.u(ctx), "PYROKINETIC"), H.char_school_level(H.u(ctx), "TELEPATH"), H.char_school_level(H.u(ctx), "TELEKINETIC"), H.char_school_level(H.u(ctx), "TELEPORTER"), H.char_school_level(H.u(ctx), "VITAKINETIC")) / 3)) + (H.var_num(H.u(ctx), "awakening_countup") / 3)))))))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_HAS_MIND"] = function(ctx)
        return (((((not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PSI_NULL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PSI_NULL")).value == true))))) and H.char_has_flag(H.npc(ctx), "HAS_MIND")) or ((not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PSI_NULL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PSI_NULL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and H.char_has_flag(H.npc(ctx), "HUMAN")) or ((H.char_snap(H.npc(ctx)) or {}).npc == true)) and (not (((function() local eg = H.safe_id('effect', "eff_monster_immune_to_telepathy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.npc(ctx), "TEEP_IMMUNE"))))) == true
    end
    EOC["EOC_CONDITION_HAS_MIND"] = function(ctx)
    if (((((not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PSI_NULL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PSI_NULL")).value == true))))) and H.char_has_flag(H.npc(ctx), "HAS_MIND")) or ((not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PSI_NULL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PSI_NULL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and H.char_has_flag(H.npc(ctx), "HUMAN")) or ((H.char_snap(H.npc(ctx)) or {}).npc == true)) and (not (((function() local eg = H.safe_id('effect', "eff_monster_immune_to_telepathy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.npc(ctx), "TEEP_IMMUNE"))))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_MONSTER_MAINTAINING_PSI_POWER"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_monster_hardened_skin") or H.creature_has_effect(H.u(ctx), "effect_monster_heightened_reflex") or H.creature_has_effect(H.u(ctx), "effect_monster_heightened_reflex_enhanced") or H.creature_has_effect(H.u(ctx), "effect_psi_biokin3_hurricane_blows") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses_2") or H.creature_has_effect(H.u(ctx), "effect_feral_combat_sense_2") or H.creature_has_effect(H.u(ctx), "effect_feral_combat_sense_3") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses_3") or H.creature_has_effect(H.u(ctx), "effect_feral_regeneration") or H.creature_has_effect(H.u(ctx), "effect_pattern_screamer_rock_thrower") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration_enhanced") or H.creature_has_effect(H.u(ctx), "effect_monster_pyrokinetic_fire_immunity") or H.creature_has_effect(H.u(ctx), "effect_monster_momentum_alteration") or H.creature_has_effect(H.u(ctx), "effect_monster_inertial_barrier") or H.creature_has_effect(H.u(ctx), "effect_monster_inertial_barrier_improved") or H.creature_has_effect(H.u(ctx), "effect_telepath_network_monster_effect"))) == true
    end
    EOC["EOC_CONDITION_MONSTER_MAINTAINING_PSI_POWER"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_monster_hardened_skin") or H.creature_has_effect(H.u(ctx), "effect_monster_heightened_reflex") or H.creature_has_effect(H.u(ctx), "effect_monster_heightened_reflex_enhanced") or H.creature_has_effect(H.u(ctx), "effect_psi_biokin3_hurricane_blows") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses_2") or H.creature_has_effect(H.u(ctx), "effect_feral_combat_sense_2") or H.creature_has_effect(H.u(ctx), "effect_feral_combat_sense_3") or H.creature_has_effect(H.u(ctx), "effect_feral_heightened_senses_3") or H.creature_has_effect(H.u(ctx), "effect_feral_regeneration") or H.creature_has_effect(H.u(ctx), "effect_pattern_screamer_rock_thrower") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration_enhanced") or H.creature_has_effect(H.u(ctx), "effect_monster_pyrokinetic_fire_immunity") or H.creature_has_effect(H.u(ctx), "effect_monster_momentum_alteration") or H.creature_has_effect(H.u(ctx), "effect_monster_inertial_barrier") or H.creature_has_effect(H.u(ctx), "effect_monster_inertial_barrier_improved") or H.creature_has_effect(H.u(ctx), "effect_telepath_network_monster_effect"))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "BAC") > 1000) or ((function() local eg = H.safe_id('effect', "winded"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "weed_high"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "high"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "datura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "nausea"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "meth"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "BAC") > 1000) or ((function() local eg = H.safe_id('effect', "winded"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "weed_high"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "high"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "datura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "nausea"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "meth"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "onfire"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT"] = function(ctx)
        return ((((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) == true
    end
    EOC["EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT"] = function(ctx)
    if ((((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) then
        local _ach1 = H.safe_id("achievement", "mom_gain_any_nether_attunement")
        if _ach1 then services.achievements.complete(_ach1) end
        H.run_eoc("EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT_FURTHER_CHECKS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT_FURTHER_CHECKS"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and ((function() local eg = H.safe_id('effect', "effect_disease_psionic_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT_FURTHER_CHECKS"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and ((function() local eg = H.safe_id('effect', "effect_disease_psionic_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        if ((function() local eg = H.safe_id('effect', "effect_disease_psionic_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 4).value == true end)()) then
            local _ach2 = H.safe_id("achievement", "mom_gain_rank_four_nether_attunement")
            if _ach2 then services.achievements.complete(_ach2) end
        end
        if ((function() local eg = H.safe_id('effect', "effect_disease_psionic_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 8).value == true end)()) then
            local _ach3 = H.safe_id("achievement", "mom_gain_rank_eight_nether_attunement")
            if _ach3 then services.achievements.complete(_ach3) end
        end
        if ((function() local eg = H.safe_id('effect', "effect_disease_psionic_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 12).value == true end)()) then
            local _ach4 = H.safe_id("achievement", "mom_gain_maximum_nether_attunement")
            if _ach4 then services.achievements.complete(_ach4) end
        end
        do local _t = math.max(1, math.floor(2)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT_FURTHER_CHECKS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_BURNING_BRIGHT_RAISE_ATTUNEMENT"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1)) == true
    end
    EOC["EOC_PERK_BURNING_BRIGHT_RAISE_ATTUNEMENT"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1)) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(6)) + 4); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_XE_RAISE_ATTUNEMENT_NETHER_SORCERY_INTERACTION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_xe_nether_resonance_consequences"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_XE_RAISE_ATTUNEMENT_NETHER_SORCERY_INTERACTION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_xe_nether_resonance_consequences"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("context", nil, ctx, "consequence_duration", (((ctx:get_number("difficulty") or 0) * 25) * services.random.native_float(0.66, 1.33)))
        if services.random.native_probability(((ctx:get_number("consequence_duration") or 0)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "effect_xe_nether_resonance_consequences", (ctx:get_number("consequence_duration") or 0), nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_MOM_FIFTH_SUN_ON_SEEING_YRAX_APEIROHEDRON"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "FIFTH_SUN_PEOPLE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "fifth_sun_and_seen_yrax_apeirohedron", "")))))))) == true
    end
    EOC["EOC_MOM_FIFTH_SUN_ON_SEEING_YRAX_APEIROHEDRON"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "FIFTH_SUN_PEOPLE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "fifth_sun_and_seen_yrax_apeirohedron", "")))))))) then
        H.set_var("actor", H.u(ctx), ctx, "fifth_sun_and_seen_yrax_apeirohedron", "yes")
        services.messages.add(ctx:expand_text(services.translate("A shiver runs down your spine as the golden shape suddenly looms out of the impenetrable abyss.  This is beyond anything possible on this primitive world.  It is beyond even anything in the huecachane civilizations known to the Ēxcan Tlahtōlōyan.  This is a thing of the First Sun, and before it you are as an ant at the feet of the gods.")), "mixed")
        return true
    end
    return false
    end
    COND["EOC_FORCE_FIELD_GENERATOR_ACTIVATION_2"] = function(ctx)
        return ((services.random.native_float(0, 99) >= 3)) == true
    end
    EOC["EOC_FORCE_FIELD_GENERATOR_ACTIVATION_2"] = function(ctx)
    if ((services.random.native_float(0, 99) >= 3)) then
        H.consume_item(H.u(ctx), "matrix_crystal_drained", 1, 0)
        services.messages.add(ctx:expand_text(services.translate("The matrix crystal cracks into pieces as the device activates!")), "mixed")
        H.eoc_add_effect(H.u(ctx), "force_field_generated", (2 * services.random.native_float(1, 6)), nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The device makes a whining sound and there is a sharp smell of burnt plastic!")), "bad")
        H.consume_item(H.u(ctx), "matrix_crystal_drained", 1, 0)
        H.consume_item(H.u(ctx), "force_field_generator", 1, 0)
        H.eoc_spawn_item(H.u(ctx), "force_field_generator_broken", 1, false, false, nil)
        return false
    end
    end
    COND["EOC_FORCE_FIELD_GENERATOR_ACTIVATION"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "matrix_crystal_drained", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_FORCE_FIELD_GENERATOR_ACTIVATION"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "matrix_crystal_drained", math.floor(1), math.floor(0))) then
        H.run_eoc("EOC_FORCE_FIELD_GENERATOR_ACTIVATION_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without a matrix crystal to power it, flipping the toggle does nothing.")), "bad")
        return false
    end
    end
    COND["EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER"] = function(ctx)
        return ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PSYSHIELD_PARTIAL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PSYSHIELD_PARTIAL")).value == true)) == true
    end
    EOC["EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER"] = function(ctx)
    if ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PSYSHIELD_PARTIAL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PSYSHIELD_PARTIAL")).value == true)) then
        H.eoc_add_effect(H.u(ctx), "effect_psyshield_protection", 480, nil, nil, nil)
        return true
    else
        do local _eg = H.safe_id('effect', "effect_psyshield_protection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_BEEP"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(240), math.floor(420); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_BEEP"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_BEEP"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) then
        services.messages.add(ctx:expand_text(services.translate("The transporter remote emits a small beep.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(2), "music", ctx:expand_text(services.translate("a small beep")), false) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_BEEP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES"] == nil or E.cond["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Confirm the Coordinates")), description = ctx:expand_text(services.translate("Activate the remote and transport yourself to your destination.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES" end end
            do local _en = (E.cond["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO"] == nil or E.cond["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Turn the remove off")), description = ctx:expand_text(services.translate("Turn the remote off for now.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_3"] = function(ctx)
        return ((services.random.native_probability(((H.creature_effect_intensity(H.u(ctx), "psi_nether_attention") * 2)), (100)) and (not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "TELEPATHICDAMPENER_SHIELD") == 1))))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_3"] = function(ctx)
    if ((services.random.native_probability(((H.creature_effect_intensity(H.u(ctx), "psi_nether_attention") * 2)), (100)) and (not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "TELEPATHICDAMPENER_SHIELD") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("And as you look around, you notice you're not the only one who stepped out of the Nether.")), "bad")
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_NETHER_BREACH"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(1, 3)), min_radius = math.floor(5), max_radius = math.floor(25) }); 
        end end
        return true
    end
    return false
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_2"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_2"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_cast_spell(H.u(ctx), "pure_translocate_power", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("There is a long moment of darkness and terrible cold that seems like it will freeze your heart, all the while filled with the sensation of watchful eyes, and then you are somewhere else.  When you arrive, you can't help but glance over your shoulder.")), "neutral")
        H.run_eoc("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_3", ctx, nil, nil, nil)
        return true
    else
        H.eoc_cast_spell(H.u(ctx), "pure_translocate_power", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("There is a long moment of darkness and terrible cold that seems like it will freeze your heart, and then you are somewhere else.")), "neutral")
        return false
    end
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) then
        H.consume_item(H.u(ctx), "psionic_transporter_remote_on", 1, 0)
        H.eoc_spawn_item(H.u(ctx), "psionic_transporter_remote_broken", 1, false, false, nil)
        H.run_eoc("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_YES_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO_2"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "transform", { target = _p }) end end
    return true
    end
    COND["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) == true
    end
    EOC["EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "psionic_transporter_remote_on", math.floor(1), math.floor(0))) then
        services.messages.add(ctx:expand_text(services.translate("Instead of confirming the destination, you press the button and turn the transporter remote off.")), "neutral")
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "psionic_transporter_remote_on" } }, { "EOC_PSI_TRANSPORTER_REMOTE_TELEPORT_TRANSPORT_NO_2" }, {  })
        return true
    end
    return false
    end
    COND["EOC_DRINKING_NETHER_WATER_NIGHTMARES_GAIN"] = function(ctx)
        return ((((("effect_black_nether_water_disease") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_DRINKING_NETHER_WATER_NIGHTMARES_GAIN"] = function(ctx)
    if ((((("effect_black_nether_water_disease") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.eoc_add_effect(H.u(ctx), "effect_black_nether_water_nightmares", 86400, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DRINKING_NETHER_WATER_NIGHTMARES_OCCUR"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_black_nether_water_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (4)))) == true
    end
    EOC["EOC_DRINKING_NETHER_WATER_NIGHTMARES_OCCUR"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_black_nether_water_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (4)))) then
        services.messages.add((services.snippets.native_random("black_nether_water_nightmares") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        do local _eg = H.safe_id('effect', "effect_black_nether_water_nightmares"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_black_nether_water_nightmares"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    EOC["EOC_MOM_ABJURATION_STONE_EFFECTS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "mom_abjuration_stone_effects", false, nil)
    return true
    end
    EOC["EOC_MOM_CASCADE_STONE_EFFECTS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_mom_cascade_stone", (180 + services.random.native_int(0, H.round_half_away(3600))), nil, nil, nil)
    do local _g = H.safe_id('mutation', "PSI_TORRENTIAL_CHANNELING_active"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_MOM_CASCADE_STONE_WEAR_OFF"] = function(ctx)
        return (((("effect_mom_cascade_stone") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_MOM_CASCADE_STONE_WEAR_OFF"] = function(ctx)
    if (((("effect_mom_cascade_stone") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.lose_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active")
        return true
    end
    return false
    end
    COND["EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS"] = function(ctx)
        return (((("effect_psi_dimensionally_anchored") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS"] = function(ctx)
    if (((("effect_psi_dimensionally_anchored") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.eoc_add_effect(H.u(ctx), "effect_mom_dimensionally_anchored_eventually_cancel_concentration", 100, nil, nil, nil)
        H.run_eoc("EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS_ESCALATING_CHECKER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS_ESCALATING_CHECKER"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) and ((function() local eg = H.safe_id('effect', "effect_mom_dimensionally_anchored_eventually_cancel_concentration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS_ESCALATING_CHECKER"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) and ((function() local eg = H.safe_id('effect', "effect_mom_dimensionally_anchored_eventually_cancel_concentration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        if services.random.native_probability((H.creature_effect_intensity(H.u(ctx), "effect_mom_dimensionally_anchored_eventually_cancel_concentration")), (100)) then
            do local _eg = H.safe_id('effect', "effect_mom_dimensionally_anchored_eventually_cancel_concentration"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        else
            do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS_ESCALATING_CHECKER"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_RESET_TELEPATHIC_STEALING_TIMER"] = function(ctx)
        return ((H.global_var_num("telepathically_stole_recently") >= 1)) == true
    end
    EOC["EOC_RESET_TELEPATHIC_STEALING_TIMER"] = function(ctx)
    if ((H.global_var_num("telepathically_stole_recently") >= 1)) then
        H.set_var("global", nil, ctx, "telepathically_stole_recently", 0)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_METAPHYSICS_SKILL_EXP_SUCCESS"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((ctx:get_number("success") or 0) ~= H.global_var_num("false")))) == true
    end
    EOC["EOC_PSIONICS_METAPHYSICS_SKILL_EXP_SUCCESS"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((ctx:get_number("success") or 0) ~= H.global_var_num("false")))) then
        local _a5 = H.u(ctx)
        local _sg6 = H.safe_id("skill", "metaphysics")
        if _a5 and _sg6 then services.skills.set(_a5, _sg6, { exercise_raw = math.floor((H.char_skill_exp(_a5, "metaphysics", true)) + (((100 * (ctx:get_number("difficulty") or 0)) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_METAPHYSICS_SKILL_EXP_FAILURE"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((ctx:get_number("success") or 0) == H.global_var_num("false")))) == true
    end
    EOC["EOC_PSIONICS_METAPHYSICS_SKILL_EXP_FAILURE"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((ctx:get_number("success") or 0) == H.global_var_num("false")))) then
        local _a7 = H.u(ctx)
        local _sg8 = H.safe_id("skill", "metaphysics")
        if _a7 and _sg8 then services.skills.set(_a7, _sg8, { exercise_raw = math.floor((H.char_skill_exp(_a7, "metaphysics", true)) + (((25 * (ctx:get_number("difficulty") or 0)) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_PSI_NEUTRALIZED_ENDS_ALL_POWERS"] = function(ctx)
        return ((((("effect_psi_neutralized") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_turn_off_powers") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_PSIONICS_PSI_NEUTRALIZED_ENDS_ALL_POWERS"] = function(ctx)
    if ((((("effect_psi_neutralized") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_turn_off_powers") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_CONCENTRATION_EFFECT_GAIN_CHECK"] = function(ctx)
        return (((((("winded") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("nausea") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("asthma") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("datura") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("onfire") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("staggered_character") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("venom_dmg") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("venom_pain") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("taint") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("visuals") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("hallu") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("formication") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("meth") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weed_high") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("high") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("drunk") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("zapped") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_reduced_breathing") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_null") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_null_unbound") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_dazed_zap") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("downed") == (H.var_str("context", nil, ctx, "effect", "")))) or (((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((ctx:get_number("intensity") or 0) == 5)) or (((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((ctx:get_number("intensity") or 0) == 11))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) == true
    end
    EOC["EOC_PSIONICS_CONCENTRATION_EFFECT_GAIN_CHECK"] = function(ctx)
    if (((((("winded") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("nausea") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("asthma") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("datura") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("onfire") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("staggered_character") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("venom_dmg") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("venom_pain") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("taint") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("visuals") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("hallu") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("formication") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("meth") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weed_high") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("high") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("drunk") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("zapped") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_reduced_breathing") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_null") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("effect_psi_null_unbound") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_dazed_zap") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("downed") == (H.var_str("context", nil, ctx, "effect", "")))) or (((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((ctx:get_number("intensity") or 0) == 5)) or (((("effect_disease_psionic_drain") == (H.var_str("context", nil, ctx, "effect", "")))) and ((ctx:get_number("intensity") or 0) == 11))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) then
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MINDOVERMATTER_PRE_COLD_TO_COLD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "pre_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MINDOVERMATTER_PRE_COLD_TO_COLD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "pre_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "pre_cold"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "cold", services.random.native_float(86400, 1209600), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MINDOVERMATTER_PRE_FLU_TO_FLU"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MINDOVERMATTER_PRE_FLU_TO_FLU"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "pre_flu"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "flu", services.random.native_float(259200, 864000), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_VIRAL_TO_CONJUNCTIVITIS_VIRAL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_VIRAL_TO_CONJUNCTIVITIS_VIRAL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "conjunctivitis_viral", (services.random.native_int(0, H.round_half_away(259200)) + 432000), "eyes", nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_BACTERIAL_TO_CONJUNCTIVITIS_BACTERIAL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MINDOVERMATTER_PRE_CONJUNCTIVITIS_BACTERIAL_TO_CONJUNCTIVITIS_BACTERIAL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "conjunctivitis_bacterial", (services.random.native_int(0, H.round_half_away(259200)) + 432000), "eyes", nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FEAR_PARALYZE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "fearparalyze"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_FEAR_PARALYZE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "fearparalyze"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_FEAR_PARALYZE1", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FEAR_PARALYZE1"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_FEAR_PARALYZE1"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_FEAR_PARALYZE2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Some <npc_name> tries to intrude into your thoughts, but your telepathic shield reflects it!")), "warning")
        return false
    end
    end
    COND["EOC_STARE"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) == true
    end
    EOC["EOC_STARE"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a strange reverberation across your body.")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE1", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_STARE1"] = function(ctx)
        return ((H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true)) == true
    end
    EOC["EOC_STARE1"] = function(ctx)
    if ((H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("You sense <npc_name> trying to enter your mind, but your magic protects you!")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE1_5", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_CONDUIT_VALUE_INCREASER_2"] = function(ctx)
        return ((H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") < 25)) == true
    end
    EOC["EOC_NETHER_CONDUIT_VALUE_INCREASER_2"] = function(ctx)
    if ((H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") < 25)) then
        H.set_var("actor", H.u(ctx), ctx, "nether_conduit_repeated_channeling_value", (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) + (services.random.native_float(1, 2.4)))
        return true
    end
    return false
    end
    COND["EOC_NETHER_CONDUIT_VALUE_INCREASER"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_NETHER_CONDUIT_VALUE_INCREASER"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.run_eoc("EOC_NETHER_CONDUIT_VALUE_INCREASER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") / 3)) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") / 3)) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) then
        H.run_eoc("EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD", ctx, nil, nil, nil)
        H.run_eoc("EOC_XE_RAISE_ATTUNEMENT_NETHER_SORCERY_INTERACTION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) then
        H.run_eoc("EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD", ctx, nil, nil, nil)
        H.run_eoc("EOC_XE_RAISE_ATTUNEMENT_NETHER_SORCERY_INTERACTION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_SCALING_CHECK"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") < 15)) == true
    end
    EOC["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_SCALING_CHECK"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") < 15)) then
        H.run_eoc("EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) then
        if (not (((function() local eg = H.safe_id('effect', "effect_no_nether_attunement_from_channel"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", (ctx:get_number("difficulty") or 0))
            H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_SCALING_CHECK", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(1)) + (services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers"))) / 2)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(3)) + (services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers"))) / 2)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") / 2))) + services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = ((services.random.native_int(0, H.round_half_away(H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")) + services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER_MAINTENANCE"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") / 3)) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER_MAINTENANCE"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") / 3)) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) then
        H.run_eoc("EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_MAINTENANCE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER_MAINTENANCE"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER_MAINTENANCE"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) + (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") * 3))), (100))) then
        H.run_eoc("EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_MAINTENANCE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") < 15)) == true
    end
    EOC["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") < 15)) then
        H.run_eoc("EOC_PERK_BURNING_BRIGHT_RAISE_ATTUNEMENT", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_maintenance", ctx, nil, nil, nil)
        H.run_eoc("EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_CHECKER_MAINTENANCE", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_PERK_BURNING_BRIGHT_RAISE_ATTUNEMENT", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_maintenance", ctx, nil, nil, nil)
        H.run_eoc("EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_CHECKER_MAINTENANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_MAINTENANCE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_BELOW_THRESHOLD_MAINTENANCE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("As you concentrate on your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(1)) + (services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers"))) / 2)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you concentrate on your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(3)) + (services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers"))) / 2)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_MAINTENANCE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_RAISE_ATTUNEMENT_ABOVE_THRESHOLD_MAINTENANCE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("As you concentrate on your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away((H.var_num(H.u(ctx), "latest_channeled_power_difficulty") / 2))) + services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you concentrate on your powers, you feel a strange tingling sensation.")), "mixed")
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = ((services.random.native_int(0, H.round_half_away(H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")) + services.random.native_int(0, H.round_half_away(H.char_vitamin(H.u(ctx), "vitamin_maintained_powers")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_NETHER_CONDUIT_VALUE_DECREASER"] = function(ctx)
        return ((H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") > 0)) == true
    end
    EOC["EOC_NETHER_CONDUIT_VALUE_DECREASER"] = function(ctx)
    if ((H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") > 0)) then
        H.set_var("actor", H.u(ctx), ctx, "nether_conduit_repeated_channeling_value", (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value")) - (1))
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "nether_conduit_repeated_channeling_value", 0)
        return false
    end
    end
    COND["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_active"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_active"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away((3 + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") / 5)))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
end
