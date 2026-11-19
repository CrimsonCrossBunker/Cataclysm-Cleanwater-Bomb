local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(character, text)
    if character.subtype == "avatar" then
        services.messages.add(text, "neutral")
    end
end

local function has_mutation(character, mutation)
    return checked(services.mutations.has(character, id("mutation", mutation)))
end

local function replace_mutation(character, mutation)
    checked(services.mutations.replace(character, id("mutation", mutation)))
end

local function register_trait_elixir(handler, mutation, gained, repeated)
    ccb.runtime.handler(handler, function(context)
        local character = context.character
        if has_mutation(character, mutation) then
            message(character, repeated())
            return
        end
        message(character, gained())
        replace_mutation(character, mutation)
    end)
end

register_trait_elixir("drink_life_extension", "EXTEND_LIFE",
    function() return ccb.services.translate("You imbibed the concoction and you feel your chakras align and your DNA de-age.") end,
    function() return ccb.services.translate("This was a very valuable elixir that you just wasted drinking yourself.  You can't become more unaging.") end)

register_trait_elixir("drink_hyde_formula", "HYDE",
    function() return ccb.services.translate("You imbibed the concoction and you feel your inner self unleashed.") end,
    function() return ccb.services.translate("If this was a just world choosing to drink this concoction more than once would send you into an uncontrollable rage state where you rampaged until your inevitable death.  This is not a just world.") end)

ccb.runtime.handler("drink_gender_potion", function(context)
    local character = context.character
    local profile = checked(services.characters.snapshot(character, 0))
    checked(services.characters.set_demographics(character, { male = not profile.male }))
end)

local function imbue(handler, apply)
    ccb.runtime.handler(handler, function(context)
        local character = context.character
        if checked(services.characters.has_flag(character, id("json_flag", "MUTATION_THRESHOLD"))) then
            message(character, ccb.services.translate("The power attempts to take hold, but is rebuffed by something sinister within you."))
            return
        end
        apply(character)
    end)
end

local function teach_element(handler, trait, mutagen_recipe, potion_recipe, gained)
    imbue(handler, function(character)
        message(character, gained())
        replace_mutation(character, trait)
        checked(services.recipes.learn(character, id("recipe", mutagen_recipe)))
        checked(services.recipes.learn(character, id("recipe", potion_recipe)))
    end)
end

teach_element("drink_earth_imbuement", "IERDE", "mutagen_earthkin", "cthonic_poultice",
    function() return ccb.services.translate("You imbibed the concoction and you feel your soul merge with an alien power, becoming attuned to the earth.") end)

teach_element("drink_water_imbuement", "UNDINE", "mutagen_waterkin", "cerulean_poultice",
    function() return ccb.services.translate("You imbibed the concoction and you feel your soul merge with an alien power, becoming attuned to the waters.") end)

teach_element("drink_air_imbuement", "SYLPH", "mutagen_airkin", "ethereal_draught",
    function() return ccb.services.translate("You imbibed the concoction and you feel your soul merge with an alien power, becoming attuned to the winds.") end)

local function change_vitamin(character, vitamin, delta)
    local current = checked(services.needs.get_vitamin(character, vitamin))
    checked(services.needs.set_vitamin(character, vitamin, current + delta))
end

local function mutate_element(handler, hatred, rival_one, rival_two, elemental_mutagen)
    imbue(handler, function(character)
        message(character, ccb.services.translate("As you imbibe the concoction, you feel the stolen power fusing with your essence."))
        local opposed = has_mutation(character, rival_one) or has_mutation(character, rival_two)
        replace_mutation(character, opposed and "FAE_ENMITY" or hatred)

        local element = id("vitamin", elemental_mutagen)
        local mutagen = id("vitamin", "mutagen")
        change_vitamin(character, element, 500)
        change_vitamin(character, mutagen, 1000)
        checked(services.mutations.mutate(character, 0, true))
        change_vitamin(character, element, -500)
        change_vitamin(character, mutagen, -1000)
    end)
end

mutate_element("drink_plant_imbuement", "FALSE_ARVORE_HATRED",
    "FALSE_HOMULLUS_HATRED", "FALSE_SALAMANDER_HATRED", "mutagen_alchemical_plantkin")

mutate_element("drink_fire_imbuement", "FALSE_SALAMANDER_HATRED",
    "FALSE_ARVORE_HATRED", "FALSE_HOMULLUS_HATRED", "mutagen_flamekin")

mutate_element("drink_doll_imbuement", "FALSE_HOMULLUS_HATRED",
    "FALSE_ARVORE_HATRED", "FALSE_SALAMANDER_HATRED", "mutagen_dollkin")
