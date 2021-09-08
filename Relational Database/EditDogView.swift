//
//  EditDogView.swift
//  Relational Database
//
//  Created by Sasha on 9/8/21.
//

import SwiftUI

struct EditDogView: View {
    
    @Binding var id: Int
    @State var name: String = ""
    @State var breed: String = ""
    @State var age: String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter breed", text: $breed)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter age", text: $age)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            Button(action: {
                
                Manager().updateDog(idValue: self.id, nameValue: self.name, breedValue: self.breed, ageValue: Int(self.age) ?? 0)
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit dog")
            }).frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            
        }
        .padding()
        .onAppear(perform: {
            let dogModel: DogModel = Manager().getDogs(idValue: self.id)
            
            self.name = dogModel.name
            self.breed = dogModel.breed
            self.age = String(dogModel.age)
        })
    }
}

struct EditDogView_Previews: PreviewProvider {
    
    @State static var id: Int = 0
    
    static var previews: some View {
        EditDogView(id: $id)
    }
}
