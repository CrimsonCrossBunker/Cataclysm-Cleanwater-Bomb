local content = require("ccb").content

-- enchantments.json
content.add(content.Enchantment { id = "ENCH_DEBUG_TORSO", condition = "ALWAYS" }
    :bodypart_change("", "torso")
    :bodypart_change("debug_torso", ""))

content.add(content.Enchantment { id = "ENCH_GASTROPOD_FOOT", condition = "ALWAYS" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = 0.25 })
    :bodypart_change("", "leg_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("", "foot_l")
    :bodypart_change("gastropod_foot", ""))

content.add(content.Enchantment { id = "ENCH_NO_RIGHT_LEG", condition = "ALWAYS" }
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_stub_r", ""))

content.add(content.Enchantment { id = "ENCH_NO_LEFT_LEG", condition = "ALWAYS" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("leg_stub_l", ""))

content.add(content.Enchantment { id = "ENCH_RIGHT_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "leg_stub_r")
    :bodypart_change("leg_prosthetic_r", "")
    :bodypart_change("foot_prosthetic_r", ""))

content.add(content.Enchantment { id = "ENCH_LEFT_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "leg_stub_l")
    :bodypart_change("leg_prosthetic_l", "")
    :bodypart_change("foot_prosthetic_l", ""))

content.add(content.Enchantment { id = "ENCH_RIGHT_PEGLEG", condition = "ALWAYS" }
    :bodypart_change("", "leg_stub_r")
    :bodypart_change("leg_peg_r", ""))

content.add(content.Enchantment { id = "ENCH_LEFT_PEGLEG", condition = "ALWAYS" }
    :bodypart_change("", "leg_stub_l")
    :bodypart_change("leg_peg_l", ""))

content.add(content.Enchantment { id = "ENCH_NO_LEFT_ARM", condition = "ALWAYS" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_stub_l", ""))

content.add(content.Enchantment { id = "ENCH_NO_RIGHT_ARM", condition = "ALWAYS" }
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_stub_r", ""))

content.add(content.Enchantment { id = "ENCH_RIGHT_ARM_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_r")
    :bodypart_change("arm_prosthetic_r", "")
    :bodypart_change("hand_prosthetic_r", ""))

content.add(content.Enchantment { id = "ENCH_LEFT_ARM_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_l")
    :bodypart_change("arm_prosthetic_l", "")
    :bodypart_change("hand_prosthetic_l", ""))

content.add(content.Enchantment { id = "ENCH_RIGHT_ARM_NEUROPROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_r")
    :bodypart_change("arm_neuroprosthetic_r", "")
    :bodypart_change("hand_neuroprosthetic_r", ""))

content.add(content.Enchantment { id = "ENCH_LEFT_ARM_NEUROPROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_l")
    :bodypart_change("arm_neuroprosthetic_l", "")
    :bodypart_change("hand_neuroprosthetic_l", ""))

content.add(content.Enchantment { id = "ENCH_RIGHT_ARM_COSMETIC_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_r")
    :bodypart_change("arm_prosthetic_cosmetic_r", "")
    :bodypart_change("hand_prosthetic_r", ""))

content.add(content.Enchantment { id = "ENCH_LEFT_ARM_COSMETIC_PROSTHETIC", condition = "ALWAYS" }
    :bodypart_change("", "arm_stub_l")
    :bodypart_change("arm_prosthetic_cosmetic_r", "")
    :bodypart_change("hand_prosthetic_l", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_ARMS", condition = "ALWAYS" }
    :bodypart_change("", "hand_l")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_r", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_LEGS", condition = "ALWAYS" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_l")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_r", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_TREADS", condition = "ALWAYS" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_l")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_bionic_treads", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_ARM_L", condition = "ALWAYS" }
    :bodypart_change("", "arm_l")
    :bodypart_change("", "hand_l")
    :bodypart_change("arm_bionic_basic_l", "")
    :bodypart_change("hand_bionic_basic_l", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_ARM_R", condition = "ALWAYS" }
    :bodypart_change("", "arm_r")
    :bodypart_change("", "hand_r")
    :bodypart_change("arm_bionic_basic_r", "")
    :bodypart_change("hand_bionic_basic_r", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_LEG_L", condition = "ALWAYS" }
    :bodypart_change("", "leg_l")
    :bodypart_change("", "foot_l")
    :bodypart_change("leg_bionic_basic_l", "")
    :bodypart_change("foot_bionic_basic_l", ""))

content.add(content.Enchantment { id = "ENCH_BIONIC_LEG_R", condition = "ALWAYS" }
    :bodypart_change("", "leg_r")
    :bodypart_change("", "foot_r")
    :bodypart_change("leg_bionic_basic_r", "")
    :bodypart_change("foot_bionic_basic_r", ""))
