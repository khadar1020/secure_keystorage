import { registerPlugin } from "@capacitor/core";

import type { SecureKeyStoragePlugin } from "./definitions";

const SecureKeyStorage = registerPlugin<SecureKeyStoragePlugin>(
  "SecureKeyStorage",
  {
    web: () => import("./web").then((module) => new module.SecureKeyStorageWeb()),
  },
);

export * from "./definitions";
export { SecureKeyStorage };
export default SecureKeyStorage;
