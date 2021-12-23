//
//  PhotoPicker.swift
//  AppFoundation
//
//  Created by Tatsuya Tanaka on 2021/12/01.
//

import SwiftUI
import Photos
import PhotosUI

public struct PhotoPicker: UIViewControllerRepresentable {
    @Binding private var isPresented: Bool
    let configuration: PHPickerConfiguration
    let onCompletion: ([PHPickerResult]) -> Void
    
    public init(
        isPresented: Binding<Bool>,
        configuration: PHPickerConfiguration,
        onCompletion: @escaping ([PHPickerResult]) -> Void
    ) {
        self._isPresented = isPresented
        self.configuration = configuration
        self.onCompletion = onCompletion
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public final class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.onCompletion(results)
            parent.isPresented = false
        }
    }
}

public extension PHPickerResult {
    func load(type: UTType) async throws -> URL? {
        guard itemProvider.hasItemConformingToTypeIdentifier(type.identifier) else {
            return nil
        }
        return try await withCheckedThrowingContinuation { continuation in
            itemProvider.loadFileRepresentation(forTypeIdentifier: type.identifier) { url, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url {
                    let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(url.lastPathComponent)
                    try? FileManager.default.removeItem(at: tmpURL)
                    try? FileManager.default.moveItem(at: url, to: tmpURL)
                    continuation.resume(returning: tmpURL)
                } else {
                    assertionFailure("unreachable")
                }
            }
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker(isPresented: .constant(true), configuration: .init(), onCompletion: { _ in })
    }
}
