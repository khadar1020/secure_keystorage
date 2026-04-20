export interface SecureKeyStorageSetOptions {
  key: string;
  value: string;
}

export interface SecureKeyStorageGetOptions {
  key: string;
}

export interface SecureKeyStorageRemoveOptions {
  key: string;
}

export interface SecureKeyStorageGetResult {
  value: string | null;
}

export interface SecureKeyStoragePlugin {
  set(options: SecureKeyStorageSetOptions): Promise<void>;
  get(options: SecureKeyStorageGetOptions): Promise<SecureKeyStorageGetResult>;
  remove(options: SecureKeyStorageRemoveOptions): Promise<void>;
}
