//
//  CameraScanUpdated.swift
//  MotoCare
//
//  Created by Anita Saragih on 13/11/23.
//

import SwiftUI
import VisionKit
import Vision

extension CharacterSet {
    static var numericCharacters1: CharacterSet {
        return CharacterSet(charactersIn: "0123456789")
    }
}

struct CameraScanUpdatedView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedTextUpdate: String // Menggunakan @Binding
    @Binding var extractedUpdatedText1: String?
    @Binding var extractedUpdatedText2: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedTextUpdate: $recognizedTextUpdate, extractedUpdatedText1: $extractedUpdatedText1, extractedUpdatedText2: $extractedUpdatedText2, parent: self)
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
        var recognizedTextUpdate: Binding<String>
        var extractedUpdatedText1: Binding<String?> // Menggunakan @Binding
        var extractedUpdatedText2: Binding<String?>
        var parent: CameraScanUpdatedView
        
        init(recognizedTextUpdate: Binding<String>, extractedUpdatedText1: Binding<String?>, extractedUpdatedText2: Binding<String?>, parent: CameraScanUpdatedView) {
            self.recognizedTextUpdate = recognizedTextUpdate
            self.extractedUpdatedText1 = extractedUpdatedText1
            self.extractedUpdatedText2 = extractedUpdatedText2
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan, targetIndexes: [0, 1, 2])
            var processedUpdatedText1 = recognizeAndExtractText1(from: extractedImages, targetText: "Ganti")
            var processedUpdatedText2 = recognizeAndExtractText2(from: extractedImages, targetText: "km.")
            
            // Menghapus "Ganti" dari processedText1
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: "Ganti", with: "")
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: "Oli Gear", with: "Oli Gardan")
            processedUpdatedText2 = cleanString(processedUpdatedText2)
            
            if !processedUpdatedText2.isEmpty {
                print("Before conversion: \(processedUpdatedText2)")
                if let integerValue = Int(processedUpdatedText2) {
                    let newData = integerValue - 3100
                    processedUpdatedText2 = String(newData)
                    print("After conversion: \(processedUpdatedText2)")
                } else {
                    print("Conversion to integer failed")
                }
            } else {
                print("String is empty")
            }
            
            let targetIndexes = [0]
            
            recognizedTextUpdate.wrappedValue = processedUpdatedText1 + processedUpdatedText2
            extractedUpdatedText1.wrappedValue = processedUpdatedText1
            self.extractedUpdatedText2.wrappedValue = processedUpdatedText2
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
    }
}
