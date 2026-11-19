local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local lessons = {
    tr_tutorial_1 = {
        text = function()
            return services.translate("You can also use the mouse to see things around you.  The <color_light_cyan>Mouse view</color> window will appear on the sidebar, and you'll be able to get information on the terrain, monsters, and items in the world around you.  Alternatively, you can press <keybind:look> to open the <color_light_cyan>Look Around</color> window.")
        end,
    },
    tr_tutorial_2 = {
        text = function()
            return services.translate("Most of the time your character will be walking when you move.  But sometimes it's useful to change your movement mode to something else.\n\nThere are four movement modes:\n<color_light_cyan>Walking</color>: default mode, average movement speed, stamina draining speed, and noise\n<color_light_cyan>Running</color>: <color_light_green>move much faster</color>, but will <color_light_red>drain your stamina quickly</color>\n<color_light_cyan>Crouching</color>: will make your character <color_light_green>less visible to monsters</color> by allowing you to hide behind some obstacles, <color_light_red>decreased movement speed</color> and <color_light_green>noise</color>\n<color_light_cyan>Prone</color>: <color_light_green>even less visibility</color> to monsters, <color_light_red>even less movement speed</color> and <color_light_green>noise</color>\n\nPressing <keybind:open_movement> will open the <color_light_cyan>Movement Mode</color> menu, which allows you to switch the mode at any time.  There are extra keybindings that can be set to switch to each mode individually for convenience.\n\nTo continue the tutorial, please move to the end of the corridor.")
        end,
    },
    tr_tutorial_3 = {
        seen = "seen_LESSON_MONSTER_SIGHTED",
        text = function()
            return services.translate("There is a <color_light_cyan>dummy</color> standing before you.  Attack it by moving into it.\nYou'll receive a message warning you that safe mode is on.  Safe mode prevents certain actions while hostiles are visible and within a certain configurable range as well as preventing you accidently attacking non-hostile creatures.  You can turn it off with <keybind:safemode>.\n\nAfter you've dealt with it, please move to the door behind it.")
        end,
    },
    tr_tutorial_4 = {
        seen = "seen_LESSON_REACH_ATTACK",
        text = function()
            return services.translate("There is another <color_light_cyan>dummy</color> standing behind the counters.  Most melee weapons require standing directly adjacent to your target in order to hit it.\n\nFortunately, some long weapons such as spears are able to perform reach attack with a range of 2 or 3, so if you have one, you don't need to climb onto the counters to stand next to the dummy.  The <color_light_cyan>steel spear</color> has a range of 2, so you can hit the dummy right over the counters.  To use the reach attack, press the <keybind:fire> key.  Once you select your target, press <keybind:CONFIRM> to confirm.\n\nAfter you've dealt with the dummy, please move to the corridor to the south.")
        end,
    },
    tr_tutorial_5 = {
        text = function()
            return services.translate("Always wielding a <color_light_cyan>steel spear</color> in your hands might be inconvenient.  Fortunately, there is a <color_light_cyan>spear strap</color> lying on the rack nearby.  You can wear it by pressing <keybind:wear>.\nTo take off any worn item, you can press <keybind:take_off>.\n\nTo continue the tutorial, please wear the spear strap.")
        end,
    },
    tr_tutorial_6 = {
        text = function()
            return services.translate("In the next room you'll find a row of racks with a gun, a magazine for it, and ammo for it.  To be able to fire a gun, you'll need to insert a magazine with ammo in it.  Press <keybind:reload_item> to open the <color_light_cyan>Reload item</color> menu and put ammo in the magazine, and then press <keybind:reload_item> once again to insert a magazine into a gun.\n\nIf you wish to unload your gun, possibly to change ammunition types, press <keybind:unload>.")
        end,
    },
    tr_tutorial_7 = {
        text = function()
            return services.translate("Cataclysm uses a container-based inventory.  Putting something into your inventory requires wearing some clothing or container with pockets that are big enough to hold it.  The <color_light_cyan>spear strap</color> is one example of such containers.  Pockets have finite dimensions, so you can't put an item that has more volume or is longer than a pocket.\n\nTo view your inventory, press <keybind:inventory>.  You'll see that you have only your worn clothes, of which only your jeans have 4 small pockets.  Select your jeans and press <keybind:CONFIRM> to see their description and amount of pockets.  To scroll through the description, press <keybind:PAGE_UP> and <keybind:PAGE_DOWN>.\n\nTo continue the tutorial, move to the western rack and wear (<keybind:wear>) the <color_light_cyan>backpack</color> to increase the available capacity of your inventory.")
        end,
    },
    tr_tutorial_8 = {
        text = function()
            return services.translate("There is a <color_light_cyan>flashlight</color> and a <color_light_cyan>medium battery</color> lying on the rack.  Flashlights are very useful tools as they allow you to see in the dark.\n\nTo continue the tutorial, please reload the flashlight by pressing <keybind:reload_item>.  Take it with you and move to the stairs.")
        end,
    },
    tr_tutorial_9 = {
        text = function()
            return services.translate("There is a <color_light_cyan>water dispenser</color> around the corner.  Pick up the <color_light_cyan>plastic bottle</color> from the rack and proceed to the dispenser.")
        end,
    },
    tr_tutorial_10 = {
        text = function()
            return services.translate("A <color_light_cyan>flashlight</color> is a good thing to have, but it drains its battery quickly, so it won't last very long.  A much better solution for long-lasting lighting is a <color_light_cyan>gasoline lantern</color>.  Reload the lantern with <color_light_cyan>gasoline</color> (<keybind:reload_item>) and then activate it (<keybind:apply>) while standing nearby.  A <color_light_cyan>lighter</color> will help you to fire the lantern.\n\nSome tools (such as lamps, dehydrators, bathroom scales etc) don't need to be picked up before activating and allow remote use.\n\nAfter you light the lantern, you can safely turn off your flashlight to conserve its energy; the lit lantern will give you enough light for any actions and will last much longer.\n\nTo continue the tutorial, please light the lantern and then move to the corridor to the east.")
        end,
    },
    tr_tutorial_11 = {
        seen = "seen_LESSON_CRAFTING_FOOD",
        text = function()
            return services.translate("Looks like you're hungry!  The hunger status is indicated on the sidebar.  Let's make a <color_light_cyan>peanut butter sandwich</color> from <color_light_cyan>peanut butter</color> and <color_light_cyan>crackers</color> on the counter next to the wall.\n\nTo make food, you need to use the <color_light_cyan>Crafting</color> menu.  Press <keybind:craft> to open the menu.  Press <keybind:NEXT_TAB> and <keybind:PREV_TAB> to toggle crafting categories and select the <color_light_cyan>FOOD</color> category.  From there, select peanut butter sandwich and press <keybind:CONFIRM> to start crafting.\n\nNote that you don't need to stand directly near the counter to be able to craft.  The <color_light_cyan>crafting radius</color> is 6 tiles, so while you're standing no farther than 6 tiles from any crafting components and tools, your character is able to still get them in order to use them.\n\nTo continue the tutorial, please craft the peanut butter sandwich and then eat it by pressing <keybind:eat>.")
        end,
    },
    tr_tutorial_12 = {
        text = function()
            return services.translate("In the next room, you can find a <color_light_cyan>paint brush</color> and several cans of <color_light_cyan>paint</color>.  You can use them to paint the wall in your preferred color.  To do this, open the <color_light_cyan>Construction</color> menu by pressing <keybind:construct> and toggling the categories with <keybind:LEFT> and <keybind:RIGHT>.  Find the <color_light_cyan>Decorative</color> category and select one of the options to paint the wall.\n\nTo continue the tutorial, please paint some walls and move further south.")
        end,
    },
    tr_tutorial_14 = {
        text = function()
            return services.translate("There are 10 <color_light_cyan>baseballs</color> lying on the floor.  You might not need all 10, or you might not have enough space in your pockets.  To pick up a specific amount of items, press <keybind:pickup>, select the stack of items, and type a number on the keyboard (Multiple numbers can be used for large stacks).  Finish the selection with <keybind:INVENTORY:TOGGLE_ENTRY>.  The cursor should change to a <color_light_cyan>#</color> symbol.\n\nYou can throw a baseball at the <color_light_cyan>dummy</color> in the end of the corridor by pressing <keybind:throw>.\n\nTo complete the tutorial, throw some baseballs at the dummy and then move to the end of the corridor to the north.")
        end,
    },
    tr_tutorial_15 = {
        text = function()
            return services.translate("Congratulations!  You have completed the tutorial.  Here is some last-minute advice.\n\nYou can press <keybind:action_menu> to open the <color_light_cyan>Action menu</color>.  It provides a convenient way to access various actions.\n\nNot sure what keys you can press in a given menu?  Press the <keybind:HELP_KEYBINDINGS> to open the <color_light_cyan>Keybindings</color> menu.  It allows you to view the existing keybindings and modify them to your liking.  Sometimes there will be lesser used or convenience actions without a default keybinding, which you can also set.\n\nYou can continue exploring the tutorial rooms, or you can exit the tutorial by pressing <keybind:main_menu> followed by <keybind:save>.  This will save your game and exit to the main menu.\n\nConsider starting your first game with a custom character with the \"Friends to the End\" scenario for a start with more direction or \"Play Now! (Default Scenario)\" if you just want to jump straight in.  Dying is frequent in the cataclysm so if you choose to make a custom character then you can load the same initial character and scenario after death by using \"Preset Character\" -> \"Last Character\".  You can also consult the help menu on the main menu or in game using <keybind:help> for more information.")
        end,
    },
}

ccb.runtime.handler("tutorial_lesson", function(ctx)
    local lesson = lessons[ctx.trap_id]
    local actor = ctx.creature
    if not lesson or not actor or not actor:is_valid() or actor.subtype ~= "avatar" then
        return false
    end
    if lesson.seen then
        if (checked(variables.get_number(actor, lesson.seen)).value or 0) == 1 then
            return false
        end
        checked(variables.set(actor, lesson.seen, 1, { include_before = false }))
    end
    local text = checked(services.text.expand_for(lesson.text(), actor, nil, nil, nil, true))
    ccb.presentation.notice_top(text)
    services.activities.offer_interruption("")
    services.messages.add(text, "neutral")
    return false
end)
