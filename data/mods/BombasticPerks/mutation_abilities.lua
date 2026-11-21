local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local metamagic_off = {
    perk_metamagic_quicken = function() return ccb.services.translate("You deactivate your quicken metamagic") end,
    perk_metamagic_extended = function() return ccb.services.translate("You deactivate your extended metamagic") end,
    perk_metamagic_widen = function() return ccb.services.translate("You deactivate your widen metamagic") end,
    perk_metamagic_reach = function() return ccb.services.translate("You deactivate your reach metamagic") end,
    perk_metamagic_silent = function() return ccb.services.translate("You deactivate your silent metamagic") end,
    perk_metamagic_still = function() return ccb.services.translate("You deactivate your still metamagic") end,
    perk_metamagic_careful = function() return ccb.services.translate("You deactivate your careful metamagic") end,
    perk_metamagic_efficient = function() return ccb.services.translate("You deactivate your efficient metamagic") end,
    perk_metamagic_intuitive = function() return ccb.services.translate("You deactivate your intuitive metamagic") end,
}

local function set_metamagic_disabled(context, disabled)
    local mutation = context.mutation.value
    local setting = disabled and "yes" or "no"
    local key = mutation .. "_deactivated"
    -- The original variable action drew from a one-element list before writing.
    services.random.native_int(0, 0)
    value(services.variables.set(context.character, key, setting, { include_before = false }))
    services.native_events.emit("u_var_changed", { key, setting })
end

ccb.runtime.handler("metamagic_enable", function(context)
    set_metamagic_disabled(context, false)
end)

ccb.runtime.handler("metamagic_disable", function(context)
    if context.character.subtype == "avatar" then
        services.messages.add(metamagic_off[context.mutation.value]())
    end
    set_metamagic_disabled(context, true)
end)

ccb.runtime.handler("toggle_sight_beyond_sight", function(context)
    local character = context.character
    local trait = id("mutation", "perk_sight_beyond_sight_active")
    if value(services.mutations.has(character, trait)) then
        value(services.mutations.erase(character, trait))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You open your eyes."))
        end
    else
        value(services.mutations.replace(character, trait))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You close your eyes and feel the air."), "good")
        end
    end
end)

ccb.runtime.handler("frankenstein_insight", function(context)
    local character = context.character
    local recipe = id("recipe", "meat_hunk")
    if value(services.recipes.knows(services.characters.avatar(), recipe)) then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You have already mastered the art of bringing back the undead!"))
        end
        return
    end
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("With a flash of insight you now understand how to bring the dead back to life!"))
    end
    value(services.recipes.learn(character, recipe))
end)

local function say(character, text, severity)
    if character.subtype ~= "avatar" then
        return
    end
    local translated = services.translate(text)
    if severity then
        services.messages.add(translated, severity)
    else
        services.messages.add(translated)
    end
end

local function has_effect(character, effect_id)
    return value(services.effects.has(character, id("effect", effect_id)))
end

local function add_effect(character, effect_id, turns)
    local applied = services.effects.add(character, id("effect", effect_id), services.time.duration_from_turns(turns))
    if not applied.ok and applied.error.code ~= "rejected" then
        error(applied.error.message)
    end
end

local function choose_wielded_item(character)
    local page = value(services.items.page(
        { kind = "character", character = character, slot = "wielded" },
        { page_size = 16, recursive = false }))
    local candidates = {}
    for _, entry in ipairs(page.items) do
        candidates[#candidates + 1] = entry.handle
    end
    if #candidates == 0 then
        return nil
    end
    local choice = value(services.inventory.choose(character, candidates))
    return choice.accepted and choice.item or nil
end

ccb.runtime.handler("open_perk_menu", function(context)
    value(services.characters.open_topic(context.character, "TALK_PERK_MENU_MAIN"))
end)

local grit_pain_key = "grit_your_teeth_pain_value"
local grit_removed_key = "grit_your_teeth_pain_value_removed"
local grit_cooldown = "effect_perk_grit_your_teeth_cooldown"

ccb.runtime.handler("perk_grit_your_teeth_deactivate", function(task)
    local c = task.character
    if not has_effect(c, grit_cooldown) then
        return
    end
    local removed = value(services.variables.get_number(c, grit_removed_key)).value or 0
    local pain = value(services.characters.snapshot(c)).pain
    local target_pain = math.modf(pain + removed)
    if target_pain ~= pain then
        value(services.needs.modify_raw_pain(c, target_pain - pain))
    end
end)

ccb.runtime.handler("perk_grit_your_teeth_backup_remove", function(event)
    local c = event.actors.character
    if c and has_effect(c, grit_cooldown) then
        value(services.effects.remove(c, id("effect", grit_cooldown)))
    end
end)
ccb.runtime.on("game:character_wakes_up", "perk_grit_your_teeth_backup_remove")

ccb.runtime.handler("perk_grit_your_teeth", function(context)
    local c = context.character
    if has_effect(c, grit_cooldown) then
        say(c, "You need more time to collect yourself before you can grit your teeth again.", "mixed")
        return
    end
    local pain = value(services.characters.snapshot(c)).pain
    value(services.variables.set(c, grit_pain_key, pain, { include_before = false }))
    if pain > 0 then
        add_effect(c, grit_cooldown, pain * 60)
    end
    local removed
    if pain >= 62 then
        removed = pain / 2
    elseif pain >= 30 then
        removed = 30
    else
        removed = pain
    end
    value(services.variables.set(c, grit_removed_key, removed, { include_before = false }))
    local target_pain = (pain >= 30) and math.modf(pain - removed) or 0
    if target_pain ~= pain then
        value(services.needs.modify_raw_pain(c, target_pain - pain))
    end
    ccb.tasks.after_character_turn(c, 180, "perk_grit_your_teeth_deactivate")
end)

ccb.runtime.handler("perk_slippery_escape", function(context)
    local c = context.character
    value(services.needs.modify_raw_pain(c, services.random.native_int(0, 4) + 2))
    value(services.effects.remove(c, id("effect", "grabbed")))
    add_effect(c, "effect_perk_slippery_escape", 1)
end)

ccb.runtime.handler("safety_squint_on", function(context)
    value(services.inventory.receive_item(
        context.character,
        id("item", "perk_safety_squint_integrated_goggles"),
        1,
        { force_equip = true }))
end)

ccb.runtime.handler("safety_squint_off", function(context)
    value(services.inventory.remove_type(context.character, id("item", "perk_safety_squint_integrated_goggles")))
end)

ccb.runtime.handler("can_finder_on", function(context)
    say(context.character, "You start hunting for cans")
end)

ccb.runtime.handler("can_finder_off", function(context)
    say(context.character, "You stop looking for cans")
end)

ccb.runtime.handler("can_hunting", function(context)
    if services.random.native_float(0, 1.0) > 0.5 then
        local c = context.character
        say(c, "Someone left a perfectly good can of soda on the ground!")
        value(services.inventory.receive_group(c, id("item_group", "groce_softdrink")))
    end
end)

ccb.runtime.handler("perk_second_wind", function(context)
    local c = context.character
    if has_effect(c, "effect_perk_second_wind_cooldown") then
        say(c, "You need more time really rest before you can get your second wind back.", "bad")
        return
    end
    if not value(services.variables.get_number(c, "perk_second_wind_max_stamina")).exists then
        value(services.variables.set(c, "perk_second_wind_max_stamina", 8500, { include_before = false }))
    end
    add_effect(c, "effect_perk_second_wind_cooldown", 15 * 60)
    add_effect(c, "effect_perk_second_wind_currently_active", 10)
    value(services.activities.assign_timed(c, id("activity", "ACT_PERK_SECOND_WIND"),
        services.time.duration_from_turns(10)))
    say(c, "You take a moment and catch your breath.", "good")
end)

ccb.runtime.handler("spinach_consumption", function(context)
    local c = context.character
    local spinach = id("item", "spinach")
    if value(services.inventory.has_items(c, spinach, 1, 0)) then
        value(services.inventory.consume_by_type(c, spinach, 1, 0))
        value(services.characters.cast_spell(c, id("spell", "spell_strength_of_spinach"), {
            targeted = true,
            message = services.translate("You swallow the spinach raw and grow visibly stronger, for a short while."),
        }))
    else
        say(c, "You don't have any spinach!")
    end
end)

ccb.runtime.handler("unopenable_grip", function(context)
    local c = context.character
    local item = choose_wielded_item(c)
    if not item then
        return
    end
    local no_unwield = id("json_flag", "NO_UNWIELD")
    local is_gripped = id("json_flag", "IS_GRIPPED")
    if not value(services.items.has_flag(item, no_unwield)) then
        value(services.items.set_flag(item, no_unwield, true))
        value(services.items.set_flag(item, is_gripped, true))
        say(c, "You focus on your grip, making it impossible to drop what you hold.", "good")
    elseif value(services.items.has_flag(item, is_gripped)) then
        value(services.items.set_flag(item, no_unwield, false))
        value(services.items.set_flag(item, is_gripped, false))
        say(c, "You loosen your grip on what you're holding.  You can now drop it if you want.", "mixed")
    else
        say(c, "You cannot get a proper grip on this item, so your attempts to hold it with all your might are fruitless.",
            "bad")
    end
end)

ccb.runtime.handler("radio_infusion", function(context)
    local c = context.character
    local item = choose_wielded_item(c)
    if not item then
        return
    end
    value(services.items.set_flag(item, id("json_flag", "RADIOACTIVE"), true))
    value(services.items.set_flag(item, id("json_flag", "LEAK_ALWAYS"), true))
    say(c, "You focus on what you are holding, and suddenly it starts glowing green.", "mixed")
end)

ccb.runtime.handler("forge_blood", function(context)
    local c = context.character
    local item = choose_wielded_item(c)
    if not item then
        return
    end
    local durable_melee = id("json_flag", "DURABLE_MELEE")
    if value(services.items.has_flag(item, durable_melee)) then
        say(c, "This object is durable enough, there's no need to use your blood on it.", "mixed")
        return
    end
    local blood_id = id("vitamin", "blood")
    local redcells_id = id("vitamin", "redcells")
    local blood = value(services.needs.get_vitamin(c, blood_id))
    local redcells = value(services.needs.get_vitamin(c, redcells_id))
    if blood >= -15000 and redcells >= -15000 then
        value(services.items.set_flag(item, durable_melee, true))
        value(services.items.set_flag(item, id("json_flag", "NO_REPAIR"), true))
        value(services.needs.set_vitamin(c, blood_id, blood - 2000))
        value(services.needs.set_vitamin(c, redcells_id, redcells - 2000))
        say(c, "You pour some of your blood on the object, imbuing it with durability.", "good")
    else
        say(c, "You do not have enough blood to safely use this ability.", "bad")
    end
end)

ccb.runtime.handler("soothing_the_savage_beast", function(context)
    local c = context.character
    if value(services.needs.get(c)).stamina > 0 then
        value(services.characters.adjust(c, { moves = -300 }))
        value(services.characters.cast_spell(c, id("spell", "soothing_the_savage_beast_spell"), {
            targeted = true,
            message = services.translate("You sing a song to charm the most wild heart."),
        }))
    else
        say(c, "Your song has no effect!", "bad")
    end
end)
