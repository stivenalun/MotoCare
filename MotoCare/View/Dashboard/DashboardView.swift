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
//    @State private var selectedItem: GaugeData?
    
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
                                                    .sheet(isPresented: $isModalPresented) {
                                                        ModalOdometerView()
                                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(width: 357, height: 132)
                                }
                                Text("Status Spare Part")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(.top, 17)
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
    
#Preview {
    DashboardView()
}
