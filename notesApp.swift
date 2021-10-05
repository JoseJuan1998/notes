//
//  notesApp.swift
//  notes
//
//  Created by jose juan alcantara rincon on 04/10/21.
//

import SwiftUI

@main
struct notesApp: App {
    @StateObject private var myNotes = MyNotes()
    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNotes)
        }
    }
}
