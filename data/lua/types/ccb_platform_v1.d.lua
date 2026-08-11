---@meta

-- LuaLS declarations for the CCB Lua-first Platform v1 bootstrap surface.
-- This is editor metadata. Do not require or copy it into runtime code.

---@class ModDefinitionOptions
---@field id? string Stable 1-256-byte Mod id without `#`; inherits the sole legacy id in a hybrid root, otherwise the root directory name.
---@field name? string 1-512-byte display name; defaults to the resolved Mod id.
---@field version? string 1-128-byte author-defined Mod version.
---@field entry? string Root-relative entry path of at most 4096 bytes; defaults to main.lua.
---@field dependencies? string[] Dense one-based array of at most 256 unique stable Mod ids loaded before this Mod.
---@field core? boolean Whether this is a core Mod.

---@class ModDefinition
---@field id string
---@field name string
---@field version string
---@field entry string
---@field dependencies string[]
---@field core boolean
local ModDefinition = {}

---@class CcbPlatformBubbleMapSquarePayload
---@field coordinate_space 'bub_ms' Literal native space tag.
---@field x integer Bubble map-square x coordinate.
---@field y integer Bubble map-square y coordinate.
---@field z integer Bubble map-square z coordinate.

---@class CcbPlatformAbsoluteMapSquarePayload
---@field coordinate_space 'abs_ms' Literal native space tag.
---@field x integer Absolute map-square x coordinate.
---@field y integer Absolute map-square y coordinate.
---@field z integer Absolute map-square z coordinate.

---@class ItemDefinitionOptions
---@field id string Stable item type id.
---@field name? string Display name; defaults to id.
---@field description? string Player-facing description.
---@field symbol? string Map symbol; defaults to `?`.

---@class ItemDefinition
---@field id string
local ItemDefinition = {}

---@param grams integer
---@return ItemDefinition self
function ItemDefinition:mass_grams(grams) end

---@param milliliters integer
---@return ItemDefinition self
function ItemDefinition:volume_ml(milliliters) end

---@param cents integer
---@return ItemDefinition self
function ItemDefinition:price_cents(cents) end

---@param id string
---@param portions integer
---@return ItemDefinition self
function ItemDefinition:material(id, portions) end

---@param id string
---@param level integer
---@return ItemDefinition self
function ItemDefinition:quality(id, level) end

---@param id string
---@return ItemDefinition self
function ItemDefinition:flag(id) end

---@param handler_id string
---@param label? string
---@return ItemDefinition self
function ItemDefinition:on_use(handler_id, label) end

---@class RecipeDefinitionOptions
---@field id string Stable recipe id.
---@field result string Stable result item id.
---@field category? string Native crafting category id.
---@field subcategory? string Native crafting subcategory id.
---@field skill? string Primary skill id.
---@field difficulty? integer Difficulty from zero through the native maximum skill level.
---@field duration_moves? integer Positive base duration in moves.
---@field autolearn? boolean Whether the recipe is automatically learnable.
---@field reversible? boolean Whether the recipe supplies disassembly data.

---@class RecipeComponentAlternative
---@field id string Item type id.
---@field count? integer Positive count; defaults to one.

---@class RecipeDefinition
---@field id string
local RecipeDefinition = {}

---@param moves integer
---@return RecipeDefinition self
function RecipeDefinition:duration_moves(moves) end

---@param id string
---@param count integer
---@return RecipeDefinition self
function RecipeDefinition:component(id, count) end

---@param choices RecipeComponentAlternative[] Dense one-based array with at most 128 entries.
---@return RecipeDefinition self
function RecipeDefinition:component_any(choices) end

---@param id string
---@param count integer Positive number of tool instances; tools are not consumed.
---@return RecipeDefinition self
function RecipeDefinition:tool(id, count) end

---@param id string
---@param charges integer Positive charges consumed by crafting.
---@return RecipeDefinition self
function RecipeDefinition:tool_charges(id, charges) end

---@class RecipeToolAlternative
---@field id string Item type id.
---@field count? integer Positive non-consuming instance count; defaults to one.
---@field charges? integer Positive charge count consumed instead of `count`.

---@param choices RecipeToolAlternative[] Dense one-based array with at most 128 entries.
---@return RecipeDefinition self
function RecipeDefinition:tool_any(choices) end

---@param id string
---@param level integer
---@return RecipeDefinition self
function RecipeDefinition:requires_skill(id, level) end

---@param requirement_id string Native Requirement id.
---@param multiplier integer Positive multiplier.
---@return RecipeDefinition self
function RecipeDefinition:requirement(requirement_id, multiplier) end

---@class NestedRecipeCategoryDefinitionOptions
---@field id string Stable nested-category recipe id.
---@field name string Player-facing nested category name.
---@field description? string Player-facing category description.
---@field category string Native crafting category id.
---@field subcategory string Native crafting subcategory id.
---@field activity_level? number Positive exertion multiplier; defaults to no exercise.

---@class NestedRecipeCategoryDefinition
---@field id string
local NestedRecipeCategoryDefinition = {}

---@param recipe_id string Native, same-transaction recipe, or nested-category id.
---@return NestedRecipeCategoryDefinition self
function NestedRecipeCategoryDefinition:recipe(recipe_id) end

---@class RequirementDefinitionOptions
---@field id string Stable reusable requirement id.
---@field name? string Optional player-facing name.

---@class RequirementAlternative
---@field id string Item type id.
---@field count? integer Positive count; defaults to one.

---@class RequirementQualityAlternative
---@field id string ToolQuality id.
---@field level? integer Positive quality level; defaults to one.
---@field count? integer Positive tool count; defaults to one.

---@class RequirementDefinition
---@field id string
local RequirementDefinition = {}

---@param item_id string
---@param count integer
---@return RequirementDefinition self
function RequirementDefinition:component(item_id, count) end

---@param choices RequirementAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:component_any(choices) end

---@param item_id string
---@param count integer Positive non-consuming instance count.
---@return RequirementDefinition self
function RequirementDefinition:tool(item_id, count) end

---@param item_id string
---@param charges integer Positive charge count consumed.
---@return RequirementDefinition self
function RequirementDefinition:tool_charges(item_id, charges) end

---@param choices RecipeToolAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:tool_any(choices) end

---@param quality_id string
---@param level integer
---@param count integer
---@return RequirementDefinition self
function RequirementDefinition:quality(quality_id, level, count) end

---@param choices RequirementQualityAlternative[] Dense one-based array with at most 128 entries.
---@return RequirementDefinition self
function RequirementDefinition:quality_any(choices) end

---@class RecipeGroupDefinitionOptions
---@field id string Stable recipe-group id.
---@field building_type? string Native camp/building group; defaults to `NONE`.

---@class RecipeGroupDefinition
---@field id string
local RecipeGroupDefinition = {}

---@param recipe_id string
---@param description string Player-facing action description.
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:recipe(recipe_id, description) end

---@param recipe_id string Recipe entry added earlier to this group.
---@param overmap_terrain string Overmap terrain matcher or `ANY`.
---@param match_type 'EXACT'|'TYPE'|'SUBTYPE'|'PREFIX'|'CONTAINS'
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:terrain(recipe_id, overmap_terrain, match_type) end

---@param recipe_id string Recipe whose most recently added terrain receives the parameter.
---@param parameter string Mapgen parameter name.
---@param values string[] Dense accepted-value list.
---@return RecipeGroupDefinition self
function RecipeGroupDefinition:terrain_parameter(recipe_id, parameter, values) end

---@class ScentTypeDefinitionOptions
---@field id string Stable scent-type id.

---@class ScentTypeDefinition
---@field id string
local ScentTypeDefinition = {}

---@param species_id string Native monster-species id that can perceive this scent.
---@return ScentTypeDefinition self
function ScentTypeDefinition:receptive_species(species_id) end

---@class SpeedDescriptionDefinitionOptions
---@field id string Stable speed-description id.

---@class SpeedDescriptionDefinition
---@field id string
local SpeedDescriptionDefinition = {}

---@param threshold number Finite non-negative relative-speed threshold.
---@param descriptions string[] Dense non-empty list of alternative player-facing descriptions.
---@return SpeedDescriptionDefinition self
function SpeedDescriptionDefinition:value(threshold, descriptions) end

---@class HarvestDropTypeDefinitionOptions
---@field id string Stable harvest-drop type id.
---@field field_dress_success? string Snippet category for successful field dressing.
---@field field_dress_failure? string Snippet category for failed field dressing.
---@field butcher_success? string Snippet category for successful butchery.
---@field butcher_failure? string Snippet category for failed butchery.
---@field dissect_success? string Snippet category for successful dissection.
---@field dissect_failure? string Snippet category for failed dissection.
---@field item_group? boolean Whether the harvested drop is an item-group id.
---@field dissect_only? boolean Whether the drop is available only through dissection.

---@class HarvestDropTypeDefinition
---@field id string
local HarvestDropTypeDefinition = {}

---@param skill_id string Native skill used by harvest rolls; the implicit default is `survival` when none are added.
---@return HarvestDropTypeDefinition self
function HarvestDropTypeDefinition:skill(skill_id) end

---@class HarvestDefinitionOptions
---@field id string Stable harvest-list id referenced by monsters or other native content.
---@field message? string Player-facing message used when this harvest is available.
---@field leftovers? string Native item id left after butchery; defaults to `ruined_chunks`.
---@field butchery_requirements? string Native butchery-requirements id; defaults to `default`.

---@class HarvestDropOptions
---@field output string Unique native item id, or native item-group id when `category` names an item-group harvest-drop type.
---@field category? string Harvest-drop type id; omission means a normal item drop.
---@field base_minimum? number Finite base minimum quantity; defaults to 1.
---@field base_maximum? number Finite base maximum quantity no lower than the minimum.
---@field skill_minimum? number Finite minimum quantity gained per harvest-skill level; defaults to 0.
---@field skill_maximum? number Finite maximum quantity gained per harvest-skill level no lower than the minimum.
---@field maximum? integer Positive native maximum quantity; defaults to 1000.
---@field mass_ratio? number Finite share of corpse mass from 0 through 1; defaults to 0.

---@class HarvestDefinition
---@field id string
local HarvestDefinition = {}

---@param options HarvestDropOptions
---@return HarvestDefinition self
function HarvestDefinition:drop(options) end

---@param output string Output id staged earlier on this harvest definition.
---@param flag_id string Existing or same-transaction native item flag id.
---@return HarvestDefinition self
function HarvestDefinition:item_flag(output, flag_id) end

---@param output string Output id staged earlier on this harvest definition.
---@param fault_id string Existing native item-fault id.
---@return HarvestDefinition self
function HarvestDefinition:item_fault(output, fault_id) end

---@class BehaviorDefinitionOptions
---@field id string Stable native behavior-node id.
---@field strategy? string Native traversal strategy for a branch node, such as `sequential`, `fallback`, or `utility`.
---@field goal? string Goal selected by a leaf node; a definition must provide either this field or one or more child() calls, never both.

---@class BehaviorPolicyPayload
---@field behavior_id string Behavior node currently being evaluated.
---@field argument string Author-supplied policy argument.
---@field subject_kind 'avatar'|'npc'|'monster'|'creature'|'none'
---@field subject GameHandle|nil Generation-safe handle for the native AI subject.

---@class BehaviorDefinition
---@field id string
local BehaviorDefinition = {}

---@param behavior_id string Existing or same-transaction child behavior id.
---@return BehaviorDefinition self
function BehaviorDefinition:child(behavior_id) end

---@param handler_id string Named callback receiving BehaviorPolicyPayload and returning one boolean.
---@param argument? string Bounded opaque argument passed to the callback.
---@param inverted? boolean Invert the callback result before traversal.
---@return BehaviorDefinition self
function BehaviorDefinition:when(handler_id, argument, inverted) end

---@param predicate_id string Registered native behavior predicate.
---@param argument? string Bounded native predicate argument.
---@param inverted? boolean Invert the predicate result before traversal.
---@return BehaviorDefinition self
function BehaviorDefinition:when_native(predicate_id, argument, inverted) end

---@param handler_id string Named callback receiving BehaviorPolicyPayload and returning one finite native-range number.
---@param argument? string Bounded opaque argument passed to the callback.
---@return BehaviorDefinition self
function BehaviorDefinition:score(handler_id, argument) end

---@param predicate_id string Registered native behavior score predicate.
---@param argument? string Bounded native predicate argument.
---@return BehaviorDefinition self
function BehaviorDefinition:score_native(predicate_id, argument) end

---@class MonsterAttackDefinitionOptions
---@field id string Stable native monster-attack id.
---@field cooldown? number Finite non-negative default cooldown; defaults to one turn.
---@field policy? string Named Lua handler returning one boolean.

---@class MonsterAttackPolicyPayload
---@field attack_id string Native attack id being invoked.
---@field attacker GameHandle Generation-safe attacking monster handle.
---@field target GameHandle|nil Generation-safe current target when one exists.

---@class MonsterAttackDefinition
---@field id string
local MonsterAttackDefinition = {}

---@param handler_id string Named handler receiving MonsterAttackPolicyPayload and returning one boolean.
---@return MonsterAttackDefinition self
function MonsterAttackDefinition:policy(handler_id) end

---@class EffectTypeDefinitionOptions
---@field id string Stable native effect-type id.
---@field name? string First intensity name; additional intensities use name().
---@field description? string First intensity description; additional intensities use description().
---@field remove_message? string Player-facing removal message.
---@field apply_memorial_log? string Memorial text recorded when applied.
---@field remove_memorial_log? string Memorial text recorded when removed.
---@field blood_analysis_description? string Player-facing blood-analysis description.
---@field maximum_intensity? integer Positive native maximum intensity; defaults to one.
---@field maximum_duration_turns? integer Non-negative maximum duration.
---@field intensity_duration_turns? integer Non-negative duration represented by one intensity.
---@field duration_add_percent? integer Duration stacking percentage; defaults to 100.
---@field intensity_add_value? integer Intensity added when stacking.
---@field intensity_decay_step? integer Decay step, where -1 is the native default.
---@field intensity_decay_tick? integer Non-negative turns per intensity-decay tick.
---@field intensity_decay_removes? boolean Whether decay removes the effect.
---@field main_parts_only? boolean Whether body-part application targets only main parts.
---@field show_in_info? boolean Whether the effect appears in item/character information.
---@field show_intensity? boolean Whether UI displays intensity; defaults to true.
---@field part_descriptions? boolean Whether descriptions vary by body part.

---@class EffectTypeDefinition
---@field id string
local EffectTypeDefinition = {}

---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:name(text) end
---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:description(text) end
---@param text string
---@return EffectTypeDefinition self
function EffectTypeDefinition:reduced_description(text) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:immune_character_flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:immune_bodypart_flag(id) end
---@param id string
---@return EffectTypeDefinition self
function EffectTypeDefinition:resist_trait(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:resist_effect(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:removes_effect(id) end
---@param id string Existing or same-transaction EffectType id.
---@return EffectTypeDefinition self
function EffectTypeDefinition:blocks_effect(id) end

---@class WeakpointDefinitionOptions
---@field id string Unique weakpoint id within its set.
---@field name? string Player-facing weakpoint name.
---@field coverage? number Finite non-negative selection weight; defaults to 100.
---@field good? boolean Whether hitting the point is beneficial to the attacker.
---@field head? boolean Whether this is a head weakpoint.

---@class WeakpointEffectOptions
---@field effect string Existing or same-transaction EffectType id.
---@field chance? number Chance from zero through 100.
---@field permanent? boolean Whether the applied effect is permanent.
---@field duration_min_turns? integer Non-negative minimum duration.
---@field duration_max_turns? integer Maximum duration no lower than the minimum.
---@field intensity_min? integer Positive minimum intensity.
---@field intensity_max? integer Maximum intensity no lower than the minimum.
---@field damage_required_min? number Minimum damage percentage from zero through 100.
---@field damage_required_max? number Maximum damage percentage no lower than the minimum.
---@field message? string Player-facing application message.

---@class WeakpointSetDefinitionOptions
---@field id string Stable native weakpoint-set id.

---@class WeakpointSetDefinition
---@field id string
local WeakpointSetDefinition = {}

---@param options WeakpointDefinitionOptions
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:weakpoint(options) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:armor_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:armor_penalty(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:damage_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param damage_type string
---@param value number
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:critical_multiplier(weakpoint_id, damage_type, value) end
---@param weakpoint_id string
---@param options WeakpointEffectOptions
---@return WeakpointSetDefinition self
function WeakpointSetDefinition:effect(weakpoint_id, options) end

---@class FieldIntensityOptions
---@field name string Player-facing intensity name.
---@field symbol? string Exactly one display-cell glyph.
---@field color? string Native color name.
---@field dangerous? boolean
---@field transparent? boolean
---@field move_cost? integer
---@field upgrade_chance? integer Chance from zero through 100.
---@field upgrade_duration_turns? integer Non-negative upgrade duration.
---@field light_emitted? number Finite non-negative light.
---@field local_light_override? number Finite local override.
---@field translucency? number Finite non-negative translucency.
---@field concentration? integer Non-negative concentration.
---@field convection_temperature_modifier? integer
---@field scent_neutralization? integer

---@class FieldEffectOptions
---@field effect string Existing or same-transaction EffectType id.
---@field duration_min_turns? integer Non-negative minimum duration.
---@field duration_max_turns? integer Maximum duration no lower than the minimum.
---@field intensity? integer Positive effect intensity.
---@field body_part? string Existing or same-transaction BodyPart id.
---@field environmental? boolean
---@field message? string
---@field npc_message? string

---@class FieldTypeDefinitionOptions
---@field id string Stable native field-type id.
---@field underwater_age_speedup_turns? integer
---@field outdoor_age_speedup_turns? integer
---@field decay_amount_factor? integer
---@field percent_spread? integer Chance from zero through 100.
---@field gas_absorption_turns? integer Non-negative absorption duration.
---@field priority? integer
---@field half_life_turns? integer Non-negative half life.
---@field phase? 'null'|'solid'|'liquid'|'gas'|'plasma'
---@field description_affix? 'in'|'covered_in'|'on'|'under'|'illuminated_by'
---@field wandering_field? string Existing or same-transaction FieldType id.
---@field looks_like? string Tileset fallback id.
---@field splattering? boolean
---@field has_fire? boolean
---@field has_acid? boolean
---@field has_electricity? boolean
---@field has_fume? boolean
---@field moppable? boolean
---@field accelerated_decay? boolean
---@field display_items? boolean
---@field display_field? boolean
---@field linear_half_life? boolean
---@field indestructible? boolean
---@field mopsafe? boolean
---@field decrease_intensity_on_contact? boolean

---@class FieldTypeDefinition
---@field id string
local FieldTypeDefinition = {}
---@param options FieldIntensityOptions
---@return FieldTypeDefinition self
function FieldTypeDefinition:intensity(options) end
---@param one_based_intensity integer
---@param options FieldEffectOptions
---@return FieldTypeDefinition self
function FieldTypeDefinition:effect(one_based_intensity, options) end
---@param monster_id string Existing or same-transaction Monster id.
---@return FieldTypeDefinition self
function FieldTypeDefinition:immune_monster(monster_id) end
---@param monster_id string Existing or same-transaction Monster id.
---@return FieldTypeDefinition self
function FieldTypeDefinition:block_monster(monster_id) end

---@class ItemGroupDefinitionOptions
---@field id string Stable native item-group id.
---@field kind? 'distribution'|'collection'
---@field with_ammo? integer Chance from zero through 100.
---@field with_magazine? integer Chance from zero through 100.

---@class ItemGroupDefinition
---@field id string
local ItemGroupDefinition = {}
---@param item_id string Existing or same-transaction Item id.
---@param probability? integer Positive distribution weight or collection percentage.
---@param variant? string Native item variant id.
---@return ItemGroupDefinition self
function ItemGroupDefinition:item(item_id, probability, variant) end
---@param group_id string Existing or same-transaction ItemGroup id.
---@param probability? integer Positive distribution weight or collection percentage.
---@return ItemGroupDefinition self
function ItemGroupDefinition:group(group_id, probability) end

---@class SubBodyPartDefinitionOptions
---@field id string Stable native sub-body-part id.
---@field name string Player-facing singular name.
---@field plural_name? string Pair/plural name; defaults to name.
---@field parent string Existing or same-transaction BodyPart id.
---@field opposite? string Existing or same-transaction SubBodyPart id; defaults to self.
---@field side? 'left'|'right'|'both'
---@field secondary? boolean
---@field maximum_coverage? integer Positive percentage no greater than 100.
---@field similar_body_part? string Existing or same-transaction SubBodyPart id used for armor coverage.

---@class SubBodyPartDefinition
---@field id string
local SubBodyPartDefinition = {}
---@param sub_body_part_id string Existing or same-transaction lower location.
---@return SubBodyPartDefinition self
function SubBodyPartDefinition:location_under(sub_body_part_id) end
---@param damage_type string
---@param amount number
---@return SubBodyPartDefinition self
function SubBodyPartDefinition:unarmed_damage(damage_type, amount) end

---@class WoundDefinitionOptions
---@field id string Stable native wound-type id.
---@field name? string Player-facing singular name; defaults to id.
---@field plural_name? string Player-facing plural name; defaults to name.
---@field description string Non-empty player-facing description.
---@field pain_min? integer Minimum pain rolled when the wound is created; defaults to zero.
---@field pain_max? integer Maximum pain no lower than pain_min; defaults to zero.
---@field healing_min_turns? integer Positive minimum healing duration in turns; defaults to one.
---@field healing_max_turns? integer Maximum healing duration no shorter than healing_min_turns; defaults to one.
---@field damage_min? integer Non-negative minimum incoming damage used by natural wound candidate selection.
---@field damage_max? integer Maximum incoming damage no lower than damage_min, used by natural candidate selection.
---@field weight? integer Positive relative natural-selection weight; defaults to one.
---@field per_part_limit? integer Non-negative per-body-part instance limit; zero is unlimited.
---@field required_body_part_flag? string Existing or same-transaction JsonFlag required when natural damage selection tests a body part.
---@field forbidden_body_part_flag? string Existing or same-transaction JsonFlag forbidden when natural damage selection tests a body part.

---@class WoundDefinition
---@field id string
local WoundDefinition = {}
---@param id string Existing or same-transaction DamageType id; each id may be added once and at least one is required.
---@return WoundDefinition self
function WoundDefinition:damage_type(id) end
---@param id string Existing or same-transaction LimbScore id.
---@param penalty number Finite penalty from zero through one.
---@return WoundDefinition self
function WoundDefinition:limb_score(id, penalty) end
---@param id string Existing or same-transaction non-self Wound id.
---@param chance integer Progression chance from zero through 100.
---@return WoundDefinition self
function WoundDefinition:progression(id, chance) end
---Require this body-part type during natural damage-selection candidate filtering.
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@return WoundDefinition self
function WoundDefinition:require_body_part_type(kind) end
---Forbid this body-part type during natural damage-selection candidate filtering.
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@return WoundDefinition self
function WoundDefinition:forbid_body_part_type(kind) end

---@class BodyPartDefinitionOptions
---@field id string Stable native body-part id.
---@field name string Player-facing singular name.
---@field plural_name? string Pair/plural name.
---@field accusative? string Accusative singular name.
---@field plural_accusative? string Accusative pair/plural name.
---@field heading? string UI heading.
---@field plural_heading? string UI pair/plural heading.
---@field encumbrance_text? string Encumbrance UI label.
---@field hp_bar_text? string HP-bar UI label.
---@field main_part? string Existing or same-transaction main BodyPart; defaults to self.
---@field connected_to? string Existing or same-transaction connected BodyPart.
---@field opposite? string Existing or same-transaction opposite BodyPart; defaults to self.
---@field side? 'left'|'right'|'both'
---@field hit_size? number Finite positive targeting size.
---@field hit_difficulty? number Finite non-negative targeting difficulty.
---@field base_health? integer Positive base HP.
---@field drench_capacity? integer Non-negative wetness capacity.
---@field limb? boolean
---@field vital? boolean

---@class BodyPartDefinition
---@field id string
local BodyPartDefinition = {}
---@param id string Existing or same-transaction SubBodyPart id.
---@return BodyPartDefinition self
function BodyPartDefinition:sub_part(id) end
---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@param weight? number Finite positive weight.
---@return BodyPartDefinition self
function BodyPartDefinition:limb_type(kind, weight) end
---@param damage_type string
---@param amount number
---@return BodyPartDefinition self
function BodyPartDefinition:armor(damage_type, amount) end
---@param damage_type string
---@param amount number
---@return BodyPartDefinition self
function BodyPartDefinition:unarmed_damage(damage_type, amount) end
---@param flag_id string Existing or same-transaction JsonFlag id.
---@return BodyPartDefinition self
function BodyPartDefinition:flag(flag_id) end
---@param limb_score_id string Existing or same-transaction LimbScore id.
---@param score number
---@param maximum? number
---@return BodyPartDefinition self
function BodyPartDefinition:limb_score(limb_score_id, score, maximum) end
---@param quality_id string Existing or same-transaction ToolQuality id.
---@param level integer
---@param disable_fraction? number Fraction from zero through one.
---@return BodyPartDefinition self
function BodyPartDefinition:quality(quality_id, level, disable_fraction) end

---@class WoundFixDefinitionOptions
---@field id string Stable native wound-fix id.
---@field name? string Player-facing action name; defaults to id.
---@field description string Non-empty player-facing treatment description.
---@field success_message? string Player-facing successful-treatment message.
---@field duration_turns? integer Non-negative base duration whose move cost fits the native integer range.
---@field health_delta? integer Signed body-part HP change applied by the treatment.

---@class WoundFixDefinition
---@field id string
local WoundFixDefinition = {}
---@param id string Existing or same-transaction Skill id.
---@param level integer Required level from zero through the native skill maximum.
---@return WoundFixDefinition self
function WoundFixDefinition:skill(id, level) end
---@param id string Existing or same-transaction Proficiency id.
---@param multiplier number Positive finite treatment-time multiplier that remains positive as a native float.
---@param mandatory boolean Whether the proficiency is required to perform the treatment.
---@return WoundFixDefinition self
function WoundFixDefinition:proficiency(id, multiplier, mandatory) end
---@param id string Existing or same-transaction Wound id removed by the treatment; at least one removal is required.
---@return WoundFixDefinition self
function WoundFixDefinition:removes(id) end
---@param id string Existing or same-transaction Wound id added by the treatment.
---@return WoundFixDefinition self
function WoundFixDefinition:adds(id) end
---@param id string Existing or same-transaction Requirement id.
---@param count integer Positive native requirement multiplier; multiplied and subsequently consolidated component/tool counts must fit signed native integers.
---@return WoundFixDefinition self
function WoundFixDefinition:requires(id, count) end

---@class AnatomyDefinitionOptions
---@field id string Stable native anatomy id.
---@class AnatomyDefinition
---@field id string
local AnatomyDefinition = {}
---@param body_part_id string Existing or same-transaction BodyPart id.
---@return AnatomyDefinition self
function AnatomyDefinition:part(body_part_id) end

---@class BodyGraphPartOptions
---@field body_parts? string[] Dense list of existing or same-transaction BodyPart ids.
---@field sub_body_parts? string[] Dense list of existing or same-transaction SubBodyPart ids.
---@field nested_graph? string Existing or same-transaction BodyGraph id.
---@field selected_color? string Native color name.
---@field display_symbol? string Exactly one display-cell glyph.
---@class BodyGraphDefinitionOptions
---@field id string Stable native body-graph id.
---@field parent_body_part? string Existing or same-transaction BodyPart id.
---@field mirror? string Existing or same-transaction BodyGraph id; mirrored graphs omit rows.
---@field label_fill? string
---@field fill_symbol? string Exactly one display-cell glyph.
---@field fill_color? string Native color name.
---@class BodyGraphDefinition
---@field id string
local BodyGraphDefinition = {}
---@param row string One through 40 display cells; all rows use one width.
---@param fill_row? string Optional fill row of the same width; supply it for every row or none.
---@return BodyGraphDefinition self
function BodyGraphDefinition:row(row, fill_row) end
---@param symbol string Unique one-cell graph symbol.
---@param options BodyGraphPartOptions
---@return BodyGraphDefinition self
function BodyGraphDefinition:part(symbol, options) end

---@class MonsterDefinitionOptions
---@field id string Stable native monster id.
---@field name string Player-facing singular name.
---@field plural_name? string Player-facing plural name.
---@field description? string Player-facing description.
---@field symbol? string Exactly one display-cell glyph.
---@field color? string Native color name.
---@field looks_like? string Tileset fallback id.
---@field body_type? string Native visual body-type tag.
---@field default_faction string Existing or same-transaction MonsterFaction id.
---@field harvest? string Existing or same-transaction Harvest id; defaults to `human`.
---@field dissect? string Existing or same-transaction Harvest id.
---@field decay? string Existing or same-transaction Harvest id.
---@field speed_description? string Existing or same-transaction SpeedDescription id.
---@field death_drops? string Existing or same-transaction ItemGroup id.
---@field volume_ml? integer Positive native volume.
---@field weight_grams? integer Positive native mass.
---@field phase? 'null'|'solid'|'liquid'|'gas'|'plasma'
---@field difficulty_adjustment? integer
---@field hp? integer Positive base HP before world scaling.
---@field speed? integer Non-negative base speed before world scaling.
---@field aggression? integer Value from -100 through 100.
---@field morale? integer
---@field tracking_distance? integer At least three tiles.
---@field attack_cost? integer Non-negative move cost.
---@field melee_skill? integer Non-negative melee skill.
---@field melee_dice? integer Non-negative bonus bash dice.
---@field melee_sides? integer Non-negative sides per bonus die.
---@field melee_armor_penetration? integer
---@field dodge? integer Non-negative dodge skill.
---@field vision_day? integer Non-negative daylight vision.
---@field vision_night? integer Non-negative dark vision.
---@field regenerates? integer HP regenerated per turn.
---@field bleed_rate? integer Non-negative percentage.
---@field status_chance_multiplier? number Finite value from zero through five.
---@field luminance? number Finite non-negative light emission.
---@field regenerates_in_dark? boolean
---@field regenerates_morale? boolean
---@field aggressive_to_characters? boolean

---@class MonsterDefinition
---@field id string
local MonsterDefinition = {}
---@param material_id string Existing or same-transaction Material id.
---@param portions? integer Positive material portions.
---@return MonsterDefinition self
function MonsterDefinition:material(material_id, portions) end
---@param species_id string Existing or same-transaction Species id.
---@return MonsterDefinition self
function MonsterDefinition:species(species_id) end
---@param category string
---@return MonsterDefinition self
function MonsterDefinition:category(category) end
---@param flag_id string Existing or same-transaction MonsterFlag id; `GEN_DORMANT` is not transaction-safe.
---@return MonsterDefinition self
function MonsterDefinition:flag(flag_id) end
---@param damage_type string
---@param amount number
---@return MonsterDefinition self
function MonsterDefinition:armor(damage_type, amount) end
---@param damage_type string
---@param amount number
---@param armor_penetration? number
---@return MonsterDefinition self
function MonsterDefinition:melee_damage(damage_type, amount, armor_penetration) end
---@param attack_id string Existing or same-transaction MonsterAttack id.
---@param cooldown? number Optional finite non-negative cooldown override.
---@return MonsterDefinition self
function MonsterDefinition:attack(attack_id, cooldown) end
---@param set_id string Existing or same-transaction WeakpointSet id.
---@return MonsterDefinition self
function MonsterDefinition:weakpoint_set(set_id) end
---@param emission_id string Existing or same-transaction Emission id.
---@param interval_turns integer Positive interval.
---@return MonsterDefinition self
function MonsterDefinition:emission(emission_id, interval_turns) end
---@param item_id string Existing or same-transaction Item id.
---@param amount integer Positive starting quantity.
---@return MonsterDefinition self
function MonsterDefinition:starting_ammo(item_id, amount) end
---@param scent_id string Existing or same-transaction ScentType id.
---@return MonsterDefinition self
function MonsterDefinition:track_scent(scent_id) end
---@param scent_id string Existing or same-transaction ScentType id.
---@return MonsterDefinition self
function MonsterDefinition:ignore_scent(scent_id) end
---@param effect_id string Existing or same-transaction EffectType id.
---@param amount integer Native regeneration modifier.
---@return MonsterDefinition self
function MonsterDefinition:regeneration_modifier(effect_id, amount) end
---@param behavior_id string Existing or same-transaction Behavior id.
---@return MonsterDefinition self
function MonsterDefinition:goal(behavior_id) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:anger_trigger(trigger) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:fear_trigger(trigger) end
---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return MonsterDefinition self
function MonsterDefinition:placate_trigger(trigger) end

---@class MoraleTypeDefinitionOptions
---@field id string Stable morale-type id.
---@field text string Player-facing description; may contain one `%s` item-name placeholder.
---@field permanent? boolean Whether morale instances of this type are permanent.

---@class MoraleTypeDefinition
---@field id string
local MoraleTypeDefinition = {}

---@class DiseaseTypeDefinitionOptions
---@field id string Stable disease-type id.
---@field symptoms string Native effect id applied as symptoms.
---@field minimum_duration_turns? integer Positive minimum duration in game turns.
---@field maximum_duration_turns? integer Positive maximum duration no shorter than the minimum.
---@field minimum_intensity? integer Positive minimum symptom intensity.
---@field maximum_intensity? integer Positive maximum symptom intensity no lower than the minimum.
---@field health_threshold? integer Health above which the character is immune.

---@class DiseaseTypeDefinition
---@field id string
local DiseaseTypeDefinition = {}

---@param body_part_id string Native body-part id affected by the disease.
---@return DiseaseTypeDefinition self
function DiseaseTypeDefinition:affected_body_part(body_part_id) end

---@class MonsterFlagDefinitionOptions
---@field id string Stable monster-flag id.

---@class MonsterFlagDefinition
---@field id string
local MonsterFlagDefinition = {}

---@class SpeciesDefinitionOptions
---@field id string Stable monster-species id.
---@field description? string Player-facing species description.
---@field footsteps? string Player-facing footstep description; defaults to `footsteps.`.
---@field bleeds? string Native field-type id produced by bleeding; defaults to `fd_null`.

---@class SpeciesDefinition
---@field id string
local SpeciesDefinition = {}

---@param flag_id string Native MonsterFlag id inherited by every monster in the species.
---@return SpeciesDefinition self
function SpeciesDefinition:flag(flag_id) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:anger(trigger) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:fear(trigger) end

---@param trigger 'STALK'|'PLAYER_WEAK'|'PLAYER_CLOSE'|'HOSTILE_SEEN'|'HURT'|'FIRE'|'FRIEND_DIED'|'FRIEND_ATTACKED'|'SOUND'|'PLAYER_NEAR_BABY'|'MATING_SEASON'|'BRIGHT_LIGHT'
---@return SpeciesDefinition self
function SpeciesDefinition:placate(trigger) end

---@class EmissionDefinitionOptions
---@field id string Stable field-emission id.
---@field field string Native field-type id used by the static fallback profile.
---@field intensity? integer Positive fallback intensity no greater than the field type's maximum; defaults to one.
---@field quantity? integer Positive fallback field quantity; defaults to one.
---@field chance? integer Fallback emission chance from one through 100; defaults to 100.

---@class EmissionProfile
---@field field string Native field-type id; `fd_null` is not accepted.
---@field intensity integer Positive intensity no greater than the selected field type's maximum.
---@field quantity integer Non-negative field quantity; zero suppresses propagation.
---@field chance integer Emission chance from zero through 100; zero suppresses this emission.

---@class EmissionProfilePayload
---@field emission_id string
---@field position CcbPlatformBubbleMapSquarePayload Detached bubble map-square position of this emission.
---@field fallback EmissionProfile Immutable static fallback authored on the definition.

---@class EmissionDefinition
---@field id string
local EmissionDefinition = {}

---@param handler_id string Named handler receiving EmissionProfilePayload and returning one complete EmissionProfile table or nil for the fallback.
---@return EmissionDefinition self
function EmissionDefinition:profile(handler_id) end

---@class MonsterFactionDefinitionOptions
---@field id string Stable monster-faction id.
---@field base? string Native MonsterFaction id inherited when no direct relation exists; defaults to the sentinel root.

---@class MonsterFactionDefinition
---@field id string
local MonsterFactionDefinition = {}

---@param kind 'by_mood'|'neutral'|'friendly'|'hate' Direct relation kind.
---@param target string Native MonsterFaction id receiving the relation.
---@return MonsterFactionDefinition self
function MonsterFactionDefinition:attitude(kind, target) end

---@class MutationTypeDefinitionOptions
---@field id string Stable mutation-type grouping id.

---@class MutationTypeDefinition
---@field id string
local MutationTypeDefinition = {}

---@class ConnectGroupDefinitionOptions
---@field id string Stable terrain/furniture connection-group id.

---@class ConnectGroupDefinition
---@field id string
local ConnectGroupDefinition = {}

---@class MutationCategoryDefinitionOptions
---@field id string Stable mutation-category id.
---@field name? string Player-facing category name; defaults to id.
---@field threshold_mutation? string Native Mutation id granted at the threshold.
---@field mutagen_message string Player-facing message after consuming category mutagen.
---@field memorial_message? string Memorial text after crossing the threshold.
---@field vitamin? string Native Vitamin id used as category mutagen; defaults to `null`.
---@field threshold_minimum? integer Non-negative vitamin amount required for a threshold attempt.
---@field base_removal_chance? integer Starting-trait removal chance from zero through 100.
---@field base_removal_cost_multiplier? number Finite non-negative vitamin-cost multiplier.
---@field work_in_progress? boolean Marks an intentionally unfinished content category.
---@field skip_consistency_test? boolean Skips category consistency review for dummy-only categories.

---@class MutationCategoryDefinition
---@field id string
local MutationCategoryDefinition = {}

---@class ConstructionCategoryDefinitionOptions
---@field id string Stable construction-category id.
---@field name? string Player-facing category name; defaults to id.

---@class ConstructionCategoryDefinition
---@field id string
local ConstructionCategoryDefinition = {}

---@class ConstructionGroupDefinitionOptions
---@field id string Stable construction-group id.
---@field name? string Player-facing group name; defaults to id.

---@class ConstructionGroupDefinition
---@field id string
local ConstructionGroupDefinition = {}

---@class VehiclePartLocationDefinitionOptions
---@field id string Stable vehicle-part location id.
---@field name? string Player-facing location name; defaults to id.
---@field description? string Player-facing location description.
---@field z_order? integer Rendering order; higher locations render above lower locations.
---@field list_order? integer Vehicle-interaction display order; lower locations appear first.

---@class VehiclePartLocationDefinition
---@field id string
local VehiclePartLocationDefinition = {}

---@class MoodFaceDefinitionOptions
---@field id string Stable mood-face table id.

---@class MoodFaceDefinition
---@field id string
local MoodFaceDefinition = {}

---@param score integer Morale threshold, within the native integer range.
---@param face string Player-facing face markup used at or above the threshold.
---@return MoodFaceDefinition self
function MoodFaceDefinition:value(score, face) end

---@class DamageInfoOrderDefinitionOptions
---@field id string DamageType id whose presentation this definition controls.
---@field display? 'none'|'basic'|'detailed' Overall item-info detail level.
---@field verb? string Player-facing damage verb; defaults to the damage-type name.

---@class DamageInfoOrderDefinition
---@field id string
local DamageInfoOrderDefinition = {}

---@param section 'bionic'|'protection'|'pet_protection'|'melee'|'ablative'
---@param order integer Sort order for this presentation section.
---@param show_type boolean Whether the damage type appears in this section.
---@return DamageInfoOrderDefinition self
function DamageInfoOrderDefinition:section(section, order, show_type) end

---@class VehiclePartCategoryDefinitionOptions
---@field id string Stable vehicle-part category id.
---@field name? string Player-facing category name; defaults to id.
---@field short_name? string Compact player-facing label; defaults to name.
---@field priority? integer UI tab order.

---@class VehiclePartCategoryDefinition
---@field id string
local VehiclePartCategoryDefinition = {}

---@class NamedColorDefinitionOptions
---@field name string Stable player-facing color name.
---@field red? integer Red channel from 0 through 255.
---@field green? integer Green channel from 0 through 255.
---@field blue? integer Blue channel from 0 through 255.
---@field alpha? integer Alpha channel from 0 through 255; defaults to 255.

---@class NamedColorDefinition
---@field name string
local NamedColorDefinition = {}

---@class RotatableSymbolDefinitionOptions
---@field symbols string[] Dense array of two or four distinct, single-codepoint glyphs in clockwise order.

---@class RotatableSymbolDefinition
---@field key string First glyph, used as the stable transaction identity.
local RotatableSymbolDefinition = {}

---@class AsciiArtDefinitionOptions
---@field id string Stable ASCII-art id.

---@class AsciiArtDefinition
---@field id string
local AsciiArtDefinition = {}

---@param text string One display line, at most 41 terminal cells after color tags are removed.
---@return AsciiArtDefinition self
function AsciiArtDefinition:line(text) end

---@class LimbScoreDefinitionOptions
---@field id string Stable limb-score id.
---@field name? string Player-facing score name; defaults to id.
---@field affected_by_wounds? boolean Whether wounds reduce this score.
---@field affected_by_encumbrance? boolean Whether encumbrance reduces this score.

---@class LimbScoreDefinition
---@field id string
local LimbScoreDefinition = {}

---@class HitRangeDefinitionOptions
---@field even_good integer[] Dense global dispersion table indexed by range.

---@class HitRangeDefinition
---@field id 'global' Singleton identity; use `content.replace`.
local HitRangeDefinition = {}

---@class BashDamageProfileDefinitionOptions
---@field id string Stable bash-damage profile id.

---@class BashDamageProfileDefinition
---@field id string
local BashDamageProfileDefinition = {}

---@param damage_type_id string Native DamageType id.
---@param multiplier number Finite non-negative susceptibility multiplier.
---@return BashDamageProfileDefinition self
function BashDamageProfileDefinition:factor(damage_type_id, multiplier) end

---@class ClothingModDefinitionOptions
---@field id string Stable clothing-modification id.
---@field flag string Item flag applied by the modification.
---@field material_item string Item consumed to apply the modification.
---@field apply_prompt string Player-facing action prompt.
---@field remove_prompt string Player-facing removal prompt.
---@field restricted? boolean Whether the modification is restricted to compatible armor.

---@class ClothingModifierOptions
---@field stat 'acid'|'fire'|'bash'|'cut'|'bullet'|'encumbrance'|'warmth'
---@field amount number Finite modifier amount.
---@field scale? ('thickness'|'coverage')[] Optional composable scaling dimensions.
---@field round_up? boolean Whether the scaled result rounds upward.

---@class ClothingModDefinition
---@field id string
local ClothingModDefinition = {}

---@param options ClothingModifierOptions
---@return ClothingModDefinition self
function ClothingModDefinition:modifier(options) end

---@class OvermapLandUseCodeDefinitionOptions
---@field id string Stable overmap land-use id.
---@field code? integer External numeric classification code; defaults to zero.
---@field name? string Player-facing name; defaults to id.
---@field description? string Detailed player-facing definition.
---@field symbol string Exactly one Unicode codepoint.
---@field color? string Native color name; defaults to black.

---@class OvermapLandUseCodeDefinition
---@field id string
local OvermapLandUseCodeDefinition = {}

---@class OvermapVisionDefinitionOptions
---@field id string Stable overmap-vision profile id.

---@class OvermapVisionAppearanceOptions
---@field name string Player-facing description at this detail level.
---@field symbol string Exactly one Unicode codepoint.
---@field color? string Native color name; defaults to black.
---@field looks_like? string Optional overmap-terrain tileset fallback id.

---@class OvermapVisionDefinition
---@field id string
local OvermapVisionDefinition = {}

---@param options OvermapVisionAppearanceOptions
---@return OvermapVisionDefinition self
function OvermapVisionDefinition:appearance(options) end

---@return OvermapVisionDefinition self
function OvermapVisionDefinition:blend_adjacent() end

---@class OvermapLocationDefinitionOptions
---@field id string Stable overmap-location predicate id.

---@class OvermapLocationDefinition
---@field id string
local OvermapLocationDefinition = {}

---@param terrain_type_id string Native overmap terrain-type id accepted by this location.
---@return OvermapLocationDefinition self
function OvermapLocationDefinition:terrain(terrain_type_id) end

---@param flag string Native overmap-terrain flag accepted by this location.
---@return OvermapLocationDefinition self
function OvermapLocationDefinition:terrain_flag(flag) end

---@class ProfessionGroupDefinitionOptions
---@field id string Stable profession-group id.

---@class ProfessionGroupDefinition
---@field id string
local ProfessionGroupDefinition = {}

---@param profession_id string Native profession id included once in this group.
---@return ProfessionGroupDefinition self
function ProfessionGroupDefinition:profession(profession_id) end

---@class MapExtraCollectionDefinitionOptions
---@field id string Stable map-extra collection id.
---@field chance? integer Non-negative collection selection chance; defaults to zero.

---@class MapExtraCollectionDefinition
---@field id string
local MapExtraCollectionDefinition = {}

---@param map_extra_id string Native map-extra id.
---@param weight integer Positive selection weight.
---@return MapExtraCollectionDefinition self
function MapExtraCollectionDefinition:extra(map_extra_id, weight) end

---@class VehicleGroupDefinitionOptions
---@field id string Stable vehicle-group id.

---@class VehicleGroupDefinition
---@field id string
local VehicleGroupDefinition = {}

---@param vehicle_id string Native vehicle prototype id.
---@param weight integer Positive selection weight.
---@return VehicleGroupDefinition self
function VehicleGroupDefinition:vehicle(vehicle_id, weight) end

---@class FaultGroupDefinitionOptions
---@field id string Stable fault-group id.

---@class FaultGroupDefinition
---@field id string
local FaultGroupDefinition = {}

---@param fault_id string Native fault id.
---@param weight integer Positive selection weight.
---@return FaultGroupDefinition self
function FaultGroupDefinition:fault(fault_id, weight) end

---@class ExplosionLightDefinitionOptions
---@field id string Stable explosion-light recipe id.

---@class ExplosionLightWaveOptions
---@field travel? number Non-negative normalized wave travel time.
---@field gap? number Non-negative normalized gap between color fronts.
---@field rise? number Non-negative alpha rise duration.
---@field fade? number Non-negative alpha fade duration.
---@field blend? number Non-negative color-blend duration.
---@field spread_jitter? number Non-negative wavefront position variation.
---@field color_jitter? number Non-negative per-tile color variation.
---@field flicker? number Non-negative per-frame brightness variation.
---@field easing? 'linear'|'ease_in'|'ease_out'|'smoothstep'

---@class ExplosionLightDurationOptions
---@field base_ms? number Non-negative base animation duration.
---@field per_tile_ms? number Non-negative duration added per blast-radius tile.
---@field minimum_ms? number Positive lower duration bound.
---@field maximum_ms? number Duration upper bound no smaller than minimum_ms.

---@class ExplosionLightShockwaveOptions
---@field enabled? boolean Defaults to true.
---@field strength? number Non-negative peak refraction strength.
---@field speed? number Positive expansion-speed multiplier.
---@field thickness? number Non-negative radial half-width.

---@class ExplosionLightDefinition
---@field id string
local ExplosionLightDefinition = {}

---@param red integer Color component from zero through 255.
---@param green integer Color component from zero through 255.
---@param blue integer Color component from zero through 255.
---@param alpha integer Translucent opacity from zero through 255.
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:stop(red, green, blue, alpha) end

---@param options ExplosionLightWaveOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:waves(options) end

---@param options ExplosionLightDurationOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:duration(options) end

---@param magnitude number Non-negative peak screen displacement.
---@param duration_ms number Non-negative shake duration.
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:screen_shake(magnitude, duration_ms) end

---@param options ExplosionLightShockwaveOptions
---@return ExplosionLightDefinition self
function ExplosionLightDefinition:shockwave(options) end

---@class AmmoEffectDefinitionOptions
---@field id string Stable ammunition-effect id.
---@field trigger_chance? integer Percentage chance, from zero through 100, that the recipe runs on impact.

---@class AmmoFieldBurstOptions
---@field field string Native field-type id.
---@field intensity_min? integer Non-negative minimum field intensity; defaults to one.
---@field intensity_max? integer Maximum field intensity no smaller than intensity_min.
---@field radius? integer Non-negative horizontal radius.
---@field height? integer Non-negative vertical radius.
---@field chance? integer Per-tile percentage chance from zero through 100.
---@field footprint? integer Non-negative AI area-size hint.
---@field passable_only? boolean Only place the field on passable tiles.

---@class AmmoTrailOptions
---@field field string Native field-type id.
---@field intensity_min? integer Non-negative minimum field intensity; defaults to one.
---@field intensity_max? integer Maximum field intensity no smaller than intensity_min.
---@field chance? integer Per-tile percentage chance from zero through 100.

---@class AmmoOnHitOptions
---@field effect string Native character-effect id.
---@field duration_turns? integer Positive duration in game turns.
---@field intensity? integer Positive effect intensity.
---@field touch_skin? boolean Require the projectile to touch skin.

---@class AmmoAreaEffectOptions
---@field effect string Native character-effect id.
---@field duration_turns? integer Positive duration in game turns.
---@field intensity_min? integer Positive minimum effect intensity.
---@field intensity_max? integer Maximum intensity no smaller than intensity_min.
---@field chance? integer Percentage chance from zero through 100.
---@field radius? integer Non-negative horizontal radius.
---@field hits_min? integer Positive minimum number of affected body parts.
---@field hits_max? integer Maximum number of affected body parts no smaller than hits_min.
---@field all_body_parts? boolean Apply to every body part instead of choosing hits.

---@class AmmoExplosionOptions
---@field power number Non-negative blast power.
---@field distance_factor? number Blast retention factor from zero through one.
---@field max_noise? integer Non-negative native sound cap.
---@field fire? boolean Whether the blast ignites its area.
---@field light? string Native ExplosionLight id.

---@class AmmoShrapnelOptions
---@field casing_mass? integer Non-negative casing mass.
---@field fragment_mass? number Positive mass of one fragment.
---@field recovery? integer Recoverable-fragment percentage from zero through 100.
---@field drop? string Native item id dropped by recovered fragments.

---@class AmmoSpellOptions
---@field level? integer Non-negative spell level.
---@field self? boolean Cast on the projectile source rather than the impact position.

---@class AmmoImpactPolicyPayload
---@field ammo_effect_id string
---@field dealt_damage integer
---@field source GameHandle|nil Generation-checked source creature when present.
---@field target GameHandle|nil Generation-checked target creature when present.
---@field position CcbPlatformBubbleMapSquarePayload Detached impact position.

---@class AmmoEffectDefinition
---@field id string
local AmmoEffectDefinition = {}

---@param options AmmoFieldBurstOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:field_burst(options) end

---@param options AmmoTrailOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:trail(options) end

---@param options AmmoOnHitOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:on_hit(options) end

---@param options AmmoAreaEffectOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:area_effect(options) end

---@param options AmmoExplosionOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:explosion(options) end

---@param options AmmoShrapnelOptions Must follow explosion().
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:shrapnel(options) end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:flashbang() end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:emp() end

---@return AmmoEffectDefinition self
function AmmoEffectDefinition:foamcrete() end

---@param spell_id string Native spell id.
---@param options? AmmoSpellOptions
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:spell(spell_id, options) end

---@param enabled? boolean Defaults to true.
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:cast_spells_on_miss(enabled) end

---@param handler_id string Named callback registered with ccb.runtime.handler.
---@return AmmoEffectDefinition self
function AmmoEffectDefinition:impact_policy(handler_id) end

---@class AddictionTypeDefinitionOptions
---@field id string Stable addiction-type id.
---@field name string Player-facing withdrawal name.
---@field type_name string Noun phrase completing “became addicted to …”.
---@field description string Player-facing effects description.
---@field craving_morale? string Native morale-type id used for cravings.

---@class AddictionTickPolicyPayload
---@field addiction_type_id string
---@field intensity integer
---@field sated_turns integer
---@field character GameHandle Generation-checked addicted character.

---@class AddictionTypeDefinition
---@field id string
local AddictionTypeDefinition = {}

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return whether the tick produced an observable effect.
---@return AddictionTypeDefinition self
function AddictionTypeDefinition:tick_policy(handler_id) end

---@class CharacterModifierDefinitionOptions
---@field id string Stable character-modifier id.
---@field description string Player-facing explanation of the modifier.
---@field operation? 'add'|'multiply'|'none' How consumers display and combine the returned value; defaults to multiply.

---@class CharacterModifierPayload
---@field modifier_id string
---@field skill_id string Empty when the consumer did not provide a skill.
---@field character GameHandle Generation-checked character being evaluated.

---@class CharacterModifierDefinition
---@field id string
local CharacterModifierDefinition = {}

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one finite native-range number.
---@return CharacterModifierDefinition self
function CharacterModifierDefinition:evaluate_with(handler_id) end

---@class StartLocationDefinitionOptions
---@field id string Stable start-location id.
---@field name string Player-facing location name.

---@class StartLocationTerrainOptions
---@field match? 'exact'|'type'|'subtype'|'prefix'|'contains' Native overmap-terrain matching mode; defaults to type.
---@field parameters? table<string, string> Mapgen parameter values applied after selection.

---@class StartLocationDefinition
---@field id string
local StartLocationDefinition = {}

---@param terrain_id string Native overmap terrain or type selector.
---@param options? StartLocationTerrainOptions
---@return StartLocationDefinition self
function StartLocationDefinition:terrain(terrain_id, options) end

---@param flag_id string Native start-placement flag.
---@return StartLocationDefinition self
function StartLocationDefinition:flag(flag_id) end

---@param minimum integer Non-negative minimum city size.
---@param maximum integer Maximum city size no smaller than minimum.
---@return StartLocationDefinition self
function StartLocationDefinition:city_size(minimum, maximum) end

---@param minimum integer Non-negative minimum distance from a city edge.
---@param maximum integer Maximum distance no smaller than minimum.
---@return StartLocationDefinition self
function StartLocationDefinition:city_distance(minimum, maximum) end

---@param minimum integer Minimum native overmap z level.
---@param maximum integer Maximum native overmap z level.
---@return StartLocationDefinition self
function StartLocationDefinition:z_levels(minimum, maximum) end

---@class ClimbingAidDefinitionOptions
---@field id string Stable climbing-aid id.
---@field slip_chance_modifier? integer Signed modifier applied to native slip chance.

---@class ClimbingAidAvailabilityOptions
---@field category 'special'|'terrain_or_furniture'|'vehicle'|'item'|'character'|'trait'
---@field flag string Native capability, item, trait, vehicle, terrain, or furniture selector.
---@field uses? integer Non-negative item charges consumed when category is item.
---@field range? integer Non-negative terrain/furniture detection radius.

---@class ClimbingAidDescentOptions
---@field max_height? integer Maximum supported descent height; -1 disables descent.
---@field easy_climb_back_up? integer Non-negative height that remains easy to climb back.
---@field allow_remaining_height? boolean Whether the aid may cover only part of a taller fall.
---@field menu_text string Player-facing menu entry.
---@field unavailable_text? string Required when deploy() is used.
---@field hotkey? string Zero or one byte; required when deploy() is used.
---@field confirm_text string Confirmation prompt.
---@field before_message? string Message shown before descent.
---@field after_message? string Message shown after descent.

---@class ClimbingAidCostOptions
---@field pain? integer Non-negative pain cost.
---@field damage? integer Non-negative damage cost.
---@field kilocalories? integer Non-negative energy cost.
---@field thirst? integer Non-negative thirst cost.

---@class ClimbingAidDefinition
---@field id string
local ClimbingAidDefinition = {}

---@param options ClimbingAidAvailabilityOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:available_when(options) end

---@param options ClimbingAidDescentOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:descent(options) end

---@param options ClimbingAidCostOptions
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:cost(options) end

---@param furniture_id string Native furniture id deployed below the climber.
---@return ClimbingAidDefinition self
function ClimbingAidDefinition:deploy(furniture_id) end

---@class WeatherTypeDefinitionOptions
---@field id string Stable weather-type id.
---@field name string Player-facing weather name.
---@field color? string Native text color; defaults to white.
---@field map_color? string Native overmap color; defaults to white.
---@field symbol? string Exactly one Unicode codepoint used by text displays.
---@field sun_symbol? string Exactly one Unicode codepoint used for the sun display.
---@field ranged_penalty? integer Signed native ranged-attack penalty.
---@field sight_penalty? number Non-negative per-tile visibility penalty.
---@field light_modifier? integer Signed ambient-light modifier.
---@field temperature_delta_kelvin? number Signed temperature delta in kelvins.
---@field light_multiplier? number Non-negative ambient-light multiplier.
---@field sun_multiplier? number Non-negative solar-radiation multiplier.
---@field sound_attenuation? integer Signed native sound attenuation.
---@field dangerous? boolean Whether entering this weather may interrupt activities.
---@field precipitation? 'none'|'very_light'|'light'|'heavy'
---@field rains? boolean Whether precipitation falls as rain.
---@field tiles_animation? string Tiles animation id; an empty string disables it.
---@field sound_category? 'silent'|'drizzle'|'rainy'|'rainstorm'|'thunder'|'flurries'|'snowstorm'|'snow'|'portal_storm'|'clear'|'sunny'|'cloudy'
---@field priority? integer Higher matching priorities replace lower ones.

---@class WeatherAnimationOptions
---@field factor number Non-negative animation density factor.
---@field color string Native animation color.
---@field symbol string Exactly one Unicode codepoint.

---@class WeatherPassiveEffectOptions
---@field effect string Native character-effect id.
---@field minimum_duration_turns? integer Positive minimum duration in game turns.
---@field maximum_duration_turns? integer Maximum duration no shorter than the minimum.
---@field intensity? integer Positive effect intensity.
---@field body_part? string Native body-part id; empty applies the effect without a body part.
---@field environmental? boolean Whether environmental immunity applies; defaults to true.
---@field immune_in_vehicle? boolean Suppress the effect in any vehicle.
---@field immune_inside_vehicle? boolean Suppress the effect inside a vehicle.
---@field immune_outside_vehicle? boolean Suppress the effect on exposed vehicle occupants.
---@field chance_in_vehicle? integer Percentage chance from zero through 100.
---@field chance_inside_vehicle? integer Percentage chance from zero through 100.
---@field chance_outside_vehicle? integer Percentage chance from zero through 100.
---@field message? string Player-facing application message.
---@field npc_message? string NPC-facing application message.

---@class WeatherConditionPayload
---@field weather_type_id string
---@field temperature_kelvin number
---@field humidity number
---@field pressure number
---@field windpower number
---@field wind_description string
---@field wind_direction integer
---@field turn integer
---@field location CcbPlatformAbsoluteMapSquarePayload Detached absolute map-square sample location.

---@class WeatherTypeDefinition
---@field id string
local WeatherTypeDefinition = {}

---@param minimum_turns integer Positive minimum duration in game turns.
---@param maximum_turns integer Maximum duration no shorter than the minimum.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:duration(minimum_turns, maximum_turns) end

---@param options WeatherAnimationOptions
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:animation(options) end

---@param weather_id string Native or same-transaction prerequisite weather id.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:requires(weather_id) end

---@param options WeatherPassiveEffectOptions
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:passive_effect(options) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one boolean.
---@return WeatherTypeDefinition self
function WeatherTypeDefinition:condition(handler_id) end

---@class ScoreDefinitionOptions
---@field id string Stable score id.
---@field statistic string Native event-statistic id whose value is displayed.
---@field description? string Optional format string receiving the statistic value.

---@class ScoreDefinition
---@field id string
local ScoreDefinition = {}

---@class OverlayOrderDefinition
---@field id string Always `global`; overlay ordering is an engine-wide singleton.
local OverlayOrderDefinition = {}

---@param mutation_id string Stable mutation or overlay id.
---@param order integer Signed native display order; lower values render first.
---@return OverlayOrderDefinition self
function OverlayOrderDefinition:mutation(mutation_id, order) end

---@class ZoneTypeDefinitionOptions
---@field id string Stable native zone-type id.
---@field name string Player-facing zone name.
---@field description? string Player-facing explanation shown by zone UIs.
---@field display_field string Native field type used to display marked tiles.
---@field can_be_personal? boolean Whether a character may own a personal instance.
---@field hidden? boolean Whether ordinary zone-type selection hides this definition.

---@class ZoneTypeDefinition
---@field id string
local ZoneTypeDefinition = {}

---@class SpeechPoolDefinitionOptions
---@field id string Stable speaker or speech-pool label.

---@class SpeechPoolDefinition
---@field id string
local SpeechPoolDefinition = {}

---@param sound string Player-facing speech text or sound description.
---@param volume integer Signed native sound volume.
---@return SpeechPoolDefinition self
function SpeechPoolDefinition:line(sound, volume) end

---@class EndScreenDefinitionOptions
---@field id string Stable end-screen id.
---@field picture string Native ASCII-art id.
---@field priority? integer Higher priorities are considered first.
---@field last_words_label? string Optional label for the final text input.

---@class EndScreenConditionPayload
---@field end_screen_id string
---@field character GameHandle Generation-checked character handle.

---@class EndScreenDefinition
---@field id string
local EndScreenDefinition = {}

---@param column integer Text column in the ASCII-art layout.
---@param row integer Text row in the ASCII-art layout.
---@param text string Player-facing information template.
---@return EndScreenDefinition self
function EndScreenDefinition:info(column, row, text) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it must return one boolean.
---@return EndScreenDefinition self
function EndScreenDefinition:condition(handler_id) end

---@class ActivityTypeDefinitionOptions
---@field id string Stable native activity id.
---@field verb string Player-facing progressive verb used by activity UI.
---@field rooted? boolean Whether the character is rooted while the activity runs.
---@field interruptable? boolean Whether gameplay may interrupt the activity; defaults to true.
---@field interruptable_with_keyboard? boolean Whether keyboard input may interrupt it; defaults to true.
---@field based_on? 'time'|'speed'|'neither' Progress model; defaults to `speed`.
---@field can_resume? boolean Whether compatible activities can resume this one; defaults to true.
---@field multi_activity? boolean Whether it participates in multi-activity workflows.
---@field fetch_items_to_zone? boolean Whether native fetching may supply the activity; defaults to true.
---@field refuel_fires? boolean Whether native fire-refuelling support is enabled.
---@field auto_needs? boolean Whether native auto-eat/drink support is enabled.
---@field activity_level? number Positive finite native exertion multiplier; defaults to 1.

---@class ActivityPolicyPayload
---@field activity_type_id string
---@field phase 'do_turn'|'completion'
---@field character GameHandle Generation-checked character handle.
---@field moves_total integer
---@field moves_left integer
---@field index integer Deprecated native activity state exposed only as a bounded snapshot.
---@field position integer Deprecated native activity state exposed only as a bounded snapshot.
---@field name string Deprecated native activity state exposed only as a bounded snapshot.

---@class ActivityPolicyResult
---@field cancel? boolean Cancel the current activity without entering native completion.
---@field moves_total? integer Replace the non-negative total move budget.
---@field moves_left? integer Replace the remaining move budget; a positive completion result extends the activity.
---@field index? integer Replace the bounded legacy activity index.
---@field position? integer Replace the bounded legacy activity position.
---@field name? string Replace the bounded legacy activity name.

---@class ActivityTypeDefinition
---@field id string
local ActivityTypeDefinition = {}

---@param distraction 'noise'|'pain'|'attacked'|'hostile_spotted_far'|'hostile_spotted_near'|'talked_to'|'asthma'|'motion_alarm'|'weather_change'|'portal_storm_popup'|'eoc'|'dangerous_field'|'hunger'|'thirst'|'temperature'|'mutation'|'oxygen'|'withdrawal'|'craft_step_complete'
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:ignore(distraction) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it may return nil or ActivityPolicyResult.
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:on_turn(handler_id) end

---@param handler_id string Named callback registered with ccb.runtime.handler; it may return nil or ActivityPolicyResult.
---@return ActivityTypeDefinition self
function ActivityTypeDefinition:on_finish(handler_id) end

---@class HelpTopicDefinitionOptions
---@field id string Stable Lua-first help-topic id.
---@field title string Player-facing topic title.
---@field order? integer Optional global display order; omitted topics append in deterministic Mod load order.

---@class HelpTopicDefinition
---@field id string
local HelpTopicDefinition = {}

---@param text string Player-facing paragraph; native help tokens remain available in text.
---@return HelpTopicDefinition self
function HelpTopicDefinition:paragraph(text) end

---@class SnippetCategoryDefinitionOptions
---@field id string Stable category/tag, including angle brackets when used by recursive expansion.

---@class SnippetEntryOptions
---@field id string Stable snippet id.
---@field text string Player-facing snippet text.
---@field name? string Optional player-facing short name.
---@field weight? integer Positive selection weight; defaults to 1.
---@field on_examine? string Named callback registered with ccb.runtime.handler; no EOC is stored.

---@class SnippetExaminePayload
---@field snippet_id string
---@field category_id string
---@field item_type_id string Stable type id of the item whose description exposed the snippet.
---@field character GameHandle Generation-checked character handle.

---@class SnippetCategoryDefinition
---@field id string
local SnippetCategoryDefinition = {}

---@param text string Player-facing anonymous snippet text.
---@param weight? integer Positive selection weight; defaults to 1.
---@return SnippetCategoryDefinition self
function SnippetCategoryDefinition:text(text, weight) end

---@param options SnippetEntryOptions
---@return SnippetCategoryDefinition self
function SnippetCategoryDefinition:entry(options) end

---@class PlaylistDefinitionOptions
---@field id string Stable playlist id; standard native contexts include `title`, `mp3`, `instrument`, and `sound`.
---@field shuffle? boolean Randomize track order per playlist cycle.

---@class PlaylistDefinition
---@field id string
local PlaylistDefinition = {}

---@param relative_file string Track path relative to the active soundpack; absolute and parent-traversing paths are rejected.
---@param volume? integer Native volume from 0 through 128; defaults to 100.
---@return PlaylistDefinition self
function PlaylistDefinition:track(relative_file, volume) end

---@class AttackVectorDefinitionOptions
---@field id string Stable attack-vector id.
---@field weapon? boolean Whether this vector represents the wielded weapon.
---@field strict_limbs? boolean Disable automatic substitution of anatomically similar parts.
---@field armor_bonus? boolean Include worn unarmed-weapon damage; defaults to true.
---@field encumbrance_limit? integer Maximum eligible limb encumbrance; defaults to 100.
---@field health_percent_limit? integer Minimum eligible limb health percentage from zero through 100.

---@class AttackVectorDefinition
---@field id string
local AttackVectorDefinition = {}

---@param body_part_id string Native BodyPart id eligible to deliver the attack.
---@return AttackVectorDefinition self
function AttackVectorDefinition:limb(body_part_id) end

---@param sub_body_part_id string Native SubBodyPart id used as the contact surface.
---@return AttackVectorDefinition self
function AttackVectorDefinition:contact(sub_body_part_id) end

---@param kind 'head'|'torso'|'sensor'|'mouth'|'arm'|'hand'|'leg'|'foot'|'wing'|'tail'|'other'
---@param count integer Positive required number of healthy limbs of this anatomical kind.
---@return AttackVectorDefinition self
function AttackVectorDefinition:requires_limb(kind, count) end

---@param flag_id string Native character/body-part flag required on an eligible limb.
---@return AttackVectorDefinition self
function AttackVectorDefinition:requires_flag(flag_id) end

---@param flag_id string Native character/body-part flag forbidden on an eligible limb.
---@return AttackVectorDefinition self
function AttackVectorDefinition:forbids_flag(flag_id) end

---@class MagicTypeDefinitionOptions
---@field id string Stable magic-system id.
---@field energy? 'hp'|'mana'|'stamina'|'bionic'|'vitamin'|'none' Native resource consumed by spells; defaults to none.
---@field vitamin? string Required native Vitamin id when energy is vitamin.
---@field energy_color? string Native color name used for the resource display; defaults to cyan.
---@field cannot_cast_message? string Message shown when a casting restriction is active.
---@field max_book_level? integer Maximum level learnable from books; omitted means no type-level override.
---@field failure_cost_fraction? number Non-negative default fraction of the successful spell cost paid on failure.
---@field failure_experience_fraction? number Non-negative default fraction of casting experience awarded on failure.

---@class MagicTypeDefinition
---@field id string
local MagicTypeDefinition = {}

---@param flag_id string Character flag that prevents casting spells of this type.
---@return MagicTypeDefinition self
function MagicTypeDefinition:cannot_cast_when(flag_id) end

---@param level_for_experience_handler string Named handler receiving `{ magic_type_id, spell_id, phase, input, experience, caster }` and returning a non-negative level.
---@param experience_for_level_handler string Named handler receiving `{ magic_type_id, spell_id, phase, input, level, caster }` and returning non-negative required experience.
---@return MagicTypeDefinition self
function MagicTypeDefinition:progression(level_for_experience_handler, experience_for_level_handler) end

---@param handler_id string Named handler returning non-negative casting experience from `{ magic_type_id, spell_id, phase, caster }`.
---@return MagicTypeDefinition self
function MagicTypeDefinition:casting_experience(handler_id) end

---@param handler_id string Named handler returning a failure chance from zero through one.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_chance(handler_id) end

---@param handler_id string Named handler returning a non-negative failed-cast cost fraction.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_cost(handler_id) end

---@param handler_id string Named handler returning a non-negative failed-cast experience fraction.
---@return MagicTypeDefinition self
function MagicTypeDefinition:failure_experience(handler_id) end

---@param handler_id string Named side-effect handler receiving `{ magic_type_id, spell_id, caster }` after a cast fails.
---@return MagicTypeDefinition self
function MagicTypeDefinition:on_failure(handler_id) end

---@class MovementModeDefinitionOptions
---@field id string Stable movement-mode id.
---@field name? string Player-facing mode name; defaults to id.
---@field kind? 'prone'|'crouching'|'walking'|'running' Native posture/movement category.
---@field character_symbol string Exactly one Unicode codepoint used in character state.
---@field panel_symbol string Exactly one Unicode codepoint used by the movement panel.
---@field panel_color? string Native panel color; defaults to white.
---@field symbol_color? string Native character-symbol color; defaults to white.
---@field exertion? number Non-negative metabolic activity level; defaults to 1.
---@field riding_exertion? number Non-negative metabolic level while riding; defaults to zero.
---@field stamina_multiplier? number Non-negative stamina cost multiplier; defaults to one.
---@field sound_multiplier? number Non-negative movement sound multiplier; defaults to one.
---@field speed_multiplier? number Positive movement-speed multiplier; defaults to one.
---@field mech_power_kilojoules? integer Non-negative mech energy cost; defaults to two.
---@field swim_speed_modifier? integer Native swim-speed adjustment; defaults to zero.
---@field stop_hauling? boolean Whether entering the mode stops hauling.

---@class MovementModeMessageOptions
---@field prepare string Message shown while preparing to change mode.
---@field success string Message shown after a successful change.
---@field failure? string Message shown after a failed change.

---@class MovementModeDefinition
---@field id string
local MovementModeDefinition = {}

---@param steed 'none'|'animal'|'mech'
---@param options MovementModeMessageOptions
---@return MovementModeDefinition self
function MovementModeDefinition:messages(steed, options) end

---@class ToolQualityDefinitionOptions
---@field id string Stable tool-quality id.
---@field name? string Display name; defaults to id.

---@class ToolQualityDefinition
---@field id string
local ToolQualityDefinition = {}

---@param level integer Non-negative quality level.
---@param text string Player-facing usage description.
---@return ToolQualityDefinition self
function ToolQualityDefinition:usage(level, text) end

---@class SkillDisplayDefinitionOptions
---@field id string Stable skill display-category id.
---@field label? string Player-facing category label; defaults to id.

---@class SkillDisplayDefinition
---@field id string
local SkillDisplayDefinition = {}

---@class SkillDefinitionOptions
---@field id string Stable skill id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.
---@field display_category? string SkillDisplay id; defaults to `none`.
---@field sort_rank? integer Native display ordering rank.
---@field teachable? boolean Whether NPCs may teach the skill.
---@field obsolete? boolean Whether the skill is retained only for compatibility.
---@field consumes_focus? boolean Whether training consumes focus.

---@class SkillDefinition
---@field id string
local SkillDefinition = {}

---@param tag string Native skill tag such as `combat_skill` or `contextual_skill`.
---@return SkillDefinition self
function SkillDefinition:tag(tag) end

---@param practice_id string Companion-practice category.
---@param weight integer Native weighting value.
---@return SkillDefinition self
function SkillDefinition:companion_practice(practice_id, weight) end

---@param level integer Level from zero through the native skill maximum.
---@param theory string Theory-level description.
---@param practice? string Practical-level description; defaults to theory text.
---@return SkillDefinition self
function SkillDefinition:level_description(level, theory, practice) end

---@param trait_id string Trait that must be present.
---@return SkillDefinition self
function SkillDefinition:requires_all_trait(trait_id) end

---@param trait_id string One alternative trait that permits use.
---@return SkillDefinition self
function SkillDefinition:requires_any_trait(trait_id) end

---@param minimum integer Non-negative absolute minimum attack time.
---@param base integer Base attack time, no lower than minimum.
---@param reduction_per_level integer Non-negative reduction per level.
---@return SkillDefinition self
function SkillDefinition:attack_time(minimum, base, reduction_per_level) end

---@param combat integer
---@param survival integer
---@param industry integer
---@return SkillDefinition self
function SkillDefinition:companion_rank_factors(combat, survival, industry) end

---@class VitaminDefinitionOptions
---@field id string Stable vitamin id.
---@field name? string Display name; defaults to id.
---@field kind? 'vitamin'|'toxin'|'drug'|'counter'
---@field deficiency? string Effect id used for deficiency.
---@field excess? string Effect id used for excess.
---@field minimum? integer Lower native accumulation bound.
---@field maximum? integer Upper native accumulation bound.
---@field rate_turns? integer Positive turns consumed per unit.

---@class VitaminDefinition
---@field id string
local VitaminDefinition = {}

---@param micrograms integer Positive mass per unit.
---@return VitaminDefinition self
function VitaminDefinition:weight_micrograms(micrograms) end

---@param start integer
---@param finish integer
---@return VitaminDefinition self
function VitaminDefinition:deficiency_range(start, finish) end

---@param start integer
---@param finish integer
---@return VitaminDefinition self
function VitaminDefinition:excess_range(start, finish) end

---@param vitamin_id string
---@param rate integer Positive decay proportion.
---@return VitaminDefinition self
function VitaminDefinition:decays_into(vitamin_id, rate) end

---@param flag string
---@return VitaminDefinition self
function VitaminDefinition:flag(flag) end

---@class JsonFlagDefinitionOptions
---@field id string Stable flag id.
---@field info? string Informative UI text.
---@field restriction? string Restriction phrase.
---@field name? string Player-facing name.
---@field item_prefix? string Item-name prefix.
---@field item_suffix? string Item-name suffix.
---@field requires_flag? string Required companion flag id.
---@field taste_modifier? integer Comestible fun modifier.
---@field inherit? boolean Whether attached items pass the flag to their base item.
---@field craft_inherit? boolean Whether components pass the flag to a crafted item.

---@class JsonFlagDefinition
---@field id string
local JsonFlagDefinition = {}

---@param flag_id string
---@return JsonFlagDefinition self
function JsonFlagDefinition:conflicts_with(flag_id) end

---@class DamageTypeDefinitionOptions
---@field id string Stable damage-type id.
---@field name? string Display name; defaults to id.
---@field skill? string Associated Skill id.
---@field magic_color? string Native color name.
---@field bash_conversion_factor? number Non-negative conversion factor.
---@field melee_only? boolean
---@field physical? boolean
---@field monster_difficulty? boolean
---@field no_resist? boolean
---@field edged? boolean
---@field environmental? boolean
---@field material_required? boolean

---@class DamageTypeDefinition
---@field id string
local DamageTypeDefinition = {}

---@param damage_type_id string
---@param factor number
---@return DamageTypeDefinition self
function DamageTypeDefinition:derived(damage_type_id, factor) end

---@param flag string
---@return DamageTypeDefinition self
function DamageTypeDefinition:immune_character_flag(flag) end

---@param flag string
---@return DamageTypeDefinition self
function DamageTypeDefinition:immune_monster_flag(flag) end

---@class PlatformDamageTypePayload
---@field damage_type_id string
---@field phase 'on_hit'|'on_damage'
---@field source GameHandle|nil Generation-safe source creature handle.
---@field target GameHandle|nil Generation-safe target creature handle.
---@field body_part string Empty for `on_hit`.
---@field total_damage number Premitigation damage for `on_damage`.
---@field damage_taken number Applied damage for `on_damage`.

---@param handler_id string Named handler receiving PlatformDamageTypePayload.
---@return DamageTypeDefinition self
function DamageTypeDefinition:on_hit(handler_id) end

---@param handler_id string Named handler receiving PlatformDamageTypePayload.
---@return DamageTypeDefinition self
function DamageTypeDefinition:on_damage(handler_id) end

---@class MaterialDefinitionOptions
---@field id string Stable material id.
---@field name? string Display name; defaults to id.
---@field salvaged_into? string Item id produced by salvage.
---@field repaired_with? string Repair item id.
---@field bash_damage_verb? string
---@field cut_damage_verb? string
---@field chip_resistance? integer Non-negative native resistance.
---@field breathability? integer Native breathability rank from zero through five.
---@field repair_difficulty? integer Native skill difficulty.
---@field wind_resistance? integer Percentage from zero through 100.
---@field density? number Positive relative density.
---@field sheet_thickness? number Non-negative sheet thickness.
---@field specific_heat_liquid? number
---@field specific_heat_solid? number
---@field latent_heat? number
---@field freezing_point? number Celsius.
---@field rotting? boolean
---@field soft? boolean
---@field uncomfortable? boolean
---@field conductive? boolean

---@class MaterialDefinition
---@field id string
local MaterialDefinition = {}

---@param damage_type_id string
---@param amount number
---@return MaterialDefinition self
function MaterialDefinition:resistance(damage_type_id, amount) end

---@param vitamin_id string
---@param amount number
---@return MaterialDefinition self
function MaterialDefinition:vitamin(vitamin_id, amount) end

---@param level integer One-based damage adjective level.
---@param text string
---@return MaterialDefinition self
function MaterialDefinition:damage_adjective(level, text) end

---@param intensity integer One-based fire intensity.
---@param immune boolean
---@param volume_ml_per_turn integer
---@param fuel number
---@param smoke number
---@param burned number
---@return MaterialDefinition self
function MaterialDefinition:burn(intensity, immune, volume_ml_per_turn, fuel, smoke, burned) end

---@param item_id string
---@param efficiency number
---@return MaterialDefinition self
function MaterialDefinition:burn_product(item_id, efficiency) end

---@param energy_kilojoules integer
---@param pump_terrain? string
---@param perpetual? boolean
---@return MaterialDefinition self
function MaterialDefinition:fuel(energy_kilojoules, pump_terrain, perpetual) end

---@param chance_hot integer
---@param chance_cold integer
---@param factor number
---@param fiery boolean
---@param size_factor number
---@return MaterialDefinition self
function MaterialDefinition:fuel_explosion(chance_hot, chance_cold, factor, fiery, size_factor) end

---@class AmmunitionTypeDefinitionOptions
---@field id string Stable ammunition-family id.
---@field name? string Display name; defaults to id.
---@field default_item? string Default ammunition item id.

---@class AmmunitionTypeDefinition
---@field id string
local AmmunitionTypeDefinition = {}

---@class ItemCategoryDefinitionOptions
---@field id string Stable inventory category id.
---@field header? string Inventory header; defaults to id.
---@field noun? string Noun used in descriptive text; defaults to header.
---@field sort_rank? integer Lower ranks sort first.
---@field spawn_rate? number Non-negative item spawn multiplier.
---@field zone? string Default zone id.

---@class ItemCategoryDefinition
---@field id string
local ItemCategoryDefinition = {}

---@param zone_id string
---@param flags string[] Dense list of item flags; may be empty when `filthy` is true.
---@param filthy? boolean Whether the rule matches filthy items.
---@return ItemCategoryDefinition self
function ItemCategoryDefinition:priority_zone(zone_id, flags, filthy) end

---@class RecipeCategoryDefinitionOptions
---@field id string Stable `CC_` crafting category id.
---@field hidden? boolean
---@field practice? boolean
---@field building? boolean
---@field wildcard? boolean

---@class RecipeCategoryDefinition
---@field id string
local RecipeCategoryDefinition = {}

---@param id string `CSC_ALL` or a subcategory id matching this category.
---@return RecipeCategoryDefinition self
function RecipeCategoryDefinition:subcategory(id) end

---@class ProficiencyCategoryDefinitionOptions
---@field id string Stable proficiency category id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.

---@class ProficiencyCategoryDefinition
---@field id string
local ProficiencyCategoryDefinition = {}

---@class ProficiencyDefinitionOptions
---@field id string Stable proficiency id.
---@field name? string Display name; defaults to id.
---@field description string Player-facing description.
---@field category string ProficiencyCategory id.
---@field time_to_learn_turns? integer Positive training time in game turns.
---@field time_multiplier? number Non-negative default crafting time multiplier.
---@field skill_penalty? number Non-negative default crafting skill penalty.
---@field weakpoint_bonus? number
---@field weakpoint_penalty? number
---@field can_learn? boolean
---@field ignore_focus? boolean
---@field teachable? boolean

---@class ProficiencyDefinition
---@field id string
local ProficiencyDefinition = {}

---@param proficiency_id string
---@return ProficiencyDefinition self
function ProficiencyDefinition:requires(proficiency_id) end

---@param category string Native bonus category.
---@param attribute 'strength'|'dexterity'|'intelligence'|'perception'|'stamina'
---@param value number
---@return ProficiencyDefinition self
function ProficiencyDefinition:bonus(category, attribute, value) end

---@class WeaponCategoryDefinitionOptions
---@field id string Stable weapon category id.
---@field name? string Display name; defaults to id.

---@class WeaponCategoryDefinition
---@field id string
local WeaponCategoryDefinition = {}

---@param proficiency_id string
---@return WeaponCategoryDefinition self
function WeaponCategoryDefinition:proficiency(proficiency_id) end

---Non-copyable borrowed callback context. Every member becomes stale after the
---item-use handler returns or fails; saving the userdata does not extend its lease.
---@class ItemUseContext
---@field player_name string
---@field item_id string
---@field character GameHandle Runtime-owner- and generation-safe handle for the using character.
---@field item GameHandle Runtime-owner- and generation-safe handle for the used item instance.
---@field position TripointCoord Reality-bubble map-square (`bub`/`ms`) position of use.
---@field charges integer
local ItemUseContext = {}

---@param text string
function ItemUseContext:message(text) end

---@class CcbPlatformContent
local CcbPlatformContent = {}

---@param options ItemDefinitionOptions
---@return ItemDefinition
function CcbPlatformContent.Item(options) end

---@param options RecipeDefinitionOptions
---@return RecipeDefinition
function CcbPlatformContent.Recipe(options) end

---@param options NestedRecipeCategoryDefinitionOptions
---@return NestedRecipeCategoryDefinition
function CcbPlatformContent.NestedRecipeCategory(options) end

---@param options ToolQualityDefinitionOptions
---@return ToolQualityDefinition
function CcbPlatformContent.ToolQuality(options) end

---@param options SkillDisplayDefinitionOptions
---@return SkillDisplayDefinition
function CcbPlatformContent.SkillDisplay(options) end

---@param options SkillDefinitionOptions
---@return SkillDefinition
function CcbPlatformContent.Skill(options) end

---@param options VitaminDefinitionOptions
---@return VitaminDefinition
function CcbPlatformContent.Vitamin(options) end

---@param options JsonFlagDefinitionOptions
---@return JsonFlagDefinition
function CcbPlatformContent.JsonFlag(options) end

---@param options DamageTypeDefinitionOptions
---@return DamageTypeDefinition
function CcbPlatformContent.DamageType(options) end

---@param options MaterialDefinitionOptions
---@return MaterialDefinition
function CcbPlatformContent.Material(options) end

---@param options AmmunitionTypeDefinitionOptions
---@return AmmunitionTypeDefinition
function CcbPlatformContent.AmmunitionType(options) end

---@param options ItemCategoryDefinitionOptions
---@return ItemCategoryDefinition
function CcbPlatformContent.ItemCategory(options) end

---@param options RecipeCategoryDefinitionOptions
---@return RecipeCategoryDefinition
function CcbPlatformContent.RecipeCategory(options) end

---@param options ProficiencyCategoryDefinitionOptions
---@return ProficiencyCategoryDefinition
function CcbPlatformContent.ProficiencyCategory(options) end

---@param options ProficiencyDefinitionOptions
---@return ProficiencyDefinition
function CcbPlatformContent.Proficiency(options) end

---@param options WeaponCategoryDefinitionOptions
---@return WeaponCategoryDefinition
function CcbPlatformContent.WeaponCategory(options) end

---@param options RequirementDefinitionOptions
---@return RequirementDefinition
function CcbPlatformContent.Requirement(options) end

---@param options RecipeGroupDefinitionOptions
---@return RecipeGroupDefinition
function CcbPlatformContent.RecipeGroup(options) end

---@param options ScentTypeDefinitionOptions
---@return ScentTypeDefinition
function CcbPlatformContent.ScentType(options) end

---@param options SpeedDescriptionDefinitionOptions
---@return SpeedDescriptionDefinition
function CcbPlatformContent.SpeedDescription(options) end

---@param options HarvestDropTypeDefinitionOptions
---@return HarvestDropTypeDefinition
function CcbPlatformContent.HarvestDropType(options) end

---@param options HarvestDefinitionOptions
---@return HarvestDefinition
function CcbPlatformContent.Harvest(options) end

---@param options BehaviorDefinitionOptions
---@return BehaviorDefinition
function CcbPlatformContent.Behavior(options) end

---@param options MonsterAttackDefinitionOptions
---@return MonsterAttackDefinition
function CcbPlatformContent.MonsterAttack(options) end

---@param options EffectTypeDefinitionOptions
---@return EffectTypeDefinition
function CcbPlatformContent.EffectType(options) end

---@param options WeakpointSetDefinitionOptions
---@return WeakpointSetDefinition
function CcbPlatformContent.WeakpointSet(options) end

---@param options FieldTypeDefinitionOptions
---@return FieldTypeDefinition
function CcbPlatformContent.FieldType(options) end

---@param options ItemGroupDefinitionOptions
---@return ItemGroupDefinition
function CcbPlatformContent.ItemGroup(options) end

---@param options SubBodyPartDefinitionOptions
---@return SubBodyPartDefinition
function CcbPlatformContent.SubBodyPart(options) end

---@param options WoundDefinitionOptions
---@return WoundDefinition
function CcbPlatformContent.Wound(options) end

---@param options BodyPartDefinitionOptions
---@return BodyPartDefinition
function CcbPlatformContent.BodyPart(options) end

---@param options WoundFixDefinitionOptions
---@return WoundFixDefinition
function CcbPlatformContent.WoundFix(options) end

---@param options AnatomyDefinitionOptions
---@return AnatomyDefinition
function CcbPlatformContent.Anatomy(options) end

---@param options BodyGraphDefinitionOptions
---@return BodyGraphDefinition
function CcbPlatformContent.BodyGraph(options) end

---@param options MonsterDefinitionOptions
---@return MonsterDefinition
function CcbPlatformContent.Monster(options) end

---@param options MoraleTypeDefinitionOptions
---@return MoraleTypeDefinition
function CcbPlatformContent.MoraleType(options) end

---@param options DiseaseTypeDefinitionOptions
---@return DiseaseTypeDefinition
function CcbPlatformContent.DiseaseType(options) end

---@param options MonsterFlagDefinitionOptions
---@return MonsterFlagDefinition
function CcbPlatformContent.MonsterFlag(options) end

---@param options SpeciesDefinitionOptions
---@return SpeciesDefinition
function CcbPlatformContent.Species(options) end

---@param options EmissionDefinitionOptions
---@return EmissionDefinition
function CcbPlatformContent.Emission(options) end

---@param options MonsterFactionDefinitionOptions
---@return MonsterFactionDefinition
function CcbPlatformContent.MonsterFaction(options) end

---@param options MutationTypeDefinitionOptions
---@return MutationTypeDefinition
function CcbPlatformContent.MutationType(options) end

---@param options ConnectGroupDefinitionOptions
---@return ConnectGroupDefinition
function CcbPlatformContent.ConnectGroup(options) end

---@param options MutationCategoryDefinitionOptions
---@return MutationCategoryDefinition
function CcbPlatformContent.MutationCategory(options) end

---@param options ConstructionCategoryDefinitionOptions
---@return ConstructionCategoryDefinition
function CcbPlatformContent.ConstructionCategory(options) end

---@param options ConstructionGroupDefinitionOptions
---@return ConstructionGroupDefinition
function CcbPlatformContent.ConstructionGroup(options) end

---@param options VehiclePartLocationDefinitionOptions
---@return VehiclePartLocationDefinition
function CcbPlatformContent.VehiclePartLocation(options) end

---@param options MoodFaceDefinitionOptions
---@return MoodFaceDefinition
function CcbPlatformContent.MoodFace(options) end

---@param options DamageInfoOrderDefinitionOptions
---@return DamageInfoOrderDefinition
function CcbPlatformContent.DamageInfoOrder(options) end

---@param options VehiclePartCategoryDefinitionOptions
---@return VehiclePartCategoryDefinition
function CcbPlatformContent.VehiclePartCategory(options) end

---@param options NamedColorDefinitionOptions
---@return NamedColorDefinition
function CcbPlatformContent.NamedColor(options) end

---@param options RotatableSymbolDefinitionOptions
---@return RotatableSymbolDefinition
function CcbPlatformContent.RotatableSymbol(options) end

---@param options AsciiArtDefinitionOptions
---@return AsciiArtDefinition
function CcbPlatformContent.AsciiArt(options) end

---@param options LimbScoreDefinitionOptions
---@return LimbScoreDefinition
function CcbPlatformContent.LimbScore(options) end

---@param options HitRangeDefinitionOptions
---@return HitRangeDefinition
function CcbPlatformContent.HitRange(options) end

---@param options BashDamageProfileDefinitionOptions
---@return BashDamageProfileDefinition
function CcbPlatformContent.BashDamageProfile(options) end

---@param options ClothingModDefinitionOptions
---@return ClothingModDefinition
function CcbPlatformContent.ClothingMod(options) end

---@param options OvermapLandUseCodeDefinitionOptions
---@return OvermapLandUseCodeDefinition
function CcbPlatformContent.OvermapLandUseCode(options) end

---@param options OvermapVisionDefinitionOptions
---@return OvermapVisionDefinition
function CcbPlatformContent.OvermapVision(options) end

---@param options OvermapLocationDefinitionOptions
---@return OvermapLocationDefinition
function CcbPlatformContent.OvermapLocation(options) end

---@param options ProfessionGroupDefinitionOptions
---@return ProfessionGroupDefinition
function CcbPlatformContent.ProfessionGroup(options) end

---@param options MapExtraCollectionDefinitionOptions
---@return MapExtraCollectionDefinition
function CcbPlatformContent.MapExtraCollection(options) end

---@param options VehicleGroupDefinitionOptions
---@return VehicleGroupDefinition
function CcbPlatformContent.VehicleGroup(options) end

---@param options FaultGroupDefinitionOptions
---@return FaultGroupDefinition
function CcbPlatformContent.FaultGroup(options) end

---@param options ExplosionLightDefinitionOptions
---@return ExplosionLightDefinition
function CcbPlatformContent.ExplosionLight(options) end

---@param options AmmoEffectDefinitionOptions
---@return AmmoEffectDefinition
function CcbPlatformContent.AmmoEffect(options) end

---@param options AddictionTypeDefinitionOptions
---@return AddictionTypeDefinition
function CcbPlatformContent.AddictionType(options) end

---@param options CharacterModifierDefinitionOptions
---@return CharacterModifierDefinition
function CcbPlatformContent.CharacterModifier(options) end

---@param options StartLocationDefinitionOptions
---@return StartLocationDefinition
function CcbPlatformContent.StartLocation(options) end

---@param options ClimbingAidDefinitionOptions
---@return ClimbingAidDefinition
function CcbPlatformContent.ClimbingAid(options) end

---@param options WeatherTypeDefinitionOptions
---@return WeatherTypeDefinition
function CcbPlatformContent.WeatherType(options) end

---@param options ScoreDefinitionOptions
---@return ScoreDefinition
function CcbPlatformContent.Score(options) end

---@return OverlayOrderDefinition
function CcbPlatformContent.OverlayOrder() end

---@param options ZoneTypeDefinitionOptions
---@return ZoneTypeDefinition
function CcbPlatformContent.ZoneType(options) end

---@param options SpeechPoolDefinitionOptions
---@return SpeechPoolDefinition
function CcbPlatformContent.SpeechPool(options) end

---@param options EndScreenDefinitionOptions
---@return EndScreenDefinition
function CcbPlatformContent.EndScreen(options) end

---@param options ActivityTypeDefinitionOptions
---@return ActivityTypeDefinition
function CcbPlatformContent.ActivityType(options) end

---@param options HelpTopicDefinitionOptions
---@return HelpTopicDefinition
function CcbPlatformContent.HelpTopic(options) end

---@param options SnippetCategoryDefinitionOptions
---@return SnippetCategoryDefinition
function CcbPlatformContent.SnippetCategory(options) end

---@param options PlaylistDefinitionOptions
---@return PlaylistDefinition
function CcbPlatformContent.Playlist(options) end

---@param options AttackVectorDefinitionOptions
---@return AttackVectorDefinition
function CcbPlatformContent.AttackVector(options) end

---@param options MagicTypeDefinitionOptions
---@return MagicTypeDefinition
function CcbPlatformContent.MagicType(options) end

---@param options MovementModeDefinitionOptions
---@return MovementModeDefinition
function CcbPlatformContent.MovementMode(options) end

---@alias PlatformContentDefinition ItemDefinition|RecipeDefinition|NestedRecipeCategoryDefinition|ToolQualityDefinition|SkillDisplayDefinition|SkillDefinition|VitaminDefinition|JsonFlagDefinition|DamageTypeDefinition|MaterialDefinition|AmmunitionTypeDefinition|ItemCategoryDefinition|RecipeCategoryDefinition|ProficiencyCategoryDefinition|ProficiencyDefinition|WeaponCategoryDefinition|RequirementDefinition|RecipeGroupDefinition|ScentTypeDefinition|SpeedDescriptionDefinition|HarvestDropTypeDefinition|HarvestDefinition|BehaviorDefinition|MonsterAttackDefinition|EffectTypeDefinition|WeakpointSetDefinition|FieldTypeDefinition|ItemGroupDefinition|SubBodyPartDefinition|WoundDefinition|BodyPartDefinition|WoundFixDefinition|AnatomyDefinition|BodyGraphDefinition|MonsterDefinition|MoraleTypeDefinition|DiseaseTypeDefinition|MonsterFlagDefinition|SpeciesDefinition|EmissionDefinition|MonsterFactionDefinition|MutationTypeDefinition|ConnectGroupDefinition|MutationCategoryDefinition|ConstructionCategoryDefinition|ConstructionGroupDefinition|VehiclePartLocationDefinition|MoodFaceDefinition|DamageInfoOrderDefinition|VehiclePartCategoryDefinition|NamedColorDefinition|RotatableSymbolDefinition|AsciiArtDefinition|LimbScoreDefinition|HitRangeDefinition|BashDamageProfileDefinition|ClothingModDefinition|OvermapLandUseCodeDefinition|OvermapVisionDefinition|OvermapLocationDefinition|ProfessionGroupDefinition|MapExtraCollectionDefinition|VehicleGroupDefinition|FaultGroupDefinition|ExplosionLightDefinition|AmmoEffectDefinition|AddictionTypeDefinition|CharacterModifierDefinition|StartLocationDefinition|ClimbingAidDefinition|WeatherTypeDefinition|ScoreDefinition|OverlayOrderDefinition|ZoneTypeDefinition|SpeechPoolDefinition|EndScreenDefinition|ActivityTypeDefinition|HelpTopicDefinition|SnippetCategoryDefinition|PlaylistDefinition|AttackVectorDefinition|MagicTypeDefinition|MovementModeDefinition

---@param definition PlatformContentDefinition
function CcbPlatformContent.add(definition) end
---@param definition PlatformContentDefinition
function CcbPlatformContent.replace(definition) end
---@param definition PlatformContentDefinition Clone of a definition staged earlier by this Mod.
function CcbPlatformContent.edit(definition) end

---@param id string Item id staged earlier by this Mod in the current candidate.
---@return ItemDefinition
function CcbPlatformContent.edit_item(id) end

---@param id string Recipe id staged earlier by this Mod in the current candidate.
---@return RecipeDefinition
function CcbPlatformContent.edit_recipe(id) end

---@param id string Nested recipe-category id staged earlier by this Mod.
---@return NestedRecipeCategoryDefinition
function CcbPlatformContent.edit_nested_recipe_category(id) end

---@param id string Tool-quality id staged earlier by this Mod.
---@return ToolQualityDefinition
function CcbPlatformContent.edit_tool_quality(id) end

---@param id string Skill display-category id staged earlier by this Mod.
---@return SkillDisplayDefinition
function CcbPlatformContent.edit_skill_display(id) end

---@param id string Skill id staged earlier by this Mod.
---@return SkillDefinition
function CcbPlatformContent.edit_skill(id) end

---@param id string Vitamin id staged earlier by this Mod.
---@return VitaminDefinition
function CcbPlatformContent.edit_vitamin(id) end

---@param id string JSON flag id staged earlier by this Mod.
---@return JsonFlagDefinition
function CcbPlatformContent.edit_json_flag(id) end

---@param id string Damage type id staged earlier by this Mod.
---@return DamageTypeDefinition
function CcbPlatformContent.edit_damage_type(id) end

---@param id string Material id staged earlier by this Mod.
---@return MaterialDefinition
function CcbPlatformContent.edit_material(id) end

---@param id string Ammunition-type id staged earlier by this Mod.
---@return AmmunitionTypeDefinition
function CcbPlatformContent.edit_ammunition_type(id) end

---@param id string Item-category id staged earlier by this Mod.
---@return ItemCategoryDefinition
function CcbPlatformContent.edit_item_category(id) end

---@param id string Recipe-category id staged earlier by this Mod.
---@return RecipeCategoryDefinition
function CcbPlatformContent.edit_recipe_category(id) end

---@param id string Proficiency-category id staged earlier by this Mod.
---@return ProficiencyCategoryDefinition
function CcbPlatformContent.edit_proficiency_category(id) end

---@param id string Proficiency id staged earlier by this Mod.
---@return ProficiencyDefinition
function CcbPlatformContent.edit_proficiency(id) end

---@param id string Weapon-category id staged earlier by this Mod.
---@return WeaponCategoryDefinition
function CcbPlatformContent.edit_weapon_category(id) end

---@param id string Reusable requirement id staged earlier by this Mod.
---@return RequirementDefinition
function CcbPlatformContent.edit_requirement(id) end

---@param id string Recipe-group id staged earlier by this Mod.
---@return RecipeGroupDefinition
function CcbPlatformContent.edit_recipe_group(id) end

---@param id string Scent-type id staged earlier by this Mod.
---@return ScentTypeDefinition
function CcbPlatformContent.edit_scent_type(id) end

---@param id string Speed-description id staged earlier by this Mod.
---@return SpeedDescriptionDefinition
function CcbPlatformContent.edit_speed_description(id) end

---@param id string Harvest-drop type id staged earlier by this Mod.
---@return HarvestDropTypeDefinition
function CcbPlatformContent.edit_harvest_drop_type(id) end

---@param id string Harvest-list id staged earlier by this Mod.
---@return HarvestDefinition
function CcbPlatformContent.edit_harvest(id) end

---@param id string Behavior id staged earlier by this Mod.
---@return BehaviorDefinition
function CcbPlatformContent.edit_behavior(id) end

---@param id string MonsterAttack id staged earlier by this Mod.
---@return MonsterAttackDefinition
function CcbPlatformContent.edit_monster_attack(id) end

---@param id string EffectType id staged earlier by this Mod.
---@return EffectTypeDefinition
function CcbPlatformContent.edit_effect_type(id) end

---@param id string WeakpointSet id staged earlier by this Mod.
---@return WeakpointSetDefinition
function CcbPlatformContent.edit_weakpoint_set(id) end

---@param id string FieldType id staged earlier by this Mod.
---@return FieldTypeDefinition
function CcbPlatformContent.edit_field_type(id) end

---@param id string ItemGroup id staged earlier by this Mod.
---@return ItemGroupDefinition
function CcbPlatformContent.edit_item_group(id) end

---@param id string SubBodyPart id staged earlier by this Mod.
---@return SubBodyPartDefinition
function CcbPlatformContent.edit_sub_body_part(id) end

---@param id string Wound id staged earlier by this Mod.
---@return WoundDefinition
function CcbPlatformContent.edit_wound(id) end

---@param id string BodyPart id staged earlier by this Mod.
---@return BodyPartDefinition
function CcbPlatformContent.edit_body_part(id) end

---@param id string Wound-fix id staged earlier by this Mod.
---@return WoundFixDefinition
function CcbPlatformContent.edit_wound_fix(id) end

---@param id string Anatomy id staged earlier by this Mod.
---@return AnatomyDefinition
function CcbPlatformContent.edit_anatomy(id) end

---@param id string BodyGraph id staged earlier by this Mod.
---@return BodyGraphDefinition
function CcbPlatformContent.edit_body_graph(id) end

---@param id string Monster id staged earlier by this Mod.
---@return MonsterDefinition
function CcbPlatformContent.edit_monster(id) end

---@param id string Morale-type id staged earlier by this Mod.
---@return MoraleTypeDefinition
function CcbPlatformContent.edit_morale_type(id) end

---@param id string Disease-type id staged earlier by this Mod.
---@return DiseaseTypeDefinition
function CcbPlatformContent.edit_disease_type(id) end

---@param id string Monster-flag id staged earlier by this Mod.
---@return MonsterFlagDefinition
function CcbPlatformContent.edit_monster_flag(id) end

---@param id string Species id staged earlier by this Mod.
---@return SpeciesDefinition
function CcbPlatformContent.edit_species(id) end

---@param id string Emission id staged earlier by this Mod.
---@return EmissionDefinition
function CcbPlatformContent.edit_emission(id) end

---@param id string Monster-faction id staged earlier by this Mod.
---@return MonsterFactionDefinition
function CcbPlatformContent.edit_monster_faction(id) end

---@param id string Mutation-type id staged earlier by this Mod.
---@return MutationTypeDefinition
function CcbPlatformContent.edit_mutation_type(id) end

---@param id string Connect-group id staged earlier by this Mod.
---@return ConnectGroupDefinition
function CcbPlatformContent.edit_connect_group(id) end

---@param id string Mutation-category id staged earlier by this Mod.
---@return MutationCategoryDefinition
function CcbPlatformContent.edit_mutation_category(id) end

---@param id string Construction-category id staged earlier by this Mod.
---@return ConstructionCategoryDefinition
function CcbPlatformContent.edit_construction_category(id) end

---@param id string Construction-group id staged earlier by this Mod.
---@return ConstructionGroupDefinition
function CcbPlatformContent.edit_construction_group(id) end

---@param id string Vehicle-part location id staged earlier by this Mod.
---@return VehiclePartLocationDefinition
function CcbPlatformContent.edit_vehicle_part_location(id) end

---@param id string Mood-face id staged earlier by this Mod.
---@return MoodFaceDefinition
function CcbPlatformContent.edit_mood_face(id) end

---@param id string Damage-info order id staged earlier by this Mod.
---@return DamageInfoOrderDefinition
function CcbPlatformContent.edit_damage_info_order(id) end

---@param id string Vehicle-part category id staged earlier by this Mod.
---@return VehiclePartCategoryDefinition
function CcbPlatformContent.edit_vehicle_part_category(id) end

---@param name string Named-color identity staged earlier by this Mod.
---@return NamedColorDefinition
function CcbPlatformContent.edit_named_color(name) end

---@param key string First glyph of a rotatable-symbol group staged earlier by this Mod.
---@return RotatableSymbolDefinition
function CcbPlatformContent.edit_rotatable_symbol(key) end

---@param id string ASCII-art id staged earlier by this Mod.
---@return AsciiArtDefinition
function CcbPlatformContent.edit_ascii_art(id) end

---@param id string Limb-score id staged earlier by this Mod.
---@return LimbScoreDefinition
function CcbPlatformContent.edit_limb_score(id) end

---@param id string Bash-damage profile id staged earlier by this Mod.
---@return BashDamageProfileDefinition
function CcbPlatformContent.edit_bash_damage_profile(id) end

---@param id string Clothing-modification id staged earlier by this Mod.
---@return ClothingModDefinition
function CcbPlatformContent.edit_clothing_mod(id) end

---@param id string Overmap land-use id staged earlier by this Mod.
---@return OvermapLandUseCodeDefinition
function CcbPlatformContent.edit_overmap_land_use_code(id) end

---@param id string Overmap-vision id staged earlier by this Mod.
---@return OvermapVisionDefinition
function CcbPlatformContent.edit_overmap_vision(id) end

---@param id string Overmap-location id staged earlier by this Mod.
---@return OvermapLocationDefinition
function CcbPlatformContent.edit_overmap_location(id) end

---@param id string Profession-group id staged earlier by this Mod.
---@return ProfessionGroupDefinition
function CcbPlatformContent.edit_profession_group(id) end

---@param id string Map-extra collection id staged earlier by this Mod.
---@return MapExtraCollectionDefinition
function CcbPlatformContent.edit_map_extra_collection(id) end

---@param id string Vehicle-group id staged earlier by this Mod.
---@return VehicleGroupDefinition
function CcbPlatformContent.edit_vehicle_group(id) end

---@param id string Fault-group id staged earlier by this Mod.
---@return FaultGroupDefinition
function CcbPlatformContent.edit_fault_group(id) end

---@param id string Explosion-light id staged earlier by this Mod.
---@return ExplosionLightDefinition
function CcbPlatformContent.edit_explosion_light(id) end

---@param id string Ammunition-effect id staged earlier by this Mod.
---@return AmmoEffectDefinition
function CcbPlatformContent.edit_ammo_effect(id) end

---@param id string Addiction-type id staged earlier by this Mod.
---@return AddictionTypeDefinition
function CcbPlatformContent.edit_addiction_type(id) end

---@param id string Character-modifier id staged earlier by this Mod.
---@return CharacterModifierDefinition
function CcbPlatformContent.edit_character_modifier(id) end

---@param id string Start-location id staged earlier by this Mod.
---@return StartLocationDefinition
function CcbPlatformContent.edit_start_location(id) end

---@param id string Climbing-aid id staged earlier by this Mod.
---@return ClimbingAidDefinition
function CcbPlatformContent.edit_climbing_aid(id) end

---@param id string Weather-type id staged earlier by this Mod.
---@return WeatherTypeDefinition
function CcbPlatformContent.edit_weather_type(id) end

---@param id string Score id staged earlier by this Mod.
---@return ScoreDefinition
function CcbPlatformContent.edit_score(id) end

---@return OverlayOrderDefinition Clone of the global overlay-order singleton staged earlier by this Mod.
function CcbPlatformContent.edit_overlay_order() end

---@param id string Zone-type id staged earlier by this Mod.
---@return ZoneTypeDefinition
function CcbPlatformContent.edit_zone_type(id) end

---@param id string Speech-pool id staged earlier by this Mod.
---@return SpeechPoolDefinition
function CcbPlatformContent.edit_speech_pool(id) end

---@param id string End-screen id staged earlier by this Mod.
---@return EndScreenDefinition
function CcbPlatformContent.edit_end_screen(id) end

---@param id string Activity-type id staged earlier by this Mod.
---@return ActivityTypeDefinition
function CcbPlatformContent.edit_activity_type(id) end

---@param id string Help-topic id staged earlier by this Mod.
---@return HelpTopicDefinition
function CcbPlatformContent.edit_help_topic(id) end

---@param id string Snippet-category id staged earlier by this Mod.
---@return SnippetCategoryDefinition
function CcbPlatformContent.edit_snippet_category(id) end

---@param id string Playlist id staged earlier by this Mod.
---@return PlaylistDefinition
function CcbPlatformContent.edit_playlist(id) end

---@param id string Attack-vector id staged earlier by this Mod.
---@return AttackVectorDefinition
function CcbPlatformContent.edit_attack_vector(id) end

---@param id string Magic-type id staged earlier by this Mod.
---@return MagicTypeDefinition
function CcbPlatformContent.edit_magic_type(id) end

---@param id string Movement-mode id staged earlier by this Mod.
---@return MovementModeDefinition
function CcbPlatformContent.edit_movement_mode(id) end

---@class CcbPlatformNativeEvent
---@field type string Native event type without the `game:` prefix.
---@field turn integer Absolute event turn.
---@field data table<string, boolean|integer|string>
---@field data_types table<string, string>
---Live handles keyed by semantic native event fields. Character-id fields use
---names such as `character`, `attacker`, `killer`, or `victim`. `item` exists
---only for character_wields_item, character_wears_item,
---character_takeoff_item, and character_armor_destroyed when the native event
---actually carries an item_location talker. No positional/avatar fallback or
---EOC alpha/beta aliases are added.
---@field actors table<string, GameHandle>

---@class CcbPlatformDialogueStartHook
---@field avatar GameHandle The avatar starting the dialogue.
---@field interlocutor GameHandle|table The creature/entity handle or detached non-entity talker snapshot.
---@field initial_topic string Initial dialogue topic id.

---@class CcbPlatformDialogueOptionHook
---@field avatar GameHandle The avatar participating in the dialogue.
---@field interlocutor GameHandle|table The creature/entity handle or detached non-entity talker snapshot.
---@field current_topic string Topic being left.
---@field selected_topic string Topic selected by the native dialogue response.

---@class CcbPlatformDialogueEndHook
---@field avatar GameHandle The avatar ending the dialogue.
---@field interlocutor GameHandle|table The creature/entity handle or detached non-entity talker snapshot.
---@field last_topic string Last processed dialogue topic id.

---@class CcbPlatformRuntime
local CcbPlatformRuntime = {}

---@param id string
---@param callback fun(payload: any): any
---@param payload_version? integer
function CcbPlatformRuntime.handler(id, callback, payload_version) end
---@param event_name string `world_ready`, `before_save`, `after_save`, `shutdown`, or `game:<event>`.
---@param handler_id string
function CcbPlatformRuntime.on(event_name, handler_id) end

---@param hook_name string Native synchronous hook name from the checked hook catalog.
---@param handler_id string Named Platform handler.
function CcbPlatformRuntime.hook(hook_name, handler_id) end

---@class PlatformTaskMigration
---@field task_id integer
---@field handler_id string
---@field owner 'character'|'world'
---@field from_version integer
---@field to_version integer

---@param handler_id string
---@param from_version integer
---@param to_version integer
---@param callback fun(payload: table<string, boolean|integer|number|string>, migration: PlatformTaskMigration): table<string, boolean|integer|number|string>
function CcbPlatformRuntime.migrate_task_payload(handler_id, from_version, to_version, callback) end

---@class CcbPlatformStateScope
local CcbPlatformStateScope = {}

---@param key string
---@param fallback? boolean|integer|number|string
---@return boolean|integer|number|string|nil
function CcbPlatformStateScope.get(key, fallback) end

---@param key string
---@param value boolean|integer|number|string|nil
function CcbPlatformStateScope.set(key, value) end

---@class CcbPlatformState
---@field character CcbPlatformStateScope
---@field world CcbPlatformStateScope

---@class PlatformTaskPayload
---@field id integer
---@field due_turn integer
---@field overdue_turns integer
---@field owner 'character'|'world'
---@field payload_version integer
---@field payload table<string, boolean|integer|number|string>

---@class CcbPlatformTasks
local CcbPlatformTasks = {}

---@param turns integer Non-negative delay in game turns.
---@param handler_id string
---@param payload? table<string, boolean|integer|number|string>
---@param payload_version? integer
---@param owner? 'character'|'world'
---@return integer task_id
function CcbPlatformTasks.after(turns, handler_id, payload, payload_version, owner) end

---@param task_id integer
---@return boolean cancelled
function CcbPlatformTasks.cancel(task_id) end

---@class PlatformChoice
---@field id string Stable value returned to Lua when selected.
---@field label string Player-facing label.
---@field description? string Optional longer explanation.
---@field enabled? boolean Whether the choice can be selected; defaults to true.

---@class PlatformTextInputOptions
---@field initial? string Initial editable value.
---@field description? string Help text displayed with the input.
---@field width? integer Input width from zero through 240 cells; zero uses the native default.
---@field max_length? integer Maximum Unicode characters, from one through 32768.
---@field only_digits? boolean Reject non-digit input.

---@class CcbPlatformPresentation
local CcbPlatformPresentation = {}

---@param message string
function CcbPlatformPresentation.notice(message) end

---@param question string
---@return boolean confirmed
function CcbPlatformPresentation.confirm(question) end

---@param prompt string
---@param entries PlatformChoice[] Dense one-based array; holes and non-integer keys are rejected.
---@return string|nil selected_id
function CcbPlatformPresentation.choose(prompt, entries) end

---@param prompt string
---@param options? PlatformTextInputOptions
---@return string|nil text
function CcbPlatformPresentation.input_text(prompt, options) end

---@class CcbPlatformServices
---@field achievements CcbPlatformAchievementsApi
---@field activities CcbPlatformActivitiesApi
---@field addictions CcbAddictionsApi
---@field bionics CcbPlatformBionicsApi
---@field camps CcbCampsApi
---@field characters CcbCharactersApi
---@field constants CcbConstantsApi
---@field coords CcbCoordsApi
---@field crafting CcbCraftingApi
---@field creatures CcbCreaturesApi
---@field effects CcbEffectsApi
---@field enums CcbEnumsApi
---@field factions CcbFactionsApi
---@field followers CcbFollowersApi
---@field handles CcbHandlesApi Handles are bound to the exact Platform Mod runtime owner as well as its runtime/world generations.
---@field hordes CcbHordesApi
---@field inventory CcbPlatformInventoryApi
---@field items CcbItemsApi
---@field martial_arts CcbPlatformMartialArtsApi
---@field messages CcbMessagesApi
---@field missions CcbMissionsApi
---@field morale CcbPlatformMoraleApi
---@field mutations CcbMutationsApi
---@field needs CcbNeedsApi
---@field npcs CcbNpcsApi
---@field overmap CcbOvermapApi
---@field proficiencies CcbProficienciesApi
---@field random CcbPlatformRandomApi
---@field recipes CcbPlatformRecipesApi
---@field relocation CcbRelocationApi
---@field requirements CcbRequirementsApi
---@field serde CcbSerdeApi
---@field skills CcbSkillsApi
---@field sound CcbSoundApi
---@field spawns CcbSpawnsApi
---@field spells CcbSpellsApi
---@field statistics CcbStatisticsApi
---@field targeting CcbTargetingApi
---@field time CcbTimeApi
---@field types CcbTypesApi
---@field units CcbUnitsApi
---@field variables CcbVariablesApi
---@field vehicles CcbVehiclesApi
---@field vitamins CcbVitaminsApi
---@field weather CcbWeatherApi
---@field wounds CcbPlatformWoundsApi
---@field world CcbWorldApi
---@field zones CcbZonesApi
---@field gameplay CcbPlatformGameplayApi
local CcbPlatformServices = {}

---@class CcbPlatformInventoryApi: CcbInventoryApi
local CcbPlatformInventoryApi = {}

---Return the Character's singular physical wielded item without scanning a page.
---A force-unarmed martial-art style does not hide a physically wielded item;
---compose that policy separately through `martial_arts.current`.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a live item GameHandle or nil when no item is wielded.
function CcbPlatformInventoryApi.wielded(character) end

---@class CcbPlatformAchievementsApi: CcbAchievementsApi
local CcbPlatformAchievementsApi = {}

---Complete any currently tracked pending achievement, matching native gameplay awards.
---@param id GameId GameId<achievement>
---@return CcbResult result `value` is true only when this call changed the completion state.
function CcbPlatformAchievementsApi.complete(id) end

---@class CcbPlatformActivitySnapshot
---@field active boolean
---@field id? GameId GameId<activity>; nil when no activity is active.
---@field verb string Player-facing progressive verb, or an empty string when inactive.
---@field moves_total integer Native total move budget.
---@field moves_left integer Native remaining move budget.
---@field interruptible boolean
---@field interruptible_with_keyboard boolean
---@field auto_resume boolean
---@field rooted boolean
---@field resumable boolean
---@field progress number Clamped progress from zero through one when the move budget permits it.

---@class CcbPlatformActivityMutation
---@field changed boolean
---@field activity CcbPlatformActivitySnapshot Resulting current activity.

---@class CcbPlatformActivitiesApi
local CcbPlatformActivitiesApi = {}

---Read a detached snapshot of one Character's current native activity.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformActivitySnapshot.
function CcbPlatformActivitiesApi.snapshot(character) end

---Assign a plain time-based activity through native Character assignment rules.
---Native actors/handlers, EOC policies, multi-activity workflows, automatic-needs
---activities, and speed/neither budgets require dedicated Lua-native services.
---@param character GameHandle Character handle.
---@param id GameId GameId<activity>
---@param duration TimeDuration Positive duration whose move budget fits the native integer range.
---@return CcbResult result `value` is a CcbPlatformActivityMutation.
function CcbPlatformActivitiesApi.assign_timed(character, id, duration) end

---Cancel the current activity through native cleanup, backlog, and resumption rules.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformActivityMutation.
function CcbPlatformActivitiesApi.cancel(character) end

---@class CcbPlatformWoundSnapshot
---@field id GameId GameId<wound>
---@field base_pain integer Pain rolled when this wound instance was created.
---@field current_pain integer Current pain after native healing attenuation.
---@field healing_time TimeDuration Total native healing duration.
---@field healing_progress TimeDuration Accumulated native healing progress.
---@field healing_fraction number Native healing fraction from zero through one.

---@class CcbPlatformWoundMutation
---@field changed boolean Whether the exact body-part wound sequence changed.
---@field before CcbPlatformWoundSnapshot[] Detached native-order snapshot before mutation.
---@field after CcbPlatformWoundSnapshot[] Detached native-order snapshot after mutation.

---@class CcbPlatformWoundsApi
local CcbPlatformWoundsApi = {}

---Read one Character's wounds on an exact current-anatomy body part.
---No nearest-part or other body-part fallback is performed.
---Wrong GameId kinds or unknown ids raise invalid_argument; handle, target,
---and missing-part failures use the returned CcbResult error.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@return CcbResult result `value` is a dense native-order CcbPlatformWoundSnapshot array.
function CcbPlatformWoundsApi.snapshot(character, body_part) end

---Add or worsen one typed wound on an exact body part; runtime-callback write only.
---The Wound per-part limit is authoritative; reaching it returns `changed = false`.
---The explicit body part is authoritative: direct add bypasses the Wound's natural
---damage-selection body-part eligibility.  A changed add immediately resynchronizes
---the Character's perceived-pain derived state.
---Wrong GameId kinds or unknown ids raise invalid_argument before mutation.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@param wound GameId GameId<wound>
---@return CcbResult result `value` is a CcbPlatformWoundMutation with detached native-order before/after arrays.
function CcbPlatformWoundsApi.add(character, body_part, wound) end

---Remove every instance of one wound type from an exact body part; runtime-callback write only.
---A changed removal immediately resynchronizes the Character's perceived-pain derived state.
---Wrong GameId kinds or unknown ids raise invalid_argument before mutation.
---@param character GameHandle Character handle.
---@param body_part GameId GameId<body_part>
---@param wound GameId GameId<wound>
---@return CcbResult result `value` has detached native-order before/after arrays; absent instances produce `changed = false`.
function CcbPlatformWoundsApi.remove(character, body_part, wound) end

---@class CcbPlatformBionicsApi: CcbBionicsApi
local CcbPlatformBionicsApi = {}

---@class CcbPlatformBionicSummary
---@field installed_count integer Number of installed bionic instances; power-storage capacity may exist without an instance.
---@field power UnitValue Current bionic energy.
---@field maximum_power UnitValue Maximum bionic energy.
---@field has_capacity boolean Whether maximum bionic energy is greater than zero.

---Read composable installed-count and power-capacity facts without a paginated instance scan.
---@param character GameHandle Character handle.
---@return CcbResult result `value` is a CcbPlatformBionicSummary.
function CcbPlatformBionicsApi.summary(character) end

---Grant a bionic through native gameplay rules without the v5 inspection-list limit.
---@param character GameHandle Character handle.
---@param id GameId GameId<bionic>
---@return CcbResult result `value.changed` reports whether the character gained instances.
function CcbPlatformBionicsApi.grant(character, id) end

---Remove the first matching bionic instance through native gameplay rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<bionic>
---@return CcbResult result `value.changed` reports whether an instance was removed.
function CcbPlatformBionicsApi.remove_type(character, id) end

---@class CcbPlatformRecipesApi: CcbRecipesApi
local CcbPlatformRecipesApi = {}

---Query learned knowledge rather than temporary book/helper availability.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value` is true only when the Character knows this recipe.
function CcbPlatformRecipesApi.knows(character, id) end

---Teach a recipe through native character rules, including `never_learn` policy.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value.changed` reports whether learned state changed; `value.known` is the resulting state.
function CcbPlatformRecipesApi.learn(character, id) end

---Forget one learned recipe through native character rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<recipe>
---@return CcbResult result `value.changed` reports whether learned state changed; `value.known` is the resulting state.
function CcbPlatformRecipesApi.forget(character, id) end

---@class CcbPlatformRecipeCategoryForget
---@field changed boolean Whether at least one learned recipe was forgotten.
---@field forgotten_count integer Number of learned recipes removed.
---@field known_before integer Learned-recipe count before removal.
---@field known_after integer Learned-recipe count after removal.
---@field category GameId GameId<crafting_category> used for selection.
---@field subcategory? string Optional native subcategory selector.

---Forget every learned recipe in one category, optionally narrowed to a subcategory.
---This does not enumerate or mutate recipes available only from books, helpers, or other temporary sources.
---Native CSC_ALL/FAVORITE/RECENT/HIDDEN selectors retain their engine selection rules.
---@param character GameHandle Character handle.
---@param category GameId GameId<crafting_category>
---@param subcategory? string Native subcategory id; omitted or empty selects the whole category.
---@return CcbResult result `value` is a CcbPlatformRecipeCategoryForget.
function CcbPlatformRecipesApi.forget_category(character, category, subcategory) end

---@class CcbPlatformMartialArtsApi: CcbMartialArtsApi
local CcbPlatformMartialArtsApi = {}

---Learn one martial-art style without coupling the mutation to presentation.
---@param character GameHandle Character handle.
---@param id GameId GameId<martial_art>
---@return CcbResult result `value.changed` reports whether known state changed; `value.known` is the resulting state.
function CcbPlatformMartialArtsApi.learn(character, id) end

---Forget one martial-art style through the character's native style collection.
---@param character GameHandle Character handle.
---@param id GameId GameId<martial_art>
---@return CcbResult result `value.changed` reports whether known state changed; `value.known` is the resulting state.
function CcbPlatformMartialArtsApi.forget(character, id) end

---@class CcbPlatformMoraleOptions
---@field duration? TimeDuration Non-negative; defaults to one hour.
---@field decay_start? TimeDuration Non-negative; defaults to thirty minutes.
---@field capped? boolean Defaults to false.

---@class CcbPlatformMoraleApi
local CcbPlatformMoraleApi = {}

---Add or combine one typed morale instance through native stacking rules.
---@param character GameHandle Character handle.
---@param id GameId GameId<morale>
---@param bonus integer
---@param max_bonus integer
---@param options? CcbPlatformMoraleOptions
---@return CcbResult result `value.before` and `value.after` are the matching net bonuses.
function CcbPlatformMoraleApi.add(character, id, bonus, max_bonus, options) end

---Remove all item-specific variants of one morale type.
---@param character GameHandle Character handle.
---@param id GameId GameId<morale>
---@return CcbResult result `value.before` and `value.after` are the matching net bonuses; `value.changed` reports whether they differ.
function CcbPlatformMoraleApi.remove(character, id) end

---@class CcbPlatformRandomApi: CcbRandomApi
local CcbPlatformRandomApi = {}

---@param minimum integer Inclusive lower bound in -1000000000..1000000000.
---@param maximum integer Inclusive upper bound in -1000000000..1000000000.
---@return integer
function CcbPlatformRandomApi.int(minimum, maximum) end

---@param numerator integer
---@param denominator integer Positive denominator up to 1000000000.
---@return boolean
function CcbPlatformRandomApi.chance(numerator, denominator) end

---@param denominator number Converted to a native integer; values at or below one always succeed.
---@return boolean
function CcbPlatformRandomApi.one_in(denominator) end

---@param numerator number
---@param denominator number Positive finite denominator with `0 <= numerator <= denominator`.
---@return boolean
function CcbPlatformRandomApi.probability(numerator, denominator) end

---@param minimum integer Inclusive lower bound.
---@param maximum integer Inclusive upper bound.
---@param count integer Number of results from 0 through 1024.
---@param with_replacement? boolean Defaults to false.
---@return integer[] values Dense sampled values; unique unless replacement was requested.
function CcbPlatformRandomApi.sample_integers(minimum, maximum, count, with_replacement) end

---@param check number
---@param difficulty number
---@param die_size? integer Defaults to 10.
---@return boolean success True when `random(1, die_size) + check > difficulty`.
function CcbPlatformRandomApi.contested(check, difficulty, die_size) end

---@class CcbPlatformStringPredicates
local CcbPlatformStringPredicates = {}

---@param values string[] At least two strings.
---@return boolean duplicate_found
function CcbPlatformStringPredicates.any_equal(values) end

---@param values string[] At least one string.
---@return boolean all_match
function CcbPlatformStringPredicates.all_equal(values) end

---@class CcbPlatformModQueries
local CcbPlatformModQueries = {}

---@param mod_id string
---@return boolean loaded Includes active Lua-first Platform Mods and the world's active Mod order.
function CcbPlatformModQueries.is_loaded(mod_id) end

---@class CcbPlatformEnvironmentQueries
local CcbPlatformEnvironmentQueries = {}

---@return string dimension_id Stable id of the currently active dimension.
function CcbPlatformEnvironmentQueries.dimension() end

---@param position TripointCoord Absolute map-square coordinate inside the active map.
---@return boolean
function CcbPlatformEnvironmentQueries.is_outside(position) end

---@param from TripointCoord Absolute map-square coordinate inside the active map.
---@param to TripointCoord Absolute map-square coordinate inside the active map.
---@param range integer Non-negative maximum range.
---@param with_fields? boolean Defaults to true.
---@return boolean visible
function CcbPlatformEnvironmentQueries.line_of_sight(from, to, range, with_fields) end

---@class CcbPlatformGameplayApi
---@field strings CcbPlatformStringPredicates
---@field mods CcbPlatformModQueries
---@field environment CcbPlatformEnvironmentQueries
local CcbPlatformGameplayApi = {}

---@param text string
function CcbPlatformServices.message(text) end

---@return integer
function CcbPlatformServices.turn() end

---@return CcbPlayerSnapshot
function CcbPlatformServices.player_snapshot() end

---@return CcbPlayerSnapshot
function CcbPlatformServices.player_stats() end

---@return CcbMovementModesSnapshot
function CcbPlatformServices.movement_modes_snapshot() end

---@return CcbTimeSnapshot
function CcbPlatformServices.time_snapshot() end

---@return CcbWeatherSnapshot
function CcbPlatformServices.weather_snapshot() end

---@param limit? integer
---@return CcbBoundedItemList
function CcbPlatformServices.inventory_snapshot(limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.effects_snapshot(limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.skills_snapshot(limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.equipment_snapshot(limit) end

---@param uid integer
---@param limit? integer
---@return table
function CcbPlatformServices.item_contents_snapshot(uid, limit) end

---@param field_limit? integer
---@return table
function CcbPlatformServices.current_tile_snapshot(field_limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.mutations_snapshot(limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.bionics_snapshot(limit) end

---@param limit? integer
---@return table
function CcbPlatformServices.missions_snapshot(limit) end

---@return table
function CcbPlatformServices.activity_snapshot() end

---@param radius? integer
---@param limit? integer
---@return table
function CcbPlatformServices.nearby_creatures_snapshot(radius, limit) end

---@class CcbPlatformV1
---@field platform_version 1
---@field ModDefinition fun(options: ModDefinitionOptions): ModDefinition
---@field content CcbPlatformContent
---@field runtime CcbPlatformRuntime
---@field state CcbPlatformState
---@field tasks CcbPlatformTasks
---@field presentation CcbPlatformPresentation
---@field services CcbPlatformServices
local ccb = {}

return ccb
