# 被剔除的上游 PR 记录 / Excluded Upstream PRs

本文件记录从 CleverRaven 上游**有意不同步**或**同步后回退**的 PR，避免每次同步时重复评估、误判为"遗漏"。

## 状态图例

- `未同步` —— 从未挑入 fork
- `已回退` —— 曾同步，后用 revert 提交撤销
- `在库待回退` —— 仍在 fork、属回退政策目标但尚未处理
- `部分回退` —— 仅撤销了部分影响

---

## 设计取向不符（确认剔除）

这些 PR 与 fork 的设计取向（物品 charges/数量模型、若干玩法平衡）不一致，故剔除或回退。

| PR | 合并日 | 标题 | 状态 |
|---|---|---|---|
| #87620 | 2026-06-14 | Remove hardcoded water boiling | 未同步 |
| #87432 | 2026-06-06 | Add some random fungus to the groundcover pool | 已回退 (9acf97c) |
| #87411 | 2026-06-04 | Gold is worthless | 未同步 |
| #87332 | 2026-05-31 | De-charge graphite, nuts and bolts | 在库待回退 |
| #87323 | 2026-06-01 | De-charge ... charges (5) | 在库待回退 |
| #87180 | 2026-05-24 | De-charge ... charges (4) | 在库待回退 |
| #87008 | 2026-05-16 | De-charge ... charges (3) | 在库待回退 |
| #87006 | 2026-05-15 | De-charge ... charges (2) | 在库待回退 |
| #87000 | 2026-05-14 | De-charge ... charges (1) | 部分回退（仅 itemgroups spawn 点）|
| #87177 | 2026-05-26 | Recipes for charged items must specify charges | 在库待回退（de-charge 关联）|
| #87668 | 2026-06-18 | fix detergent use in washing | 未同步（detergent de-charge 连带修复，见下）|
| #87891 | 2026-07-04 | CleverRaven/detergent (detergent itemgroup group spawn) | 未同步（detergent de-charge 关联） |
| #87897 | 2026-07-05 | put bleach in bottles properly | 部分同步（仅 display/container，未取 group spawn 改） |

de-charge 系列此前的回退工作多数已作废（分支回到 master），故标"在库待回退"。

**#87668 剔除说明**：上游某 de-charge 改动（#87668 描述称引入自 "#87543"，但该 PR 号在上游 git 历史/GitHub 均查无对应合并，号可能有误）把 detergent 改为 count 物品；#87668 是修该回归——把 C++ 洗涤逻辑从 `charges_of/has_charges` 改成 `amount_of/has_amount`。但 fork 未同步那个 detergent de-charge，detergent 仍是 `stackable:true`（`count_by_charges()=true`，配方产 charges:6、itemgroup spawn charges:[2,129]，实测于 fork master）。套用 #87668 会把"多 charges 的一份洗衣粉"按 1 个实例计（`amount_of` 每实例计 1，不看 charges），导致洗涤 cleanser 需求误判不足→搞坏 fork 洗涤。fork 现有 `charges_of` 代码对 charges-detergent 本就正确，无需改动。注：vehicle_use.cpp:1455 那处 `count_by_charges()?has_charges:has_amount` 三元两模型都兼容，但其余 5 处无条件改 amount 对 fork 有害，故整体剔除。结论基于代码实测，不依赖 "#87543" 是否存在。

### 已入库、保留不回退

以下 PR 同源于上述取向，但已同步进 fork，**保留、不回退**：

| PR | 合并日 | 标题 |
|---|---|---|
| #87329 | 2026-06-04 | Blacklist a whole bunch of recipes in Aftershock |
| #87046 | 2026-06-01 | Crafting faults |

---

## 其它有意过滤

| PR | 合并日 | 标题 | 理由 |
|---|---|---|---|
| #87351 | 2026-06-02 | CMake+vcpkg to select SDL3 or SDL2 | fork 锁定 SDL3，不需要 SDL2 切换路径 |
| #87717 | 2026-06-20 | fix: Crash in any ImGui window on alt + F4 | 上游随即被 #87720 revert，两者净零；同步无意义 |
| #87720 | 2026-06-20 | Revert "fix: Crash in any ImGui window on alt + F4" | 撤销 #87717；与 #87717 成对跳过 |

---

## 同步记录 / Sync Log

### sync-cdda-20260701 (2026-07-01)

同步范围：从上次 sync-cdda-87733（2026-06-25）到 upstream/master HEAD（2026-06-30），共 44 commits / 25 PRs。

**冲突处理**：

| PR | 文件 | 处理方式 |
|---|---|---|
| #87719 (ash重量体积调整) | `chemicals_and_resources.json` | 保留 fork 的 stackable/BY_WEIGHT 模型，不采用上游的 count 模型重量/体积值 |
| #87832 (酒精显示统一) | `carnivore.json` | 采用上游的描述文本和 display_type 改进 |

**同步的 PR 编号**：#87570, #87682, #87719, #87726, #87735, #87752, #87761, #87770, #87779, #87794, #87795, #87796, #87797, #87799, #87800, #87805, #87806, #87808, #87809, #87810, #87811, #87814, #87815, #87823, #87825, #87827, #87829, #87831, #87832, #87834, #87836, #87838, #87841, #87842

本次无新增排除项。


### sync-cdda-20260705 (2026-07-05)

同步范围：从上次 sync-cdda-20260701（#87842）到 upstream/master HEAD（2026-07-05），共 46 commits / 26 PRs。

**冲突处理**：

| PR | 文件 | 处理方式 |
|---|---|---|
| #87891 (detergent group spawn) | `collections_domestic.json` 等 4 文件 | 保留 fork 的 stackable/charges 模型，不取上游的 group 式 spawn |
| #87897 (bleach 装瓶) | `SUS/domestic.json`, `collections_domestic.json`, `mil_base_z-1.json` 等 | 保留 fork 的 charges 计法；仅取 display/container 改进 |

**同步的 PR 编号**：#87678, #87746, #87802, #87819, #87826, #87836, #87837, #87838, #87843, #87844, #87845, #87848, #87852, #87853, #87854, #87855, #87856, #87857, #87858, #87859, #87863, #87873, #87875, #87881, #87897, #87900

**本次新增排除项**：#87891（detergent group spawn，与 fork stackable 模型冲突）
