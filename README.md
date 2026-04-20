# Capacitor Secure Key Storage Plugin

Reusable Capacitor plugin for Android secure key/value storage using Android Keystore-backed `EncryptedSharedPreferences`.

This package is useful when multiple Capacitor apps need the same secure-storage native implementation instead of copying plugin code into each repo.

## What It Supports

- Android secure storage via `EncryptedSharedPreferences`
- Simple key/value API:
  - `set`
  - `get`
  - `remove`

## Current Platform Scope

- Android: implemented
- iOS: not implemented in this package yet

## Install

```bash
npm install @khadar1020/capacitor-secure-storage
npx cap sync
```

## Usage

```ts
import SecureKeyStorage from "@khadar1020/capacitor-secure-storage";

await SecureKeyStorage.set({
  key: "nostr_nsec",
  value: "nsec1example",
});

const { value } = await SecureKeyStorage.get({
  key: "nostr_nsec",
});

await SecureKeyStorage.remove({
  key: "nostr_nsec",
});
```

## Example Wrapper

In an app, it is usually nicer to wrap the raw plugin methods:

```ts
import SecureKeyStorage from "@khadar1020/capacitor-secure-storage";

const NSEC_KEY = "nostr_nsec";

export async function saveNsec(nsec: string) {
  await SecureKeyStorage.set({ key: NSEC_KEY, value: nsec });
}

export async function getNsec() {
  const { value } = await SecureKeyStorage.get({ key: NSEC_KEY });
  return value;
}

export async function removeNsec() {
  await SecureKeyStorage.remove({ key: NSEC_KEY });
}
```

## Notes

- This package stores data securely only on Android.
- If an app also supports web, it should provide its own fallback outside this package.
- For full cross-platform secure storage, the next step would be adding iOS Keychain support.
