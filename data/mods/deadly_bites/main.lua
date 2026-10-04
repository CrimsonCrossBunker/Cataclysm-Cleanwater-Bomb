local ccb = require("ccb")
local behavior = require("behavior")

ccb.runtime.handler("take_antiviral", behavior.take_antiviral, 1)
ccb.runtime.handler("begin_deadly_virus", behavior.begin_infected, 1)

local antiviral = ccb.content.Item {
    id = "antivirals",
    copy_from = "deadly_bites_antiviral_base",
}
antiviral:on_use("take_antiviral",
    ccb.content.text("Reduces the effect of certain viral infections."))
ccb.content.add(antiviral)

require("scenario")
