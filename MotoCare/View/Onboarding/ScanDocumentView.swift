import SwiftUI
import VisionKit
import Vision

extension CharacterSet {
    static var numericCharacters: CharacterSet {
        return CharacterSet(charactersIn: "0123456789")
    }
}

struct ScanDocumentView: UIViewControllerRepresentable {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    let someMotorcycle = Motorcycle(/* berikan parameter yang sesuai */)
    let someDate = Date(/* berikan parameter yang sesuai */)
    let someMileage = 10000 // Berikan nilai mileage yang sesuai
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String // Menggunakan @Binding
    @Binding var extractedText1: String?
    @Binding var extractedText2: String?
    @Binding var extractedText3: String?
    @Binding var extractedText4: String?
    @Binding var extractedText5: String?
    @Binding var extractedText6: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, extractedText1: $extractedText1, extractedText2: $extractedText2, extractedText3: $extractedText3, extractedText4: $extractedText4, extractedText5: $extractedText5, extractedText6: $extractedText6, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var recognizedText: Binding<String>
        var extractedText1: Binding<String?> // Menggunakan @Binding
        var extractedText2: Binding<String?>
        var extractedText3: Binding<String?>
        var extractedText4: Binding<String?>
        var extractedText5: Binding<String?>
        var extractedText6: Binding<String?>
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, extractedText1: Binding<String?>, extractedText2: Binding<String?>, extractedText3: Binding<String?>, extractedText4: Binding<String?>, extractedText5: Binding<String?>, extractedText6: Binding<String?>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.extractedText1 = extractedText1
            self.extractedText2 = extractedText2
            self.extractedText3 = extractedText3
            self.extractedText4 = extractedText4
            self.extractedText5 = extractedText5
            self.extractedText6 = extractedText6
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan, targetIndexes: [0, 1, 2])
            var processedText1 = recognizeAndExtractText1(from: extractedImages, targetText: "Ganti")
            var processedText2 = recognizeAndExtractText2(from: extractedImages, targetText: "Km")
            var processedText3 = recognizeAndExtractText3(from: extractedImages, targetText: "Ganti")
            var processedText4 = recognizeAndExtractText4(from: extractedImages, targetText: "Km")
            var processedText5 = recognizeAndExtractText5(from: extractedImages, targetText: "Ganti")
            var processedText6 = recognizeAndExtractText6(from: extractedImages, targetText: "Km")
            
            // Menghapus "Ganti" dari processedText1
            processedText1 = processedText1.replacingOccurrences(of: "Ganti", with: "")
            processedText3 = processedText3.replacingOccurrences(of: "Ganti", with: "")
            processedText5 = processedText5.replacingOccurrences(of: "Ganti", with: "")
            
            //hapus spasinya
            processedText1 = processedText1.replacingOccurrences(of: " ", with: "")
            processedText3 = processedText3.replacingOccurrences(of: " ", with: "")
            processedText5 = processedText5.replacingOccurrences(of: " ", with: "")
            
            //hapus -
            processedText1 = processedText1.replacingOccurrences(of: "-", with: "")
            processedText3 = processedText3.replacingOccurrences(of: "-", with: "")
            processedText5 = processedText5.replacingOccurrences(of: "-", with: "")
            
            // Mengganti "Oli Gear" dengan "Oli Gardan"
            processedText1 = processedText1.replacingOccurrences(of: "OliGear", with: "OliGardan")
            processedText3 = processedText3.replacingOccurrences(of: "OliGear", with: "OliGardan")
            processedText5 = processedText5.replacingOccurrences(of: "OliGear", with: "OliGardan")
            
            processedText2 = cleanString(processedText2)
            processedText4 = cleanString(processedText4)
            processedText6 = cleanString(processedText6)
            
            if !processedText2.isEmpty {
                print("Before conversion: \(processedText2)")
                if let integerValue = Int(processedText2) {
                    let newData = integerValue - 3100
                    processedText2 = String(newData)
                    print("After conversion: \(processedText2)")
                } else {
                    print("Conversion to integer failed")
                }
            } else {
                print("String is empty")
            }
            
            if !processedText4.isEmpty {
                print("Before conversion: \(processedText4)")
                if let integerValue = Int(processedText4) {
                    let newData = integerValue - 3100
                    processedText4 = String(newData)
                    print("After conversion: \(processedText4)")
                } else {
                    print("Conversion to integer failed")
                }
            } else {
                print("String is empty")
            }
            if !processedText6.isEmpty {
                print("Before conversion: \(processedText6)")
                if let integerValue = Int(processedText6) {
                    let newData = integerValue - 3100
                    processedText6 = String(newData)
                    print("After conversion: \(processedText6)")
                } else {
                    print("Conversion to integer failed")
                }
            } else {
                print("String is empty")
            }
            
            let targetIndexes = [0, 1, 2]
            
            recognizedText.wrappedValue = processedText1 + processedText2 + processedText3 + processedText4 + processedText5 + processedText6
            extractedText1.wrappedValue = processedText1
            self.extractedText2.wrappedValue = processedText2
            extractedText3.wrappedValue = processedText3
            self.extractedText4.wrappedValue = processedText4
            extractedText5.wrappedValue = processedText5
            self.extractedText6.wrappedValue = processedText6
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
        // Fungsi untuk membersihkan string dari karakter non-numeric
        fileprivate func cleanString(_ input: String) -> String {
            return String(input.unicodeScalars.filter { CharacterSet.numericCharacters.contains($0) })
        }
        
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan, targetIndexes: [Int]) -> [CGImage] {
            var extractedImages = [CGImage]()
            
            for index in targetIndexes {
                guard index >= 0 && index < scan.pageCount else { continue }
                
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                
                extractedImages.append(cgImage)
            }
            
            return extractedImages
        }
        
        
        fileprivate func recognizeAndExtractText(from images: [CGImage], targetText: String, targetIndex: Int) -> String {
            var extractedText = ""
            
            // Pastikan bahwa targetIndex tidak melampaui batas indeks gambar yang ada
            guard images.indices.contains(targetIndex) else {
                print("Error: Index \(targetIndex) is out of bounds.")
                return extractedText
            }
            
            let image = images[targetIndex]  // Mengambil gambar dengan indeks targetIndex
            
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(3).first else { continue }
                    
                    let recognizedText = candidate.string
                    if recognizedText.contains(targetText) {
                        extractedText += "\(recognizedText),"
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            try? requestHandler.perform([recognizeTextRequest])
            
            return extractedText
        }
        
        fileprivate func recognizeAndExtractText1(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 0)
        }
        
        fileprivate func recognizeAndExtractText2(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 0)
        }
        
        fileprivate func recognizeAndExtractText3(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 1)
        }
        
        fileprivate func recognizeAndExtractText4(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 1)
        }
        
        fileprivate func recognizeAndExtractText5(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 2)
        }
        
        fileprivate func recognizeAndExtractText6(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 2)
        }
    }
}
