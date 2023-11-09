import SwiftUI
import VisionKit
import Vision

struct ScanDocumentView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String // Menggunakan @Binding
    @Binding var extractedText1: String?
    @Binding var extractedText2: String?
    
    func makeCoordinator() -> Coordinator {
           Coordinator(recognizedText: $recognizedText, extractedText1: $extractedText1, extractedText2: $extractedText2, parent: self)
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
            var parent: ScanDocumentView
            
            init(recognizedText: Binding<String>, extractedText1: Binding<String?>, extractedText2: Binding<String?>, parent: ScanDocumentView) {
                self.recognizedText = recognizedText
                self.extractedText1 = extractedText1
                self.extractedText2 = extractedText2
                self.parent = parent
            }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
           let extractedImages = extractImages(from: scan)
           var processedText1 = recognizeAndExtractText1(from: extractedImages, targetText: "Ganti")
           var processedText2 = recognizeAndExtractText2(from: extractedImages, targetText: "km.")

           // Menghapus "Ganti" dari processedText1
           processedText1 = processedText1.replacingOccurrences(of: "Ganti", with: "")
            
            print(processedText1)
//            print(processedText2)

           // Mengganti "Oli Gear" dengan "Oli Gardan"
           processedText1 = processedText1.replacingOccurrences(of: "Oli Gear", with: "Oli Gardan")

           processedText2 = processedText2.replacingOccurrences(of: "km.", with: "")

           recognizedText.wrappedValue = processedText1 + processedText2
           extractedText1.wrappedValue = processedText1
           extractedText2.wrappedValue = processedText2
           parent.presentationMode.wrappedValue.dismiss()
        }


        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
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
    }
}
