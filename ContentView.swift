//
//  ContentView.swift
//  notes
//
//  Created by jose juan alcantara rincon on 04/10/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myNotes: MyNotes
    @State var searchString: String = ""
    @State var newFolderName: String = ""
    @State var showingPopUp: Bool = false
    @State private var isActive: Bool = false
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    TextField("Search", text: $searchString)
                    Section(header:
                        Text("On My iPhone")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)){
                        if myNotes.folders.count > 0 {
                            FolderCell(name: "All on My iPhone", myNotes: myNotes)
                        }
                        FolderCell(name: "Notes", myNotes: myNotes)
                        ForEach(myNotes.folders){ folderName in
                            FolderCell(name: folderName.name, myNotes: myNotes)
                        }
                        .onDelete(perform: { indexSet in
                            print(indexSet)
                        })
                    }
                    .textCase(nil)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button("Edit"){
                            print("Edit")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar){
                        Image(systemName: "folder.badge.plus")
                            .onTapGesture {
                                showingPopUp.toggle()
                            }
                        Spacer()
                        HStack{
                            Text("")
                            NavigationLink(
                                destination: NoteView(rootActive: $isActive, myNotes: myNotes),
                                isActive: $isActive,
                                label: {
                                    Image(systemName: "square.and.pencil")
                                }
                            )
                        }
                    }
                }
            }
            if(showingPopUp){
                NewFolder($showingPopUp, with: myNotes)
            }
        }
    }
}

struct FolderCell: View {
    var name:String
    var myNotes: MyNotes
    var body: some View{
        NavigationLink(destination: FolderView(myNotes: myNotes, folderName: name)){
            HStack{
                Image(systemName: "folder")
                Text(name)
            }
        }
    }
}

struct NewFolder: View {
    @ObservedObject var myNotes: MyNotes
    @Binding var showingPopUp: Bool
    @State var newFolderName: String = ""
    
    init(_ showingPopUp: Binding<Bool>, with myNotes: MyNotes){
        self._showingPopUp = showingPopUp
        self.myNotes = myNotes
    }
        
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.40, alignment: .center)
                VStack{
                    Text("New Folder")
                        .font(.headline)
                    Text("Enter a name for this folder")
                        .font(.subheadline)
                    Spacer()
                    TextField("Name", text: $newFolderName)
                        .frame(width: 200, height: 10)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(7)
                    Spacer()
                    Color.gray.frame(width: 200, height: CGFloat(1))
                    HStack{
                        Button(action: {
                            showingPopUp.toggle()
                        }){
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                        }
                        Button(action: {
                                myNotes.folders.append(Folder(name: newFolderName))
                                showingPopUp.toggle()
                        }){
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testNotes = MyNotes()
        testNotes.folders = testFolders
        return ContentView(myNotes: testNotes)
    }
}
