local ccb = require("ccb")
local services = ccb.services
local characters = services.characters
local needs = services.needs
local mutations = services.mutations
local addictions = services.addictions
local variables = services.variables
local environment = services.gameplay.environment
local random = services.random
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(text, kind)
    services.messages.add(text, kind or "neutral")
end

local function story_popup(text)
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
    message(text)
end

local function has_trait(character, trait)
    return checked(mutations.has(character, id("mutation", trait)))
end

local function set_trait(character, trait)
    checked(mutations.replace(character, id("mutation", trait)))
end

local marloss_morale = id("morale", "morale_marloss")
local marloss_threshold = "THRESH_MARLOSS"
local mycus_threshold = "THRESH_MYCUS"
local spore = id("monster", "mon_spore")
local component_traits = { "MARLOSS", "MARLOSS_BLUE", "MARLOSS_YELLOW" }
local component_addictions = { id("addiction", "marloss_r"), id("addiction", "marloss_b"), id("addiction", "marloss_y") }

local function clear_addictions(character)
    for _, addiction in ipairs(component_addictions) do
        checked(addictions.remove(character, addiction))
    end
end

local function clear_components(character)
    for _, trait in ipairs(component_traits) do
        checked(mutations.erase(character, id("mutation", trait)))
    end
    clear_addictions(character)
end

local function expose_other_components(character, first, second, strength)
    checked(addictions.expose(character, first, strength))
    checked(addictions.expose(character, second, strength))
end

local function profile(character)
    return checked(characters.snapshot(character, 0))
end

local function event(character, name, item_type)
    local args = { tostring(profile(character).id) }
    if item_type then args[2] = item_type end
    services.native_events.emit(name, args)
end

local function after_consumption(character, task)
    ccb.tasks.after_character_turn(character, 0, task)
end

local function sleep(character, base, discount)
    local turns = base - discount * profile(character).stats.intelligence
    checked(needs.fall_asleep(character, services.time.duration_from_turns(turns)))
end

ccb.runtime.handler("marloss_vomit_due", function(task)
    checked(needs.vomit(task.character))
end)

ccb.runtime.handler("marloss_rejection_due", function(task)
    checked(needs.vomit(task.character))
    sleep(task.character, 36000, 60)
end)

ccb.runtime.handler("marloss_gateway_sleep_due", function(task)
    sleep(task.character, 2400, 30)
end)

ccb.runtime.handler("mycus_assimilation_sleep_due", function(task)
    sleep(task.character, 18000, 60)
end)

local function stomach_discomfort(character)
    checked(needs.modify_calories(character, -87))
    local current = checked(needs.get(character))
    checked(needs.set(character, { thirst = current.thirst + 10, sleepiness = current.sleepiness + 5 }))
end

local function mutate_and_upset_stomach(character)
    checked(mutations.mutate(character, 1, false))
    checked(needs.modify_pain(character, 2 * (1 + random.native_int(0, 4))))
    stomach_discomfort(character)
end

local function increase_painkiller(character, amount)
    local current = checked(needs.get(character)).painkiller
    checked(needs.set(character, { painkiller = current + amount }))
end

local function relieved(character)
    message(ccb.services.translate("You feel better all over."), "good")
    increase_painkiller(character, 30)
    checked(needs.modify_pain(character, -40))
end

local function reject_marloss(character)
    message(ccb.services.translate("You feel a familiar warmth, but suddenly it surges into an excruciating burn as you convulse, vomiting, and black out…"), "bad")
    checked(characters.add_memorial(character,
        ccb.services.translate("Suffered Marloss Rejection.", "memorial_male"),
        ccb.services.translate("Suffered Marloss Rejection.", "memorial_female")))
    checked(needs.modify_pain(character, 90))
    checked(characters.hurt_all(character, 40 + random.native_int(0, 25)))
    after_consumption(character, "marloss_rejection_due")
    clear_components(character)
    set_trait(character, "MARLOSS_AVOID")
end

local function actor_position(character)
    return checked(services.creatures.snapshot(character)).position
end

local function open_gateway(character)
    message(ccb.services.translate("You feel a familiar warmth, but suddenly it surges into painful burning as you convulse and collapse to the ground…"), "bad")
    after_consumption(character, "marloss_gateway_sleep_due")
    clear_components(character)
    set_trait(character, marloss_threshold)
    environment.set_terrain(actor_position(character), "t_marloss", 0)
    event(character, "crosses_marloss_threshold")
    message(ccb.services.translate("You wake up in a Marloss bush.  Almost *cradled* in it, actually, as though it grew there for you."), "good")
    message(ccb.services.translate("unity.  together we have reached the door.  we provide the final key.  now to pass through…"), "good")
end

local function gain_component(character, component)
    if checked(characters.has_flag(character, id("json_flag", "MUTATION_THRESHOLD"))) then
        reject_marloss(character)
        return
    end
    local held = 0
    for _, trait in ipairs(component_traits) do
        if has_trait(character, trait) then held = held + 1 end
    end
    if held >= 2 then
        open_gateway(character)
        return
    end
    message(ccb.services.translate("You feel a strange warmth spreading throughout your body…"))
    set_trait(character, component.trait)
    checked(addictions.remove(character, component.addiction))
    expose_other_components(character, component.other_first, component.other_second, 60)
end

local function nearby_tiles(character, radius)
    local diameter = 2 * radius + 1
    return services.world.points_nearby(actor_position(character), {
        max_radius = radius, limit = diameter * diameter,
    }).items
end

local function repeat_marloss(character, component, item)
    local name = item and checked(services.items.snapshot(item, 0)).type_name or ""
    local text = ccb.services.translate("As you eat the <npc_name>, you have a near-religious experience, feeling at one with your surroundings…")
    message((text:gsub("<npc_name>", function() return name end)), "good")
    checked(services.morale.add(character, marloss_morale, 100, 1000))
    expose_other_components(character, component.other_first, component.other_second, 50)
    checked(needs.set(character, { hunger = -10 }))

    local spore_count = "marloss_spores_spawned"
    local options = { include_before = false }
    checked(variables.set(character, spore_count, 0, options))
    local spawned = 0
    for _, tile in ipairs(nearby_tiles(character, 4)) do
        if environment.is_passable(tile.position) then
            local distance = tile.distance
            if random.native_probability(1, distance) then environment.marlossify(tile.position) end
            if random.one_in(10 + 5 * distance) and random.one_in(spawned * 2) then
                local result = checked(services.spawns.population(spore, tile.position, {
                    count = 1, min_radius = 0, max_radius = 0, friendly = true, open_air_allowed = true,
                }))
                if result.spawned > 0 then
                    spawned = spawned + 1
                    checked(variables.set(character, spore_count, spawned, options))
                end
            end
        end
    end
    checked(variables.remove(character, spore_count, options))
end

local outcomes = {
    function(character)
        message(ccb.services.translate("It tastes extremely strange!"))
        mutate_and_upset_stomach(character)
    end,
    relieved,
    function(character)
        relieved(character)
        checked(needs.set(character, { radiation = 0 }))
    end,
    function(character)
        if checked(needs.fill_stomach(character, 0.125, 6)) > 0 then
            message(ccb.services.translate("It is delicious, and very filling!"), "good")
        else
            message(ccb.services.translate("It is delicious, but you can't eat any more."), "bad")
        end
    end,
    function(character)
        message(ccb.services.translate("You take one bite, and immediately vomit!"), "bad")
        after_consumption(character, "marloss_vomit_due")
    end,
    gain_component,
}
local outcome_weights = { 3, 2, 1, 1, 1, 4 }

local function register_marloss(name, item_type, primary, other_first, other_second)
    local component = {
        trait = component_traits[primary],
        addiction = component_addictions[primary],
        other_first = component_addictions[other_first],
        other_second = component_addictions[other_second],
    }
    local function consume(context, item)
        local character = context.character
        if character.subtype ~= "avatar" or has_trait(character, "MARLOSS_AVOID")
            or has_trait(character, mycus_threshold) then
            return
        end
        event(character, "consumes_marloss_item", item_type)
        if has_trait(character, component.trait) or has_trait(character, marloss_threshold) then
            repeat_marloss(character, component, item)
        else
            outcomes[random.weighted_index(outcome_weights)](character, component)
        end
    end
    ccb.runtime.handler("eat_" .. name, function(context) consume(context, context.item) end)
    ccb.runtime.handler("use_" .. name, function(context) consume(context) end)
end

register_marloss("marloss_berry", "marloss_berry", 1, 2, 3)
register_marloss("wine_marloss", "wine_marloss", 1, 2, 3)
register_marloss("marloss_seed", "marloss_seed", 2, 1, 3)
register_marloss("marloss_gel", "marloss_gel", 3, 1, 2)

local function assimilate(character)
    event(character, "crosses_mycus_threshold")
    message(ccb.services.translate("It tastes amazing, and you finish it quickly."))
    message(ccb.services.translate("You feel better all over."), "good")
    increase_painkiller(character, 30)
    checked(needs.set(character, { radiation = 0 }))
    checked(characters.heal_all(character, 4))
    message(ccb.services.translate("As it settles in, you feel ecstasy radiating through every part of your body…"), "good")
    checked(services.morale.add(character, marloss_morale, 1000, 1000))
    message(ccb.services.translate("Your eyes roll back in your head.  Everything dissolves into a blissful haze…"), "good")
    after_consumption(character, "mycus_assimilation_sleep_due")
    checked(mutations.erase(character, id("mutation", marloss_threshold)))
    set_trait(character, mycus_threshold)

    story_popup(ccb.services.translate("we welcome into us.  we have endured long in this forbidding world."))
    message(" ")
    message(ccb.services.translate("A sea of white caps, waving gently.  A haze of spores wafting silently over a forest."), "good")
    story_popup(ccb.services.translate('the natives have a saying: "e pluribus unum."  out of many, one.'))
    message(" ")
    message(ccb.services.translate("The blazing pink redness of the berry.  The juices spreading across our tongue, the warmth draping over us like a lover's embrace."), "good")
    story_popup(ccb.services.translate("we welcome the union of our lines in our local guide.  we will prosper, and unite this world.  even now, our fruits adapt to better serve local physiology."))
    message(" ")
    message(ccb.services.translate("The sky-blue of the seed.  The nutty, creamy flavors intermingling with the berry, a memory that will never leave us."), "good")
    story_popup(ccb.services.translate("as, in time, shall we adapt to better welcome those who have not received us."))
    message(" ")
    message(ccb.services.translate('The amber-yellow of the sap.  Feel it flowing through our veins, taking the place of the strange, thin red gruel called "blood."'), "good")
    story_popup(ccb.services.translate("we are the Mycus."))

    for _, tile in ipairs(nearby_tiles(character, 3)) do
        local position = tile.position
        if environment.is_passable(position) and environment.furniture_id(position) == "f_null"
            and not environment.terrain_has_flag(position, "DEEP_WATER")
            and not environment.terrain_has_flag(position, "NO_FLOOR") then
            environment.marlossify(position)
        end
    end
    clear_addictions(character)
end

ccb.runtime.handler("eat_mycus", function(context)
    local character = context.character
    if character.subtype ~= "avatar" then return end
    if has_trait(character, marloss_threshold) then
        assimilate(character)
    elseif has_trait(character, mycus_threshold) then
        if has_trait(character, "M_DEPENDENT") then
            increase_painkiller(character, 5)
            local stimulant = checked(needs.get(character)).stimulant
            checked(needs.set(character, { stimulant = stimulant + 5 }))
        elseif not random.one_in(3) then
            checked(mutations.mutate_category(character, id("mutation_category", "MYCUS"), false, true))
            stomach_discomfort(character)
            checked(services.morale.add(character, marloss_morale, 25, 200))
        end
    else
        message(ccb.services.translate("This tastes really weird!  You're not sure it's good for you…"))
        mutate_and_upset_stomach(character)
        after_consumption(character, "marloss_vomit_due")
        checked(needs.modify_health(character, { daily_health = -8, daily_health_cap = -50 }))
    end
end)
