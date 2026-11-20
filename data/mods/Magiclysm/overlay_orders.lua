local ccb = require("ccb")
local content = ccb.content

-- Native global mutation-overlay ordering
do
local definition = content.OverlayOrder()
definition:mutation("DRAGON_WINGS_BLACK", 500)
definition:mutation("DRAGON_SCALES_BLACK", 1500)
definition:mutation("DEMON_SKIN", 1500)
definition:mutation("SKIN_BLUE", 1500)
definition:mutation("SKIN_GREEN", 1500)
definition:mutation("SKIN_GRAY", 1500)
definition:mutation("SKIN_MIDNIGHT", 1500)
definition:mutation("SKIN_OPAL", 1500)
definition:mutation("SKIN_RED", 1500)
definition:mutation("DRAGON_TAIL_STUB", 400)
definition:mutation("DRAGON_TAIL_SCALED", 400)
definition:mutation("DRAGON_TAIL", 400)
definition:mutation("HORNS_DRAGON", 6000)
definition:mutation("MUZZLE_DRAGON", 7000)
definition:mutation("DRAGON_MAW_BLACK", 7000)
definition:mutation("DRAGON_BREATH_BLACK", 8500)
content.add(definition)
end
