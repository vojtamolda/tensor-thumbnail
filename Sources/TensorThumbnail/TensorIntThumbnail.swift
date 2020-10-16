#if canImport(TensorFlow)
  import TensorFlow
#else
  import TensorFraud
#endif
import SwiftUI


// MARK: Tensor view with integer scalars

struct TensorIntThumbnail<Scalar: TensorFlowScalar>: View where Scalar: BinaryInteger {
    /// Visualized tensor.
    var tensor: Tensor<Scalar>
    /// Switch to treat the first dimension as batch size and effectively ignore it for visualization.
    var batched: Bool = false
    
    /// Visualized tensor with the first dimension omitted if `batched` is enabled.
    var batchedTensor: TensorSlice<Scalar> {
        batched ? tensor[1] : tensor[...]
    }
    /// Shape of the visualized tensor with the first dimension omitted if `batched` is enabled.
    var batchedDimensions: ArraySlice<Int> {
        batched ? tensor.shape[1...] : tensor.shape[0...]
    }
    
    /// Label showing the batch size if `batched` is enabled.
    @ViewBuilder var batchText: some View {
        if batched {
            HStack(spacing: 2) {
                Image(nsImage: NSImage(named: NSImage.listViewTemplateName)!)
                    .scaleEffect(0.8)
                Text("\(tensor.shape[0]) × ")
                    .font(.caption)
            }
        }
    }
    /// Label showing the extra, non-visualized dimension if there are any.
    @ViewBuilder var extraDimensionsText: some View {
        if batchedDimensions.count > 3 {
            Text("× " + batchedDimensions[3...].map { "\($0)" }.joined(separator: " × "))
                .font(.caption)
                .frame(maxWidth: 100)
                .multilineTextAlignment(.center)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            batchText
            
            let start = batchedDimensions.startIndex
            let height = batchedDimensions.count > 0 ? batchedDimensions[start] : nil
            let width = batchedDimensions.count > 1 ? batchedDimensions[start + 1] : nil
            let depth = batchedDimensions.count > 2 ? batchedDimensions[start + 2] : nil
            let preview = batchedTensor.thumbnail()
            PrismView(height: height, width: width, depth: depth, preview: preview)

            extraDimensionsText
        }
    }
}

// MARK: - Thumbnail of tensor data

extension TensorSlice where Scalar: BinaryInteger {
    func normalized() -> [UInt8] {
        let min = scalars.min()!
        let max = scalars.max()!
        let range = Double(max - min)

        if range.magnitude < Double.ulpOfOne {
            return Array(repeating: UInt8.max / 2, count: scalars.count)
        }

        return scalars.map { scalar in
            UInt8(Double(scalar - min) / range * Double(UInt8.max))
        }
    }

    /// Creates a preview image from the first two dimensions of the tensor.
    func thumbnail(range: RangeMode<Scalar> = .standardDeviation()) -> CGImage? {
        if (rank == 0) { return nil }

        let colorSpace = CGColorSpace(name: CGColorSpace.linearGray)!
        let bitmapInfo: CGBitmapInfo = [
            CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
            CGBitmapInfo(rawValue: CGImageByteOrderInfo.orderDefault.rawValue)
        ]
        
        let (height, width) = (rank == 1) ? (shape[0], 1) : (shape[0], shape[1])
        let normalizedScalars = self.normalized()
        guard let dataProvider = CGDataProvider(data: Data(normalizedScalars) as CFData) else {
            return nil
        }
        
        return CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8, bitsPerPixel: 8,
            bytesPerRow: width,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            provider: dataProvider,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
        )
    }
}
