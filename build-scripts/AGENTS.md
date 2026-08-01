# `build-scripts/` agent instructions

- Build and packaging scripts are authoritative for the platforms they target.
- Preserve reproducibility, quoted paths, exit status, and artifact naming.
- Keep secrets and signing operations outside tracked scripts.
- Validate syntax and run the narrowest supported packaging dry run.

构建脚本属于构建契约；不要用文档中的旧命令覆盖实际脚本行为。
