# Monokai Maizy Edition for Orca

An app theme combining the UI palette from [Monokai for Orca](https://github.com/ehart004/orca-monokai-theme/blob/main/themes/monokai.json) with code colors and font styles from the `Monokai-maizy-edition` IntelliJ IDEA scheme in the supplied settings export.

## Install

1. From this plugin directory, install the plugin using Orca's CLI:

   ```sh
   orca plugin install . --json
   ```

   You can also pass the absolute path to the plugin folder from any directory.

2. Open Orca Settings → Appearance and select **Monokai Maizy Edition** as the app theme.

Requires Orca 1.4.246 or newer. The plugin contributes one app theme and needs no executable code or permissions.

## Colors

The original Orca Monokai UI tokens are preserved. Editor text/background remain `#f8f8f2` / `#272822`, matching the IDEA scheme. Shared syntax rules apply Maizy colors to variables, constants, fields, parameters, block comments, escapes and attributes across languages. The theme contains no language-specific overrides.

IDEA uses semantic attributes while Orca uses TextMate scopes. This is a best-effort mapping: a distinction appears only when the active language grammar exposes a matching scope. IDEA-only effects, diagnostics, code backgrounds and semantic distinctions without a matching scope cannot be reproduced exactly. Unspecified attributes retain the base Monokai rules. Terminal colors and fonts are configured separately in Orca.

The theme is self-contained. Installing or editing it requires only this plugin folder; the original theme repository and IntelliJ settings export are not dependencies.

## Attribution

Orca UI and fallback syntax rules: Monokai for Orca by ehart004, MIT; source checkout commit `cb34f750f3c62a243d02a350ac497b704e5c7235`. Keep the upstream [LICENSE](LICENSE) with redistributed copies.
