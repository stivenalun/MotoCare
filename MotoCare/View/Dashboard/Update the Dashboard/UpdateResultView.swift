//
//  UpdateResultView.swift
//  MotoCare
//
//  Created by Anita Saragih on 13/11/23.
//

import SwiftUI

struct UpdateResultView: View {
    @State private var text = ""
    @Binding var extractedUpdatedText1: String?
    @Binding var extractedUpdatedText2: String?
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Update Selesai!")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .frame(width: 355, height: 30, alignment: .topLeading)
                
                Text("Ini dia yang sudah kamu servis.")
                    .font(.system(size: 17))
                    .frame(width: 355, height: 50, alignment: .topLeading)
                
                // Riwayat Servis 1
                VStack(alignment: .leading, spacing: 10) {
                    Text("Servis")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedUpdatedText2 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedUpdatedText2 ?? "") {
                                    let newDistance = distance - 3100
                                    extractedUpdatedText2 = String(newDistance)
                                } else {
                                    print("Invalid input")
                                }
                            }
                        ))
                        .foregroundColor(.white)
                        .font(.body)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .frame(width: 300, height: 50)
                
                // Perbaikan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perbaikan")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    HStack{
                        if let extractedText1 = extractedUpdatedText1 {
                            let data = extractedText1.components(separatedBy: ",")
                            
                            ForEach(data, id: \.self) { item in
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 0.94, blue: 0.71))
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .inset(by: 0.5)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    } .padding(20)
                }
                .padding(20)
                
                // Tombol Selesai
                NavigationLink(destination: FinishOnboardingView()) {
                    Text("Yeay Selesai")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 335, height: 55)
                        .background(Color(red: 1, green: 0.83, blue: 0.15))
                        .cornerRadius(25)
                }
            }
            .padding()
        }
    }
}

// Preview
struct UpdateResultView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateResultView(
            extractedUpdatedText1: .constant(""),
            extractedUpdatedText2: .constant("")
        )
    }
}
