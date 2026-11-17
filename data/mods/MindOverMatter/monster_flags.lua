local ccb = require("ccb")
local content = ccb.content

-- Immune to cellular breakdown
content.add(content.MonsterFlag { id = "ENERVATE_IMMUNE" })

-- Immune to photokinetic damage
content.add(content.MonsterFlag { id = "PHOTOKIN_MONSTER_IMMUNE" })

-- Immune to telekinetic damage
content.add(content.MonsterFlag { id = "TELEKIN_IMMUNE" })

-- Immune to being telekinetically thrown
content.add(content.MonsterFlag { id = "TELEKIN_PUSH_PULL_IMMUNE" })

-- This monster is part of a hive mind
content.add(content.MonsterFlag { id = "HIVE_MIND" })

-- Immune to forcible teleportation
content.add(content.MonsterFlag { id = "TELEPORT_IMMUNE" })
