//
//  AddDogView.swift
//  Relational Database
//
//  Created by Sasha on 9/8/21.
//

import SwiftUI

struct AddDogView: View {
    
    @State var name: String = ""
    @State var breed: String = ""
    @State var age: String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
                .padding(10)
                .cornerRadius(5)
                .background(Color(.systemGray6))
                .disableAutocorrection(true)
            
            TextField("Enter breed", text: $breed)
                .padding(10)
                .cornerRadius(5)
                .background(Color(.systemGray6))
                .disableAutocorrection(true)
            
            TextField("Enter age", text: $age)
                .padding(10)
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .background(Color(.systemGray6))
                .disableAutocorrection(true)
            
            Button(action: {
                Manager().addDog(nameValue: self.name, breedValue: self.breed, ageValue: Int(self.age) ?? 0)
                
                self.mode.wrappedValue
                .dismiss()
            }, label: {
                Text("Add dog")
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
        }.padding()
        
    }
}

struct AddDogView_Previews: PreviewProvider {
    static var previews: some View {
        AddDogView()
    }
}
