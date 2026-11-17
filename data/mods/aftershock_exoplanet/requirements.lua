local content = require("ccb").content

-- options.json

-- The previous empty tool group leaves the existing anesthesia requirement intact.
content.merge_requirement(
    content.Requirement { id = "anesthetic" }
)

-- requirements.json

-- Includes forging resources as well as tools needed for most physical material hypertech crafting
content.merge_requirement(
    content.Requirement { id = "nanosmithing_standard" }
        :tool_charges("nano_forge", 20)
        :tool("tongs", 1)
        :quality("ANVIL", 3, 1)
        :quality("DIAMONDPRESS", 1, 1)
        :quality("NANO_FORGE", 1, 1)
)

-- Any kind of non-poisonous bones, human or not.
content.merge_requirement(
    content.Requirement { id = "bone_edible" },
    content.Requirement {}
        :component_any {
            { id = "frost_bone_human", count = 1 },
            { id = "alien_bone", count = 1 },
        }
)

-- Any kind of bones, human or not.  Tainted bones are too brittle and won't work for this purpose.
content.merge_requirement(
    content.Requirement { id = "bone_sturdy" },
    content.Requirement {}
        :component_any {
            { id = "frost_bone_human", count = 1 },
            { id = "alien_bone", count = 1 },
        }
)

-- Any type of edible raw fat.
content.merge_requirement(
    content.Requirement { id = "edible_fat" },
    content.Requirement {}
        :component_any {
            { id = "frost_human_fat", count = 1 },
            { id = "alien_fat", count = 1 },
        }
)

-- Any type of edible tallow.
content.merge_requirement(
    content.Requirement { id = "edible_tallow" },
    content.Requirement {}
        :component_any {
            { id = "frost_human_tallow", count = 1 },
            { id = "alien_tallow", count = 1 },
        }
)

-- Butter of all types and other future butter substitutes
content.merge_requirement(
    content.Requirement { id = "any_butter" },
    content.Requirement {}
        :component("atomic_butter", 1)
)

-- For when a recipe calls for either cooking oil or butter, like many baking recipes do.
content.merge_requirement(
    content.Requirement { id = "any_butter_or_oil" },
    content.Requirement {}
        :component("atomic_butter", 1)
)

-- Anything you might consider offal or intestines.
content.merge_requirement(
    content.Requirement { id = "meat_offal" },
    content.Requirement {}
        :component_any {
            { id = "alien_liver", count = 4 },
            { id = "alien_kidney", count = 4 },
            { id = "alien_sweetbread", count = 4 },
        }
)

-- An unbroken slab of raw meat.  For when scraps just aren't good enough.
content.merge_requirement(
    content.Requirement { id = "meat_raw_steak" },
    content.Requirement {}
        :component_any {
            { id = "frost_human_flesh", count = 1 },
            { id = "alien_flesh", count = 1 },
        }
)

-- Anything you might consider raw, unpreserved 'red' meat.  About 250mL of meat.
content.merge_requirement(
    content.Requirement { id = "meat_red_raw" },
    content.Requirement {}
        :component("alien_meat_scrap", 10)
)

-- Anything you might consider raw lung.  About 250mL of lungs.
content.merge_requirement(
    content.Requirement { id = "meat_lung" },
    content.Requirement {}
        :component("alien_lung", 1)
)

-- Anything you might consider a large raw stomach.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_large" },
    content.Requirement {}
        :component("alien_stomach_large", 1)
)

-- Anything you might consider a small raw stomach.
content.merge_requirement(
    content.Requirement { id = "meat_stomach_small" },
    content.Requirement {}
        :component_any {
            { id = "alien_stomach", count = 1 },
            { id = "frost_hstomach", count = 1 },
        }
)

-- Any type of raw meat except for fish.  About 300-400kcal of meat.
content.merge_requirement(
    content.Requirement { id = "meat_nofish" },
    content.Requirement {}
        :component_any {
            { id = "afs_mealgrubs", count = 1 },
            { id = "alien_liver", count = 5 },
            { id = "alien_kidney", count = 5 },
            { id = "alien_sweetbread", count = 5 },
        }
)

-- meat you'd put on a sandwich
content.merge_requirement(
    content.Requirement { id = "meat_cooked" },
    content.Requirement {}
        :component_any {
            { id = "alien_flesh_cooked", count = 1 },
            { id = "alien_meat_scrap_cooked", count = 10 },
            { id = "frost_human_cooked", count = 1 },
        }
)

-- Raw meat that non-cannibals would be unhappy eating.
content.merge_requirement(
    content.Requirement { id = "human_meat" },
    content.Requirement {}
        :component("frost_human_flesh", 1)
)

-- Cooked meat that non-cannibals would be unhappy eating.
content.merge_requirement(
    content.Requirement { id = "human_meat_cooked" },
    content.Requirement {}
        :component("frost_human_cooked", 1)
)

-- recipes/requirements.json

-- surface_heat
content.merge_requirement(
    content.Requirement { id = "surface_heat" },
    content.Requirement {}
        :tool("afs_atompot", 1)
)

-- Tools usable for providing heat usable for boiling water, but not necessarily for anything else.
-- water_boiling_heat
content.merge_requirement(
    content.Requirement { id = "water_boiling_heat" },
    content.Requirement {}
        :tool("afs_atompot", 1)
)

content.merge_requirement(
    content.Requirement { id = "electric_probing" }
        :tool_any {
            { id = "voltmeter", count = 1 },
            { id = "toolset", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "welding_standard" },
    content.Requirement {}
        :component("afs_welding_paste", 2)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 2 },
            { id = "afs_plasma_torch", charges = 1 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "welding_alloys" },
    content.Requirement {}
        :component("afs_welding_paste", 4)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 6 },
            { id = "afs_plasma_torch", charges = 3 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_standard" },
    content.Requirement {}
        :component("afs_welding_paste", 2)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 6 },
            { id = "afs_plasma_torch", charges = 3 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_lc_steel" },
    content.Requirement {}
        :component("afs_welding_paste", 2)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 6 },
            { id = "afs_plasma_torch", charges = 3 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_alloys" },
    content.Requirement {}
        :component("afs_welding_paste", 2)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 6 },
            { id = "afs_plasma_torch", charges = 3 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_rebar" },
    content.Requirement {}
        :component("afs_welding_paste", 2)
        :tool_any {
            { id = "afs_plasma_torch_gun", charges = 6 },
            { id = "afs_plasma_torch", charges = 3 },
            { id = "afs_welding_paste", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "afs_nanofab_material_3" }
        :component("afs_material_3", 2)
)

content.merge_requirement(
    content.Requirement { id = "afs_nanofab_biomaterial_1" }
        :component("afs_biomaterial_1", 2)
)
