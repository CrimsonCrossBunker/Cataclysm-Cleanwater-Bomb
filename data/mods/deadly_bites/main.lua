local ccb = require("ccb")
local behavior = require("behavior")

ccb.runtime.handler("take_antiviral", behavior.take_antiviral, 1)
ccb.runtime.handler("begin_deadly_virus", behavior.begin_infected, 1)

require("effects")
require("content")
require("scenario")
