local ccb = require("ccb")
local returning = require("raid_return")

ccb.runtime.handler("labyrinth_home_transport", function(character)
    returning.home(character)
end)

ccb.runtime.handler("void_spider_lair_exit_transport", function(character)
    returning.home(character)
end)
