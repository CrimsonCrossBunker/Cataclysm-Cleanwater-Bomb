---@meta

-- LuaLS declarations for the CCB Lua Mod API v5.
-- This file is editor metadata. Do not require or copy it into runtime code.

---@alias CcbScalar boolean|integer|number|string
---@alias CcbScalarMap table<string, CcbScalar>
---@alias CcbPageSlot
---| '"main.extensions"'
---| '"ingame.extensions"'
---| '"settings.mods"'
---| '"debug.tools"'
---@alias CcbTone '"normal"'|'"muted"'|'"good"'|'"warning"'|'"bad"'|'"info"'
---@alias CcbSizeToken '"compact"'|'"normal"'|'"wide"'|'"fill"'
---@alias CcbRegistryKind
---| '"bionic"'
---| '"furniture"'
---| '"item"'
---| '"monster"'
---| '"mutation"'
---| '"recipe"'
---| '"skill"'
---| '"terrain"'

---@class CcbPageDescriptor
---@field title? string
---@field category? string
---@field order? integer
---@field slots? CcbPageSlot[]

---@class CcbUiEnvironment
---@field profile string
---@field input '"touch"'|'"mouse_keyboard"'|'"terminal"'
---@field density '"touch"'|'"comfortable"'|'"compact"'
---@field breakpoint '"narrow"'|'"regular"'|'"wide"'
---@field minimum_target number
---@field touch boolean
---@field hover boolean
---@field swipe_scroll boolean
---@field native_text_input boolean
---@field keyboard_navigation boolean
---@field pointer_activation boolean
---@field tap_activation boolean
---@field long_press_dangerous boolean

---@class CcbRadialOption
---@field id string
---@field label string
---@field enabled? boolean
---@field selected? boolean

---@class CcbActionSlotOption
---@field id string
---@field label string
---@field enabled? boolean

---Ephemeral drawing facade. Valid only during the current page draw callback;
---do not retain it in globals, closures, events, services, or scheduled work.
---@class ScriptUiContext
local ScriptUiContext = {}

---@return '"imgui"'
function ScriptUiContext:backend() end

---@return '"sdl2"'|'"sdl3"'|'"imtui"'
function ScriptUiContext:platform() end

---@param capability string
---@return boolean
function ScriptUiContext:supports(capability) end

---@return boolean
function ScriptUiContext:is_immediate_mode() end

---@return boolean
function ScriptUiContext:uses_native_widgets() end

---@return CcbUiEnvironment
function ScriptUiContext:environment() end

---@param value string
function ScriptUiContext:text(value) end

---@param value string
function ScriptUiContext:heading(value) end

---@param value string
function ScriptUiContext:bullet_text(value) end

---@param value string
function ScriptUiContext:disabled_text(value) end

---@param value string
---@param red number
---@param green number
---@param blue number
---@param alpha number
function ScriptUiContext:text_colored(value, red, green, blue, alpha) end

---@param value string
---@param tone CcbTone
function ScriptUiContext:text_tone(value, tone) end

function ScriptUiContext:separator() end
function ScriptUiContext:same_line() end
function ScriptUiContext:new_line() end
function ScriptUiContext:spacing() end

---@param width number
function ScriptUiContext:set_next_item_width(width) end

---@param size CcbSizeToken
function ScriptUiContext:item_width(size) end

---@param fraction number
---@param overlay? string
function ScriptUiContext:progress_bar(fraction, overlay) end

---@param label string
---@return boolean activated
function ScriptUiContext:button(label) end

---@param id string
---@param label string
---@return boolean activated
function ScriptUiContext:button_id(id, label) end

---@param label string
---@return boolean activated
function ScriptUiContext:small_button(label) end

---@param id string
---@param label string
---@return boolean activated
function ScriptUiContext:small_button_id(id, label) end

---@param label string
---@param value boolean
---@return boolean value
function ScriptUiContext:checkbox(label, value) end

---@param id string
---@param label string
---@param value boolean
---@return boolean value
function ScriptUiContext:checkbox_id(id, label, value) end

---@param label string
---@param active boolean
---@return boolean activated
function ScriptUiContext:radio_button(label, active) end

---@param id string
---@param label string
---@param active boolean
---@return boolean activated
function ScriptUiContext:radio_button_id(id, label, active) end

---@param label string
---@param selected boolean
---@return boolean activated
function ScriptUiContext:selectable(label, selected) end

---@param id string
---@param label string
---@param selected boolean
---@return boolean activated
function ScriptUiContext:selectable_id(id, label, selected) end

---@param label string
---@param value integer
---@param minimum integer
---@param maximum integer
---@return integer value
function ScriptUiContext:slider_int(label, value, minimum, maximum) end

---@param id string
---@param label string
---@param value integer
---@param minimum integer
---@param maximum integer
---@return integer value
function ScriptUiContext:slider_int_id(id, label, value, minimum, maximum) end

---@param label string
---@param value number
---@param minimum number
---@param maximum number
---@return number value
function ScriptUiContext:slider_float(label, value, minimum, maximum) end

---@param id string
---@param label string
---@param value number
---@param minimum number
---@param maximum number
---@return number value
function ScriptUiContext:slider_float_id(id, label, value, minimum, maximum) end

---@param label string
---@param value integer
---@return integer value
function ScriptUiContext:input_int(label, value) end

---@param id string
---@param label string
---@param value integer
---@return integer value
function ScriptUiContext:input_int_id(id, label, value) end

---@param label string
---@param value number
---@return number value
function ScriptUiContext:input_float(label, value) end

---@param id string
---@param label string
---@param value number
---@return number value
function ScriptUiContext:input_float_id(id, label, value) end

---@param label string
---@param value string
---@return string value
function ScriptUiContext:input_text(label, value) end

---@param id string
---@param label string
---@param value string
---@return string value
function ScriptUiContext:input_text_id(id, label, value) end

---@param id string
---@param center_label string
---@param options CcbRadialOption[]
---@return string selected_id Empty when no new selection was made.
function ScriptUiContext:radial_select_id(id, center_label, options) end

---@param id string
---@param selected_action string
---@param context_revision integer
---@param options CcbActionSlotOption[]
---@return string selected_action
function ScriptUiContext:action_slot_id(id, selected_action, context_revision, options) end

---@param id string
---@param height number
---@param draw fun()
function ScriptUiContext:child(id, height, draw) end

---@param id string
---@param height CcbSizeToken
---@param draw fun()
function ScriptUiContext:scroll(id, height, draw) end

---@param id string
---@param columns integer
---@param draw fun()
function ScriptUiContext:table(id, columns, draw) end

---@param id string
---@param narrow_columns integer
---@param regular_columns integer
---@param wide_columns integer
---@param draw fun()
function ScriptUiContext:grid(id, narrow_columns, regular_columns, wide_columns, draw) end

function ScriptUiContext:table_next_row() end

---@return boolean visible
function ScriptUiContext:table_next_column() end

---@param id string
---@param draw fun()
function ScriptUiContext:tabs(id, draw) end

---@param id string
---@param label string
---@param draw fun()
---@return boolean active
function ScriptUiContext:tab(id, label, draw) end

---@param id string
---@param label string
---@param default_open boolean
---@param draw fun()
---@return boolean open
function ScriptUiContext:tree(id, label, default_open, draw) end

---@param id string
---@param title string
---@param open boolean
---@param draw fun()
---@return boolean open
function ScriptUiContext:modal(id, title, open, draw) end

---@param text string
function ScriptUiContext:tooltip(text) end

---@param item_count integer
---@param row_height number
---@param draw_range fun(first: integer, last_exclusive: integer)
function ScriptUiContext:virtual_list(item_count, row_height, draw_range) end

---@param item_count integer
---@param row_height CcbSizeToken
---@param draw_range fun(first: integer, last_exclusive: integer)
function ScriptUiContext:virtual_list_rows(item_count, row_height, draw_range) end

---@class CcbUiApi
---@field page fun(id: string, title: string, draw: fun(ctx: ScriptUiContext, params: CcbScalarMap))
---@field open fun(page_id: string, params?: CcbScalarMap)
---@field back fun()
---@field close fun()
local CcbUiApi = {}

---@param id string
---@param descriptor CcbPageDescriptor
---@param draw fun(ctx: ScriptUiContext, params: CcbScalarMap) ctx is valid only for this invocation
function CcbUiApi.page(id, descriptor, draw) end

---@class CcbEventOptions
---@field priority? integer
---@field once? boolean

---@class CcbEvent
---@field type string
---@field turn integer
---@field data CcbScalarMap
---@field data_types table<string, string>

---@alias CcbEventCallback fun(event: CcbEvent): boolean?

---@class CcbEventsApi
local CcbEventsApi = {}

---@param name string Game event id, lifecycle event id, or source-local custom event id.
---@param callback CcbEventCallback
---@return integer subscription_id
---@overload fun(name: string, options: CcbEventOptions, callback: CcbEventCallback): integer
function CcbEventsApi.on(name, callback) end

---@param provider_id string
---@param name string
---@param callback CcbEventCallback
---@return integer subscription_id
---@overload fun(provider_id: string, name: string, options: CcbEventOptions, callback: CcbEventCallback): integer
function CcbEventsApi.on_from(provider_id, name, callback) end

---@param subscription_id integer
---@return boolean removed
function CcbEventsApi.off(subscription_id) end

---@param name string
---@param data? CcbScalarMap
---@return boolean continued
function CcbEventsApi.emit(name, data) end

---@class CcbSchedulerApi
local CcbSchedulerApi = {}

---@param delay_turns integer
---@param callback fun(task_id: integer, now_turn: integer, due_turn: integer): boolean?
---@return integer task_id
function CcbSchedulerApi.after(delay_turns, callback) end

---@param interval_turns integer
---@param callback fun(task_id: integer, now_turn: integer, due_turn: integer): boolean?
---@return integer task_id
function CcbSchedulerApi.every(interval_turns, callback) end

---@param task_id integer
---@return boolean canceled
function CcbSchedulerApi.cancel(task_id) end

---@return integer turn
function CcbSchedulerApi.now() end

---@class CcbServiceDescriptor
---@field version? integer
---@field methods table<string, fun(arguments: CcbScalarMap): CcbScalarMap?>

---@class CcbServiceInfo
---@field provider string
---@field name string
---@field version integer
---@field methods string[]

---@class CcbServicesApi
local CcbServicesApi = {}

---@param name string
---@param descriptor CcbServiceDescriptor
function CcbServicesApi.provide(name, descriptor) end

---@param provider_id string
---@param service_name string
---@param method_name string
---@param arguments? CcbScalarMap
---@return CcbScalarMap
function CcbServicesApi.call(provider_id, service_name, method_name, arguments) end

---@param provider_id string
---@param service_name string
---@param minimum_version? integer
---@return boolean
function CcbServicesApi.available(provider_id, service_name, minimum_version) end

---@return CcbServiceInfo[]
function CcbServicesApi.list() end

---@class CcbModulesApi
local CcbModulesApi = {}

---@param provider_id string
---@param module_name string
---@return any exports
function CcbModulesApi.import(provider_id, module_name) end

---@return string source_id
function CcbModulesApi.source_id() end

---@class CcbRegistryListOptions
---@field offset? integer
---@field limit? integer
---@field query? string
---@field details? boolean

---@class CcbRegistryEntry
---@field id string
---@field name string

---@class CcbRegistryDefinition: CcbRegistryEntry
---@field kind CcbRegistryKind
---@field description? string

---@class CcbRegistryPage
---@field kind CcbRegistryKind
---@field revision integer
---@field offset integer
---@field limit integer
---@field total integer
---@field returned integer
---@field has_more boolean
---@field entries (CcbRegistryEntry|CcbRegistryDefinition)[]

---@class CcbRegistryApi
local CcbRegistryApi = {}

---@return CcbRegistryKind[]
function CcbRegistryApi.kinds() end

---@param kind CcbRegistryKind
---@param id string
---@return CcbRegistryDefinition?
function CcbRegistryApi.get(kind, id) end

---@param kind CcbRegistryKind
---@param options? CcbRegistryListOptions
---@return CcbRegistryPage
function CcbRegistryApi.list(kind, options) end

---@return integer
function CcbRegistryApi.revision() end

---@class CcbI18nApi
local CcbI18nApi = {}

---@param message string
---@return string
function CcbI18nApi.gettext(message) end

---@param context string
---@param message string
---@return string
function CcbI18nApi.pgettext(context, message) end

---@param singular string
---@param plural string
---@param count integer
---@return string
function CcbI18nApi.ngettext(singular, plural, count) end

---@param context string
---@param singular string
---@param plural string
---@param count integer
---@return string
function CcbI18nApi.npgettext(context, singular, plural, count) end

---@return integer
function CcbI18nApi.language_revision() end

---@class CcbStateStore
local CcbStateStore = {}

---@generic T: CcbScalar
---@param key string
---@param default T
---@return T
function CcbStateStore.get(key, default) end

---@param key string
---@param value CcbScalar|nil
function CcbStateStore.set(key, value) end

---@class CcbStateApi
---@field character CcbStateStore
---@field world CcbStateStore
---@field page CcbStateStore

---@class CcbPlayerSnapshot
---@field name string
---@field moves integer
---@field stamina integer
---@field stamina_max integer
---@field pain integer
---@field focus integer
---@field speed integer
---@field hunger integer
---@field thirst integer
---@field sleepiness integer
---@field morale integer
---@field stored_kcal integer
---@field healthy_kcal integer
---@field kcal_percent number
---@field radiation integer
---@field bionic_power_kj number
---@field bionic_power_max_kj number
---@field movement_mode_id string
---@field movement_mode_name string
---@field desired_movement_mode_id string
---@field desired_movement_mode_name string
---@field movement_mode_pending boolean
---@field x integer
---@field y integer
---@field z integer

---@class CcbMovementMode
---@field id string
---@field name string
---@field available boolean
---@field current boolean
---@field desired boolean
---@field switch_moves integer
---@field switch_seconds number

---@class CcbMovementModesSnapshot
---@field items CcbMovementMode[]
---@field count integer
---@field current_id string
---@field desired_id string

---@class CcbTimeSnapshot
---@field turn integer
---@field year integer
---@field season_id string
---@field season_name string
---@field day integer
---@field hour integer
---@field minute integer
---@field display string

---@class CcbWeatherSnapshot
---@field id string
---@field name string
---@field temperature_c number
---@field temperature_display string
---@field dangerous boolean
---@field raining boolean
---@field sight_penalty number
---@field wind_speed number
---@field wind_direction string

---@class CcbItemSnapshot
---@field uid integer
---@field id string
---@field name string
---@field category_id string
---@field category_name string
---@field charges integer
---@field count_by_charges boolean
---@field weight_grams number
---@field volume_ml number
---@field contents_count integer
---@field worn boolean
---@field wielded boolean

---@class CcbBoundedItemList
---@field items CcbItemSnapshot[]
---@field total integer
---@field returned integer
---@field limit integer
---@field truncated boolean

---@class CcbEffectSnapshot
---@field id string
---@field name string
---@field description string
---@field body_part_id string
---@field duration_turns integer
---@field intensity integer
---@field permanent boolean

---@class CcbSkillSnapshot
---@field id string
---@field name string
---@field description string
---@field level integer
---@field exercise_percent integer
---@field knowledge_level integer
---@field knowledge_percent integer
---@field rusty boolean
---@field training boolean
---@field combat boolean

---@class CcbMutationSnapshot
---@field id string
---@field name string
---@field description string
---@field active boolean
---@field activatable boolean
---@field base_trait boolean
---@field purifiable boolean
---@field threshold boolean
---@field points integer

---@class CcbBionicSnapshot
---@field uid integer
---@field id string
---@field name string
---@field description string
---@field powered boolean
---@field activatable boolean
---@field included boolean
---@field incapacitated_turns integer
---@field charge_timer_turns integer
---@field activation_cost_kj number
---@field deactivation_cost_kj number

---@class CcbMissionSnapshot
---@field uid integer
---@field id string
---@field name string
---@field description string
---@field status '"active"'|'"completed"'|'"failed"'
---@field selected boolean
---@field has_deadline boolean
---@field deadline_turn integer
---@field has_target boolean
---@field target_x? integer
---@field target_y? integer
---@field target_z? integer

---@class CcbActivityEntry
---@field id string
---@field active boolean
---@field verb string
---@field moves_total integer
---@field moves_left integer
---@field interruptible boolean
---@field interruptible_with_keyboard boolean
---@field auto_resume boolean
---@field progress_message string
---@field progress number

---@class CcbCreatureSnapshot
---@field name string
---@field kind '"monster"'|'"npc"'|'"creature"'
---@field attitude string
---@field distance integer
---@field x integer
---@field y integer
---@field z integer
---@field hp integer
---@field hp_max integer

---@class CcbActionDescriptor
---@field id string
---@field label string
---@field group string
---@field repeatable boolean
---@field dangerous boolean

---@class CcbInputContextSnapshot
---@field category string
---@field hud_scene_id string
---@field hud_scene_title string
---@field revision integer
---@field actions CcbActionDescriptor[]
---@field available table<string, boolean>

---@class CcbQueuedAction
---@field id integer
---@field type string
---@field status '"queued"'
---@field queued_turn integer
---@field action? string
---@field context_revision? integer
---@field dangerous? boolean
---@field source? string

---@class CcbActionResult
---@field id integer
---@field type string
---@field status '"succeeded"'|'"failed"'|'"canceled"'|'"denied"'
---@field error string
---@field queued_turn integer
---@field completed_turn integer
---@field action_taken boolean

---@class CcbActionsStatus
---@field pending_count integer
---@field result_count integer
---@field result_limit integer
---@field pending CcbQueuedAction[]
---@field results CcbActionResult[]

---@class CcbGameActionsApi
local CcbGameActionsApi = {}

---@param action_type string
---@param options? table
---@return integer request_id
function CcbGameActionsApi.enqueue(action_type, options) end

---@param action_id string
---@param context_revision integer
---@return integer request_id
function CcbGameActionsApi.enqueue_context(action_id, context_revision) end

---@param request_id integer
---@return boolean canceled
function CcbGameActionsApi.cancel(request_id) end

---@param result_limit? integer
---@return CcbActionsStatus
function CcbGameActionsApi.status(result_limit) end

---@return CcbInputContextSnapshot
function CcbGameActionsApi.context_snapshot() end

---@class CcbRuntimeStatus
---@field loaded boolean
---@field generation integer
---@field pages integer
---@field event_handlers integer
---@field sources integer
---@field memory_used integer
---@field memory_limit integer
---@field callback_count integer
---@field callback_time_total_us integer
---@field callback_time_max_us integer
---@field slow_callback_count integer
---@field last_slow_callback string
---@field last_error string

---@alias CcbGameHandleKind '"creature"'|'"item"'|'"vehicle"'

---@class CcbGameHandlePosition
---@field x integer
---@field y integer
---@field z integer

---@class CcbGameHandleLocator
---@field scope string
---@field stable_id integer
---@field position CcbGameHandlePosition
---@field path integer[]

---@class CcbGameHandleError
---@field code string
---@field message string

---@class CcbGameHandleStatus
---@field ok boolean
---@field value? { kind: CcbGameHandleKind, locator: CcbGameHandleLocator }
---@field error? CcbGameHandleError

---Opaque generation-checked reference to a live game object. Handles never
---expose native pointers and become invalid after runtime/world replacement.
---@class GameHandle
---@field kind CcbGameHandleKind
local GameHandle = {}

---@return CcbGameHandleLocator
function GameHandle:locator() end

---@return boolean
function GameHandle:is_valid() end

---@return CcbGameHandleStatus
function GameHandle:status() end

---@class CcbGameHandlesApi
local CcbGameHandlesApi = {}

---@return GameHandle
function CcbGameHandlesApi.avatar() end

---@alias CcbLuaBindingStatus '"planned"'|'"partial"'|'"covered"'|'"not_applicable"'

---@class CcbLuaBindingDomain
---@field id string
---@field namespace string
---@field capability string
---@field minimum_api_version integer
---@field status CcbLuaBindingStatus

---@class CcbGameApi
---@field api_version 5
---@field actions CcbGameActionsApi
---@field handles CcbGameHandlesApi
local CcbGameApi = {}

---@return CcbLuaBindingDomain[]
function CcbGameApi.api_catalog() end

---@param domain string
---@return boolean
function CcbGameApi.api_supports(domain) end

---@param message string
function CcbGameApi.add_msg(message) end

---@return string
function CcbGameApi.player_name() end

---@return CcbPlayerSnapshot
function CcbGameApi.player_snapshot() end

---@return CcbPlayerSnapshot
function CcbGameApi.player_stats() end

---@return CcbMovementModesSnapshot
function CcbGameApi.movement_modes_snapshot() end

---@return CcbTimeSnapshot
function CcbGameApi.time_snapshot() end

---@return CcbWeatherSnapshot
function CcbGameApi.weather_snapshot() end

---@param limit? integer
---@return CcbBoundedItemList
function CcbGameApi.inventory_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.effects_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.skills_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.equipment_snapshot(limit) end

---@param uid integer
---@param limit? integer
---@return table
function CcbGameApi.item_contents_snapshot(uid, limit) end

---@param field_limit? integer
---@return table
function CcbGameApi.current_tile_snapshot(field_limit) end

---@param limit? integer
---@return table
function CcbGameApi.mutations_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.bionics_snapshot(limit) end

---@param limit? integer
---@return table
function CcbGameApi.missions_snapshot(limit) end

---@param backlog_limit? integer
---@return table
function CcbGameApi.activity_snapshot(backlog_limit) end

---@param radius? integer
---@param limit? integer
---@return table
function CcbGameApi.nearby_creatures_snapshot(radius, limit) end

---@return CcbRuntimeStatus
function CcbGameApi.runtime_status() end

---@generic T: CcbScalar
---@param key string
---@param default T
---@return T
function CcbGameApi.state_get(key, default) end

---@param key string
---@param value CcbScalar|nil
function CcbGameApi.state_set(key, value) end

---@type CcbUiApi
ui = {}

---@type CcbEventsApi
events = {}

---@type CcbSchedulerApi
scheduler = {}

---@type CcbServicesApi
services = {}

---@type CcbModulesApi
modules = {}

---@type CcbRegistryApi
registry = {}

---@type CcbI18nApi
i18n = {}

---@type CcbStateApi
state = {}

---@type CcbGameApi
game = {}

---@type string
ccb_source_id = ""
