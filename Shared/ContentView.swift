//
//  ContentView.swift
//  Shared
//
//  Created by Jaroslav Pulik on 01/04/2021.
//

import SwiftUI

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
            Text("Hello".localazyLocalized)
                .padding()
            Button(action: { _ = Localazy.shared.getString(for: "Just-in-source-lang") }) {
                Text("Access key without translation")
            }
        }
            .onAppear(perform: onAppear)
            .onChange(of: contentViewModel.didLoadLocalizedStrings) { _ in
                onStringsLoaded()
            }
            .onReceive(NotificationCenter.default.publisher(for: .localazyMissingTextFound)) { notif in
                let id = notif.userInfo?["id"] as? LocalazyID
                let locale = notif.userInfo?["locale"] as? LocalazyLocale
                let key = notif.userInfo?["key"] as? String
                print(id, locale, key)
            }
    }
    
    func onAppear() {
//        Localazy.shared.forceReload()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(50)) {
            Localazy.shared.setStatsEnabled(false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(100)) {
            Localazy.shared.setStatsEnabled(true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(150)) {
            Localazy.shared.setStatsEnabled(false)
        }
    }
    
    func onStringsLoaded() {
        let locales = Localazy.shared.getLocales()
        print(locales)
        
        let string = Localazy.shared.getString(for: "Hello")
        print(string)
        
        print("Hello".localazyLocalized)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
