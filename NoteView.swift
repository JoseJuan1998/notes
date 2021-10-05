//
//  NoteView.swift
//  notes
//
//  Created by jose juan alcantara rincon on 05/10/21.
//

import SwiftUI

struct NoteView: View {
    @Binding var rootActive: Bool
    @ObservedObject var myNotes: MyNotes
    @State var title = ""
    @State var noteText = ""
   
    var body: some View {
        VStack {
            TextEditor(text: $noteText)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Done") {
                            title = noteText.components(separatedBy: .newlines)[0]
                            myNotes.notes.append(Note(title: title, noteText: noteText))
                            rootActive.toggle()
                        }
                    }
                }
        }
    }
}


struct NoteView_Previews: PreviewProvider {
    static var previews: some View{
        let testNote = MyNotes()
        testNote.notes = testNotes
        return NoteView(rootActive: .constant(false) ,myNotes: testNote)
    }
}
