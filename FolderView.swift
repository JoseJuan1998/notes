//
//  FolderView.swift
//  notes
//
//  Created by jose juan alcantara rincon on 04/10/21.
//

import SwiftUI

struct FolderView: View {
    @ObservedObject var myNotes: MyNotes
    var folderName: String
    
    var body: some View {
        List{
            if folderName == "Notes" || folderName == "All on My iPhone" {
                ForEach(myNotes.notes){ note in
                    Text(note.title)
                }
            }
        }
        .navigationTitle(folderName)
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar){
                if folderName == "Notes" || folderName == "All on My iPhone"{
                    Text("\(myNotes.notes.count) " + "Notes")
                }else{
                    Text("0 Notes")                }
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        let testnote = MyNotes()
        testnote.notes = testNotes
        return FolderView(myNotes: testnote, folderName: "Folder Name")
    }
}
