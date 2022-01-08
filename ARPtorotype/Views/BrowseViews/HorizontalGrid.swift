//
//  HorizontalGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct HorizontalGrid: View {
    
    private let gridItemLayout = [GridItem(.fixed(150))]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(.title2)
                .bold()
                .padding(.leading, 20)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<5) { index in
                        Color(UIColor.secondarySystemFill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct HorizontalGrid_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalGrid()
    }
}
