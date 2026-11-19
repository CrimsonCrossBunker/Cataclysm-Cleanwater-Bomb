local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local install_turn_rule = require("heritage")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local size_numbers = { tiny = 1, small = 2, medium = 3, large = 4, huge = 5 }
local preparation = id("activity", "ACT_GENERIC_EOC")
local shift_time = services.time.duration(2, "turn")
local mana_reducer = id("mutation", "DRUID_SHIFTER_MANA_REDUCER")
local feline_leap = id("mutation", "FELINE_LEAP")
local feline_threshold = id("mutation", "THRESH_FELINE")
local raven_ascent = id("spell", "druid_raven_form_fly_upward")
local concealed = id("json_flag", "SHAPESHIFTED_ARMOR")
local semitangible = id("json_flag", "SEMITANGIBLE")
local unrestricted = id("json_flag", "UNRESTRICTED")
local integrated = id("json_flag", "INTEGRATED")
local intangible = id("json_flag", "INTANGIBLE_ARMOR")
local unbreakable = id("json_flag", "UNBREAKABLE")
local hide_flags = { concealed, semitangible, unrestricted, intangible, unbreakable }
local restore_flags = { semitangible, intangible, unrestricted, concealed, unbreakable }
local forms = {}

local function has(character, trait)
    return checked(services.mutations.has(character, trait))
end

local function has_flag(item, flag)
    return checked(services.items.has_flag(item, flag))
end

local function hide_armor(character)
    for _, item in ipairs(checked(services.inventory.worn_items(character))) do
        if not has_flag(item, semitangible) and not has_flag(item, unrestricted) and not has_flag(item, integrated) then
            for _, flag in ipairs(hide_flags) do
                checked(services.items.set_flag(item, flag, true))
            end
        end
    end
end

local function restore_armor(character)
    for _, item in ipairs(checked(services.inventory.items_with_flag(character, concealed))) do
        for _, flag in ipairs(restore_flags) do
            checked(services.items.set_flag(item, flag, false))
        end
    end
end

local function message(character, localized, kind)
    if character.subtype == "avatar" then services.messages.add(localized(), kind) end
end

-- Negative factors divide. Keeping the original operations also preserves truncation of the resulting delta.
local function scale_calories(character, factor, ignore_weariness)
    if not factor then return end
    local current = checked(services.needs.get(character)).stored_kcal
    local target = factor < 0 and current / -factor or current * factor
    checked(services.needs.modify_calories(character, math.modf(target - current), ignore_weariness))
end

local function revert(character, form)
    if not has(character, form.trait) then return end
    checked(services.activities.assign_timed(character, preparation, shift_time))
    message(character, form.reverted, "neutral")
    checked(services.mutations.erase(character, form.trait))
    checked(services.mutations.erase(character, mana_reducer))
    if form.on_revert then form.on_revert(character) end
    local mana = math.modf(checked(services.variables.get_number(character, "transformed_mana")).value or 0)
    checked(services.spells.set_mana_raw(character, mana))
    local size = checked(services.variables.get_number(character, "preshift_size")).value
    local factor = form.calories[size]
    if factor then scale_calories(character, -factor, form.ignore_weariness) end
    restore_armor(character)
end

local function activate(character, form)
    for _, other in ipairs(forms) do
        if other ~= form and has(character, other.trait) then
            message(character, form.already_shifted, "mixed")
            ccb.tasks.after_character_turn(character, 0, form.reset)
            return
        end
    end
    if has(character, form.trait) then
        revert(character, form)
        return
    end
    local mana = checked(services.spells.mana(character)).current
    if mana < 50 then
        message(character, form.low_mana, "bad")
        ccb.tasks.after_character_turn(character, 0, form.reset)
        return
    end

    checked(services.activities.assign_timed(character, preparation, shift_time))
    mana = checked(services.spells.mana(character)).current
    if form.pay_immediately then
        checked(services.spells.set_mana_raw(character, mana - 50))
        mana = checked(services.spells.mana(character)).current
    end
    local size = size_numbers[checked(services.creatures.snapshot(character)).size]
    local options = { include_before = false }
    checked(services.variables.set(character, "transformed_mana", mana - 50, options))
    checked(services.variables.set(character, "preshift_size", size, options))
    scale_calories(character, form.calories[size], form.ignore_weariness)
    hide_armor(character)
    checked(services.mutations.replace(character, form.trait))
    checked(services.mutations.replace(character, mana_reducer))
    if form.on_shift then form.on_shift(character) end
    message(character, form.shifted, "good")
end

local function register(form)
    local activation = "activate_druid_" .. form.animal
    local deactivation = "deactivate_druid_" .. form.animal
    form.mutation = id("mutation", form.id)
    form.trait = id("mutation", form.id .. "_TRAITS")
    form.reset = "reset_druid_" .. form.animal
    forms[#forms + 1] = form
    ccb.runtime.handler(activation, function(ctx) activate(ctx.character, form) end)
    ccb.runtime.handler(deactivation, function(ctx) revert(ctx.character, form) end)
    ccb.runtime.handler(form.reset, function(task)
        checked(services.mutations.invoke_activation(task.character, form.mutation, false))
    end, 1)
    content.add(content.Mutation {
        id = form.id,
        name = form.name,
        description = form.description,
        activation_message = ccb.content.text("You activate your %s."),
        points = 0,
        starting_trait = false,
        purifiable = false,
        valid = false,
        active = true,
        activation_stays_on = true,
        on_activate = activation,
        on_deactivate = deactivation,
    })
end

register {
    animal = "bear",
    id = "DRUID_SHIFTER_BEAR_FORM",
    name = ccb.content.text("Form of the Forest King"),
    description = ccb.content.text("You can transform yourself into a bear.  Roar."),
    starting_option = function()
        return { label = ccb.services.translate("Bear Form"),
            description = ccb.services.translate("You learned how to transform into a bear.") }
    end,
    calories = { 12, 6, 2, 1.5 },
    ignore_weariness = true,
    shifted = function()
        return ccb.services.translate("Your body shifts and expands as fur sprouts from your skin and your mouth and teeth lengthen.")
    end,
    reverted = function()
        return ccb.services.translate("Your body shifts and contracts and you return to your humanoid form.")
    end,
    low_mana = function()
        return ccb.services.translate("You don't have enough mana to transform into a bear.")
    end,
    already_shifted = function()
        return ccb.services.translate("You cannot transform into a bear if you are already in an animal form.")
    end,
}

register {
    animal = "cougar",
    id = "DRUID_SHIFTER_COUGAR_FORM",
    name = ccb.content.text("Form of the Stalking Hunter"),
    description = ccb.content.text("You can transform yourself into a cougar and stalk your enemies."),
    starting_option = function()
        return { label = ccb.services.translate("Cougar Form"),
            description = ccb.services.translate("You learned how to transform into a cougar.") }
    end,
    calories = { -4, -2, [4] = 1.5, [5] = 3 },
    on_shift = function(character)
        if not has(character, feline_leap) then checked(services.mutations.replace(character, feline_leap)) end
    end,
    on_revert = function(character)
        if not has(character, feline_threshold) then checked(services.mutations.erase(character, feline_leap)) end
    end,
    shifted = function()
        return ccb.services.translate("Your body shifts and warps as fur sprouts from your skin, whiskers from your nose, and claws and fangs from your fingers and mouth.")
    end,
    reverted = function()
        return ccb.services.translate("Your body shifts and your fur disappears as you return to your humanoid form.")
    end,
    low_mana = function()
        return ccb.services.translate("You don't have enough mana to transform into a cougar.")
    end,
    already_shifted = function()
        return ccb.services.translate("You cannot transform into a cougar if you are already in an animal form.")
    end,
}

register {
    animal = "deer",
    id = "DRUID_SHIFTER_DEER_FORM",
    name = ccb.content.text("Form of the Swift Runner"),
    description = ccb.content.text("You can transform yourself into a deer."),
    starting_option = function()
        return { label = ccb.services.translate("Deer Form"),
            description = ccb.services.translate("You learned how to transform into a deer.") }
    end,
    calories = { -4, -2, [4] = 1.5, [5] = 3 },
    ignore_weariness = true,
    shifted = function()
        return ccb.services.translate("Your body shifts and warps as your fingers and feet fuse into hooves and majestic antlers sprout from your head.")
    end,
    reverted = function()
        return ccb.services.translate("Your body shifts and your fingers separate as you return to your humanoid form.")
    end,
    low_mana = function()
        return ccb.services.translate("You don't have enough mana to transform into a deer.")
    end,
    already_shifted = function()
        return ccb.services.translate("You cannot transform into a deer if you are already in an animal form.")
    end,
}

register {
    animal = "raven",
    id = "DRUID_SHIFTER_RAVEN_FORM",
    name = ccb.content.text("Form of the Soaring Wings"),
    description = ccb.content.text("You can transform yourself into a raven and take wing."),
    starting_option = function()
        return { label = ccb.services.translate("Raven Form"),
            description = ccb.services.translate("You learned how to transform into a raven.") }
    end,
    calories = { [2] = -2, [3] = -4, [4] = -6, [5] = -10 },
    ignore_weariness = true,
    pay_immediately = true,
    on_revert = function(character)
        local result = services.spells.forget(character, raven_ascent)
        if not result.ok and result.error.code ~= "not_known" then error(result.error.message) end
    end,
    shifted = function()
        return ccb.services.translate("Your body shifts and changes as you concentrate and you take wing as a raven.")
    end,
    reverted = function()
        return ccb.services.translate("Your body shifts and changes and you return to your humanoid form.")
    end,
    low_mana = function()
        return ccb.services.translate("You don't have enough mana to transform into a raven.")
    end,
    already_shifted = function()
        return ccb.services.translate("You cannot transform into a raven if you are already in an animal form.")
    end,
}

local function complete_proficiency(character, proficiency)
    local required = services.proficiencies.definition(proficiency).time_to_learn
    checked(services.proficiencies.set_practiced_time(character, proficiency, required))
end

local select_starting_form = "choose_starting_druid_form"
local menu_keys = { "a", "b", "c", "d" }
ccb.runtime.handler(select_starting_form, function(task)
    local options = {}
    for index, form in ipairs(forms) do
        local option = form.starting_option()
        option.id = form.animal
        option.hotkey = menu_keys[index]
        options[index] = option
    end
    local selected = services.interaction.choose(options, {
        title = ccb.services.translate("Which form did you learn how to shift into?"),
        allow_cancel = false,
        show_descriptions = true,
    })
    if not selected.accepted then return end
    local character = task.character
    local form = forms[selected.index]
    checked(services.mutations.replace(character, form.mutation))
    complete_proficiency(character, id("proficiency", "prof_druid_transformation_" .. form.animal))
end, 1)

ccb.runtime.handler("schedule_starting_druid_form", function()
    local character = services.characters.avatar()
    if checked(services.characters.has_profession(character, "shifter_druid")) then
        ccb.tasks.after_character_turn(character, 0, select_starting_form)
    end
end)
ccb.runtime.on("game:game_start", "schedule_starting_druid_form")

local druid = id("mutation", "DRUID")
local basis_name = "prof_druid_basis_of_transformation"
local basis = id("proficiency", basis_name)
install_turn_rule("magiclysm_druid_training", function(character)
    complete_proficiency(character, basis)
end, function(character)
    return has(character, druid)
end, function(character)
    return checked(services.proficiencies.has_id_text(character, basis_name)) or not has(character, druid)
end)

local blocked_activities = {
    ACT_LOCKPICK = true,
    ACT_REPAIR_ITEM = true,
    ACT_MEND_ITEM = true,
    ACT_VEHICLE_REPAIR = true,
    ACT_RELOAD = true,
    ACT_FIRSTAID = true,
    ACT_MILK = true,
    ACT_HACKSAW = true,
    ACT_BOLTCUTTING = true,
    ACT_HAIRCUT = true,
    ACT_SHAVE = true,
    ACT_CRACKING = true,
    ACT_READ = true,
    ACT_EBOOKSAVE = true,
    ACT_TIDY_UP = true,
    ACT_MOP = true,
    ACT_VEHICLE_DECONSTRUCTION = true,
    ACT_VEHICLE_FOLD = true,
    ACT_VEHICLE_UNFOLD = true,
    ACT_BIKERACK_UNRACKING = true,
    ACT_BIKERACK_RACKING = true,
    ACT_MULTIPLE_DIS = true,
    ACT_MULTIPLE_FISH = true,
    ACT_MULTIPLE_CRAFT = true,
    ACT_MULTIPLE_CHOP_PLANKS = true,
    ACT_MULTIPLE_CHOP_TREES = true,
    ACT_MULTIPLE_MINE = true,
    ACT_MULTIPLE_CONSTRUCTION = true,
    ACT_MULTIPLE_MOP = true,
    ACT_MULTIPLE_READ = true,
    ACT_FISH = true,
    ACT_GENERIC_GAME = true,
    ACT_GAME = true,
    ACT_DISASSEMBLE = true,
    ACT_MULTIPLE_FARM = true,
    ACT_HARVEST = true,
    ACT_FIELD_DRESS = true,
    ACT_SKIN = true,
    ACT_QUARTER = true,
    ACT_DISSECT = true,
    ACT_LONGSALVAGE = true,
    ACT_BUILD = true,
    ACT_PICKAXE = true,
    ACT_HAND_CRANK = true,
    ACT_PICKUP = true,
    ACT_AUTODRIVE = true,
    ACT_FERTILIZE_PLOT = true,
    ACT_MOVE_LOOT = true,
    ACT_UNLOAD_LOOT = true,
    ACT_INSERT_ITEM = true,
    ACT_START_FIRE = true,
    ACT_OPEN_GATE = true,
    ACT_FILL_LIQUID = true,
    ACT_SHEARING = true,
    ACT_HOTWIRE_CAR = true,
    ACT_AIM = true,
    ACT_ATM = true,
    ACT_START_ENGINES = true,
    ACT_OXYTORCH = true,
    ACT_TOOLMOD_ADD = true,
    ACT_CLEAR_RUBBLE = true,
    ACT_WASH = true,
    ACT_PRYING = true,
    ACT_CHOP_LOGS = true,
    ACT_CHOP_PLANKS = true,
    ACT_JACKHAMMER = true,
    ACT_CHURN = true,
    ACT_PLANT_SEED = true,
    ACT_WEAR = true,
    ACT_WIELD = true,
    ACT_BINDER_COPY_RECIPE = true,
    ACT_DATA_HANDLING = true,
    ACT_FURNITURE_MOVE = true,
    ACT_TENT_PLACE = true,
    ACT_TENT_DECONSTRUCT = true,
    ACT_REEL_CABLE = true,
    ACT_SALINE_INFUSE = true,
}
local fish_form = id("mutation", "DRUID_SHIFTER_FISH_FORM_TRAITS")

local function is_shifted(character)
    for _, form in ipairs(forms) do
        if has(character, form.trait) then return true end
    end
    return has(character, fish_form)
end

ccb.runtime.handler("block_druid_animal_activity", function(event)
    if not blocked_activities[event.data.activity] then return end
    local character = event.actors.character or services.characters.avatar()
    if is_shifted(character) then
        checked(services.activities.cancel(character))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You can't perform that activity while in the form of an animal."), "bad")
        end
    end
end)
ccb.runtime.on("game:character_starts_activity", "block_druid_animal_activity")
