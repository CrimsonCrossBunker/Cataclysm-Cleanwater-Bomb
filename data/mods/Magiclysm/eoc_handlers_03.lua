local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_MAGICLYSM_MELEE_MONSTER_REMOVE_INVISIBILITY_EFFECTS"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_shape_of_dust"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_technomancer_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_MAGICLYSM_MELEE_MONSTER_REMOVE_INVISIBILITY_EFFECTS"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_shape_of_dust"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_technomancer_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_shape_of_dust"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_technomancer_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "telepathic_ignorance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.npc(ctx) and _eg then services.effects.remove(H.npc(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_MELEE_CHARACTER_REMOVE_INVISIBILITY_EFFECTS"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_shape_of_dust"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_technomancer_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_MAGICLYSM_MELEE_CHARACTER_REMOVE_INVISIBILITY_EFFECTS"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_shape_of_dust"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_technomancer_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_shape_of_dust"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_technomancer_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "telepathic_ignorance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.npc(ctx) and _eg then services.effects.remove(H.npc(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_ORB_OF_LIGHT_CLASSLESS_REMOVED_ON_DAMAGE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_classless_magic_light"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MAGICLYSM_ORB_OF_LIGHT_CLASSLESS_REMOVED_ON_DAMAGE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_classless_magic_light"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_classless_magic_light"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER_2"] = function(ctx)
        return (((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(3)) end)()))))) == true
    end
    EOC["EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER_2"] = function(ctx)
    if (((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(3)) end)()))))) then
        H.set_var("actor", H.u(ctx), ctx, "magiclysm_elf_is_in_wilderness", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "magiclysm_elf_is_in_wilderness", 0)
        return false
    end
    end
    COND["EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ELVEN_NEED_FOR_WILDERNESS") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ELVEN_NEED_FOR_WILDERNESS") == 1)) then
        H.run_eoc("EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PLAYER_IN_FORGE"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "forge_x0y0z0") or H.char_at_om_location(H.u(ctx), "forge_x1y0z0") or H.char_at_om_location(H.u(ctx), "forge_x2y0z0") or H.char_at_om_location(H.u(ctx), "forge_x3y0z0") or H.char_at_om_location(H.u(ctx), "forge_x0y1z0") or H.char_at_om_location(H.u(ctx), "forge_x1y1z0") or H.char_at_om_location(H.u(ctx), "forge_x2y1z0") or H.char_at_om_location(H.u(ctx), "forge_x3y1z0") or H.char_at_om_location(H.u(ctx), "forge_x0y2z0") or H.char_at_om_location(H.u(ctx), "forge_x1y2z0") or H.char_at_om_location(H.u(ctx), "forge_x2y2z0") or H.char_at_om_location(H.u(ctx), "forge_x3y2z0") or H.char_at_om_location(H.u(ctx), "forge_x0y3z0") or H.char_at_om_location(H.u(ctx), "forge_x1y3z0") or H.char_at_om_location(H.u(ctx), "forge_x2y3z0") or H.char_at_om_location(H.u(ctx), "forge_x3y3z0") or H.char_at_om_location(H.u(ctx), "forge_x0y0z1") or H.char_at_om_location(H.u(ctx), "forge_x1y0z1") or H.char_at_om_location(H.u(ctx), "forge_x2y0z1") or H.char_at_om_location(H.u(ctx), "forge_x3y0z1") or H.char_at_om_location(H.u(ctx), "forge_x0y1z1") or H.char_at_om_location(H.u(ctx), "forge_x1y1z1") or H.char_at_om_location(H.u(ctx), "forge_x2y1z1") or H.char_at_om_location(H.u(ctx), "forge_x3y1z1") or H.char_at_om_location(H.u(ctx), "forge_x0y2z1") or H.char_at_om_location(H.u(ctx), "forge_x1y2z1") or H.char_at_om_location(H.u(ctx), "forge_x2y2z1") or H.char_at_om_location(H.u(ctx), "forge_x3y2z1") or H.char_at_om_location(H.u(ctx), "forge_x0y3z1") or H.char_at_om_location(H.u(ctx), "forge_x1y3z1") or H.char_at_om_location(H.u(ctx), "forge_x2y3z1") or H.char_at_om_location(H.u(ctx), "forge_x3y3z1") or H.char_at_om_location(H.u(ctx), "forge_x0y0z2") or H.char_at_om_location(H.u(ctx), "forge_x1y0z2") or H.char_at_om_location(H.u(ctx), "forge_x2y0z2") or H.char_at_om_location(H.u(ctx), "forge_x3y0z2") or H.char_at_om_location(H.u(ctx), "forge_x0y1z2") or H.char_at_om_location(H.u(ctx), "forge_x1y1z2") or H.char_at_om_location(H.u(ctx), "forge_x2y1z2") or H.char_at_om_location(H.u(ctx), "forge_x3y1z2") or H.char_at_om_location(H.u(ctx), "forge_x0y2z2") or H.char_at_om_location(H.u(ctx), "forge_x1y2z2") or H.char_at_om_location(H.u(ctx), "forge_x2y2z2") or H.char_at_om_location(H.u(ctx), "forge_x3y2z2") or H.char_at_om_location(H.u(ctx), "forge_x0y3z2") or H.char_at_om_location(H.u(ctx), "forge_x1y3z2") or H.char_at_om_location(H.u(ctx), "forge_x2y3z2") or H.char_at_om_location(H.u(ctx), "forge_x3y3z2") or H.char_at_om_location(H.u(ctx), "forge_x0y0z3") or H.char_at_om_location(H.u(ctx), "forge_x1y0z3") or H.char_at_om_location(H.u(ctx), "forge_x2y0z3") or H.char_at_om_location(H.u(ctx), "forge_x3y0z3") or H.char_at_om_location(H.u(ctx), "forge_x0y1z3") or H.char_at_om_location(H.u(ctx), "forge_x1y1z3") or H.char_at_om_location(H.u(ctx), "forge_x2y1z3") or H.char_at_om_location(H.u(ctx), "forge_x3y1z3") or H.char_at_om_location(H.u(ctx), "forge_x0y2z3") or H.char_at_om_location(H.u(ctx), "forge_x1y2z3") or H.char_at_om_location(H.u(ctx), "forge_x2y2z3") or H.char_at_om_location(H.u(ctx), "forge_x3y2z3") or H.char_at_om_location(H.u(ctx), "forge_x0y3z3") or H.char_at_om_location(H.u(ctx), "forge_x1y3z3") or H.char_at_om_location(H.u(ctx), "forge_x2y3z3") or H.char_at_om_location(H.u(ctx), "forge_x3y3z3") or H.char_at_om_location(H.u(ctx), "forge_x0y0z4") or H.char_at_om_location(H.u(ctx), "forge_x1y0z4") or H.char_at_om_location(H.u(ctx), "forge_x2y0z4") or H.char_at_om_location(H.u(ctx), "forge_x3y0z4") or H.char_at_om_location(H.u(ctx), "forge_x0y1z4") or H.char_at_om_location(H.u(ctx), "forge_x1y1z4") or H.char_at_om_location(H.u(ctx), "forge_x2y1z4") or H.char_at_om_location(H.u(ctx), "forge_x3y1z4") or H.char_at_om_location(H.u(ctx), "forge_x0y2z4") or H.char_at_om_location(H.u(ctx), "forge_x1y2z4") or H.char_at_om_location(H.u(ctx), "forge_x2y2z4") or H.char_at_om_location(H.u(ctx), "forge_x3y2z4") or H.char_at_om_location(H.u(ctx), "forge_x0y3z4") or H.char_at_om_location(H.u(ctx), "forge_x1y3z4") or H.char_at_om_location(H.u(ctx), "forge_x2y3z4") or H.char_at_om_location(H.u(ctx), "forge_x3y3z4"))) == true
    end
    EOC["EOC_PLAYER_IN_FORGE"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "forge_x0y0z0") or H.char_at_om_location(H.u(ctx), "forge_x1y0z0") or H.char_at_om_location(H.u(ctx), "forge_x2y0z0") or H.char_at_om_location(H.u(ctx), "forge_x3y0z0") or H.char_at_om_location(H.u(ctx), "forge_x0y1z0") or H.char_at_om_location(H.u(ctx), "forge_x1y1z0") or H.char_at_om_location(H.u(ctx), "forge_x2y1z0") or H.char_at_om_location(H.u(ctx), "forge_x3y1z0") or H.char_at_om_location(H.u(ctx), "forge_x0y2z0") or H.char_at_om_location(H.u(ctx), "forge_x1y2z0") or H.char_at_om_location(H.u(ctx), "forge_x2y2z0") or H.char_at_om_location(H.u(ctx), "forge_x3y2z0") or H.char_at_om_location(H.u(ctx), "forge_x0y3z0") or H.char_at_om_location(H.u(ctx), "forge_x1y3z0") or H.char_at_om_location(H.u(ctx), "forge_x2y3z0") or H.char_at_om_location(H.u(ctx), "forge_x3y3z0") or H.char_at_om_location(H.u(ctx), "forge_x0y0z1") or H.char_at_om_location(H.u(ctx), "forge_x1y0z1") or H.char_at_om_location(H.u(ctx), "forge_x2y0z1") or H.char_at_om_location(H.u(ctx), "forge_x3y0z1") or H.char_at_om_location(H.u(ctx), "forge_x0y1z1") or H.char_at_om_location(H.u(ctx), "forge_x1y1z1") or H.char_at_om_location(H.u(ctx), "forge_x2y1z1") or H.char_at_om_location(H.u(ctx), "forge_x3y1z1") or H.char_at_om_location(H.u(ctx), "forge_x0y2z1") or H.char_at_om_location(H.u(ctx), "forge_x1y2z1") or H.char_at_om_location(H.u(ctx), "forge_x2y2z1") or H.char_at_om_location(H.u(ctx), "forge_x3y2z1") or H.char_at_om_location(H.u(ctx), "forge_x0y3z1") or H.char_at_om_location(H.u(ctx), "forge_x1y3z1") or H.char_at_om_location(H.u(ctx), "forge_x2y3z1") or H.char_at_om_location(H.u(ctx), "forge_x3y3z1") or H.char_at_om_location(H.u(ctx), "forge_x0y0z2") or H.char_at_om_location(H.u(ctx), "forge_x1y0z2") or H.char_at_om_location(H.u(ctx), "forge_x2y0z2") or H.char_at_om_location(H.u(ctx), "forge_x3y0z2") or H.char_at_om_location(H.u(ctx), "forge_x0y1z2") or H.char_at_om_location(H.u(ctx), "forge_x1y1z2") or H.char_at_om_location(H.u(ctx), "forge_x2y1z2") or H.char_at_om_location(H.u(ctx), "forge_x3y1z2") or H.char_at_om_location(H.u(ctx), "forge_x0y2z2") or H.char_at_om_location(H.u(ctx), "forge_x1y2z2") or H.char_at_om_location(H.u(ctx), "forge_x2y2z2") or H.char_at_om_location(H.u(ctx), "forge_x3y2z2") or H.char_at_om_location(H.u(ctx), "forge_x0y3z2") or H.char_at_om_location(H.u(ctx), "forge_x1y3z2") or H.char_at_om_location(H.u(ctx), "forge_x2y3z2") or H.char_at_om_location(H.u(ctx), "forge_x3y3z2") or H.char_at_om_location(H.u(ctx), "forge_x0y0z3") or H.char_at_om_location(H.u(ctx), "forge_x1y0z3") or H.char_at_om_location(H.u(ctx), "forge_x2y0z3") or H.char_at_om_location(H.u(ctx), "forge_x3y0z3") or H.char_at_om_location(H.u(ctx), "forge_x0y1z3") or H.char_at_om_location(H.u(ctx), "forge_x1y1z3") or H.char_at_om_location(H.u(ctx), "forge_x2y1z3") or H.char_at_om_location(H.u(ctx), "forge_x3y1z3") or H.char_at_om_location(H.u(ctx), "forge_x0y2z3") or H.char_at_om_location(H.u(ctx), "forge_x1y2z3") or H.char_at_om_location(H.u(ctx), "forge_x2y2z3") or H.char_at_om_location(H.u(ctx), "forge_x3y2z3") or H.char_at_om_location(H.u(ctx), "forge_x0y3z3") or H.char_at_om_location(H.u(ctx), "forge_x1y3z3") or H.char_at_om_location(H.u(ctx), "forge_x2y3z3") or H.char_at_om_location(H.u(ctx), "forge_x3y3z3") or H.char_at_om_location(H.u(ctx), "forge_x0y0z4") or H.char_at_om_location(H.u(ctx), "forge_x1y0z4") or H.char_at_om_location(H.u(ctx), "forge_x2y0z4") or H.char_at_om_location(H.u(ctx), "forge_x3y0z4") or H.char_at_om_location(H.u(ctx), "forge_x0y1z4") or H.char_at_om_location(H.u(ctx), "forge_x1y1z4") or H.char_at_om_location(H.u(ctx), "forge_x2y1z4") or H.char_at_om_location(H.u(ctx), "forge_x3y1z4") or H.char_at_om_location(H.u(ctx), "forge_x0y2z4") or H.char_at_om_location(H.u(ctx), "forge_x1y2z4") or H.char_at_om_location(H.u(ctx), "forge_x2y2z4") or H.char_at_om_location(H.u(ctx), "forge_x3y2z4") or H.char_at_om_location(H.u(ctx), "forge_x0y3z4") or H.char_at_om_location(H.u(ctx), "forge_x1y3z4") or H.char_at_om_location(H.u(ctx), "forge_x2y3z4") or H.char_at_om_location(H.u(ctx), "forge_x3y3z4"))) then
        H.eoc_add_effect(H.u(ctx), "safe_shoppers", 3600, nil, 1, nil)
        return true
    end
    return false
    end
    EOC["EOC_FORGE_GAME_LOAD"] = function(ctx)
    H.run_eoc("EOC_PLAYER_IN_FORGE", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_VALIDATE_FORGE"] = function(ctx)
        return (H.truthy((H.var_exists("global", nil, ctx, "loc_forge_of_wonders") and 1 or 0))) == true
    end
    EOC["EOC_VALIDATE_FORGE"] = function(ctx)
    if (H.truthy((H.var_exists("global", nil, ctx, "loc_forge_of_wonders") and 1 or 0))) then
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("MANUALLY FINDING THE FORGE AS A FALLBACK (PRESS SPACE).")))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "loc_forge_of_wonders", { terrain = "forge_x2y2z1" }, { z = math.floor(0) }, { kind = "furniture", id = H.safe_id("furniture", "f_magiclysm_greater_translocator_gate") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        return false
    end
    end
    COND["EOC_FORGE_TELEPORT"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not (((H.char_has_trait(H.u(ctx), "MUTE") == 1) or (H.char_has_trait(H.u(ctx), "ILLITERATE") == 1)))))) == true
    end
    EOC["EOC_FORGE_TELEPORT"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not (((H.char_has_trait(H.u(ctx), "MUTE") == 1) or (H.char_has_trait(H.u(ctx), "ILLITERATE") == 1)))))) then
        H.run_eoc("EOC_VALIDATE_FORGE", ctx, nil, nil, nil)
        H.consume_item(H.u(ctx), "forge_warp_scroll", 1, 0)
        H.eoc_spawn_item(H.u(ctx), "forge_return_warp_scroll", 1, false, false, nil)
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "forge_return_point", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "loc_forge_of_wonders"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        services.messages.add(ctx:expand_text(services.translate("As you recite the incantation the runes on the scroll begin to shift.  And in the blink of an eye you are suddenly somewhere else.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You need to be able to see, read, and speak to recite the incantation.")), "neutral")
        return false
    end
    end
    COND["EOC_FORGE_RETURN_TELEPORT"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not (((H.char_has_trait(H.u(ctx), "MUTE") == 1) or (H.char_has_trait(H.u(ctx), "ILLITERATE") == 1)))))) == true
    end
    EOC["EOC_FORGE_RETURN_TELEPORT"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not (((H.char_has_trait(H.u(ctx), "MUTE") == 1) or (H.char_has_trait(H.u(ctx), "ILLITERATE") == 1)))))) then
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "forge_return_point"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.consume_item(H.u(ctx), "forge_return_warp_scroll", 1, 0)
        services.messages.add(ctx:expand_text(services.translate("As you recite the incantation the scroll burns away in your hands.  And in the blink of an eye you are suddenly somewhere else.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You need to be able to see, read, and speak to recite the incantation.")), "neutral")
        return false
    end
    end
    COND["EOC_MANA_LEECH_UNLOCK"] = function(ctx)
        return (H.char_is_wearing(H.u(ctx), "mana_leech_shackle")) == true
    end
    EOC["EOC_MANA_LEECH_UNLOCK"] = function(ctx)
    if (H.char_is_wearing(H.u(ctx), "mana_leech_shackle")) then
        H.consume_item(H.u(ctx), "mana_leech_unlock_scroll", 1, 0)
        do local g = H.safe_id('item', "mana_leech_shackle"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.eoc_cast_spell(H.u(ctx), "gain_mana_leech_shackle_unlocked", false, nil)
        services.messages.add(ctx:expand_text(services.translate("As you complete the incantation, your mana-leech shackle becomes loose and inert.  It won't stop you from casting spells anymore.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are not wearing a mana-leech shackle, so this spell wouldn't do anything for you.")), "info")
        return false
    end
    end
    COND["EOC_MANA_LEECH_PLAYER_NOT_WORN"] = function(ctx)
        return (((not (H.char_is_wearing(H.u(ctx), "mana_leech_shackle"))) and H.char_has_item(H.u(ctx), "mana_leech_shackle"))) == true
    end
    EOC["EOC_MANA_LEECH_PLAYER_NOT_WORN"] = function(ctx)
    if (((not (H.char_is_wearing(H.u(ctx), "mana_leech_shackle"))) and H.char_has_item(H.u(ctx), "mana_leech_shackle"))) then
        do local g = H.safe_id('item', "mana_leech_shackle"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.eoc_spawn_item(H.u(ctx), "mana_leech_shackle_unlocked", 1, false, false, nil)
        return true
    end
    return false
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
        return ((H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION") or (H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true))) == true
    end
    EOC["EOC_STARE1"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION") or (H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true))) then
        services.messages.add(ctx:expand_text(services.translate("You sense <npc_name> trying to enter your mind, but your magic protects you!")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_MANA_LEECH_START"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "WEARING_MANA_LEECH") == 1)) == true
    end
    EOC["EOC_MANA_LEECH_START"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "WEARING_MANA_LEECH") == 1)) then
        H.eoc_cast_spell(H.u(ctx), "gain_mana_leech_shackle", false, nil)
        H.lose_trait(H.u(ctx), "WEARING_MANA_LEECH")
        return true
    end
    return false
    end
    COND["EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_GAME_START"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) == true
    end
    EOC["EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_GAME_START"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) then
        H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) == true
    end
    EOC["EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) then
        H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_FANTASY_SPECIES_REMOVE_THRESHOLD"] = function(ctx)
    H.lose_trait(H.u(ctx), "THRESH_SPECIES_ELF")
    H.lose_trait(H.u(ctx), "THRESH_SPECIES_DWARF")
    H.lose_trait(H.u(ctx), "THRESH_SPECIES_GOBLIN")
    H.lose_trait(H.u(ctx), "THRESH_SPECIES_LIZARDFOLK")
    H.lose_trait(H.u(ctx), "THRESH_SPECIES_RAVENFOLK")
    return true
    end
    COND["EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) == true
    end
    EOC["EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })) then
        H.set_var("actor", H.u(ctx), ctx, "purifying_level", H.char_vitamin(H.u(ctx), "mutagen_human"))
        if (H.char_has_trait(H.u(ctx), "ELVEN_BUILD") == 1) then
            do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen_species_elf"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        if (H.char_has_trait(H.u(ctx), "DWARVEN_BUILD") == 1) then
            do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen_species_dwarf"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        if (H.char_has_trait(H.u(ctx), "GOBLIN_BUILD") == 1) then
            do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen_species_goblin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        if (H.char_has_trait(H.u(ctx), "LIZARDFOLK_BUILD") == 1) then
            do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen_species_lizardfolk"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        if (H.char_has_trait(H.u(ctx), "RAVENFOLK_BUILD") == 1) then
            do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen_species_ravenfolk"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "purifying_level"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        return true
    end
    return false
    end
    COND["EOC_IRON_ALLERGY_WEARING_IRON_OR_STEEL"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) == true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_IRON_OR_STEEL"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) then
        H.run_eoc("EOC_IRON_ALLERGY_WEARING_IRON_FOLLOWUP", ctx, nil, nil, nil)
        H.run_eoc("EOC_IRON_ALLERGY_WEARING_STEEL_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_IRON_ALLERGY_UNWEARING_IRON_OR_STEEL"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) == true
    end
    EOC["EOC_IRON_ALLERGY_UNWEARING_IRON_OR_STEEL"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_IRON_ALLERGY_WEARING_IRON_FOLLOWUP"), nil) end end
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_IRON_ALLERGY_WEARING_STEEL_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_IRON_ALLERGY_WIELDING_IRON_OR_STEEL"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) == true
    end
    EOC["EOC_IRON_ALLERGY_WIELDING_IRON_OR_STEEL"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) then
        H.run_eoc("EOC_IRON_ALLERGY_WEARING_IRON_FOLLOWUP", ctx, nil, nil, nil)
        H.run_eoc("EOC_IRON_ALLERGY_WEARING_STEEL_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_IRON_ALLERGY_WEARING_IRON_RESULT_TRUE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_iron_allergy_wearing_iron", -1, nil, nil, nil)
    return true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_IRON_RESULT_FALSE"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_iron_allergy_wearing_iron"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_IRON_FOLLOWUP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, { wielded_only = true } }, { "EOC_IRON_ALLERGY_WEARING_IRON_RESULT_TRUE" }, { "EOC_IRON_ALLERGY_WEARING_IRON_RESULT_FALSE" })
    return true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_STEEL_RESULT_TRUE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_iron_allergy_wearing_steel", -1, nil, nil, nil)
    return true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_STEEL_RESULT_FALSE"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_iron_allergy_wearing_steel"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_IRON_ALLERGY_WEARING_STEEL_FOLLOWUP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { worn_only = true }, { wielded_only = true }, { wielded_only = true } }, { "EOC_IRON_ALLERGY_WEARING_STEEL_RESULT_TRUE" }, { "EOC_IRON_ALLERGY_WEARING_STEEL_RESULT_FALSE" })
    return true
    end
    COND["EOC_LOVES_SHINY_OBJECTS_WEARING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) == true
    end
    EOC["EOC_LOVES_SHINY_OBJECTS_WEARING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) then
        H.run_eoc("EOC_LOVES_SHINY_OBJECTS_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LOVES_SHINY_OBJECTS_UNWEARING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) == true
    end
    EOC["EOC_LOVES_SHINY_OBJECTS_UNWEARING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LOVES_SHINY_OBJECTS_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_LOVES_SHINY_OBJECTS_WIELDING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) == true
    end
    EOC["EOC_LOVES_SHINY_OBJECTS_WIELDING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LOVES_SHINY_OBJECTS") == 1)) then
        H.run_eoc("EOC_LOVES_SHINY_OBJECTS_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_LOVES_SHINY_OBJECTS_FOLLOWUP_TRUE"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "shiny_count", (H.var_num(H.u(ctx), "shiny_count")) + (1))
    return true
    end
    EOC["EOC_LOVES_SHINY_OBJECTS_FOLLOWUP"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "shiny_count", 0)
    do local _g = H.safe_id('morale', "morale_need_shiny_objects"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, { worn_only = true } }, { "EOC_LOVES_SHINY_OBJECTS_FOLLOWUP_TRUE" }, {  })
    services.messages.add(ctx:expand_text(services.translate("You have <u_val:shiny_count> shiny objects.")), "debug")
    if (H.var_num(H.u(ctx), "shiny_count") < 6) then
        do local _g = H.safe_id('morale', "morale_need_shiny_objects"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(((-30) + (H.var_num(H.u(ctx), "shiny_count") * 5))), math.floor(((-30) + (H.var_num(H.u(ctx), "shiny_count") * 5))), { duration = services.time.duration_from_turns(math.floor(604800)), decay_start = services.time.duration(30, 'minutes') }) end end
    end
    return true
    end
    COND["EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1)) == true
    end
    EOC["EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1)) then
        if services.random.native_probability((H.char_mana(H.u(ctx), "current")), ((H.char_mana(H.u(ctx), "maximum") * 0.75))) then
            H.eoc_add_effect(H.u(ctx), "effect_manatouched_external_mana_luminance", (function() local a, b = math.floor(300), math.floor(900); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("The air around you suddenly shimmers with a lambent glow.")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_MANA_FLASH_SPELLCASTING_FINISH"] = function(ctx)
        return (((((("NONE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOTEK") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", ""))))) and (H.char_has_trait(H.u(ctx), "MANA_LUM_FLASH") == 1))) == true
    end
    EOC["EOC_MANA_FLASH_SPELLCASTING_FINISH"] = function(ctx)
    if (((((("NONE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOTEK") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", ""))))) and (H.char_has_trait(H.u(ctx), "MANA_LUM_FLASH") == 1))) then
        if services.random.native_probability((1), (100)) then
            H.eoc_add_effect(H.u(ctx), "effect_manatouched_mana_flash_active", ((5 * (ctx:get_number("difficulty") or 0)) * services.random.native_float(0.5, 2)), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("Your ley lines flare up!")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_MANA_LUM_EXTERNAL_SPELLCASTING_FINISH"] = function(ctx)
        return (((((("NONE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOTEK") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", ""))))) and (H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1))) == true
    end
    EOC["EOC_MANA_LUM_EXTERNAL_SPELLCASTING_FINISH"] = function(ctx)
    if (((((("NONE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOTEK") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", ""))))) and (H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1))) then
        if services.random.native_probability((H.char_mana(H.u(ctx), "current")), ((H.char_mana(H.u(ctx), "maximum") * 15))) then
            H.eoc_add_effect(H.u(ctx), "effect_manatouched_external_mana_luminance", (function() local a, b = math.floor(300), math.floor(900); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("The air around you suddenly shimmers with a lambent glow.")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_magus_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MAGUS") == 1)) == true
    end
    EOC["EOC_magus_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MAGUS") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", (((function() local g = H.safe_id('item', "magus_booster_1_active"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.items_of_type(H.u(ctx), g, false); return (r.ok and r.value and #r.value) or 0 end)()) + (((function() local g = H.safe_id('item', "magus_booster_2_active"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.items_of_type(H.u(ctx), g, false); return (r.ok and r.value and #r.value) or 0 end)()) * 2)))
        H.set_spell_adj(H.u(ctx), "level", "MAGUS", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "MAGUS")), "=")
        return true
    end
    return false
    end
    COND["EOC_kelvinist_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "KELVINIST") == 1)) == true
    end
    EOC["EOC_kelvinist_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "KELVINIST") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", (((function() local g = H.safe_id('item', "kelvinist_booster_1_active"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.items_of_type(H.u(ctx), g, false); return (r.ok and r.value and #r.value) or 0 end)()) + (((function() local g = H.safe_id('item', "kelvinist_booster_2_active"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.items_of_type(H.u(ctx), g, false); return (r.ok and r.value and #r.value) or 0 end)()) * 2)))
        H.set_spell_adj(H.u(ctx), "level", "KELVINIST", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "KELVINIST")), "=")
        return true
    end
    return false
    end
    COND["EOC_technomancer_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "TECHNOMANCER") == 1)) == true
    end
    EOC["EOC_technomancer_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "TECHNOMANCER") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", (math.max(0, H.creature_effect_intensity(H.u(ctx), "technomancer_cl_booster_effect")) + (((function() local g = H.safe_id('item', "technomancer_booster_2_active"); if not g or not H.u(ctx) then return 0 end; local r = services.inventory.resources(H.u(ctx), g, 1); return (r.ok and r.value and r.value.charges) or 0 end)()) / 5)))
        H.set_spell_adj(H.u(ctx), "level", "TECHNOMANCER", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "TECHNOMANCER")), "=")
        H.set_var("actor", H.u(ctx), ctx, "doodad_boost", math.max(0, (H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "TECHNOMANCER")) - math.max(0, H.creature_effect_intensity(H.u(ctx), "technomancer_cl_booster_effect")))))
        return true
    end
    return false
    end
    COND["EOC_technomancer_caster_level_boost_finish_casting"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TECHNOMANCER") == 1) and ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))))) == true
    end
    EOC["EOC_technomancer_caster_level_boost_finish_casting"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TECHNOMANCER") == 1) and ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))))) then
        H.consume_item(H.u(ctx), "technomancer_booster_2_active", 0, (math.floor(H.var_num(H.u(ctx), "doodad_boost")) * 5))
        return true
    end
    return false
    end
    COND["EOC_biomancer_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "BIOMANCER") == 1)) == true
    end
    EOC["EOC_biomancer_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "BIOMANCER") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", math.max(0, H.creature_effect_intensity(H.u(ctx), "biomancer_cl_booster_effect")))
        H.set_spell_adj(H.u(ctx), "level", "BIOMANCER", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "BIOMANCER")), "=")
        return true
    end
    return false
    end
    COND["EOC_animist_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ANIMIST") == 1)) == true
    end
    EOC["EOC_animist_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ANIMIST") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", H.field_strength(H.u(ctx), "fd_blood", nil))
        H.set_spell_adj(H.u(ctx), "level", "ANIMIST", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "ANIMIST")), "=")
        return true
    end
    return false
    end
    COND["EOC_stormshaper_caster_level_boost"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "STORMSHAPER") == 1) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["EOC_stormshaper_caster_level_boost"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "STORMSHAPER") == 1) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", (H.weather_val("precipitation") * 2))
        H.set_spell_adj(H.u(ctx), "level", "STORMSHAPER", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "STORMSHAPER")), "=")
        return true
    end
    return false
    end
    COND["EOC_earthshaper_caster_level_boost_1"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandbox" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()))) == true
    end
    EOC["EOC_earthshaper_caster_level_boost_1"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandbox" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 1)
        return true
    end
    return false
    end
    COND["EOC_earthshaper_caster_level_boost_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_clay" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmoundfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmound" end)()))) == true
    end
    EOC["EOC_earthshaper_caster_level_boost_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_clay" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmoundfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmound" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 2)
        return true
    end
    return false
    end
    COND["EOC_earthshaper_caster_level_boost_3"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_shallow" end)()))) == true
    end
    EOC["EOC_earthshaper_caster_level_boost_3"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_shallow" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 3)
        return true
    end
    return false
    end
    COND["EOC_earthshaper_caster_level_boost_5"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit" end)()))) == true
    end
    EOC["EOC_earthshaper_caster_level_boost_5"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 5)
        return true
    end
    return false
    end
    COND["EOC_earthshaper_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "EARTHSHAPER") == 1)) == true
    end
    EOC["EOC_earthshaper_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "EARTHSHAPER") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", math.max(0, (-((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()))))
        H.run_eoc("EOC_earthshaper_caster_level_boost_1", ctx, nil, nil, nil)
        H.run_eoc("EOC_earthshaper_caster_level_boost_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_earthshaper_caster_level_boost_3", ctx, nil, nil, nil)
        H.run_eoc("EOC_earthshaper_caster_level_boost_5", ctx, nil, nil, nil)
        H.set_spell_adj(H.u(ctx), "level", "EARTHSHAPER", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "EARTHSHAPER")), "=")
        return true
    end
    return false
    end
    COND["EOC_druid_caster_level_boost_1"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_white" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()))) == true
    end
    EOC["EOC_druid_caster_level_boost_1"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_white" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 1)
        return true
    end
    return false
    end
    COND["EOC_druid_caster_level_boost_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_harvested" end)()))) == true
    end
    EOC["EOC_druid_caster_level_boost_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_harvested" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 2)
        return true
    end
    return false
    end
    COND["EOC_druid_caster_level_boost_3"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_long" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()))) == true
    end
    EOC["EOC_druid_caster_level_boost_3"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_long" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 3)
        return true
    end
    return false
    end
    COND["EOC_druid_caster_level_boost_5"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mega_fern" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus_colony" end)()))) == true
    end
    EOC["EOC_druid_caster_level_boost_5"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mega_fern" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus_colony" end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 5)
        return true
    end
    return false
    end
    COND["EOC_druid_caster_level_boost"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DRUID") == 1)) == true
    end
    EOC["EOC_druid_caster_level_boost"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DRUID") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "level_boost", 0)
        H.run_eoc("EOC_druid_caster_level_boost_1", ctx, nil, nil, nil)
        H.run_eoc("EOC_druid_caster_level_boost_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_druid_caster_level_boost_3", ctx, nil, nil, nil)
        H.run_eoc("EOC_druid_caster_level_boost_5", ctx, nil, nil, nil)
        H.set_spell_adj(H.u(ctx), "level", "DRUID", "", "", H._jm_limit_caster_level_boost(ctx, H.var_num(H.u(ctx), "level_boost"), H.char_school_level(H.u(ctx), "DRUID")), "=")
        return true
    end
    return false
    end
    COND["EOC_BIOMANCY_IS_DISTURBING"] = function(ctx)
        return ((((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))) == true
    end
    EOC["EOC_BIOMANCY_IS_DISTURBING"] = function(ctx)
    if ((((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))) then
        H.eoc_add_effect(H.u(ctx), "effect_biomancer_disturbing", ((ctx:get_number("difficulty") or 0) * 8), nil, ((ctx:get_number("difficulty") or 0) * 1.5), nil)
        return true
    end
    return false
    end
    COND["EOC_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) == true
    end
    EOC["EOC_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", ((H.creature_effect_intensity(H.u(ctx), "grabbed", "arm_l") + H.creature_effect_intensity(H.u(ctx), "grabbed", "arm_r")) / 10), "=")
        return true
    end
    return false
    end
    COND["EOC_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_r" ~= nil) and H.safe_id('body_part', "hand_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_l" ~= nil) and H.safe_id('body_part', "hand_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) == true
    end
    EOC["EOC_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_r" ~= nil) and H.safe_id('body_part', "hand_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_l" ~= nil) and H.safe_id('body_part', "hand_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", ((H.creature_effect_intensity(H.u(ctx), "grabbed", "hand_l") + H.creature_effect_intensity(H.u(ctx), "grabbed", "hand_r")) / 5), "=")
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_BROKEN_LIMBS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) == true
    end
    EOC["EOC_MAGICLYSM_BROKEN_LIMBS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) then
        if ((((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not ((((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
            H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", 10, "=")
        end
        if (((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", 30, "=")
        end
        return true
    end
    return false
    end
    COND["EOC_THAUMIC_ZOMBIES_INCREASE_DIFFICULTY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_thaumic_zombie_magical_disruption"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_THAUMIC_ZOMBIES_INCREASE_DIFFICULTY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_thaumic_zombie_magical_disruption"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", 2, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "magiclysm", 0.25, "=")
        return true
    end
    return false
    end
    COND["EOC_NO_CASTING_ENERVATION_SPELLS_EFFECTS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_CASTING_ENERVATION_SPELLS") == 1)) == true
    end
    EOC["EOC_NO_CASTING_ENERVATION_SPELLS_EFFECTS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_CASTING_ENERVATION_SPELLS") == 1)) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "", 999, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", 999, "=")
        return true
    end
    return false
    end
    COND["EOC_NO_CASTING_CONVEYANCE_SPELLS_EFFECTS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_CASTING_CONVEYANCE_SPELLS") == 1)) == true
    end
    EOC["EOC_NO_CASTING_CONVEYANCE_SPELLS_EFFECTS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_CASTING_CONVEYANCE_SPELLS") == 1)) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "", 999, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", 999, "=")
        return true
    end
    return false
    end
end
