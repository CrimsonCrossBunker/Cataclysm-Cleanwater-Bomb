local content = require("ccb").content

-- requirements/ammo.json

content.merge_requirement(
    content.Requirement { id = "ammo_762_25" }
        :component("unprimed_762_25_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 9mm ammo
content.merge_requirement(
    content.Requirement { id = "ammo_9mm" }
        :component("unprimed_9mm_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 38 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_38spc" }
        :component("unprimed_38_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 303 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_303" }
        :component("unprimed_303_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 308 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_308" }
        :component("unprimed_308_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 762x51 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_762_51" }
        :component("unprimed_762_51_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 30-06 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_3006" }
        :component("unprimed_3006_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 32 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_32" }
        :component("unprimed_32_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 380 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_380" }
        :component("unprimed_380_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 458 WM ammo
content.merge_requirement(
    content.Requirement { id = "ammo_458wm" }
        :component("unprimed_458wm_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 57 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_57" }
        :component("unprimed_57mm_casing", 1)
        :component("smrifle_primer", 1)
)

-- Components required for shotgun and signal flare ammo
content.merge_requirement(
    content.Requirement { id = "ammo_shot" }
        :component("unprimed_shot_hull", 1)
        :component("shotgun_primer", 1)
)

-- Components required for .357 Magnum ammo
content.merge_requirement(
    content.Requirement { id = "ammo_357mag" }
        :component("unprimed_357mag_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for .357 SIG ammo
content.merge_requirement(
    content.Requirement { id = "ammo_357sig" }
        :component("unprimed_357sig_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for 10mm Auto ammo
content.merge_requirement(
    content.Requirement { id = "ammo_10mm" }
        :component("unprimed_10mm_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for .45 Colt ammo
content.merge_requirement(
    content.Requirement { id = "ammo_45colt" }
        :component("unprimed_45colt_casing", 1)
        :component("lgpistol_primer", 1)
)

-- Components required for .38 Super ammo
content.merge_requirement(
    content.Requirement { id = "ammo_38super" }
        :component("unprimed_38super_casing", 1)
        :component("smpistol_primer", 1)
)

-- Components required for .410 ammo
content.merge_requirement(
    content.Requirement { id = "ammo_410shot" }
        :component("unprimed_410shot_hull", 1)
        :component("shotgun_primer", 1)
)

-- Components required for .270 Winchester ammo
content.merge_requirement(
    content.Requirement { id = "ammo_270win" }
        :component("unprimed_270win_casing", 1)
        :component("lgrifle_primer", 1)
)

-- Components required for 30 carbine ammo
content.merge_requirement(
    content.Requirement { id = "ammo_30carbine" }
        :component("unprimed_30carbine_casing", 1)
        :component("smrifle_primer", 1)
)

-- Components required for .300 AAC Blackout ammo
content.merge_requirement(
    content.Requirement { id = "ammo_300blk" }
        :component("unprimed_300blk_casing", 1)
        :component("smrifle_primer", 1)
)

-- Components required for .460 S&W ammo
content.merge_requirement(
    content.Requirement { id = "ammo_460sw" }
        :component("unprimed_460sw_casing", 1)
        :component("lgrifle_primer", 1)
)

-- References needed for boltfaces and magazines using .22 lr or derivatives
content.merge_requirement(
    content.Requirement { id = "22_casehead" }
        :tool_any {
            { id = "22_casing", count = 1 },
            { id = "22_casing_new", count = 1 },
            { id = "22_fmj", count = 1 },
            { id = "22_lr", count = 1 },
            { id = "22_cb", count = 1 },
            { id = "22_ratshot", count = 1 },
            { id = "bp_22_fmj", count = 1 },
            { id = "bp_22_lr", count = 1 },
            { id = "reloaded_22_lr", count = 1 },
            { id = "reloaded_22_fmj", count = 1 },
        }
)

-- References needed for boltfaces and magazines using .223 or derivatives
content.merge_requirement(
    content.Requirement { id = "223_casehead" }
        :tool_any {
            { id = "300blk_casing", count = 1 },
            { id = "unprimed_300blk_casing", count = 1 },
            { id = "223_casing", count = 1 },
            { id = "unprimed_223_casing", count = 1 },
            { id = "223", count = 1 },
            { id = "556", count = 1 },
            { id = "556_incendiary", count = 1 },
            { id = "bp_223", count = 1 },
            { id = "bp_556", count = 1 },
            { id = "bp_556_incendiary", count = 1 },
            { id = "reloaded_223", count = 1 },
            { id = "reloaded_556", count = 1 },
            { id = "reloaded_556_incendiary", count = 1 },
            { id = "300blk", count = 1 },
            { id = "300blk_ss", count = 1 },
            { id = "bp_300blk", count = 1 },
            { id = "reloaded_300blk", count = 1 },
        }
)

-- References needed for boltfaces and magazines using .308 or derivatives
content.merge_requirement(
    content.Requirement { id = "308_casehead" }
        :tool_any {
            { id = "308_casing", count = 1 },
            { id = "unprimed_308_casing", count = 1 },
            { id = "762_51_casing", count = 1 },
            { id = "unprimed_762_51_casing", count = 1 },
            { id = "308", count = 1 },
            { id = "762_51", count = 1 },
            { id = "762_51_incendiary", count = 1 },
            { id = "bp_308", count = 1 },
            { id = "bp_762_51", count = 1 },
            { id = "bp_762_51_incendiary", count = 1 },
            { id = "reloaded_308", count = 1 },
            { id = "reloaded_762_51", count = 1 },
            { id = "reloaded_762_51_incendiary", count = 1 },
        }
)

-- References needed for boltfaces and magazines using 9mm or derivatives
content.merge_requirement(
    content.Requirement { id = "9mm_casehead" }
        :tool_any {
            { id = "9mm_casing", count = 1 },
            { id = "unprimed_9mm_casing", count = 1 },
            { id = "9mm", count = 1 },
            { id = "9mmfmj", count = 1 },
            { id = "9mmP", count = 1 },
            { id = "9mmP2", count = 1 },
            { id = "bp_9mm", count = 1 },
            { id = "bp_9mmfmj", count = 1 },
            { id = "reloaded_9mm", count = 1 },
            { id = "reloaded_9mmfmj", count = 1 },
            { id = "reloaded_9mmP", count = 1 },
            { id = "reloaded_9mmP2", count = 1 },
        }
)

-- References needed for boltfaces and magazines using .40sw or derivatives
content.merge_requirement(
    content.Requirement { id = "40_casehead" }
        :tool_any {
            { id = "357sig_casing", count = 1 },
            { id = "unprimed_357sig_casing", count = 1 },
            { id = "40_casing", count = 1 },
            { id = "unprimed_40_casing", count = 1 },
            { id = "40fmj", count = 1 },
            { id = "40sw", count = 1 },
            { id = "bp_40fmj", count = 1 },
            { id = "bp_40sw", count = 1 },
            { id = "reloaded_40fmj", count = 1 },
            { id = "reloaded_40sw", count = 1 },
            { id = "357sig_fmj", count = 1 },
            { id = "357sig_jhp", count = 1 },
            { id = "reloaded_357sig_fmj", count = 1 },
            { id = "reloaded_357sig_jhp", count = 1 },
        }
)

-- References needed for boltfaces and magazines using .45acp or derivatives
content.merge_requirement(
    content.Requirement { id = "45_casehead" }
        :tool_any {
            { id = "45_casing", count = 1 },
            { id = "unprimed_45_casing", count = 1 },
            { id = "45_acp", count = 1 },
            { id = "45_jhp", count = 1 },
            { id = "45_super", count = 1 },
            { id = "bp_45_acp", count = 1 },
            { id = "bp_45_jhp", count = 1 },
            { id = "reloaded_45_acp", count = 1 },
            { id = "reloaded_45_jhp", count = 1 },
            { id = "reloaded_45_super", count = 1 },
        }
)

-- References needed for boltfaces and magazines using .30-06 or derivatives
content.merge_requirement(
    content.Requirement { id = "3006_casehead" }
        :tool_any {
            { id = "3006_casing", count = 1 },
            { id = "unprimed_3006_casing", count = 1 },
            { id = "3006", count = 1 },
            { id = "3006fmj", count = 1 },
            { id = "3006_incendiary", count = 1 },
            { id = "bp_3006", count = 1 },
            { id = "bp_3006fmj", count = 1 },
            { id = "bp_3006_incendiary", count = 1 },
            { id = "reloaded_3006", count = 1 },
            { id = "reloaded_3006fmj", count = 1 },
            { id = "reloaded_3006_incendiary", count = 1 },
            { id = "270win_casing", count = 1 },
            { id = "270win_jsp", count = 1 },
            { id = "reloaded_270win_jsp", count = 1 },
        }
)

-- References needed for boltfaces and magazines using 7.62x39 or derivatives
content.merge_requirement(
    content.Requirement { id = "762_casehead" }
        :tool_any {
            { id = "762_casing", count = 1 },
            { id = "unprimed_762_casing", count = 1 },
            { id = "762_jhp", count = 1 },
            { id = "762_m87", count = 1 },
            { id = "reloaded_762_jhp", count = 1 },
            { id = "reloaded_762_m87", count = 1 },
        }
)

-- References needed for boltfaces and magazines using 7.62x54R or derivatives
content.merge_requirement(
    content.Requirement { id = "762R_casehead" }
        :tool_any {
            { id = "762R_casing", count = 1 },
            { id = "unprimed_762R_casing", count = 1 },
            { id = "762_54R", count = 1 },
            { id = "reloaded_762_54R", count = 1 },
        }
)

-- References needed for forge and crucible to recast your stabilized explosives
content.merge_requirement(
    content.Requirement { id = "explosives_casting_standard" }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
        }
        :tool_charges("forge", 25)
)

-- References needed for boltfaces and magazines using .50 Beowulf or derivatives
content.merge_requirement(
    content.Requirement { id = "50beowulf_casehead" }
        :tool_any {
            { id = "50beowulf_casing", count = 1 },
            { id = "unprimed_50beowulf_casing", count = 1 },
            { id = "50beowulf_xtp", count = 1 },
            { id = "50beowulf_penetrator", count = 1 },
            { id = "bp_50beowulf_xtp", count = 1 },
            { id = "bp_50beowulf_penetrator", count = 1 },
            { id = "reloaded_50beowulf_xtp", count = 1 },
            { id = "reloaded_50beowulf_penetrator", count = 1 },
        }
)

-- A list of all pistol-caliber casings for use in crafts and adjacent projects.
content.merge_requirement(
    content.Requirement { id = "pistol_casings" }
        :component_any {
            { id = "22_casing", count = 1 },
            { id = "32_casing", count = 1 },
            { id = "unprimed_32_casing", count = 1 },
            { id = "38_casing", count = 1 },
            { id = "unprimed_38_casing", count = 1 },
            { id = "38super_casing", count = 1 },
            { id = "unprimed_38super_casing", count = 1 },
            { id = "40_casing", count = 1 },
            { id = "unprimed_40_casing", count = 1 },
            { id = "10mm_casing", count = 1 },
            { id = "unprimed_10mm_casing", count = 1 },
            { id = "44_casing", count = 1 },
            { id = "unprimed_44_casing", count = 1 },
            { id = "454_casing", count = 1 },
            { id = "unprimed_454_casing", count = 1 },
            { id = "460sw_casing", count = 1 },
            { id = "unprimed_460sw_casing", count = 1 },
            { id = "45_casing", count = 1 },
            { id = "unprimed_45_casing", count = 1 },
            { id = "45colt_casing", count = 1 },
            { id = "unprimed_45colt_casing", count = 1 },
            { id = "57mm_casing", count = 1 },
            { id = "unprimed_57mm_casing", count = 1 },
            { id = "500_casing", count = 1 },
            { id = "unprimed_500_casing", count = 1 },
            { id = "762_25_casing", count = 1 },
            { id = "unprimed_762_25_casing", count = 1 },
            { id = "9mm_casing", count = 1 },
            { id = "unprimed_9mm_casing", count = 1 },
            { id = "357sig_casing", count = 1 },
            { id = "unprimed_357sig_casing", count = 1 },
            { id = "357mag_casing", count = 1 },
            { id = "unprimed_357mag_casing", count = 1 },
            { id = "9x18mm_casing", count = 1 },
            { id = "unprimed_9x18mm_casing", count = 1 },
            { id = "380_casing", count = 1 },
            { id = "unprimed_380_casing", count = 1 },
            { id = "50ae_casing", count = 1 },
            { id = "unprimed_50ae_casing", count = 1 },
        }
)

-- A list of rifle-caliber casings for use in crafts and adjacent projects. Excludes giant cartridges like .50 Browning and shotgun shells.
content.merge_requirement(
    content.Requirement { id = "rifle_casings" }
        :component_any {
            { id = "123ln_casing", count = 1 },
            { id = "unprimed_123ln_casing", count = 1 },
            { id = "223_casing", count = 1 },
            { id = "unprimed_223_casing", count = 1 },
            { id = "270win_casing", count = 1 },
            { id = "unprimed_270win_casing", count = 1 },
            { id = "3006_casing", count = 1 },
            { id = "unprimed_3006_casing", count = 1 },
            { id = "303_casing", count = 1 },
            { id = "unprimed_303_casing", count = 1 },
            { id = "308_casing", count = 1 },
            { id = "unprimed_308_casing", count = 1 },
            { id = "300blk_casing", count = 1 },
            { id = "unprimed_300blk_casing", count = 1 },
            { id = "30carbine_casing", count = 1 },
            { id = "unprimed_30carbine_casing", count = 1 },
            { id = "300_casing", count = 1 },
            { id = "unprimed_300_casing", count = 1 },
            { id = "4570_casing", count = 1 },
            { id = "unprimed_4570_casing", count = 1 },
            { id = "450_casing", count = 1 },
            { id = "unprimed_450_casing", count = 1 },
            { id = "545_casing", count = 1 },
            { id = "unprimed_545_casing", count = 1 },
            { id = "50beowulf_casing", count = 1 },
            { id = "unprimed_50beowulf_casing", count = 1 },
            { id = "762R_casing", count = 1 },
            { id = "unprimed_762R_casing", count = 1 },
            { id = "762_51_casing", count = 1 },
            { id = "unprimed_762_51_casing", count = 1 },
            { id = "762_casing", count = 1 },
            { id = "unprimed_762_casing", count = 1 },
            { id = "77arisaka_casing", count = 1 },
            { id = "unprimed_77arisaka_casing", count = 1 },
        }
)

-- Assorted larger-than-average bullet casings and grenade shells for use in crafts and related projects. Also includes shotgun shells, because those lads are chunky.
content.merge_requirement(
    content.Requirement { id = "heavy_weapon_casings" }
        :component_any {
            { id = "40x46mm_m212_casing", count = 1 },
            { id = "40x46mm_m118_casing", count = 1 },
            { id = "40x46mm_m199_casing", count = 1 },
            { id = "40x46mm_m195_casing", count = 1 },
            { id = "40x46mm_hornets_nest_22lr_casing", count = 1 },
            { id = "40x46mm_hornets_nest_410_casing", count = 1 },
            { id = "40x53mm_m169_casing", count = 1 },
            { id = "50_casing", count = 1 },
            { id = "unprimed_50_casing", count = 1 },
            { id = "338lapua_casing", count = 1 },
            { id = "unprimed_338lapua_casing", count = 1 },
            { id = "458wm_casing", count = 1 },
            { id = "unprimed_458wm_casing", count = 1 },
            { id = "shot_hull", count = 1 },
            { id = "410shot_hull", count = 1 },
            { id = "273x110casing", count = 1 },
            { id = "273x44casing", count = 1 },
        }
)

-- requirements/butchery.json

-- omit butcher quality because it is checked separately
content.merge_requirement(
    content.Requirement { id = "full_butchery_large" }
        :quality("SURFACE", 3, 1)
        :quality("ROPE", 2, 1)
        :quality("SUSPENDING", 2, 1)
        :quality("CUT", 2, 1)
        :quality("SAW_W", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "butchery_large" }
        :quality("SURFACE", 3, 1)
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "dissect_large" }
        :quality("SURFACE", 3, 1)
        :quality("CUT_FINE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "butchery_small" }
        :quality("SURFACE", 2, 1)
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "dissect_small" }
        :quality("SURFACE", 2, 1)
        :quality("CUT_FINE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "field_dress" }
        :quality("SURFACE", 2, 1)
        :quality("CUT", 2, 1)
)

-- omit butcher quality because it is checked separately
content.merge_requirement(
    content.Requirement { id = "full_butchery_large_no_surface" }
        :quality("ROPE", 2, 1)
        :quality("SUSPENDING", 2, 1)
        :quality("CUT", 2, 1)
        :quality("SAW_W", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "butchery_large_no_surface" }
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "dissect_large_no_surface" }
        :quality("CUT_FINE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "butchery_small_no_surface" }
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "dissect_small_no_surface" }
        :quality("CUT_FINE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "field_dress_no_surface" }
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "bleed_large" }
        :quality("ROPE", 2, 1)
        :quality("SUSPENDING", 2, 1)
        :quality("CUT", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "bleed_small" }
        :quality("CUT", 2, 1)
)

-- requirements/chemistry.json

-- This should contain all strong acids, based on pKa value.
content.merge_requirement(
    content.Requirement { id = "any_strong_acid" }
        :component_any {
            { id = "chem_sulphuric_acid", count = 1 },
            { id = "chem_muriatic_acid", count = 1 },
            { id = "chem_nitric_acid", count = 1 },
        }
)

-- This should contain all weak acids, based on pKa value.
content.merge_requirement(
    content.Requirement { id = "any_weak_acid" }
        :component_any {
            { id = "chem_acetic_acid", count = 1 },
            { id = "formic_acid", count = 1 },
        }
)

-- This should contain all weak acids, based on pKa value.
content.merge_requirement(
    content.Requirement { id = "any_weak_acid" }
        :component_any {
            { id = "chem_acetic_acid", count = 1 },
            { id = "formic_acid", count = 1 },
            { id = "chem_citric_acid", count = 1 },
        }
)

-- Borax flux for use in Cu/Fe/Ag/Au brazing, welding, and forging, such as fluxing copper, iron, gold, or silver. One unit of flux covers 10cm^2 area of joining. For brazing, ~15g per 100g of product should be used.
content.merge_requirement(
    content.Requirement { id = "flux" }
        :component("chem_borax", 1)
)

-- Iron/Steel forging flux. One spoonful of flux covers 50cm^2 area of joining.
content.merge_requirement(
    content.Requirement { id = "flux_fe_forge" }
        :component_any {
            { id = "flux", count = 1, requirement = true },
            { id = "flux_ash", count = 1 },
        }
)

-- Iron/Steel smelting flux. 
content.merge_requirement(
    content.Requirement { id = "flux_fe_smelt" }
        :component_any {
            { id = "flux", count = 1, requirement = true },
            { id = "chem_caco3", count = 50 },
        }
)

-- Hi-temp lubricant for metal chains and parts, such as flatjaw tongs. makes a very thin coating. 1mL is enough to cover 1ft^2 or .1m^2 of material.
content.merge_requirement(
    content.Requirement { id = "metal_lube" }
        :component("graphite", 1)
)

-- Drifts are used for punching for some reason in CDDA. This requirement reflects that a drift is required, and so is high temp metal lubricant.
content.merge_requirement(
    content.Requirement { id = "metal_punch" }
        :component("metal_lube", 1, true)
        :tool("drift", 1)
)

-- This punch recipe is for the nail punch and regular steel drift, for use on bronze items. A bronze punch/drift should be added here if ti becomes an item.
content.merge_requirement(
    content.Requirement { id = "bronze_punch" }
        :component("metal_lube", 1, true)
        :tool_any {
            { id = "drift", count = 1 },
            { id = "punch_nail", count = 1 },
        }
)

-- requirements/cooking_components.json

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- Bread type food usable as batter for frying.
content.merge_requirement(
    content.Requirement { id = "batter" }
        :component_any {
            { id = "flour", count = 2 },
            { id = "flour_wheat_free", count = 2 },
            { id = "bread_flour", count = 2 },
            { id = "cornmeal", count = 1 },
            { id = "flatbread", count = 1 },
            { id = "tortilla_any", count = 1, requirement = true },
            { id = "bread", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "biscuit", count = 1 },
            { id = "hardtack", count = 1 },
            { id = "crackers", count = 1 },
            { id = "hallula", count = 1 },
        }
)

-- Bread appropriate for toast.
content.merge_requirement(
    content.Requirement { id = "bread_toastable" }
        :component_any {
            { id = "bread", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "sourdough_bread", count = 1 },
            { id = "brioche", count = 1 },
            { id = "brown_bread", count = 1 },
            { id = "hallula", count = 1 },
            { id = "snack_bread", count = 1 },
        }
)

-- Bread appropriate for sandwiches.
content.merge_requirement(
    content.Requirement { id = "bread_sandwich" }
        :component_any {
            { id = "bread_toastable", count = 1, requirement = true },
            { id = "flatbread", count = 1 },
            { id = "tortilla_any", count = 1, requirement = true },
            { id = "biscuit", count = 1 },
            { id = "crackers", count = 1 },
            { id = "toast", count = 1 },
        }
)

-- Any type of bread
content.merge_requirement(
    content.Requirement { id = "any_bread" }
        :component("bread_sandwich", 1, true)
)

-- Peanut butter of all types and other peanut butter substitutes
content.merge_requirement(
    content.Requirement { id = "any_peanutbutter" }
        :component_any {
            { id = "peanutbutter", count = 1 },
            { id = "spread_peanutbutter", count = 1 },
        }
)

-- Any type of prepared culinary nut besides coconuts
content.merge_requirement(
    content.Requirement { id = "any_nut" }
        :component_any {
            { id = "peanut_shelled", count = 1 },
            { id = "pine_nuts", count = 2 },
            { id = "pecan_shelled", count = 1 },
            { id = "pecan_roasted", count = 1 },
            { id = "cashews", count = 1 },
            { id = "pistachio_shelled", count = 1 },
            { id = "pistachio_roasted", count = 1 },
            { id = "almond_shelled", count = 1 },
            { id = "almond_roasted", count = 1 },
            { id = "beech_nuts", count = 1 },
            { id = "hickory_nut_shelled", count = 1 },
            { id = "hickory_nut_roasted", count = 1 },
            { id = "chestnut_shelled", count = 1 },
            { id = "chestnut_roasted", count = 1 },
            { id = "hazelnut_shelled", count = 1 },
            { id = "hazelnut_roasted", count = 1 },
            { id = "walnut_shelled", count = 1 },
            { id = "walnut_roasted", count = 1 },
            { id = "butternut_shelled", count = 1 },
            { id = "butternut_roasted", count = 1 },
            { id = "acorns_cooked", count = 1 },
            { id = "acorn_roasted", count = 1 },
            { id = "acorns_blanched", count = 1 },
            { id = "soy_nuts", count = 1 },
        }
)

-- All of the different bird eggs
content.merge_requirement(
    content.Requirement { id = "eggs_bird" }
        :component_any {
            { id = "egg_bird_unfert", count = 1 },
            { id = "egg_chicken", count = 1 },
            { id = "egg_grouse", count = 1 },
            { id = "egg_crow", count = 3 },
            { id = "egg_raven", count = 3 },
            { id = "egg_bluejay", count = 6 },
            { id = "egg_cardinal", count = 12 },
            { id = "egg_robin", count = 7 },
            { id = "egg_pigeon", count = 3 },
            { id = "egg_sparrow", count = 17 },
            { id = "egg_waxwing", count = 17 },
            { id = "egg_chickadee", count = 34 },
            { id = "egg_duck", count = 1 },
            { id = "egg_duck_domestic", count = 1 },
            { id = "egg_goose_canadian", count = 1 },
            { id = "egg_turkey", count = 1 },
            { id = "egg_turkey_domestic", count = 1 },
            { id = "egg_pheasant", count = 1 },
            { id = "egg_goose", count = 1 },
            { id = "egg_hummingbird", count = 100 },
            { id = "egg_woodpecker", count = 17 },
            { id = "egg_coot", count = 1 },
            { id = "egg_cormorant", count = 1 },
            { id = "egg_moorhen", count = 1 },
            { id = "egg_grebe", count = 1 },
            { id = "egg_guinea_fowl", count = 1 },
        }
)

-- All of the different reptile eggs
content.merge_requirement(
    content.Requirement { id = "eggs_reptile" }
        :component_any {
            { id = "egg_turtle_painted", count = 4 },
            { id = "egg_turtle_snapping_common", count = 4 },
            { id = "egg_wormsnake", count = 17 },
            { id = "egg_skink_fivelined", count = 17 },
        }
)

-- All of the different frog eggs
content.merge_requirement(
    content.Requirement { id = "eggs_frog" }
        :component_any {
            { id = "egg_leo_frog", count = 1 },
            { id = "egg_bullfrog_frog", count = 1 },
            { id = "egg_fowler_toad", count = 1 },
            { id = "egg_freedom_toad", count = 1 },
            { id = "egg_peeper_frog", count = 1 },
            { id = "egg_gray_frog", count = 1 },
            { id = "egg_mink_frog", count = 1 },
            { id = "egg_pickerel_frog", count = 1 },
            { id = "egg_green_frog", count = 1 },
            { id = "egg_wood_frog", count = 1 },
            { id = "egg_spade_frog", count = 1 },
        }
)

-- All of the different invertebrate eggs
content.merge_requirement(
    content.Requirement { id = "eggs_invert" }
        :component_any {
            { id = "eggs_insect", count = 1, requirement = true },
            { id = "eggs_spider", count = 4, requirement = true },
            { id = "egg_worm", count = 1 },
            { id = "egg_snail", count = 4 },
            { id = "egg_slug", count = 4 },
        }
)

-- All of the different insect eggs
content.merge_requirement(
    content.Requirement { id = "eggs_insect" }
        :component_any {
            { id = "ant_egg", count = 1 },
            { id = "ant_egg_acid", count = 1 },
            { id = "egg_roach", count = 4 },
            { id = "egg_roach_plague", count = 4 },
            { id = "egg_locust", count = 4 },
            { id = "egg_dragonfly", count = 4 },
            { id = "egg_firefly", count = 4 },
            { id = "egg_centipede", count = 2 },
            { id = "egg_wasp", count = 4 },
            { id = "egg_antlion", count = 2 },
            { id = "egg_strider", count = 4 },
            { id = "egg_grasshopper", count = 4 },
            { id = "egg_lady_bug", count = 4 },
            { id = "egg_mole_cricket", count = 4 },
            { id = "egg_mantis", count = 1 },
            { id = "egg_stag_beetle", count = 1 },
            { id = "egg_water_beetle", count = 4 },
            { id = "egg_water_bug", count = 4 },
            { id = "egg_butterfly", count = 4 },
            { id = "egg_moth", count = 4 },
            { id = "egg_cicada", count = 4 },
            { id = "egg_fly", count = 4 },
            { id = "egg_mosquito", count = 4 },
            { id = "egg_moth_fly", count = 4 },
            { id = "egg_silverfish", count = 4 },
            { id = "egg_centipede_house", count = 4 },
        }
)

-- All of the different spider eggs
content.merge_requirement(
    content.Requirement { id = "eggs_spider" }
        :component_any {
            { id = "egg_spider_cellar", count = 1 },
            { id = "egg_spider_jumping", count = 1 },
            { id = "egg_spider_trapdoor", count = 1 },
            { id = "egg_spider_web", count = 1 },
            { id = "egg_spider_widow", count = 1 },
            { id = "egg_spider_wolf", count = 1 },
        }
)

-- All of the different fish eggs
content.merge_requirement(
    content.Requirement { id = "eggs_roe" }
        :component_any {
            { id = "egg_fish", count = 1 },
            { id = "egg_brown_trout", count = 1 },
            { id = "egg_brook_trout", count = 1 },
            { id = "egg_lake_trout", count = 1 },
            { id = "egg_rainbow_trout", count = 1 },
            { id = "egg_salmon", count = 1 },
            { id = "egg_kokanee_salmon", count = 1 },
            { id = "egg_whitefish", count = 1 },
            { id = "egg_whitefish_round", count = 1 },
            { id = "egg_lbass", count = 1 },
            { id = "egg_sbass", count = 1 },
            { id = "egg_pbass", count = 1 },
            { id = "egg_perch", count = 1 },
            { id = "egg_walleye", count = 1 },
            { id = "egg_warmouth", count = 1 },
            { id = "egg_sunfish", count = 1 },
            { id = "egg_pumpkinseed", count = 1 },
            { id = "egg_bluegill", count = 1 },
            { id = "egg_redbreast", count = 1 },
            { id = "egg_green_sunfish", count = 1 },
            { id = "egg_rock_bass", count = 1 },
            { id = "egg_calico_bass", count = 1 },
            { id = "egg_bullhead", count = 1 },
            { id = "egg_bullhead_yellow", count = 1 },
            { id = "egg_channel_catfish", count = 1 },
            { id = "egg_white_catfish", count = 1 },
            { id = "egg_pike", count = 1 },
            { id = "egg_pickerel", count = 1 },
            { id = "egg_pickerel_american", count = 1 },
            { id = "egg_muskellunge", count = 1 },
            { id = "egg_white_sucker", count = 1 },
            { id = "egg_carp", count = 1 },
            { id = "egg_grass_carp", count = 1 },
            { id = "egg_goldfish", count = 1 },
            { id = "egg_bowfin", count = 1 },
            { id = "egg_burbot", count = 1 },
            { id = "egg_sturgeon_lake", count = 1 },
            { id = "egg_sturgeon_shortnose", count = 1 },
            { id = "egg_fallfish", count = 1 },
            { id = "egg_cod", count = 1 },
            { id = "egg_haddock", count = 1 },
            { id = "egg_bluefin_tuna", count = 1 },
            { id = "egg_halibut", count = 1 },
            { id = "egg_pollock", count = 1 },
            { id = "egg_flounder", count = 1 },
            { id = "egg_mackerel", count = 1 },
            { id = "egg_bluefish", count = 1 },
            { id = "egg_blackfish", count = 1 },
            { id = "egg_porgy", count = 1 },
        }
)

-- When we only need the nutrition of eggs and don't care about their shape. About 0.05L 
content.merge_requirement(
    content.Requirement { id = "eggs_any_shape" }
        :component_any {
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "rehydrated_eggs", count = 1 },
            { id = "eggs_reptile", count = 1, requirement = true },
        }
)

-- Pasteurized milk, including reconstituted
content.merge_requirement(
    content.Requirement { id = "milk_standard" }
        :component_any {
            { id = "milk", count = 1 },
            { id = "milk_reconstituted", count = 1 },
            { id = "milk_UHT", count = 1 },
        }
)

-- Any cheese you could use as is
content.merge_requirement(
    content.Requirement { id = "cheese_standard" }
        :component_any {
            { id = "cheese", count = 1 },
            { id = "cheese_hard", count = 1 },
            { id = "can_cheese", count = 1 },
            { id = "cheese_rehydrated", count = 1 },
            { id = "cottage_cheese", count = 1 },
            { id = "mozzarella_cheese", count = 1 },
            { id = "mozzarella_cheese_smoked", count = 1 },
            { id = "mascarpone", count = 1 },
            { id = "pecorino_cheese", count = 1 },
        }
)

-- Any kind of lactose-free plant-based milk. Not for use in fermentation recipes.
content.merge_requirement(
    content.Requirement { id = "lf_milk_standard" }
        :component_any {
            { id = "soy_milk", count = 1 },
            { id = "almond_milk", count = 1 },
            { id = "oat_milk", count = 1 },
            { id = "hazelnut_milk", count = 1 },
            { id = "walnut_milk", count = 1 },
        }
)

-- Frosting for cakes and treats
content.merge_requirement(
    content.Requirement { id = "any_frosting" }
        :component_any {
            { id = "buttercream", count = 2 },
            { id = "milk_cream_whipped", count = 2 },
        }
)

-- Butter of all types and other future butter substitutes
content.merge_requirement(
    content.Requirement { id = "any_butter" }
        :component_any {
            { id = "raw_butter", count = 1 },
            { id = "butter", count = 1 },
            { id = "ghee", count = 1 },
        }
)

-- Equivalent to milk_standard, with addition of raw milk for recipes using a heat source to kill microbes
content.merge_requirement(
    content.Requirement { id = "milk_standard_raw" }
        :component_any {
            { id = "milk_standard", count = 1, requirement = true },
            { id = "milk_raw", count = 1 },
        }
)

-- Equivalent to milk_standard_raw, but without milk_reconstituted
content.merge_requirement(
    content.Requirement { id = "milk_standard_raw_fresh" }
        :component_any {
            { id = "milk", count = 1 },
            { id = "milk_UHT", count = 1 },
            { id = "milk_raw", count = 1 },
        }
)

--   Only powdered sugar
content.merge_requirement(
    content.Requirement { id = "sugar_powdered" }
        :component_any {
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 },
        }
)

-- One unit provides ~200kcal; chosen to match one unit of molasses
content.merge_requirement(
    content.Requirement { id = "sugar_standard" }
        :component_any {
            { id = "sugar", count = 10 },
            { id = "syrup", count = 4 },
            { id = "syrup_corn", count = 3 },
            { id = "syrup_simple", count = 6 },
            { id = "beet_syrup", count = 6 },
            { id = "molasses", count = 1 },
            { id = "honey_bottled", count = 3 },
            { id = "honey_glassed", count = 1 },
            { id = "sweet_water", count = 1 },
            { id = "honeydew", count = 3 },
            { id = "artificial_sweetener", count = 10 },
        }
)

-- About a little more than half of standard
content.merge_requirement(
    content.Requirement { id = "sugar_standard_half" }
        :component_any {
            { id = "sugar", count = 6 },
            { id = "syrup", count = 2 },
            { id = "syrup_corn", count = 2 },
            { id = "syrup_simple", count = 3 },
            { id = "beet_syrup", count = 3 },
            { id = "honey_bottled", count = 2 },
            { id = "honeydew", count = 2 },
            { id = "artificial_sweetener", count = 6 },
        }
)

-- Any kind of whiskey.
content.merge_requirement(
    content.Requirement { id = "whiskey_any" }
        :component_any {
            { id = "whiskey", count = 1 },
            { id = "single_malt_whiskey", count = 1 },
            { id = "single_pot_whiskey", count = 1 },
            { id = "cheap_whiskey", count = 1 },
            { id = "canadian_whiskey", count = 1 },
        }
)

-- Technical artifact to support mixed alcohol recipe. See comment on `hard_liquor` below for semantics.
content.merge_requirement(
    content.Requirement { id = "hard_liquor_unmixed" }
        :component_any {
            { id = "brandy", count = 1 },
            { id = "gin", count = 1 },
            { id = "moonshine", count = 1 },
            { id = "rum", count = 1 },
            { id = "tequila", count = 1 },
            { id = "vodka", count = 1 },
            { id = "triple_sec", count = 1 },
            { id = "whiskey_any", count = 1, requirement = true },
        }
)

-- Hard liquor - necessarily comestible and high proof, not necessarily high quality. 7 portions per 250ml
content.merge_requirement(
    content.Requirement { id = "hard_liquor" }
        :component_any {
            { id = "hard_liquor_unmixed", count = 1, requirement = true },
            { id = "mixed_alcohol_strong", count = 1 },
        }
)

-- Cheap and improvised wines.
content.merge_requirement(
    content.Requirement { id = "cheap_wine" }
        :component_any {
            { id = "bum_wine", count = 1 },
            { id = "burdock_wine", count = 1 },
            { id = "dandelion_wine", count = 1 },
            { id = "fruit_wine", count = 1 },
            { id = "pine_wine", count = 1 },
            { id = "wine_barley", count = 1 },
        }
)

-- More expensive wines.
content.merge_requirement(
    content.Requirement { id = "worthy_wine" }
        :component_any {
            { id = "bristol_sherry", count = 1 },
            { id = "madeira", count = 1 },
            { id = "sherry", count = 1 },
            { id = "wine_cabernet", count = 1 },
            { id = "wine_chardonnay", count = 1 },
            { id = "wine_marsala", count = 1 },
            { id = "wine_noir", count = 1 },
            { id = "wine_riesling", count = 1 },
            { id = "wine_vermouth", count = 1 },
        }
)

-- Hard liquor and ethanol - Must be diluted. Added for ease of use
content.merge_requirement(
    content.Requirement { id = "hard_liquor_chem" }
        :component_any {
            { id = "hard_liquor", count = 7, requirement = true },
            { id = "chem_ethanol", count = 125 },
        }
)

-- Hard liquor, ethanol, and denaturalized alcohol - Do not use in comestibles
content.merge_requirement(
    content.Requirement { id = "hard_liquor_toxic" }
        :component_any {
            { id = "hard_liquor_chem", count = 1, requirement = true },
            { id = "denat_alcohol", count = 125 },
        }
)

-- Anything you might consider offal or intestines.
content.merge_requirement(
    content.Requirement { id = "meat_offal" }
        :component_any {
            { id = "meat_heart", count = 4, requirement = true },
            { id = "meat_lung", count = 4, requirement = true },
            { id = "meat_liver", count = 4, requirement = true },
            { id = "meat_kidney", count = 4, requirement = true },
            { id = "sweetbread", count = 4 },
            { id = "human_sweetbread", count = 4 },
            { id = "demihuman_sweetbread", count = 4 },
            { id = "offal", count = 1 },
            { id = "mutant_bug_organs", count = 1 },
        }
)

-- A whole slab of raw, red meat.  Substitutes pork and beef, but not chicken, in common recipes.
content.merge_requirement(
    content.Requirement { id = "meat_red_raw_steak" }
        :component_any {
            { id = "meat", count = 1 },
            { id = "mutant_meat", count = 1 },
            { id = "human_flesh", count = 1 },
            { id = "mutant_human_flesh", count = 1 },
            { id = "demihuman_flesh", count = 1 },
        }
)

-- An unbroken slab of raw meat including poultry.  For when scraps aren't good enough.
content.merge_requirement(
    content.Requirement { id = "meat_raw_steak" }
        :component_any {
            { id = "meat_red_raw_steak", count = 1, requirement = true },
            { id = "poultry", count = 1 },
        }
)

-- Anything you might consider raw, unpreserved 'red' meat that can begin the curing process.  About 250mL of meat.
content.merge_requirement(
    content.Requirement { id = "meat_red_raw_curable" }
        :component_any {
            { id = "meat_red_raw_steak", count = 1, requirement = true },
            { id = "meat_scrap", count = 10 },
            { id = "human_meat_scrap", count = 10 },
            { id = "demihuman_meat_scrap", count = 10 },
            { id = "mutant_meat_scrap", count = 10 },
            { id = "porkbelly", count = 1 },
        }
)

-- Anything you might consider raw, unpreserved 'red' meat.  Washed cured meat can be cooked normally, but cannot be cured again.  About 250mL of meat.
content.merge_requirement(
    content.Requirement { id = "meat_red_raw" }
        :component_any {
            { id = "meat_red_raw_curable", count = 1, requirement = true },
            { id = "washed_cured_meat", count = 1 },
        }
)

-- Anything you might consider raw 'red' meat.  About 250mL of meat.
content.merge_requirement(
    content.Requirement { id = "meat_red" }
        :component_any {
            { id = "meat_red_raw", count = 1, requirement = true },
            { id = "rehydrated_meat", count = 1 },
            { id = "meat_canned", count = 1 },
        }
)

-- Anything you might consider raw lung.  About 250mL of lungs.
content.merge_requirement(
    content.Requirement { id = "meat_lung" }
        :component_any {
            { id = "lung", count = 1 },
            { id = "human_lung", count = 1 },
            { id = "demihuman_lung", count = 1 },
            { id = "mutant_bug_lungs", count = 1 },
            { id = "mutant_lung", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_heart" }
        :component_any {
            { id = "heart", count = 1 },
            { id = "human_heart", count = 1 },
            { id = "demihuman_heart", count = 1 },
            { id = "mutant_heart", count = 1 },
            { id = "mutant_human_heart", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_liver" }
        :component_any {
            { id = "liver", count = 1 },
            { id = "human_liver", count = 1 },
            { id = "demihuman_liver", count = 1 },
            { id = "canned_liver", count = 1 },
            { id = "mutant_liver", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_kidney" }
        :component_any {
            { id = "kidney", count = 1 },
            { id = "human_kidney", count = 1 },
            { id = "demihuman_kidney", count = 1 },
            { id = "mutant_kidney", count = 1 },
        }
)

-- Anything resembling brains and other nervous tissue.
content.merge_requirement(
    content.Requirement { id = "meat_brain" }
        :component_any {
            { id = "brain", count = 1 },
            { id = "human_brain", count = 1 },
            { id = "demihuman_brain", count = 1 },
            { id = "mutant_brain", count = 1 },
        }
)

-- Anything you might consider a raw stomach.  About 500mL of stomachs.
content.merge_requirement(
    content.Requirement { id = "meat_stomach" }
        :component_any {
            { id = "meat_stomach_small", count = 2, requirement = true },
            { id = "meat_stomach_large", count = 1, requirement = true },
        }
)

-- Anything you might consider a cooked stomach.  About 500mL of stomachs.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_cooked" }
        :component_any {
            { id = "meat_stomach_small", count = 2, requirement = true },
            { id = "meat_stomach_large", count = 1, requirement = true },
        }
)

-- Anything you might consider a boiled stomach.  About 500mL of stomachs.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_boiled" }
        :component_any {
            { id = "small_stomach_boiled", count = 2 },
            { id = "stomach_boiled", count = 1 },
            { id = "small_hstomach_boiled", count = 2 },
            { id = "hstomach_boiled", count = 1 },
            { id = "small_demihuman_stomach_boiled", count = 2 },
            { id = "demihuman_stomach_boiled", count = 1 },
        }
)

-- Anything you might consider a small raw stomach.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_large" }
        :component_any {
            { id = "stomach_large", count = 1 },
            { id = "hstomach_large", count = 1 },
            { id = "demihuman_stomach_large", count = 1 },
        }
)

-- Anything you might consider a small raw stomach.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_small" }
        :component_any {
            { id = "stomach", count = 1 },
            { id = "hstomach", count = 1 },
            { id = "demihuman_stomach", count = 1 },
        }
)

-- multifarious cracklins
content.merge_requirement(
    content.Requirement { id = "any_cracklins" }
        :component_any {
            { id = "cracklins", count = 1 },
            { id = "human_cracklins", count = 1 },
            { id = "mutant_cracklins", count = 1 },
            { id = "mutant_human_cracklins", count = 1 },
            { id = "demihuman_cracklins", count = 1 },
        }
)

-- Any type of edible bone marrow.
content.merge_requirement(
    content.Requirement { id = "edible_bonemarrow" }
        :component_any {
            { id = "bone_marrow", count = 1 },
            { id = "human_marrow", count = 1 },
            { id = "demihuman_marrow", count = 1 },
            { id = "mutant_marrow", count = 1 },
            { id = "mutant_human_marrow", count = 1 },
        }
)

-- Any type of raw meat except for fish.  About 300-400kcal of meat.
content.merge_requirement(
    content.Requirement { id = "meat_nofish" }
        :component_any {
            { id = "meat_red", count = 1, requirement = true },
            { id = "meat_offal", count = 1, requirement = true },
            { id = "can_spam", count = 2 },
            { id = "lunchmeat", count = 2 },
            { id = "can_chicken", count = 1 },
            { id = "poultry_raw_any", count = 2, requirement = true },
        }
)

-- cooked red meat.
content.merge_requirement(
    content.Requirement { id = "meat_red_cooked" }
        :component_any {
            { id = "meat_cooked", count = 1 },
            { id = "meat_fatty_cooked", count = 1 },
            { id = "meat_scrap_cooked", count = 10 },
            { id = "mutant_meat_cooked", count = 1 },
            { id = "mutant_meat_scrap_cooked", count = 10 },
            { id = "human_cooked", count = 1 },
            { id = "mutant_human_cooked", count = 1 },
            { id = "demihuman_cooked", count = 1 },
            { id = "meat_pickled", count = 1 },
            { id = "meat_smoked", count = 1 },
            { id = "meat_salted", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "rehydrated_meat", count = 1 },
            { id = "cooked_cured_meat", count = 1 },
            { id = "jerky", count = 1 },
            { id = "bacon", count = 2 },
            { id = "lunchmeat", count = 2 },
            { id = "bologna", count = 2 },
            { id = "can_spam", count = 2 },
            { id = "fried_spam", count = 2 },
            { id = "meat_canned", count = 1 },
            { id = "meat_aspic", count = 1 },
            { id = "sausage", count = 1 },
            { id = "sausage_cooked", count = 1 },
            { id = "sausage_wasteland", count = 1 },
            { id = "bratwurst_sausage", count = 1 },
            { id = "meat_fried", count = 1 },
        }
)

-- Cooked red meat that fits two portions to a standard vacuum bag.  Excludes canned, dehydrated, and already vacuum-packed meat.
content.merge_requirement(
    content.Requirement { id = "meat_vacuum_packable" }
        :component_any {
            { id = "meat_cooked", count = 1 },
            { id = "meat_fatty_cooked", count = 1 },
            { id = "meat_scrap_cooked", count = 10 },
            { id = "mutant_meat_cooked", count = 1 },
            { id = "mutant_meat_scrap_cooked", count = 10 },
            { id = "human_cooked", count = 1 },
            { id = "mutant_human_cooked", count = 1 },
            { id = "demihuman_cooked", count = 1 },
            { id = "meat_pickled", count = 1 },
            { id = "meat_smoked", count = 1 },
            { id = "rehydrated_meat", count = 1 },
            { id = "cooked_cured_meat", count = 1 },
            { id = "meat_fried", count = 1 },
        }
)

-- meat you'd put on a sandwich
content.merge_requirement(
    content.Requirement { id = "meat_cooked" }
        :component_any {
            { id = "meat_red_cooked", count = 1, requirement = true },
            { id = "any_cracklins", count = 2, requirement = true },
            { id = "earthworm_dried", count = 10 },
            { id = "can_chicken", count = 1 },
            { id = "fish_cooked", count = 1 },
            { id = "fish_scrap_cooked", count = 10 },
            { id = "fish_smoked", count = 1 },
            { id = "lobster_cooked", count = 1 },
            { id = "lobster_smoked", count = 1 },
            { id = "can_herring", count = 1 },
            { id = "can_salmon", count = 1 },
            { id = "can_tuna", count = 1 },
            { id = "can_sardine", count = 1 },
            { id = "can_clams", count = 1 },
            { id = "salted_fish", count = 1 },
            { id = "fish_canned", count = 1 },
            { id = "fish_pickled", count = 1 },
            { id = "lobster_canned", count = 1 },
            { id = "poultry_cooked", count = 1 },
            { id = "poultry_pepper", count = 1 },
            { id = "poultry_smoked", count = 1 },
        }
)

-- Raw meat that non-cannibals would be unhappy eating.
content.merge_requirement(
    content.Requirement { id = "human_meat" }
        :component_any {
            { id = "human_flesh", count = 1 },
            { id = "mutant_human_flesh", count = 1 },
        }
)

-- Cooked meat that non-cannibals would be unhappy eating.
content.merge_requirement(
    content.Requirement { id = "human_meat_cooked" }
        :component_any {
            { id = "human_cooked", count = 1 },
            { id = "mutant_human_cooked", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_soup_ingredients" }
        :component_any {
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 },
            { id = "broth_meat", count = 2 },
        }
        :component_any {
            { id = "veggy_potatolike", count = 1, requirement = true },
            { id = "celery", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "radish_taproot", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "acorns_processed_any", count = 1, requirement = true },
            { id = "dry_lentils", count = 1 },
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "oats", count = 1 },
            { id = "oatmeal", count = 1 },
        }
        :component_any {
            { id = "meat_red", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "poultry_raw_any", count = 1, requirement = true },
            { id = "poultry_smoked", count = 1 },
            { id = "dry_poultry", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "fish_soup_ingredients" }
        :component_any {
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 },
            { id = "broth_meat", count = 2 },
        }
        :component_any {
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 },
            { id = "veggy_any", count = 1, requirement = true },
            { id = "sauerkraut", count = 1 },
            { id = "can_corn", count = 1 },
            { id = "hominy", count = 1 },
            { id = "dry_veggy", count = 1 },
            { id = "dry_corn", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "flatbread", count = 1 },
            { id = "tortilla_corn", count = 1 },
            { id = "bread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "biscuit", count = 1 },
            { id = "hardtack", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "sourdough_bread", count = 1 },
            { id = "hallula", count = 1 },
            { id = "brioche", count = 1 },
            { id = "flour", count = 2 },
            { id = "cornmeal", count = 2 },
            { id = "milk_powder", count = 1 },
            { id = "crackers", count = 1 },
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "mushroom", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "acorns_processed_any", count = 1, requirement = true },
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "oats", count = 1 },
            { id = "oatmeal", count = 1 },
        }
        :component_any {
            { id = "fish", count = 2 },
            { id = "dry_fish", count = 2 },
            { id = "fish_smoked", count = 2 },
            { id = "fish_pickled", count = 2 },
            { id = "salted_fish", count = 2 },
            { id = "fish_canned", count = 2 },
            { id = "can_salmon", count = 2 },
            { id = "fish_scrap", count = 10 },
            { id = "can_tuna", count = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "lobster_stew_ingredients" }
        :component_any {
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 },
        }
        :component_any {
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 },
            { id = "veggy_any", count = 1, requirement = true },
            { id = "sauerkraut", count = 1 },
            { id = "can_corn", count = 1 },
            { id = "hominy", count = 1 },
            { id = "dry_veggy", count = 1 },
            { id = "dry_corn", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "flatbread", count = 1 },
            { id = "tortilla_corn", count = 1 },
            { id = "bread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "biscuit", count = 1 },
            { id = "hardtack", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "sourdough_bread", count = 1 },
            { id = "brioche", count = 1 },
            { id = "hallula", count = 1 },
            { id = "flour", count = 2 },
            { id = "cornmeal", count = 2 },
            { id = "milk_powder", count = 1 },
            { id = "crackers", count = 1 },
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "mushroom", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "acorns_processed_any", count = 1, requirement = true },
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "oats", count = 1 },
            { id = "oatmeal", count = 1 },
        }
        :component_any {
            { id = "lobster", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "lobster_smoked", count = 2 },
            { id = "lobster_canned", count = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "woods_soup_ingredients" }
        :component_any {
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 },
            { id = "broth_meat", count = 2 },
            { id = "pine_tea", count = 2 },
        }
        :component_any {
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "poultry_cooked_any", count = 1, requirement = true },
            { id = "bacon", count = 4 },
            { id = "bologna", count = 5 },
            { id = "meat_pickled", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "jerky", count = 1 },
            { id = "meat_smoked", count = 1 },
            { id = "earthworm_dried", count = 10 },
            { id = "meat_salted", count = 1 },
            { id = "meat_fried", count = 1 },
            { id = "fish", count = 1 },
            { id = "fish_smoked", count = 1 },
            { id = "dry_fish", count = 1 },
            { id = "rehydrated_fish", count = 1 },
            { id = "fish_canned", count = 1 },
            { id = "can_salmon", count = 1 },
            { id = "can_tuna", count = 1 },
            { id = "lobster", count = 1 },
            { id = "dry_lobster", count = 1 },
            { id = "lobster_smoked", count = 1 },
            { id = "lobster_canned", count = 1 },
            { id = "sausage", count = 1 },
            { id = "sausage_cooked", count = 1 },
            { id = "bratwurst_sausage", count = 1 },
        }
        :component_any {
            { id = "veggy_wild", count = 2 },
            { id = "veggy", count = 2 },
            { id = "corn_kernels", count = 2 },
            { id = "rehydrated_veggy", count = 2 },
            { id = "rehydrated_corn_kernels", count = 2 },
            { id = "dry_veggy", count = 2 },
            { id = "dry_corn", count = 2 },
            { id = "dry_beans", count = 2 },
            { id = "can_beans", count = 2 },
            { id = "raw_beans", count = 2 },
            { id = "beans_cooked", count = 2 },
            { id = "dry_lentils", count = 2 },
            { id = "dry_rice", count = 2 },
            { id = "dry_wild_rice", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 },
            { id = "mushroom_cooked", count = 2 },
            { id = "morel_cooked", count = 2 },
            { id = "acorns_processed_any", count = 2, requirement = true },
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "oats", count = 1 },
            { id = "oatmeal", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "woods_soup_ingredients_veggy" }
        :component_any {
            { id = "broth", count = 1 },
            { id = "broth_bone", count = 1 },
            { id = "broth_meat", count = 1 },
            { id = "pine_tea", count = 1 },
        }
        :component_any {
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
        }
        :component_any {
            { id = "veggy_wild", count = 1 },
            { id = "veggy", count = 1 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "dry_veggy", count = 1 },
            { id = "dry_corn", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "mushroom", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "acorns_processed_any", count = 1, requirement = true },
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "oats", count = 1 },
            { id = "oatmeal", count = 1 },
        }
)

-- Any type of raw fat.
content.merge_requirement(
    content.Requirement { id = "any_fat" }
        :component_any {
            { id = "edible_fat", count = 1, requirement = true },
            { id = "fat_tainted", count = 1 },
        }
)

-- Any type of edible raw fat.
content.merge_requirement(
    content.Requirement { id = "edible_fat" }
        :component_any {
            { id = "fat", count = 1 },
            { id = "mutant_fat", count = 1 },
            { id = "human_fat", count = 1 },
            { id = "mutant_human_fat", count = 1 },
            { id = "demihuman_fat", count = 1 },
        }
)

-- Any type of edible tallow.
content.merge_requirement(
    content.Requirement { id = "edible_tallow" }
        :component_any {
            { id = "tallow", count = 1 },
            { id = "mutant_tallow", count = 1 },
            { id = "human_tallow", count = 1 },
            { id = "mutant_human_tallow", count = 1 },
            { id = "demihuman_tallow", count = 1 },
        }
)

-- Any type of tallow.
content.merge_requirement(
    content.Requirement { id = "any_tallow" }
        :component_any {
            { id = "edible_tallow", count = 1, requirement = true },
            { id = "tallow_tainted", count = 1 },
        }
)

-- Any type of edible blood.
content.merge_requirement(
    content.Requirement { id = "edible_blood" }
        :component_any {
            { id = "animal_blood", count = 1 },
            { id = "mutant_blood", count = 1 },
            { id = "blood", count = 1 },
            { id = "mutant_human_blood", count = 1 },
            { id = "demihuman_blood", count = 1 },
        }
)

-- Any type of blood.
content.merge_requirement(
    content.Requirement { id = "any_blood" }
        :component_any {
            { id = "edible_blood", count = 1, requirement = true },
            { id = "blood_tainted", count = 1 },
            { id = "blood_tainted_human", count = 1 },
        }
)

-- For when a recipe calls for either cooking oil or butter, like many baking recipes do.
content.merge_requirement(
    content.Requirement { id = "any_butter_or_oil" }
        :component_any {
            { id = "cooking_oil", count = 1 },
            { id = "edible_tallow", count = 1, requirement = true },
            { id = "raw_butter", count = 1 },
            { id = "butter", count = 1 },
            { id = "ghee", count = 1 },
        }
)

-- For when a recipe calls for deep frying, and the food absorbs some oil. Clarified butter or ghee can be used to deep fry, but butter's smoke point is too low without clarification
content.merge_requirement(
    content.Requirement { id = "fry_oil" }
        :component_any {
            { id = "cooking_oil", count = 1 },
            { id = "edible_tallow", count = 1, requirement = true },
            { id = "ghee", count = 1 },
        }
)

-- Non-salt seasonings you might add to a dish to flavor it. Should be about a teaspoon, or smallest serving
content.merge_requirement(
    content.Requirement { id = "seasoning_mild" }
        :component_any {
            { id = "hot_sauce", count = 1 },
            { id = "pepper", count = 1 },
            { id = "spicebush_berries_smoked", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "seasoning_italian", count = 1 },
            { id = "wild_herbs", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_clove", count = 1 },
        }
)

--  Should be about a teaspoon, or smallest serving
content.merge_requirement(
    content.Requirement { id = "condiment" }
        :component_any {
            { id = "mayonnaise", count = 1 },
            { id = "mustard", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "hot_sauce", count = 1 },
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "butter", count = 1 },
            { id = "raw_butter", count = 1 },
        }
)

-- Salt-like ingredients that can be used to preserve foods
content.merge_requirement(
    content.Requirement { id = "salt_preservation" }
        :component_any {
            { id = "salt_water", count = 1 },
            { id = "saline", count = 1 },
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 2 },
            { id = "chem_saltpetre", count = 1 },
            { id = "chem_black_powder", count = 47 },
        }
)

-- Sweet, unprocessed fruit, roughly by mass.
content.merge_requirement(
    content.Requirement { id = "sweet_fruit_fresh" }
        :component_any {
            { id = "apple", count = 1 },
            { id = "apricot", count = 1 },
            { id = "banana", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "cherries", count = 1 },
            { id = "grapefruit", count = 1 },
            { id = "grapes", count = 1 },
            { id = "guayaba", count = 1 },
            { id = "kiwi", count = 2 },
            { id = "lulo", count = 2 },
            { id = "mango", count = 1 },
            { id = "maracuya", count = 1 },
            { id = "melon_chunks", count = 1 },
            { id = "orange", count = 1 },
            { id = "papaya", count = 1 },
            { id = "peach", count = 1 },
            { id = "pear", count = 1 },
            { id = "pumpkin_cut", count = 1 },
            { id = "pineapple_chunks", count = 1 },
            { id = "plums", count = 1 },
            { id = "pomegranate", count = 1 },
            { id = "raspberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "rose_hips_cut", count = 1 },
            { id = "wintergreen_berry", count = 4 },
            { id = "mayapple", count = 2 },
            { id = "m_stellatum_berries", count = 2 },
            { id = "strawberries", count = 1 },
            { id = "huckleberries", count = 1 },
            { id = "mulberries", count = 1 },
            { id = "elderberries", count = 1 },
            { id = "nannyberries", count = 1 },
            { id = "tupelo_fruit", count = 1 },
            { id = "hobbleberries", count = 1 },
            { id = "autumn_olive", count = 1 },
            { id = "watermelon_wedge", count = 1 },
        }
)

-- Sweet, unprocessed, roughly by mass.
content.merge_requirement(
    content.Requirement { id = "sweet_fruit" }
        :component("sweet_fruit_fresh", 1, true)
)

-- Similar to sweet_fruit, but allows processed fruit and vegetables that can pretend to be fruit.
content.merge_requirement(
    content.Requirement { id = "sweet_fruit_like" }
        :component_any {
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "lemon", count = 1 },
            { id = "apple_canned", count = 1 },
            { id = "apple_sugar", count = 1 },
            { id = "dry_fruit", count = 1 },
            { id = "can_peach", count = 1 },
            { id = "juice_pulp", count = 2 },
            { id = "rehydrated_fruit", count = 1 },
            { id = "rhubarb", count = 2 },
        }
)

-- Similar to sweet_fruit_like, but removes Juice_pulp to prevent infinte recycling.
content.merge_requirement(
    content.Requirement { id = "sweet_fruit_like_no_pulp" }
        :component_any {
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "lemon", count = 1 },
            { id = "apple_canned", count = 1 },
            { id = "apple_sugar", count = 1 },
            { id = "dry_fruit", count = 1 },
            { id = "can_peach", count = 1 },
            { id = "rehydrated_fruit", count = 1 },
            { id = "rhubarb", count = 2 },
        }
)

-- anything you would consider a leafy green vegetable
content.merge_requirement(
    content.Requirement { id = "veggy_green" }
        :component_any {
            { id = "cabbage", count = 1 },
            { id = "cattail_stalk", count = 1 },
            { id = "lettuce", count = 1 },
            { id = "horseradish_greens", count = 1 },
            { id = "raw_dandelion", count = 1 },
            { id = "raw_burdock", count = 1 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "veggy", count = 1 },
            { id = "veggy_wild", count = 1 },
            { id = "veggy_salted", count = 1 },
            { id = "spinach", count = 1 },
            { id = "sea_lettuce", count = 1 },
            { id = "bladderwrack", count = 1 },
            { id = "kelp_sugar", count = 1 },
            { id = "brussels_sprout", count = 1 },
            { id = "kale", count = 1 },
            { id = "cauliflower", count = 1 },
        }
)

-- Any edible tuber that can be used like potato
content.merge_requirement(
    content.Requirement { id = "veggy_potatolike" }
        :component_any {
            { id = "potato", count = 1 },
            { id = "groundnut_prepared", count = 5 },
        }
)

content.merge_requirement(
    content.Requirement { id = "veggy_any_corn_uncooked" }
        :component_any {
            { id = "corn", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "can_corn", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "veggy_any_uncooked" }
        :component_any {
            { id = "rehydrated_veggy", count = 1 },
            { id = "veggy_any_corn_uncooked", count = 1, requirement = true },
            { id = "veggy_any_fresh_uncooked", count = 1, requirement = true },
        }
)

content.merge_requirement(
    content.Requirement { id = "veggy_any_fresh_uncooked" }
        :component_any {
            { id = "broccoli", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "carrot", count = 2 },
            { id = "cattail_stalk", count = 1 },
            { id = "plant_stalk", count = 1 },
            { id = "celery", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "cucumber", count = 1 },
            { id = "cucumber_cut", count = 1 },
            { id = "gherkin_cut", count = 1 },
            { id = "gherkin", count = 1 },
            { id = "lettuce", count = 1 },
            { id = "onion", count = 1 },
            { id = "plant_sac", count = 1 },
            { id = "potato", count = 1 },
            { id = "pumpkin_cut", count = 1 },
            { id = "radish_taproot", count = 1 },
            { id = "raw_dandelion", count = 1 },
            { id = "raw_burdock", count = 1 },
            { id = "raw_bamboo", count = 1 },
            { id = "rhubarb", count = 1 },
            { id = "sugar_beet", count = 1 },
            { id = "tomato", count = 1 },
            { id = "tomato_cut", count = 1 },
            { id = "bell_pepper", count = 1 },
            { id = "bell_pepper_cut", count = 1 },
            { id = "veggy", count = 1 },
            { id = "veggy_wild", count = 1 },
            { id = "zucchini", count = 1 },
            { id = "zucchini_cut", count = 1 },
            { id = "eggplant_cut", count = 1 },
            { id = "raw_artichoke", count = 1 },
            { id = "artichoke_heart", count = 1 },
            { id = "raw_asparagus", count = 1 },
            { id = "carrot_wild", count = 1 },
            { id = "wild_garlic", count = 2 },
            { id = "brussels_sprout", count = 3 },
            { id = "spinach", count = 1 },
            { id = "japanese_knotweed_stem", count = 1 },
            { id = "any_cauliflower", count = 1, requirement = true },
            { id = "any_kale", count = 1, requirement = true },
            { id = "pea_pods", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "veggy_any" }
        :component_any {
            { id = "fiddlehead_boiled", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "salsify_baked", count = 1 },
            { id = "groundnut_prepared", count = 1 },
            { id = "veggy_any_uncooked", count = 1, requirement = true },
            { id = "veggy_canned", count = 1 },
            { id = "veggy_salted", count = 1 },
        }
)

-- Any form of tomato used in cooking
content.merge_requirement(
    content.Requirement { id = "any_tomato" }
        :component_any {
            { id = "tomato", count = 1 },
            { id = "tomato_cut", count = 1 },
            { id = "can_tomato", count = 1 },
        }
)

-- Any form of gherkin cucumber used in cooking
content.merge_requirement(
    content.Requirement { id = "any_gherkin_cucumber" }
        :component_any {
            { id = "gherkin", count = 1 },
            { id = "gherkin_cut", count = 1 },
        }
)

-- Any form of eggplant used in cooking
content.merge_requirement(
    content.Requirement { id = "any_eggplant" }
        :component_any {
            { id = "eggplant", count = 1 },
            { id = "eggplant_cut", count = 2 },
        }
)

-- Any form of artichoke used in cooking
content.merge_requirement(
    content.Requirement { id = "any_artichoke" }
        :component_any {
            { id = "raw_artichoke", count = 1 },
            { id = "artichoke_heart", count = 1 },
        }
)

-- Any form of asparagus used in cooking
content.merge_requirement(
    content.Requirement { id = "any_asparagus" }
        :component("raw_asparagus", 1)
)

-- Any form of brussels sprout used in cooking
content.merge_requirement(
    content.Requirement { id = "any_brussels_sprout" }
        :component("brussels_sprout", 3)
)

-- Any form of pea sprout used in cooking
content.merge_requirement(
    content.Requirement { id = "any_pea" }
        :component_any {
            { id = "pea_pods", count = 1 },
            { id = "pea", count = 5 },
        }
)

-- Any form of zucchini used in cooking
content.merge_requirement(
    content.Requirement { id = "any_zucchini" }
        :component_any {
            { id = "zucchini", count = 1 },
            { id = "zucchini_cut", count = 1 },
        }
)

-- Any form of salad cucumber used in cooking
content.merge_requirement(
    content.Requirement { id = "any_salad_cucumber" }
        :component_any {
            { id = "cucumber", count = 1 },
            { id = "cucumber_cut", count = 1 },
        }
)

-- Any form of bell pepper used in cooking
content.merge_requirement(
    content.Requirement { id = "any_bell_pepper" }
        :component_any {
            { id = "bell_pepper", count = 1 },
            { id = "bell_pepper_cut", count = 1 },
        }
)

-- Any form of chili pepper used in cooking
content.merge_requirement(
    content.Requirement { id = "any_chili_pepper" }
        :component_any {
            { id = "chili_pepper", count = 1 },
            { id = "chili_pepper_cut", count = 1 },
            { id = "rehydrated_chili", count = 1 },
        }
)

-- Any form of cauliflower used in cooking
content.merge_requirement(
    content.Requirement { id = "any_cauliflower" }
        :component_any {
            { id = "cauliflower", count = 5 },
            { id = "cauliflower_head", count = 1 },
        }
)

-- Any form of kale used in cooking
content.merge_requirement(
    content.Requirement { id = "any_kale" }
        :component_any {
            { id = "kale", count = 5 },
            { id = "kale_head", count = 1 },
        }
)

-- Any acorns processed to remove tannins and are now palatable, either wet or dry
content.merge_requirement(
    content.Requirement { id = "acorns_processed_any" }
        :component_any {
            { id = "acorns_cooked", count = 1 },
            { id = "acorn_roasted", count = 1 },
            { id = "acorns_blanched", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "mushroom_soup_ingredients" }
        :component("broth", 1)
        :component_any {
            { id = "mushroom", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "morel_cooked", count = 1 },
        }
        :component("flour", 1)
)

content.merge_requirement(
    content.Requirement { id = "broth_ingredients" }
        :component_any {
            { id = "veggy_any", count = 1, requirement = true },
            { id = "empty_corn_cob", count = 1 },
            { id = "corn", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "mushroom", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "kombu", count = 1 },
        }
        :component_any {
            { id = "hot_sauce", count = 1 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 8 },
            { id = "seasoning_salt", count = 4 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 4 },
            { id = "spicebush_berries_smoked", count = 4 },
            { id = "spicebush_berries", count = 4 },
            { id = "garlic_clove", count = 2 },
            { id = "salt", count = 4 },
        }
)

content.merge_requirement(
    content.Requirement { id = "broth_meat_ingredients" }
        :component_any {
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
        }
        :component_any {
            { id = "hot_sauce", count = 1 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 8 },
            { id = "seasoning_salt", count = 4 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 4 },
            { id = "spicebush_berries", count = 4 },
            { id = "spicebush_berries_smoked", count = 4 },
            { id = "garlic_clove", count = 2 },
            { id = "salt", count = 4 },
        }
)

content.merge_requirement(
    content.Requirement { id = "veggy_soup_ingredients" }
        :component("broth", 1)
        :component_any {
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 },
            { id = "celery", count = 1 },
            { id = "veggy_green", count = 1, requirement = true },
            { id = "veggy_potatolike", count = 1, requirement = true },
            { id = "sauerkraut", count = 1 },
            { id = "powder_eggs", count = 1 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "acorns_processed_any", count = 1, requirement = true },
            { id = "tofu", count = 1 },
            { id = "dry_tofu", count = 1 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 },
            { id = "dry_lentils", count = 1 },
        }
        :component("veggy_any", 1, true)
)

-- Wash liquor - needs to be concentrated
content.merge_requirement(
    content.Requirement { id = "wash_liquor" }
        :component_any {
            { id = "wash_vodka", count = 1 },
            { id = "wash_whiskey", count = 1 },
            { id = "wash_rum", count = 1 },
            { id = "wash_moonshine", count = 1 },
        }
)

-- Technical artifact to support mixed alcohol recipe. See `weak_liquor` comment below for semantics.
content.merge_requirement(
    content.Requirement { id = "weak_liquor_unmixed" }
        :component_any {
            { id = "cheap_wine", count = 5, requirement = true },
            { id = "worthy_wine", count = 5, requirement = true },
            { id = "beer", count = 1 },
            { id = "belgian_ale", count = 1 },
            { id = "bristol_sherry", count = 1 },
            { id = "drink_hard_seltzer", count = 1 },
            { id = "european_pilsner", count = 1 },
            { id = "hb_beer", count = 1 },
            { id = "hb_seltzer", count = 1 },
            { id = "imperial_stout", count = 1 },
            { id = "india_pale_ale", count = 1 },
            { id = "mead", count = 1 },
            { id = "hopped_mead", count = 1 },
            { id = "plain_mead", count = 1 },
            { id = "spiced_mead", count = 1 },
            { id = "pale_ale", count = 1 },
            { id = "stout", count = 1 },
        }
)

-- Weak liquor - necessarily comestible and low proof, not necessarily high quality. 250ml
content.merge_requirement(
    content.Requirement { id = "weak_liquor" }
        :component_any {
            { id = "weak_liquor_unmixed", count = 1, requirement = true },
            { id = "mixed_alcohol_weak", count = 1 },
        }
)

-- Soda's and such. Anything carbonated that isn't alcoholic or an energy drink.
content.merge_requirement(
    content.Requirement { id = "soda_pop" }
        :component_any {
            { id = "cola", count = 1 },
            { id = "creamsoda", count = 1 },
            { id = "crispycran", count = 1 },
            { id = "lemonlime", count = 1 },
            { id = "orangesoda", count = 1 },
            { id = "purple_drink", count = 1 },
            { id = "rootbeer", count = 1 },
            { id = "spezi", count = 1 },
        }
)

-- Group of diet sodas, do not add alcohol, non-diet soda, or energy drinks/things with stim
content.merge_requirement(
    content.Requirement { id = "soda_pop_diet" }
        :component_any {
            { id = "zerocola", count = 1 },
            { id = "zeroorange", count = 1 },
            { id = "zerotropical", count = 1 },
        }
)

-- Non-carbonated, sweet fruit based drinks.
content.merge_requirement(
    content.Requirement { id = "sweet_juice" }
        :component_any {
            { id = "oj", count = 1 },
            { id = "oj_fresh", count = 1 },
            { id = "lemonade", count = 1 },
            { id = "apple_cider", count = 1 },
            { id = "cranberry_juice", count = 1 },
            { id = "juice", count = 1 },
            { id = "juice_pasteurized", count = 1 },
            { id = "kompot", count = 1 },
        }
)

-- Small can, 250ml.
content.merge_requirement(
    content.Requirement { id = "small_cans" }
        :component_any {
            { id = "canister_empty", count = 1 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
        }
)

-- Flour, irrespective of whether it's wheat-free or wheat-full.
content.merge_requirement(
    content.Requirement { id = "flour_any" }
        :component_any {
            { id = "flour", count = 1 },
            { id = "flour_wheat_free", count = 1 },
            { id = "bread_flour", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "tortilla_any" }
        :component_any {
            { id = "tortilla_corn", count = 1 },
            { id = "tortilla_flour", count = 1 },
        }
)

-- Any bird meat, 1 chunk or 5 scraps
content.merge_requirement(
    content.Requirement { id = "poultry_raw_any" }
        :component_any {
            { id = "poultry", count = 1 },
            { id = "poultry_scrap", count = 5 },
        }
)

-- Cooked and ready to eat bird meat, 100ml
content.merge_requirement(
    content.Requirement { id = "poultry_cooked_any" }
        :component_any {
            { id = "poultry_cooked", count = 1 },
            { id = "poultry_scrap_cooked", count = 5 },
            { id = "poultry_pepper", count = 1 },
            { id = "poultry_scrap_pepper", count = 5 },
            { id = "poultry_smoked", count = 1 },
            { id = "can_chicken", count = 1 },
        }
)

-- requirements/cooking_tools.json

-- Heat usable for heating a surface - for example a pot, pan, dutch oven, etc.
-- Roughly 80% efficiency for a microwave or induction hotplate, 30-40% for gas/kerosene/alcohol/propane/acetylene, 20-25% for hexamine, 15-20% for an oven/charcoal, 50-60% for a regular electric cooker.  18% efficiency for improvised options like the toolkit or an arc welder.
-- esbit has 40kJ/u, kerosene/gasoline 34 kJ/u, biogas 5kJ/u, propane 25kJ/u, acetylene 50kJ/u, alcohol 20kJ/u. needs 2x total energy of induction.
-- charcoal/coal 31/u, but it is less efficient than other fossil fuels and is closer to an oven.  I'm treating the smoker as a big charcoal grill as far as efficiency is concerned.
-- Standards: 1 surface_heat - bake one unit of standard flour, process 2u of butter/oil, 1u of sugar_standard, cook a corn tortilla, process 100g of fruit.  2 surface_heats - cook a scrap of raw meat (30g), process milk in a recipe, apply a unit of 'batter' to a recipe, process 100g of veggy (treat very starchy stuff like potatoes, roots, cattails, as flour).
-- More Standards: 3 surface_heats: cook oatmeal. 4 surface_heats: cook beans, rice, or lentils, use cooked meat in a recipe, cook one unit of raw organs.  5 surface_heats: cook 1 unit of cornmeal or bread flour. 6u surface_heats: roast nuts, cook a chunk of tofu. 15u surface heat: process a chunk of fat or a unit of blood. 20u: cook a chunk of raw meat (300g)
-- Note that a lot of food is not cooked to boiling temperature.  As a result most comestibles that used surface_heat have been made clean water only because it is not sufficient to guarantee potability.
-- Ovens are terrible, this is intentional.  Typical oven uses 3x the wattage of a microwave, and bakes for often over 10x as long as the microwave does.  We cannot account for batch energy savings (multiple things in same oven) nor keeping the oven at temp (many kJ are wasted bringing it up to temp, unlike with a microwave) so efficiency is generously 0.2x that of microwave.
-- A good way to judge input needed is how many seconds it takes to microwave.  1kW is a good estimate for microwave power usage, and the ratios are relatively consistent between different foodstuffs.
content.merge_requirement(
    content.Requirement { id = "surface_heat", name = content.text("Heat source") }
        :tool_any {
            { id = "hotplate_induction", charges = 25 },
            { id = "microwave", charges = 25 },
            { id = "hotplate", charges = 35 },
            { id = "multi_cooker", charges = 35 },
            { id = "char_smoker", charges = 4 },
            { id = "charcoal_cooker", charges = 4 },
            { id = "oven_tool", charges = 125 },
            { id = "esbit_stove", charges = 2 },
            { id = "oil_cooker", charges = 2 },
            { id = "gasoline_cooker", charges = 2 },
            { id = "biogas_cooker", charges = 10 },
            { id = "propane_cooker", charges = 2 },
            { id = "acetylene_cooker", charges = 1 },
            { id = "popcan_stove", charges = 3 },
            { id = "fire", count = 1 },
            { id = "fake_solar_cooker", count = 1 },
        }
)

-- Power requirement to smoke 10g of food. Half the power cost of dehydrating, assuming smoking means halfway dehydrated. Can't be done electrically, obviously.
-- https://www.masterclass.com/articles/how-to-smoke-meat-with-a-charcoal-smoker - roughly 1 pound charcoal per 1 pound meat (and 1 hour).
-- https://firebrandbbq.com.au/2018/03/05/lighting-charcoal-bbq-heres-much-fuel-really-need/ also says 1:1 but that it can go as low as 1:2.
-- Survivor doesn't care too much about quality, the important part is that it gets preserved. It is 6.24 grams of charcoal per 10 grams of food presently.
-- 300g of meat would be 30u of this, which is about 187g of charcoal total (or 168g of coal) as an example.
content.merge_requirement(
    content.Requirement { id = "smoking_heat", name = content.text("Smoking heat") }
        :tool_charges("char_smoker", 6)
)

-- Power requirement to dehydrate 10g of food. Electric food dehydrators are about 30-35% efficient, which is by itself irrelevant but may eventually matter to compare other means of dehydrating.
-- Like above with smoking_heat, charcoal expenditure is much less efficient than just cooking something.  Since you are fully dehydrating rather than just smoking, double the cost of smoking_heat in charcoal.
-- Estimate given by dehydrating 3 lbs of bananas for 6 hours (https://www.freshoffthegrid.com/dehydrating-bananas/), 500w is about normal for a dehydrator. This might be different for meat, but I'm using the same values for any food at the moment.
-- 3lbs = 1634g, time = 0.5x60x60x6 = 10800kJ. 10800kJ/163.5(10s of grams) = ~66 kJ per 10-gram
content.merge_requirement(
    content.Requirement { id = "dehydrating_heat", name = content.text("Dehydrating heat") }
        :tool_any {
            { id = "dehydrator", charges = 66 },
            { id = "char_smoker", charges = 12 },
        }
)

-- Power requirement to seal one bag, 400w for 10 seconds.  Includes the bag.
-- Yes, they really are that cheap, vacuum sealers are trivial to operate.
-- Vacuum sealed bags are an ideal environment for botulinum growth, and they cannot be heated to 125c due to bag meltage.
-- Therefore, indefinite storage is impossible through this method, and as such vac bags are now only 50% instead of 0% spoilage.
-- It's likely doable to reseal an MRE bag using a sealer and the sterilize it and its contents with heat instead of radiation, though this is speculative.
content.merge_requirement(
    content.Requirement { id = "vacuum_sealing_standard", name = content.text("Vacuum sealer") }
        :component_any {
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 1 },
            { id = "plastic_bag_vac", count = 1 },
        }
        :tool_any {
            { id = "vac_sealer", charges = 4 },
            { id = "makeshift_sealer", charges = 8 },
        }
)

-- Oil usable for frying. Note: the oil is reusable.
content.merge_requirement(
    content.Requirement { id = "frying_oil", name = content.text("Frying oil") }
        :tool_any {
            { id = "cooking_oil", count = 1 },
            { id = "tallow", count = 1 },
            { id = "ghee", count = 1 },
        }
)

-- Tools usable for providing heat usable for boiling water, but not necessarily for anything else. This can use unclean water even for food recipes like boiled vegetables since it sterlizes the water.
-- Hypothetical maximum efficiency to clean 0.25L of water (one unit) is around 100kJ, to heat in a basement and boil for 1 minute. In theory boiling water in the middle of a summer afternoon should use less power, but we cannot model that (yet)
-- Roughly 75-80% efficiency for induction, 25-30% for gas/kerosene/alcohol/propane/acetylene, ~20% for hexamine, 50% for a regular electric cooker, 40% for microwave, 10% for oven/charcoal.
-- kerosene/gasoline 34 kJ/u, biogas 5kJ/u, propane 25kJ/u, acetylene 50kJ/u alcohol 20kJ/u. needs 400kJ total - 100kJ/0.25.
-- esbit has 40kJ/u, @ ~20% efficiency that's aboout 13u
-- charcoal/coal 50/u, it is less efficient than other fossil fuels  at ~15%.
-- note that while microwaves are great for cooking food they're not great for boiling water.  Convection in general is inefficient for this process, however induction (heats the pan itself through magnetic coils) excels.
-- for each unit of water add an additional count of this per 15 minutes the water is kept boiling.
content.merge_requirement(
    content.Requirement { id = "water_boiling_heat", name = content.text("Boiling heat") }
        :tool_any {
            { id = "coffeemaker", charges = 125 },
            { id = "hotplate_induction", charges = 125 },
            { id = "hotplate", charges = 200 },
            { id = "microwave", charges = 250 },
            { id = "multi_cooker", charges = 200 },
            { id = "char_smoker", charges = 30 },
            { id = "charcoal_cooker", charges = 30 },
            { id = "esbit_stove", charges = 13 },
            { id = "oil_cooker", charges = 12 },
            { id = "gasoline_cooker", charges = 12 },
            { id = "biogas_cooker", charges = 80 },
            { id = "propane_cooker", charges = 16 },
            { id = "acetylene_cooker", charges = 8 },
            { id = "popcan_stove", charges = 20 },
            { id = "fire", count = 1 },
            { id = "fake_solar_cooker", count = 1 },
        }
)

-- acidic additives to lower PH and prevent the growth of botulinum, for a 3L jar.
-- lemon is about 20-25% juice by weight. Formic acid is non toxic and can be safely ingested in dilute amounts.
-- Even many pressure canning recipes should require this for safety.
content.merge_requirement(
    content.Requirement { id = "canning_acid_large" }
        :component_any {
            { id = "chem_citric_acid", count = 6 },
            { id = "formic_acid", count = 2 },
            { id = "lemon", count = 1 },
            { id = "vinegar", count = 6 },
        }
)

-- acidic additives to lower PH and prevent the growth of botulinum.
-- Even many pressure canning recipes should require this for safety.
content.merge_requirement(
    content.Requirement { id = "canning_acid_small" }
        :component_any {
            { id = "chem_citric_acid", count = 1 },
            { id = "vinegar", count = 1 },
        }
)

-- This is sealing glass jars using the water bath method, using acid to neutralize botulinum instead of extreme heat.
-- For high-acid foods, such as many fruits, extreme heat is not necessary, since botulinum can't grow if PH is 4.6. immersing low acid foods in an acidic solution is typically also sufficient
-- Per its longest_side (13.2cm) a 0.5L jar is about 7cm wide.  Per its longest_side (29.8cm) a 3L jar is about 11cm wide.
-- water needs to fill above the jar about 3-6cm.  I'm assuming half this for the radius.  Therefore 0.5L jar is immersed in an 10x18cm cylinder, and 3L jar is immersed in a 15x35cm cylinder.
-- accounting for displacement that means about 2u water per 0.5L jar and 12u water per 3L jar.
-- using water_boiling_heat as a base, a minimum cost of 2u for the temp needed to heat the water, another 2u for the jar (specific heat is lower than water but jar will contain an aqueous solution so this is an estimate, though it takes about 15 minutes for water to come to temp again after adding jars so it should be accurate) as well as another 2u for the roughly 15 minutes to seal the jar, and another 2u to represent time lost due to inefficiency and heat bleed.
content.merge_requirement(
    content.Requirement { id = "canning_low_heat" }
        :tool_charges("water_boiling_heat", 10, true)
        :tool_any {
            { id = "pot_canning", count = 1 },
            { id = "pot_canning_clay", count = 1 },
        }
        :tool_any {
            { id = "water", charges = 2 },
            { id = "water_clean", charges = 2 },
        }
        :quality("CUT", 2, 1)
        :quality("COOK", 3, 1)
)

-- This is sealing glass jars using the water bath method, using extreme heat (125c) to neutralize botulinum, requires a pressure cooker to achieve such temperatures.
-- Needed for low-acid foods, such as meat and many veggies, which present suitable anerobic conditions for botulinum to grow in absence of low PH.
-- Per its longest_side (13.2cm) a 0.5L jar is about 7cm wide.  Per its longest_side (29.8cm) a 3L jar is about 11cm wide.
-- water needs to fill above the jar about 3-6cm.  I'm assuming half this for the radius.  Therefore 0.5L jar is immersed in an 10x18cm cylinder, and 3L jar is immersed in a 15x35cm cylinder.
-- accounting for displacement that means about 2u water per 0.5L jar and 12u water per 3L jar.
-- 50% more energy used compared to low_heat canning. A 0.5L jar of meat would take about 1875kJ to can in ideal circumstances, compare to 1000kJ to cook normally or 4800kJ to dehydrate.
content.merge_requirement(
    content.Requirement { id = "canning_high_heat" }
        :tool_charges("water_boiling_heat", 15, true)
        :tool_any {
            { id = "pressure_cooker", count = 1 },
            { id = "small_pressure_vessel", count = 1 },
            { id = "makeshift_pressure_cooker", count = 1 },
        }
        :tool_any {
            { id = "water", charges = 2 },
            { id = "water_clean", charges = 2 },
        }
        :quality("CUT", 2, 1)
        :quality("COOK", 3, 1)
)

-- this is being left as a fallback for any canning recipe which hasn't yet been converted to low or high heat.
content.merge_requirement(
    content.Requirement { id = "canning_standard" }
        :tool_charges("water_boiling_heat", 15, true)
        :tool_any {
            { id = "pot_canning", count = 1 },
            { id = "pot_canning_clay", count = 1 },
        }
)

-- Toolset required to seal a tin can.  Power costs of contents will need to reach 125c in order to kill botulinum, as usual.
-- The ingredients are packed into the tin can with water to ensure no air is left, then sealed, then pressure cooked. The steam pressure helps prevent the lid from bursting off, which might happen if you heated the can over a stove.
-- similar to pressure canning, although this is measured in 0.25L rather than 0.5L, and uses a bit less power because metal cans are more compact, more thermally conductive, and are already sealed.
-- treating a small tin can (0.25L) of water heated inside the bare minimum amount of water to encapsulate it, heated to 33% above boiling, for roughly 12u boiling per half_liter, lower than glass jar pressure canning.
content.merge_requirement(
    content.Requirement { id = "canning_metal" }
        :tool_charges("water_boiling_heat", 6, true)
        :tool_any {
            { id = "pressure_cooker", count = 1 },
            { id = "small_pressure_vessel", count = 1 },
            { id = "makeshift_pressure_cooker", count = 1 },
        }
        :tool_any {
            { id = "water", charges = 1 },
            { id = "water_clean", charges = 1 },
        }
        :tool("can_sealer", 1)
        :tool("tongs", 1)
        :quality("SAW_M", 1, 1)
        :quality("HAMMER", 2, 1)
        :quality("CUT", 2, 1)
        :quality("COOK", 3, 1)
)

-- Materials for a small (0.25L) tin can.
content.merge_requirement(
    content.Requirement { id = "tincan_small" }
        :component("scrap", 1)
        :component_any {
            { id = "canister_empty", count = 1 },
            { id = "can_food", count = 1 },
        }
)

-- Materials for a medium (0.5L) tin can.
content.merge_requirement(
    content.Requirement { id = "tincan_medium" }
        :component("scrap", 2)
        :component("can_medium", 1)
)

-- Materials for a large (3L) tin can.
content.merge_requirement(
    content.Requirement { id = "tincan_large" }
        :component_any {
            { id = "scrap", count = 5 },
            { id = "sheet_metal_small", count = 1 },
        }
        :component("can_food_big", 1)
)

-- requirements/explosives.json

-- This should contain all flammable liquids. 1 mL.
content.merge_requirement(
    content.Requirement { id = "flammable_liquid" }
        :component_any {
            { id = "gasoline", count = 1 },
            { id = "diesel", count = 1 },
            { id = "biodiesel", count = 1 },
            { id = "chem_ethanol", count = 1 },
            { id = "chem_methanol", count = 1 },
            { id = "ether", count = 1 },
            { id = "denat_alcohol", count = 1 },
            { id = "lamp_oil", count = 1 },
            { id = "motor_oil", count = 1 },
            { id = "jp8", count = 1 },
            { id = "avgas", count = 1 },
            { id = "chem_turpentine", count = 1 },
            { id = "camphine", count = 1 },
        }
)

-- This should contain all flammable liquids with a flash point below 30 degrees centigrade, such as for molotovs. 1 mL.
content.merge_requirement(
    content.Requirement { id = "accelerant_liquid" }
        :component_any {
            { id = "gasoline", count = 1 },
            { id = "chem_ethanol", count = 1 },
            { id = "chem_methanol", count = 1 },
            { id = "ether", count = 1 },
            { id = "denat_alcohol", count = 1 },
            { id = "avgas", count = 1 },
            { id = "chem_turpentine", count = 1 },
        }
)

-- This should contain all flammable liquids with a flash point above 30 degrees centigrade, 1 mL.
content.merge_requirement(
    content.Requirement { id = "fuel_liquid" }
        :component_any {
            { id = "diesel", count = 1 },
            { id = "biodiesel", count = 1 },
            { id = "lamp_oil", count = 1 },
            { id = "jp8", count = 1 },
            { id = "motor_oil", count = 1 },
            { id = "camphine", count = 1 },
        }
)

-- This should contain all the explosives you can set off with only a fuse, 10g tnt equivalent.
content.merge_requirement(
    content.Requirement { id = "volatile_explosive" }
        :component_any {
            { id = "chem_black_powder", count = 90 },
            { id = "gunpowder", count = 90 },
            { id = "red_phosphorous_small", count = 100 },
            { id = "red_phosphorous", count = 1 },
            { id = "gunpowder_pistol", count = 90 },
            { id = "gunpowder_shotgun", count = 90 },
            { id = "gunpowder_magnum_pistol", count = 80 },
            { id = "gunpowder_artillery", count = 90 },
            { id = "gunpowder_rifle", count = 70 },
            { id = "chem_hmtd", count = 14 },
            { id = "chem_apex", count = 7 },
            { id = "chem_mercury_fulminate", count = 21 },
            { id = "chem_lead_azide", count = 21 },
        }
)

-- This should contain all the explosives you need to set off with an explosive primer, but can be used without casting in a crucible. 10g tnt equivalent.
content.merge_requirement(
    content.Requirement { id = "stable_explosive" }
        :component_any {
            { id = "chem_ammonium_nitrate", count = 24 },
            { id = "chem_ammonium_nitrate_pellets", count = 24 },
            { id = "chem_anfo", count = 14 },
            { id = "chem_rdx", count = 6 },
        }
)

-- This should contain all the explosives you need to set off with an explosive primer or a fuze, and also need casting in a crucible. 10g tnt equivalent.
content.merge_requirement(
    content.Requirement { id = "military_explosive" }
        :component("chem_compositionb", 8)
)

--  Gas canisters, which can be recycled to get empty canisters. containers with an internal volume of 250 ml.
content.merge_requirement(
    content.Requirement { id = "small_gas_canister_case" }
        :component_any {
            { id = "canister_empty", count = 1 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
        }
)

-- requirements/materials.json

content.merge_requirement(
    content.Requirement { id = "bamboo_stick" }
        :component_any {
            { id = "stick", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "bamboo_stick_long" }
        :component_any {
            { id = "stick_long", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
        }
)

-- Materials used for joining (typically non-metallic) parts
content.merge_requirement(
    content.Requirement { id = "adhesive" }
        :component_any {
            { id = "duct_tape", count = 25 },
            { id = "glue_strong", count = 10 },
            { id = "glue_weak", count = 150 },
        }
)

-- Any type of all-surface glue.  Each unit is 1cm^2 of coverage
content.merge_requirement(
    content.Requirement { id = "glue_any" }
        :component_any {
            { id = "glue_strong", count = 4 },
            { id = "glue_weak", count = 150 },
        }
)

-- Any type of waterproof glue, which is just about everything except bone/hide glue.  Each unit is 1cm^2 of coverage
content.merge_requirement(
    content.Requirement { id = "glue_waterproof" }
        :component("glue_strong", 4)
)

-- Strong glue, such as superglues, epoxy resin.  Each unit is 0.5cm^2 of coverage
content.merge_requirement(
    content.Requirement { id = "glue_strong" }
        :component("glue_strong", 1)
)

-- Materials used for joining or tying with strings (typically non-metallic) parts. For use with improvised or simple items.
content.merge_requirement(
    content.Requirement { id = "adhesive_cordage" }
        :component_any {
            { id = "adhesive", count = 1, requirement = true },
            { id = "cordage", count = 1, requirement = true },
        }
)

-- Any kind of wood, for handicrafts and staves etc. Includes toxic sealants like motor oil. Each unit is up to 1500cm^2 of coverage.
content.merge_requirement(
    content.Requirement { id = "wood_sealant_any" }
        :component_any {
            { id = "wood_sealant_nontoxic", count = 1, requirement = true },
            { id = "any_tallow", count = 5, requirement = true },
            { id = "lamp_oil", count = 250 },
            { id = "motor_oil", count = 250 },
            { id = "wax_any", count = 1, requirement = true },
            { id = "rosin", count = 1 },
        }
)

-- Any kind of wood, for handicrafts and staves etc. Includes toxic sealants like motor oil. Each unit is up to 750cm^2 of coverage.
content.merge_requirement(
    content.Requirement { id = "wood_sealant_any_small" }
        :component_any {
            { id = "wood_sealant_nontoxic_small", count = 1, requirement = true },
            { id = "any_tallow", count = 2, requirement = true },
            { id = "lamp_oil", count = 125 },
            { id = "motor_oil", count = 125 },
            { id = "wax_any", count = 1, requirement = true },
            { id = "rosin", count = 1 },
        }
)

-- Wood sealant, for handicrafts and staves etc. Only sealants that can be used on food surfaces allowed. Each unit is 1500cm^2 of coverage.
content.merge_requirement(
    content.Requirement { id = "wood_sealant_nontoxic" }
        :component_any {
            { id = "cooking_oil", count = 16 },
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "wax", count = 1 },
            { id = "pine_resin", count = 1 },
            { id = "raw_butter", count = 20 },
            { id = "butter", count = 20 },
        }
)

-- Wood sealant, for handicrafts and staves etc. Only sealants that can be used on food surfaces allowed. Each unit is 750cm^2 of coverage.
content.merge_requirement(
    content.Requirement { id = "wood_sealant_nontoxic_small" }
        :component_any {
            { id = "cooking_oil", count = 8 },
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "wax", count = 1 },
            { id = "pine_resin", count = 1 },
            { id = "raw_butter", count = 10 },
            { id = "butter", count = 10 },
        }
)

-- Materials, that are used in making concrete.  Adjusted for 1 unit of water with 1 cement / 0.6 water ratio per one requirement, and 3 cement/2 sand/1 aggregate ratio of ingredients by volume
content.merge_requirement(
    content.Requirement { id = "concrete_materials_dry" }
        :component("material_cement", 30)
        :component("material_sand", 20)
        :component_any {
            { id = "material_gravel", count = 10 },
            { id = "pebble", count = 2 },
        }
)

-- Materials used when forming bullets
content.merge_requirement(
    content.Requirement { id = "ammo_bullet" }
        :component("lead", 1)
)

-- Any kind of non-poisonous bones, human or not. Includes non-poisonous human-size skulls.
content.merge_requirement(
    content.Requirement { id = "bone_edible" }
        :component_any {
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_demihuman", count = 1 },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_human", count = 1 },
        }
)

-- Any kind of bones, human or not.  Tainted bones are too brittle and won't work for this purpose.
content.merge_requirement(
    content.Requirement { id = "bone_sturdy" }
        :component_any {
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_demihuman", count = 1 },
        }
)

-- Any kind of bones.  May possibly be poisonous to eat, or fragile.
content.merge_requirement(
    content.Requirement { id = "bone_any" }
        :component_any {
            { id = "bone_sturdy", count = 1, requirement = true },
            { id = "bone_tainted", count = 1 },
            { id = "skull_human_tainted", count = 1 },
        }
)

-- Any kind of bone meal, edible or not.  May possibly be poisonous to eat.
content.merge_requirement(
    content.Requirement { id = "bone_meal_any" }
        :component_any {
            { id = "meal_bone", count = 1 },
            { id = "meal_bone_tainted", count = 1 },
        }
)

-- Any non-poisonous skull, human or not.
content.merge_requirement(
    content.Requirement { id = "skull_any" }
        :component_any {
            { id = "skull_tiny", count = 1, requirement = true },
            { id = "skull_small", count = 1, requirement = true },
            { id = "skull_medium", count = 1, requirement = true },
            { id = "skull_large", count = 1, requirement = true },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_human", count = 1 },
        }
)

-- Tiny skulls
content.merge_requirement(
    content.Requirement { id = "skull_tiny" }
        :component_any {
            { id = "skull_canis_small", count = 1 },
            { id = "skull_feline_small", count = 1 },
            { id = "skull_opossum", count = 1 },
        }
)

-- Small skulls
content.merge_requirement(
    content.Requirement { id = "skull_small" }
        :component_any {
            { id = "skull_canis_medium", count = 1 },
            { id = "skull_feline_medium", count = 1 },
            { id = "skull_raccoon", count = 1 },
            { id = "skull_skunk", count = 1 },
            { id = "skull_rabbit", count = 1 },
        }
)

-- Medium skulls
content.merge_requirement(
    content.Requirement { id = "skull_medium" }
        :component_any {
            { id = "skull_canis", count = 1 },
            { id = "skull_canis_triclopean", count = 1 },
            { id = "skull_cougar", count = 1 },
            { id = "skull_beaver", count = 1 },
            { id = "skull_beaver_huge", count = 1 },
            { id = "skull_sheep", count = 1 },
        }
)

-- Skulls similar in size to a human skull, but not human or demi-human
content.merge_requirement(
    content.Requirement { id = "skull_humanlike" }
        :component_any {
            { id = "skull_bear", count = 1 },
            { id = "skull_pig", count = 1 },
            { id = "skull_goat", count = 1 },
            { id = "skull_cervine", count = 1 },
            { id = "skull_cervine_spideer", count = 1 },
            { id = "skull_llama", count = 1 },
        }
)

-- Skulls that belong to megafauna and large livestock
content.merge_requirement(
    content.Requirement { id = "skull_large" }
        :component_any {
            { id = "skull_bovine", count = 1 },
            { id = "skull_equine", count = 1 },
            { id = "skull_moose", count = 1 },
            { id = "skull_moose_tusked", count = 1 },
        }
)

-- Material used for equivalence between one unit of scrap copper and corresponding amount of elemental copper.
content.merge_requirement(
    content.Requirement { id = "copper_scrap_equivalent" }
        :component_any {
            { id = "scrap_copper", count = 1 },
            { id = "copper", count = 50 },
        }
)

-- Fibrous plant material for basket weaving or rope making.
content.merge_requirement(
    content.Requirement { id = "plant_cordage" }
        :component_any {
            { id = "withered", count = 2 },
            { id = "straw_pile", count = 2 },
            { id = "tanbark", count = 1 },
            { id = "willowbark", count = 1 },
            { id = "birchbark", count = 1 },
        }
)

--  makes 540cm of 10 lbish fishing line with little time spent braiding, thread requires to much work and sinew unglues in water unless threated
content.merge_requirement(
    content.Requirement { id = "cordage_fishing" }
        :component_any {
            { id = "string_36", count = 6 },
            { id = "cordage_36", count = 6 },
            { id = "cordage_36_leather", count = 6 },
            { id = "string_6", count = 36 },
            { id = "cordage_6", count = 36 },
            { id = "cordage_6_leather", count = 36 },
            { id = "thread_nomex", count = 108 },
            { id = "thread_kevlar", count = 36 },
        }
)

-- Materials used for tying items, primitive bowstrings, and other uses involving string or makeshift cordage, 36 g/90 cm of cordage per unit.
content.merge_requirement(
    content.Requirement { id = "cordage" }
        :component_any {
            { id = "string_36", count = 1 },
            { id = "cordage_36", count = 1 },
            { id = "cordage_36_leather", count = 1 },
            { id = "cordage_short", count = 6, requirement = true },
        }
)

-- Materials used for tying smaller items requiring less string, 6 g/15 cm of cordage per unit.
content.merge_requirement(
    content.Requirement { id = "cordage_short" }
        :component_any {
            { id = "string_6", count = 1 },
            { id = "cordage_6", count = 1 },
            { id = "cordage_6_leather", count = 1 },
        }
)

-- Superior materials used for tying items where more durability and/or flexibility are required (like good-quality bowstrings), 36 g/90 cm of string per unit.
content.merge_requirement(
    content.Requirement { id = "cordage_superior" }
        :component_any {
            { id = "string_36", count = 1 },
            { id = "cordage_superior_short", count = 6, requirement = true },
        }
)

-- Superior materials used for tying smaller items requiring less string where more durability and/or flexibility are required (like good-quality bowstrings), 6 g/15 cm of string per unit.
content.merge_requirement(
    content.Requirement { id = "cordage_superior_short" }
        :component("string_6", 1)
)

content.merge_requirement(
    content.Requirement { id = "any_sheet_metal_small" }
        :component_any {
            { id = "sheet_metal_small", count = 1 },
            { id = "hc_sheet_metal_small", count = 1 },
            { id = "mc_sheet_metal_small", count = 1 },
            { id = "qt_sheet_metal_small", count = 1 },
            { id = "ch_sheet_metal_small", count = 1 },
        }
)

-- Materials required to print one superalloy sheet
content.merge_requirement(
    content.Requirement { id = "superalloy_forge" }
        :component("any_sheet_metal_small", 4, true)
        :component("nanomaterial", 5)
)

-- Materials required to apply diamond coating (per 250ml volume)
content.merge_requirement(
    content.Requirement { id = "cvd_diamond" }
        :component("plasma", 5)
        :component_any {
            { id = "charcoal", count = 25 },
            { id = "coal_lump", count = 25 },
        }
)

-- Materials required to run one cycle of the furniture autoclave
content.merge_requirement(
    content.Requirement { id = "autoclave" }
        :component_any {
            { id = "water", count = 64 },
            { id = "water_clean", count = 64 },
        }
)

-- Materials required to run one cycle of the item version autoclave
content.merge_requirement(
    content.Requirement { id = "autoclave_item" }
        :component_any {
            { id = "water", count = 8 },
            { id = "water_clean", count = 8 },
        }
)

-- Materials required by the nanofabricator to create an item (per 250ml volume)
content.merge_requirement(
    content.Requirement { id = "nanofabricator" }
        :component("nanomaterial", 5)
)

-- Materials used for crafting or repairing clothing or sheeting, etc.
content.merge_requirement(
    content.Requirement { id = "fabric_standard" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_lycra", count = 1 },
            { id = "sheet_lycra_patchwork", count = 1 },
            { id = "lycra_patch", count = 8 },
            { id = "nylon", count = 1 },
            { id = "sheet_nylon_patchwork", count = 1 },
            { id = "sheet_nylon", count = 1 },
            { id = "leather", count = 8 },
            { id = "nomex", count = 8 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "sheet_nomex", count = 1 },
            { id = "neoprene", count = 8 },
            { id = "sheet_neoprene", count = 1 },
            { id = "sheet_neoprene_patchwork", count = 1 },
        }
)

-- Materials used for crafting or repairing clothing or sheeting, etc.
content.merge_requirement(
    content.Requirement { id = "fabric_standard_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "lycra_patch", count = 1 },
            { id = "nylon", count = 1 },
            { id = "leather", count = 1 },
            { id = "nomex", count = 1 },
            { id = "neoprene", count = 1 },
        }
)

-- Materials used for crafting or repairing woven fabrics
content.merge_requirement(
    content.Requirement { id = "fabric_standard_permeable" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "lycra_patch", count = 8 },
            { id = "sheet_lycra_patchwork", count = 1 },
            { id = "sheet_lycra", count = 1 },
            { id = "nylon", count = 8 },
            { id = "sheet_nylon_patchwork", count = 1 },
            { id = "sheet_nylon", count = 1 },
            { id = "nomex", count = 8 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "sheet_nomex", count = 1 },
        }
)

-- Materials used for crafting or repairing woven fabrics
content.merge_requirement(
    content.Requirement { id = "fabric_standard_permeable_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "lycra_patch", count = 8 },
            { id = "nylon", count = 8 },
            { id = "nomex", count = 8 },
        }
)

-- Materials used for crafting or repairing non-form fitting clothing
content.merge_requirement(
    content.Requirement { id = "fabric_standard_nostretch" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "nylon", count = 8 },
            { id = "sheet_nylon_patchwork", count = 1 },
            { id = "sheet_nylon", count = 1 },
            { id = "nomex", count = 8 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "sheet_nomex", count = 1 },
        }
)

-- Materials used for crafting or repairing non-form fitting clothing
content.merge_requirement(
    content.Requirement { id = "fabric_standard_nostretch_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "nylon", count = 1 },
            { id = "nomex", count = 1 },
        }
)

-- Materials used for crafting felt clothing
content.merge_requirement(
    content.Requirement { id = "fabric_felt" }
        :component_any {
            { id = "felt_patch", count = 8 },
            { id = "sheet_felt_patchwork", count = 1 },
            { id = "sheet_felt", count = 1 },
        }
)

-- Materials used for faux fur clothing
content.merge_requirement(
    content.Requirement { id = "fabric_fauxfur" }
        :component_any {
            { id = "faux_fur", count = 8 },
            { id = "sheet_faux_fur_patchwork", count = 1 },
            { id = "sheet_faux_fur", count = 1 },
        }
)

-- Materials used for crafting fur clothing
content.merge_requirement(
    content.Requirement { id = "fabric_fur" }
        :component_any {
            { id = "fur", count = 8 },
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 },
        }
)

-- Materials used for crafting fur clothing
content.merge_requirement(
    content.Requirement { id = "fabric_fur_pelt" }
        :component_any {
            { id = "fur", count = 8 },
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 },
        }
)

-- Materials used for crafting leather clothing.
content.merge_requirement(
    content.Requirement { id = "fabric_leather_hide" }
        :component_any {
            { id = "leather", count = 8 },
            { id = "sheet_leather_patchwork", count = 1 },
            { id = "tanned_hide", count = 1 },
        }
)

-- Materials used for crafting leather clothing where fur is or should be an option (can be scraped off with a cutting tool for example), when tanned hides/pelts are available it seems to roughly be a 1:8 ratio
content.merge_requirement(
    content.Requirement { id = "fabric_leather_fur_hide" }
        :component_any {
            { id = "leather", count = 8 },
            { id = "fur", count = 8 },
            { id = "tanned_hide", count = 1 },
            { id = "tanned_pelt", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 },
            { id = "sheet_fur_patchwork", count = 1 },
        }
)

-- Materials used for crafting Nomex clothing
content.merge_requirement(
    content.Requirement { id = "fabric_nomex" }
        :component_any {
            { id = "nomex", count = 8 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "sheet_nomex", count = 1 },
        }
)

-- Materials used for crafting nylon clothing
content.merge_requirement(
    content.Requirement { id = "fabric_nylon" }
        :component_any {
            { id = "nylon", count = 8 },
            { id = "sheet_nylon_patchwork", count = 1 },
            { id = "sheet_nylon", count = 1 },
        }
)

-- Materials used for crafting neoprene clothing
content.merge_requirement(
    content.Requirement { id = "fabric_neoprene" }
        :component_any {
            { id = "neoprene", count = 8 },
            { id = "sheet_neoprene_patchwork", count = 1 },
            { id = "sheet_neoprene", count = 1 },
        }
)

-- Materials used for crafting lycra clothing
content.merge_requirement(
    content.Requirement { id = "fabric_lycra" }
        :component_any {
            { id = "lycra_patch", count = 8 },
            { id = "sheet_lycra", count = 1 },
            { id = "sheet_lycra_patchwork", count = 1 },
        }
)

-- Materials for use when sewing items. 10 inches of thread, sinew, fiber, canvas or yarn, or 12 inches of nomex and kevlar thread per unit.
content.merge_requirement(
    content.Requirement { id = "filament" }
        :component_any {
            { id = "thread", count = 1 },
            { id = "sinew", count = 1 },
            { id = "plant_fibre", count = 1 },
            { id = "yarn", count = 1 },
            { id = "thread_canvas", count = 1 },
            { id = "thread_nomex", count = 2 },
            { id = "thread_kevlar", count = 2 },
        }
)

-- each of these equals 12 inches of thread for use when sewing items requiring advanced thread.
content.merge_requirement(
    content.Requirement { id = "advanced_filament" }
        :component_any {
            { id = "thread_nomex", count = 2 },
            { id = "thread_kevlar", count = 2 },
            { id = "thread_canvas", count = 2 },
        }
)

-- Materials for use when sewing high end items, restricted to only the aramid threads and canvas thread.  Canvas thread is 2x the length of aramid thread and is reasonably sturdy, but will be double-stitched anyways to be on the safe side.
content.merge_requirement(
    content.Requirement { id = "filament_durable" }
        :component_any {
            { id = "thread_kevlar", count = 2 },
            { id = "thread_nomex", count = 2 },
            { id = "thread_canvas", count = 2 },
        }
)

-- Thread for sewing canvas.  Unlike filament_durable it's ok to use a single 10 inch canvas thread for this, but half-length aramid threads are still double.  Kept separate from filament_durable because canvas thread is doubled up for those to alleviate it being a bit weaker than kevlar threading.
content.merge_requirement(
    content.Requirement { id = "filament_canvas" }
        :component_any {
            { id = "thread_canvas", count = 1 },
            { id = "thread_nomex", count = 2 },
            { id = "thread_kevlar", count = 2 },
        }
)

-- Materials for glazing pottery
content.merge_requirement(
    content.Requirement { id = "glazing" }
        :component_any {
            { id = "any_tallow", count = 1, requirement = true },
            { id = "cooking_oil", count = 8 },
            { id = "wax", count = 1 },
            { id = "lamp_oil", count = 200 },
            { id = "motor_oil", count = 200 },
            { id = "salt_water", count = 5 },
            { id = "ash", count = 5 },
            { id = "tin", count = 50 },
        }
)

-- Materials used for lashing, when choice of makeshift rope or vine is sensible, per 1080 g/9 m of rope
content.merge_requirement(
    content.Requirement { id = "rope_natural" }
        :component_any {
            { id = "rope_30", count = 1 },
            { id = "rope_makeshift_30", count = 1 },
            { id = "vine_30", count = 1 },
            { id = "rope_natural_short", count = 5, requirement = true },
        }
)

-- Materials used for lashing, when choice of makeshift rope or vine is sensible, per 1080 g/9 m of rope
content.merge_requirement(
    content.Requirement { id = "chain_material" }
        :component("chain", 1)
)

-- Materials used for lashing, when choice of makeshift rope is sensible, per 216 g/180 cm of rope.
content.merge_requirement(
    content.Requirement { id = "rope_natural_short" }
        :component_any {
            { id = "rope_6", count = 1 },
            { id = "vine_6", count = 1 },
            { id = "rope_makeshift_6", count = 1 },
            { id = "seatbelt", count = 1 },
        }
)

-- Materials used for lashing, when any rope or wire is sensible, per 216 g/180 cm of rope.
content.merge_requirement(
    content.Requirement { id = "rope_any_short" }
        :component_any {
            { id = "rope_6", count = 1 },
            { id = "vine_6", count = 1 },
            { id = "rope_makeshift_6", count = 1 },
            { id = "any_wire", count = 1, requirement = true },
        }
)

-- Materials used for lashing, when extra durability and/or flexibility is needed, per 1080 g/9 m of rope.
content.merge_requirement(
    content.Requirement { id = "rope_superior" }
        :component_any {
            { id = "rope_30", count = 1 },
            { id = "vine_30", count = 1 },
            { id = "rope_superior_short", count = 5, requirement = true },
        }
)

-- Materials used for lashing, when extra durability and/or flexibility is needed, per 216 g/180 cm of rope.
content.merge_requirement(
    content.Requirement { id = "rope_superior_short" }
        :component_any {
            { id = "rope_6", count = 1 },
            { id = "vine_6", count = 1 },
            { id = "seatbelt", count = 1 },
        }
)

-- Materials for when you just need a heavy chunk of metal, like for the makeshift hammer
content.merge_requirement(
    content.Requirement { id = "steel_chunk_any" }
        :component_any {
            { id = "steel_chunk", count = 1 },
            { id = "budget_steel_chunk", count = 1 },
            { id = "chunk_cast_iron", count = 1 },
            { id = "lc_steel_chunk", count = 1 },
            { id = "mc_steel_chunk", count = 1 },
            { id = "hc_steel_chunk", count = 1 },
            { id = "ch_steel_chunk", count = 1 },
            { id = "qt_steel_chunk", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "steel_lump_any" }
        :component_any {
            { id = "steel_lump", count = 1 },
            { id = "budget_steel_lump", count = 1 },
            { id = "lump_cast_iron", count = 1 },
            { id = "lc_steel_lump", count = 1 },
            { id = "mc_steel_lump", count = 1 },
            { id = "hc_steel_lump", count = 1 },
            { id = "ch_steel_lump", count = 1 },
            { id = "qt_steel_lump", count = 1 },
        }
)

-- Any lump of steel but only lumps of steel
content.merge_requirement(
    content.Requirement { id = "steel_lump_any_steel" }
        :component_any {
            { id = "budget_steel_lump", count = 1 },
            { id = "lc_steel_lump", count = 1 },
            { id = "mc_steel_lump", count = 1 },
            { id = "hc_steel_lump", count = 1 },
            { id = "ch_steel_lump", count = 1 },
            { id = "qt_steel_lump", count = 1 },
        }
)

-- Materials for use when forging items from steel
content.merge_requirement(
    content.Requirement { id = "steel_standard" }
        :component_any {
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
        }
)

-- Materials for use in scrap armor
content.merge_requirement(
    content.Requirement { id = "mixed_steel" }
        :component_any {
            { id = "scrap", count = 50 },
            { id = "steel_standard", count = 1, requirement = true },
        }
)

-- Materials for use when forging atypically small items from bronze
content.merge_requirement(
    content.Requirement { id = "bronze_tiny" }
        :component("scrap_bronze", 1)
)

-- Rocks that can be used for knapping.
content.merge_requirement(
    content.Requirement { id = "rock_flaking_any" }
        :component_any {
            { id = "rock_flaking", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "flint", count = 1 },
        }
)

-- Materials for waterproofing leather and wooden items.
content.merge_requirement(
    content.Requirement { id = "waterproofing" }
        :component_any {
            { id = "wax", count = 1 },
            { id = "pine_resin", count = 5 },
        }
)

-- Materials for fletching arrows.
content.merge_requirement(
    content.Requirement { id = "fletching" }
        :component_any {
            { id = "feather", count = 10 },
            { id = "duct_tape", count = 40 },
            { id = "cardboard", count = 10 },
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 4 },
            { id = "bottle_plastic_small", count = 1 },
            { id = "plastic_chunk", count = 1 },
            { id = "aluminum_foil", count = 40 },
            { id = "cash_card", count = 2 },
            { id = "credit_card", count = 2 },
        }
)

-- Materials used for adding weight to weapons and to other items. The materials should be malleable, ductile and dense.
content.merge_requirement(
    content.Requirement { id = "weights" }
        :component_any {
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "gold_small", count = 3 },
            { id = "platinum_small", count = 3 },
        }
)

-- Materials used for plastic and rubber things.
content.merge_requirement(
    content.Requirement { id = "plastics" }
        :component("plastic_chunk", 1)
)

-- Materials used for repairing solar panels
content.merge_requirement(
    content.Requirement { id = "solar_panel" }
        :component("solar_cell", 3)
        :component("cable", 2)
)

-- Materials used for advanced solar panels
content.merge_requirement(
    content.Requirement { id = "solar_panel_v2" }
        :component("solar_cell_v2", 3)
        :component("cable", 2)
)

-- Materials used for painting something of any color
content.merge_requirement(
    content.Requirement { id = "paint", name = content.text("Paint") }
        :tool_any {
            { id = "paint_red", charges = 1 },
            { id = "paint_orange", charges = 1 },
            { id = "paint_yellow", charges = 1 },
            { id = "paint_green", charges = 1 },
            { id = "paint_cyan", charges = 1 },
            { id = "paint_blue", charges = 1 },
            { id = "paint_pink", charges = 1 },
            { id = "paint_purple", charges = 1 },
            { id = "paint_white", charges = 1 },
            { id = "paint_gray", charges = 1 },
            { id = "paint_black", charges = 1 },
            { id = "paint_brown", charges = 1 },
        }
)

-- Materials needed to make a pair of rubber shoe soles.
content.merge_requirement(
    content.Requirement { id = "shoe_rubber" }
        :component_any {
            { id = "sole_rubber", count = 2 },
            { id = "chunk_rubber", count = 7 },
            { id = "rubber_tire_chunk", count = 2 },
            { id = "rubber_tire_strip", count = 1 },
        }
)

-- Materials needed to repair damage to tires.
content.merge_requirement(
    content.Requirement { id = "tire_rubber" }
        :component_any {
            { id = "sole_rubber", count = 1 },
            { id = "chunk_rubber", count = 2 },
            { id = "rubber_tire_chunk", count = 1 },
        }
)

-- Materials used for joining soft, flexible material where regular brittle superglue would be inappropriate.
content.merge_requirement(
    content.Requirement { id = "adhesive_rubber" }
        :component("glue_weak", 250)
)

-- Materials for use when forging items from steel
content.merge_requirement(
    content.Requirement { id = "lc_steel_standard" }
        :component_any {
            { id = "lc_steel_lump", count = 1 },
            { id = "lc_steel_chunk", count = 4 },
        }
)

-- Materials for use when forging items from steel
content.merge_requirement(
    content.Requirement { id = "mc_steel_standard" }
        :component_any {
            { id = "mc_steel_lump", count = 1 },
            { id = "mc_steel_chunk", count = 4 },
        }
)

-- Materials for use when forging items from steel
content.merge_requirement(
    content.Requirement { id = "hc_steel_standard" }
        :component_any {
            { id = "hc_steel_lump", count = 1 },
            { id = "hc_steel_chunk", count = 4 },
        }
)

-- Materials for use when building out of animal dung
content.merge_requirement(
    content.Requirement { id = "daub_fill" }
        :component_any {
            { id = "material_quicklime", count = 4 },
            { id = "material_limestone", count = 4 },
            { id = "clay_lump", count = 4 },
            { id = "feces_manure", count = 2 },
            { id = "feces_dog", count = 2 },
            { id = "feces_cow", count = 1 },
        }
        :component_any {
            { id = "pebble", count = 10 },
            { id = "material_sand", count = 10 },
        }
)

-- High temp resistant clay, either kaolin alone or clay+feldspar
content.merge_requirement(
    content.Requirement { id = "clay_refractory" }
        :component("clay_lump", 1)
        :component_any {
            { id = "clay_kaolin", count = 1 },
            { id = "chunk_feldspar", count = 1 },
        }
)

-- Materials for anaerobic digestion
content.merge_requirement(
    content.Requirement { id = "organic_waste" }
        :component_any {
            { id = "feces_roach", count = 20 },
            { id = "feces_bird", count = 20 },
            { id = "feces_manure", count = 3 },
            { id = "feces_dog", count = 3 },
            { id = "water_sewage", count = 3 },
            { id = "feces_cow", count = 1 },
        }
)

-- Carbon resources, used for case hardening.
content.merge_requirement(
    content.Requirement { id = "carbon" }
        :component_any {
            { id = "charcoal", count = 25 },
            { id = "coal_lump", count = 25 },
        }
)

content.merge_requirement(
    content.Requirement { id = "any_fresh_water" }
        :component_any {
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
        }
)

-- Any kind of water, clean or not.
content.merge_requirement(
    content.Requirement { id = "any_water" }
        :component_any {
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "water_sewage", count = 1 },
            { id = "water_murky", count = 1 },
            { id = "water_spring", count = 1 },
            { id = "saline", count = 5 },
        }
)

content.merge_requirement(
    content.Requirement { id = "nails" }
        :component_any {
            { id = "nail", count = 1 },
            { id = "bronze_nail", count = 1 },
        }
)

-- Both wax types, for when the recipe doesn't really care.
content.merge_requirement(
    content.Requirement { id = "wax_any" }
        :component_any {
            { id = "wax", count = 1 },
            { id = "wax_paraffin", count = 1 },
        }
)

-- Any plastic bottle, no matter of it's size.
content.merge_requirement(
    content.Requirement { id = "plastic_bottles_any" }
        :component_any {
            { id = "jug_plastic", count = 1 },
            { id = "bottle_twoliter", count = 1 },
            { id = "bottle_plastic", count = 1 },
            { id = "bottle_folding", count = 1 },
            { id = "bottle_bathroom", count = 1 },
            { id = "bottle_plastic_seasoning", count = 1 },
            { id = "bottle_plastic_small", count = 1 },
            { id = "bottle_plastic_seasoning_small", count = 1 },
        }
)

-- Any plastic bottle, four liter of volume in total.
content.merge_requirement(
    content.Requirement { id = "plastic_bottles_4l" }
        :component_any {
            { id = "jug_plastic", count = 2 },
            { id = "plastic_bottles_2l", count = 2, requirement = true },
        }
)

-- Any plastic bottle, two liter of volume in total.
content.merge_requirement(
    content.Requirement { id = "plastic_bottles_2l" }
        :component_any {
            { id = "bottle_twoliter", count = 1 },
            { id = "plastic_bottles_1l", count = 2, requirement = true },
        }
)

-- Any plastic bottle, one liter of volume in total.
-- apparently we have no 1 L bottles in the game (yet)
content.merge_requirement(
    content.Requirement { id = "plastic_bottles_1l" }
        :component("plastic_bottles_05l", 2, true)
)

-- Any plastic bottle, 0.5 liter of volume in total.
content.merge_requirement(
    content.Requirement { id = "plastic_bottles_05l" }
        :component_any {
            { id = "bottle_plastic", count = 1 },
            { id = "bottle_folding", count = 1 },
            { id = "bottle_bathroom", count = 1 },
            { id = "bottle_plastic_seasoning", count = 1 },
            { id = "bottle_plastic_small", count = 2 },
            { id = "bottle_plastic_seasoning_small", count = 2 },
        }
)

-- For jewelry crafts that require a plain necklace as a base. Anything with a pendent already attached shouldn’t be considered here.
content.merge_requirement(
    content.Requirement { id = "plain_necklaces" }
        :component_any {
            { id = "platinum_necklace", count = 1 },
            { id = "gold_necklace", count = 1 },
            { id = "silver_necklace", count = 1 },
            { id = "copper_necklace", count = 1 },
        }
)

-- For jewelry crafts that require gemstones.
content.merge_requirement(
    content.Requirement { id = "gemstones" }
        :component_any {
            { id = "diamond", count = 1 },
            { id = "garnet", count = 1 },
            { id = "amethyst", count = 1 },
            { id = "aquamarine", count = 1 },
            { id = "emerald", count = 1 },
            { id = "alexandrite", count = 1 },
            { id = "malachite", count = 1 },
            { id = "pearl", count = 1 },
            { id = "ruby", count = 1 },
            { id = "peridot", count = 1 },
            { id = "sapphire", count = 1 },
            { id = "opal", count = 1 },
            { id = "tourmaline", count = 1 },
            { id = "citrine", count = 1 },
            { id = "blue_topaz", count = 1 },
            { id = "onyx", count = 1 },
        }
)

-- Prevents having to open condoms before crafts
content.merge_requirement(
    content.Requirement { id = "any_condom" }
        :component_any {
            { id = "condom", count = 1 },
            { id = "condom_sealed", count = 1 },
        }
)

-- All steel wires
content.merge_requirement(
    content.Requirement { id = "any_wire" }
        :component_any {
            { id = "lc_wire", count = 1 },
            { id = "mc_wire", count = 1 },
            { id = "hc_wire", count = 1 },
            { id = "ch_wire", count = 1 },
            { id = "qt_wire", count = 1 },
        }
)

-- when it doesn't matter if it's a steel, plastic, aluminum pipe or whatever
content.merge_requirement(
    content.Requirement { id = "any_pipe" }
        :component_any {
            { id = "pipe", count = 1 },
            { id = "pipe_cpvc", count = 1 },
            { id = "cu_pipe", count = 1 },
        }
)

-- requirements/melee.json

-- Any objects you could use as improvised melee weapons.
content.merge_requirement(
    content.Requirement { id = "improvised_melee_weapons" }
        :tool_any {
            { id = "stick", count = 1 },
            { id = "stick_long", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
            { id = "bamboo_stalk", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pipe", count = 1 },
        }
)

-- Any basic shivs not explicitly designed for combat, or low-quality things.
content.merge_requirement(
    content.Requirement { id = "basic_shivs" }
        :tool_any {
            { id = "glass_shiv", count = 1 },
            { id = "sharp_toothbrush", count = 1 },
            { id = "bone_knife", count = 1 },
            { id = "knuckle_katar", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "screwdriver", count = 1 },
            { id = "scissors_child", count = 1 },
            { id = "scissors_medical", count = 1 },
            { id = "scissors", count = 1 },
        }
)

-- Any real, small weapons that can be concealed and stab someone at close range, like pocket knives.
content.merge_requirement(
    content.Requirement { id = "real_shivs" }
        :tool_any {
            { id = "switchblade", count = 1 },
            { id = "knife_swissarmy", count = 1 },
            { id = "punch_dagger", count = 1 },
            { id = "knuckle_katar", count = 1 },
        }
)

-- Any claw-like weapons that are real and good quality.  Excludes makeshift stuff.
content.merge_requirement(
    content.Requirement { id = "real_claws" }
        :tool_any {
            { id = "bagh_nakha", count = 1 },
            { id = "bio_claws_weapon", count = 1 },
        }
)

-- Any basic thing that you can use to hook stuff in a fight.
content.merge_requirement(
    content.Requirement { id = "basic_hooks" }
        :tool_any {
            { id = "makeshift_scythe_war", count = 1 },
            { id = "makeshift_halberd", count = 1 },
            { id = "makeshift_glaive", count = 1 },
            { id = "makeshift_scythe_war", count = 1 },
            { id = "battleaxe_fake", count = 1 },
            { id = "battleaxe_inferior", count = 1 },
            { id = "ax_sheets_welded", count = 1 },
            { id = "ax_sheets_bolted", count = 1 },
            { id = "hockey_stick", count = 1 },
            { id = "lucern_hammerfake", count = 1 },
            { id = "homemade_polehammer", count = 1 },
            { id = "homemade_polehammer_makeshift", count = 1 },
        }
)

-- Any quality weapon designed to hook your opponents and their gear in a fight.  Reserved for the good stuff.
content.merge_requirement(
    content.Requirement { id = "real_hooks" }
        :tool_any {
            { id = "scythe_war", count = 1 },
            { id = "poleaxe", count = 1 },
            { id = "ji", count = 1 },
            { id = "halberd", count = 1 },
            { id = "glaive", count = 1 },
            { id = "battleaxe", count = 1 },
            { id = "lucern_hammer", count = 1 },
            { id = "warhammer", count = 1 },
            { id = "lc_warhammer", count = 1 },
            { id = "hc_warhammer", count = 1 },
            { id = "ch_warhammer", count = 1 },
            { id = "qt_warhammer", count = 1 },
            { id = "lc_battleaxe", count = 1 },
            { id = "mc_battleaxe", count = 1 },
            { id = "hc_battleaxe", count = 1 },
            { id = "ch_battleaxe", count = 1 },
            { id = "qt_battleaxe", count = 1 },
        }
)

-- Any small close-range stabbing weapons.  Not explicitly designed for combat.
content.merge_requirement(
    content.Requirement { id = "basic_knives" }
        :tool_any {
            { id = "knife_hunting", count = 1 },
            { id = "makeshift_knife", count = 1 },
            { id = "bone_knife", count = 1 },
            { id = "primitive_knife", count = 1 },
            { id = "kris_fake", count = 1 },
            { id = "tanto_fake", count = 1 },
            { id = "tanto_inferior", count = 1 },
            { id = "kirpan_cheap", count = 1 },
            { id = "enfield_bayonet", count = 1 },
            { id = "knife_huge", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "knife_cleaver", count = 1 },
        }
)

-- Any real, small weapons meant to stab someone at close range; larger shivs basically.
content.merge_requirement(
    content.Requirement { id = "real_knives" }
        :tool_any {
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_KABAR", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "lc_knife_rambo", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "hc_knife_rambo", count = 1 },
            { id = "ch_knife_rambo", count = 1 },
            { id = "qt_knife_rambo", count = 1 },
            { id = "knife_rm42", count = 1 },
            { id = "knife_folding", count = 1 },
            { id = "knife_trench", count = 1 },
            { id = "lc_knife_trench", count = 1 },
            { id = "knife_trench", count = 1 },
            { id = "hc_knife_trench", count = 1 },
            { id = "ch_knife_trench", count = 1 },
            { id = "qt_knife_trench", count = 1 },
            { id = "knife_baselard", count = 1 },
            { id = "kris", count = 1 },
            { id = "kukri", count = 1 },
            { id = "lc_kukri", count = 1 },
            { id = "ch_kukri", count = 1 },
            { id = "hc_kukri", count = 1 },
            { id = "qt_kukri", count = 1 },
            { id = "tanto", count = 1 },
            { id = "karambit", count = 1 },
            { id = "kirpan", count = 1 },
            { id = "butterfly_swords", count = 1 },
        }
)

-- Any weapon that you could thrust with and stab someone.
content.merge_requirement(
    content.Requirement { id = "basic_thrusting_swords" }
        :tool_any {
            { id = "sword_metal_fencing", count = 1 },
            { id = "estoc_fake", count = 1 },
            { id = "estoc_inferior", count = 1 },
            { id = "fencing_foil", count = 1 },
            { id = "fencing_foil_sharpened", count = 1 },
            { id = "shock_foil", count = 1 },
            { id = "fencing_epee", count = 1 },
            { id = "fencing_epee_sharpened", count = 1 },
            { id = "shock_epee", count = 1 },
            { id = "fencing_sabre", count = 1 },
            { id = "fencing_sabre_sharpened", count = 1 },
            { id = "shock_sabre", count = 1 },
            { id = "rapier_fake", count = 1 },
            { id = "broadsword_fake", count = 1 },
            { id = "broadsword_inferior", count = 1 },
            { id = "sharpened_pipe", count = 1 },
        }
)

-- Any real, quality weapon designed to be used in a thrusting fashion.  Needs to be a sword, not a spear.  This includes fencing weaponry.
content.merge_requirement(
    content.Requirement { id = "real_thrusting_swords" }
        :tool_any {
            { id = "estoc", count = 1 },
            { id = "lc_estoc", count = 1 },
            { id = "mc_estoc", count = 1 },
            { id = "ch_estoc", count = 1 },
            { id = "hc_estoc", count = 1 },
            { id = "qt_estoc", count = 1 },
            { id = "sword_cane", count = 1 },
            { id = "rapier", count = 1 },
            { id = "lc_rapier", count = 1 },
            { id = "hc_rapier", count = 1 },
            { id = "ch_rapier", count = 1 },
            { id = "qt_rapier", count = 1 },
            { id = "lc_talwar", count = 1 },
            { id = "mc_talwar", count = 1 },
            { id = "hc_talwar", count = 1 },
            { id = "ch_talwar", count = 1 },
            { id = "qt_talwar", count = 1 },
            { id = "cavalry_sabre", count = 1 },
            { id = "lc_cavalry_sabre", count = 1 },
            { id = "mc_cavalry_sabre", count = 1 },
            { id = "hc_cavalry_sabre", count = 1 },
            { id = "ch_cavalry_sabre", count = 1 },
            { id = "qt_cavalry_sabre", count = 1 },
            { id = "jian", count = 1 },
            { id = "lc_jian", count = 1 },
            { id = "mc_jian", count = 1 },
            { id = "hc_jian", count = 1 },
            { id = "ch_jian", count = 1 },
            { id = "qt_jian", count = 1 },
            { id = "broadsword", count = 1 },
            { id = "lc_broadsword", count = 1 },
            { id = "ch_broadsword", count = 1 },
            { id = "hc_broadsword", count = 1 },
            { id = "qt_broadsword", count = 1 },
        }
)

-- Any basic thing you could use as a short sword, excludes high-quality things.
content.merge_requirement(
    content.Requirement { id = "basic_short_swords" }
        :tool_any {
            { id = "makeshift_machete", count = 1 },
            { id = "machete_gimmick", count = 1 },
            { id = "machete", count = 1 },
        }
)

-- Any real, edged short swords you could practice with, like broadswords.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_short_swords" }
        :tool_any {
            { id = "khopesh", count = 1 },
            { id = "sword_xiphos", count = 1 },
            { id = "sword_bronze", count = 1 },
            { id = "sword_bayonet", count = 1 },
            { id = "butterfly_swords", count = 1 },
            { id = "arisaka_bayonet", count = 1 },
            { id = "survivor_machete_qt", count = 1 },
        }
)

-- Any basic thing that can be used like a medium sword.
content.merge_requirement(
    content.Requirement { id = "basic_medium_swords" }
        :tool_any {
            { id = "cavalry_sabre_fake", count = 1 },
            { id = "jian_fake", count = 1 },
            { id = "jian_inferior", count = 1 },
            { id = "scimitar_fake", count = 1 },
            { id = "scimitar_inferior", count = 1 },
            { id = "arming_sword_fake", count = 1 },
            { id = "arming_sword_inferior", count = 1 },
            { id = "wakizashi_inferior", count = 1 },
            { id = "wakizashi_fake", count = 1 },
            { id = "broadsword_inferior", count = 1 },
            { id = "broadsword_fake", count = 1 },
            { id = "cutlass_fake", count = 1 },
            { id = "cutlass_inferior", count = 1 },
            { id = "sword_wood", count = 1 },
            { id = "sword_nail", count = 1 },
            { id = "sword_crude", count = 1 },
            { id = "sword_sheets_welded", count = 1 },
            { id = "sword_metal", count = 1 },
        }
)

-- Any real, edged medium swords you could practice with, like cavalry sabres.  This is any sword that is bigger than a short sword, but shorter than a long sword.
content.merge_requirement(
    content.Requirement { id = "real_medium_swords" }
        :tool_any {
            { id = "broadsword", count = 1 },
            { id = "lc_broadsword", count = 1 },
            { id = "ch_broadsword", count = 1 },
            { id = "hc_broadsword", count = 1 },
            { id = "qt_broadsword", count = 1 },
            { id = "cavalry_sabre", count = 1 },
            { id = "lc_cavalry_sabre", count = 1 },
            { id = "mc_cavalry_sabre", count = 1 },
            { id = "hc_cavalry_sabre", count = 1 },
            { id = "ch_cavalry_sabre", count = 1 },
            { id = "qt_cavalry_sabre", count = 1 },
            { id = "jian", count = 1 },
            { id = "lc_jian", count = 1 },
            { id = "mc_jian", count = 1 },
            { id = "hc_jian", count = 1 },
            { id = "ch_jian", count = 1 },
            { id = "qt_jian", count = 1 },
            { id = "scimitar", count = 1 },
            { id = "lc_scimitar", count = 1 },
            { id = "mc_scimitar", count = 1 },
            { id = "hc_scimitar", count = 1 },
            { id = "ch_scimitar", count = 1 },
            { id = "qt_scimitar", count = 1 },
            { id = "arming_sword", count = 1 },
            { id = "lc_arming_sword", count = 1 },
            { id = "mc_arming_sword", count = 1 },
            { id = "hc_arming_sword", count = 1 },
            { id = "ch_arming_sword", count = 1 },
            { id = "qt_arming_sword", count = 1 },
            { id = "dao", count = 1 },
            { id = "wakizashi", count = 1 },
            { id = "lc_wakizashi", count = 1 },
            { id = "mc_wakizashi", count = 1 },
            { id = "hc_wakizashi", count = 1 },
            { id = "ch_wakizashi", count = 1 },
            { id = "qt_wakizashi", count = 1 },
            { id = "sword_cane", count = 1 },
            { id = "cutlass", count = 1 },
            { id = "lc_cutlass", count = 1 },
            { id = "mc_cutlass", count = 1 },
            { id = "hc_cutlass", count = 1 },
            { id = "ch_cutlass", count = 1 },
            { id = "qt_cutlass", count = 1 },
            { id = "falx", count = 1 },
            { id = "lc_falx", count = 1 },
            { id = "mc_falx", count = 1 },
            { id = "hc_falx", count = 1 },
            { id = "ch_falx", count = 1 },
            { id = "qt_falx", count = 1 },
            { id = "lc_talwar", count = 1 },
            { id = "mc_talwar", count = 1 },
            { id = "hc_talwar", count = 1 },
            { id = "ch_talwar", count = 1 },
            { id = "qt_talwar", count = 1 },
            { id = "lc_kilij", count = 1 },
            { id = "mc_kilij", count = 1 },
            { id = "hc_kilij", count = 1 },
            { id = "ch_kilij", count = 1 },
            { id = "qt_kilij", count = 1 },
        }
)

-- Basic things you could use as a long sword.  Excludes real stuff, this is makeshift and low-grade bits.
content.merge_requirement(
    content.Requirement { id = "basic_long_swords" }
        :tool_any {
            { id = "sword_wood", count = 1 },
            { id = "bokken", count = 1 },
            { id = "bokken_fake", count = 1 },
            { id = "bokken_inferior", count = 1 },
            { id = "sword_nail", count = 1 },
            { id = "sword_crude", count = 1 },
            { id = "sword_sheets_welded", count = 1 },
            { id = "sword_metal", count = 1 },
            { id = "longsword_inferior", count = 1 },
            { id = "longsword_fake", count = 1 },
            { id = "katana_inferior", count = 1 },
            { id = "katana_fake", count = 1 },
        }
)

-- Any real, edged long swords you could practice with, like katanas, longswords, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_long_swords" }
        :tool_any {
            { id = "katana", count = 1 },
            { id = "lc_katana", count = 1 },
            { id = "mc_katana", count = 1 },
            { id = "hc_katana", count = 1 },
            { id = "ch_katana", count = 1 },
            { id = "qt_katana", count = 1 },
            { id = "longsword", count = 1 },
            { id = "lc_longsword", count = 1 },
            { id = "mc_longsword", count = 1 },
            { id = "hc_longsword", count = 1 },
            { id = "ch_longsword", count = 1 },
            { id = "qt_longsword", count = 1 },
            { id = "nodachi", count = 1 },
            { id = "jade_nagamaki", count = 1 },
        }
)

-- Basic or makeshift weapons that can be used like a greatsword.  Excludes real or good things.
content.merge_requirement(
    content.Requirement { id = "basic_great_swords" }
        :tool_any {
            { id = "sword_wood_large", count = 1 },
            { id = "sword_crude_large", count = 1 },
            { id = "sword_sheets_welded_large", count = 1 },
            { id = "sword_metal_large", count = 1 },
            { id = "zweihander_inferior", count = 1 },
            { id = "zweihander_fake", count = 1 },
            { id = "nodachi_inferior", count = 1 },
            { id = "nodachi_fake", count = 1 },
        }
)

-- Any real, edged, big swords you could practice with, like zweihanders, greatswords, or the Dragonslayer, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side, and is large enough to require a normal human to use two hands can qualify.
content.merge_requirement(
    content.Requirement { id = "real_great_swords" }
        :tool_any {
            { id = "zweihander", count = 1 },
            { id = "lc_zweihander", count = 1 },
            { id = "mc_zweihander", count = 1 },
            { id = "hc_zweihander", count = 1 },
            { id = "ch_zweihander", count = 1 },
            { id = "qt_zweihander", count = 1 },
            { id = "nodachi", count = 1 },
            { id = "lc_nodachi", count = 1 },
            { id = "mc_nodachi", count = 1 },
            { id = "hc_nodachi", count = 1 },
            { id = "ch_nodachi", count = 1 },
            { id = "qt_nodachi", count = 1 },
            { id = "kriegsmesser", count = 1 },
            { id = "lc_kriegsmesser", count = 1 },
            { id = "mc_kriegsmesser", count = 1 },
            { id = "hc_kriegsmesser", count = 1 },
            { id = "ch_kriegsmesser", count = 1 },
            { id = "qt_kriegsmesser", count = 1 },
        }
)

-- Any given thing you can use like an axe, basic stuff.
content.merge_requirement(
    content.Requirement { id = "basic_axes" }
        :tool_any {
            { id = "ax_sheets_welded", count = 1 },
            { id = "ax_sheets_bolted", count = 1 },
            { id = "primitive_axe", count = 1 },
        }
)

-- Any real, cutting weapons that can be used like an axe; large, heavy head with two sharp sides on a pole.
content.merge_requirement(
    content.Requirement { id = "real_axes" }
        :tool_any {
            { id = "hatchet", count = 1 },
            { id = "copper_ax", count = 1 },
            { id = "iceaxe", count = 1 },
            { id = "crash_axe", count = 1 },
            { id = "brush_axe", count = 1 },
            { id = "bronze_brush_axe", count = 1 },
        }
)

-- A one-handed weapon with an axe head.
content.merge_requirement(
    content.Requirement { id = "handaxes_axes" }
        :tool_any {
            { id = "copper_ax", count = 1 },
            { id = "throwing_axe", count = 1 },
            { id = "iceaxe", count = 1 },
            { id = "hatchet", count = 1 },
            { id = "crash_axe", count = 1 },
            { id = "primitive_axe", count = 1 },
        }
)

-- Any real, cutting weapons that can be used like an axe; large, heavy head with two sharp sides on a pole.
content.merge_requirement(
    content.Requirement { id = "real_great_axes" }
        :tool_any {
            { id = "fire_ax", count = 1 },
            { id = "battleaxe", count = 1 },
            { id = "lc_battleaxe", count = 1 },
            { id = "mc_battleaxe", count = 1 },
            { id = "hc_battleaxe", count = 1 },
            { id = "ch_battleaxe", count = 1 },
            { id = "qt_battleaxe", count = 1 },
            { id = "ax", count = 1 },
        }
)

-- Any basic, easy-to-use bashing weapons.  Like police batons, sticks, or baseball bats.
content.merge_requirement(
    content.Requirement { id = "basic_batons" }
        :tool_any {
            { id = "cudgel", count = 1 },
            { id = "bat", count = 1 },
            { id = "bat_metal", count = 1 },
            { id = "bat_nerf", count = 1 },
            { id = "baton-extended", count = 1 },
            { id = "PR24-extended", count = 1 },
            { id = "bowling_pin", count = 1 },
            { id = "cane", count = 1 },
            { id = "hollow_cane", count = 1 },
            { id = "makeshift_cane", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "glass_macuahuitl", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "makeshift_sap", count = 1 },
            { id = "shillelagh_fake", count = 1 },
            { id = "pipe", count = 1 },
            { id = "stick", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
            { id = "bamboo_stalk", count = 1 },
        }
)

-- Any one-handed weapon designed primarily to bash or smash things.  Reserved for quality items.
content.merge_requirement(
    content.Requirement { id = "real_batons" }
        :tool_any {
            { id = "blackjack", count = 1 },
            { id = "bwirebat", count = 1 },
            { id = "shillelagh", count = 1 },
            { id = "shillelagh_weighted", count = 1 },
            { id = "shocktonfa_off", count = 1 },
            { id = "tonfa", count = 1 },
            { id = "tonfa_wood", count = 1 },
        }
)

-- Any basic thing that can be used as a flail.
content.merge_requirement(
    content.Requirement { id = "basic_flails" }
        :tool("2h_flail_wood", 1)
)

-- Any real heavy-ended bashing weapons that feature a long pole with an independently-swinging baton.
content.merge_requirement(
    content.Requirement { id = "real_flails" }
        :tool("2h_flail_steel", 1)
)

-- Any basic thing that works like a great hammer; unga bunga.
content.merge_requirement(
    content.Requirement { id = "basic_great_hammers" }
        :tool_any {
            { id = "club_wooden_large", count = 1 },
            { id = "glass_macuahuitl", count = 1 },
            { id = "aztec_sword_stone", count = 1 },
            { id = "aztec_sword_scrap", count = 1 },
            { id = "hammer_sledge", count = 1 },
            { id = "hammer_sledge_short", count = 1 },
            { id = "hammer_sledge_heavy", count = 1 },
            { id = "hammer_sledge_engineer", count = 1 },
            { id = "lucern_hammerfake", count = 1 },
            { id = "mace_pipe_large", count = 1 },
        }
)

-- Any real great hammers.  It's got to have a big blunt end on a long pole, directly attached to it.
content.merge_requirement(
    content.Requirement { id = "real_great_hammers" }
        :tool_any {
            { id = "warhammer", count = 1 },
            { id = "lc_warhammer", count = 1 },
            { id = "hc_warhammer", count = 1 },
            { id = "ch_warhammer", count = 1 },
            { id = "qt_warhammer", count = 1 },
            { id = "lucern_hammer", count = 1 },
            { id = "2h_club_kanabo_studded", count = 1 },
            { id = "2h_club_kanabo_spiked", count = 1 },
            { id = "lc_aztec_sword", count = 1 },
            { id = "mc_aztec_sword", count = 1 },
            { id = "hc_aztec_sword", count = 1 },
            { id = "ch_aztec_sword", count = 1 },
            { id = "qt_aztec_sword", count = 1 },
        }
)

-- Any basic thing you can use as a mace.
content.merge_requirement(
    content.Requirement { id = "basic_maces" }
        :tool_any {
            { id = "mace_inferior", count = 1 },
            { id = "mace_fake", count = 1 },
            { id = "mace_trench", count = 1 },
            { id = "mace_pipe", count = 1 },
            { id = "mace_simple", count = 1 },
            { id = "morningstar_fake", count = 1 },
            { id = "morningstar_inferior", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "nailbat", count = 1 },
            { id = "nailboard", count = 1 },
            { id = "bwirebat", count = 1 },
            { id = "nutboltbat", count = 1 },
            { id = "bat", count = 1 },
            { id = "bat_metal", count = 1 },
            { id = "bat_nerf", count = 1 },
        }
)

-- Any real, top-heavy bashing weapons with a pointy ball at the end that doesn't independently swing (those are flails).
content.merge_requirement(
    content.Requirement { id = "real_maces" }
        :tool_any {
            { id = "mace", count = 1 },
            { id = "lc_mace", count = 1 },
            { id = "mace", count = 1 },
            { id = "hc_mace", count = 1 },
            { id = "ch_mace", count = 1 },
            { id = "qt_mace", count = 1 },
            { id = "mace_bronze", count = 1 },
            { id = "morningstar", count = 1 },
        }
)

-- Any basic thing you can use like a quarterstaff.
content.merge_requirement(
    content.Requirement { id = "basic_quarterstaves" }
        :tool_any {
            { id = "staff_pipe", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "mop", count = 1 },
        }
)

-- Any real, pole-like weapons designed for bashing and smashing.  Reserved for quality items.
content.merge_requirement(
    content.Requirement { id = "real_quarterstaves" }
        :tool_any {
            { id = "i_staff", count = 1 },
            { id = "lc_steel_staff", count = 1 },
            { id = "mc_steel_staff", count = 1 },
            { id = "hc_steel_staff", count = 1 },
            { id = "ch_steel_staff", count = 1 },
            { id = "qt_steel_staff", count = 1 },
            { id = "q_staff", count = 1 },
            { id = "bo", count = 1 },
            { id = "shock_staff", count = 1 },
        }
)

-- Any basic weapon you can use as a cutting polearm.
content.merge_requirement(
    content.Requirement { id = "basic_polearms" }
        :tool_any {
            { id = "aztec_spear_scrap", count = 1 },
            { id = "aztec_spear_glass", count = 1 },
            { id = "aztec_spear_stone", count = 1 },
            { id = "makeshift_halberd", count = 1 },
            { id = "halberd_fake", count = 1 },
            { id = "makeshift_glaive", count = 1 },
            { id = "naginata_fake", count = 1 },
            { id = "naginata_inferior", count = 1 },
            { id = "makeshift_scythe_war", count = 1 },
            { id = "hockey_stick", count = 1 },
            { id = "lucern_hammerfake", count = 1 },
            { id = "homemade_polehammer", count = 1 },
            { id = "homemade_polehammer_makeshift", count = 1 },
        }
)

-- Any real, top-heavy cutting weapons with a long pole and a blade on the end, designed to swing side-to-side.  Think like a sword with a really long handle.
content.merge_requirement(
    content.Requirement { id = "real_polearms" }
        :tool_any {
            { id = "lc_aztec_spear", count = 1 },
            { id = "mc_aztec_spear", count = 1 },
            { id = "hc_aztec_spear", count = 1 },
            { id = "ch_aztec_spear", count = 1 },
            { id = "qt_aztec_spear", count = 1 },
            { id = "glaive", count = 1 },
            { id = "halberd", count = 1 },
            { id = "lajatang", count = 1 },
            { id = "naginata", count = 1 },
            { id = "scythe_war", count = 1 },
            { id = "poleaxe", count = 1 },
            { id = "lucern_hammer", count = 1 },
            { id = "ji", count = 1 },
        }
)

-- Any given item that can be used as a spear.  Reserved for crappier things.
content.merge_requirement(
    content.Requirement { id = "basic_spears" }
        :tool_any {
            { id = "pitchfork", count = 1 },
            { id = "pointy_stick_long", count = 1 },
            { id = "spear_wood", count = 1 },
            { id = "spear_wood_simple", count = 1 },
            { id = "spear_shaft_sharpened", count = 1 },
            { id = "spear_spike", count = 1 },
            { id = "spear_knife", count = 1 },
            { id = "spear_knife_superior", count = 1 },
            { id = "spear_homemade_halfpike", count = 1 },
            { id = "spear_steel_crude", count = 1 },
            { id = "simple_spear_pipe", count = 1 },
            { id = "spear_rebar", count = 1 },
            { id = "pike_wood", count = 1 },
            { id = "pike_fake", count = 1 },
            { id = "pike_inferior", count = 1 },
            { id = "spear_stone", count = 1 },
            { id = "spear_stone_simple", count = 1 },
        }
)

-- Any weapon that features a long pole with a pointed tip at the end.  Reserved for quality weapons.
content.merge_requirement(
    content.Requirement { id = "real_spears" }
        :tool_any {
            { id = "spear_knife_proper", count = 1 },
            { id = "spear_steel", count = 1 },
            { id = "spear_copper", count = 1 },
            { id = "spear_pipe", count = 1 },
            { id = "qiang", count = 1 },
            { id = "javelin", count = 1 },
            { id = "javelin_iron", count = 1 },
            { id = "pike_copper", count = 1 },
            { id = "pike", count = 1 },
            { id = "spear_dory", count = 1 },
            { id = "spear_bronze", count = 1 },
            { id = "ji", count = 1 },
        }
)

-- Any weapon that features a handle and flexible lash.
content.merge_requirement(
    content.Requirement { id = "whips" }
        :tool_any {
            { id = "dressage_whip", count = 1 },
            { id = "bullwhip", count = 1 },
            { id = "bullwhip_razor", count = 1 },
        }
)

-- requirements/multi_activity.json

content.merge_requirement(
    content.Requirement { id = "multi_butcher" }
        :quality("BUTCHER", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_butcher_big" }
        :quality("BUTCHER", 1, 1)
        :quality("SAW_W", 1, 1)
        :quality("SAW_M", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_farm_tilling" }
        :quality("DIG", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_farm_cut_harvesting" }
        :quality("GRASS_CUT", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_chopping_trees" }
        :quality("AXE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_chopping_planks" }
        :quality("AXE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "multi_fishing" }
        :quality("FISHING_ROD", 1, 1)
)

-- requirements/ranged.json

-- Any crossbow for use in practice.
content.merge_requirement(
    content.Requirement { id = "crossbows" }
        :tool_any {
            { id = "bullet_crossbow", count = 1 },
            { id = "crossbow", count = 1 },
            { id = "compositecrossbow", count = 1 },
            { id = "compcrossbow", count = 1 },
            { id = "huge_crossbow", count = 1 },
        }
)

-- requirements/skyfarer.json

-- For items that can be repaired with nails, glue, or tape.
content.merge_requirement(
    content.Requirement { id = "nail_any_adhesive" }
        :component_any {
            { id = "nail", count = 1 },
            { id = "adhesive", count = 1, requirement = true },
        }
)

-- Materials for use when forging atypically small items from steel
content.merge_requirement(
    content.Requirement { id = "steel_tiny" }
        :component_any {
            { id = "steel_chunk", count = 1 },
            { id = "scrap", count = 5 },
        }
)

-- Planks or sticks used in recipes, roughly 1:1 basis by weight.
content.merge_requirement(
    content.Requirement { id = "wood_structural_small" }
        :component_any {
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
        }
)

-- Materials used for repairing small wooden vehicleparts, that don't warrant use of wood_structural_small
content.merge_requirement(
    content.Requirement { id = "vehicle_repair_small_wood" }
        :component("splinter", 1)
)

-- Planks, sticks, and long sticks used in recipes, roughly 1:1 by weight.
content.merge_requirement(
    content.Requirement { id = "wood_structural" }
        :component_any {
            { id = "stick_long", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
            { id = "wood_structural_small", count = 2, requirement = true },
        }
)

-- Materials used for joining (typically non-metallic) parts, excluding tape.
content.merge_requirement(
    content.Requirement { id = "adhesive_proper" }
        :component_any {
            { id = "glue_strong", count = 1 },
            { id = "glue_weak", count = 15 },
        }
)

-- Materials that connect part together tightly, nails and glue.
content.merge_requirement(
    content.Requirement { id = "nail_glue" }
        :component_any {
            { id = "nail", count = 1 },
            { id = "adhesive_proper", count = 1, requirement = true },
        }
)

-- For where proper leather or fur are used.
content.merge_requirement(
    content.Requirement { id = "fabric_hides_proper" }
        :component_any {
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
        }
)

-- Forging resources and tools needed for mid-level blacksmithing.
content.merge_requirement(
    content.Requirement { id = "blacksmithing_intermediate" }
        :tool_any {
            { id = "forge", charges = 20 },
            { id = "oxy_torch", charges = 20 },
        }
        :quality("ANVIL", 2, 1)
        :quality("HAMMER", 3, 1)
        :quality("CHISEL", 3, 1)
)

-- requirements/tailoring.json

-- Shaping and attaching a biosillicified chitin plate to something, per 112 g of biosillicified chitin.  Time needed is 10 minutes per unit.  In the future when we have some bases, we should also add the requirement for a weak base to neutralize the chitin before crafting with it.
content.merge_requirement(
    content.Requirement { id = "armor_acidchitin" }
        :component("acidchitin_piece", 1)
        :component("filament", 1, true)
        :quality("CUT", 2, 1)
        :quality("SEW", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- Assembling chainmail rings into finished products, and riveting rings closed, per 1025 g of steel.  It is assumed that each ring used comes with a prepared rivet.  Time needed is 1 hour per unit (most of the time goes into making rings and then chainmail sheets first)
content.merge_requirement(
    content.Requirement { id = "armor_lc_chainmail_assembling" }
        :component("lc_link_sheet", 1)
        :component("lc_chain_link", 25)
        :tool_any {
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 },
        }
        :quality("WRENCH", 1, 1)
)

-- Assembling chainmail rings into finished products, and riveting rings closed, per 1025 g of steel.  It is assumed that each ring used comes with a prepared rivet.  Time needed is 1 hour per unit (most of the time goes into making rings and then chainmail sheets first)
content.merge_requirement(
    content.Requirement { id = "armor_mc_chainmail_assembling" }
        :component("mc_link_sheet", 1)
        :component("mc_chain_link", 25)
        :tool_any {
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 },
        }
        :quality("WRENCH", 1, 1)
)

-- Assembling chainmail rings into finished products, and riveting rings closed, per 1025 g of steel.  It is assumed that each ring used comes with a prepared rivet.  Time needed is 1 hour per unit (most of the time goes into making rings and then chainmail sheets first)
content.merge_requirement(
    content.Requirement { id = "armor_hc_chainmail_assembling" }
        :component("hc_link_sheet", 1)
        :component("hc_chain_link", 25)
        :tool_any {
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 },
        }
        :quality("WRENCH", 1, 1)
)

-- Assembling chainmail rings into finished products, and riveting rings closed, per 1025 g of steel.  It is assumed that each ring used comes with a prepared rivet.  Time needed is 1 hour per unit (most of the time goes into making rings and then chainmail sheets first)
content.merge_requirement(
    content.Requirement { id = "armor_ch_chainmail_assembling" }
        :component("ch_link_sheet", 1)
        :component("ch_chain_link", 25)
        :tool_any {
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 },
        }
        :quality("WRENCH", 1, 1)
)

-- Assembling chainmail rings into finished products, and riveting rings closed, per 1025 g of steel.  It is assumed that each ring used comes with a prepared rivet.  Time needed is 1 hour per unit (most of the time goes into making rings and then chainmail sheets first)
content.merge_requirement(
    content.Requirement { id = "armor_qt_chainmail_assembling" }
        :component("qt_link_sheet", 1)
        :component("qt_chain_link", 25)
        :tool_any {
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 },
        }
        :quality("WRENCH", 1, 1)
)

-- Shaping and attaching a chitin plate to something, per 90 g of chitin.  Time needed is 10 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_chitin" }
        :component("chitin_piece", 1)
        :component("filament", 1, true)
        :quality("CUT", 2, 1)
        :quality("SEW", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- Shaping and attaching a rigid Kevlar plate to something, per 430 g of rigid Kevlar.  Time needed is 45 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_kevlar_rigid" }
        :component("rigid_kevlar_plate", 1)
        :component("glue_strong", 1)
        :quality("CUT", 2, 1)
)

-- Joining Kevlar panels together into something like a Kevlar vest or other armor per 428 g of Kevlar.  Time needed is 45 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_kevlar_layered" }
        :component("sheet_kevlar_layered", 1)
        :component("filament_durable", 5, true)
        :quality("FABRIC_CUT", 2, 1)
)

-- Attaching a steel plate to some flexible material like cloth or leather, as well as working it into shape needed, per 251 g of steel.  Time needed is 20 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_steel_plate" }
        :component("sheet_metal_small", 1)
        :component("filament", 1, true)
        :quality("SAW_M", 1, 1)
        :quality("HAMMER", 1, 1)
        :quality("DRILL", 1, 1)
)

-- Coating clothing in vinyl or equivalent, such as Flex Seal analogues.  This version involves melting and adhering flexible plastic.  5 sq cm / 5 grams.
content.merge_requirement(
    content.Requirement { id = "vinylizing_standard" }
        :component("plastic_sheet_small", 1)
        :component("glue_strong", 4)
        :tool_charges("surface_heat", 1, true)
)

-- Joining multiple sheets of paper together using duct tape, per 19 g of paper.  Time needed is 2 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_paper" }
        :component("paper", 5)
        :component("duct_tape", 1)
)

-- Layering paper sheets, cutting holes in them, laminating them with glue, and connecting multiple of resulting plates with cordage, per 162 g of paper.  Time needed is 50 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "armor_paper_lamellar" }
        :component("paper", 50)
        :component_any {
            { id = "glue_strong", count = 4 },
            { id = "glue_weak", count = 1 },
        }
        :component("cordage_short", 2, true)
        :quality("CUT", 2, 1)
)

-- Shaping and tying together multiple wood pieces of same size with lots of cordage, per 1463 g of wood.  Time needed is 30 minutes per unit.  Works for lamellar wooden armor as well as for planks tied to limbs.
content.merge_requirement(
    content.Requirement { id = "armor_wood" }
        :component("2x4", 1)
        :component("cordage", 2, true)
        :quality("SAW_W", 2, 1)
        :quality("CUT", 2, 1)
)

-- A small piece of fabric or leather to strap something firmly to the body.  Stronger than a bit of string.
content.merge_requirement(
    content.Requirement { id = "strap_small" }
        :component_any {
            { id = "cotton_patchwork", count = 3 },
            { id = "leather", count = 3 },
            { id = "fur", count = 3 },
            { id = "strap_cotton", count = 1 },
        }
        :quality("SEW", 1, 1)
        :quality("CUT", 2, 1)
)

-- A long piece of fabric or leather to strap something firmly to the body.  Stronger than a bit of string.
content.merge_requirement(
    content.Requirement { id = "strap_large" }
        :component_any {
            { id = "cordage_short", count = 1, requirement = true },
            { id = "leather", count = 4 },
            { id = "fur", count = 4 },
            { id = "strap_cotton", count = 1 },
        }
        :quality("SEW", 1, 1)
        :quality("CUT", 2, 1)
)

-- Dyeing cloth items, per 500 ml of dyed cloth.  Use only for fancy clothing, otherwise it's unnecessary.  Takes 720 minutes, this doesn't depend on amount.
content.merge_requirement(
    content.Requirement { id = "dye_cloth" }
        :component_any {
            { id = "dye_powder", count = 5 },
            { id = "tanbark", count = 1 },
            { id = "coffee_raw", count = 1 },
            { id = "coffee_raw_kentucky", count = 1 },
            { id = "tea_raw", count = 1 },
            { id = "mustard", count = 48 },
            { id = "acorns", count = 1 },
            { id = "wild_herbs", count = 100 },
            { id = "raw_dandelion", count = 4 },
            { id = "sugar_beet", count = 1 },
            { id = "carrot", count = 12 },
            { id = "carrot_wild", count = 6 },
            { id = "onion", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "cranberries", count = 3 },
            { id = "raspberries", count = 1 },
            { id = "huckleberries", count = 1 },
            { id = "mulberries", count = 1 },
            { id = "elderberries", count = 1 },
            { id = "chokeberries", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "cherries", count = 1 },
            { id = "grapes", count = 1 },
            { id = "pomegranate", count = 1 },
            { id = "rose_hips", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "celery", count = 1 },
            { id = "mushroom", count = 1 },
        }
        :component_any {
            { id = "ammonia_liquid", count = 2 },
            { id = "vinegar", count = 16 },
            { id = "ash", count = 10 },
            { id = "tanbark", count = 1 },
            { id = "salt", count = 100 },
            { id = "chem_potassium_alum", count = 100 },
        }
        :component_any {
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 },
        }
        :tool_charges("surface_heat", 5, true)
        :quality("COOK", 3, 1)
)

-- All kinds of fasteners for jacket-sized soft objects.
content.merge_requirement(
    content.Requirement { id = "fastener_large" }
        :component_any {
            { id = "zipper_long_plastic", count = 1 },
            { id = "button_plastic", count = 9 },
            { id = "touch_fastener", count = 6 },
            { id = "snapfastener_steel", count = 9 },
            { id = "string_6", count = 6 },
            { id = "cordage_6_leather", count = 6 },
        }
)

-- All kinds of fasteners for footwear-sized soft objects, including pockets.
content.merge_requirement(
    content.Requirement { id = "fastener_small" }
        :component_any {
            { id = "button_plastic", count = 3 },
            { id = "zipper_short_plastic", count = 1 },
            { id = "snapfastener_steel", count = 3 },
            { id = "touch_fastener", count = 2 },
            { id = "string_6", count = 2 },
            { id = "cordage_6_leather", count = 2 },
        }
)

-- Identical in every way to fastener_small but given string_6 first so that world objects spawn with shoelaces as those are much more common than button or zipper shoes.
content.merge_requirement(
    content.Requirement { id = "fastener_shoes" }
        :component_any {
            { id = "string_6", count = 2 },
            { id = "cordage_6_leather", count = 2 },
            { id = "zipper_short_plastic", count = 1 },
            { id = "snapfastener_steel", count = 3 },
            { id = "touch_fastener", count = 2 },
            { id = "button_plastic", count = 3 },
        }
)

-- All kinds of fasteners for strapped-on objects like belts, per single strap.
content.merge_requirement(
    content.Requirement { id = "clasps" }
        :component_any {
            { id = "button_plastic", count = 1 },
            { id = "snapfastener_steel", count = 2 },
            { id = "buckle_steel", count = 1 },
            { id = "touch_fastener", count = 2 },
            { id = "string_6", count = 2 },
            { id = "cordage_6_leather", count = 2 },
        }
)

-- Melting and reshaping plastic items through the use of vacuum forming molds, per 70 g of plastic. Usually takes 30 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "plastic_molding" }
        :component("polycarbonate_sheet", 1)
        :tool_any {
            { id = "makeshift_vacuum_mold", charges = 4 },
            { id = "vac_mold", charges = 2 },
        }
        :tool_charges("surface_heat", 5, true)
        :quality("CUT", 2, 1)
)

-- 35g per unit. Crafting cotton items, adjusted for tailoring rework. 3g+excessive weight of material is wasted, producing patches or scraps. Time needed is usually 30 minutes per unit if hand-stitching. This uses roughly 50 inches of thread to account for waste.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton" }
        :component("sheet_cotton", 1)
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- Crafting cotton items via knitting, per 1 g of cotton; no material wasted.  Time needed is usually 2 minutes per unit if doing it by hand.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_knitting" }
        :component("thread", 1)
        :quality("KNIT", 1, 1)
)

-- 35g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 30 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet)
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_patchwork" }
        :component_any {
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 35g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 30 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_patchwork_simple" }
        :component_any {
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)

-- 5g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 15 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing cotton scraps.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_small" }
        :component("cotton_patchwork", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 5g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 15 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing cotton scraps.  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_small_simple" }
        :component("cotton_patchwork", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)

-- 85g per unit. Crafting denim items, adjusted for tailoring rework. 7g+excessive weight of material is wasted, producing patches or scraps. Time needed is usually 40 minutes per unit if hand-stitching. This uses roughly 50 inches of thread to account for waste.
content.merge_requirement(
    content.Requirement { id = "tailoring_denim" }
        :component("sheet_denim", 1)
        :component("filament", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 85g per unit. Crafting possibly-patchwork denim items, adjusted for tailoring rework. Time needed is usually 40 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet)
content.merge_requirement(
    content.Requirement { id = "tailoring_denim_patchwork" }
        :component_any {
            { id = "sheet_denim", count = 1 },
            { id = "sheet_denim_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 14g per unit. Crafting possibly-patchwork denim items, adjusted for tailoring rework. Time needed is usually 20 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing denim scraps.
content.merge_requirement(
    content.Requirement { id = "tailoring_denim_small" }
        :component("denim_patch", 1)
        :component("filament", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 14g per unit. Crafting possibly-patchwork denim items, adjusted for tailoring rework. Time needed is usually 20 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing denim scraps.
content.merge_requirement(
    content.Requirement { id = "tailoring_denim_small_simple" }
        :component("denim_patch", 1)
        :component("filament", 5, true)
        :quality("SEW", 2, 1)
        :quality("CUT", 1, 1)
)

-- 85g per unit. Crafting canvas items, adjusted for tailoring rework. 7g+excessive weight of material is wasted, producing patches or scraps. Time needed is usually 40 minutes per unit if hand-stitching. This uses roughly 50 inches of thread to account for waste.
content.merge_requirement(
    content.Requirement { id = "tailoring_canvas" }
        :component("sheet_canvas", 1)
        :component("filament_canvas", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 85g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 40 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet)
content.merge_requirement(
    content.Requirement { id = "tailoring_canvas_patchwork" }
        :component_any {
            { id = "sheet_canvas", count = 1 },
            { id = "sheet_canvas_patchwork", count = 1 },
        }
        :component("filament_canvas", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 14g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 20 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing canvas scraps.
content.merge_requirement(
    content.Requirement { id = "tailoring_canvas_small" }
        :component("canvas_patch", 1)
        :component("filament_canvas", 5, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 350g per unit. Crafting faux fur items, per 371 g of faux fur with rework; 21 g + excessive weight of material is wasted, producing faux fur patches and scraps.  Time needed is usually 40 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_faux_fur" }
        :component("sheet_faux_fur", 1)
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- 350g per unit. Crafting possibly-patchwork faux fur items, per 371 g of faux fur; 21 g + excessive weight of material is wasted, producing faux fur patches and scraps.  Time needed is usually 40 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).
content.merge_requirement(
    content.Requirement { id = "tailoring_faux_fur_patchwork" }
        :component_any {
            { id = "sheet_faux_fur", count = 1 },
            { id = "sheet_faux_fur_patchwork", count = 1 },
        }
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- 40g per unit. Crafting possibly-patchwork faux fur items, per 46 g of faux fur; 6 g + excessive weight of material is wasted, producing faux fur scraps.  Time needed is usually 25 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).
content.merge_requirement(
    content.Requirement { id = "tailoring_faux_fur_small" }
        :component("faux_fur", 1)
        :component("filament", 4, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- 25g per unit. Crafting felt items (not via knitting), per 28 g of felt; 3 g + excessive weight of material is wasted, producing felt patches as byproducts.  Time needed is usually 35 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_felt" }
        :component("sheet_felt", 1)
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 2, 1)
)

-- 25g per unit. Crafting possibly-patchwork felt items (not via knitting), per 28 g of felt; 3 g + excessive weight of material is wasted, producing felt patches as byproducts.  Time needed is usually 35 minutes per unit if hand-stitching. (most of the time actually needed goes into making a patchwork sheet)
content.merge_requirement(
    content.Requirement { id = "tailoring_felt_patchwork" }
        :component_any {
            { id = "sheet_felt", count = 1 },
            { id = "sheet_felt_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 25g per unit. Crafting possibly-patchwork felt items (not via knitting), per 28 g of felt; 3 g + excessive weight of material is wasted, producing felt patches as byproducts.  Time needed is usually 35 minutes per unit if hand-stitching. (most of the time actually needed goes into making a patchwork sheet).  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_felt_patchwork_simple" }
        :component_any {
            { id = "sheet_felt", count = 1 },
            { id = "sheet_felt_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)

-- 3g per unit. Crafting possibly-patchwork felt items (not via knitting), per 3.4 g of felt; .4 g + excessive weight of material is wasted, producing felt scraps as byproducts.  Time needed is usually 15 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_felt_small" }
        :component("felt_patch", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 250g per unit. Crafting fur items, per 372 g of fur; 122 g + excessive weight of material is wasted, producing fur patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching for extra material processing time.
content.merge_requirement(
    content.Requirement { id = "tailoring_fur" }
        :component("tanned_pelt", 1)
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- 250g per unit. Crafting fur items, per 372 g of fur; 122 g + excessive weight of material is wasted, producing fur patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching for extra material processing time.
content.merge_requirement(
    content.Requirement { id = "tailoring_fur_patchwork" }
        :component_any {
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 },
        }
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- 250g per unit. Crafting fur items, per 372 g of fur; 122 g + excessive weight of material is wasted, producing fur patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching for extra material processing time.  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_fur_patchwork_simple" }
        :component_any {
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 },
        }
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 35g per unit. Crafting either small or patchwork fur items, per 46 g of fur; 11 g + excessive weight of material is wasted, producing fur patches as byproducts.  Time needed is usually 15 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_fur_small" }
        :component("fur", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- Crafting Kevlar items, per 26 g of Kevlar; 6 g + excessive weight of material is wasted, producing Kevlar scraps as byproducts.  Time needed is usually 40 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_kevlar_fabric" }
        :component_any {
            { id = "sheet_kevlar", count = 1 },
            { id = "sheet_kevlar_patchwork", count = 1 },
        }
        :component("filament_durable", 6, true)
        :quality("SEW", 2, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- 275g per unit. Crafting leather items, per 296 g of leather; 21 g + excessive weight of material is wasted, producing leather patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_leather" }
        :component("tanned_hide", 1)
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 275g per unit. Crafting leather items, per 296 g of leather; 21 g + excessive weight of material is wasted, producing leather patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_leather_patchwork" }
        :component_any {
            { id = "sheet_leather", count = 1 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 },
        }
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 275g per unit. Crafting leather items, per 296 g of leather; 21 g + excessive weight of material is wasted, producing leather patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching.  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_leather_patchwork_simple" }
        :component_any {
            { id = "sheet_leather", count = 1 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 },
        }
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 35g per unit. Crafting either small or patchwork leather items, per 37 g of leather; 2 g + excessive weight of material is wasted, producing leather patches as byproducts.  Time needed is usually 15 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_leather_small" }
        :component("leather", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 35g per unit. Crafting either small or patchwork leather items, per 37 g of leather; 2 g + excessive weight of material is wasted, producing leather patches as byproducts.  Time needed is usually 15 minutes per unit if hand-stitching. Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_leather_small_simple" }
        :component("leather", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("LEATHER_AWL", 1, 1)
)

-- 30g per unit. Crafting Lycra items, per 33 g of Lycra; 3 g + excessive weight of material is wasted, producing Lycra scraps as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_lycra" }
        :component("sheet_lycra", 1)
        :component("thread_nomex", 5)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 30g per unit. Crafting possibly-patchwork Lycra items, per 33 g of Lycra; 3 g + excessive weight of material is wasted, producing Lycra scraps as byproducts.  Time needed is usually 90 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).
content.merge_requirement(
    content.Requirement { id = "tailoring_lycra_patchwork" }
        :component_any {
            { id = "sheet_lycra", count = 1 },
            { id = "sheet_lycra_patchwork", count = 1 },
        }
        :component("thread_nomex", 5)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 4g per unit. Crafting possibly-patchwork Lycra items, per 4.18 g of Lycra; .18 g + excessive weight of material is wasted, producing Lycra scraps as byproducts.  Time needed is usually 30 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_lycra_small" }
        :component("lycra_patch", 1)
        :component("thread_nomex", 3)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 25g per unit. Crafting neoprene items, per 26 g of neoprene; 1 g + excessive weight of material is wasted, producing neoprene scraps as byproducts.  Superglue and duct tape will usually be needed for extra waterproofing.  Time needed is usually 60 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_neoprene" }
        :component("sheet_neoprene", 1)
        :component("filament", 5, true)
        :quality("SEW_CURVED", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 25g per unit. Crafting possibly-patchwork neoprene items, per 26 g of neoprene; 1 g + excessive weight of material is wasted, producing neoprene scraps as byproducts.  Superglue and duct tape will usually be needed for extra waterproofing.  Time needed is usually 60 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).
content.merge_requirement(
    content.Requirement { id = "tailoring_neoprene_patchwork" }
        :component_any {
            { id = "sheet_neoprene", count = 1 },
            { id = "sheet_neoprene_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW_CURVED", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 3g per unit. Crafting possibly-patchwork neoprene items, per 3 g of neoprene; .5 g + excessive weight of material is wasted, producing neoprene scraps as byproducts.  Superglue and duct tape will usually be needed for extra waterproofing.  Time needed is usually 30 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_neoprene_small" }
        :component("neoprene", 1)
        :component("filament", 3, true)
        :quality("SEW_CURVED", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 30g per unit. Crafting Nomex items, per 32 g of Nomex; 2 g + excessive weight of material is wasted, producing Nomex scraps as byproducts.  Time needed is usually 45 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_nomex" }
        :component("sheet_nomex", 1)
        :component_any {
            { id = "thread_nomex", count = 5 },
            { id = "thread_kevlar", count = 5 },
        }
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- 30g per unit. Crafting possibly-patchwork Nomex items, per 32 g of Nomex; 2 g + excessive weight of material is wasted, producing Nomex scraps as byproducts.  Time needed is usually 45 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_nomex_patchwork" }
        :component_any {
            { id = "sheet_nomex", count = 1 },
            { id = "sheet_nomex_patchwork", count = 1 },
        }
        :component_any {
            { id = "thread_nomex", count = 5 },
            { id = "thread_kevlar", count = 5 },
        }
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- 3g per unit. Crafting small Nomex items, per 32 g of Nomex; 1 g + excessive weight of material is wasted, producing Nomex scraps as byproducts.
content.merge_requirement(
    content.Requirement { id = "tailoring_nomex_small" }
        :component("nomex", 1)
        :component_any {
            { id = "thread_nomex", count = 3 },
            { id = "thread_kevlar", count = 3 },
        }
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- 40g per unit. Crafting synthetic fabric items, per 46 g of nylon; 6 g + excessive weight of material is wasted, producing synthetic fabric scraps as byproducts.  Time needed is usually 30 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_nylon" }
        :component("sheet_nylon", 1)
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 40g per unit. Crafting possibly-patchwork synthetic fabric items, per 46 g of nylon; 6 g + excessive weight of material is wasted, producing synthetic fabric scraps as byproducts.  Time needed is usually 30 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet).
content.merge_requirement(
    content.Requirement { id = "tailoring_nylon_patchwork" }
        :component_any {
            { id = "sheet_nylon", count = 1 },
            { id = "sheet_nylon_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 5g per unit. Crafting possibly-patchwork synthetic fabric items, per 6 g of nylon; 1 g + excessive weight of material is wasted, producing synthetic fabric scraps as byproducts.  Time needed is usually 25 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_nylon_patchwork_small" }
        :component("nylon", 1)
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- Crafting wool items via knitting, per 1 g of wool; no material wasted.  Time needed is usually 2 minutes per unit if doing it by hand.
content.merge_requirement(
    content.Requirement { id = "tailoring_wool_knitting" }
        :component("yarn", 1)
        :quality("KNIT", 1, 1)
)

-- Waterproofing cloth items, per 500 ml of waterproofed cloth.  Takes 360 minutes, doesn't depend on amount.  Duct tape is needed to waterproof seams.
content.merge_requirement(
    content.Requirement { id = "waterproofing_cloth" }
        :component("chem_potassium_alum", 50)
        :component("detergent", 10)
        :component_any {
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 },
        }
        :component("duct_tape", 5)
        :tool_charges("water_boiling_heat", 2, true)
        :quality("COOK", 3, 1)
        :quality("CUT", 2, 1)
)

-- Making a waterproof layer from plastic sheets duct taped together, per 0.2 m2.
content.merge_requirement(
    content.Requirement { id = "waterproofing_plastic_sheets" }
        :component("plastic_sheet_small", 1)
        :component("duct_tape", 5)
        :quality("CUT", 1, 1)
)

-- Enough to make one tanned hide/pelt
content.merge_requirement(
    content.Requirement { id = "tanning_agent" }
        :component_any {
            { id = "tanbark", count = 1 },
            { id = "acorns", count = 2 },
            { id = "hops", count = 2 },
            { id = "pine_bough", count = 6 },
            { id = "meat_brain", count = 3, requirement = true },
        }
)

-- 1 unit of 'sewing_tool' is 1 minute of sewing.
-- Sewing maching is 84W, 1 charge is 1kj so that's 12s of use. I'm assuming the machine is only running 50% of the time so 24s. 60 / 24 = 2.5 rounded down to 2.
content.merge_requirement(
    content.Requirement { id = "sewing_tool" }
        :tool_any {
            { id = "sewing_machine", charges = 2 },
            { id = "needle_bone", count = 1 },
            { id = "needle_wood", count = 1 },
            { id = "needle_steel", count = 1 },
            { id = "sewing_kit", count = 1 },
            { id = "tailors_kit", count = 1 },
        }
        :quality("SEW", 1, 1)
)

-- requirements/toolsets.json

-- Forming bullets from raw materials.
content.merge_requirement(
    content.Requirement { id = "bullet_forming" }
        :tool("press", 1)
        :tool_any {
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 },
            { id = "integrated_welder", charges = 2 },
        }
        :tool("tongs", 1)
        :tool("tape_measure", 1)
        :tool("swage", 1)
        :tool("arbor_press", 1)
        :tool_any {
            { id = "gloves_medical", count = 1 },
            { id = "gloves_rubber", count = 1 },
            { id = "entry_suit", count = 1 },
            { id = "hazmat_suit", count = 1 },
        }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 },
            { id = "pressure_cooker", count = 1 },
        }
)

-- Forming of shot from raw materials
content.merge_requirement(
    content.Requirement { id = "shot_forming" }
        :component("any_water", 1, true)
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 },
        }
        :tool_any {
            { id = "ladle", count = 1 },
            { id = "ceramic_mug", count = 1 },
            { id = "ceramic_cup", count = 1 },
            { id = "teapot", count = 1 },
            { id = "clay_teapot", count = 1 },
            { id = "can_food", count = 1 },
        }
        :tool_any {
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 },
            { id = "integrated_welder", charges = 2 },
        }
)

-- Gun cleaning
content.merge_requirement(
    content.Requirement { id = "gun_cleaning" }
        :component_any {
            { id = "gasoline", count = 125 },
            { id = "diesel", count = 125 },
            { id = "chem_ethanol", count = 125 },
            { id = "chem_methanol", count = 125 },
            { id = "methed_alcohol", count = 125 },
            { id = "denat_alcohol", count = 125 },
            { id = "chem_acetone", count = 1 },
            { id = "chem_chloroform", count = 125 },
            { id = "ether", count = 125 },
            { id = "chem_DMSO", count = 125 },
            { id = "vinegar", count = 8 },
            { id = "ammonia_hydroxide", count = 1 },
            { id = "bleach", count = 1 },
        }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fur", count = 1 },
            { id = "faux_fur", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "cotton_ball", count = 2 },
        }
        :tool_any {
            { id = "pipe_cleaner", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
        }
        :quality("SCREW", 1, 1)
)

-- BP requires hot soapy water
content.merge_requirement(
    content.Requirement { id = "gun_cleaning_bp" }
        :component("soapy_water", 3)
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fur", count = 1 },
            { id = "faux_fur", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "cotton_ball", count = 2 },
        }
        :tool_any {
            { id = "pipe_cleaner", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
        }
        :tool_charges("water_boiling_heat", 2, true)
        :quality("SCREW", 1, 1)
)

-- Requires a rod/wire and cloth patch or similar item.
content.merge_requirement(
    content.Requirement { id = "gun_cleaning_quick" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fur", count = 1 },
            { id = "faux_fur", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "cotton_ball", count = 2 },
        }
        :tool_any {
            { id = "pipe_cleaner", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
        }
)

-- Gun Lubrication
content.merge_requirement(
    content.Requirement { id = "gun_lubrication" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fur", count = 1 },
            { id = "faux_fur", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "cotton_ball", count = 2 },
        }
        :component_any {
            { id = "lamp_oil", count = 5 },
            { id = "cooking_oil", count = 1 },
            { id = "motor_oil", count = 5 },
        }
        :tool_any {
            { id = "pipe_cleaner", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
        }
)

-- Firing various clay shapes to make earthenware
content.merge_requirement(
    content.Requirement { id = "earthenware_firing" }
        :tool_any {
            { id = "fire", count = 1 },
            { id = "fake_clay_kiln", charges = 1 },
            { id = "kiln", charges = 1 },
        }
)

-- Forging of steel items (per steel chunk), charcoal forge is already a substitute for forge
content.merge_requirement(
    content.Requirement { id = "forging_standard" }
        :tool_any {
            { id = "forge", charges = 20 },
            { id = "oxy_torch", charges = 20 },
        }
)

-- Forging of steel items (per scrap metal), charcoal forge is already a substitute for forge
content.merge_requirement(
    content.Requirement { id = "forging_scrap" }
        :tool_any {
            { id = "forge", charges = 4 },
            { id = "oxy_torch", charges = 4 },
        }
)

-- Includes forging resources as well as tools needed for most blacksmithing. Per forging_standard energy cost balanced for one steel chunk. Flux amount is equivalent to a small teaspoon.
content.merge_requirement(
    content.Requirement { id = "blacksmithing_simple" }
        :component("flux_fe_forge", 1, true)
        :tool_any {
            { id = "forge", charges = 20 },
            { id = "oxy_torch", charges = 20 },
        }
        :tool_charges("metal_file_any", 1, true)
        :tool_charges("metalworking_tongs_any", 1, true)
        :quality("ANVIL", 2, 1)
        :quality("HAMMER", 2, 1)
)

-- Includes forging resources as well as tools needed for most blacksmithing. Per forging_standard energy cost balanced for one steel chunk. Flux amount is equivalent to a small teaspoon.
content.merge_requirement(
    content.Requirement { id = "blacksmithing_standard" }
        :component("flux_fe_forge", 1, true)
        :tool_any {
            { id = "forge", charges = 20 },
            { id = "oxy_torch", charges = 20 },
        }
        :tool_charges("metal_file_any", 1, true)
        :tool_charges("metalworking_tongs_any", 1, true)
        :quality("ANVIL", 3, 1)
        :quality("HAMMER", 3, 1)
)

content.merge_requirement(
    content.Requirement { id = "blacksmithing_standard_fileless" }
        :tool_any {
            { id = "forge", charges = 20 },
            { id = "oxy_torch", charges = 20 },
        }
        :tool_charges("metalworking_tongs_any", 1, true)
        :quality("ANVIL", 3, 1)
        :quality("HAMMER", 3, 1)
)

-- Includes forging resources as well as tools needed for most blacksmithing. Per forging_scrap energy cost balanced for one scrap metal.
content.merge_requirement(
    content.Requirement { id = "blacksmithing_scrap" }
        :tool_any {
            { id = "forge", charges = 4 },
            { id = "oxy_torch", charges = 4 },
        }
        :tool_charges("metal_file_any", 1, true)
        :tool_charges("metalworking_tongs_any", 1, true)
        :quality("ANVIL", 3, 1)
        :quality("HAMMER", 3, 1)
)

-- Production of mutagens.
content.merge_requirement(
    content.Requirement { id = "mutagen_production_standard" }
        :tool_charges("surface_heat", 1, true)
        :quality("CHEM", 3, 1)
        :quality("SEPARATE", 1, 1)
        :quality("ANALYSIS", 1, 1)
)

-- Pickaxe tools
content.merge_requirement(
    content.Requirement { id = "pickaxe_list" }
        :tool_any {
            { id = "pickaxe", count = 1 },
            { id = "bronze_pickaxe", count = 1 },
        }
)

-- Production of mutagenic serums.
content.merge_requirement(
    content.Requirement { id = "serum_production_standard" }
        :tool_charges("surface_heat", 1, true)
        :quality("CHEM", 3, 1)
        :quality("FINE_DISTILL", 1, 1)
        :quality("CONCENTRATE", 1, 1)
)

-- Crafting or repair of fabric items, includes roughly 10 inches of thread.
content.merge_requirement(
    content.Requirement { id = "sewing_standard" }
        :component("filament", 1, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 2, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- crafting or repair of aramid based fabrics (nomex, kevlar). Aramid threads are abrasive and require a stronger needle. they also have special cutting considerations.
content.merge_requirement(
    content.Requirement { id = "sewing_aramids" }
        :component("advanced_filament", 1, true)
        :quality("SEW", 3, 1)
        :quality("CUT", 2, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- Crafting or repair of Kevlar/aramid items. This was added in the middle of the tailoring overhaul, i'll be migrating to sewing_aramids
content.merge_requirement(
    content.Requirement { id = "sewing_kevlar" }
        :component("filament_durable", 1, true)
        :quality("SEW", 2, 1)
        :quality("CUT", 2, 1)
        :quality("FABRIC_CUT", 2, 1)
)

-- Crafting or repair of fabric simple items where exact shape is not important, such as cloaks and blankets, includes roughly 10 inches of thread.
content.merge_requirement(
    content.Requirement { id = "sewing_simple" }
        :component("filament", 1, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)

-- Crafting of steel/iron items or installation of vehicle parts, measured in 1 cm segments - assume roughly 360 cm per hour, 10 seconds per # of this quality
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "welding_standard", name = content.text("Welding tools") }
        :component_any {
            { id = "welding_rod_steel", count = 1 },
            { id = "welding_wire_steel", count = 1 },
            { id = "brazing_rod_bronze", count = 1 },
        }
        :tool_any {
            { id = "welder", charges = 20 },
            { id = "welding_kit", charges = 20 },
            { id = "welder_crude", charges = 40 },
            { id = "integrated_welder", charges = 30 },
            { id = "oxy_torch", charges = 1 },
        }
        :quality("GLARE", 1, 1)
)

-- Crafting items made of aluminum alloy or installation of vehicle parts, currently making the same assumption for time/coverage as steel
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "welding_alloys", name = content.text("Alloy welding tools") }
        :component_any {
            { id = "welding_rod_alloy", count = 1 },
            { id = "welding_wire_alloy", count = 1 },
            { id = "brazing_rod_alloy", count = 1 },
        }
        :tool_any {
            { id = "welder", charges = 20 },
            { id = "welding_kit", charges = 20 },
            { id = "welder_crude", charges = 40 },
            { id = "integrated_welder", charges = 30 },
            { id = "oxy_torch", charges = 1 },
        }
        :quality("GLARE", 1, 1)
)

-- Repair of steel/iron items - per 10 cm of weld (100 seconds each), done this way to use 1 chunk of steel per 10 cm
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "repair_welding_standard" }
        :component_any {
            { id = "welding_rod_steel", count = 10 },
            { id = "welding_wire_steel", count = 10 },
            { id = "brazing_rod_bronze", count = 10 },
        }
        :component("steel_chunk_any", 1, true)
        :tool_any {
            { id = "welder", charges = 200 },
            { id = "welding_kit", charges = 200 },
            { id = "welder_crude", charges = 400 },
            { id = "integrated_welder", charges = 300 },
            { id = "oxy_torch", charges = 10 },
        }
        :quality("GLARE", 1, 1)
        :quality("HAMMER", 2, 1)
)

-- Repair of mild steel items - per 10 cm of weld (100 seconds each), done this way to use 1 chunk of steel per 10 cm
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "repair_welding_lc_steel" }
        :component_any {
            { id = "welding_rod_steel", count = 10 },
            { id = "welding_wire_steel", count = 10 },
            { id = "brazing_rod_bronze", count = 10 },
        }
        :component("lc_steel_chunk", 1)
        :tool_any {
            { id = "welder", charges = 200 },
            { id = "welding_kit", charges = 200 },
            { id = "welder_crude", charges = 400 },
            { id = "integrated_welder", charges = 300 },
            { id = "oxy_torch", charges = 10 },
        }
        :quality("GLARE", 1, 1)
        :quality("HAMMER", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_superalloy" }
        :component_any {
            { id = "welding_rod_alloy", count = 10 },
            { id = "welding_wire_alloy", count = 10 },
            { id = "brazing_rod_alloy", count = 10 },
        }
        :component("alloy_sheet", 1)
        :tool_any {
            { id = "welder", charges = 200 },
            { id = "welding_kit", charges = 200 },
            { id = "welder_crude", charges = 400 },
            { id = "integrated_welder", charges = 300 },
            { id = "oxy_torch", charges = 10 },
        }
        :quality("GLARE", 1, 1)
        :quality("HAMMER", 2, 1)
)

-- Repair of aluminum items - per 10 cm of weld (100 seconds each), done this way to use 1 chunk of steel per 10 cm
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "repair_welding_alloys" }
        :component_any {
            { id = "welding_rod_alloy", count = 10 },
            { id = "welding_wire_alloy", count = 10 },
            { id = "brazing_rod_alloy", count = 10 },
        }
        :component("material_aluminium_ingot", 1)
        :tool_any {
            { id = "welder", charges = 200 },
            { id = "welding_kit", charges = 200 },
            { id = "welder_crude", charges = 400 },
            { id = "integrated_welder", charges = 300 },
            { id = "oxy_torch", charges = 10 },
        }
        :quality("GLARE", 1, 1)
        :quality("HAMMER", 2, 1)
)

-- Repair of rebar items - per 10 cm of weld (100 seconds each), done this way to use 1 rebar per 40 cm - you should use new rebar instead of repairing individual rebars
-- Arc welding is about 85% efficient, acetylene welding is about 40% efficient
content.merge_requirement(
    content.Requirement { id = "repair_welding_rebar" }
        :component_any {
            { id = "welding_rod_steel", count = 10 },
            { id = "welding_wire_steel", count = 10 },
            { id = "brazing_rod_bronze", count = 10 },
        }
        :component("rebar", 1)
        :tool_any {
            { id = "welder", charges = 800 },
            { id = "welding_kit", charges = 800 },
            { id = "welder_crude", charges = 1600 },
            { id = "oxy_torch", charges = 40 },
        }
        :quality("GLARE", 1, 1)
        :quality("SAW_M", 2, 1)
)

-- Construction of chainmail items
content.merge_requirement(
    content.Requirement { id = "chainmail_standard" }
        :tool("boltcutters", 1)
        :tool_any {
            { id = "cordless_drill", charges = 10 },
            { id = "corded_powerdrill", charges = 10 },
            { id = "drill_press_tool", charges = 5 },
        }
        :quality("HAMMER", 3, 1)
        :quality("ANVIL", 3, 1)
        :quality("WRENCH", 1, 1)
)

-- Soldering metal items
content.merge_requirement(
    content.Requirement { id = "soldering_standard", name = content.text("Soldering tools") }
        :component("solder_wire", 1)
        :tool_any {
            { id = "soldering_iron", charges = 1 },
            { id = "integrated_electrokit", charges = 1 },
            { id = "soldering_iron_portable", charges = 1 },
            { id = "integrated_welder", charges = 1 },
            { id = "small_repairkit", charges = 1 },
            { id = "large_repairkit", charges = 1 },
        }
)

-- Drilling holes in various materials, including steel
content.merge_requirement(
    content.Requirement { id = "drilling_standard", name = content.text("Drill") }
        :tool_any {
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 },
            { id = "drill_press_tool", charges = 1 },
            { id = "hand_drill", count = 1 },
        }
)

-- Drilling holes in various materials other than steel
content.merge_requirement(
    content.Requirement { id = "drilling_light", name = content.text("Light drill") }
        :tool_any {
            { id = "cordless_drill", charges = 1 },
            { id = "corded_powerdrill", charges = 1 },
            { id = "drill_press_tool", charges = 1 },
            { id = "hand_drill", count = 1 },
            { id = "makeshift_hand_drill", count = 2 },
        }
)

-- Rate of anesthetic used for a surgery in 1E-2 mL/kg/min.  Autodoc's interface only supports charges of anesthetic_kit, any other requirement will have unexpected results.
content.merge_requirement(
    content.Requirement { id = "anesthetic" }
        :tool_charges("anesthetic_kit", 6)
)

-- Cutting wires
content.merge_requirement(
    content.Requirement { id = "cutting_wire_standard", name = content.text("Wire cutters") }
        :tool_any {
            { id = "hacksaw", count = 1 },
            { id = "multitool", count = 1 },
            { id = "boltcutters", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
        }
)

-- tools that can grip harder than just your bare hands.
content.merge_requirement(
    content.Requirement { id = "pliers_standard", name = content.text("Pliers") }
        :tool_any {
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 },
            { id = "multitool", count = 1 },
            { id = "camping_multitool", count = 1 },
        }
)

-- for winding medium to small springs.
content.merge_requirement(
    content.Requirement { id = "spring_standard" }
        :component("qt_wire", 1)
        :tool_any {
            { id = "corded_powerdrill", charges = 5 },
            { id = "cordless_drill", charges = 5 },
            { id = "fake_lathe", charges = 5 },
        }
        :tool_any {
            { id = "stick", count = 1 },
            { id = "bamboo_stalk_dry", count = 1 },
            { id = "bamboo_stalk", count = 1 },
            { id = "small_lc_steel_bar_round", count = 1 },
            { id = "small_mc_steel_bar_round", count = 1 },
            { id = "small_hc_steel_bar_round", count = 1 },
            { id = "small_aluminum_bar_round", count = 1 },
        }
        :tool_charges("pliers_standard", 1, true)
        :tool_charges("cutting_wire_standard", 1, true)
        :quality("DRILL", 2, 1)
        :quality("FILE", 1, 1)
)

-- mopping
content.merge_requirement(
    content.Requirement { id = "mopping_standard" }
        :quality("MOP", 1, 1)
)

-- jackhammering
content.merge_requirement(
    content.Requirement { id = "jackhammering_standard_1_10" }
        :tool_any {
            { id = "jackhammer", charges = 5 },
            { id = "jackhammer_mining", charges = 5 },
            { id = "elec_jackhammer", charges = 66 },
            { id = "elec_jackhammer_mining", charges = 66 },
        }
)

-- jackhammering
content.merge_requirement(
    content.Requirement { id = "jackhammering_standard" }
        :tool_charges("jackhammering_standard_1_10", 10, true)
)

-- jackhammering
content.merge_requirement(
    content.Requirement { id = "jackhammering_standard_2_5" }
        :tool_charges("jackhammering_standard_1_10", 4, true)
)

-- mining
content.merge_requirement(
    content.Requirement { id = "mining_standard" }
        :tool_any {
            { id = "pickaxe_list", charges = 1, requirement = true },
            { id = "jackhammering_standard", charges = 6, requirement = true },
        }
)

-- Tools for casting and work hardening items made from bronze
content.merge_requirement(
    content.Requirement { id = "bronzesmithing_tools" }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
        }
        :quality("HAMMER", 2, 1)
        :quality("ANVIL", 2, 1)
)

-- should contain all the ink pens
content.merge_requirement(
    content.Requirement { id = "ink_standard", name = content.text("Writing implement") }
        :tool_any {
            { id = "pen", charges = 1 },
            { id = "black_pen", charges = 1 },
            { id = "blue_pen", charges = 1 },
            { id = "green_pen", charges = 1 },
            { id = "red_pen", charges = 1 },
        }
)

-- Things suitable for drawing or writing something on paper, cardboard, cloth or similar materials.
content.merge_requirement(
    content.Requirement { id = "drawing_tool" }
        :tool_any {
            { id = "ink_standard", charges = 1, requirement = true },
            { id = "pencil", charges = 1 },
            { id = "permanent_marker", charges = 1 },
            { id = "survival_marker", charges = 1 },
        }
)

-- Power tools able to make long, straight cuts
content.merge_requirement(
    content.Requirement { id = "power_saw_long" }
        :tool_any {
            { id = "tablesaw_tool", charges = 50 },
            { id = "circsaw_off", charges = 100 },
            { id = "bandsaw_tool", charges = 50 },
        }
)

-- Power tools able to make short, precise cuts
content.merge_requirement(
    content.Requirement { id = "power_saw_short" }
        :tool_any {
            { id = "mitresaw_tool", charges = 10 },
            { id = "circsaw_off", charges = 20 },
            { id = "bandsaw_tool", charges = 10 },
        }
)

-- Tools for removing concrete
content.merge_requirement(
    content.Requirement { id = "concrete_removal_standard" }
        :tool_any {
            { id = "jackhammering_standard_2_5", charges = 7, requirement = true },
            { id = "masonrysaw_off", charges = 200 },
            { id = "electric_masonrysaw_off", charges = 2640 },
            { id = "heavy_masonrysaw_off", charges = 100 },
            { id = "corded_demolition_hammer", charges = 1848 },
        }
        :tool_any {
            { id = "hammer_sledge", count = 1 },
            { id = "hammer_sledge_heavy", count = 1 },
        }
        :quality("HAMMER", 1, 1)
)

-- Tools for removing concrete walls. Smaller masonry saws can be used, but use double power to account for increased usage during deconstruction period.  Demo equipment is preferred.
content.merge_requirement(
    content.Requirement { id = "concrete_wall_removal_standard" }
        :tool_any {
            { id = "masonrysaw_off", charges = 200 },
            { id = "electric_masonrysaw_off", charges = 2640 },
            { id = "heavy_masonrysaw_off", charges = 100 },
            { id = "jackhammer_mining", charges = 140 },
            { id = "elec_jackhammer_mining", charges = 1848 },
            { id = "corded_demolition_hammer", charges = 1848 },
        }
        :tool_any {
            { id = "hammer_sledge", count = 1 },
            { id = "hammer_sledge_heavy", count = 1 },
        }
        :quality("HAMMER", 1, 1)
)

-- Tools for removing a wall, floor, or glass mounted in metal
content.merge_requirement(
    content.Requirement { id = "wall_floor_glass_removal_standard" }
        :tool_charges("angle_grinder", 200)
        :quality("HAMMER", 2, 1)
        :quality("CHISEL", 2, 1)
        :quality("PRY", 3, 1)
        :quality("DIG", 3, 1)
)

-- Tools for removing a wall, floor, or glass mounted in wood
-- The farrier's nail_puller can't be used with a hammer, but it probably has enough leverage on its own.
content.merge_requirement(
    content.Requirement { id = "wood_removal_standard" }
        :tool_any {
            { id = "claw_bar", count = 1 },
            { id = "nail_puller_bronze", count = 1 },
            { id = "nail_puller", count = 1 },
        }
        :quality("HAMMER", 2, 1)
        :quality("CHISEL", 2, 1)
        :quality("PRY", 1, 1)
        :quality("DIG", 3, 1)
)

-- Tools for removing a linoleum tile
content.merge_requirement(
    content.Requirement { id = "linoleum_removal_standard" }
        :quality("HAMMER", 2, 1)
        :quality("CHISEL", 2, 1)
)

-- Tools for removing road / sidewalk
content.merge_requirement(
    content.Requirement { id = "road_removal_standard" }
        :tool_any {
            { id = "pickaxe_list", charges = 1, requirement = true },
            { id = "jackhammering_standard_2_5", charges = 7, requirement = true },
        }
        :tool_any {
            { id = "masonrysaw_off", charges = 100 },
            { id = "electric_masonrysaw_off", charges = 1320 },
        }
        :quality("PRY", 3, 1)
)

-- Tools for removing metal bars / rebar / etc
content.merge_requirement(
    content.Requirement { id = "metal_removal_standard" }
        :tool_any {
            { id = "hacksaw", count = 1 },
            { id = "small_repairkit", count = 1 },
            { id = "large_repairkit", count = 1 },
            { id = "angle_grinder", charges = 200 },
            { id = "reciprocating_saw", charges = 200 },
            { id = "exodii_prybar", charges = 200 },
        }
        :quality("SAW_M", 2, 1)
)

-- Tools for removing things like locked metal doors, which won't have easy to access points to place a manual saw
content.merge_requirement(
    content.Requirement { id = "metal_removal_high_standard" }
        :tool_any {
            { id = "angle_grinder", charges = 200 },
            { id = "exodii_prybar", charges = 200 },
        }
        :quality("SAW_M", 8, 1)
)

-- Tools for deconstructing items built with mortar or cement
content.merge_requirement(
    content.Requirement { id = "cement_removal" }
        :quality("HAMMER", 2, 1)
        :quality("CHISEL", 2, 1)
        :quality("PRY", 3, 1)
)

-- Tools to mark a hard surface.
content.merge_requirement(
    content.Requirement { id = "marking_hard" }
        :tool_any {
            { id = "ink_standard", charges = 50, requirement = true },
            { id = "medical_tape", charges = 25 },
            { id = "duct_tape", charges = 25 },
            { id = "permanent_marker", charges = 25 },
            { id = "survival_marker", count = 1 },
            { id = "paint", charges = 1, requirement = true },
        }
)

-- Tools to mark a soft, rough surface.
content.merge_requirement(
    content.Requirement { id = "marking_soft" }
        :tool_any {
            { id = "duct_tape", charges = 25 },
            { id = "survival_marker", count = 1 },
            { id = "paint", charges = 1, requirement = true },
        }
)

-- Disposable or reusable gloves.
content.merge_requirement(
    content.Requirement { id = "ppe_gloves", name = content.text("Protective gloves") }
        :tool_any {
            { id = "gloves_medical", count = 1 },
            { id = "gloves_rubber", count = 1 },
            { id = "entry_suit", count = 1 },
            { id = "hazmat_suit", count = 1 },
        }
)

-- Full eye protection, thick or shatterproof. Also includes some masks with appropriate coverage.
content.merge_requirement(
    content.Requirement { id = "ppe_eyes", name = content.text("Eye protection") }
        :tool_any {
            { id = "glass_goggles", count = 1 },
            { id = "survivor_goggles", count = 1 },
            { id = "goggles_ski", count = 1 },
            { id = "glasses_safety", count = 1 },
            { id = "glasses_bal", count = 1 },
            { id = "mask_gas", count = 1 },
            { id = "mask_gas_xs", count = 1 },
            { id = "mask_gas_xl", count = 1 },
            { id = "mask_bunker", count = 1 },
            { id = "goggles_chem", charges = 1 },
            { id = "mask_survivor", charges = 1 },
            { id = "mask_survivorxs", charges = 1 },
            { id = "mask_survivorxl", charges = 1 },
            { id = "mask_hsurvivor", charges = 1 },
            { id = "mask_hsurvivorxl", charges = 1 },
            { id = "mask_hsurvivorxs", charges = 1 },
        }
)

-- Gas protection.
content.merge_requirement(
    content.Requirement { id = "ppe_gas", name = content.text("Gas protection") }
        :tool_any {
            { id = "mask_filter", charges = 2 },
            { id = "mask_gas", charges = 1 },
            { id = "mask_gas_xs", charges = 1 },
            { id = "mask_gas_xl", charges = 1 },
            { id = "mask_gas_half", charges = 1 },
            { id = "mask_bunker", charges = 1 },
            { id = "mask_survivor", charges = 1 },
            { id = "mask_survivorxs", charges = 1 },
            { id = "mask_survivorxl", charges = 1 },
            { id = "mask_hsurvivor", charges = 1 },
            { id = "mask_hsurvivorxl", charges = 1 },
            { id = "mask_hsurvivorxs", charges = 1 },
            { id = "mask_lsurvivor", charges = 1 },
            { id = "mask_lsurvivorxl", charges = 1 },
            { id = "mask_lsurvivorxs", charges = 1 },
        }
)

-- Torso and arm protection, either chemical/flame resistant or easy to remove.
content.merge_requirement(
    content.Requirement { id = "ppe_skin", name = content.text("Skin protection") }
        :tool_any {
            { id = "coat_lab", count = 1 },
            { id = "hazmat_suit", count = 1 },
            { id = "jacket_chef", count = 1 },
            { id = "entry_suit", count = 1 },
            { id = "folding_poncho", count = 1 },
            { id = "coat_rain", count = 1 },
            { id = "bunker_coat", count = 1 },
            { id = "entry_suit_xs", count = 1 },
            { id = "xl_entry_suit", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "hotcut_any" }
        :tool_any {
            { id = "hotcut", count = 1 },
            { id = "hotcut_bronze", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "metalworking_tongs_any" }
        :tool_any {
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "metal_file_any" }
        :tool_any {
            { id = "metal_file", count = 1 },
            { id = "bronze_file", count = 1 },
            { id = "belt_grinder", charges = 25 },
        }
)

-- Something able to do fine cuts, allowing to extract small teeth without damaging them
-- The comment called for adequate protection. When a way to check for that without writing down and keeping updated a list of anything that can protect the arms in the requirements, add arm protection requirement
-- Can instead add arm damage risk, mitigated by skill and reduced by armor, when such a thing becomes possible
content.merge_requirement(
    content.Requirement { id = "nm_teeth_removal" }
        :quality("CUT_FINE", 2, 1)
)

-- Long rope used as a tool, in construction process and so on
content.merge_requirement(
    content.Requirement { id = "tool_rope_long" }
        :tool_any {
            { id = "rope_30", count = 1 },
            { id = "rope_makeshift_30", count = 1 },
            { id = "vine_30", count = 1 },
            { id = "grapnel", count = 1 },
            { id = "chain", count = 1 },
            { id = "hd_tow_cable", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "rivet_setting" }
        :component("rivets", 1)
        :quality("ANVIL", 3, 1)
        :quality("HAMMER", 3, 1)
        :quality("DRILL", 3, 1)
)

content.merge_requirement(
    content.Requirement { id = "rivet_replacement" }
        :component("rivets", 1)
        :quality("ANVIL", 3, 1)
        :quality("HAMMER", 3, 1)
        :quality("FILE", 2, 1)
)

-- Quenching hot metal items
content.merge_requirement(
    content.Requirement { id = "quench" }
        :tool_any {
            { id = "water", charges = 1 },
            { id = "water_clean", charges = 1 },
        }
        :tool("metal_tank", 1)
)

content.merge_requirement(
    content.Requirement { id = "smelting_standard" }
        :tool_any {
            { id = "forge", charges = 1 },
            { id = "oxy_torch", charges = 1 },
        }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
        }
        :tool_any {
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 },
        }
        :tool("casting_mold", 1)
)

-- requirements/uncraft.json

-- Result of disassembling books, magazines and similar items
content.merge_requirement(
    content.Requirement { id = "uncraft_book" }
        :component("paper", 1)
)

-- requirements/vehicle.json

-- Compatible with legacy flag TOOL_WRENCH or when installing wheels
content.merge_requirement(
    content.Requirement { id = "vehicle_fasten" }
        :tool_any {
            { id = "lug_wrench", count = 1 },
            { id = "wrench_large", count = 1 },
            { id = "cordless_impact_wrench", charges = 100 },
        }
)

-- Compatible with legacy flag TOOL_WRENCH or when doing jobs with quality 1 wrenching
content.merge_requirement(
    content.Requirement { id = "vehicle_wrench_1" }
        :quality("WRENCH", 1, 1)
)

-- Compatible with legacy flag TOOL_WRENCH or when doing jobs with quality 2 wrenching
content.merge_requirement(
    content.Requirement { id = "vehicle_wrench_2" }
        :quality("WRENCH", 2, 1)
)

-- Compatible with legacy flag NAILABLE
content.merge_requirement(
    content.Requirement { id = "vehicle_nail_install" }
        :component("nail", 20)
        :quality("HAMMER", 2, 1)
)

-- represents riveting and/or bolting plates together as a supplement for welding
content.merge_requirement(
    content.Requirement { id = "vehicle_bolt_install" }
        :component("nuts_bolts", 20)
        :quality("WRENCH", 2, 1)
        :quality("DRILL", 2, 1)
)

-- for simple installs that only require tightening bolts
content.merge_requirement(
    content.Requirement { id = "vehicle_bolt_install_simple" }
        :component("nuts_bolts", 4)
        :quality("WRENCH", 1, 1)
)

-- Compatible with legacy flag NAILABLE
content.merge_requirement(
    content.Requirement { id = "vehicle_nail_removal" }
        :quality("PRY", 1, 1)
)

-- Compatible with legacy flag TOOL_SCREWDRIVER
content.merge_requirement(
    content.Requirement { id = "vehicle_screw" }
        :quality("SCREW", 1, 1)
)

-- Counterpart to welding_* installation requirements
content.merge_requirement(
    content.Requirement { id = "vehicle_weld_removal" }
        :quality("SAW_M", 2, 1)
)

-- Used for parts that can't be cut with hand tools
content.merge_requirement(
    content.Requirement { id = "vehicle_weld_removal_cut_resistant" }
        :quality("SAW_M", 3, 1)
)

-- Materials used for repairing alternators and general electronics
content.merge_requirement(
    content.Requirement { id = "vehicle_repair_electronics" }
        :component("scrap", 1)
        :component("cable", 3)
)

-- recipes/basecamps/components.json

-- Big tent or couple of small tents, used in basecamp construction.
content.merge_requirement(
    content.Requirement { id = "large_tent_equivalent" }
        :component_any {
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 },
        }
)
