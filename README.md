# Capacitor Secure Key Storage Plugin

Reusable Capacitor plugin for secure key/value storage using:

- Android Keystore-backed `EncryptedSharedPreferences`
- iOS Keychain

This package is useful when multiple Capacitor apps need the same secure-storage native implementation instead of copying plugin code into each repo.

## What It Supports

- Android secure storage via `EncryptedSharedPreferences`
- iOS secure storage via Keychain
- Simple key/value API:
  - `set`
  - `get`
  - `remove`

## Current Platform Scope

- Android: implemented
- iOS: implemented

## Install

```bash
npm install @khadarvsk/capacitor-secure-storage
npx cap sync
```

## Usage

```ts
import SecureKeyStorage from "@khadarvsk/capacitor-secure-storage";

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
import SecureKeyStorage from "@khadarvsk/capacitor-secure-storage";

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

- This package stores data securely on Android and iOS native platforms.
- If an app also supports web, it should provide its own fallback outside this package.
- On iOS, values are stored in the Keychain as generic-password items keyed by the provided `key`.
