//
//  PhotosGridCard.swift
//  ElectroluxCodeAssignment
//
//  Created by Oscar Berggren on 2021-07-03.
//

import SwiftUI

struct GridPhoto: View {
    
    let image: UIImage?
    let isHighlighted: Bool
    var photoSelected: () -> () = { }
    
    var body: some View {
        
        GeometryReader { reader in
            ZStack {
                
                ZStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color.gridPhotoColor)
                .padding(Constants.singlePadding)
            }
            .background(isHighlighted ? Color.photoHighlight : Color.photosGridBackground)
            .frame(width: reader.size.width,
                   height: reader.size.width)
        }
        .frame(width: UIScreen.main.bounds.width / 2,
               height: UIScreen.main.bounds.width / 2)
        .onTapGesture {
            photoSelected()
        }
    }
}
