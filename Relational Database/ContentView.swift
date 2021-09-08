//
//  ContentView.swift
//  Relational Database
//
//  Created by Sasha on 9/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var dogModels: [DogModel] = []
    @State var dogSelected: Bool = false
    @State var selectedDogId: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: AddDogView(),
                        label: {
                            Text("Add dog")
                        })
                }
                NavigationLink (
                    destination: EditDogView(id: self.$selectedDogId), isActive: self.$dogSelected) {
                    EmptyView()
                }
                    
                
                List(self.dogModels) { (model) in
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.breed)
                        Spacer()
                        Text("\(model.age)")
                        
                        Button(action: {
                            self.selectedDogId = model.id
                            self.dogSelected = true
                        }, label: {
                            Text("Edit")
                                .foregroundColor(.blue)
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        
                        Button(action: {
                            let manager: Manager = Manager()
                            manager.deleteDog(idValue: model.id)
                            self.dogModels = manager.getDogs()
                           
                        }, label: {
                            Text("Delete")
                                .foregroundColor(.red)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                
            }.padding()
            .onAppear(perform: {
                self.dogModels = Manager().getDogs()
            })
            .navigationBarTitle("Dogs")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
