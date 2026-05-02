import Foundation
import Capacitor

@objc(SecureKeyStoragePlugin)
public class SecureKeyStoragePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "SecureKeyStoragePlugin"
    public let jsName = "SecureKeyStorage"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "set", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "get", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "remove", returnType: CAPPluginReturnPromise)
    ]

    private let keychain = KeychainStorage()

    @objc func set(_ call: CAPPluginCall) {
        guard let key = call.getString("key"), !key.isEmpty else {
            call.reject("Key is required")
            return
        }

        guard let value = call.getString("value") else {
            call.reject("Value is required")
            return
        }

        do {
            try keychain.set(value, for: key)
            call.resolve()
        } catch {
            call.reject("Failed to securely store value", nil, error)
        }
    }

    @objc func get(_ call: CAPPluginCall) {
        guard let key = call.getString("key"), !key.isEmpty else {
            call.reject("Key is required")
            return
        }

        do {
            let value = try keychain.get(key)
            call.resolve([
                "value": value as Any
            ])
        } catch {
            call.reject("Failed to securely load value", nil, error)
        }
    }

    @objc func remove(_ call: CAPPluginCall) {
        guard let key = call.getString("key"), !key.isEmpty else {
            call.reject("Key is required")
            return
        }

        do {
            try keychain.remove(key)
            call.resolve()
        } catch {
            call.reject("Failed to securely remove value", nil, error)
        }
    }
}
