# Bubblewrap Init — Interactive Prompt Cheatsheet

When you run:

```bash
bubblewrap init --manifest https://shuteng8787-sudo.github.io/habitstreak/manifest.json
```

It will ask many questions. Most can be Enter-to-accept. Below is what to type for the ones that matter.

---

## Critical prompts (DON'T just press Enter)

| Prompt | What to type | Why |
|---|---|---|
| Application package name | `io.github.shuteng8787sudo.habitstreak` | Android package names cannot contain hyphens. Once chosen, you can NEVER change this for an installed app |
| Display mode | `standalone` | TWA standard |
| Orientation | `default` | Let user phone decide |
| Min SDK Version | `21` | Default; supports Android 5.0+ (>99% of devices) |
| Target SDK Version | latest available (33 or 34) | Required by Play |
| **Key store password** | type a 16-24 char password, **WRITE IT DOWN** | If lost, you can NEVER update this app again |
| **Key password** | same or different, **WRITE IT DOWN** | If lost, you can NEVER update this app again |

---

## Auto-accept prompts (just press Enter)

- Web app URL: pre-filled from manifest URL
- Application name: pre-filled from manifest `name`
- Short name: pre-filled from manifest `short_name`
- Theme color: pre-filled `#059669`
- Background color: pre-filled
- Icon URL: pre-filled
- Maskable icon URL: optional, can skip
- Splash screen color: pre-filled
- Splash screen image URL: optional, can skip
- Status bar color: pre-filled
- Navigation bar color: pre-filled
- Notification channel name: pre-filled

---

## After `init` finishes, you'll have:

```
twa-manifest.json          ← config
android.keystore           ← signing key — BACK UP IMMEDIATELY (3 places)
app/                       ← Android Studio project
```

---

## Get the SHA-256 fingerprint (needed for assetlinks.json)

```bash
keytool -list -v -keystore android.keystore -alias android -storepass <YOUR_KEYSTORE_PASSWORD>
```

Look for the line `SHA256:` — copy that value (looks like `AB:CD:EF:...`).

Replace the placeholder in `shuteng8787-sudo.github.io/.well-known/assetlinks.json`.

---

## Build the AAB

```bash
bubblewrap build
```

Asks for keystore password and key password. Output: `app-release-bundle.aab` (this is what you upload to Play Console).

---

## Critical reminder: KEYSTORE BACKUP

After `init` succeeds, **immediately** copy `android.keystore` to:

1. A different physical location (USB drive)
2. A cloud backup (encrypted, e.g., 1Password vault attachment)
3. Print the password on paper, store in a safe place

If both your laptop and one backup are gone simultaneously, all 21 future apps under this keystore become un-updatable forever. Treat the keystore as more important than the app code.
