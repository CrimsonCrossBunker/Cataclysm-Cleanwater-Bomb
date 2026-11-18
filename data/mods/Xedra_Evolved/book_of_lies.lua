local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local random = services.random
local time = services.time
local id = services.types.id

local activity_id = "ACT_READING_BOOK_LIES"
local reading_time = "time_reading_book_lies"
local deduction_points = "deduction_from_book_lies_counter"
local hound_delay = "delay_before_hound"
local claw_delay = "delay_before_claw"
local clawed_parts = { "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r" }

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function advance(character, key, delta)
    store(character, key, number(character, key) + delta)
end

local function deduction(character)
    return math.modf(checked(services.skills.level(character, "deduction")))
end

local function add_effect(character, effect, seconds, options)
    checked(services.effects.add(character, id("effect", effect), time.duration(seconds, "second"), options))
end

local function taint_intensity(character)
    local result = services.effects.get(character, id("effect", "taint"), id("body_part", "bp_null"))
    if not result.ok and result.error.code == "not_found" then
        return -1
    end
    return checked(result).intensity
end

local function hurt_part(character, part, damage)
    local body_part = id("body_part", part)
    local hp = checked(services.characters.hp(character, body_part))
    local remaining = math.modf(hp - damage)
    checked(services.characters.set_hp(character, body_part, remaining, true))
end

local function warn_about_visions(character)
    if character.subtype == "avatar" then
        services.messages.add(services.translate("Your sight darkens as the visions overtake you!"), "bad")
    end
end

local function snippet_popup(character, category)
    if character.subtype == "avatar" then
        ccb.presentation.notice(services.snippets.native_random(category) or "")
        services.activities.offer_interruption("")
    end
end

local function hounds(character)
    if not (number(character, hound_delay) <= 0) then
        return
    end
    add_effect(character, "taint", random.native_int(120, 300), { intensity = taint_intensity(character) + 1 })
    if taint_intensity(character) >= 2 and random.native_int(0, 1) == 0 then
        add_effect(character, "hallu", random.native_int(1500, 2100))
        local position = checked(services.creatures.snapshot(character)).position
        services.spawns.hostile_hallucination(position, 50, time.duration(60, "second"))
    end
    if taint_intensity(character) >= 3 and random.native_int(0, 11) == 0 then
        add_effect(character, "blind", random.native_int(240, 300))
        warn_about_visions(character)
    end
    if taint_intensity(character) == 4 and random.native_int(0, 11) == 0 then
        add_effect(character, "tindrift", 1)
        warn_about_visions(character)
    end
    advance(character, deduction_points, 750)
    if not checked(services.effects.has(character, id("effect", "taint"))) then
        for _, part in ipairs(clawed_parts) do
            hurt_part(character, part, 5)
        end
        snippet_popup(character, "book_lies_taint_resisted")
    end
    store(character, hound_delay, random.native_float(5, 15))
end

local function claw(character)
    if not (number(character, claw_delay) <= 0) then
        return
    end
    local part = random.native_int(0, 5)
    store(character, "random_clawed_part", part)
    hurt_part(character, clawed_parts[part + 1], random.native_float(35, 45))
    advance(character, deduction_points, 6250)
    snippet_popup(character, "book_lies_claw")
    store(character, claw_delay, random.native_float(25, 35))
end

local function provoked(character, vitamin, threshold)
    local knowing = checked(services.needs.get_vitamin(character, vitamin))
    return random.native_int(math.min(0, knowing), math.max(0, knowing)) >= threshold
end

ccb.runtime.handler("read_book_of_lies_turn", function(activity)
    local character = activity.character
    local seconds = number(character, reading_time) + 1
    store(character, reading_time, seconds)
    if not (seconds >= 10) then
        return
    end

    local knowing_lies = id("vitamin", "xedra_knowing_lies")
    local knowing = checked(services.needs.get_vitamin(character, knowing_lies))
    checked(services.needs.set_vitamin(character, knowing_lies, knowing + 1))
    advance(character, deduction_points, 1)
    advance(character, hound_delay, -1)
    advance(character, claw_delay, -1)
    store(character, reading_time, 0)

    if provoked(character, knowing_lies, 150) and random.native_probability(1, 2) then
        checked(services.needs.modify_raw_pain(character, 1))
        advance(character, deduction_points, 25)
    end
    if provoked(character, knowing_lies, 150) then
        checked(services.needs.modify_health(character, { lifestyle = -1 }))
        advance(character, deduction_points, 25)
    end
    if provoked(character, knowing_lies, 300) and random.native_probability(1, 3) then
        local penalty = -3 * deduction(character)
        checked(services.variables.set_global("morale_book_lies", penalty, { include_before = false }))
        checked(services.morale.add(character, id("morale", "morale_book_lies"), penalty, penalty,
            { duration = time.duration(30, "minute"), decay_start = time.duration(15, "minute") }))
        advance(character, deduction_points, 50)
    end
    if provoked(character, knowing_lies, 1200) then
        hounds(character)
    end
    if provoked(character, knowing_lies, 2000) then
        claw(character)
    end
end, 1)

local function finish_reading(character)
    local points = number(character, deduction_points)
    local avatar = character.subtype == "avatar"
    if points <= 15500 then
        if avatar then
            services.messages.add(services.translate(
                "You gained almost no knowledge from this session.  Maybe if you read more, you will gain more."), "bad")
        end
    elseif points <= 33000 then
        if avatar then
            services.messages.add(services.translate("You gained a decent amount of knowledge from this read."), "good")
        end
        points = points * 2
        store(character, deduction_points, points)
    elseif points > 33000 then
        if avatar then
            services.messages.add(services.translate(
                "You bear the marks inflicted by beings that do not want you to know this much.  Not moderating your use of this book will have consequences, but what you are gaining from it might be worth the cost."),
                "mixed")
        end
        points = points * 3
        store(character, deduction_points, points)
    end
    local skill = id("skill", "deduction")
    local before = checked(services.skills.get(character, skill)).practical_exercise_raw
    local speed = services.gameplay.options.get_number("SKILL_TRAINING_SPEED")
    local experience = math.modf(before + points * speed)
    checked(services.skills.set(character, skill, { exercise_raw = experience }))
    store(character, deduction_points, 0)
end

ccb.runtime.handler("finish_book_of_lies", function(activity)
    finish_reading(activity.character)
end, 1)

ccb.runtime.handler("award_book_of_lies_on_activity_end", function(event)
    if event.data.activity == activity_id then
        finish_reading(event.actors.character or services.characters.avatar())
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "award_book_of_lies_on_activity_end")

ccb.runtime.handler("open_book_of_lies", function(use)
    local character = use.character
    if not character then
        return 0
    end
    local level = deduction(character)
    if level < 7 then
        use:message(services.translate("Fortunately, you lack the deductive abilities to understand this book."), "good")
    elseif level >= 10 then
        use:message(services.translate("Rejoice, for you have no reason to read this book anymore."), "good")
    else
        local assigned = services.activities.assign_timed(character, id("activity", activity_id), time.duration(8, "hour"))
        if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
            checked(assigned)
        end
        use:message(services.translate("You begin your read, for better or worse."), "mixed")
    end
    return 0
end, 1)

content.add(content.ActivityType {
    id = activity_id,
    verb = content.text("reading"),
    based_on = "time",
    can_resume = false,
    rooted = true,
}:on_turn("read_book_of_lies_turn"):on_finish("finish_book_of_lies"))

content.add(content.Item {
    id = "book_deduction_lies",
    name = content.plural_text("Lies", "copies of Lies"),
    description = content.text("A haphazardly-written book filled with ramblings about something it calls \"the Lies\".  You feel threatened by this book, uneasy at the thought of having it on your person, but parsing its texts could give you insight on how things truly are.\nOnly the first third of the pages are filled with text, and the last written page is splattered in red."),
    mass_grams = 830,
    volume_ml = 1320,
    price_cents = 100,
    looks_like = "cookbook",
    symbol = "?",
    color = "dark_gray",
}:tool({}):material("paper", 1):flag("TRADER_AVOID")
    :on_use("open_book_of_lies", content.text("Read the book."), content.text("Read the book.")))
