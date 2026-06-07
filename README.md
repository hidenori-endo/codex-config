# Codex Config

Personal Codex configuration for a fully automated local workflow.

## Install

Run from this repository:

```powershell
.\install.ps1
```

The installer backs up the existing `~/.codex/config.toml` before replacing it.
It also removes `~/.codex/rules/default.rules`, backing it up first unless `-NoBackup` is used.

To skip the backup:

```powershell
.\install.ps1 -NoBackup
```

## Notes

This configuration disables approval prompts and filesystem sandboxing:

```toml
approval_policy = "never"
sandbox_mode = "danger-full-access"
```

Use it only on machines where you trust the working environment.
