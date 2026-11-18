local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local duration = services.time.duration
local id = services.types.id
local random_int = services.random.native_int

local template = content.Item {
    id = "magic_square_base",
    abstract = true,
    name = "Magic Square abstract",
    description = "SATOR AREPO TENET OPERA ROTAS.",
    mass_grams = 3,
    color = "white",
    symbol = "`",
    price_cents = 0,
    price_postapoc_cents = 0,
    volume_ml = 6,
    longest_side_mm = 297,
    variant_kind = "generic",
}
template:tool()
template:material("paper", 1)
template:flag("TINDER"):flag("PAPER_SHAPED"):flag("SINGLE_USE")
content.add(template)

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function square(key, name, use)
    local handler = "use_hedge_magic_square_" .. key
    ccb.runtime.handler(handler, function(ctx)
        if not ctx.character then return nil end

        -- The original duration of 2.5 turns was truncated by the native clock.
        value(services.activities.assign_timed(ctx.character, id("activity", "ACT_GENERIC_EOC"), duration(2, "turn")))
        use(ctx)
        return 1
    end)

    local book = content.Item {
        id = "item_" .. key .. "_magic_square",
        copy_from = "magic_square_base",
        name = name,
        description = ccb.content.text("A piece of paper.  A magic square is carefully written on it."),
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        scannable = true,
    }
    book:flag("HEDGE_ENCHANTED")
    book:clear_use_actions()
    book:on_use(handler, ccb.content.text("Activate"), ccb.content.text("Activate the charm using the magic square."))
    content.add(book)
end

local function apply_effect(effect, turns, intensity)
    return function(ctx)
        value(services.effects.add(ctx.character, id("effect", effect), duration(turns, "turn"), {
            intensity = intensity,
        }))
    end
end

square("walk_on_water",
    ccb.content.plural_text("magic square (To Walk Upon the Water)", "magic squares (To Walk Upon the Water)"),
    apply_effect("effect_hedge_walk_on_water_magic_square", 1800, 30))

square("breathe_water",
    ccb.content.plural_text("magic square (To Operate Under the Water)", "magic squares (To Operate Under the Water)"),
    apply_effect("effect_hedge_breathe_water_magic_square", 7200, 120))

square("bash_terrain",
    ccb.content.plural_text("magic square (To Demolish Buildings and Strongholds)",
        "magic squares (To Demolish Buildings and Strongholds)"),
    function(ctx)
        value(services.characters.cast_spell(ctx.character, id("spell", "hedge_bash_terrain_magic_square_real"), {
            targeted = true,
        }))
    end)

square("armed_men",
    ccb.content.plural_text("magic square (To Cause Armed Men to Appear)", "magic squares (To Cause Armed Men to Appear)"),
    function(ctx)
        local center = value(services.creatures.snapshot(ctx.character)).position
        local group = id("monster_group", "GROUP_HEDGE_TO_CAUSE_ARMED_MEN")
        local visible = 0
        for _ = 1, 2 + random_int(0, 3) do
            local monster = services.spawns.choose_monster_from_group(group)
            local result = value(services.spawns.population(monster, center, {
                min_radius = 1,
                max_radius = 3,
                lifespan = {
                    minimum = duration(15, "minute"),
                    maximum = duration(45, "minute"),
                },
            }))
            visible = visible + result.visible
        end

        if visible > 1 then
            services.messages.add(ccb.services.translate("Several armed warriors appear."), "bad")
        elseif visible == 1 then
            services.messages.add(ccb.services.translate("An armed warrior appears."), "bad")
        end
    end)

local function summon_food(ctx, food, message, minimum, maximum)
    ctx:message(message)
    value(services.inventory.receive_item(ctx.character, id("item", food), minimum + random_int(0, maximum - minimum)))
end

local food_choices = {
    {
        label = function() return ccb.services.translate("Summon meat") end,
        description = function() return ccb.services.translate("Ask the spirits to summon some meat for you to eat.") end,
        summon = function(ctx)
            summon_food(ctx, "meat_cooked",
                ccb.services.translate("There is a gust of wind, a sparkle in the air, and a faint murmur of sound, and some cooked meat appears before you."),
                1, 4)
        end,
    },
    {
        label = function() return ccb.services.translate("Summon cheese") end,
        description = function() return ccb.services.translate("Ask the spirits to summon some cheese for you to eat.") end,
        summon = function(ctx)
            summon_food(ctx, "cheese_hard",
                ccb.services.translate("There is a gust of wind, a sparkle in the air, and a faint murmur of sound, and some hard cheese appears before you."),
                4, 15)
        end,
    },
    {
        label = function() return ccb.services.translate("Summon fish") end,
        description = function() return ccb.services.translate("Ask the spirits to summon some fish for you to eat.") end,
        summon = function(ctx)
            summon_food(ctx, "fish_cooked",
                ccb.services.translate("There is a gust of wind, a sparkle in the air, and a faint murmur of sound, and some cooked fish appears before you."),
                1, 4)
        end,
    },
    {
        label = function() return ccb.services.translate("Summon bread") end,
        description = function() return ccb.services.translate("Ask the spirits to summon some bread for you to eat.") end,
        summon = function(ctx)
            summon_food(ctx, "bread",
                ccb.services.translate("There is a gust of wind, a sparkle in the air, and a faint murmur of sound, and some fresh bread appears before you."),
                2, 8)
        end,
    },
    {
        label = function() return ccb.services.translate("Summon wine") end,
        description = function() return ccb.services.translate("Ask the spirits to summon a bottle of wine for you to drink.") end,
        summon = function(ctx)
            ctx:message(ccb.services.translate("There is a gust of wind, a sparkle in the air, and a faint murmur of sound, and a bottle of wine appears before you."))
            local wine = random_int(0, 1) == 1 and "wine_riesling" or "wine_noir"
            value(services.inventory.receive_item(ctx.character, id("item", wine), 3, {
                container = id("item", "bottle_glass"),
            }))
        end,
    },
}

square("food_or_drink",
    ccb.content.plural_text("magic square (To Cause the Spirits to Bring us Anything We May Wish to Eat or to Drink)",
        "magic squares (To Cause the Spirits to Bring us Anything We May Wish to Eat or to Drink)"),
    function(ctx)
        local entries = {}
        for index, food in ipairs(food_choices) do
            entries[index] = { id = tostring(index), label = food.label(), description = food.description() }
        end
        local choice = services.interaction.choose(entries, {
            title = ccb.services.translate("Conjure which victuals?"),
            allow_cancel = true,
            show_descriptions = true,
        })
        if choice.accepted then food_choices[choice.index].summon(ctx) end
    end)

square("invisibility",
    ccb.content.plural_text("magic square (To Render Oneself Invisible Unto Every Person)",
        "magic squares (To Render Oneself Invisible Unto Every Person)"),
    apply_effect("effect_invisibility_magic_square", 4620, 77))
