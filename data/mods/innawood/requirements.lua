local content = require("ccb").content

-- requirements/materials.json

-- Materials used for crafting or repairing clothing or sheeting, etc.
content.merge_requirement(
    content.Requirement { id = "fabric_standard" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "fibercloth_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 },
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

-- Materials used for crafting or repairing woven fabrics
content.merge_requirement(
    content.Requirement { id = "fabric_standard_permeable" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "fibercloth_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 },
            { id = "lycra_patch", count = 8 },
            { id = "sheet_lycra", count = 1 },
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
    content.Requirement { id = "fabric_standard_nostretch" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "fibercloth_patchwork", count = 8 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 },
            { id = "nylon", count = 8 },
            { id = "sheet_nylon_patchwork", count = 1 },
            { id = "sheet_nylon", count = 1 },
            { id = "nomex", count = 8 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "sheet_nomex", count = 1 },
        }
)

-- Materials used for crafting or repairing clothing or sheeting, etc.
content.merge_requirement(
    content.Requirement { id = "fabric_standard_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fibercloth_patchwork", count = 1 },
            { id = "lycra_patch", count = 1 },
            { id = "nylon", count = 1 },
            { id = "leather", count = 1 },
            { id = "nomex", count = 1 },
            { id = "neoprene", count = 1 },
        }
)

-- Materials used for crafting or repairing woven fabrics
content.merge_requirement(
    content.Requirement { id = "fabric_standard_permeable_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fibercloth_patchwork", count = 1 },
            { id = "lycra_patch", count = 8 },
            { id = "nylon", count = 8 },
            { id = "nomex", count = 8 },
        }
)

-- Materials used for crafting or repairing non-form fitting clothing
content.merge_requirement(
    content.Requirement { id = "fabric_standard_nostretch_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fibercloth_patchwork", count = 1 },
            { id = "nylon", count = 1 },
            { id = "nomex", count = 1 },
        }
)

-- requirements/tailoring.json

-- Melting and reshaping plastic items through the use of vacuum forming molds, per 70 g of plastic. Usually takes 30 minutes per unit.
content.merge_requirement(
    content.Requirement { id = "plastic_molding" }
        :component("plastic_chunk", 1)
        :tool_any {
            { id = "makeshift_vacuum_mold", charges = 4 },
            { id = "vac_mold", charges = 2 },
        }
        :tool_charges("surface_heat", 5, true)
        :quality("CUT", 2, 1)
)

-- Crafting cotton items, per 101 g of cotton; 10 g + excessive weight of material is wasted, producing rags and cotton scraps as byproducts.  Time needed is usually 90 minutes per unit if hand-stitching.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton" }
        :component_any {
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- Crafting possibly-patchwork cotton items, per 101 g of cotton; 10 g + excessive weight of material is wasted, producing rags and cotton scraps as byproducts.  Time needed is usually 90 minutes per unit if hand-stitching (most of the time actually needed goes into making a patchwork sheet)
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_patchwork" }
        :component_any {
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_fibercloth", count = 1 },
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
            { id = "sheet_fibercloth", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)

-- A small piece of fabric or leather to strap something firmly to the body.  Stronger than a bit of string.
content.merge_requirement(
    content.Requirement { id = "strap_small" }
        :component_any {
            { id = "cotton_patchwork", count = 3 },
            { id = "fibercloth_patchwork", count = 3 },
            { id = "leather", count = 3 },
            { id = "fur", count = 3 },
        }
        :quality("SEW", 1, 1)
        :quality("CUT", 2, 1)
)

-- 5g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 15 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing cotton scraps.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_small" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fibercloth_patchwork", count = 1 },
        }
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

-- 5g per unit. Crafting possibly-patchwork cotton items, adjusted for tailoring rework. Time needed is usually 15 minutes per unit if hand-stitching.  excessive weight of material is wasted, possibly producing cotton scraps.  Used for simpler items where precision cutting is less important.
content.merge_requirement(
    content.Requirement { id = "tailoring_cotton_small_simple" }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "fibercloth_patchwork", count = 1 },
        }
        :component("filament", 3, true)
        :quality("SEW", 1, 1)
        :quality("CUT", 1, 1)
)
