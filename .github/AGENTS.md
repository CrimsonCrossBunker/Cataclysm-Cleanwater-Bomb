# `.github/` agent instructions

- Workflows are authoritative build and validation contracts.
- Pin third-party actions to full commit SHAs and grant minimum permissions.
- Treat PR titles, bodies, labels, and fork input as untrusted data.
- Keep documentation-impact checks advisory during Phase 0/1.
- Repository settings described by `ai/repository-settings.target.yml` are a
  target and manual checklist, not proof that settings are active.

CI 修改应使用最小权限并固定第三方 Action；不得把目标配置描述成已经生效。
