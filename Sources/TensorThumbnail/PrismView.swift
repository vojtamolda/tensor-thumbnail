import SwiftUI


/// Height (*H*), width (*W*) and depth (*D*) of a tensor visualized as a 3D layered prism with a rectangular base.
public struct PrismView: View {
    var height: Int?
    var width: Int?
    var depth: Int?
    var preview: CGImage?

    // MARK: - Constants

    /// *H/W/D* that gets displayed as `maximumSize` long.
    let threshold: Int = 100
    /// Size of the prism when rendering *H/W/D*  equal to 1.
    let minimumSize: CGFloat = 4
    /// Size of the prism when rendering *H/W/D*  greater or equal to `threshold`.
    let maximumSize: CGFloat = 100

    /// Diagonal offset when rendering layers along the depth dimension.
    let depthStep: CGFloat = 2

    // MARK: - Normalization of dimensions
    
    /// Normalized size of the diagram with respect to `threshold`, `minimumSize` and `maximumSize`.
    var normalizedSize: CGFloat {
        var largest = max(height ?? 0, width ?? 0, depth ?? 0)
        largest = min(largest, threshold)

        let normalized = CGFloat(largest) / CGFloat(threshold)
        return minimumSize + normalized * (maximumSize - minimumSize)
    }

    /// Vertical dimension of the prism.
    var prismHeight: CGFloat {
        guard let height = height else { return minimumSize }

        let largest = max(height, width ?? 0, depth ?? 0)
        let proportionalHeight = CGFloat(height) / CGFloat(largest) * normalizedSize
        return max(proportionalHeight, minimumSize)
    }
    /// Horizontal dimension of the prism.
    var prismWidth: CGFloat {
        guard let width = width else { return minimumSize }

        let largest = max(height ?? 0, width, depth ?? 0)
        let proportionalWidth = CGFloat(width) / CGFloat(largest) * normalizedSize
        return max(proportionalWidth, minimumSize)
    }
    /// Number of prism layers displayed in the depth dimension.
    var prismDepth: Int {
        guard let depth = depth else { return 1 }
        if depth <= 3 { return depth }

        let largest = max(height ?? 0, width ?? 0, depth)
        let diagonalStep = sqrt(2.0) * depthStep * 2
        
        if depth == largest {
            return Int(maximumSize / diagonalStep)
        } else {
            let proportionalDepth = Int(CGFloat(depth) / CGFloat(largest)
                                        * normalizedSize / diagonalStep)
            return max(proportionalDepth, 3)
        }
    }
    
    // MARK: - Dimension labels

    /// Label of the horizontal dimension.
    @ViewBuilder var widthText: some View {
        if let width = self.width {
            Text(String(width))
                .font(.caption)
                .alignmentGuide(.horizontalCenter) { $0[HorizontalAlignment.center] }
        }
    }
    /// Label of the vertical dimension.
    @ViewBuilder var heightText: some View {
        if let height = self.height {
            Text(String(height))
                .font(.caption)
                .rotationEffect(.degrees(-90))
                .fixedSize()
                .frame(width: 15, height: 10)
                .alignmentGuide(.verticalCenter) { $0[VerticalAlignment.center] }
        }
    }
    /// Label of the depth dimension.
    @ViewBuilder var depthText: some View {
        if let depth = self.depth {
            Text(String(depth))
                .font(.caption)
                .rotationEffect(.degrees(45))
                .offset(x: 2, y: 2)
                .frame(width: nil, height: nil,
                       alignment: Alignment(horizontal: .center,
                                            vertical: .bottom))
                .alignmentGuide(HorizontalAlignment.trailing) { _ in
                    CGFloat(prismDepth) * depthStep / 2
                }
                .alignmentGuide(VerticalAlignment.top) { _ in
                    -CGFloat(prismDepth) * depthStep / 2
                }
        }
    }
    /// Preview of the tensor data.
    @ViewBuilder var previewImage: some View {
        if let preview = self.preview {
            let size = NSSize(width: preview.width, height: preview.height)
            let image = NSImage(cgImage: preview, size: size)
            Image(nsImage: image)
                .resizable()
                .interpolation(.none)
                .frame(width: prismWidth, height: prismHeight)
                .aspectRatio(contentMode: .fill)
                .border(Color.secondary, width: 1)
        }
    }

    // MARK: - Public API methods

    public var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(alignment: .horizontalCenter, spacing: 0) {
                widthText

                HStack(alignment: .verticalCenter, spacing: 0) {
                    heightText
                    
                    ZStack(alignment: .topTrailing) {
                        ForEach(0..<prismDepth) { i in
                            let offset = CGFloat(prismDepth - i - 1) * depthStep
                            Rectangle()
                                .fill(Color.gray)
                                .border(Color.secondary, width: 1)
                                .frame(width: prismWidth, height: prismHeight,
                                       alignment: .topLeading)
                                .offset(x: offset, y: offset)
                        }
                        previewImage
                    }
                    .alignmentGuide(.horizontalCenter) { $0[HorizontalAlignment.center] }
                    .alignmentGuide(.verticalCenter) { $0[VerticalAlignment.center] }
                    .padding(.bottom, CGFloat(prismDepth - 1) * depthStep)
                    .padding(.trailing, CGFloat(prismDepth - 1) * depthStep)
                }
            }
            depthText
        }
    }

    /// Height (*H*), width (*W*) and depth (*D*) of a tensor visualized as a 3D layered prism with a rectangular base.
    ///
    /// - Parameters:
    ///   - height: Vertical dimension of the tensor.
    ///   - width: Horizontal dimension of the tensor.
    ///   - depth: Depth-stacked dimension of the tensor.
    ///   - preview: Image that previews tensor data.
    public init(height: Int? = nil, width: Int? = nil, depth: Int? = nil, preview: CGImage? = nil) {
        self.height = height
        self.width = width
        self.depth = depth
        self.preview = preview
    }
}
