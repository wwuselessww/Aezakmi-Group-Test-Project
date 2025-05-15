//
//  MainPage.swift
//  Aezakmi Group Test Project
//
//  Created by Alexander Kozharin on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PencilKit

struct MainPage:View {
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var vm = MainPageViewModel()
    
    var body: some View {
        
        VStack {
            if let feedback = vm.userFeedbackText  {
                Text(feedback.title)
                    .bold()
                    .foregroundStyle(feedback.isError == false ? .green : .red)
            } else {
                Text("")
                    .foregroundStyle(.clear)
            }
            Spacer()
            if !vm.didTapDrawBtn {
                    if let selection = vm.selection {
                        GeometryReader { geo in
                            Image(uiImage: selection)
                                .resizable()
                                .scaledToFit()
                                
                                .onTapGesture { location in
                                    print(location)
                                    vm.textLocation = location
                                }
                                .onChange(of: vm.didTapAddTextBtn) { oldValue, newValue in
                                    if newValue == false {
                                        vm.addTextToImage(viewSize: geo.size)
                                    }
                                }
                                .frame(minWidth: 200, maxWidth: 400, minHeight: 200, maxHeight: 400)
                        }
                    } else {
                        VStack {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .scaledToFit()
                                .frame(minWidth: 100, maxWidth: 200)
                            Text("Image isn't selected")
                                .bold()
                        }
                    }

                
            } else {
                if let image = vm.selection {
                    ZStack {
                        CanvasView(canvasView: $vm.canvasView, backgroundImage: image)
                    }
                    
                } else {
                    Text("No image was selected")
                }
            }
            
            Spacer()
            if vm.didTapFiltersBtn {
                Slider(value: $vm.filterIntensity)
                    .onChange(of: vm.filterIntensity) { _, newValue in
                        vm.applyProccesing()
                    }
                HStack {
                    ForEach(vm.filtersArray) { filter in
                        
                        Button {
                            vm.setFilter(filter.filter)
                            vm.getImage()
                        } label: {
                            VStack {
                                Text(filter.name)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .withDefaultButtonFormatting(disabled: .constant(false))
                            }
                            .foregroundStyle(.black)
                        }
                    }
                }
            } else if vm.didTapAddTextBtn {
                TextEditor(text: $vm.text, textColor: $vm.textColor, selectedFontSize: $vm.textFontSize)
            }
            HStack(spacing: 30) {
                PhotoEditButton(systemImage: "pencil", title: "draw", disable: .constant(false)) {
                    print("draw")
                    vm.didTapDrawBtn.toggle()
                }
                
                PhotoEditButton(systemImage: "textformat.size", title: "Text", disable: .constant(false)) {
                    withAnimation {
                        vm.didTapAddTextBtn.toggle()
                        //                        vm.addTextToImage()
                    }
                }
                
                PhotoEditButton(systemImage: "camera.filters", title: "filtes", disable: .constant(false)) {
                    withAnimation {
                        vm.didTapFiltersBtn.toggle()
                    }
                }
                
                PhotoEditButton(systemImage: "square.and.arrow.down", title: "save", disable: .constant(false)) {
                    print("save")
                    vm.saveImage()
                }
                
//                PhotoEditButton(systemImage: "square.and.arrow.up", title: "share", disable: .constant(false)) {
//                    print("share")
//                }
                if let image = vm.selection {
                    ShareLink(item: Image(uiImage: image), preview: SharePreview("Eddited Image", image: Image(uiImage: image))) {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(.white)
                                .withDefaultButtonFormatting(disabled: .constant(false))
                                .frame(width: 40, height: 40)
                            Text("Share")
                                .foregroundStyle(.black)
                                .bold()

                        }
                    }
                }
            }
            CroppedPhotosPicker(style: .default, options: vm.cropOptions, selection: $vm.selection) { rect in
                print("did Crop to rect \(rect)")
            } didCancel: {
                print("did cancel")
            } label: {
                Text("Pick and crop Image")
                    .foregroundStyle(.white)
                    .bold()
                    .withDefaultButtonFormatting(disabled: .constant(false))
                
            }
            
            
        }
        .onChange(of: vm.didTapDrawBtn, { oldValue, newValue in
            if newValue == false {
                vm.draw()
            }
        })
        .padding()
    }
}
#Preview {
    MainPage()
        .environmentObject(AppViewModel())
}
