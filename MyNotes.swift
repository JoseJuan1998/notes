//
//  MyNotes.swift
//  notes
//
//  Created by jose juan alcantara rincon on 04/10/21.
//

import Foundation

class MyNotes: ObservableObject{
    @Published var folders = [Folder]()
    @Published var notes = [Note]()
}

struct Folder: Identifiable {
    var id = UUID()
    var name: String
    var notes: [Note] = testNotes
}

struct Note: Identifiable {
    var id = UUID()
    var title: String
    var noteText: String
}

var testFolders = [
    Folder(name: "Folder1"),
    Folder(name: "Folder2")
]

var testNotes = [
    Note(title: "Note1", noteText: "Lorem Ipsum"),
    Note(title: "Note2", noteText: "Lorem Ipsum")
]
