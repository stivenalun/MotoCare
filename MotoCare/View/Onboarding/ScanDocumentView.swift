import SwiftUI
import VisionKit
import Vision

struct ScanDocumentView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String // Menggunakan @Binding
    @Binding var extractedText: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, extractedText: $extractedText, parent: self)
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
        var extractedText: Binding<String?> // Menggunakan @Binding
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, extractedText: Binding<String?>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.extractedText = extractedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            let processedText = recognizeAndExtractText(from: extractedImages, targetText: "Ganti")
            
            recognizedText.wrappedValue = processedText
            extractedText.wrappedValue = processedText // Menyimpan hasil ke extractedText
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
        
        fileprivate func recognizeAndExtractText(from images: [CGImage], targetText: String) -> String {
            var extractedText = ""
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
            
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                try? requestHandler.perform([recognizeTextRequest])
            }
            
            return extractedText
        }
    }
}
