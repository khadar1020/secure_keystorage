import Foundation
import Security

enum KeychainStorageError: LocalizedError {
    case unexpectedData
    case unhandled(OSStatus)

    var errorDescription: String? {
        switch self {
        case .unexpectedData:
            return "Unexpected data returned from Keychain"
        case .unhandled(let status):
            if let message = SecCopyErrorMessageString(status, nil) as String? {
                return message
            }
            return "Keychain error: \(status)"
        }
    }
}

final class KeychainStorage {
    private let service = "app.formstr.plugins.securekeystorage"

    private func query(for key: String) -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
    }

    func set(_ value: String, for key: String) throws {
        let data = Data(value.utf8)
        var item = query(for: key)
        item[kSecValueData as String] = data
        item[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly

        let status = SecItemAdd(item as CFDictionary, nil)
        if status == errSecDuplicateItem {
            let attributesToUpdate = [kSecValueData as String: data]
            let updateStatus = SecItemUpdate(
                query(for: key) as CFDictionary,
                attributesToUpdate as CFDictionary
            )
            guard updateStatus == errSecSuccess else {
                throw KeychainStorageError.unhandled(updateStatus)
            }
            return
        }

        guard status == errSecSuccess else {
            throw KeychainStorageError.unhandled(status)
        }
    }

    func get(_ key: String) throws -> String? {
        var item = query(for: key)
        item[kSecReturnData as String] = true
        item[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: CFTypeRef?
        let status = SecItemCopyMatching(item as CFDictionary, &result)

        switch status {
        case errSecSuccess:
            guard let data = result as? Data,
                  let value = String(data: data, encoding: .utf8) else {
                throw KeychainStorageError.unexpectedData
            }
            return value
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainStorageError.unhandled(status)
        }
    }

    func remove(_ key: String) throws {
        let status = SecItemDelete(query(for: key) as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainStorageError.unhandled(status)
        }
    }
}
