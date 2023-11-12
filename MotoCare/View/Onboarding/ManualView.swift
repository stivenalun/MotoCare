import SwiftUI

struct ManualView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    let motorcycle: Motorcycle
    
    @State private var isModalPresented = false
    @State private var lastServiceMileage = ""
    @State private var lastServiceMileage2 = ""
    @State private var lastServiceMileage3 = ""
    @State private var selectedSpareparts: [Sparepart] = []
    @State private var selectedSparepartsServis2: [Sparepart] = []
    @State private var selectedSparepartsServis3: [Sparepart] = []
    @FocusState var isInputActive: Bool
    @State private var currentServisSelection: Int = 1
    @State private var isNavigate = false
    
    let availableSpareparts: [Sparepart] = sparepartData
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
                VStack {
                    ScrollView {
                        Text("Masukkan data servis terakhir!")
                            .font(.system(size: 18))
                            .frame(width: 355, height: 50, alignment: .topLeading)
                            .foregroundColor(.white)
                        
                        Text("Servis 1")
                            .modifier(ServisTitleModifier())
                        
                        Rectangle()
                            .fill(Color("BackColor"))
                            .cornerRadius(10)
                            .frame(width: 360, height: 40)
                            .overlay(
                                TextField("Jarak tempuh", text: $lastServiceMileage)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 20)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                        }
                                    }
                                    .keyboardType(.decimalPad)
                            )
                            .padding(.bottom, 5)
                        
                        Button("+ Sparepart") {
                            isModalPresented.toggle()
                            currentServisSelection = 1
                        }
                        .modifier(ButtonStyleModifier())
                        
                        HStack {
                            ForEach(selectedSpareparts, id: \.id) { selectedSparepart in
                                Text(selectedSparepart.name)
                                    .modifier(SelectedSparepartModifier())
                            }
                        }
                        
                        Text("Servis 2")
                            .modifier(ServisTitleModifier())
                            .padding(.vertical)
                        
                        Rectangle()
                            .fill(Color("BackColor"))
                            .cornerRadius(10)
                            .frame(width: 360, height: 40)
                            .overlay(
                                TextField("Jarak tempuh", text: $lastServiceMileage2)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 20)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done"){
                                                isInputActive = false
                                            }
                                        }
                                    }
                                    .keyboardType(.decimalPad)
                            )
                            .padding(.bottom, 5)
                        
                        Button("+ Sparepart ") {
                            isModalPresented.toggle()
                            currentServisSelection = 2
                        }
                        .modifier(ButtonStyleModifier())
                        
                        HStack {
                            ForEach(selectedSparepartsServis2, id: \.id) { selectedSparepart in
                                Text(selectedSparepart.name)
                                    .modifier(SelectedSparepartModifier())
                            }
                        }
                        
                        Text("Servis 3")
                            .modifier(ServisTitleModifier())
                            .padding(.vertical)
                        
                        Rectangle()
                            .fill(Color("BackColor"))
                            .cornerRadius(10)
                            .frame(width: 360, height: 40)
                            .overlay(
                                TextField("Jarak tempuh", text: $lastServiceMileage3)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 20)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                        }
                                    }
                                    .keyboardType(.decimalPad)
                            )
                            .padding(.bottom, 5)
                        
                        Button("+ Sparepart ") {
                            isModalPresented.toggle()
                            currentServisSelection = 3
                        }
                        .modifier(ButtonStyleModifier())
                        
                        HStack {
                            ForEach(selectedSparepartsServis3, id: \.id) { selectedSparepart in
                                Text(selectedSparepart.name)
                                    .modifier(SelectedSparepartModifier())
                            }
                        }
                        
                        VStack{
                            Button {
                                addSpareparts()
                                isNavigate = true
                            } label: {
                                Text("Selesai")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 335, height: 55, alignment: .center)
                                    .background(Color("TabIconColor"))
                                    .cornerRadius(25)
                            }
                        }
                        .padding(.top, 60)
                    }
                    .navigationTitle("Input Manual")
                    .sheet(isPresented: $isModalPresented) {
                        // Pass state isSelectionConfirmed ke SparepartSelectionView
                        SparepartSelectionView(spareparts: availableSpareparts,
                                               selectedSpareparts: currentServisSelection == 1 ? $selectedSpareparts : (currentServisSelection == 2 ? $selectedSparepartsServis2 : $selectedSparepartsServis3),
                                               isModalPresented: $isModalPresented)
                        .presentationDetents([.large, .medium, .fraction(0.40)])
                    }
                    .navigationDestination(isPresented: $isNavigate) {
                        FinishOnboardingView()
                    }
                }
            }
        }
    }
    
    func addSpareparts() {
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.name, lastServiceMileage: Int(lastServiceMileage)!, sparepartType: part.type)
            sparepart.motorcycle = motorcycle
            // simpen ke database
            motorcycle.spareparts?.append(sparepart)
        }
    }
}
    
struct SparepartSelectionView: View {
    var spareparts: [Sparepart]
    @Binding var selectedSpareparts: [Sparepart]
    @Binding var isModalPresented: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                List(spareparts) { sparepart in
                    Button(action: {
                        if selectedSpareparts.contains(sparepart) {
                            selectedSpareparts.removeAll { $0 == sparepart }
                        } else {
                            selectedSpareparts.append(sparepart)
                        }
                    }) {
                        HStack {
                            Text(sparepart.name)
                            Spacer()
                            if selectedSpareparts.contains(sparepart) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                .navigationTitle(" ")
                .foregroundColor(.black)
                .listStyle(InsetGroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            isModalPresented = false // Tutup modal saat "Konfirmasi" diklik
                        }
                    }
                }
            }
        }
    }
}

struct SelectedSparepartModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .font(.system(size: 14))
            .foregroundColor(.black)
            .frame(height: 40, alignment: .center)
            .background(Color("TabIconColor"))
            .cornerRadius(16)
    }
}

struct ServisTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .frame(width: 355, alignment: .topLeading)
    }
}

struct ButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 15)
            .padding(.vertical, 3)
            .foregroundColor(.black)
            .background(Color("TabIconColor"))
            .cornerRadius(8)
            .padding(.trailing, 230)
            .padding(.bottom, 10)
    }
}

//#Preview {
//    ManualView()
//}






