//
//  HorizontalGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct HorizontalGrid: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    private let gridItemLayout = [GridItem(.fixed(150))]
    var title: String
    var items: [ARModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Separator()
            
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading, 20)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count, id: \.self) { index in
                        let model = items[index]
                        
                        ItemButton(model: model) {
                            model.asyncLoadARModelEntity { completed, error in
                                if completed {
                                    placementSettings.selectedModel = model
                                }
                            }
                            showBrowse = false
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
