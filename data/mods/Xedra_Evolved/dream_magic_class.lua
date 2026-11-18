local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local variables = services.variables
local timers = require("character_timers")
local research = require("dreamsmith_research")

local flavor_riddles = {
    function()
        return ccb.services.translate("All or Nothing?"),
            ccb.services.translate("All"),
            ccb.services.translate("Nothing")
    end,
    function()
        return ccb.services.translate("Dead or Alive?"),
            ccb.services.translate("Dead"),
            ccb.services.translate("Alive")
    end,
    function()
        return ccb.services.translate("Deep or Shallow?"),
            ccb.services.translate("Deep"),
            ccb.services.translate("Shallow")
    end,
    function()
        return ccb.services.translate("Dusk or Dawn?"),
            ccb.services.translate("Dusk"),
            ccb.services.translate("Dawn")
    end,
    function()
        return ccb.services.translate("Enemy or Friend?"),
            ccb.services.translate("Enemy"),
            ccb.services.translate("Friend")
    end,
    function()
        return ccb.services.translate("Even or Odd?"),
            ccb.services.translate("Even"),
            ccb.services.translate("Odd")
    end,
    function()
        return ccb.services.translate("Fail or Success?"),
            ccb.services.translate("Fail"),
            ccb.services.translate("Success")
    end,
    function()
        return ccb.services.translate("Guilty or Innocent?"),
            ccb.services.translate("Guilty"),
            ccb.services.translate("Innocent")
    end,
    function()
        return ccb.services.translate("Hero or Coward?"),
            ccb.services.translate("Hero"),
            ccb.services.translate("Coward")
    end,
    function()
        return ccb.services.translate("Hope or Despair?"),
            ccb.services.translate("Hope"),
            ccb.services.translate("Despair")
    end,
    function()
        return ccb.services.translate("Inner or Outer?"),
            ccb.services.translate("Inner"),
            ccb.services.translate("Outer")
    end,
    function()
        return ccb.services.translate("Victory or Defeat?"),
            ccb.services.translate("Victory"),
            ccb.services.translate("Defeat")
    end,
    function()
        return ccb.services.translate("Madness or Sanity?"),
            ccb.services.translate("Madness"),
            ccb.services.translate("Sanity")
    end,
    function()
        return ccb.services.translate("Oppressed or Oppressor?"),
            ccb.services.translate("Oppressed"),
            ccb.services.translate("Oppressor")
    end,
    function()
        return ccb.services.translate("Rapid or Slow?"),
            ccb.services.translate("Rapid"),
            ccb.services.translate("Slow")
    end,
    function()
        return ccb.services.translate("Remember or Forget?"),
            ccb.services.translate("Remember"),
            ccb.services.translate("Forget")
    end,
    function()
        return ccb.services.translate("The Beginning or The End?"),
            ccb.services.translate("The Beginning"),
            ccb.services.translate("The End")
    end,
    function()
        return ccb.services.translate("Truth or Lie?"),
            ccb.services.translate("Truth"),
            ccb.services.translate("Lie")
    end,
    function()
        return ccb.services.translate("War or Peace?"),
            ccb.services.translate("War"),
            ccb.services.translate("Peace")
    end,
    function()
        return ccb.services.translate("Yes or No?"),
            ccb.services.translate("Yes"),
            ccb.services.translate("No")
    end,
}

local eater_riddles = {
    function()
        return ccb.services.translate("Lord or Peasant?"),
            ccb.services.translate("Lord"),
            ccb.services.translate("Peasant"),
            "DREAMER",
            "EATER"
    end,
    function()
        return ccb.services.translate("King or Pawn?"),
            ccb.services.translate("King"),
            ccb.services.translate("Pawn"),
            "DREAMER",
            "EATER"
    end,
    function()
        return ccb.services.translate("Executed or Executioner?"),
            ccb.services.translate("Executed"),
            ccb.services.translate("Executioner"),
            "EATER",
            "DREAMER"
    end,
    function()
        return ccb.services.translate("Reality or Dreams?"),
            ccb.services.translate("Reality"),
            ccb.services.translate("Dreams"),
            "EATER",
            "DREAMER"
    end,
    function()
        return ccb.services.translate("Leader or Follower?"),
            ccb.services.translate("Leader"),
            ccb.services.translate("Follower"),
            "DREAMER",
            "EATER"
    end,
}

local inventor_riddles = {
    function()
        return ccb.services.translate("Wisdom or Foolishness?"),
            ccb.services.translate("Wisdom"),
            ccb.services.translate("Foolishness"),
            "INVENTOR",
            "DREAMSMITH"
    end,
    function()
        return ccb.services.translate("Purity or Contamination?"),
            ccb.services.translate("Purity"),
            ccb.services.translate("Contamination"),
            "DREAMSMITH",
            "INVENTOR"
    end,
    function()
        return ccb.services.translate("Past or Future?"),
            ccb.services.translate("Past"),
            ccb.services.translate("Future"),
            "DREAMSMITH",
            "INVENTOR"
    end,
    function()
        return ccb.services.translate("Complex or Straightforward?"),
            ccb.services.translate("Complex"),
            ccb.services.translate("Straightforward"),
            "INVENTOR",
            "DREAMSMITH"
    end,
    function()
        return ccb.services.translate("Knowledge or Certainty?"),
            ccb.services.translate("Knowledge"),
            ccb.services.translate("Certainty"),
            "INVENTOR",
            "DREAMSMITH"
    end,
}

local eater_spells = { "spring_heeled_leap", "spell_rage", "spell_stamina_wonder", "spell_dodge" }

local dreamer_spells = { "dream_dagger", "make_constructed_hammer", "summon_shifter" }

local eater_dreams = {
    [2] = function()
        return {
            ccb.services.translate("In your dream, you stand at the edge of two worlds, a bad feeling overcoming you."),
        }
    end,
    [3] = function()
        return {
            ccb.services.translate("One world's infinitely dense, concentrated into a singular dot with neverending gales and scorching heat."),
        }
    end,
    [4] = function()
        return {
            ccb.services.translate("The other world is limitless, full to the brim with potential and boundless possibilities.  You watched it, but can't comprehend what you saw."),
        }
    end,
    [5] = function()
        return {
            ccb.services.translate("You watch for a while but there is only you to decide and decide you must."),
            ccb.services.translate("You don't remember much from your dream, but what little you do is that there was something… or someone, and you answered their questions."),
        }
    end,
}

local inventor_dreams = {
    [2] = function()
        return {
            ccb.services.translate("It happens again.  Otherworldly nightmares haunt you."),
        }
    end,
    [3] = function()
        return {
            ccb.services.translate("Another time, another two worlds."),
        }
    end,
    [4] = function()
        return {
            ccb.services.translate("You don't remember much from these two, they felt very similar."),
        }
    end,
    [5] = function()
        return {
            ccb.services.translate("One was tiring and hard-working."),
        }
    end,
    [6] = function()
        return {
            ccb.services.translate("The second was information, information, and nothing but information."),
        }
    end,
    [7] = function()
        return {
            ccb.services.translate("It is time to choose again."),
            ccb.services.translate("It is that person again."),
        }
    end,
}

local allow = "allow_sequence"
local magic_potential = "magic_potential"
local eater_sequence = "eater_dreamer_sequence"
local inventor_sequence = "inventor_dreamsmith_sequence"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function number(key)
    return checked(variables.get_global_number(key)).value or 0
end

local function store(key, value)
    checked(variables.set_global(key, value, { include_before = false }))
end

local function message(character, text, popup)
    if character.subtype == "avatar" then
        if popup then
            ccb.presentation.notice(text)
            services.activities.offer_interruption("")
        end
        services.messages.add(text, "mixed")
    end
end

local function choose_two(title, left, right, first, second)
    local selection = services.interaction.choose({
        { id = first, label = left },
        { id = second, label = right },
    }, { title = title, allow_cancel = false })
    return selection.id
end

local function flavor_riddle()
    local weights = {}
    for index in ipairs(flavor_riddles) do
        weights[index] = math.modf(number(string.format("xe_riddle_%02d", index)) + 1)
    end
    local index = services.random.weighted_index(weights)
    if index == nil then
        return
    end
    local key = string.format("xe_riddle_%02d", index)
    store(key, number(key) - 1)
    local title, left, right = flavor_riddles[index]()
    choose_two(title, left, right, "left", "right")
end

local function grant_one(character, kind, pool)
    local candidates = {}
    for index, entry in ipairs(pool) do
        candidates[index] = id(kind, entry)
    end
    checked(services.progression.grant_random_missing(character, kind, candidates))
end

local function finish_eater_or_dreamer(character, career)
    checked(services.mutations.replace(character, id("mutation", career)))
    local spells = career == "EATER" and eater_spells or dreamer_spells
    grant_one(character, "spell", spells)
    grant_one(character, "spell", spells)
    local text = ccb.services.translate("It doesn't matter…")
    local entries = {}
    for index = 1, 8 do
        entries[index] = { id = tostring(index), label = text }
    end
    services.interaction.choose(entries, { title = text, allow_cancel = false })
    message(character, ccb.services.translate("Since your kind is doomed…"))
end

local function finish_inventor_or_dreamsmith(character, career)
    checked(services.mutations.replace(character, id("mutation", career)))
    if career == "DREAMSMITH" then
        research.advance_enchanted_recipes(character)
        research.advance_enchanted_recipes(character)
    else
        grant_one(character, "recipe", { "inventor_research_base_1" })
    end
    message(character, ccb.services.translate("Your attempts to save anything are hopeless…"))
    store(magic_potential, 0)
end

local function class_riddle(character, riddles, finish)
    flavor_riddle()
    flavor_riddle()
    local index = services.random.weighted_index { 1, 1, 1, 1, 1 }
    local career = choose_two(riddles[index]())
    if career then
        finish(character, career)
    end
end

local function show_dream_line(character, lines, step)
    local line = lines[math.floor(step)]
    if line then
        for _, text in ipairs(line()) do
            message(character, text, true)
        end
    end
end

local function eater_dreamer_dream(character)
    local step = number(eater_sequence)
    if step <= 0 then
        return
    end
    if has_trait(character, "EATER") or has_trait(character, "DREAMER") then
        store(eater_sequence, -99999)
        store(magic_potential, 0)
        return
    end
    step = step + 1
    store(eater_sequence, step)
    show_dream_line(character, eater_dreams, math.min(step, 5))
    if step >= 5 then
        class_riddle(character, eater_riddles, finish_eater_or_dreamer)
        store(eater_sequence, -99999)
        store(magic_potential, 0)
    end
end

local function inventor_dreamsmith_dream(character)
    local step = number(inventor_sequence)
    if step <= 0 then
        return
    end
    step = step + 1
    store(inventor_sequence, step)
    if has_trait(character, "INVENTOR") or has_trait(character, "DREAMSMITH") then
        store(inventor_sequence, -99999)
        store(magic_potential, -1)
        return
    end
    show_dream_line(character, inventor_dreams, math.min(step, 7))
    if step >= 7 then
        class_riddle(character, inventor_riddles, finish_inventor_or_dreamsmith)
        store(inventor_sequence, -99999)
    end
end

local function no_sequence()
    return number(allow) == 1 and number(eater_sequence) == 0 and number(inventor_sequence) == 0
end

ccb.runtime.handler("xedra_dream_class_on_wake", function(event)
    local character = event.actors.character or services.characters.avatar()
    if not has_trait(character, "EATER") and not has_trait(character, "DREAMER") and no_sequence() then
        store(allow, 0)
        store(eater_sequence, number(eater_sequence) + 1)
    end
    if not has_trait(character, "INVENTOR") and not has_trait(character, "DREAMSMITH") and no_sequence() then
        store(allow, 0)
        store(inventor_sequence, number(inventor_sequence) + 1)
    end
    eater_dreamer_dream(character)
    inventor_dreamsmith_dream(character)
end, 1)
ccb.runtime.on("game:character_wakes_up", "xedra_dream_class_on_wake")

timers.register("xedra_dream_class_timer", "xedra_allow_dream_class_due", function()
    return services.random.native_int(services.time.duration(1, "day").turns,
        services.time.duration(3, "day").turns)
end, function() return true end, function(character)
    if not has_trait(character, "EATER") and not has_trait(character, "DREAMER")
        and not has_trait(character, "INVENTOR") and not has_trait(character, "DREAMSMITH")
        and number(magic_potential) > 0 and not has_trait(character, "DREAMLESS")
        and research.may_use_dream_magic(character) then
        store(allow, 1)
    end
end)
