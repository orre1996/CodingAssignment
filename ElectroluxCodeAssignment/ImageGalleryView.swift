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
    
    let singlePadding: CGFloat = 8.0
    
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
                })
                
            }
            .padding(EdgeInsets(top: singlePadding,
                                leading: singlePadding,
                                bottom: singlePadding, trailing: 8))
            .background(Color.white)
            .cornerRadius(singlePadding)
                
                
                Button(action: {
                    //TODO: Cancel search - Oscar B. 3/7-21
                }) {
                    Text("Cancel")
                }
                .padding(.horizontal, singlePadding * 2)
                .frame(height: singlePadding * 8,
                       alignment: .center)
            }
        }
        .padding(EdgeInsets(top: singlePadding,
                            leading: singlePadding * 2,
                            bottom: singlePadding,
                            trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: singlePadding * 8)
        .background(Color.searchFieldBackground)
    }
    
    private var photoGrid: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 0) {
                ForEach(0..<viewModel.images.count, id: \.self) { index in
                    
                    GeometryReader { reader in
                        ZStack {
                            Color.gridPhotoColor.padding(singlePadding * 2)
                        }
                        .frame(width: reader.size.width,
                               height: reader.size.width)
                    }
                    .frame(width: UIScreen.main.bounds.width / 2,
                           height: UIScreen.main.bounds.width / 2)
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
