//
//  DesignDetectiveView.swift
//  
//
//  Created by Enes Karaosman on 11.03.2021.
//

import SwiftUI

internal struct DesignDetectiveView: View {
    
    let backImage: UIImage
    @ObservedObject var viewModel = DesignDetectiveViewModel.shared
    @State private var globalPosition: CGPoint = .zero
    
    init(backImage: UIImage) {
        self.backImage = backImage
    }
    
    @ViewBuilder public var body: some View {
        if let image = viewModel.image {
            GeometryReader { gr in
                ZStack(alignment: .bottomTrailing) {
                    
                    Image(uiImage: backImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: gr.size.width, alignment: .center)
                        .mask(
                            BottomRightClipper(
                                right: gr.size.width - globalPosition.x,
                                bottom: gr.size.height - globalPosition.y
                            )
                        )
                        .onTapGesture(count: 2) {
                            viewModel.image = nil
                        }
                    
                    BottomRightCursor(
                        onChanged: { changed in
                            globalPosition = changed
                        },
                        onEnded: { ended in
                            flushState(in: gr.size)
                        }
                    )
                    
                }
                .onAppear { flushState(in: gr.size) }
            }
            .edgesIgnoringSafeArea(.all)
        } else {
            emptyScreenView()
        }
    }
    
    func flushState(in size: CGSize) {
        globalPosition = .init(x: size.width, y: size.height)
    }
    
    func emptyScreenView() -> some View {
        GeometryReader { gr in
            VStack {
                Button("Copy image URL to the clipboard of device then tap here!") {
                    if let url = UIPasteboard.general.url {
                        print(url)
                        viewModel.getImagefromURL(url)
                    } else {
                        print("No URL copied")
                    }
                }.padding()
                Divider()
                pickImage
                ImagePicker(sourceType: self.imagePickerSourceType) { image in
                    if image != nil {
                        DispatchQueue.main.async {
                            self.viewModel.image = image
                        }
                    }
                    self.showImagePicker = false
                }
                .frame(height: gr.size.height * 0.8)
            }
        }
    }
    
    @State private var showImagePicker = false
    @State private var imagePickerSourceType = UIImagePickerController.SourceType.photoLibrary
    
    private var pickImage: some View {
        HStack {
            Text("Or select an image from photos").font(.footnote)
            Spacer()
            Image(systemName: "photo").imageScale(.large).foregroundColor(.accentColor).onTapGesture {
                self.imagePickerSourceType = .photoLibrary
                self.showImagePicker = true
            }.padding(.horizontal)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Image(systemName: "camera").imageScale(.large).foregroundColor(.accentColor).onTapGesture {
                    self.imagePickerSourceType = .camera
                    self.showImagePicker = true
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: self.imagePickerSourceType) { image in
                if image != nil {
                    DispatchQueue.main.async {
                        self.viewModel.image = image
                    }
                }
                self.showImagePicker = false
            }
        }
    }
    
}
