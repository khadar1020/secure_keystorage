import { WebPlugin } from "@capacitor/core";

import type {
  SecureKeyStorageGetOptions,
  SecureKeyStorageGetResult,
  SecureKeyStoragePlugin,
  SecureKeyStorageRemoveOptions,
  SecureKeyStorageSetOptions,
} from "./definitions";

export class SecureKeyStorageWeb
  extends WebPlugin
  implements SecureKeyStoragePlugin
{
  async set(_options: SecureKeyStorageSetOptions): Promise<void> {
    throw this.unimplemented(
      "SecureKeyStorage is only implemented for Android in this package.",
    );
  }

  async get(_options: SecureKeyStorageGetOptions): Promise<SecureKeyStorageGetResult> {
    throw this.unimplemented(
      "SecureKeyStorage is only implemented for Android in this package.",
    );
  }

  async remove(_options: SecureKeyStorageRemoveOptions): Promise<void> {
    throw this.unimplemented(
      "SecureKeyStorage is only implemented for Android in this package.",
    );
  }
}
