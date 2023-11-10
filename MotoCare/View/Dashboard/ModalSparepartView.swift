////
////  ModalView.swift
////  MotorCareSwiftData
////
////  Created by Nur Hidayatul Fatihah on 31/10/23.
////
//
//import SwiftUI
//
//struct ModalSparepartView: View {
//    let data: SparepartData
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            VStack(alignment: .leading) {
//                Image(data.imageSparePart)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                Text("Status")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                ZStack {
//                    RoundedRectangle(cornerRadius: 14)
//                        .fill(Color(red: 0.12, green: 0.12, blue: 0.12))
//                    VStack(alignment: .leading) {
//                        Text("\(data.labelText) perlu pengecekan")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .padding(.horizontal)
//                            .padding(.top)
//                        Text("1 bulan lagi sampai penggantian")
//                            .font(.title3)
//                            .fontWeight(.medium)
//                            .padding(.horizontal)
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("Diperlukan pengecekan")
//                                    .foregroundStyle(.yellow)
//                                Text("28500/28000Km")
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.yellow)
//                                Spacer()
//                                Text("Butuh penggantian")
//                                Text("32000Km")
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                                Spacer()
//                                Text("Kondisi bagus")
//                                Text("28500/27999Km")
//                                    .font(.title3)
//                                    .fontWeight(.bold)
//                            }
//                            Spacer()
//                            VStack {
//                                Gauge(value: data.value, in: data.minimum...data.maximum) {
//                                }
//                                .gaugeStyle(.accessoryCircular)
//                                .scaleEffect(1.75)
//                                .padding()
//                                .tint(Gradient(colors: [.red, .yellow, .green]))
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
//                            }
//                        }
//                        .padding()
//                    }
//                }
//                .padding(.bottom)
//                Text("Tentang \(data.labelText)")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.bottom)
//                ZStack {
//                    RoundedRectangle(cornerRadius: 14)
//                        .fill(Color("BackColor"))
//                    Text("Oli mesin pada motor adalah cairan pelumas yang melumasi, mendinginkan, membersihkan, dan melindungi mesin dari gesekan dan korosi. Ini penting untuk menjaga kinerja mesin tetap baik dan perlu diganti secara teratur sesuai rekomendasi pabrikan.")
//                        .padding(10)
//                }
//            }
//            .padding()
//            .navigationBarTitle("\(data.labelText)", displayMode: .inline)
//            .navigationBarItems(leading:
//                HStack {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        HStack {
//                            Image(systemName: "chevron.backward")
//                            Text("Back")
//                        }
//                        .accentColor(Color("TabIconColor"))
//                    }
//                }
//        )
//        }
//    }
//}
//
//
//#Preview {
//    ModalSparepartView(data: .init(value: 75.0, minimum: 0.0, maximum: 100.0, iconSparePart: "engine-oil", labelText: "Oli Mesin", imageSparePart: "EngineOilImage"))
//}
