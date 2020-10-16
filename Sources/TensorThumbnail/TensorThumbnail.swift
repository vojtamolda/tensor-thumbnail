#if canImport(TensorFlow)
import TensorFlow
#else
import TensorFraud
#endif
import SwiftUI


/// TODO: Docs
///
/// - Remark:
///  I wasn't able to remove the duplication in `TensorFloatThumbnail` and `TensorIntThumbnail`. Any suggestions for
///  doing this are welcome. The problem is the division operation for `Int`s and `Float`s. It uses the same operator but completely
///  different semantics so there's no common protocol on which to base the conditional conformance.
public struct TensorThumbnail<Scalar: TensorFlowScalar>: View {
    public let body: AnyView

    public init<Scalar: TensorFlowScalar>(tensor: Tensor<Scalar>, batched: Bool = false)
            where Scalar: BinaryFloatingPoint {
        body = AnyView(TensorFloatThumbnail(tensor: tensor, batched: batched))
    }
    
    public init<Scalar: TensorFlowScalar>(tensor: Tensor<Scalar>, batched: Bool = false)
            where Scalar: BinaryInteger {
        body = AnyView(TensorIntThumbnail(tensor: tensor, batched: batched))
    }    
}

enum RangeMode<T: Numeric> {
    case manual(min: T, max: T)
    case standardDeviation(scaledBy: Double = 1.0)
}

// MARK: - Alignment guides

extension HorizontalAlignment {
    private enum HorizontalCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    static let horizontalCenter = HorizontalAlignment(HorizontalCenter.self)
}

extension VerticalAlignment {
    private enum VerticalCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    static let verticalCenter = VerticalAlignment(VerticalCenter.self)
}
