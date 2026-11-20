local ccb = require("ccb")

return {
    heritage = {
        title = function() return ccb.services.translate("What is your heritage?") end,
        {
            id = "BROWNIE",
            label = function() return ccb.services.translate("Brownie") end,
            description = function() return ccb.services.translate("Your parents were brownies, the simple, down-to-earth crafters of the fae.") end,
        },
        {
            id = "POOKA",
            label = function() return ccb.services.translate("Pooka") end,
            description = function() return ccb.services.translate("Your parents were pookas, shapechangers that can take animal forms.") end,
        },
        {
            id = "SELKIE",
            label = function() return ccb.services.translate("Selkie") end,
            description = function() return ccb.services.translate("Your parents were selkies, who spend part of the time upon land and part of the time as a seal in the sea") end,
        },
        {
            id = "TROW",
            label = function() return ccb.services.translate("Trow") end,
            description = function() return ccb.services.translate("Your parents were trow, tough as stone, who dwell beneath the earth.") end,
        },
    },
    court = {
        title = function() return ccb.services.translate("Choose your court.") end,
        {
            id = "SUMMER",
            hotkey = "1",
            label = function() return ccb.services.translate("The Summer Court") end,
            description = function() return ccb.services.translate("The Summer Court, sometimes called the Seelie Court, the Fair Folk that are considered more benevolent (or at least, less malevolent) by mortals.") end,
        },
        {
            id = "WINTER",
            hotkey = "2",
            label = function() return ccb.services.translate("The Winter Court") end,
            description = function() return ccb.services.translate("The Winter Court, sometimes called the Unseelie Court, the Fair Folk who lurk under bridges and in the darkness of the wild places.") end,
        },
    },
    summer = {
        title = function() return ccb.services.translate("Choose the path of your magick.") end,
        {
            id = "SPRING",
            hotkey = "1",
            label = function() return ccb.services.translate("Magicks of Spring") end,
            description = function() return ccb.services.translate("Magicks of Spring, affecting plants, growth, healing, rain, creativity, and love.") end,
        },
        {
            id = "SUMMER",
            hotkey = "2",
            label = function() return ccb.services.translate("Magicks of Summer") end,
            description = function() return ccb.services.translate("Magicks of Summer, affecting heat, light, athleticism, passion, illusion, and plenty.") end,
        },
    },
    winter = {
        title = function() return ccb.services.translate("Choose the path of your magick.") end,
        {
            id = "AUTUMN",
            hotkey = "1",
            label = function() return ccb.services.translate("Magicks of Autumn") end,
            description = function() return ccb.services.translate("Magicks of Autumn, affecting decay, the harvest, fear, preservation, concealment, home and the hearth, and colors.") end,
        },
        {
            id = "WINTER",
            hotkey = "2",
            label = function() return ccb.services.translate("Magicks of Winter") end,
            description = function() return ccb.services.translate("Magicks of Winter, affecting darkness, silence, sleep, ice, snow, cold, wind, and death.") end,
        },
    },
    noble = {
        title = function() return ccb.services.translate("As one of the nobility of the Fair Folk, you are heir to a deeper understanding of their magicks.  Choose a second path.") end,
        hide_known = true,
        {
            id = "SPRING",
            hotkey = "1",
            label = function() return ccb.services.translate("Magicks of Spring") end,
            description = function() return ccb.services.translate("Magicks of Spring, affecting plants, growth, healing, rain, creativity, and love.") end,
        },
        {
            id = "SUMMER",
            hotkey = "2",
            label = function() return ccb.services.translate("Magicks of Summer") end,
            description = function() return ccb.services.translate("Magicks of Summer, affecting heat, light, athleticism, passion, illusion, and plenty.") end,
        },
        {
            id = "AUTUMN",
            hotkey = "3",
            label = function() return ccb.services.translate("Magicks of Autumn") end,
            description = function() return ccb.services.translate("Magicks of Autumn, affecting decay, the harvest, fear, preservation, concealment, home and the hearth, and colors.") end,
        },
        {
            id = "WINTER",
            hotkey = "4",
            label = function() return ccb.services.translate("Magicks of Winter") end,
            description = function() return ccb.services.translate("Magicks of Winter, affecting darkness, silence, sleep, ice, snow, cold, wind, and death.") end,
        },
    },
}
