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
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @Query var motorcycles: [Motorcycle]
    
    @State private var showModal = false
    @State private var isModalPresented = false
    @State private var isUpdateModalPresented = false
    @State private var selectedItem: GaugeData?
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
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
                                            Text("IoT Tidak Terhubung")
                                                .font(.system(size: 14))
                                                .foregroundStyle(.white)
                                        }
                                        .padding(10)
                                        .frame(width: 159, height: 27, alignment: .center)
                                        .background(Color(red: 0.51, green: 0.51, blue: 0.51))
                                        .cornerRadius(40)
                                    }
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 357, height: 142)
                                            .background(
                                                LinearGradient(
                                                    stops: [
                                                        Gradient.Stop(color: Color(red: 0.19, green: 0.29, blue: 0.3), location: 0.08),
                                                        Gradient.Stop(color: Color(red: 0.09, green: 0.11, blue: 0.11), location: 1.00),
                                                    ],
                                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                                    endPoint: UnitPoint(x: 0.5, y: 1.46)
                                                )
                                            )
                                            .cornerRadius(16)
                                        VStack(alignment: .leading) {
                                            ZStack(alignment: .leading) {
                                                VStack(alignment: .leading) {
                                                    Text("Jarak Tempuh")
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.white)
                                                    
                                                    Text("\(motorcycles[0].currentMileage ) Km")
                                                        .font(.system(size: 36))
                                                        .italic()
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                        .padding(.bottom, 13)
                                                    HStack {
                                                        
                                                    }
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
                                
                                StatusSparepartView(motorcycle: motorcycles[0], data: convertData(history: motorcycles[0].spareparts ?? []), selectedItem: $selectedItem, showModal: $showModal)
                                
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
                                .frame(width: 357, height: 44, alignment: .center)
                                .background(Color("TabIconColor"))
                                .cornerRadius(11)
                                .sheet(isPresented: $isUpdateModalPresented) {
                                    NavigationView {
                                            ModalUpdateServisView(motorcycle: motorcycles[0])
                                        }
                                }
                            }
                            .padding()
                            .navigationBarTitle("Dashboard")
                        }
                    }
                }
            }
            .onAppear {
                print(motorcycles.count)
            }
        }
        .sheet(isPresented: $showModal) {
            if let selectedItem = selectedItem {
                NavigationView {
                    ModalSparepartView(data: selectedItem)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.2, green: 0.29, blue: 0.3), location: 0.00),
                                    Gradient.Stop(color: .black.opacity(0.9), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.95, y: 0),
                                endPoint: UnitPoint(x: 0.26, y: 0.98)
                            ))
                        .ignoresSafeArea()
                    
                }
            }
        }
    }
    
    func convertData(history: [SparepartHistory]) -> [GaugeData] {
        var gauges = [GaugeData]()
        for data in history {
            var icon = ""
            var checkIntervalInKilometer: Double = 0
            var replaceIntervalInKilometer: Double = 0
            var image = ""
            switch data.sparepartType {
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
                checkIntervalInKilometer = 4000
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
            
            let gauge = GaugeData(
                value: Double(data.motorcycle?.currentMileage ?? 0) - Double(data.lastServiceMileage),
                minimum: 0,
                maximum: replaceIntervalInKilometer,
                iconSparePart: icon,
                labelText: data.name,
                imageSparePart: image,
                status: estimateSparepartStatus(lastServiceMillage: data.lastServiceMileage, currentMillage: data.motorcycle?.currentMileage ?? 0, type: data.sparepartType)
            )
            gauges.append(gauge)
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
    
    var data: [GaugeData]
    @Binding var selectedItem: GaugeData?
    @Binding var showModal: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Spare Part")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(data, id: \.id) { data in
                    Button(action: {
                        self.selectedItem = data
                        self.showModal.toggle()
                    }) {
                        //Gauge View
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.16, green: 0.22, blue: 0.23), location: 0.08),
                                        Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                ))
                                .frame(width: 176, height: 123)
                            
                            HStack {
                                Gauge(value: data.value, in: data.minimum...data.maximum) {
                                    
                                }
                                .gaugeStyle(.accessoryCircularCapacity)
                                .scaleEffect(1.10)
                                .padding(3)
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
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .scaleEffect(0.75)
                                    
                                    HStack(spacing:3) {
                                        Image(systemName: data.status.iconStatus)
                                            .resizable()
                                            .frame(width: 12, height:12)
                                            .foregroundColor(data.status.tintColor)
                                        
                                        Text(data.status.rawValue)
                                            .font(.system(size: 12))
                                            .fontWeight(.semibold)
                                            .foregroundColor(data.status.tintColor)
                                    }
                                    .padding(8)
                                    .frame(height: 20, alignment: .center)
                                    .background(data.status.tintColor.opacity(0.3))
                                    .cornerRadius(22)
                                }
                            }
                        }
                        .onTapGesture {
                            selectedItem = data
                            showModal.toggle()
                        }
                    }
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
    case ganti = "GANTI"
    case periksa = "PERIKSA"
    case aman = "AMAN"
    
    var sparepartStatusValue: String {
        switch self {
        case .ganti:
            return "GANTI"
        case .periksa:
            return "CEK"
        case .aman:
            return "AMAN"
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
        }
    }
}

//#Preview {
//    DashboardView()
//}
