local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "MARSHMALLOW",
    footsteps = ccb.content.text("shlop."),
}
definition:anger("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "GUMMY",
    footsteps = ccb.content.text("pop."),
}
definition:anger("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "CRACKER",
    footsteps = ccb.content.text("tac."),
}
definition:fear("HURT")
content.add(definition)
end
do
local definition = content.Species {
    id = "COOKIE",
    footsteps = ccb.content.text("pat."),
}
definition:fear("HURT")
definition:fear("SOUND")
content.add(definition)
end
do
local definition = content.Species {
    id = "CHEWGUM",
    footsteps = ccb.content.text("shlip."),
}
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "LICORICE",
    footsteps = ccb.content.text("Shlop."),
}
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
do
local definition = content.Species {
    id = "CHOCOLATE",
    footsteps = ccb.content.text("Clop."),
}
definition:anger("FRIEND_DIED")
definition:fear("HURT")
definition:fear("FIRE")
content.add(definition)
end
