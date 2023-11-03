import SwiftUI

struct ScanResultView: View {
    @State private var text = ""
    @Binding var extractedText: String?
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack{
                    Text("Hampir Selesai!")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .frame(width: 355, height: 50, alignment: .topLeading)
                    
                    Text("Ini nih hasil scan riwayat servismu.")
                        .font(.system(size: 17))
                        .frame(width: 360, height: 80, alignment: .topLeading)
                    
                    Text("Riwayat Servis 1*")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    HStack{
                        Text("Jarak Tempuh")
                            .font(.system(size: 16))
                        TextField("xxx kilometer", text: $text)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 0)
                    .frame(width: 390, height: 40, alignment: .topLeading)
                    
                    Text("Perbaikan")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    HStack {
                        if let extractedText = extractedText {
                            let data = extractedText.components(separatedBy: ",")
                            ForEach(data, id: \.self) { item in
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(width: .infinity, height: 34, alignment: .center)
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
                    .padding(.top, 330)
                }
            }
        }
    }
}


#Preview {
    ScanResultView(extractedText: .constant(""))
}
