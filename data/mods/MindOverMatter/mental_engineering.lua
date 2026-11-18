local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local activity_id = "ACT_PSI_TELEPATH_ADJUSTING_MENTALITY"
local pending_adjustment = "mentality_picked"

local function read(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, key)
    return read(services.mutations.has_id_text(character, key))
end

local function has_item(character, key)
    local resources = read(services.inventory.resources(character, id("item", key), 1))
    return resources.charges > 0 or resources.has_amount
end

local function telepathy_level(character)
    return read(services.spells.level_sum(character, id("mutation", "TELEPATH")))
end

local function message(character, text, severity)
    if character.subtype == "avatar" then
        services.messages.add(text, severity or "neutral")
    end
end

-- The choice IDs are saved while the activity is in progress.
local adjustments = {
    {
        id = 1,
        minimum = 60,
        eligible = function(character)
            return not has_trait(character, "PSYCHOPATH")
                and not has_trait(character, "PACIFIST")
                and not has_trait(character, "NUMB")
        end,
        text = function()
            return ccb.services.translate("Become Uncaring"),
                ccb.services.translate("You will no longer care about harming your fellow humans and other innocent creatures.")
        end,
    },
    {
        id = 2,
        minimum = 40,
        eligible = function(character)
            return has_trait(character, "PSYCHOPATH")
        end,
        text = function()
            return ccb.services.translate("Stop being Uncaring"),
                ccb.services.translate("The suffering of your fellows will affect you.  How could you possibly live like that?")
        end,
    },
    {
        id = 3,
        minimum = 120,
        eligible = function(character)
            return has_trait(character, "PACIFIST")
        end,
        text = function()
            return ccb.services.translate("Remove your Pacifist desires"),
                ccb.services.translate("Lose your pacifistic desires to do no harm.  Even thinking about what you might do afterwards unnerves you.")
        end,
    },
    {
        id = 4,
        minimum = 120,
        eligible = function(character)
            return has_trait(character, "THRESH_MEDICAL")
                and not has_trait(character, "NUMB")
                and not has_trait(character, "PACIFIST")
                and not has_trait(character, "PSYCHOPATH")
        end,
        text = function()
            return ccb.services.translate("Become Numb"),
                ccb.services.translate("Stop caring about all the little ups and downs of the Cataclysm.  You feel this is only possible due to your extensive consumption of Medical mutagen.")
        end,
    },
    {
        id = 5,
        minimum = 100,
        eligible = function(character)
            return has_trait(character, "NUMB")
        end,
        text = function()
            return ccb.services.translate("Stop being Numb"),
                ccb.services.translate("Let yourself be affected by all the ups and downs of the Cataclysm.  Hopefully more up than down.")
        end,
    },
    {
        id = 6,
        minimum = 190,
        eligible = function(character)
            return has_trait(character, "NYCTOPHOBIA")
        end,
        text = function()
            return ccb.services.translate("Conquer Nyctophobia"),
                ccb.services.translate("Perform a comprehensive and corrective surgery to cure your fear of the dark.  No longer will you be paralyzed by errant shadows.")
        end,
    },
    {
        id = 7,
        minimum = 90,
        eligible = function(character)
            return has_trait(character, "VANITY")
        end,
        text = function()
            return ccb.services.translate("Stop your Vanity"),
                ccb.services.translate("Deflate your perfectly logical, justified, and factual acknowledgement of your beauty.  How could you deprive everyone else of your looks?")
        end,
    },
    {
        id = 8,
        minimum = 60,
        eligible = function(character)
            return has_trait(character, "PICKYEATER")
        end,
        text = function()
            return ccb.services.translate("Stop being a Picky Eater"),
                ccb.services.translate("Rather than expanding your palette the normal way, use your incredible telepathic powers to force yourself to be OK with untasty looking food.  At least it gets the job done.")
        end,
    },
    {
        id = 9,
        minimum = 10,
        eligible = function(character)
            return not has_trait(character, "SOCIAL1")
                and not has_trait(character, "SOCIAL2")
                and not has_trait(character, "AMOG")
                and not has_trait(character, "DARK_TRIAD")
                and not has_trait(character, "ASOCIAL1")
                and not has_trait(character, "ASOCIAL2")
        end,
        text = function()
            return ccb.services.translate("Push Extroversion"),
                ccb.services.translate("Force yourself to appreciate the company of others by making yourself an extrovert.  Hopefully you'll be able to find people to interact with.")
        end,
    },
    {
        id = 10,
        minimum = 10,
        eligible = function(character)
            return has_trait(character, "SOCIAL1")
        end,
        text = function()
            return ccb.services.translate("Stop Extroversion"),
                ccb.services.translate("Stop yourself from enjoying the company of others by removing your extroversion.  It's not like there's anybody around anyways, right?")
        end,
    },
    {
        id = 11,
        minimum = 20,
        eligible = function(character)
            return not has_trait(character, "SOCIAL2")
                and has_trait(character, "SOCIAL1")
        end,
        text = function()
            return ccb.services.translate("Force Sociability"),
                ccb.services.translate("Force yourself to require the company of others by making yourself incredibly sociable.  Hopefully you have friends.")
        end,
    },
    {
        id = 12,
        minimum = 60,
        eligible = function(character)
            return has_trait(character, "SOCIAL2")
        end,
        text = function()
            return ccb.services.translate("Tone down Sociability"),
                ccb.services.translate("Work on yourself by stopping your need for others' presence.  A workable lifestyle turned problem which started with the death of everyone you knew and loved.")
        end,
    },
    {
        id = 13,
        minimum = 10,
        eligible = function(character)
            return not has_trait(character, "ASOCIAL1")
                and not has_trait(character, "ASOCIAL2")
                and not has_trait(character, "AMOG")
                and not has_trait(character, "DARK_TRIAD")
                and not has_trait(character, "SOCIAL1")
                and not has_trait(character, "SOCIAL2")
        end,
        text = function()
            return ccb.services.translate("Push Introversion"),
                ccb.services.translate("Make sure that you're happy alone by making yourself an introvert.  With near everyone dead, this mindset just got a lot more viable.")
        end,
    },
    {
        id = 14,
        minimum = 10,
        eligible = function(character)
            return has_trait(character, "ASOCIAL1")
        end,
        text = function()
            return ccb.services.translate("Stop Introversion"),
                ccb.services.translate("Stop yourself from enjoying being alone by removing your introversion.  You now feel positively neutral.")
        end,
    },
    {
        id = 15,
        minimum = 20,
        eligible = function(character)
            return not has_trait(character, "ASOCIAL2")
                and has_trait(character, "ASOCIAL1")
        end,
        text = function()
            return ccb.services.translate("Become a Loner"),
                ccb.services.translate("Force yourself to hate interacting with others.  What would have been a debilitating mentality in pre-Cataclysm life might actually help you.  What's the chance you'll actually have to talk to someone now?")
        end,
    },
    {
        id = 16,
        minimum = 60,
        eligible = function(character)
            return has_trait(character, "ASOCIAL2")
        end,
        text = function()
            return ccb.services.translate("Stop being a Loner"),
                ccb.services.translate("Your instinctive hatred of social interaction is probably a bit much.  For all that meeting other survivors is rare you should probably be more receptive to their presence.")
        end,
    },
    {
        id = 17,
        minimum = 70,
        eligible = function(character)
            return has_item(character, "water")
                and has_trait(character, "HATES_WATER")
        end,
        text = function()
            return ccb.services.translate("Stop Hating Water"),
                ccb.services.translate("As much as you currently hate water, you can begrudgingly accept that it would be easier if you didn't feel that way.")
        end,
    },
    {
        id = 18,
        minimum = 60,
        eligible = function(character)
            return has_item(character, "water")
                and not has_trait(character, "OUTDOORSMAN")
                and not has_trait(character, "HATES_WATER")
        end,
        text = function()
            return ccb.services.translate("Become an Outdoorsman"),
                ccb.services.translate("You now have a lot more reasons to be outside while it's raining.  Being wet doesn't really hurt you physically, and with your telepathic power you can make sure it doesn't hurt you mentally either.")
        end,
    },
    {
        id = 19,
        minimum = 160,
        eligible = function(character)
            return read(services.inventory.category_count(character, id("item_category", "guns"))) > 0
                and has_trait(character, "BRAWLER")
        end,
        text = function()
            return ccb.services.translate("Expand beyond Brawling"),
                ccb.services.translate("Replace therapy and many other normal, healthy options for getting over your inability to use guns.  At least this method is quick.")
        end,
    },
    {
        id = 20,
        minimum = 190,
        eligible = function(character)
            return has_trait(character, "WAYFARER")
        end,
        text = function()
            return ccb.services.translate("Reject Wayfaring"),
                ccb.services.translate("Drastic times require dramatic measures.  Whatever your reason for not driving, you can get over it with a small dose of major psychic surgery.")
        end,
    },
    {
        id = 21,
        minimum = 90,
        eligible = function(character)
            return has_trait(character, "NOMAD")
        end,
        text = function()
            return ccb.services.translate("Reject the Nomadic life"),
                ccb.services.translate("As much as you love travelling you can see the benefits of staying in one place.  Psychically remove your desire to keep exploring.")
        end,
    },
    {
        id = 22,
        minimum = 140,
        eligible = function(character)
            return has_trait(character, "NOMAD2")
        end,
        text = function()
            return ccb.services.translate("Overcome your Antsy-ness"),
                ccb.services.translate("As much as it hurts you, you just cannot get over the dullness of familiar places.  With a bit of psychic surgery, that dullness can get a good bit brighter.")
        end,
    },
    {
        id = 23,
        minimum = 190,
        eligible = function(character)
            return has_trait(character, "NOMAD3")
        end,
        text = function()
            return ccb.services.translate("Prevent Restlessness"),
                ccb.services.translate("Even taking the time to consider this alteration of your head is making you incredibly unhappy at your lack of travel.  You should really fix this.")
        end,
    },
    {
        id = 24,
        minimum = 80,
        eligible = function(character)
            return has_trait(character, "SQUEAMISH")
        end,
        text = function()
            return ccb.services.translate("Lose your Squeamishness"),
                ccb.services.translate("Logically speaking, your refusal to wear tainted clothing really isn't that bad.  There may be some benefit to reducing your squeamishness, though.")
        end,
    },
    {
        id = 25,
        minimum = 120,
        eligible = function(character)
            return has_item(character, "dnd_handbook")
                and not has_trait(character, "PROF_DICEMASTER")
        end,
        text = function()
            return ccb.services.translate("Pretend to be a Dungeon Master"),
                ccb.services.translate("Finding time to DM a game is probably not going to happen again.  Even so, by spending an inordinate amount of time studying a DM'ing guide while under the effect of your psychic powers you think you can get some ideas on how to do it again but quicker.")
        end,
    },
    {
        id = 26,
        minimum = 60,
        eligible = function(character)
            return not has_trait(character, "PYROMANIA")
        end,
        text = function()
            return ccb.services.translate("Embrace Pyromania"),
                ccb.services.translate("The government is gone and so are the owners of all these buildings.  And trees.  And really everything flammable.  You think you can make yourself enjoy the act a lot more than you may already do, but this may have some side effects.")
        end,
    },
    {
        id = 27,
        minimum = 60,
        eligible = function(character)
            return has_trait(character, "PYROMANIA")
        end,
        text = function()
            return ccb.services.translate("Lose your Pyromania"),
                ccb.services.translate("As fun as it is, you can begrudgingly agree that there's better things to do than setting fires.  Put a hypothetical therapist out of business with your psychic powers and fix that.")
        end,
    },
    {
        id = 28,
        minimum = 60,
        eligible = function(character)
            return read(services.skills.level(character, "social")) >= 3
                and has_trait(character, "TRUTHTELLER")
        end,
        text = function()
            return ccb.services.translate("Devalue Truth Telling"),
                ccb.services.translate("Being able to lie could be an important part of your life… if there was even anyone to lie to.  You doubt this would help you much.")
        end,
    },
    {
        id = 29,
        minimum = 70,
        eligible = function(character)
            return read(services.skills.level(character, "social")) >= 6
                and not has_trait(character, "LIAR")
                and not has_trait(character, "TRUTHTELLER")
        end,
        text = function()
            return ccb.services.translate("Become a Liar"),
                ccb.services.translate("There's still a couple of survivors around, and being good at lying to them might give you some opportunities you otherwise would lack.  It might also get you in trouble.")
        end,
    },
    {
        id = 31,
        minimum = 90,
        eligible = function(character)
            return has_trait(character, "VEGAN")
        end,
        text = function()
            return ccb.services.translate("Reject Veganism"),
                ccb.services.translate("Even the thought of doing this makes you incredibly uncomfortable, but of all the reasons to quit veganism, the complete destruction of your entire world probably qualifies.")
        end,
    },
    {
        id = 32,
        minimum = 90,
        eligible = function(character)
            return not has_trait(character, "STRICT_HUMANITARIAN")
                and not has_trait(character, "HERBIVORE")
                and not has_trait(character, "SAPIOVORE")
                and not has_trait(character, "EATDEAD")
                and not has_trait(character, "VEGETARIAN")
                and not has_trait(character, "VEGAN")
                and not has_trait(character, "CANNIBAL")
        end,
        text = function()
            return ccb.services.translate("Be a Strict Humanitarian"),
                ccb.services.translate("Logically speaking, those things that kind of look human really aren't.  It might currently feel uncomfortable, but it's hard to think of a real argument against eating them.  May as well get over your emotions.  Telepathically!")
        end,
    },
    {
        id = 33,
        minimum = 50,
        eligible = function(character)
            return has_trait(character, "STRICT_HUMANITARIAN")
        end,
        text = function()
            return ccb.services.translate("Stop being a Strict Humanitarian"),
                ccb.services.translate("You feel just fine eating those not-humans, but a tiny part of your brain tells you that this might be a slippery slope.  It might not be logical, but you can stop this immediately.")
        end,
    },
    {
        id = 34,
        minimum = 140,
        eligible = function(character)
            return not has_trait(character, "CANNIBAL")
                and has_trait(character, "STRICT_HUMANITARIAN")
                and not has_trait(character, "HERBIVORE")
                and not has_trait(character, "SAPIOVORE")
                and not has_trait(character, "EATDEAD")
                and not has_trait(character, "VEGETARIAN")
                and not has_trait(character, "VEGAN")
        end,
        text = function()
            return ccb.services.translate("Embrace Cannibalism"),
                ccb.services.translate("Completely disgusting, and potentially quite unhealthy.  However, given the times it may be your only option.  Can you force yourself to enjoy the taste of human flesh?")
        end,
    },
    {
        id = 35,
        minimum = 100,
        eligible = function(character)
            return has_trait(character, "CANNIBAL")
        end,
        text = function()
            return ccb.services.translate("Reject Cannibalism"),
                ccb.services.translate("As tasty as humans are, it's gotten you some negative looks from other survivors when you accidently referred to your 'taste.'  Are you willing to change yourself just to meet their expectations?")
        end,
    },
    {
        id = 36,
        minimum = 70,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_morale")) >= 10
                and has_trait(character, "MOODSWINGS")
        end,
        text = function()
            return ccb.services.translate("Stop your Mood Swings"),
                ccb.services.translate("Help balance your mood by fixing the centers of your brain that are responsible for regulating it.  Be a little more at peace with yourself.")
        end,
    },
    {
        id = 37,
        minimum = 70,
        eligible = function(character)
            return not has_trait(character, "SAVANT")
        end,
        text = function()
            return ccb.services.translate("Become a Savant"),
                ccb.services.translate("You've heard stories of people who heavily specialize in certain skills at the expense of all others.  With a bit of work, you think you can replicate this in yourself.")
        end,
    },
    {
        id = 38,
        minimum = 70,
        eligible = function(character)
            return has_trait(character, "SAVANT")
        end,
        text = function()
            return ccb.services.translate("Stop being a Savant"),
                ccb.services.translate("Can you really care about all those other things that don't matter or even make that much sense.  With a bit of telepathic brain surgery you can!")
        end,
    },
    {
        id = 39,
        minimum = 100,
        eligible = function(character)
            return has_trait(character, "HOARDER")
        end,
        text = function()
            return ccb.services.translate("Stop Hoarding"),
                ccb.services.translate("You can begrudgingly admit that an old candy wrapper might not be the most useful thing in the world.  Help yourself physically drop it by mentally dropping your hording sensibilities.")
        end,
    },
    {
        id = 40,
        minimum = 160,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_shield")) >= 12
                and has_trait(character, "SCHIZOPHRENIC")
        end,
        text = function()
            return ccb.services.translate("Fix Kaluptic Psychosis"),
                ccb.services.translate("At least one of the voices recommended you do this, and they seemed trustworthy.")
        end,
    },
    {
        id = 41,
        minimum = 120,
        eligible = function(character)
            return read(services.spells.effective_level(character, "clair_speed_reading")) >= 6
                and has_trait(character, "SLOWREADER")
        end,
        text = function()
            return ccb.services.translate("Improve your Slow Reading"),
                ccb.services.translate("It takes you a while to process information, far longer than the average person.  You think you've identified the locations of your brain responsible for this, and with a bit of telepathic power you can fix that.")
        end,
    },
    {
        id = 42,
        minimum = 160,
        eligible = function(character)
            return read(services.spells.effective_level(character, "clair_speed_reading")) >= 12
                and not has_trait(character, "FASTREADER")
                and not has_trait(character, "SLOWREADER")
                and not has_trait(character, "ILLITERATE")
        end,
        text = function()
            return ccb.services.translate("Speed up your Reading"),
                ccb.services.translate("With some deep analysis of how your brain works while reading with your Speed Reading power, you think you can replicate some of the efficiency caused by it.  This will allow you to permanently read quicker.")
        end,
    },
    {
        id = 43,
        minimum = 110,
        eligible = function(character)
            return has_trait(character, "ADDICTIVE")
        end,
        text = function()
            return ccb.services.translate("Remove your Addictiveness"),
                ccb.services.translate("Help yourself stop getting addicted to things by analyzing the relevant pathways and closing them up.  You won't be extra addictive anymore, but you won't necessarily have any special resistance either.")
        end,
    },
    {
        id = 44,
        minimum = 140,
        eligible = function(character)
            return not has_trait(character, "NONADDICTIVE")
                and not has_trait(character, "ADDICTIVE")
        end,
        text = function()
            return ccb.services.translate("Prevent Addiction"),
                ccb.services.translate("Increase your inhibitions with a bit of psychic surgery.  Even beyond the normal reasons, a good supply of alcohol and really any other addictive substance is hard to come by nowadays.  Make sure you don't need them any more than usual.")
        end,
    },
    {
        id = 45,
        minimum = 110,
        eligible = function(character)
            return has_trait(character, "FORGETFUL")
        end,
        text = function()
            return ccb.services.translate("Stop being Forgetful"),
                ccb.services.translate("Fix your damaged memory regions to allow you to remember all of that important stuff better.")
        end,
    },
    {
        id = 46,
        minimum = 160,
        eligible = function(character)
            return not has_trait(character, "GOODMEMORY")
                and not has_trait(character, "FORGETFUL")
        end,
        text = function()
            return ccb.services.translate("Get a Good Memory"),
                ccb.services.translate("Improve the memory regions within your brain, allowing you to recall information far more easily.  Help make sure you don't forget things ever again.")
        end,
    },
    {
        id = 47,
        minimum = 70,
        eligible = function(character)
            return not has_trait(character, "PROJUNK")
                and not has_trait(character, "ANTIJUNK")
                and not has_trait(character, "PROJUNK2")
        end,
        text = function()
            return ccb.services.translate("Build a Sweet Tooth"),
                ccb.services.translate("Sugar already tastes pretty good.  You can increase those feelings and make it taste even better.")
        end,
    },
    {
        id = 48,
        minimum = 30,
        eligible = function(character)
            return has_trait(character, "PROJUNK")
        end,
        text = function()
            return ccb.services.translate("Break your Sweet Tooth"),
                ccb.services.translate("Sugar may taste amazing, but eating so much of it probably isn't healthy.  Enforce your new diet by making it taste worse.")
        end,
    },
    {
        id = 49,
        minimum = 70,
        eligible = function(character)
            return has_trait(character, "HATES_BOOKS")
        end,
        text = function()
            return ccb.services.translate("Stop Hating Books"),
                ccb.services.translate("As annoying as books may be, you think that it would be useful to not be so bored while reading them.  Fix that with psychic power.")
        end,
    },
    {
        id = 50,
        minimum = 100,
        eligible = function(character)
            return not has_trait(character, "LOVES_BOOKS")
                and not has_trait(character, "HATES_BOOKS")
                and not has_trait(character, "ILLITERATE")
        end,
        text = function()
            return ccb.services.translate("Start Loving Books"),
                ccb.services.translate("Reading has been one of the most important skills that has let humanity rise as far as it once did.  Make sure you spend more time doing it by making sure that you love it.")
        end,
    },
    {
        id = 51,
        minimum = 110,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_concentration")) >= 6
                and has_trait(character, "SLOWLEARNER")
        end,
        text = function()
            return ccb.services.translate("Fix your Slow Learning"),
                ccb.services.translate("Improve the areas relegated to learning new information in your brain that you've noticed are operating a little poorly.  This has no downsides.")
        end,
    },
    {
        id = 52,
        minimum = 180,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_concentration")) >= 16
                and not has_trait(character, "FASTLEARNER")
                and not has_trait(character, "SLOWLEARNER")
                and not has_trait(character, "CEPH_MIND")
        end,
        text = function()
            return ccb.services.translate("Improve your Learning"),
                ccb.services.translate("Take some notes on how you brain functions while you're in concentration trances and permanently replicate a small part of that efficiency in your head to help you learn everything quicker.")
        end,
    },
    {
        id = 53,
        minimum = 80,
        eligible = function(character)
            return has_trait(character, "DISORGANIZED")
        end,
        text = function()
            return ccb.services.translate("Stop being Disorganized"),
                ccb.services.translate("Improve your 3D awareness and planning by adjusting your brain.  There's definitely ways of packing that you're currently missing.")
        end,
    },
    {
        id = 54,
        minimum = 120,
        eligible = function(character)
            return not has_trait(character, "PACKMULE")
                and not has_trait(character, "DISORGANIZED")
        end,
        text = function()
            return ccb.services.translate("Become a Packmule"),
                ccb.services.translate("Dramatically improve your 3D awareness by making several efficiency alterations to your brain.  Seeing how things fit together will get a lot easier.")
        end,
    },
    {
        id = 55,
        minimum = 70,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_morale")) >= 6
                and has_trait(character, "BADTEMPER")
        end,
        text = function()
            return ccb.services.translate("Improve your Temper"),
                ccb.services.translate("You already have enough to be angry about right now, you don't need your brain naturally being pissed off as well.  Instead of pills or therapy, use your telepathic powers!")
        end,
    },
    {
        id = 56,
        minimum = 90,
        eligible = function(character)
            return read(services.spells.effective_level(character, "telepathic_morale")) >= 12
                and not has_trait(character, "OPTIMISTIC")
                and not has_trait(character, "BADTEMPER")
                and not has_trait(character, "SEASONAL_AFFECTIVE")
        end,
        text = function()
            return ccb.services.translate("Be Optimistic!"),
                ccb.services.translate("With a couple of notes from your Mood Stabilization power, you can permanently alter your brain to make you happier.")
        end,
    },
    {
        id = 57,
        minimum = 110,
        eligible = function(character)
            return has_trait(character, "SEASONAL_AFFECTIVE")
        end,
        text = function()
            return ccb.services.translate("Cure your Seasonal Affective Disorder"),
                ccb.services.translate("Winter already has some real issues for your survival.  There's no need for you to be depressed on top of it.  Fix that up with some intricate mental surgery.")
        end,
    },
    {
        id = 58,
        minimum = 90,
        eligible = function(character)
            return read(services.spells.effective_level(character, "clair_see_map")) >= 6
                and has_trait(character, "UNOBSERVANT")
        end,
        text = function()
            return ccb.services.translate("Cure Topographagnosia"),
                ccb.services.translate("Fix your inability to remember locations and direct yourself by connecting locations of your brain that were erroneously disconnected.")
        end,
    },
    {
        id = 59,
        minimum = 110,
        eligible = function(character)
            return read(services.spells.effective_level(character, "clair_see_map")) >= 12
                and not has_trait(character, "EAGLEEYED")
                and not has_trait(character, "UNOBSERVANT")
        end,
        text = function()
            return ccb.services.translate("Become a Scout"),
                ccb.services.translate("With a deep analysis of how you remember locations you think you can improve your ability to do so.")
        end,
    },
    {
        id = 60,
        minimum = 100,
        eligible = function(character)
            return not has_trait(character, "MASOCHIST")
                and not has_trait(character, "MASOCHIST_MED")
                and not has_trait(character, "CENOBITE")
        end,
        text = function()
            return ccb.services.translate("Become a Masochist"),
                ccb.services.translate("Rewire your way of feeling pain into something slightly positive.  It will still be incredibly distracting and debilitating, but at least you'll enjoy it.  Hopefully not enough to intentionally seek it out.")
        end,
    },
    {
        id = 61,
        minimum = 60,
        eligible = function(character)
            return has_trait(character, "MASOCHIST")
        end,
        text = function()
            return ccb.services.translate("Stop being a Masochist"),
                ccb.services.translate("Your enjoyment of pain has lead to too many bad decisions.  Get rid of it before a zombie gets rid of you.")
        end,
    },
    {
        id = 62,
        minimum = 90,
        eligible = function(character)
            return not has_trait(character, "SPIRITUAL")
        end,
        text = function()
            return ccb.services.translate("Embrace your Spirituality"),
                ccb.services.translate("The dream of a person struggling with their faith.  Force yourself to see spirituality in everything by mentally adjusting your brain to mirror somebody else's faith.  It may not be the typical way of finding spirituality, but you reckon the end result will be similar.")
        end,
    },
    {
        id = 63,
        minimum = 50,
        eligible = function(character)
            return has_trait(character, "SPIRITUAL")
        end,
        text = function()
            return ccb.services.translate("Reject your Spirituality"),
                ccb.services.translate("Even your immense spirituality cannot compete with the horrors around you.  Intentionally lose a major element of who you are so you don't have to deal with it.")
        end,
    },
    {
        id = 64,
        minimum = 70,
        eligible = function(character)
            return has_trait(character, "TABLEMANNERS")
        end,
        text = function()
            return ccb.services.translate("Neglect your Table Manners"),
                ccb.services.translate("Use your psychic powers to forget all of your memories mandating you eat with good manners; hopefully, you won't lose anything else important.")
        end,
    },
    {
        id = 65,
        minimum = 110,
        eligible = function(character)
            return read(services.spells.effective_level(character, "clair_see_auras")) >= 6
                and has_trait(character, "INATTENTIVE")
        end,
        text = function()
            return ccb.services.translate("Fix your Inattentiveness"),
                ccb.services.translate("Fix up the regions of your brain responsible for predicting the actions of others.  A surprisingly comprehensive surgery.")
        end,
    },
}

local function replace_trait(character, trait)
    read(services.mutations.replace(character, id("mutation", trait)))
end

local function erase_trait(character, trait)
    read(services.mutations.erase(character, id("mutation", trait)))
end

-- Slot 30 has no menu entry, but is still a defined completion outcome.
local adjustment_outcomes = {
    [1] = function(character)
        replace_trait(character, "PSYCHOPATH")
        message(character, ccb.services.translate("It's a good thing that all of those people don't really matter."), "neutral")
    end,
    [2] = function(character)
        erase_trait(character, "PSYCHOPATH")
        message(character, ccb.services.translate("Looking back at your past actions, you really hope you didn't do anything that you will now regret."), "neutral")
    end,
    [3] = function(character)
        erase_trait(character, "PACIFIST")
        message(character, ccb.services.translate("Your past desires were really holding you back.  Now you're more at ease with what you must do."), "neutral")
    end,
    [4] = function(character)
        replace_trait(character, "NUMB")
        message(character, ccb.services.translate("Nothing seems to matter anymore."), "neutral")
    end,
    [5] = function(character)
        erase_trait(character, "NUMB")
        message(character, ccb.services.translate("Compared to your prior state, you are suddenly overwhelmed with emotion!"), "neutral")
    end,
    [6] = function(character)
        erase_trait(character, "NYCTOPHOBIA")
        message(character, ccb.services.translate("How could you ever have let just a little bit of darkness affect you so much?"), "good")
    end,
    [7] = function(character)
        erase_trait(character, "VANITY")
        message(character, ccb.services.translate("How could you have ever thought that way?  Of all the silly things to feel, especially in times like these"), "good")
    end,
    [8] = function(character)
        erase_trait(character, "PICKYEATER")
        message(character, ccb.services.translate("Your mind and stomach simultaneously grown in relief at your food palette expanding."), "good")
    end,
    [9] = function(character)
        replace_trait(character, "SOCIAL1")
        message(character, ccb.services.translate("Since there's so few people left alive, you're at least happy that you generally enjoy their company."), "good")
    end,
    [10] = function(character)
        erase_trait(character, "SOCIAL1")
        message(character, ccb.services.translate("Getting your energy from interacting with others was not the worst idea in the world, but also not the best."), "neutral")
    end,
    [11] = function(character)
        replace_trait(character, "SOCIAL2")
        erase_trait(character, "SOCIAL1")
        message(character, ccb.services.translate("You absolutely love and absolutely need to be able to talk to people.  You cannot believe that the Cataclysm is getting in the way of that!"), "neutral")
    end,
    [12] = function(character)
        erase_trait(character, "SOCIAL2")
        replace_trait(character, "SOCIAL1")
        message(character, ccb.services.translate("As much as you enjoy a good conversation, you've gotten over the reality that people just aren't around anymore.  You'll have to live with that."), "good")
    end,
    [13] = function(character)
        replace_trait(character, "ASOCIAL1")
        message(character, ccb.services.translate("Since there's so few people left alive, you are no longer forced to talk with anyone."), "good")
    end,
    [14] = function(character)
        erase_trait(character, "ASOCIAL1")
        message(character, ccb.services.translate("There's definitely someone out there right?  It's a shame you cannot enjoy your solitude anymore."), "neutral")
    end,
    [15] = function(character)
        replace_trait(character, "ASOCIAL2")
        erase_trait(character, "ASOCIAL1")
        message(character, ccb.services.translate("You absolutely detest having to interact with anyone else!  It's a good thing you'll never have to again!"), "neutral")
    end,
    [16] = function(character)
        erase_trait(character, "ASOCIAL2")
        replace_trait(character, "ASOCIAL1")
        message(character, ccb.services.translate("Your prior level of hatred of social interaction was a bit much.  You no longer enjoy the solitude quite as much but you definitely don't have a problem with other people anymore."), "good")
    end,
    [17] = function(character)
        erase_trait(character, "HATES_WATER")
        message(character, ccb.services.translate("Earlier you were over-reacting a bit.  You cannot really connect with why water was just that bad."), "good")
    end,
    [18] = function(character)
        replace_trait(character, "OUTDOORSMAN")
        message(character, ccb.services.translate("Being wet is just a natural part of living.  Especially now."), "good")
    end,
    [19] = function(character)
        erase_trait(character, "BRAWLER")
        message(character, ccb.services.translate("The thought of getting shot may still scare you, but the thought of not being able to fight back is on another level.  How did you ever let yourself not use these tools?"), "good")
    end,
    [20] = function(character)
        erase_trait(character, "WAYFARER")
        message(character, ccb.services.translate("No buses, no trains, no planes.  You've been met with a simultaneous need to travel distances and a vast reduction in your tools to do so.  Forcing yourself to be able to drive cars was a good idea."), "good")
    end,
    [21] = function(character)
        erase_trait(character, "NOMAD")
        message(character, ccb.services.translate("You cannot wait to finally settle down."), "good")
    end,
    [22] = function(character)
        erase_trait(character, "NOMAD2")
        replace_trait(character, "NOMAD")
        message(character, ccb.services.translate("The thought of that far-away place seems just a little less necessary.  You still want to go there though."), "good")
    end,
    [23] = function(character)
        erase_trait(character, "NOMAD3")
        replace_trait(character, "NOMAD2")
        message(character, ccb.services.translate("Perhaps you can wait a couple of minutes before leaving."), "good")
    end,
    [24] = function(character)
        erase_trait(character, "SQUEAMISH")
        message(character, ccb.services.translate("Tainted clothes are still gross, and with other options you'll obviously never use them.  There's probably some situation out there though that could make it worth it."), "good")
    end,
    [25] = function(character)
        replace_trait(character, "PROF_DICEMASTER")
        message(character, ccb.services.translate("You know, maybe you can find some people to DM with.  If not though, you think that there's probably some side benefits to adjusting your head this way."), "good")
    end,
    [26] = function(character)
        replace_trait(character, "PYROMANIA")
        message(character, ccb.services.translate("All that stuff is looking awfully flammable.  Time to get a lighter.  If you have mental powers now, perhaps there's something that will let you cause fires with your mind as well?"), "neutral")
    end,
    [27] = function(character)
        erase_trait(character, "PYROMANIA")
        message(character, ccb.services.translate("Nothing's preventing you from starting fires, but nothing's forcing you to do so either.  Flame just seems less attractive."), "neutral")
    end,
    [28] = function(character)
        erase_trait(character, "TRUTHTELLER")
        message(character, ccb.services.translate("You can now lie to your heart's content!  Mostly to a mirror."), "good")
    end,
    [29] = function(character)
        replace_trait(character, "LIAR")
        message(character, ccb.services.translate("You can instinctively tell ways to mislead others.  Their reactions are just so predictable."), "good")
    end,
    [30] = function(character)
        erase_trait(character, "LIAR")
        message(character, ccb.services.translate("Its hard to tell yourself, but you feel that your face got a lot more tells."), "bad")
    end,
    [31] = function(character)
        erase_trait(character, "VEGAN")
        message(character, ccb.services.translate("You could use a hamburger."), "good")
    end,
    [32] = function(character)
        replace_trait(character, "STRICT_HUMANITARIAN")
        message(character, ccb.services.translate("Your palette just got a bit bigger.  Admittedly, how often do you actual encounter these creatures?"), "good")
    end,
    [33] = function(character)
        erase_trait(character, "STRICT_HUMANITARIAN")
        message(character, ccb.services.translate("How were you able to eat those humany things so easily?"), "bad")
    end,
    [34] = function(character)
        replace_trait(character, "CANNIBAL")
        message(character, ccb.services.translate("Your fellow survivors just got a lot more attractive.  To your taste buds."), "good")
    end,
    [35] = function(character)
        erase_trait(character, "CANNIBAL")
        message(character, ccb.services.translate("What have you done?"), "bad")
    end,
    [36] = function(character)
        erase_trait(character, "MOODSWINGS")
        message(character, ccb.services.translate("You cannot wait to start living life without all those distracting and conflicting emotions."), "good")
    end,
    [37] = function(character)
        replace_trait(character, "SAVANT")
        message(character, ccb.services.translate("It's hard to even understand how you used to think.  There's only one thing that makes sense now."), "neutral")
    end,
    [38] = function(character)
        erase_trait(character, "SAVANT")
        message(character, ccb.services.translate("All that information that you didn't used to be able to really handle just got a lot easier to process.  Unfortunately, your prior favorite subject just got a lot more harder to process."), "neutral")
    end,
    [39] = function(character)
        erase_trait(character, "HOARDER")
        message(character, ccb.services.translate("You almost sigh in relief at all the stuff you can get rid of."), "good")
    end,
    [40] = function(character)
        erase_trait(character, "SCHIZOPHRENIC")
        message(character, ccb.services.translate("It's been so long since you've been alone in your head."), "good")
    end,
    [41] = function(character)
        erase_trait(character, "SLOWREADER")
        message(character, ccb.services.translate("Compared to before, you think you can blow through a textbook if you wanted."), "good")
    end,
    [42] = function(character)
        replace_trait(character, "FASTREADER")
        message(character, ccb.services.translate("No amount of reading assignments will ever get you down."), "good")
    end,
    [43] = function(character)
        erase_trait(character, "ADDICTIVE")
        message(character, ccb.services.translate("Nothing immediately changes, but you do feel like you're less likely to become obsessed with things now."), "good")
    end,
    [44] = function(character)
        replace_trait(character, "NONADDICTIVE")
        message(character, ccb.services.translate("You suddenly feel that you're less likely to become unhealthily obsessed with things."), "good")
    end,
    [45] = function(character)
        erase_trait(character, "FORGETFUL")
        message(character, ccb.services.translate("Everything in the past seems just a little clearer."), "good")
    end,
    [46] = function(character)
        replace_trait(character, "GOODMEMORY")
        message(character, ccb.services.translate("The past, your skills, really just everything seems so much clearer."), "good")
    end,
    [47] = function(character)
        replace_trait(character, "PROJUNK")
        message(character, ccb.services.translate("You'd love to have a snicker."), "good")
    end,
    [48] = function(character)
        erase_trait(character, "PROJUNK")
        message(character, ccb.services.translate("Candy.  Meh."), "bad")
    end,
    [49] = function(character)
        erase_trait(character, "HATES_BOOKS")
        message(character, ccb.services.translate("A survival guide may be useful information now.  You could see yourself giving it a look."), "good")
    end,
    [50] = function(character)
        replace_trait(character, "LOVES_BOOKS")
        message(character, ccb.services.translate("You cannot wait to curl up with a good book for a couple of hours."), "good")
    end,
    [51] = function(character)
        erase_trait(character, "SLOWLEARNER")
        message(character, ccb.services.translate("New ideas seem to piece together normally."), "good")
    end,
    [52] = function(character)
        replace_trait(character, "FASTLEARNER")
        message(character, ccb.services.translate("You can piece together new concepts even now."), "good")
    end,
    [53] = function(character)
        erase_trait(character, "DISORGANIZED")
        message(character, ccb.services.translate("It just became quicker to sort out your backpack."), "good")
    end,
    [54] = function(character)
        replace_trait(character, "PACKMULE")
        message(character, ccb.services.translate("Time to start packing!"), "good")
    end,
    [55] = function(character)
        erase_trait(character, "BADTEMPER")
        message(character, ccb.services.translate("The haze of unhappiness fades.  Now you can be down about all the other things in your hopefully not ending soon life!"), "good")
    end,
    [56] = function(character)
        replace_trait(character, "OPTIMISTIC")
        message(character, ccb.services.translate("You feel happy."), "good")
    end,
    [57] = function(character)
        erase_trait(character, "SEASONAL_AFFECTIVE")
        message(character, ccb.services.translate("General darkness and dreariness might not be your favorite thing in the world, but you'll live."), "good")
    end,
    [58] = function(character)
        erase_trait(character, "UNOBSERVANT")
        message(character, ccb.services.translate("You suddenly have a much better idea of the area around you!"), "good")
    end,
    [59] = function(character)
        replace_trait(character, "EAGLEEYED")
        message(character, ccb.services.translate("You know exactly where you are."), "good")
    end,
    [60] = function(character)
        replace_trait(character, "MASOCHIST")
        message(character, ccb.services.translate("Even pinching your skin feels better than it used to."), "good")
    end,
    [61] = function(character)
        erase_trait(character, "MASOCHIST")
        message(character, ccb.services.translate("The aches and pains of combat suddenly seem far less appealing."), "bad")
    end,
    [62] = function(character)
        replace_trait(character, "SPIRITUAL")
        message(character, ccb.services.translate("You can now see the things unexplainable by science.  And right now, that's your entire life."), "good")
    end,
    [63] = function(character)
        erase_trait(character, "SPIRITUAL")
        message(character, ccb.services.translate("Your prior source of comfort with your life is now gone."), "bad")
    end,
    [64] = function(character)
        erase_trait(character, "TABLEMANNERS")
        message(character, ccb.services.translate("Do you really need a table to eat a sandwich?"), "good")
    end,
    [65] = function(character)
        erase_trait(character, "INATTENTIVE")
        message(character, ccb.services.translate("You can make some normal inferences such as a 'smile' likely indicating that somebody is friendly."), "good")
    end,
}

local side_effects = {
    [1] = function(character)
        replace_trait(character, "PSYCHOPATH")
        erase_trait(character, "PACIFIST")
        erase_trait(character, "NUMB")
        message(character, ccb.services.translate("You suddenly feel much less empathetic towards others."), "neutral")
    end,
    [2] = function(character)
        replace_trait(character, "PACIFIST")
        erase_trait(character, "PSYCHOPATH")
        erase_trait(character, "NUMB")
        message(character, ccb.services.translate("You've realized that you're far more empathetic to others.  Even those who may not deserve it."), "bad")
    end,
    [3] = function(character)
        replace_trait(character, "NYCTOPHOBIA")
        message(character, ccb.services.translate("There's no way you could possibly even contemplate even moving an inch into the darkness because that's so so so so so so so incredibly uncomfortably terrifyingly horrible.  Please no."), "bad")
    end,
    [4] = function(character)
        replace_trait(character, "VANITY")
        message(character, ccb.services.translate("It's so much easier to recognize how you are just that much more attractive than everyone else.  You need to make sure they know it."), "bad")
    end,
    [5] = function(character)
        replace_trait(character, "PICKYEATER")
        message(character, ccb.services.translate("That stuff you used to eat is completely disgusting.  Going hungry is nowhere near as painful as having to suffer even the slightest taste of that slop!"), "bad")
    end,
    [6] = function(character)
        replace_trait(character, "SOCIAL2")
        erase_trait(character, "SOCIAL1")
        erase_trait(character, "ASOCIAL1")
        erase_trait(character, "ASOCIAL2")
        message(character, ccb.services.translate("You feel an enormous need to interact with others!"), "bad")
    end,
    [7] = function(character)
        replace_trait(character, "ASOCIAL2")
        erase_trait(character, "SOCIAL2")
        erase_trait(character, "ASOCIAL1")
        erase_trait(character, "SOCIAL1")
        message(character, ccb.services.translate("You feel an incredible need to avoid others!"), "bad")
    end,
    [8] = function(character)
        replace_trait(character, "BRAWLER")
        message(character, ccb.services.translate("Guns are just too scary.  The loud bang, the thought of them being used on you… despite their utility, there's no way you could get close to one of them."), "bad")
    end,
    [9] = function(character)
        replace_trait(character, "WAYFARER")
        message(character, ccb.services.translate("There's so much that could go wrong if you ever got behind a wheel.  Cars used to be one of the largest causes of death before the Cataclysm, and there's definitely no need to decrease your odds by getting in one now!"), "bad")
    end,
    [10] = function(character)
        replace_trait(character, "NOMAD3")
        erase_trait(character, "NOMAD2")
        erase_trait(character, "NOMAD")
        message(character, ccb.services.translate("Keep moving keep moving keep moving keep moving keep moving keep moving!"), "bad")
    end,
    [11] = function(character)
        replace_trait(character, "SQUEAMISH")
        message(character, ccb.services.translate("The blood and cuts that come alongside combat is bad enough.  Putting such disgusting clothes on your skin is absolutely not an option."), "bad")
    end,
    [12] = function(character)
        replace_trait(character, "PYROMANIA")
        message(character, ccb.services.translate("All that stuff is looking awfully flammable.  Time to get a lighter.  If you have mental powers now, perhaps there's something that will let you cause fires with your mind as well?"), "bad")
    end,
    [13] = function(character)
        replace_trait(character, "TRUTHTELLER")
        erase_trait(character, "LIAR")
        message(character, ccb.services.translate("Thinking about lying to someone just immediately causes you to blush and stutter.  Best not even bother."), "bad")
    end,
    [14] = function(character)
        replace_trait(character, "VEGAN")
        erase_trait(character, "STRICT_HUMANITARIAN")
        erase_trait(character, "CANNIBAL")
        message(character, ccb.services.translate("You refuse to even tangentially benefit from the suffering of all those innocent animals!"), "bad")
    end,
    [15] = function(character)
        replace_trait(character, "STRICT_HUMANITARIAN")
        erase_trait(character, "VEGAN")
        erase_trait(character, "CANNIBAL")
        message(character, ccb.services.translate("Your palette just got a bit bigger.  Admittedly, how often do you actual encounter these creatures?"), "good")
    end,
    [16] = function(character)
        replace_trait(character, "CANNIBAL")
        erase_trait(character, "VEGAN")
        erase_trait(character, "STRICT_HUMANITARIAN")
        message(character, ccb.services.translate("Your fellow survivors just got a lot more attractive.  To your taste buds."), "good")
    end,
    [17] = function(character)
        replace_trait(character, "MOODSWINGS")
        message(character, ccb.services.translate("You feel that your prior mental balance and peace has ended."), "bad")
    end,
    [18] = function(character)
        replace_trait(character, "SAVANT")
        message(character, ccb.services.translate("It's hard to even understand how you used to think.  There's only one thing that makes sense now."), "neutral")
    end,
    [19] = function(character)
        replace_trait(character, "HOARDER")
        message(character, ccb.services.translate("You NEED to make sure that nothing gets left behind.  Every single thing is important."), "bad")
    end,
    [20] = function(character)
        replace_trait(character, "SCHIZOPHRENIC")
        message(character, ccb.services.translate("It's hard to hear yourself think over all of the voices in your head!"), "bad")
    end,
    [21] = function(character)
        replace_trait(character, "SLOWREADER")
        erase_trait(character, "FASTREADER")
        message(character, ccb.services.translate("The words on the page seem more daunting."), "bad")
    end,
    [22] = function(character)
        replace_trait(character, "ADDICTIVE")
        erase_trait(character, "NONADDICTIVE")
        message(character, ccb.services.translate("Right now, you don't feel any change.  Something tells you that touching drugs or alcohol may have just become a worse idea, however."), "bad")
    end,
    [23] = function(character)
        replace_trait(character, "FORGETFUL")
        erase_trait(character, "GOODMEMORY")
        message(character, ccb.services.translate("Your memory seems much worse than before."), "bad")
    end,
    [24] = function(character)
        replace_trait(character, "HATES_BOOKS")
        erase_trait(character, "LOVES_BOOKS")
        message(character, ccb.services.translate("Your desire to read seems lesser."), "bad")
    end,
    [25] = function(character)
        replace_trait(character, "SLOWLEARNER")
        erase_trait(character, "FASTLEARNER")
        message(character, ccb.services.translate("Thinking of new ideas just got a good bit harder."), "bad")
    end,
    [26] = function(character)
        replace_trait(character, "DISORGANIZED")
        erase_trait(character, "PACKMULE")
        message(character, ccb.services.translate("You think it's going to take longer to sort things now."), "bad")
    end,
    [27] = function(character)
        replace_trait(character, "BADTEMPER")
        erase_trait(character, "OPTIMISTIC")
        erase_trait(character, "SEASONAL_AFFECTIVE")
        message(character, ccb.services.translate("You feel unhappy."), "bad")
    end,
    [28] = function(character)
        replace_trait(character, "SEASONAL_AFFECTIVE")
        erase_trait(character, "OPTIMISTIC")
        erase_trait(character, "BADTEMPER")
        message(character, ccb.services.translate("You really hope things remain bright and sunny."), "bad")
    end,
    [29] = function(character)
        replace_trait(character, "UNOBSERVANT")
        erase_trait(character, "EAGLEEYED")
        message(character, ccb.services.translate("Where are you?"), "bad")
    end,
    [30] = function(character)
        replace_trait(character, "MASOCHIST")
        message(character, ccb.services.translate("Even pinching your skin feels better than it used to."), "good")
    end,
    [31] = function(character)
        replace_trait(character, "TABLEMANNERS")
        message(character, ccb.services.translate("You better make sure you have a fork."), "bad")
    end,
    [32] = function(character)
        replace_trait(character, "INATTENTIVE")
        message(character, ccb.services.translate("The emotions on people's faces and movements of animals mean nothing to you.  Not in an emotional sense, but because you really don't understand them anymore."), "bad")
    end,
}

local function apply_side_effects(character)
    while true do
        local chance = math.max(200 - telepathy_level(character), 20)
        -- With no effective telepathy left, every roll would trigger another side effect.
        if chance == 200 and services.interaction.confirm(ccb.services.translate(
            "Without any telepathic power, the PATIENT MOSAIC side effects will keep repeating.  Stop the process?"
        )) then
            return
        end
        if not services.random.native_probability(chance, 200) then
            return
        end
        -- The old draw was floating-point and the effect used the last matching threshold.
        local roll = services.random.native_float(1, 32)
        read(services.variables.set(character, pending_adjustment, roll, { include_before = false }))
        side_effects[math.floor(roll)](character)
    end
end

local function start_adjustment(character)
    local level = telepathy_level(character)
    if level <= 100 then
        message(character, ccb.services.translate("You feel that you need to be an incredibly powerful telepath to make this work"))
        return
    end
    local choices = {}
    for _, adjustment in ipairs(adjustments) do
        if level >= adjustment.minimum and adjustment.eligible(character) then
            local label, description = adjustment.text()
            choices[#choices + 1] = { id = tostring(adjustment.id), label = label, description = description }
        end
    end
    choices[#choices + 1] = {
        id = "cancel",
        label = ccb.services.translate("cancel"),
        description = ccb.services.translate("Do something else"),
    }
    local choice = services.interaction.choose(choices, { allow_cancel = true, show_descriptions = true })
    local selected = tonumber(choice.id)
    if not selected then
        return
    end

    message(character, ccb.services.translate("You begin rewiring your brain to change your way of looking at the world."))
    local seconds = 28800 - math.min(level * 135, 27000)
    local duration = services.time.duration(seconds, "second")
    local assigned = services.activities.assign_timed(character, id("activity", activity_id), duration)
    if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
        read(assigned)
    end
    read(services.variables.set(character, pending_adjustment, selected, { include_before = false }))
end

ccb.runtime.handler("select_mental_engineering", function(craft)
    for _ = 1, craft.batch do
        start_adjustment(craft.character)
    end
end, 1)

ccb.runtime.handler("finish_mental_engineering", function(activity)
    local character = activity.character
    local pending = read(services.variables.get_number(character, pending_adjustment))
    if not pending.exists then
        return
    end
    -- Values from an in-progress legacy activity use the same numbered outcomes.
    if pending.value >= 1 then
        local index = math.min(math.floor(pending.value), #adjustment_outcomes)
        adjustment_outcomes[index](character)
    end
    apply_side_effects(character)
end, 1)

content.add(content.ActivityType {
    id = activity_id,
    verb = ccb.content.text("adjusting mentality"),
    rooted = true,
    based_on = "time",
    activity_level = 2,
    can_resume = false,
}:on_finish("finish_mental_engineering"))

content.add(content.Recipe {
    id = "recipe_mental_engineering",
    name = ccb.content.text("enact the PATIENT MOSAIC process"),
    description = ccb.content.text("With the help of a telepathic focusing tool and your (hopefully) extensive telepathic powers, you can sink into a deep trance where you can only sense yourself, allowing you to permanently adjust your mental state and view of the outside world.  Will the end result still be you?"),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_RITUALS",
    skill = "metaphysics",
    difficulty = 9,
    duration_moves = 0,
    activity_level = 2,
    flags = { "SECRET", "BLIND_EASY" },
    scripted_output = true,
}:book("phavian_psionic_telepathic_mental_engineering_book", 8)
    :tool("telepathic_focusing_tool", 1)
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :on_complete("select_mental_engineering"))
