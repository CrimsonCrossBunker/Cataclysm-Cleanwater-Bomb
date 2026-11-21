local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function global_number(key)
    return checked(services.variables.get_global_number(key)).value or 0
end

local function set_global(key, value)
    checked(services.variables.set_global(key, value, { include_before = false }))
end

local function set_var(actor, key, value)
    checked(services.variables.set(actor, key, value, { include_before = false }))
end

local function has_trait(actor, trait)
    return checked(services.mutations.has_id_text(actor, trait))
end

local function popup(actor, text, severity)
    if actor.subtype ~= "avatar" then
        return
    end
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
    services.messages.add(text, severity or "neutral")
end

ccb.runtime.handler("iso_add_starting_trait", function()
    local avatar = services.characters.avatar()
    if not has_trait(avatar, "iso_trait") then
        checked(services.mutations.replace(avatar, id("mutation", "iso_trait")))
    end
end, 1)
ccb.runtime.on("game:game_begin", "iso_add_starting_trait")

local last_scion_spells = {
    "iso_eldritch_stun_blind_deaf",
    "iso_eldritch_summon_hindering_darkness",
    "iso_eldritch_blink",
    "iso_eldritch_damage_shield",
    "iso_eldritch_line_biting_acid",
    "iso_eldritch_cone_lightning",
    "iso_eldritch_cold_damage_over_time",
    "iso_eldritch_cold_damage_blast",
    "iso_eldritch_summon_shadows",
    "iso_eldritch_invisibile_and_intangible",
    "iso_eldritch_cure_poison_disease_gas",
    "iso_eldritch_polymorph",
    "iso_eldritch_destroy_nether",
    "iso_eldritch_imprisonment",
    "iso_eldritch_mass_aoe_zombie_destruction",
}

local function store_last_scion_spell_levels(actor)
    if not has_trait(actor, "iso_eldritch_sorcery") then
        return
    end
    for _, spell in ipairs(last_scion_spells) do
        local level = checked(services.spells.effective_level(actor, spell))
        if level > 0 then
            set_var(actor, spell .. "_stored_level", level)
        end
    end
end

ccb.runtime.handler("iso_last_scion_return_staff", function(payload)
    local actor = payload.character
    if not has_trait(actor, "iso_eldritch_sorcery") then
        return
    end
    if not checked(services.inventory.has_items(actor, id("item", "iso_sorcerers_staff"), 1, 0)) then
        checked(services.inventory.receive_item(actor, id("item", "iso_sorcerers_staff"), 1))
        popup(actor, ccb.services.translate("Your lost staff has returned to you."), "good")
    end
end)

ccb.runtime.handler("iso_bossfight_poll", function()
    local actor = services.characters.avatar()
    local origin = checked(services.creatures.snapshot(actor)).position
    if #checked(services.monsters.nearby(origin, 50)) > 0 then
        ccb.tasks.after_avatar_turn(3, "iso_bossfight_poll")
    else
        set_var(actor, "bossfight_complete", 1)
        set_global("bossfight_active", 0)
        popup(actor,
            ccb.services.translate("The oppressive atmosphere in the room lifts as the last of the hostiles is defeated."),
            "neutral")
        checked(services.world.transform_radius(origin, 60, id("terrain_furniture_transform", "iso_open_bossfight")))
        if checked(services.variables.get(actor, "iso_balthazar_ally")).value == nil then
            checked(services.characters.open_topic(actor, "ISO_BALTHAZAR_WORK_TOGETHER"))
        end
    end
end)

local function teleport_to_elevator(actor, om_terrain, search_range, special_id)
    local origin = checked(services.creatures.snapshot(actor)).position
    local options = {
        z = -1,
        random = true,
        unseen_only = true,
        search_range = search_range,
    }
    if special_id then
        options.special = id("overmap_special", special_id)
        options.create_special = true
    end
    local om_target = services.overmap.find_target(origin:project_to("omt"), om_terrain, options)
    local location = services.world.find_location(om_target:project_to("ms"), {
        kind = "terrain",
        id = id("terrain", "t_elevator"),
    }, {
        target_max_radius = 30,
        distance_origin = origin,
    })
    local destination = location.position or services.coords.tripoint_abs_ms(0, 0, 0)
    set_global("new_map", destination)
    return destination
end

ccb.runtime.handler("examine_t_elevator_control_iso", function(ctx)
    local actor = ctx.character
    local level = global_number("ISO_CURRENT_LEVEL") + 1
    set_global("ISO_CURRENT_LEVEL", level)
    set_var(actor, "ISO_CURRENT_LEVEL_DANGER", 0)
    set_global("iso_balthazar_aid_value", math.min(40, global_number("iso_balthazar_aid_value") + 5))
    set_var(actor, "bossfight_complete", 0)
    popup(actor, ccb.services.translate("The elevator starts moving before you can touch the panel."), "neutral")

    local interval = global_number("SAFEPOINT_INTERVAL")
    if interval ~= 0 and level % interval == 0 then
        local destination = teleport_to_elevator(actor, "iso_elevator_safe", 180)
        checked(services.relocation.teleport_character(actor, destination, { force = true }))
        if has_trait(actor, "iso_bionic_vampire") then
            local current = checked(services.bionics.summary(actor)).power
            checked(services.bionics.set_power(actor, current:add(services.units.new("energy", 500000000, "millijoule"))))
        end
    else
        if has_trait(actor, "iso_eldritch_sorcery") then
            checked(services.spells.adjust_school_levels(actor, id("mutation", "iso_eldritch_sorcery"), 1))
        end
        store_last_scion_spell_levels(actor)
        if level < 5 then
            local destination = teleport_to_elevator(actor, "iso_elevator_office", 600)
            checked(services.relocation.teleport_character(actor, destination, { force = true }))
        elseif level >= 7 then
            local terrain = services.random.native_int(0, 1) == 0 and "iso_elevator" or "iso_elevator_microlab_embed"
            local destination = teleport_to_elevator(actor, terrain, 180)
            checked(services.relocation.teleport_character(actor, destination, { force = true }))
        elseif level >= 6 then
            local destination = teleport_to_elevator(actor, "iso_elevator", 180, "iso_bossfight_arena_1")
            set_global("bossfight_active", 1)
            popup(actor, ccb.services.translate("Something dangerous stirs beyond the elevator doors."), "neutral")
            ccb.tasks.after_avatar_turn(1, "iso_bossfight_poll")
            checked(services.relocation.teleport_character(actor, destination, { force = true }))
        end
    end

    ccb.tasks.after_character_turn(actor, 1, "iso_last_scion_return_staff")
end)
