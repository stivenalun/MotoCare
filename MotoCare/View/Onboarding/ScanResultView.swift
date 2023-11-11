import SwiftUI

struct ScanResultView: View {
    @State private var text = ""
    @Binding var extractedText1: String?
    @Binding var extractedText2: String?
    @Binding var extractedText3: String?
    @Binding var extractedText4: String?
    @Binding var extractedText5: String?
    @Binding var extractedText6: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hampir Selesai!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Ini nih hasil scan riwayat servismu.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                
                // Riwayat Servis 1
                VStack(alignment: .leading, spacing: 10) {
                    Text("Riwayat Servis 1")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedText2 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedText2 ?? "") {
                                   let newDistance = distance - 3100
                                   extractedText2 = String(newDistance)
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
                .frame(width: 300)
                
                // Perbaikan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perbaikan")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    HStack{
                        if let extractedText1 = extractedText1 {
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
                    }
                }
                .padding(20)
                
                // Riwayat Servis 2
                VStack(alignment: .leading, spacing: 10) {
                    Text("Riwayat Servis 2")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedText4 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedText4 ?? "") {
                                   let newDistance = distance - 3100
                                   extractedText4 = String(newDistance)
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
                .frame(width: 300)
                
                // Perbaikan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perbaikan")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    HStack{
                        if let extractedText3 = extractedText3 {
                            let data = extractedText3.components(separatedBy: ",")
                            
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
                    }
                }
                .padding(20)
                
                // Riwayat Servis 3
                VStack(alignment: .leading, spacing: 10) {
                    Text("Riwayat Servis 3")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedText6 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedText6 ?? "") {
                                   let newDistance = distance - 3100
                                   extractedText6 = String(newDistance)
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
                .frame(width: 300)
                
                // Perbaikan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perbaikan")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    HStack{
                        if let extractedText5 = extractedText5 {
                            let data = extractedText5.components(separatedBy: ",")
                            
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
                    }
                }
                .padding(20)
                
                // Tombol Selesai
                NavigationLink(destination: FinishOnboardingView()) {
                    Text("Selesai")
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
struct ScanResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScanResultView(
            extractedText1: .constant(""),
            extractedText2: .constant(""),
            extractedText3: .constant(""),
            extractedText4: .constant(""),
            extractedText5: .constant(""),
            extractedText6: .constant("")
        )
    }
}
