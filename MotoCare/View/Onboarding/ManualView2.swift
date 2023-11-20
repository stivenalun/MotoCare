import SwiftUI

struct ManualView2: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM: MotorcycleViewModel
    @Bindable var motorcycle: Motorcycle
    @State private var lastServiceMileage = ""
    @State private var lastServiceMileage2 = ""
    @State private var lastServiceMileage3 = ""
    @State private var selectedSpareparts: [Sparepart] = []
    @State private var selectedSparepartsServis2: [Sparepart] = []
    @State private var selectedSparepartsServis3: [Sparepart] = []
    @FocusState var isInputActive: Bool
    @State private var isPushed: Bool = false
<<<<<<< HEAD
    
    @State private var selectedSpareparts: [Sparepart] = []
    
=======

>>>>>>> container-baru
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading) {
                                Text("Yuk input sampai 3 perbaikan terakhirmu di bengkel.")
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 20)
                                    .frame(maxWidth: 350, alignment: .topLeading)
                                
                                Text("Riwayat Servis 1")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Rectangle()
                                    .fill(Color("BackColor"))
                                    .cornerRadius(10)
                                    .frame(width: 350, height: 35)
                                    .overlay(
                                        TextField("Jarak tempuh", text: $lastServiceMileage)
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 10)
                                            .keyboardType(.numberPad)
                                            .focused($isInputActive)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                    Spacer()
                                                    Button("Done") {
                                                        isInputActive = false
                                                    }
                                                }
                                            }
                                    )

                                Text("Sparepart yang diservis")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                VStack {
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[0], selectedSpareparts: $selectedSpareparts)
                                        CheckboxRow(sparepart: sparepartData[1], selectedSpareparts: $selectedSpareparts)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[2], selectedSpareparts: $selectedSpareparts)
                                        CheckboxRow(sparepart: sparepartData[3], selectedSpareparts: $selectedSpareparts)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[4], selectedSpareparts: $selectedSpareparts)
                                    }
                                
                                    // Add more CheckboxRows as needed
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("Riwayat Servis 2")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Rectangle()
                                    .fill(Color("BackColor"))
                                    .cornerRadius(10)
                                    .frame(width: 350, height: 35)
                                    .overlay(
                                        TextField("Jarak tempuh", text: $lastServiceMileage2)
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 10)
                                            .keyboardType(.numberPad)
                                            .focused($isInputActive)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                    Spacer()
                                                    Button("Done") {
                                                        isInputActive = false
                                                    }
                                                }
                                            }
                                    )

                                Text("Sparepart yang diservis")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                VStack {
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[0], selectedSpareparts: $selectedSparepartsServis2)
                                        CheckboxRow(sparepart: sparepartData[1], selectedSpareparts: $selectedSparepartsServis2)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[2], selectedSpareparts: $selectedSparepartsServis2)
                                        CheckboxRow(sparepart: sparepartData[3], selectedSpareparts: $selectedSparepartsServis2)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[4], selectedSpareparts: $selectedSparepartsServis2)
                                    }
                                    // Add more CheckboxRows as needed
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("Riwayat Servis 3")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                Rectangle()
                                    .fill(Color("BackColor"))
                                    .cornerRadius(10)
                                    .frame(width: 350, height: 35)
                                    .overlay(
                                        TextField("Jarak tempuh", text: $lastServiceMileage3)
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 10)
                                            .keyboardType(.numberPad)
                                            .focused($isInputActive)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                    Spacer()
                                                    Button("Done") {
                                                        isInputActive = false
                                                    }
                                                }
                                            }
                                    )
<<<<<<< HEAD
                                
                                Text ("Sparepart yang diservis")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                VStack{
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 120, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[4],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        RectangleStyle()
                                            .frame(width: 115, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[0],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 130, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[1],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        RectangleStyle()
                                            .frame(width: 145, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[3],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 140, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[2],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
=======

                                Text("Sparepart yang diservis")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                VStack {
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[0], selectedSpareparts: $selectedSparepartsServis3)
                                        CheckboxRow(sparepart: sparepartData[1], selectedSpareparts: $selectedSparepartsServis3)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[2], selectedSpareparts: $selectedSparepartsServis3)
                                        CheckboxRow(sparepart: sparepartData[3], selectedSpareparts: $selectedSparepartsServis3)
                                    }
                                    HStack{
                                        CheckboxRow(sparepart: sparepartData[4], selectedSpareparts: $selectedSparepartsServis3)
                                    }
                                    // Add more CheckboxRows as needed
>>>>>>> container-baru
                                }
                            }

                            .padding()
                            .navigationBarTitle("Manual Input")
                        }
                    }

                    NavigationLink(
                        destination: FinishOnboardingView(),
                        isActive: $isPushed,
                        label: {
                            Button(action: {
                                print("===================================")
                                addMaintenanceHistory()
                                isPushed.toggle()
                            }, label: {
                                Text("Selesai")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 335, height: 45)
                                    .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                                    .cornerRadius(11)
                            })
                        })
                }
            }
        }
    }

    func checkboxSelected(sparepart: Sparepart, isMarked: Bool) {
<<<<<<< HEAD
        print("\(sparepart) is marked: \(isMarked)")
        //
        if isMarked {
            // If marked, add to the selectedSpareparts array
            selectedSpareparts.append(sparepart)
        } else {
            // If unmarked, remove from the selectedSpareparts array
            if let index = selectedSpareparts.firstIndex(of: sparepart) {
                selectedSpareparts.remove(at: index)
            }
        }
        //
    }
    
    func addMaintenanceHistory() {
        // MARK: Save maintenance history
        let maintenanceHistory = MaintenanceHistory(date: Date(),
                                                    maintenanceMileage: Int(lastServiceMileage) ?? 0)
        
        motorcycle.maintenanceHistories.append(maintenanceHistory)
        
=======
        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSpareparts)
    }

    func checkboxSelected2(sparepart: Sparepart, isMarked: Bool) {
        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSparepartsServis2)
    }

    func checkboxSelected3(sparepart: Sparepart, isMarked: Bool) {
        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSparepartsServis3)
    }

    func addMaintenanceHistory() {
        let maintenanceHistory = MaintenanceHistory(date: Date(), maintenanceMileage: Int(lastServiceMileage) ?? 0)
        motorcycle.maintenanceHistories.append(maintenanceHistory)

        appendSparepartsToMaintenanceHistory(selectedSpareparts: selectedSpareparts)
        appendSparepartsToMaintenanceHistory(selectedSpareparts: selectedSparepartsServis2)
        appendSparepartsToMaintenanceHistory(selectedSpareparts: selectedSparepartsServis3)

        print("Success saved!")
    }

    private func handleCheckboxSelection(sparepart: Sparepart, isMarked: Bool, selectedSpareparts: Binding<[Sparepart]>) {
        if isMarked {
            selectedSpareparts.wrappedValue.append(sparepart)
        } else {
            if let index = selectedSpareparts.wrappedValue.firstIndex(of: sparepart) {
                selectedSpareparts.wrappedValue.remove(at: index)
            }
        }
    }

    private func appendSparepartsToMaintenanceHistory(selectedSpareparts: [Sparepart]) {
>>>>>>> container-baru
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.type.rawValue, sparepartType: part.type)
            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
        }
    }
    
    struct RectangleStyle: View {
        var body: some View {
            Rectangle()
                .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                .cornerRadius(10)
                .padding(.leading, -4)
        }
    }
    
}

struct CheckboxRow: View {
    let sparepart: Sparepart
    @Binding var selectedSpareparts: [Sparepart]

    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
            .frame(width: 120, height: 30)
            .cornerRadius(10)
            .padding(.leading, -4)
            .overlay(
                CheckboxField(
                    sparepart: sparepart,
                    label: sparepart,
                    size: 17,
                    textSize: 17,
                    imageName: sparepart.icon,
                    callback: { isMarked in
                        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSpareparts)
                    }
                )
            )
    }

    private func handleCheckboxSelection(sparepart: Sparepart, isMarked: Bool, selectedSpareparts: Binding<[Sparepart]>) {
        if isMarked {
            selectedSpareparts.wrappedValue.append(sparepart)
        } else {
            if let index = selectedSpareparts.wrappedValue.firstIndex(of: sparepart) {
                selectedSpareparts.wrappedValue.remove(at: index)
            }
        }
    }
}

struct CheckboxField: View {
    
    let partData: Sparepart
    let size: CGFloat
    let color: Color
    let textSize: Int
<<<<<<< HEAD
    let callback: (Sparepart, Bool)->()
    
    init(
        partData: Sparepart,
        color: Color = Color.white,
        callback: @escaping (Sparepart, Bool)->()
=======
    let imageName: String
    let callback: (Bool)->()

    init(
        sparepart: Sparepart,
        label: Sparepart,
        size: CGFloat = 10,
        color: Color = Color.white,
        textSize: Int = 14,
        imageName: String,
        callback: @escaping (Bool)->()
>>>>>>> container-baru
    ) {
        self.partData = partData
        self.size = 17
        self.color = color
        self.textSize = 17
        self.callback = callback
    }

    @State var isMarked: Bool = false

    var body: some View {
        Button(action: {
            self.isMarked.toggle()
<<<<<<< HEAD
            self.callback(partData, self.isMarked)
=======
            self.callback(self.isMarked)
>>>>>>> container-baru
        }) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: self.isMarked ? "checkmark.circle.fill" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Image(partData.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(partData.type.rawValue)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}
<<<<<<< HEAD



//#Preview {
//    ManualView2()
//}


//#Preview {
//    ManualView2(motorcycle: motorcycleVM.motorcycle)
//}

=======
>>>>>>> container-baru
