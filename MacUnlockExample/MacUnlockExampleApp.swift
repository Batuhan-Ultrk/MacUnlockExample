//
//  MacUnlockExampleApp.swift
//  MacUnlockExample
//
//  Created by Batuhan Ulutürk on 4.12.2024.
//

import SwiftUI
import Cocoa
import Quartz

@main
struct MacUnlockExampleApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        print("Application started. Checking screen lock...")

        // Sürekli ekran kilit durumunu kontrol eden zamanlayıcı
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(checkAndUnlockScreen), userInfo: nil, repeats: true)
    }

    @objc func checkAndUnlockScreen() {
        if isScreenLocked() {
            print("Screen is locked. Initiating unlock process...")
            unlockScreen()
        } else {
            print("The screen is already on.")
        }
    }

    func unlockScreen() {
        let password = "EnterYourMacPasswordHere" // Mac şifrenizi buraya yazın
        fakeKeyStrokes(password)
    }

    func fakeKeyStrokes(_ string: String) {
        let src = CGEventSource(stateID: .hidSystemState)
        let unicodeString = Array(string.utf16)
        unicodeString.withUnsafeBufferPointer { buffer in
            let event = CGEvent(keyboardEventSource: src, virtualKey: 0, keyDown: true)
            event?.keyboardSetUnicodeString(stringLength: buffer.count, unicodeString: buffer.baseAddress)
            event?.post(tap: .cghidEventTap)
            CGEvent(keyboardEventSource: src, virtualKey: 0, keyDown: false)?.post(tap: .cghidEventTap)
        }
        // Enter tuşu
        CGEvent(keyboardEventSource: src, virtualKey: 36, keyDown: true)?.post(tap: .cghidEventTap)
        CGEvent(keyboardEventSource: src, virtualKey: 36, keyDown: false)?.post(tap: .cghidEventTap)
    }

    func isScreenLocked() -> Bool {
        if let sessionInfo = CGSessionCopyCurrentDictionary() as? [String: Any],
           let isLocked = sessionInfo["CGSSessionScreenIsLocked"] as? Bool {
            return isLocked
        }
        return false
    }
}
