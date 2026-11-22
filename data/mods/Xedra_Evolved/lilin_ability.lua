local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local mutations = services.mutations
local effects = services.effects
local id = services.types.id
local shapeshift_armor = require("shapeshift_armor")
local sky_island = content.is_mod_active("skyisland")

local ruach_vitamin = id("vitamin", "lilin_ruach_vitamin")
local progress = "lilin_amount_of_ruach_spent_for_powers"
local increase = progress .. "_increaser"

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(character, key)
    return value(variables.get_number(character, key)).value or 0
end

local function tell_player(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(text, tone or "bad")
    end
end

local function has_trait(character, trait_name)
    return value(mutations.has_id_text(character, trait_name))
end

local function has_effect(character, effect_name)
    return value(effects.has(character, id("effect", effect_name)))
end

local function add_permanent_effect(character, effect_name)
    value(effects.add(character, id("effect", effect_name),
        services.time.duration_from_turns(1), { permanent = true }))
end

local function remove_effect(character, effect_name)
    value(effects.remove(character, id("effect", effect_name)))
end

local function deactivate_trait(character, trait_name)
    value(mutations.invoke_activation(character, id("mutation", trait_name), false))
end

local function ruach_efficiency(character)
    local stored = value(services.needs.get_vitamin(character, ruach_vitamin))
    local discount = 0
    if has_trait(character, "LILIN_RUACH_EFFICIENCY") then
        discount = discount + 0.15
    end
    if has_trait(character, "LILIN_RUACH_EFFICIENCY_UPGRADE") then
        discount = discount + 0.15 + math.max((stored - 3500) / 12000, 0)
    end
    return 1 - math.min(discount, 0.33)
end

local function spend_ruach(character, base_cost)
    local cost = base_cost * ruach_efficiency(character)
    local stored = value(services.needs.get_vitamin(character, ruach_vitamin))
    if stored < cost then
        return false
    end
    value(services.needs.set_vitamin(character, ruach_vitamin, math.modf(stored - cost)))
    return true
end

local function next_token(character, key)
    local token = number(character, key) + 1
    value(variables.set(character, key, token, { include_before = false }))
    return token
end

local function is_current_token(context, key)
    local token = context.data and context.data.token
    return token ~= nil and number(context.character, key) == token
end

local function scale_calories(character, factor)
    local current = value(services.needs.get(character)).stored_kcal
    local delta = math.modf(current * factor - current)
    value(services.needs.modify_calories(character, delta, true))
end

local function assign_shift_activity(character, turns)
    value(services.activities.assign_timed(
        character, id("activity", "ACT_GENERIC_EOC"), services.time.duration_from_turns(turns)))
end

ccb.runtime.handler("lilin_commit_ruach", function(context)
    local character = context.character
    local stored = value(services.needs.get_vitamin(character, ruach_vitamin))
    if stored < 240 then
        tell_player(character, services.translate("You don't have enough ruach to dedicate any to increasing your powers!"))
        return
    end
    if sky_island and has_effect(character, "effect_si_lilin_no_ruach_upgrades") then
        tell_player(character, services.translate("Your spirit is still fragile after your brush with death.  You have no ruach to spare."))
        return
    end
    value(services.needs.set_vitamin(character, ruach_vitamin, stored - 240))
    local increment = number(character, increase) + 0.75
    value(variables.set(character, increase, increment, { include_before = false }))
    value(variables.set(character, progress, number(character, progress) + increment, { include_before = false }))
end)

local glorious_token_key = "lilin_temporary_glorious_token"

local function glorious_interval(character)
    local base = 3600 + (has_trait(character, "LILIN_TEMPORARY_GLORIOUS_2") and 601200 or 0)
    return math.max(1, math.modf(services.random.native_float(0.75, 1.25) * base))
end

local function stop_glorious(character)
    next_token(character, glorious_token_key)
    if has_trait(character, "BEAUTIFUL3") and has_effect(character, "effect_lilin_temporary_glorious") then
        tell_player(character, services.translate("You rend the illusions around yourself to tatters."), "neutral")
        value(mutations.erase(character, id("mutation", "BEAUTIFUL3")))
    end
    remove_effect(character, "effect_lilin_temporary_glorious")
end

ccb.runtime.handler("lilin_temporary_glorious_on", function(context)
    local character = context.character
    if has_effect(character, "effect_lilin_temporary_glorious") then
        stop_glorious(character)
        return
    end
    if has_trait(character, "BEAUTIFUL3") then
        tell_player(character, services.translate("You are already so beautiful no illusion could enhance your appearance."), "mixed")
        ccb.tasks.after_character_turn(character, 0, "lilin_temporary_glorious_deactivate")
        return
    end
    if spend_ruach(character, 60) then
        value(mutations.replace(character, id("mutation", "BEAUTIFUL3")))
        add_permanent_effect(character, "effect_lilin_temporary_glorious")
        tell_player(character, services.translate("You spin a beguiling web of illusion around yourself."), "good")
        local token = next_token(character, glorious_token_key)
        ccb.tasks.after_character_turn(character, glorious_interval(character),
            "lilin_temporary_glorious_maintain", { token = token })
    else
        tell_player(character, services.translate("You don't have enough ruach to enhance your appearance."), "bad")
        ccb.tasks.after_character_turn(character, 0, "lilin_temporary_glorious_deactivate")
    end
end)

ccb.runtime.handler("lilin_temporary_glorious_off", function(context)
    stop_glorious(context.character)
end)

ccb.runtime.handler("lilin_temporary_glorious_deactivate", function(context)
    deactivate_trait(context.character, "LILIN_TEMPORARY_GLORIOUS")
    deactivate_trait(context.character, "LILIN_TEMPORARY_GLORIOUS_2")
end)

ccb.runtime.handler("lilin_temporary_glorious_maintain", function(context)
    if not is_current_token(context, glorious_token_key) then
        return
    end
    local character = context.character
    if not (has_trait(character, "BEAUTIFUL3") and has_effect(character, "effect_lilin_temporary_glorious")) then
        return
    end
    if spend_ruach(character, 60) then
        tell_player(character, services.translate("You feel a chill on your skin as you maintain your web of pleasing illusions."), "mixed")
        ccb.tasks.after_character_turn(character, glorious_interval(character),
            "lilin_temporary_glorious_maintain", { token = context.data.token })
    else
        tell_player(character, services.translate("You don't have enough ruach to enhance your appearance."), "neutral")
        value(mutations.erase(character, id("mutation", "BEAUTIFUL3")))
        remove_effect(character, "effect_lilin_temporary_glorious")
    end
end)

ccb.runtime.handler("lilin_temporary_glorious_process", function(context)
    local character = context.character
    if not has_effect(character, "effect_lilin_temporary_glorious") then
        return
    end
    local outside = value(services.creatures.snapshot(character)).outside
    local is_day = services.time.now():is_day()
    if outside and is_day then
        value(mutations.erase(character, id("mutation", "BEAUTIFUL3")))
    else
        value(mutations.replace(character, id("mutation", "BEAUTIFUL3")))
    end
end)

local attribute_token_key = "lilin_attribute_bonuses_token"

local function attribute_interval(character)
    local bonus = 0
    for _, trait_name in ipairs({
        "LILIN_ATTRIBUTE_BONUSES_STRENGTH",
        "LILIN_ATTRIBUTE_BONUSES_DEXTERITY",
        "LILIN_ATTRIBUTE_BONUSES_PERCEPTION",
    }) do
        if has_trait(character, trait_name) then
            bonus = bonus + 280
        end
    end
    return math.max(1, math.modf(services.random.native_float(0.75, 1.25) + bonus))
end

local function stop_attribute_bonuses(character)
    next_token(character, attribute_token_key)
    if has_effect(character, "effect_lilin_attribute_bonuses") then
        tell_player(character, services.translate("Your physical abilities return to normal."), "neutral")
        remove_effect(character, "effect_lilin_attribute_bonuses")
    end
end

ccb.runtime.handler("lilin_attribute_bonuses_on", function(context)
    local character = context.character
    if has_effect(character, "effect_lilin_attribute_bonuses") then
        stop_attribute_bonuses(character)
        return
    end
    if spend_ruach(character, 80) then
        add_permanent_effect(character, "effect_lilin_attribute_bonuses")
        tell_player(character, services.translate("You draw on your ruach to enhance your physical abilities."), "good")
        local token = next_token(character, attribute_token_key)
        ccb.tasks.after_character_turn(character, attribute_interval(character),
            "lilin_attribute_bonuses_maintain", { token = token })
    else
        tell_player(character, services.translate("You don't have enough ruach to enhance your physical abilities."), "bad")
        ccb.tasks.after_character_turn(character, 0, "lilin_attribute_bonuses_deactivate")
    end
end)

ccb.runtime.handler("lilin_attribute_bonuses_off", function(context)
    stop_attribute_bonuses(context.character)
end)

ccb.runtime.handler("lilin_attribute_bonuses_deactivate", function(context)
    deactivate_trait(context.character, "LILIN_ATTRIBUTE_BONUSES")
end)

ccb.runtime.handler("lilin_attribute_bonuses_maintain", function(context)
    if not is_current_token(context, attribute_token_key) then
        return
    end
    local character = context.character
    if not has_effect(character, "effect_lilin_attribute_bonuses") then
        return
    end
    if spend_ruach(character, 60) then
        tell_player(character, services.translate("You feel a chill on your skin as you maintain your enhanced physical abilities."), "mixed")
        ccb.tasks.after_character_turn(character, attribute_interval(character),
            "lilin_attribute_bonuses_maintain", { token = context.data.token })
    else
        tell_player(character, services.translate("You don't have enough ruach to enhance your physical abilities."), "neutral")
        remove_effect(character, "effect_lilin_attribute_bonuses")
    end
end)

local function leave_owl_form(character)
    if not has_trait(character, "TURN_INTO_OWL_TRAITS") then
        return
    end
    tell_player(character, services.translate("Your wings recede and you land on now-humanoid legs."), "neutral")
    value(mutations.erase(character, id("mutation", "TURN_INTO_OWL_TRAITS")))
    remove_effect(character, "effect_lilin_owl_form_pass_through_walls")
    scale_calories(character, 4)
    shapeshift_armor.restore(character)
end

ccb.runtime.handler("lilin_turn_into_owl_on", function(context)
    local character = context.character
    if has_trait(character, "TURN_INTO_OWL_TRAITS") then
        leave_owl_form(character)
        return
    end
    if spend_ruach(character, 360) then
        assign_shift_activity(character, 1.5)
        shapeshift_armor.subsume(character)
        value(mutations.replace(character, id("mutation", "TURN_INTO_OWL_TRAITS")))
        if has_trait(character, "LILIN_OWL_FORM_PASS_THROUGH_WALLS") then
            add_permanent_effect(character, "effect_lilin_owl_form_pass_through_walls")
        end
        scale_calories(character, 0.25)
        tell_player(character, services.translate("Your eyes grow wide as feathers sprout from your arms and you take to the air on silent wings."), "good")
    else
        tell_player(character, services.translate("You don't have enough ruach to transform into an owl."), "bad")
        ccb.tasks.after_character_turn(character, 0, "lilin_turn_into_owl_deactivate")
    end
end)

ccb.runtime.handler("lilin_turn_into_owl_off", function(context)
    leave_owl_form(context.character)
end)

ccb.runtime.handler("lilin_turn_into_owl_deactivate", function(context)
    deactivate_trait(context.character, "LILIN_TURN_INTO_OWL")
end)

local healing_token_key = "lilin_bonus_healing_token"
local healing_limbs = { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" }

local function stop_bonus_healing(character)
    next_token(character, healing_token_key)
    if has_effect(character, "effect_lilin_bonus_healing_active") then
        tell_player(character, services.translate("Your accelerated healing slows to a stop."), "neutral")
        remove_effect(character, "effect_lilin_bonus_healing_active")
    end
end

ccb.runtime.handler("lilin_bonus_healing_on", function(context)
    local character = context.character
    if has_effect(character, "effect_lilin_bonus_healing_active") then
        stop_bonus_healing(character)
        return
    end
    if spend_ruach(character, 100) then
        add_permanent_effect(character, "effect_lilin_bonus_healing_active")
        tell_player(character, services.translate("You pour ruach into your wounds and your body begins healing."), "good")
        local token = next_token(character, healing_token_key)
        ccb.tasks.after_character_turn(character, services.random.native_int(8, 15),
            "lilin_bonus_healing_maintain", { token = token })
    else
        tell_player(character, services.translate("You don't have enough ruach to heal your wounds."), "bad")
        ccb.tasks.after_character_turn(character, 0, "lilin_bonus_healing_deactivate")
    end
end)

ccb.runtime.handler("lilin_bonus_healing_off", function(context)
    stop_bonus_healing(context.character)
end)

ccb.runtime.handler("lilin_bonus_healing_deactivate", function(context)
    deactivate_trait(context.character, "LILIN_BONUS_HEALING_ACTIVE")
end)

ccb.runtime.handler("lilin_bonus_healing_maintain", function(context)
    if not is_current_token(context, healing_token_key) then
        return
    end
    local character = context.character
    if not has_effect(character, "effect_lilin_bonus_healing_active") then
        return
    end
    if spend_ruach(character, 100) then
        tell_player(character, services.translate("You feel icy pinpricks on your skin as your wounds heal."), "mixed")
        local all_full = true
        for _, part in ipairs(healing_limbs) do
            local bp = id("body_part", part)
            local hp = value(services.characters.hp(character, bp))
            local hp_max = value(services.characters.hp_max(character, bp))
            if hp < hp_max then
                hp = hp + 1
                value(services.characters.set_hp(character, bp, hp, true))
            end
            if hp < hp_max then
                all_full = false
            end
        end
        if all_full then
            tell_player(character, services.translate("With your body restored, you no longer need to dedicate ruach to healing it."), "neutral")
            ccb.tasks.after_character_turn(character, 0, "lilin_bonus_healing_deactivate")
        else
            ccb.tasks.after_character_turn(character, services.random.native_int(8, 15),
                "lilin_bonus_healing_maintain", { token = context.data.token })
        end
    else
        tell_player(character, services.translate("You don't have enough ruach accelerate your healing."), "neutral")
        ccb.tasks.after_character_turn(character, 0, "lilin_bonus_healing_deactivate")
    end
end)

local function leave_war_owl_form(character)
    if not has_trait(character, "LILIN_WAR_OWL_FORM_TRAITS") then
        return
    end
    tell_player(character, services.translate("Your wings, feathers, and talons all vanish as you return to your human form."), "neutral")
    value(mutations.erase(character, id("mutation", "LILIN_WAR_OWL_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "LILIN_WAR_OWL_FORM_LEAPER")))
    shapeshift_armor.restore(character)
    scale_calories(character, 1 / 1.5)
end

ccb.runtime.handler("lilin_war_owl_on", function(context)
    local character = context.character
    if has_trait(character, "LILIN_WAR_OWL_FORM_TRAITS") then
        leave_war_owl_form(character)
        return
    end
    if spend_ruach(character, 480) then
        assign_shift_activity(character, 1.5)
        shapeshift_armor.subsume(character)
        value(mutations.replace(character, id("mutation", "LILIN_WAR_OWL_FORM_TRAITS")))
        value(mutations.replace(character, id("mutation", "LILIN_WAR_OWL_FORM_LEAPER")))
        scale_calories(character, 1.5)
        tell_player(character, services.translate("Wings erupt from your shoulders and talons grow from your fingers as you assume the strix form."), "good")
    else
        tell_player(character, services.translate("You don't have enough ruach to transform into a strix."), "bad")
        ccb.tasks.after_character_turn(character, 0, "lilin_war_owl_deactivate")
    end
end)

ccb.runtime.handler("lilin_war_owl_off", function(context)
    leave_war_owl_form(context.character)
end)

ccb.runtime.handler("lilin_war_owl_deactivate", function(context)
    deactivate_trait(context.character, "LILIN_TRANSFORM_INTO_WAR_OWL_FORM")
end)

ccb.runtime.handler("lilin_strix_leap", function(context)
    local character = context.character
    local stamina = value(services.needs.get(character)).stamina
    if stamina <= 2000 then
        tell_player(character, services.translate("Your legs are too tired to perform a jump."), "bad")
        return
    end
    value(services.characters.adjust(character, { moves = -100 }))
    value(services.needs.set(character, { stamina = stamina - 2000 }))
    value(services.characters.cast_spell(character, id("spell", "lilin_strix_leap_spell"), {
        targeted = true,
        message = services.translate("You squat down, build up tension in your legs, then with a mighty beat of your wings, you leap."),
    }))
end)

local lilin = content.Mutation {
    id = "LILIN_TRAITS",
    name = content.text("Lilit"),
    description = content.text("You are one of the lilin, a hunter in the night, driven to feed on the spiritual essence (some might say the soul) of your prey.  Probably you were born that way, but maybe it happened to due to a malediction, or some artifact you found in a place best forgotten.  Regardless, it is your gift and your curse now, and you must use your powers to survive.\n\nYou may activate this trait to spend some ruach toward increasing your power.  You must be outside under the moonlight to have a chance of gaining new lilin powers."),
    points = 2,
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    active = true,
    on_activate = "lilin_commit_ruach",
    activation_message = content.text("You dedicate some ruach to increasing your power."),
    categories = { "LILIN" },
    types = { "HERITAGE" },
    flags = { "HERITAGE" },
}
lilin:relationship("allowed_category", "LILIN")
lilin:relationship("cancel", "DREAMER")
lilin:relationship("cancel", "DREAMSMITH")
lilin:relationship("cancel", "EATER")
lilin:relationship("cancel", "INVENTOR")
lilin:relationship("cancel", "CHAOTIC")
lilin:relationship("cancel", "CHAOTIC_BAD")
lilin:relationship("enchantment", "INLINE_ENCH_LILIN_TRAITS_0")
lilin:integer_value("anger_relation", "VAMPIRE", -40)
lilin:integer_value("anger_relation", "HOMULLUS", 30)
content.add(lilin)
