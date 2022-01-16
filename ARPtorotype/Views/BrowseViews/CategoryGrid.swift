//
//  CategoryGrid.swift
//  ARPtorotype
//
//  Created by Kaligula on 08.01.2022.
//

import SwiftUI

struct CategoryGrid: View {
    @Binding var showBrowse: Bool
    @EnvironmentObject var arModelsViewModel: ARModelsViewModel
    
    var body: some View {
        VStack {
            ForEach(ARModelCategory.allCases, id: \.self) { category in
                if let modelsByCategory = arModelsViewModel.arModels.filter({ $0.category == category }) {
                    HorizontalGrid(showBrowse: $showBrowse, title: category.label, items: modelsByCategory)
                }
            }
        }
    }
}

struct CategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGrid(showBrowse: Binding.constant(false))
    }
}
