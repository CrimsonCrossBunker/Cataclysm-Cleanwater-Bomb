local ccb = require("ccb")
local content = ccb.content

-- Native monster blacklists
do
local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:entry("mon_zombie_fungus")
definition:entry("mon_boomer_fungus")
definition:entry("mon_zombie_child_fungus")
definition:entry("mon_zombie_gasbag_fungus")
definition:entry("mon_zombie_smoker_fungus")
definition:entry("mon_skeleton_fungus")
definition:entry("mon_skeleton_brute_fungus")
definition:entry("mon_skeleton_hulk_fungus")
definition:entry("mon_chud")
content.add(definition)
end
do
local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:species("ZOMBIE")
definition:species("ROBOT")
definition:species("CYBORG")
content.add(definition)
end
