//
//  AddView.swift
//  RememberMe
//
//  Created by Anthony You on 14/03/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var usersViewModel: UsersViewModel
        
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var inputName = ""
    @State private var placeName = ""
    
    @State private var isFormValid = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if image != nil {
                        image!
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                self.showingImagePicker = true
                            }
                        
                    } else {
                        Button(action: {
                            self.showingImagePicker = true
                        }, label: {
                            HStack {
                                Image(systemName: "camera")
                                Text("Take a picture")
                            }
                        })
                    }
                }
                Section(header: Text("Contact information")) {
                    TextField("Contact name", text: $inputName)
                    TextField("Place where you met", text: $placeName)
                }
            }
            .padding()
            .navigationTitle("Add contact")
            .navigationBarItems(trailing: Button("Save") {
                self.checkValidation()
                
                if self.isFormValid {
                    let annotation = CodableMKPointAnnotation()
                    if let location = locationFetcher.lastKnownLocation {
                        annotation.coordinate = location
                        annotation.title = self.placeName
                    }
                    let user = User(id: UUID(), name: inputName, photo: UUID(), annotation: annotation)
                    self.usersViewModel.users.append(user)
                    self.savePhoto(with: user.photo)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    isShowingAlert = true
                }
            })
            .onAppear(perform: {
                self.locationFetcher.start()
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: self.$inputImage)
            })
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: Photo Management
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func savePhoto(with uuid: UUID) {
        if let inputImage = inputImage {
            FileManager.default.savePhoto(inputImage, withName: uuid.uuidString)
        }
    }
    
    // MARK: Handle Form Validations
    
    func checkValidation() {
        if (!inputName.isEmpty) && (!placeName.isEmpty) && (inputImage != nil) {
            isFormValid = true
        } else if inputName.isEmpty {
            alertTitle = "Name is empty"
            alertMessage = "You must provide a name."
        } else if image == nil {
            alertTitle = "Photo is missing"
            alertMessage = "You must provide a photo."
        } else if placeName.isEmpty {
            alertTitle = "Place name is empty"
            alertMessage = "You must provide a place name."
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(usersViewModel: UsersViewModel())
    }
}
