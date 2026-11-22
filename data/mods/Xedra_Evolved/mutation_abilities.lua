local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local effects = services.effects
local spells = services.spells

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function player_message(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(text, tone)
    end
end

local traits_while_active = {
    ARVORE_TOXIC_FLESH = "TOXICFLESH",
    ARVORE_VINES = "VINES3",
    ARVORE_MIND_CONTROL_POLLEN = "ARVORE_MIND_CONTROL_POLLEN_ON",
    WEREWOLF_SENSE_SPIRITS_AND_ALIENS = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE",
    IERDE_STONE_FORM = "IERDE_STONE_FORM_TRAITS",
}

ccb.runtime.handler("enable_trait_form", function(context)
    local character = context.character
    local mutation = context.mutation.value
    value(mutations.replace(character, id("mutation", traits_while_active[mutation])))
    if mutation == "IERDE_STONE_FORM" then
        player_message(character, ccb.services.translate("Your body stiffens as your flesh turns to stone and your joints to earth."), "good")
    end
end)

ccb.runtime.handler("disable_trait_form", function(context)
    value(mutations.erase(context.character, id("mutation", traits_while_active[context.mutation.value])))
end)

local toggled_forms = {
    ARVORE_WOOD_CLAWS = "ARVORE_WOOD_CLAWS_active",
    ARVORE_THORN_SKIN = "ARVORE_THORN_SKIN_ON",
    BLOODTHORNE_DRUID_AURA_OF_VINES = "BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT",
    HOMULLUS_BACKSTAGE = "HOMULLUS_BACKSTAGE_active",
}

ccb.runtime.handler("toggle_trait_form", function(context)
    local character = context.character
    local mutation = context.mutation.value
    local form = id("mutation", toggled_forms[mutation])
    if value(mutations.has(character, form)) then
        value(mutations.erase(character, form))
        if mutation == "ARVORE_WOOD_CLAWS" then
            player_message(character, ccb.services.translate("The jagged wood covering your hands recedes, leaving no trace behind."))
        elseif mutation == "ARVORE_THORN_SKIN" then
            player_message(character, ccb.services.translate("Your thorns retract, leaving smooth unbroken skin behind."))
        elseif mutation == "HOMULLUS_BACKSTAGE" then
            player_message(character, ccb.services.translate("You become more noticeable."))
        end
    else
        value(mutations.replace(character, form))
        if mutation == "ARVORE_THORN_SKIN" then
            player_message(character, ccb.services.translate("Woody thorns push through your skin."), "good")
        elseif mutation == "HOMULLUS_BACKSTAGE" then
            player_message(character, ccb.services.translate("You seem to fade into the background."), "good")
        end
    end
end)

local function add_effect(character, effect, turns, options)
    value(effects.add(character, id("effect", effect), services.time.duration_from_turns(turns), options))
end

local function add_permanent_effect(character, effect)
    add_effect(character, effect, 1, { permanent = true })
end

local function remove_effect(character, effect)
    value(effects.remove(character, id("effect", effect)))
end

local permanent_effects = {
    ARVORE_POISON_POLLEN = "effect_arvore_poison_pollen",
    PARACLESIAN_FAE_SIGHT_2 = "effect_paraclesian_see_fae",
}

ccb.runtime.handler("enable_form_effect", function(context)
    add_permanent_effect(context.character, permanent_effects[context.mutation.value])
end)

ccb.runtime.handler("disable_form_effect", function(context)
    remove_effect(context.character, permanent_effects[context.mutation.value])
end)

ccb.runtime.handler("werewolf_phase_through_walls", function(context)
    add_permanent_effect(context.character, "effect_xe_werewolf_walk_through_walls")
    add_permanent_effect(context.character, "incorporeal")
end)

ccb.runtime.handler("werewolf_stop_phasing", function(context)
    local character = context.character
    local phasing = "effect_xe_werewolf_walk_through_walls"
    if value(effects.has(character, id("effect", phasing))) then
        remove_effect(character, "incorporeal")
        remove_effect(character, phasing)
    end
end)

local function set_dhampir_fang_spell(character, level)
    value(spells.set_level(character, id("spell", "vampire_drink_blood_with_fangs_spell"), level))
end

ccb.runtime.handler("enable_dhampir_fangs", function(context)
    set_dhampir_fang_spell(context.character, 0)
end)

ccb.runtime.handler("disable_dhampir_fangs", function(context)
    set_dhampir_fang_spell(context.character, -1)
end)

ccb.runtime.handler("end_lucid_dream", function(context)
    remove_effect(context.character, "effect_lucid_dream")
end)

ccb.runtime.handler("salamander_remove_stun", function(context)
    add_effect(context.character, "effect_salamander_remove_stun", 5)
end)

ccb.runtime.handler("undine_escape_grabs", function(context)
    local character = context.character
    local effect = "effect_undine_escape_grabs"
    remove_effect(character, effect)
    add_effect(character, effect, services.random.native_int(2, 8))
end)

ccb.runtime.handler("salamander_reset_sleep", function(context)
    value(services.needs.set(context.character, { sleepiness = 0, sleep_deprivation = 0 }))
end)

local function spend_mana(character, cost)
    local mana = value(spells.mana(character)).current
    if mana < cost then
        return false
    end
    value(spells.set_mana_raw(character, mana - cost))
    return true
end

ccb.runtime.handler("sylph_fly_at_will", function(context)
    local character = context.character
    if spend_mana(character, 3) then
        add_effect(character, "effect_sylph_levitation", 2)
        add_effect(character, "effect_sylph_climb_flying", 2)
    else
        player_message(character, ccb.services.translate("You do not have enough mana to fly!"), "bad")
        remove_effect(character, "effect_sylph_levitation")
        remove_effect(character, "effect_sylph_climb_flying")
    end
end)

ccb.runtime.handler("sylph_enter_cloud_form", function(context)
    local character = context.character
    add_permanent_effect(character, "effect_sylph_cloud_body")
    add_permanent_effect(character, "incorporeal")
    value(mutations.replace(character, id("mutation", "SYLPH_CLOUD_FORM_APPEARANCE")))
    player_message(character, ccb.services.translate("Your body falls apart into billowing clouds."), "good")
end)

ccb.runtime.handler("sylph_maintain_cloud_form", function(context)
    local character = context.character
    if not spend_mana(character, 10) then
        player_message(character, ccb.services.translate("You do not have enough mana to maintain your cloud body!"), "bad")
        remove_effect(character, "incorporeal")
        remove_effect(character, "effect_sylph_cloud_body")
    end
end)

ccb.runtime.handler("sylph_leave_cloud_form", function(context)
    local character = context.character
    remove_effect(character, "effect_sylph_cloud_body")
    remove_effect(character, "incorporeal")
    value(mutations.erase(character, id("mutation", "SYLPH_CLOUD_FORM_APPEARANCE")))
end)

local function wielded_item(character)
    local page = value(services.items.page(
        { kind = "character", character = character, slot = "wielded" },
        { page_size = 1, recursive = false }
    ))
    return page.items[1] and page.items[1].handle or nil
end

ccb.runtime.handler("bloodthorne_summon_heartwhip", function(context)
    local character = context.character
    if value(services.creatures.snapshot(character)).has_weapon then
        player_message(character, ccb.services.translate("Your hands need to be free to summon the heartwhip."), "bad")
        return
    end
    value(services.characters.cast_spell(character, id("spell", "bloodthorne_druid_summon_whip"), { hit_self = true }))
    add_effect(character, "bleed", 300, { intensity = 1, body_part = id("body_part", "arm_r") })
    local wielded = wielded_item(character)
    if wielded and not value(services.items.has_flag(wielded, id("json_flag", "NO_UNWIELD"))) then
        value(services.items.set_flag(wielded, id("json_flag", "NO_UNWIELD"), true))
    end
    ccb.tasks.after_character_turn(character, 10, "bloodthorne_heartwhip_remove_blood")
end)

ccb.runtime.handler("bloodthorne_heartwhip_remove_blood", function(context)
    value(effects.remove(context.character, id("effect", "bleed"), id("body_part", "arm_r")))
end)

ccb.runtime.handler("bloodthorne_unsummon_heartwhip", function(context)
    local character = context.character
    local wielded = wielded_item(character)
    if wielded
        and value(services.items.has_flag(wielded, id("json_flag", "MAGIC_FOCUS")))
        and value(services.items.has_flag(wielded, id("json_flag", "REACH3")))
    then
        player_message(character, ccb.services.translate("The heartwhip retracts, slithering through your grip and back within your body."), "neutral")
        value(services.inventory.remove_type(character, id("item", "heartvine_whip")))
    end
end)

ccb.runtime.handler("changeling_right_of_passage_on", function(context)
    local character = context.character
    if not value(effects.has(character, id("effect", "effect_changeling_noble_broken_right_of_passage"))) then
        value(mutations.replace(character, id("mutation", "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS")))
    else
        player_message(character, ccb.services.translate("After your actions you may not invoke the right of passage."), "bad")
        ccb.tasks.after_character_turn(character, 0, "changeling_right_of_passage_deactivate")
    end
end)

ccb.runtime.handler("changeling_right_of_passage_off", function(context)
    value(mutations.erase(context.character, id("mutation", "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS")))
end)

ccb.runtime.handler("changeling_right_of_passage_deactivate", function(context)
    value(mutations.invoke_activation(context.character, id("mutation", "CHANGELING_NOBLE_RIGHT_OF_PASSAGE"), false))
end)

ccb.runtime.handler("gracken_arm_push1", function(context)
    local character = context.character
    if value(services.needs.get(character)).stamina > 0 then
        value(services.characters.adjust(character, { moves = -100 }))
        value(services.characters.cast_spell(character, id("spell", "gracken_arm_push_spell"), {
            targeted = true,
            message = ccb.services.translate("You lash out and push your target away!"),
        }))
    end
end)

local function dismiss_temporary_trait(character, trait_id, message)
    value(mutations.erase(character, id("mutation", trait_id)))
    player_message(character, ccb.services.translate(message), "neutral")
end

ccb.runtime.handler("dismiss_ethereal_wings", function(context)
    dismiss_temporary_trait(context.character, "ethereal_wings", "The wings behind you fade out of existence.")
end)

local karma_arm_parts = {
    "karma_arm_up_r",
    "karma_arm_up_l",
    "karma_arm_lw_r",
    "karma_arm_lw_l",
}

local karma_arm_cured_effects = {
    "bleed",
    "infected",
    "bite",
}

ccb.runtime.handler("dismiss_karma_arms", function(context)
    local character = context.character
    for _, part in ipairs(karma_arm_parts) do
        local bp = id("body_part", part)
        local cur = value(services.characters.hp(character, bp))
        value(services.characters.set_hp(character, bp, math.modf(cur + 150), true))
        for _, eff in ipairs(karma_arm_cured_effects) do
            value(effects.remove(character, id("effect", eff), bp))
        end
    end
    dismiss_temporary_trait(character, "karma_arms", "The cyan arms grow dim and finally disappear.")
end)

ccb.runtime.handler("dismiss_devil_tail", function(context)
    dismiss_temporary_trait(context.character, "devil_tail", "Your devil tail fades away.")
end)

ccb.runtime.handler("dismiss_stalker_eyes", function(context)
    dismiss_temporary_trait(context.character, "stalker_eyes", "The great new world visible to your eyes disappears.")
end)
