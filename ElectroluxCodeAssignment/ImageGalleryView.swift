//
//  ContentView.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import SwiftUI

struct ImageGalleryView: View {
    
    @StateObject var viewModel = ImageGalleryViewModel()
    
    @State var currentSearchInput = ""
    @State var isEditing = false
    @State var selectedPhotoIndex: Int? = nil
    
    let singlePadding: CGFloat = Constants.singlePadding
    
    private let gridLayout = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            Color.photosGridBackground
            
            VStack(spacing: 0) {
                headerView
                
                searchView
                
                photoGrid
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.getFlickrImages()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Error"),
                  message: Text("Couldn´t find images for the typed keyword, try something else"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    private var headerView: some View {
        ZStack {
            HStack {
                
                Spacer()
                
                Button(action: {
                    //TODO: Save selected image - Oscar B. 3/7-21
                }) {
                    Text("Save")
                }
            }
            
            Text("Flickr Photos")
                .foregroundColor(Color.black)
        }
        .padding(EdgeInsets(top: singlePadding * 4,
                            leading: singlePadding * 2,
                            bottom: 0,
                            trailing: singlePadding * 2))
        .frame(maxWidth: .infinity, maxHeight: singlePadding * 10)
        .background(Color.white)
    }
    
    private var searchView: some View {
        
        ZStack {
            HStack(spacing: 0) {
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                
                TextField("Search", text: $currentSearchInput, onEditingChanged: { isEditing in
                    self.isEditing = isEditing
                }, onCommit: {
                    viewModel.getFlickrImages(searchWord: currentSearchInput)
                })
                
            }
            .padding(EdgeInsets(top: singlePadding,
                                leading: singlePadding,
                                bottom: singlePadding,
                                trailing: singlePadding * 2))
            .background(Color.white)
            .cornerRadius(singlePadding)
                
                
                if isEditing {
                Button(action: {
                    isEditing = false
                    endTextEditing()
                }) {
                    Text("Cancel")
                }
                .padding(.leading, singlePadding * 2)
                .frame(height: singlePadding * 8,
                       alignment: .center)
                }
            }
        }
        .padding(EdgeInsets(top: singlePadding,
                            leading: singlePadding * 2,
                            bottom: singlePadding,
                            trailing: singlePadding * 2))
        .frame(maxWidth: .infinity, maxHeight: singlePadding * 8)
        .background(Color.searchFieldBackground)
    }
    
    private var photoGrid: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 0) {
                ForEach(0..<(viewModel.flickrPhotoResponse?.photos?.photo?.count ?? 0), id: \.self) { index in
                    
                    GridPhoto(image: viewModel.getImage(at: index),
                                   isHighlighted: selectedPhotoIndex == index,
                                   photoSelected: {
                                    selectedPhotoIndex = index
                                   })
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView()
    }
}
