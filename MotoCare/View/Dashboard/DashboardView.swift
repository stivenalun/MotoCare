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
    @State private var selectedItem: SparepartData?
    
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
                                                    
                                                    Text("\(motorcycleVM.motorcycle.currentMileage ) Km")
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
                                                        ModalOdometerView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(width: 357, height: 132)
                                }
                                
                                StatusSparepartView(motorcycle: motorcycleVM.motorcycle)
                            }
                            .padding()
                            .navigationBarTitle("Dashboard")
                        }
                    }
                }
            }
        }
    }
}

struct StatusSparepartView : View{
    @Environment(\.modelContext) private var modelContext
    let motorcycle: Motorcycle
    
//    let data = [GaugeData].self
//    @Binding var selectedItem: GaugeData?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Spare Part")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
//                ForEach(data, id: \.value) { data in
//                    Button(action: {
//                        self.selectedItem = data
//                        self.showModal.toggle()
//                    }) {
//                        //Gauge View
//                        ZStack {
//                            Rectangle()
//                                .foregroundColor(.clear)
//                                .frame(width: 176, height: 123)
//                                .background(
//                                    LinearGradient(
//                                        stops: [
//                                            Gradient.Stop(color: Color(red: 0.16, green: 0.22, blue: 0.23), location: 0.08),
//                                            Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
//                                        ],
//                                        startPoint: UnitPoint(x: 0.5, y: 0),
//                                        endPoint: UnitPoint(x: 0.5, y: 1)
//                                    )
//                                )
//                                .cornerRadius(20)
//
//                            VStack {
//                                Gauge(value: data.value, in: data.minimum...data.maximum) {
//                                    
//                                }
//                                .gaugeStyle(.accessoryCircularCapacity)
//                                .scaleEffect(1.75)
//                                .padding()
//                                .overlay {
//                                    Image(data.iconSparePart)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 35, height: 100)
//                                        .cornerRadius(14)
//                                        .foregroundColor(.primary)
//                                }
//                                Text(data.labelText)
//                                    .font(.title3)
//                                    .foregroundColor(.primary)
//                                    .scaleEffect(0.75)
//                                
//                            }
//                        }
//                        .onTapGesture {
//                            selectedItem = data
//                            showModal.toggle()
//                        }
//                    }
//                }
//            }
            
            List(motorcycle.spareparts ?? []) { sparepart in
                Text("\(sparepart.name) -  \(estimateSparepartStatus(lastServiceMillage:sparepart.lastServiceMileage, currentMillage: motorcycle.currentMileage, type: sparepart.sparepartType).rawValue)")
            }
        }
    }
    
    func estimateSparepartStatus(lastServiceMillage: Int, currentMillage: Int, type: SparepartType) -> SparepartStatus {
        let totalMillageFromService = currentMillage - lastServiceMillage
        
        guard var checkIntervalMillage = sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.checkIntervalInKilometer else { return .aman }
        
        guard var replaceIntervalMillage = sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.replaceIntervalInKilometer  else { return .aman }
        
//        print(checkIntervalMillage)
//        print(replaceIntervalMillage)
        
        if totalMillageFromService <= checkIntervalMillage && totalMillageFromService >= replaceIntervalMillage {
            return .periksa
        } else if totalMillageFromService >= replaceIntervalMillage {
            return .ganti
        } else {
            return .aman
        }
    }
}

struct GaugeData {
    var value: Double
    var minimum: Double
    var maximum: Double
    var sparepartName: String
    var iconSparePart: String
    var imageSparePart: String
    var sparepartStatus: SparepartStatus
    
}


//struct GaugeMapper {
//    static func mapGauge(gauge: Sparepart) -> GaugeData {
//        return GaugeData(value: <#T##Double#>, minimum: 0.0, maximum: Double(gauge.replaceIntervalInKilometer), sparepartName: gauge.name, iconSparePart: gauge.icon, imageSparePart: gauge.image, sparepartStatus: <#SparepartStatus#>)
//    }
//}


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
}

    
#Preview {
    DashboardView()
}
