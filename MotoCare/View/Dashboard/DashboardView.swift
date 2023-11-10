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
    @Query var motorcycles: [Motorcycle]
    
    enum GaugeCategory {
        case needReplacement
        case checkingRequired
        case safeToGo
    }

//    @State var motorMileageNumber: Int
    @State private var showModal = false
    @State private var isModalPresented = false
    @State private var selectedItem: GaugeData?

    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
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
//                                        RoundedRectangle(cornerRadius: 14)
//                                            .fill(.white)
//                                            .frame(width: 330, height: 104)
//                                            .onTapGesture {
//                                                isModalPresented = true
//                                            }
                                        VStack(alignment: .leading) {
                                            Text("Jarak Tempuh")
                                                .font(.system(size: 13))
                                                .foregroundColor(.white)
                                                
                                            
                                            Text("\(motorcycles.first?.currentMileage ?? 0) Km")
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
                                        }
                                    }
                                }
                            }
                            .frame(width: 357, height: 132)
                        }
                        
                        SectionView(title: "Rekomendasi Penggantian", data: filterData(category: .needReplacement), showModal: $showModal, selectedItem: $selectedItem)
                        SectionView(title: "Rekomendasi Pengecekan", data: filterData(category: .checkingRequired), showModal: $showModal, selectedItem: $selectedItem)
                        SectionView(title: "Kondisi Bagus", data: filterData(category: .safeToGo), showModal: $showModal, selectedItem: $selectedItem)
                    }
                }
                .padding()
                .navigationBarTitle("Dashboard")
                
            }
            .sheet(isPresented: $showModal) {
                if let selectedItem = selectedItem {
                    NavigationView {
                        ModalSparepartView(data: selectedItem)
                            .padding()
                            .background(Color.black.edgesIgnoringSafeArea(.all))
                            .presentationDragIndicator(.visible)
                    }
                    
                }
            }
        }
    }

    func filterData(category: GaugeCategory) -> [GaugeData] {
       // Define your gauge data and filter it based on the category
       return gaugeData.filter { data in
           switch category {
           case .needReplacement:
               return data.value <= (data.maximum / 2) && data.value < data.maximum && data.color == .red
           case .checkingRequired:
               return data.value >= (data.maximum / 2) && data.value < data.maximum && data.color == .yellow
           case .safeToGo:
               return data.value >= data.maximum && data.color == .green
           }
       }
    }
}

struct SectionView: View {
    let title: String
    let data: [GaugeData]
    @Binding var showModal: Bool
    @Binding var selectedItem: GaugeData?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(data, id: \.value) { data in
                    Button(action: {
                        self.selectedItem = data
                        self.showModal.toggle()
                    }) {
                        //Gauge View
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                                            .fill(Color(red: 0.12, green: 0.12, blue: 0.12))
                                                            .frame(width: 172, height: 172)

                            VStack {
                                Gauge(value: data.value, in: data.minimum...data.maximum) {
                                    
                                }
                                .gaugeStyle(.accessoryCircular)
                                .scaleEffect(1.75)
                                .padding()
                                .tint(getGaugeColor(data: data))
                                .overlay {
                                    Image(data.iconSparePart)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 100)
                                        .cornerRadius(14)
                                        .foregroundColor(.primary)
                                }
                                Text(data.labelText)
                                    .font(.title3)
                                    .foregroundColor(.primary)
                                    .scaleEffect(0.75)
                                
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
    }
}

enum ColorCategory {
    case red
    case yellow
    case green
}

struct GaugeData {
   var value: Double
   var minimum: Double
   var maximum: Double
   var iconSparePart: String
   var labelText: String
   var imageSparePart: String
   var color: ColorCategory
}



let gaugeData: [GaugeData] = [
    GaugeData(value: 150.0, minimum: 0.0, maximum: 100.0, iconSparePart: "engine-oil", labelText: "Oli Mesin", imageSparePart: "EngineOilImage", color: .green),
    GaugeData(value: 40.0, minimum: 0.0, maximum: 100.0, iconSparePart: "spark-plug", labelText: "Busi", imageSparePart: "SparkPlugImage", color: .red),
    GaugeData(value: 50.0, minimum: 0.0, maximum: 100.0, iconSparePart: "air-filter", labelText: "Air Filter", imageSparePart: "AirFilterImage", color: .yellow),
    GaugeData(value: 120.0, minimum: 0.0, maximum: 100.0, iconSparePart: "final-drive-oil", labelText: "Oli Gear", imageSparePart: "FinalDriveOilImage", color: .green),
    GaugeData(value: 10.0, minimum: 0.0, maximum: 100.0, iconSparePart: "v-belt", labelText: "V-Belt", imageSparePart: "VBeltImage", color: .red)
]

func getGaugeColor(data: GaugeData) -> Color {
//       let percentage = (data.value - data.minimum) / (data.maximum - data.minimum)

    switch data.color {
    case .red:
        return Color.red
    case .yellow:
        return Color.yellow
    case .green:
        return Color.green
    default:
        return Color.blue
    }
   }

    
#Preview {
    DashboardView()
}
