//
//  TestView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 08/11/23.
//

import SwiftUI
import SwiftData

struct TestView: View {
    @Environment(\.modelContext) var context
    @Query private var motorcycles: [Motorcycle]
    
    @State private var name: String = ""
    @State private var mileage: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Brand", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Milegae", text: $mileage)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        
                        let m = Motorcycle(brand: name, currentMileage: Int(mileage)!)
                        context.insert(m)
                        name = ""
                        mileage = ""
                    }
                
                List(motorcycles) { motorcycle in
                    NavigationLink {
                        TestDetailView(motorcycle: motorcycle)
                    } label: {
                        Text("\(motorcycle.brand) - \(motorcycle.currentMileage)")
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct TestDetailView: View {
    let motorcycle: Motorcycle
    
    @State private var text: String = ""
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            TextField("Note text", text: $text)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    let sparepart = SparepartHistory(name: text, lastServiceMileage: 20, sparepartType: .airfilter)
                    sparepart.motorcycle = motorcycle
//                    modelContext.insert(sparepart)
                    
                    motorcycle.spareparts?.append(sparepart)
                    text = ""
                }
            
            List(motorcycle.spareparts ?? []) { sparepart in
                Text("\(sparepart.name) - \(sparepart.lastServiceMileage)")
            }
            Spacer()
        }
    }
}

#Preview {
    TestView()
}
