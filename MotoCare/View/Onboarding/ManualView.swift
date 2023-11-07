import SwiftUI

struct Sparepart: Identifiable, Equatable { // Conform ke Equatable
    let id = UUID()
    let name: String
    
    static func == (lhs: Sparepart, rhs: Sparepart) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ManualView: View {
    @State private var isModalPresented = false
    @State private var servis1 = ""
    @State private var servis2 = ""
    @State private var servis3 = ""
    @State private var selectedSparepartsServis1: [Sparepart] = []
    @State private var selectedSparepartsServis2: [Sparepart] = []
    @State private var selectedSparepartsServis3: [Sparepart] = []
    @FocusState var isInputActive: Bool
    @State private var currentServisSelection: Int = 1
    
    // Dummy data for spareparts
    let availableSpareparts: [Sparepart] = [
        Sparepart(name: "Oli Gardan"),
        Sparepart(name: "Oli Mesin"),
        Sparepart(name: "V-Belt"),
        Sparepart(name: "Busi"),
        Sparepart(name: "Air Filter"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text("Masukkan data servis terakhir!")
                        .font(.system(size: 18))
                        .frame(width: 355, height: 50, alignment: .topLeading)
                    
                    Text("Servis 1")
                        .modifier(ServisTitleModifier())
                    
                    Rectangle()
                        .fill(Color("BackColor"))
                        .cornerRadius(5)
                        .frame(width: 360, height: 40)
                        .overlay(
                            TextField("Jarak tempuh", text: $servis1)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                    }
                                }
                        )
                        .padding(.bottom, 5)
                    
                    Button("+ Sparepart") {
                        isModalPresented.toggle()
                        currentServisSelection = 1
                    }
                    .modifier(ButtonStyleModifier())
                    
                    HStack {
                        ForEach(selectedSparepartsServis1, id: \.id) { selectedSparepart in
                            Text(selectedSparepart.name)
                                .modifier(SelectedSparepartModifier())
                        }
                    }
                    
                    Text("Servis 2")
                        .modifier(ServisTitleModifier())
                    
                    Rectangle()
                        .fill(Color("BackColor"))
                        .cornerRadius(10)
                        .frame(width: 360, height: 40)
                        .overlay(
                            TextField("Jarak tempuh", text: $servis2)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                    }
                                }
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
                    
                    Rectangle()
                        .fill(Color("BackColor"))
                        .cornerRadius(10)
                        .frame(width: 360, height: 40)
                        .overlay(
                            TextField("Jarak tempuh", text: $servis3)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                    }
                                }
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
                        NavigationLink(destination: FinishOnboardingView(), label: {
                            Text("Selesai")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 335, height: 55, alignment: .center)
                                .background(Color(red: 1, green: 0.83, blue: 0.15))
                                .cornerRadius(25)
                        } )
                    }
                    .padding(.top, 60)
                }
                .navigationTitle("Input Manual")
                .sheet(isPresented: $isModalPresented) {
                    // Pass state isSelectionConfirmed ke SparepartSelectionView
                    SparepartSelectionView(spareparts: availableSpareparts,
                                           selectedSpareparts: currentServisSelection == 1 ? $selectedSparepartsServis1 : (currentServisSelection == 2 ? $selectedSparepartsServis2 : $selectedSparepartsServis3),
                                           isModalPresented: $isModalPresented)
                    .presentationDetents([.large, .medium, .fraction(0.42)])
                }
            }
        }
    }
}

struct SparepartSelectionView: View {
    var spareparts: [Sparepart]
    @Binding var selectedSpareparts: [Sparepart]
    @Binding var isModalPresented: Bool
    
    var body: some View {
        NavigationView {
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

struct SelectedSparepartModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding(5)
            .background(Color(red: 1, green: 0.94, blue: 0.71))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .inset(by: 0.5)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

struct ServisTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
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

#Preview {
    ManualView()
}






