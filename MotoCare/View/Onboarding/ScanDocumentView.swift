import SwiftUI
import VisionKit
import Vision

extension CharacterSet {
    static var numericCharacters: CharacterSet {
        return CharacterSet(charactersIn: "0123456789")
    }
}

struct ScanDocumentView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String // Menggunakan @Binding
    @Binding var extractedText1: String?
    @Binding var extractedText2: String?
    @Binding var extractedText3: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, extractedText1: $extractedText1, extractedText2: $extractedText2, extractedText3: $extractedText3, parent: self)
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
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, extractedText1: Binding<String?>, extractedText2: Binding<String?>, extractedText3: Binding<String?>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.extractedText1 = extractedText1
            self.extractedText2 = extractedText2
            self.extractedText3 = extractedText3
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            var processedText1 = recognizeAndExtractText1(from: extractedImages, targetText: "Ganti")
            var processedText2 = recognizeAndExtractText2(from: extractedImages, targetText: "km.")
            var processedText3 = recognizeAndExtractText3(from: extractedImages, targetText: "Ganti")
            
            // Menghapus "Ganti" dari processedText1
            processedText1 = processedText1.replacingOccurrences(of: "Ganti", with: "")
            processedText3 = processedText3.replacingOccurrences(of: "Ganti", with: "")
            
            // Mengganti "Oli Gear" dengan "Oli Gardan"
            processedText1 = processedText1.replacingOccurrences(of: "Oli Gear", with: "Oli Gardan")
            processedText3 = processedText3.replacingOccurrences(of: "Oli Gear", with: "Oli Gardan")
            
            processedText2 = cleanString(processedText2)
        
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
            recognizedText.wrappedValue = processedText1 + processedText2 + processedText3
            extractedText1.wrappedValue = processedText1
            self.extractedText2.wrappedValue = processedText2
//            extractedText2.wrappedValue = processedText2
            extractedText3.wrappedValue = processedText3
            parent.presentationMode.wrappedValue.dismiss()
        }
        

        // Fungsi untuk membersihkan string dari karakter non-numeric
               fileprivate func cleanString(_ input: String) -> String {
                   return String(input.unicodeScalars.filter { CharacterSet.numericCharacters.contains($0) })
               }
        
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            print(scan.pageCount)
            for index in 0..<scan.pageCount {
                
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
        fileprivate func recognizeAndExtractText1(from images: [CGImage], targetText: String) -> String {
            var extractedText1 = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
            
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(3).first else { continue }
                    
                    let recognizedText = candidate.string
                    if recognizedText.contains(targetText) {

                        extractedText1 += "\(recognizedText),"
                        
                        
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return extractedText1
        }
        
        fileprivate func recognizeAndExtractText2(from images: [CGImage], targetText: String) -> String {
            var extractedText2 = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(3).first else { continue }
                    
                    let recognizedText = candidate.string
                    if recognizedText.contains(targetText) {
                        extractedText2 += "\(recognizedText)"
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return extractedText2
        }
        
        fileprivate func recognizeAndExtractText3(from images: [CGImage], targetText: String) -> String {
            var extractedText3 = ""
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(3).first else { continue }
                    
                    let recognizedText = candidate.string
                    if recognizedText.contains(targetText) {
                        extractedText3 += "\(recognizedText),"
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return extractedText3
        }
    }
}
