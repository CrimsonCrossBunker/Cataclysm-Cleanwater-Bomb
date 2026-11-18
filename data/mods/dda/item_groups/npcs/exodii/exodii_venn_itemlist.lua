local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_Bionic_Limb_Store_Tier1", kind = "collection" }
    group:item("bio_exodii_arm_bionic_basic_right")
    group:item("bio_exodii_arm_bionic_basic_left")
    group:item("bio_exodii_leg_bionic_basic_right")
    group:item("bio_exodii_leg_bionic_basic_left")
    group:item("bio_exodii_arm_bionic_basic_armored_right")
    group:item("bio_exodii_arm_bionic_basic_armored_left")
    group:item("bio_exodii_leg_bionic_basic_armored_right")
    group:item("bio_exodii_leg_bionic_basic_armored_left")
    group:item("bio_exodii_leg_bionic_treads")
    content.add(group)
end
