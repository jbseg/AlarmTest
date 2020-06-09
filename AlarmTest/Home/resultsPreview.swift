//
//  resultsPreview.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/1/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct resultsPreview: View {
    let images: [String] = ["marilyn", "barack", "silhouette","marilyn", "barack", "silhouette","marilyn", "barack", "silhouette","marilyn", "barack", "silhouette"]
    @State var detailsOpen = false
    var body: some View {
        
        VStack(alignment: .leading){
            ScrollView(.horizontal){
                HStack(spacing: 3){
                    ForEach(images, id: \.self) { image_name in
                        Image(image_name).resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .cornerRadius(100)
                    }
                }
                
            }
            NavigationLink(destination: Text("results are here"), isActive: self.$detailsOpen) {
                Text("Result Details")
            }
        }
    }
}

struct resultsPreview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            resultsPreview()
        }
    }
}
