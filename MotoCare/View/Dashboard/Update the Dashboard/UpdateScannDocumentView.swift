//
//  CameraScanUpdatedView.swift
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

struct UpdateScannDocumentView: UIViewControllerRepresentable {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: String
    @Binding var extractedUpdatedText1: String?
    @Binding var UpdatescannedServiceMileage: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, extractedUpdatedText1: $extractedUpdatedText1, UpdatescannedServiceMileage: $UpdatescannedServiceMileage, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var recognizedText: Binding<String>
        var extractedUpdatedText1: Binding<String?>
        var UpdatescannedServiceMileage: Binding<String?>
        var parent: UpdateScannDocumentView
        
        init(recognizedText: Binding<String>, extractedUpdatedText1: Binding<String?>, UpdatescannedServiceMileage: Binding<String?>, parent: UpdateScannDocumentView) {
            self.recognizedText = recognizedText
            self.extractedUpdatedText1 = extractedUpdatedText1
            self.UpdatescannedServiceMileage = UpdatescannedServiceMileage
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan, targetIndexes: [0, 1, 2])
            var processedUpdatedText1 = recognizeAndExtractText1(from: extractedImages, targetText: "Ganti")
            var processedUpdatedText2 = recognizeAndExtractText2(from: extractedImages, targetText: "Km")
            
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: "Ganti", with: "")
            
            //hapus spasinya
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: " ", with: "")
            
            //hapus -
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: "-", with: "")
          
            // Mengganti "Oli Gear" dengan "Oli Gardan"
            processedUpdatedText1 = processedUpdatedText1.replacingOccurrences(of: "OliGear", with: "OliGardan")
           
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
            
//            let targetIndexes = [0]
            
            recognizedText.wrappedValue = processedUpdatedText1 + processedUpdatedText2
            extractedUpdatedText1.wrappedValue = processedUpdatedText1
            self.UpdatescannedServiceMileage.wrappedValue = processedUpdatedText2
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func cleanString(_ input: String) -> String {
            return String(input.unicodeScalars.filter { CharacterSet.numericCharacters1.contains($0) })
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
            var extractedUpdateText = ""
            
            // Pastikan bahwa targetIndex tidak melampaui batas indeks gambar yang ada
            guard images.indices.contains(targetIndex) else {
                print("Error: Index \(targetIndex) is out of bounds.")
                return extractedUpdateText
            }
            
            let image = images[targetIndex]  // Mengambil gambar dengan indeks targetIndex
            
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(3).first else { continue }
                    
                    let recognizedText = candidate.string
                    if recognizedText.contains(targetText) {
                        extractedUpdateText += "\(recognizedText),"
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
            
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            try? requestHandler.perform([recognizeTextRequest])
            
            return extractedUpdateText
        }
        
        fileprivate func recognizeAndExtractText1(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 0)
        }
        
        fileprivate func recognizeAndExtractText2(from images: [CGImage], targetText: String) -> String {
            return recognizeAndExtractText(from: images, targetText: targetText, targetIndex: 0)
        }
    }
}
