//
//  ContentView.swift
//  Shared
//
//  Created by Jaroslav Pulik on 01/04/2021.
//

import SwiftUI
import OSLog

#if os(macOS)
import Localazy_macOS
#else
import Localazy_iOS
#endif

final class ContentViewModel: ObservableObject {
    
    @Published var didLoadLocalizedStrings: Bool = false
    
    init() {
        NotificationCenter.default.publisher(for: .localazyStringsLoaded)
            .map { _ in true }
            .assign(to: &$didLoadLocalizedStrings)
    }
    
}

struct ContentView: View {
    
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            
            // Use .localazyLocalized String extension to get translation
            Text("Hello".localazyLocalized)
                .padding()
            
            // Use system NSLocalizedString method to get translation from Localazy
            // only work when Bundle.swizzleLocalizationWithLocalazy() was called before
            Text(NSLocalizedString("Hello", comment: "Hello"))
                .padding()
            
            // In SwiftUI Text you can use init(localazyKey:) constructor to get Localazy localized keys
            Text(localazyKey: "Hello")
                .padding()
            
            Button(action: { _ = Localazy.shared.getString(for: "Just-in-source-lang") }) {
                Text("Access key without translation")
            }
            .padding()
            
            Button(action: { Localazy.shared.forceReload() }) {
                // Will force - reload all localizations and will cause server fetch to be performed
                Text("Force reload")
            }
            .padding()
            
        }
        .onAppear(perform: onAppear)
        .onReceive(contentViewModel.$didLoadLocalizedStrings) { _ in
            onStringsLoaded()
        }
        .onReceive(NotificationCenter.default.publisher(for: .localazyMissingTextFound), perform: onKeyMissing(notif:))
    }
    
    func onAppear() {
        // Will override default configuration defined in Localazy.plist
        Localazy.shared.setStatsEnabled(true)
    }
    
    /// Custom logic when all translations were successfully loaded into memory
    func onStringsLoaded() {
        // ...
    }
    
    func onKeyMissing(notif: NotificationCenter.Publisher.Output) {
        _ = notif.userInfo?["id"] as? LocalazyID
        let locale = notif.userInfo?["locale"] as? LocalazyLocale
        let key = notif.userInfo?["key"] as? String ?? "--"
        os_log("Missing translation found for key: %@, locale: %@.", log: .default, type: .info, key, locale?.description ?? "--")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
