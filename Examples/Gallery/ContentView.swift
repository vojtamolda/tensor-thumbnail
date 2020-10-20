//
//  ContentView.swift
//  Gallery
//
//  Created by Vojta Molda on 10/27/20.
//

import SwiftUI
import TensorThumbnail
import TensorFraud


struct ContentView: View {

    struct Section {
        var label: String
        var tensors: [Tensor<Float>]
    }
    var sections: [Section] = [
        Section(
            label: "Vector",
            tensors: [
                Tensor<Float>(randomUniform: [1]),
                Tensor<Float>(randomUniform: [5]),
                Tensor<Float>(randomUniform: [10]),
                Tensor<Float>(randomUniform: [50]),
                Tensor<Float>(randomUniform: [75]),
                Tensor<Float>(randomUniform: [100]),
                Tensor<Float>(randomUniform: [1000]),
            ]
        ),
        Section(
            label: "Matrix",
            tensors: [
                Tensor<Float>(randomUniform: [5, 5]),
                Tensor<Float>(randomUniform: [50, 50]),
                Tensor<Float>(randomUniform: [1000, 1000]),
            ]
        ),
        Section(
            label: "Image",
            tensors: [
                Tensor<Float>(randomUniform: [240, 320, 3]),
            ]
        ),
        Section(
            label: "Tensor",
            tensors: [
                Tensor<Float>(randomUniform: [32, 3, 64, 64]),
                Tensor<Float>(randomUniform: [32, 4, 3, 64, 64]),
            ]
        )
    ]

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(sections, id: \.label) { section in
                GroupBox(label: Text(section.label).font(.subheadline)) {
                    HStack {
                        ForEach(section.tensors, id: \.self) { tensor in
                            TensorThumbnail<Float>(tensor: tensor)
                                .padding(5)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
