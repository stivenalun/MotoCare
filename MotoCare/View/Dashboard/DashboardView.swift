//
//  DashboardView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel = DashboardViewModel()
    
    //    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @Query var motorcycles: [Motorcycle]
    @Query var sparepartHistories: [SparepartHistory]
    @Query(sort: \MaintenanceHistory.date, order: .reverse) var maintenanceHistories: [MaintenanceHistory]
    
    @State private var showModal = false
    @State private var isModalPresented = false
    //    @State private var isUpdateModalPresented = false
    @State private var selectedItem: GaugeData?
    @State private var modalDetent = PresentationDetent.medium
    
    
    @AppStorage("IOTMILLEAGE") var iOTCurrentMilleage: Int = 0
    @AppStorage("IOTSTATUS") var iOTStatus: Bool = false
    
    private var delegate: NotificationDelegate = NotificationDelegate()
    
    
    var body: some View {
        NavigationView {
            ZStack{
//                BackgroundView()
                VStack {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Merek Motor")
                                        .font(.system(size: 17))
                                        .foregroundColor(.white)
                                    HStack {
                                        Text("Lexi S ABS")
                                            .font(.system(size: 34))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91))
                                        Spacer()
                                        HStack {
                                            if iOTStatus {
                                                Text("iOT Terhubung")
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(.green)
                                                
                                            } else {
                                                Text("iOT Tidak Terhubung")
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                        .padding(10)
                                        .frame(width: 159, height: 27, alignment: .center)
                                        .background(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.5))
                                        .cornerRadius(40)
                                    }
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 357, height: 149)
                                            .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                            .cornerRadius(20)
                                        VStack(alignment: .leading) {
                                            ZStack(alignment: .leading) {
                                                VStack(alignment: .leading) {
                                                    Text("Jarak Tempuh")
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.white)
                                                    
                                                    //                                                    Text("\(iOTCurrentMilleage) Km")
                                                    Text("\(motorcycles[0].currentMileage + (iOTCurrentMilleage/1000)) Km")
                                                        .font(.system(size: 36))
                                                        .italic()
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                        .padding(.bottom, 13)
                                                    Button(action: {
                                                        isModalPresented = true
                                                        
                                                    }) {
                                                        Text("Perbarui Jarak Tempuh")
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                            .foregroundStyle(.black)
                                                            .padding(5)
                                                    }
                                                    .padding(6)
                                                    .frame(width: 318, height: 44, alignment: .center)
                                                    .background(Color("TabIconColor"))
                                                    .cornerRadius(11)
                                                    .sheet(isPresented: $isModalPresented) {
                                                        ModalUpdateOdometerView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(width: 357, height: 132)
                                }
                                
                                
                                
                                
                                
                                
                                StatusSparepartView(motorcycle: motorcycles[0],
                                                    data: convertData(spareparts: sparepartData,
                                                                      sparepartHistories: summaryOfSparePartHistory(),
                                                                      maintenanceMileage: maintenanceHistories.first?.maintenanceMileage ?? 0),
                                                    selectedItem: $selectedItem,
                                                    showModal: $showModal)
                                
                                
                            }
                            .padding()
                            //                            .navigationBarTitle("Dashboard")
                        }
                    }
                }
            }
            .onAppear {
                print(motorcycles.count)
                
                let center = UNUserNotificationCenter.current()
                center.delegate = delegate
                center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
                    if let error = error {
                        print(error)
                    } else {
                        self.setupNotification()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showModal) {
            ModalSparepartView(data: $selectedItem)
                .presentationDetents([.height(575), .large], selection: $modalDetent)
            //                .background(
            //                    LinearGradient(
            //                        stops: [
            //                            Gradient.Stop(color: Color(red: 0.2, green: 0.29, blue: 0.3), location: 0.00),
            //                            Gradient.Stop(color: .black.opacity(0.9), location: 1.00),
            //                        ],
            //                        startPoint: UnitPoint(x: 0.95, y: 0),
            //                        endPoint: UnitPoint(x: 0.26, y: 0.98)
            //                    ))
                .ignoresSafeArea()
        }
    }
    
    func summaryOfSparePartHistory() -> [SparepartHistory] {
        
        print(sparepartHistories.count)
        // Create a dictionary to store the latest timestamp for each event name
        var latestTimestamps: [String: Date] = [:]
        
        // Create an array to store the filtered results
        var filteredSparepartHistories: [SparepartHistory] = []
        
        // Iterate through the original array and append only the newest events for each unique event name to the filtered array
        for event in sparepartHistories {
            if let latestTimestamp = latestTimestamps[event.name] {
                if event.createdAt > latestTimestamp {
                    latestTimestamps[event.name] = event.createdAt
                    filteredSparepartHistories.removeAll(where: { $0.name == event.name })
                    filteredSparepartHistories.append(event)
                }
            } else {
                latestTimestamps[event.name] = event.createdAt
                filteredSparepartHistories.append(event)
            }
        }
        
        // Print the results
        for event in filteredSparepartHistories {
            print("\(event.name) - \(event.createdAt)")
        }
        return filteredSparepartHistories
    }
    
    func setupNotification() {
        let center = UNUserNotificationCenter.current()
        
        // create content
        let content = UNMutableNotificationContent()
        content.title = "Motomo butuh kamu!"
        content.body =  "Sudah waktunya perbarui jarak tempuh kamu nih. Yuk ke Dashboard sekarang."
        content.categoryIdentifier = NotificationCategory.general.rawValue
        content.userInfo = ["customData": "Some Data"]
        
        // create trigger
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // create trigger tiap 2 minggu sekali
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        dateComponents.day = 14 // 2 weeks in days
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // create request
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        
        // define actions
        let dismiss = UNNotificationAction(identifier: NotificationAction.dimiss.rawValue, title: "Dismiss", options: [])
        
        let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
        
        let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([generalCategory])
        
        // add request to notification center
        center.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func convertData(spareparts: [Sparepart], sparepartHistories: [SparepartHistory], maintenanceMileage: Int) -> [GaugeData] {
        var gauges = [GaugeData]()
        for data in spareparts {
            var icon = ""
            var checkIntervalInKilometer: Double = 0
            var replaceIntervalInKilometer: Double = 0
            var image = ""
            switch data.type {
            case .busi:
                icon = "spark-plug"
                checkIntervalInKilometer = 4000
                replaceIntervalInKilometer = 8000
                image = "SparkPlugImage"
            case .vbelt:
                icon = "v-belt"
                checkIntervalInKilometer = 8000
                replaceIntervalInKilometer = 25000
                image = "VBeltImage"
            case .olimesin:
                icon = "engine-oil"
                checkIntervalInKilometer = 0
                replaceIntervalInKilometer = 4000
                image = "EngineOilImage"
            case .oligardan:
                icon = "final-drive-oil"
                checkIntervalInKilometer = 4000
                replaceIntervalInKilometer = 12000
                image = "FinalDriveOilImage"
            case .airfilter:
                icon = "air-filter"
                checkIntervalInKilometer = 16000
                replaceIntervalInKilometer = 16000
                image = "AirFilterImage"
                
            }
            
            var gauge = GaugeData(
                value: 0,
                minimum: 0,
                maximum: replaceIntervalInKilometer,
                iconSparePart: icon,
                labelText: data.type.rawValue,
                imageSparePart: image,
                status: estimateSparepartStatus(lastServiceMillage: maintenanceMileage,
                                                currentMillage: motorcycles[0].currentMileage,
                                                type: data.type)
            )
            if let sparepart = sparepartHistories.first(where: { $0.sparepartType == data.type }) {
                gauge.status = estimateSparepartStatus(lastServiceMillage: sparepart.maintenanceMileage,
                                                       currentMillage: motorcycles[0].currentMileage,
                                                       type: data.type)
                gauge.value = replaceIntervalInKilometer - Double(motorcycles[0].currentMileage - sparepart.maintenanceMileage)
                print("\(sparepart.name) - \(sparepart.createdAt)")
                gauges.append(gauge)
            } else {
                gauge.value = 0
                gauge.status = .none
                gauges.append(gauge)
            }
            
            print("sparepart histories: \(sparepartHistories.count)")
        }
        return gauges
    }
    
    func estimateSparepartStatus(lastServiceMillage: Int, currentMillage: Int, type: SparepartType) -> SparepartStatus {
        let totalMillageFromService = currentMillage - lastServiceMillage
        
        guard let checkIntervalMillage = (sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.checkIntervalInKilometer) else { return .aman }
        
        guard let replaceIntervalMillage = (sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.replaceIntervalInKilometer) else { return .aman }
        
        if totalMillageFromService <= checkIntervalMillage && totalMillageFromService >= replaceIntervalMillage {
            return .periksa
        } else if totalMillageFromService >= replaceIntervalMillage {
            return .ganti
        } else {
            return .aman
        }
    }
}

struct StatusSparepartView : View{
    @Environment(\.modelContext) private var modelContext
    let motorcycle: Motorcycle
    @Query var motorcycles: [Motorcycle]
    
    var data: [GaugeData]
    @Binding var selectedItem: GaugeData?
    @Binding var showModal: Bool
    
    @AppStorage("modalopen") var isUpdateModalPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Spare Part")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 357, height: 450)
                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                    .cornerRadius(16)
                
                VStack {
                    Button(action: {
                        isUpdateModalPresented.toggle()
                        
                    }) {
                        Text("Tambahkan Servis Baru")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .padding(5)
                            
                    }
                    .padding(10)
                    .frame(width: 330, height: 44, alignment: .center)
                    .background(Color("TabIconColor"))
                    .cornerRadius(11)
                    .sheet(isPresented: $isUpdateModalPresented) {
                        ModalUpdateServisView(motorcycle: motorcycles[0])
                    }
                    .padding(.top, 18)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(data, id: \.id) { data in
                            Button(action: {
                                self.selectedItem = data
                                self.showModal.toggle()
                            }) {
                                //Gauge View
                                ZStack {
                                    Rectangle()
                                      .foregroundColor(.clear)
                                      .frame(width: 162, height: 109)
                                      .background(Color(red: 0.16, green: 0.22, blue: 0.23))
                                      .cornerRadius(20)
                                    
                                    HStack {
                                        Gauge(value: data.status == .ganti || data.status == .none ? data.minimum : data.value, in: data.minimum...data.maximum) {
                                            
                                        }
                                        .gaugeStyle(.accessoryCircularCapacity)
                                        .scaleEffect(1.0)
                                        .tint(data.status.tintColor)
                                        .overlay {
                                            Image(data.iconSparePart)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 80)
                                                .cornerRadius(14)
                                                .foregroundColor(.white)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(data.labelText)
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                            
                                            HStack {
                                                Image(systemName: data.status.iconStatus)
                                                    .resizable()
                                                    .frame(width: 12, height:12)
                                                    .foregroundColor(data.status.tintColor)
                                                
                                                Text(data.status.rawValue)
                                                    .font(.system(size: 12))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(data.status.tintColor)
                                            }
                                            .padding(6)
                                            .frame(height: 20, alignment: .center)
                                            .background(Color(red: 0.38, green: 0.36, blue: 0.36))
                                            .cornerRadius(22)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(13)
                    
                }
            }
        }
        .onAppear {
            //            data = convertData(history: motorcycle.spareparts ?? [])
            print("spareparts: ", data.count)
            //                print(convertData(history: motorcycle.spareparts ?? []).count)
            //                data = convertData(history: motorcycle.spareparts ?? [])
        }
    }
}

struct GaugeData: Identifiable {
    var id: UUID = UUID()
    var value: Double
    var minimum: Double
    var maximum: Double
    var iconSparePart: String
    var labelText: String
    var imageSparePart: String
    var status: SparepartStatus
}

enum SparepartStatus: String {
    case ganti = "Ganti"
    case periksa = "Periksa"
    case aman = "Aman"
    case none = "No data"
    
    var sparepartStatusValue: String {
        switch self {
        case .ganti:
            return "Ganti"
        case .periksa:
            return "Periksa"
        case .aman:
            return "Aman"
        case .none:
            return "No data"
        }
    }
    
    var iconStatus: String {
        switch self {
        case .ganti:
            return "exclamationmark.triangle.fill"
        case .periksa:
            return "questionmark.circle"
        case .aman:
            return "checkmark.circle"
        case .none:
            return "autostartstop.trianglebadge.exclamationmark"
        }
    }
    
    var tintColor: Color {
        switch self {
        case .ganti:
            return .red
        case .periksa:
            return .yellow
        case .aman:
            return .green
        default:
            return .gray
        }
        
    }
    
    var modalStatus: String {
        switch self {
        case .ganti:
            return "Ganti Segera!"
        case .periksa:
            return "Lakukan Pemeriksaan"
        case .aman:
            return "Kondisi Bagus"
        default:
            return "No Data"
        }
    }
}

//#Preview {
//    DashboardView()
//}
