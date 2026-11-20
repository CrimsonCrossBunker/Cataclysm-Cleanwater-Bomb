local ccb = require("ccb")
local content = ccb.content

-- Native effect migrations
do
do
local definition = content.Migration {
    kind = "effect",
    from = "winded_leg_l",
    to = "winded_leg",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "winded_leg_r",
    to = "winded_leg",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "winded_arm_l",
    to = "winded_arm",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "winded_arm_r",
    to = "winded_arm",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "no_power_leg_l",
    to = "no_power_leg",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "no_power_leg_r",
    to = "no_power_leg",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "no_power_arm_l",
    to = "no_power_arm",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "effect",
    from = "no_power_arm_r",
    to = "no_power_arm",
}
content.add(definition)
end
end

-- Native overmap-terrain migrations
do
do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_north",
    to = "s_lightindustry_10_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_north",
    to = "s_lightindustry_11_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_0_north",
    to = "s_lightindustry_road_0_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_1_north",
    to = "s_lightindustry_road_1_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_north",
    to = "s_lightindustry_00_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_north",
    to = "s_lightindustry_01_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_roof_north",
    to = "s_lightindustry_10_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_roof_north",
    to = "s_lightindustry_11_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_roof_north",
    to = "s_lightindustry_00_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_roof_north",
    to = "s_lightindustry_01_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_east",
    to = "s_lightindustry_10_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_east",
    to = "s_lightindustry_11_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_0_east",
    to = "s_lightindustry_road_0_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_1_east",
    to = "s_lightindustry_road_1_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_east",
    to = "s_lightindustry_00_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_east",
    to = "s_lightindustry_01_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_roof_east",
    to = "s_lightindustry_10_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_roof_east",
    to = "s_lightindustry_11_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_roof_east",
    to = "s_lightindustry_00_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_roof_east",
    to = "s_lightindustry_01_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_south",
    to = "s_lightindustry_10_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_south",
    to = "s_lightindustry_11_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_0_south",
    to = "s_lightindustry_road_0_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_1_south",
    to = "s_lightindustry_road_1_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_south",
    to = "s_lightindustry_00_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_south",
    to = "s_lightindustry_01_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_roof_south",
    to = "s_lightindustry_10_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_roof_south",
    to = "s_lightindustry_11_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_roof_south",
    to = "s_lightindustry_00_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_roof_south",
    to = "s_lightindustry_01_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_west",
    to = "s_lightindustry_10_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_west",
    to = "s_lightindustry_11_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_0_west",
    to = "s_lightindustry_road_0_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_road_1_west",
    to = "s_lightindustry_road_1_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_west",
    to = "s_lightindustry_00_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_west",
    to = "s_lightindustry_01_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_10_roof_west",
    to = "s_lightindustry_10_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_11_roof_west",
    to = "s_lightindustry_11_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_00_roof_west",
    to = "s_lightindustry_00_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_lightindustry_scen_01_roof_west",
    to = "s_lightindustry_01_roof_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_vandal_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_vandal_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_vandal_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_vandal_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_survivor_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_survivor_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_survivor_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_survivor_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_infested_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_infested_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_infested_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_infested_north",
    to = "shelter_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1_north",
    to = "shelter_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1b_north",
    to = "shelter_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_2_north",
    to = "shelter_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_vandal_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_infested_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_vandal_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_infested_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_vandal_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_infested_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_vandal_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_infested_north",
    to = "shelter_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_unfinished_north",
    to = "shelter_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_unfinished_north",
    to = "shelter_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_unfinished_north",
    to = "shelter_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_unfinished_north",
    to = "shelter_under_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_unfinished_north",
    to = "shelter_under_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_unfinished_north",
    to = "shelter_under_unfinished_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_vandal_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_vandal_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_vandal_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_vandal_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_survivor_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_survivor_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_survivor_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_survivor_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_infested_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_infested_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_infested_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_infested_east",
    to = "shelter_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1_east",
    to = "shelter_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1b_east",
    to = "shelter_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_2_east",
    to = "shelter_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_vandal_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_infested_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_vandal_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_infested_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_vandal_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_infested_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_vandal_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_infested_east",
    to = "shelter_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_unfinished_east",
    to = "shelter_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_unfinished_east",
    to = "shelter_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_unfinished_east",
    to = "shelter_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_unfinished_east",
    to = "shelter_under_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_unfinished_east",
    to = "shelter_under_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_unfinished_east",
    to = "shelter_under_unfinished_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_vandal_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_vandal_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_vandal_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_vandal_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_survivor_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_survivor_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_survivor_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_survivor_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_infested_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_infested_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_infested_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_infested_south",
    to = "shelter_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1_south",
    to = "shelter_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1b_south",
    to = "shelter_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_2_south",
    to = "shelter_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_vandal_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_infested_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_vandal_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_infested_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_vandal_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_infested_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_vandal_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_infested_south",
    to = "shelter_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_unfinished_south",
    to = "shelter_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_unfinished_south",
    to = "shelter_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_unfinished_south",
    to = "shelter_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_unfinished_south",
    to = "shelter_under_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_unfinished_south",
    to = "shelter_under_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_unfinished_south",
    to = "shelter_under_unfinished_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_vandal_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_vandal_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_vandal_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_vandal_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_survivor_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_survivor_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_survivor_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_survivor_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_infested_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_infested_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_infested_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_infested_west",
    to = "shelter_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1_west",
    to = "shelter_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_1b_west",
    to = "shelter_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_roof_2_west",
    to = "shelter_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_vandal_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_infested_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_vandal_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_infested_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_vandal_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_infested_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_vandal_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_infested_west",
    to = "shelter_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1_unfinished_west",
    to = "shelter_unfinished_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_1b_unfinished_west",
    to = "shelter_unfinished_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_2_unfinished_west",
    to = "shelter_unfinished_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1_unfinished_west",
    to = "shelter_under_unfinished_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_1b_unfinished_west",
    to = "shelter_under_unfinished_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "shelter_under_2_unfinished_west",
    to = "shelter_under_unfinished_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1a_north",
    to = "LIXA_surface_1a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1b_north",
    to = "LIXA_surface_1b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2a_north",
    to = "LIXA_surface_2a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2b_north",
    to = "LIXA_surface_2b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1a_north",
    to = "LIXA_roof_1a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1b_north",
    to = "LIXA_roof_1b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2a_north",
    to = "LIXA_roof_2a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2b_north",
    to = "LIXA_roof_2b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1a_north",
    to = "LIXA_stairshaft_1a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1b_north",
    to = "LIXA_stairshaft_1b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1c_north",
    to = "LIXA_stairshaft_1c",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1d_north",
    to = "LIXA_stairshaft_1d",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2a_north",
    to = "LIXA_stairshaft_2a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2b_north",
    to = "LIXA_stairshaft_2b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2c_north",
    to = "LIXA_stairshaft_2c",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2d_north",
    to = "LIXA_stairshaft_2d",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1a_north",
    to = "LIXA_workfloor_1a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1b_north",
    to = "LIXA_workfloor_1b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2a_north",
    to = "LIXA_workfloor_2a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2b_north",
    to = "LIXA_workfloor_2b",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_roof_north",
    to = "LIXA_device_2_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_roof_north",
    to = "LIXA_device_3_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_1_north",
    to = "LIXA_device_1",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_north",
    to = "LIXA_device_2",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_north",
    to = "LIXA_device_3",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_noaccess_north",
    to = "LIXA_device_unfolded_noaccess",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_A_north",
    to = "LIXA_device_unfolded_A",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_B_north",
    to = "LIXA_device_unfolded_B",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_1_north",
    to = "LIXA_entry_1",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_2_north",
    to = "LIXA_entry_2",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_north",
    to = "LIXA_road",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_north",
    to = "LIXA_road_guard",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_roof_north",
    to = "LIXA_road_guard_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1c_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1d_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2c_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2d_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2a_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2b_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_1_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_noaccess_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_A_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_B_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_1_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_2_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1c_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1d_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2c_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2d_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2a_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2b_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_1_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_noaccess_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_A_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_B_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_1_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_2_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_1b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_surface_2b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_1b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_roof_2b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1c_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_1d_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2c_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_stairshaft_2d_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_1b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2a_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_workfloor_2b_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_1_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_2_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_3_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_noaccess_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_A_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_device_unfolded_B_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_1_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_entry_2_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "LIXA_road_guard_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_entrance_north",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a1_north",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a2_north",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_entrance_east",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a1_east",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a2_east",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_entrance_south",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a1_south",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a2_south",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_entrance_west",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a1_west",
    to = "deep_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "void_spider_lair_a2_west",
    to = "deep_rock",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "lodge_basement_laboratory_entrance",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_stairs",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_core",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_finale",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_train_depot",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_2_a1_tower_lab",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_stairs",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_finale",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a1_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a2_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b1_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b2_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b3_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_cells",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_entrance",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_stairs",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_stairs",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_core",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_finale",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_7_hidden",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_8_hidden_lab_stairs",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_9_hidden",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementD1_hidden_lab_stairs",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementE1",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "basement_hidden_lab_stairs",
    to = "basement",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_1",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_2",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_3",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_4",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_5",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_6",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_7",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_8",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_9",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_stairs",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_core",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_finale",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_train_depot",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_shaft",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_entrance",
    to = "forest",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_stairs_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_core_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_finale_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_train_depot_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_2_a1_tower_lab_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_stairs_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_finale_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a1_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a2_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b1_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b2_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b3_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_cells_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_entrance_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_stairs_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_stairs_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_core_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_finale_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_7_hidden_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_8_hidden_lab_stairs_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_9_hidden_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementD1_hidden_lab_stairs_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementE1_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "basement_hidden_lab_stairs_north",
    to = "basement",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_1_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_2_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_3_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_4_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_5_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_6_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_7_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_8_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_9_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_stairs_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_core_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_finale_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_train_depot_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_shaft_north",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_entrance_north",
    to = "forest",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_stairs_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_core_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_finale_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_train_depot_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_2_a1_tower_lab_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_stairs_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_finale_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a1_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a2_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b1_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b2_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b3_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_cells_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_entrance_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_stairs_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_stairs_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_core_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_finale_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_7_hidden_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_8_hidden_lab_stairs_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_9_hidden_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementD1_hidden_lab_stairs_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementE1_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "basement_hidden_lab_stairs_south",
    to = "basement",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_1_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_2_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_3_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_4_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_5_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_6_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_7_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_8_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_9_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_stairs_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_core_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_finale_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_train_depot_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_shaft_south",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_entrance_south",
    to = "forest",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_stairs_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_core_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_finale_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_train_depot_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_2_a1_tower_lab_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_stairs_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_finale_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a1_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a2_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b1_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b2_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b3_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_cells_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_entrance_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_stairs_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_stairs_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_core_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_finale_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_7_hidden_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_8_hidden_lab_stairs_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_9_hidden_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementD1_hidden_lab_stairs_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementE1_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "basement_hidden_lab_stairs_east",
    to = "basement",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_1_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_2_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_3_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_4_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_5_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_6_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_7_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_8_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_9_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_stairs_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_core_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_finale_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_train_depot_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_shaft_east",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_entrance_east",
    to = "forest",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_stairs_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_core_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_finale_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_train_depot_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_2_a1_tower_lab_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_stairs_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "tower_lab_finale_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a1_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_a2_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_open_air_corner_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b1_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b2_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "office_tower_lab_b3_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_cells_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_escape_entrance_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ants_lab_stairs_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_stairs_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_core_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "ice_lab_finale_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_7_hidden_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_8_hidden_lab_stairs_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "prison_1_b_9_hidden_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementD1_hidden_lab_stairs_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lab_surface_brick_basementE1_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "basement_hidden_lab_stairs_west",
    to = "basement",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_1_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_2_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_3_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_4_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_5_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_6_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_7_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_8_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_hq_9_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_stairs_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_core_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_finale_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_train_depot_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_shaft_west",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "central_lab_entrance_west",
    to = "forest",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "hw_supports",
    to = "hw_supports_north",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_prepperquest_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_under_empty_north",
    to = "lmoe_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_under_empty_north",
    to = "lmoe_under_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_prepperquest_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_under_empty_east",
    to = "lmoe_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_under_empty_east",
    to = "lmoe_under_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_prepperquest_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_under_empty_south",
    to = "lmoe_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_under_empty_south",
    to = "lmoe_under_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_prepperquest_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_under_empty_west",
    to = "lmoe_under_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "lmoe_zombie_under_empty_west",
    to = "lmoe_under_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_1",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_11",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_12",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_14",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_15",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_16",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_3",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_5",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_6",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_8",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_13_roof",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_13",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_2",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_4",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_4_roof",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_7",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_7_hayloft",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_7_roof",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_9",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_9_roof",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_10",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_10_roof",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "horse_farm_13_2ndfloor",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_g_north",
    to = "derelict_property_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_g_south",
    to = "derelict_property_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_g_east",
    to = "derelict_property_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_g_west",
    to = "derelict_property_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_b_north",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_b_south",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_b_east",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "bunker_shop_b_west",
    to = "solid_earth",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "megastore_parking_north",
    to = "s_lot_no_sidewalk_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "megastore_parking_east",
    to = "s_lot_no_sidewalk_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "megastore_parking_south",
    to = "s_lot_no_sidewalk_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "megastore_parking_west",
    to = "s_lot_no_sidewalk_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_east",
    to = "dirt_road_turn_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_forest_east",
    to = "dirt_road_turn_forest_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_forest_north",
    to = "dirt_road_turn_forest_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_forest_south",
    to = "dirt_road_turn_forest_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_forest_west",
    to = "dirt_road_turn_forest_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_north",
    to = "dirt_road_turn_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_south",
    to = "dirt_road_turn_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn1_west",
    to = "dirt_road_turn_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "meadow_core_north",
    to = "meadow_core",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "meadow_core_east",
    to = "meadow_core",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "meadow_core_south",
    to = "meadow_core",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "meadow_core_west",
    to = "meadow_core",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "city_center",
    to = "road_nesw_manhole",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_001_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_001_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_001_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_001_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_101_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_101_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_101_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "apartments_con_tower_101_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1a_npc_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1a_npc_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1a_npc_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1a_npc_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1b_npc_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1b_npc_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1b_npc_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_1b_npc_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2a_npc_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2a_npc_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2a_npc_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2a_npc_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2b_npc_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2b_npc_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2b_npc_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_2b_npc_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_roof_npc_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_roof_npc_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_roof_npc_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "campground_roof_npc_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_roof_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall0_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_roof_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall1_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_roof_east",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_roof_north",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_roof_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_roof_west",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_south",
    to = "omt_obsolete",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "trailerparksmall2_west",
    to = "omt_obsolete",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_north",
    to = "full_mutagen_lab_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_east",
    to = "full_mutagen_lab_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_south",
    to = "full_mutagen_lab_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "full_basic_lab_roof_west",
    to = "full_mutagen_lab_roof",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turnback_north",
    to = "rural_road_end_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turnback_east",
    to = "rural_road_end_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turnback_south",
    to = "rural_road_end_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turnback_west",
    to = "rural_road_end_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_north",
    to = "rural_road_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_east",
    to = "rural_road_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_south",
    to = "rural_road_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_west",
    to = "rural_road_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_north",
    to = "rural_road_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_east",
    to = "rural_road_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_south",
    to = "rural_road_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_west",
    to = "rural_road_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_north",
    to = "rural_road_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_east",
    to = "rural_road_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_south",
    to = "rural_road_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_west",
    to = "rural_road_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_north",
    to = "rural_road_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_east",
    to = "rural_road_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_south",
    to = "rural_road_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_west",
    to = "rural_road_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_north",
    to = "rural_road_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_east",
    to = "rural_road_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_south",
    to = "rural_road_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_west",
    to = "rural_road_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_north",
    to = "rural_road_nes",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_east",
    to = "rural_road_esw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_south",
    to = "rural_road_nsw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_west",
    to = "rural_road_new",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_north",
    to = "rural_road_esw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_east",
    to = "rural_road_nsw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_south",
    to = "rural_road_new",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_west",
    to = "rural_road_nes",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_4way_north",
    to = "rural_road_nesw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_4way_east",
    to = "rural_road_nesw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_4way_south",
    to = "rural_road_nesw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_4way_west",
    to = "rural_road_nesw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_forest_north",
    to = "rural_road_forest_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_forest_east",
    to = "rural_road_forest_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_forest_south",
    to = "rural_road_forest_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_forest_west",
    to = "rural_road_forest_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_forest_north",
    to = "rural_road_forest_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_forest_east",
    to = "rural_road_forest_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_forest_south",
    to = "rural_road_forest_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_forest_west",
    to = "rural_road_forest_ew",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_forest_north",
    to = "rural_road_forest_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_forest_east",
    to = "rural_road_forest_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_forest_south",
    to = "rural_road_forest_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn_forest_west",
    to = "rural_road_forest_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_forest_north",
    to = "rural_road_forest_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_forest_east",
    to = "rural_road_forest_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_forest_south",
    to = "rural_road_forest_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_turn1_forest_west",
    to = "rural_road_forest_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_forest_north",
    to = "rural_road_forest_sw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_forest_east",
    to = "rural_road_forest_wn",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_forest_south",
    to = "rural_road_forest_ne",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_turn_forest_west",
    to = "rural_road_forest_es",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_forest_north",
    to = "rural_road_forest_nes",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_forest_east",
    to = "rural_road_forest_esw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_forest_south",
    to = "rural_road_forest_nsw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rural_road_3way_forest_west",
    to = "rural_road_forest_new",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_forest_north",
    to = "rural_road_forest_esw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_forest_east",
    to = "rural_road_forest_nsw",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_forest_south",
    to = "rural_road_forest_new",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "dirt_road_3way_forest_west",
    to = "rural_road_forest_nes",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "cabin_liam_driveway",
    to = "rural_road_forest_ns",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "cabin_liam_driveway_north",
    to = "rural_road_forest_ns",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "hellmouth",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "rift",
    to = "empty_rock",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab",
    to = "house_05",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_basement_north",
    to = "house_05_basement_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_basement_east",
    to = "house_05_basement_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_basement_south",
    to = "house_05_basement_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_basement_west",
    to = "house_05_basement_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_north",
    to = "house_05_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_east",
    to = "house_05_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_south",
    to = "house_05_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "house_05ab_west",
    to = "house_05_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "2farm_roof_15_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "2farm_roof_15_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "2farm_roof_15_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "2farm_roof_15_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_M1_north",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_M1_east",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_M1_south",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_M1_west",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_h_north",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_h_east",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_h_south",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_h_west",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_h_north",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_h_east",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_h_south",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_h_west",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_north",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_east",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_south",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_west",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_open_north",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_open_east",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_open_south",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_straight_v_open_west",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_north",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_east",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_south",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_west",
    to = "farmland_straight_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_open_north",
    to = "farmland_straight_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_open_east",
    to = "farmland_straight_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_open_south",
    to = "farmland_straight_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "farm_lot_wire_turn_v_open_west",
    to = "farmland_straight_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "rock",
    to = "empty_rock",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "slimepit_top",
    to = "slimepit_z0_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "slimepit_bottom",
    to = "slimepit_z-1_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "slimepit",
    to = "slimepit_z-2_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "slimepit_down",
    to = "slimepit_z0_north",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_looted",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_looted_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_looted_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_looted_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_looted_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_1",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_1_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_1_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_1_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_1_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_1",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_1_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_1_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_1_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_1_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_1",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_1_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_1_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_1_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_upper_roof_1_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_looted",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_looted_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_looted_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_looted_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_3_looted_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_3",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_3_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_3_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_3_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_3_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_looted",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_looted_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_looted_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_looted_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_4_looted_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_4",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_4_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_4_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_4_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_roof_4_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2ndfloor_4",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2ndfloor_4_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2ndfloor_4_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2ndfloor_4_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gun_2ndfloor_4_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_2ndfloor",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_2ndfloor_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_2ndfloor_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_2ndfloor_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_2ndfloor_west",
    to = "s_gun_a_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_roof",
    to = "s_gun_a_roof",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_roof_north",
    to = "s_gun_a_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_roof_east",
    to = "s_gun_a_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_roof_south",
    to = "s_gun_a_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_roof_west",
    to = "s_gun_a_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_looted",
    to = "s_gun_a",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_looted_north",
    to = "s_gun_a_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_looted_east",
    to = "s_gun_a_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_looted_south",
    to = "s_gun_a_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gunstore_looted_west",
    to = "s_gun_a_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "silo_roof",
    to = "silo_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo",
    to = "silo_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo_1",
    to = "silo_1_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo_2",
    to = "silo_2_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo_3",
    to = "silo_3_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo_4",
    to = "silo_4_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "silo_finale",
    to = "silo_finale_north",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_entrance_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_1_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_1_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_1_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_1_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_2_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_2_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_2_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_2_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_3_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_3_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_3_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_2_3_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_1_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_1_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_1_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_1_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_2_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_2_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_2_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_2_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_3_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_3_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_3_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_3_3_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_roof_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_roof_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_roof_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_roof_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_roof_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_roof_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_roof_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "fema_1_3_roof_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_tlc_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_tlc_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_tlc_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_tlc_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_te_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_te_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_te_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_te_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_trc_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_trc_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_trc_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_trc_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_le_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_le_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_le_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_le_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_mid_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_mid_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_mid_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_mid_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_re_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_re_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_re_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_re_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_blc_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_blc_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_blc_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_blc_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_brc_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_brc_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_brc_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_brc_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_entrance_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_entrance_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_entrance_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "FEMA_entrance_west",
    to = "field",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_north",
    to = "s_gas_1_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_south",
    to = "s_gas_1_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_east",
    to = "s_gas_1_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_west",
    to = "s_gas_1_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_north",
    to = "outpost_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_south",
    to = "outpost_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_east",
    to = "outpost_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_west",
    to = "outpost_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_roof_north",
    to = "outpost_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_roof_south",
    to = "outpost_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_roof_east",
    to = "outpost_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "outpost_cross_roof_west",
    to = "outpost_roof_west",
}
content.add(definition)
end
end

-- Native overmap-special migrations
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "o_lightindustry_scen",
    to = "o_lightindustry",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter 1",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter 1b",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter 2",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Survivor",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Survivor 1",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Survivor 1b",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Survivor 2",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Vandalized",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Vandalized 2",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Vandalized 1b",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Vandalized 3",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Infested",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Infested 1",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Infested 1b",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Infested 2",
    to = "Evac Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Unfinished 1",
    to = "Evac Shelter Unfinished",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Unfinished 1b",
    to = "Evac Shelter Unfinished",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Evac Shelter Unfinished 2",
    to = "Evac Shelter Unfinished",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "void_spider_lair",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Lab",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Lab with Anthill",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Ice Lab",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Central Lab",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Prison Hidden Lab",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "basement_hidden_lab_entrance",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "office_tower_hiddenlab",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Occupied LMOE Shelter",
    to = "LMOE Shelter",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "farm_horse",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "railroad_city",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Railroad Station",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "house_05ab",
    to = "house_05",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Isherwood Farms",
    to = "Isherwood Farm Mutable",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "FakeSpecial_cs_market_small",
    to = "cs_market_small",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "FEMA Camp",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "FEMA_Camp2",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "FakeSpecial_s_gas",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "military_outpost_cross",
    to = "military_outpost",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "bunker shop",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_looted",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_1",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_2",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_3",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_3_looted",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_4",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gun_4_looted",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gunstore",
    to = "s_gun_a",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "s_gunstore_looted",
    to = "s_gun_a",
}
content.add(definition)
end
end

-- Native proficiency migrations
do
do
local definition = content.Migration {
    kind = "proficiency",
    from = "prof_wp_slime_basic",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "proficiency",
    from = "prof_wp_slime_advanced",
    to = "",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "proficiency",
    from = "prof_case_hardening",
    to = "prof_hardening",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "proficiency",
    from = "prof_quenching",
    to = "prof_tempering",
}
content.add(definition)
end
end

-- Native terrain and furniture migrations
do
do
local definition = content.Migration {
    kind = "furniture",
    from = "f_broken_boat",
    to = "f_beach_log",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "furniture",
    from = "f_board_map_o",
    to = "f_board_map_b",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_underbrush_harvested_spring",
    to = "t_underbrush_harvested",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_underbrush_harvested_summer",
    to = "t_underbrush_harvested",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_underbrush_harvested_autumn",
    to = "t_underbrush_harvested",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_underbrush_harvested_winter",
    to = "t_underbrush_harvested",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_nl_metal_wall_edge",
    to = "t_nl_metal_wall_border",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_nl_sewage_pipe_edge",
    to = "t_nl_sewage_pipe_border",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "terrain",
    from = "t_hole",
    to = "t_open_air",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "furniture",
    from = "f_arc_furnace",
    to = "f_arcfurnace_empty",
}
content.add(definition)
end
end

-- Native trap migrations
do
do
local definition = content.Migration {
    kind = "trap",
    from = "tr_ledge",
    to = "tr_null",
}
content.add(definition)
end
end

-- Native variable migrations
do
do
local definition = content.Migration {
    kind = "var",
    from = "u_talked_to_hub",
    to = "talked_to_hub",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "var",
    from = "u_know_jaryi",
    to = "know_jaryi",
}
content.add(definition)
end
end

-- Native vehicle-part migrations
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "atomic_lamp",
    to = "aisle_lights",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "atomic_light",
    to = "aisle_lights",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "ap_fridge",
    to = "ap_apartment_fridge",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "ap_freezer",
    to = "ap_chest_freezer",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "generator_7500w",
    to = "battery_car",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "car_light_plus_battery_cell",
    to = "battery_car",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "car_medium_plus_battery_cell",
    to = "battery_car",
}
content.add(definition)
end
end
