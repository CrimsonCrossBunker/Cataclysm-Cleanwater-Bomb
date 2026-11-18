local content = require("ccb").content

local human = content.Anatomy { id = "human_anatomy" }
human:part("eyes")
human:part("head")
human:part("mouth")
human:part("torso")
human:part("arm_l")
human:part("arm_r")
human:part("hand_l")
human:part("hand_r")
human:part("leg_l")
human:part("leg_r")
human:part("foot_l")
human:part("foot_r")
content.add(human)

local default = content.Anatomy { id = "default_anatomy" }
default:part("torso")
default:part("head")
content.add(default)
