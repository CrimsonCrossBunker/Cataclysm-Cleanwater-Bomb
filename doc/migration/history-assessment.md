# Documentation history assessment

## Scope

This Phase 0 assessment uses the frozen migration inventory at commit
`0378ca2b84303cf614c617c9d9eaa50138cd21ff`.  It examines Git objects for the
175 inventoried Markdown paths only.  It does not walk working-tree caches,
rewrite this repository, or import history into CCB-Docs.

本评估只分析迁移清单中的 175 个 Markdown 路径，不遍历工作区缓存、不改写主
仓库，也不在 Phase 0/1 向 CCB-Docs 导入历史。

## Measured history

| Measure | Result |
| --- | ---: |
| Inventoried paths | 175 |
| Commits touching those paths | 225 |
| Historical blobs reachable through those paths | 399 |
| Unpacked historical Markdown blob bytes | 19,836,858 |

The figures come from path-limited `git log`, `git rev-list --objects`, and
`git cat-file`.  Root dot-prefixed tool/config paths are outside the migration
scope.  `obj-lua/` is untracked and was neither traversed nor included.

## Tooling result and recommendation

`git filter-repo` is not installed in the current environment, so no filtered
repository was created.  The path-limited history is small enough to justify a
temporary filtered-history trial before Phase 2, but it must use only the
documents selected for migration—not the entire CCB repository history.

Before any history is pushed:

1. install or obtain a pinned `git-filter-repo` in a temporary environment;
2. filter only the final selected source paths and preserve renames/authors;
3. inspect the resulting commit graph and packed repository size;
4. reject unrelated source/build objects;
5. use a clean content import plus recorded source commit, contributors, and
   license for paths whose history cannot be preserved cleanly.

No history-import decision or mutation is authorized in Phase 0/1.
