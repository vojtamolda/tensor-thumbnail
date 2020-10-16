#if !canImport(TensorFlow)
import TensorFraud
import SwiftUI


// FIXME: Conformance to CustomPlaygroundDisplayConvertible conflicts with the one in TensorFlow.
extension Tensor: CustomPlaygroundDisplayConvertible
where Scalar: TensorFlowScalar & BinaryFloatingPoint {    
    public var playgroundDescription: Any {
        let thumbnailView = TensorThumbnail<Scalar>(tensor: self).padding(5)

        let window = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize.zero),
                              styleMask: [.utilityWindow], backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView: thumbnailView)
        return window.contentView!
    }
}

#endif
