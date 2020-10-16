#if canImport(TensorFlow)
import TensorFlow
#else
import TensorFraud
#endif
import SwiftUI


// MARK: - Thumbnails for tensors with floating point scalars

public extension Tensor where Scalar: TensorFlowScalar & BinaryFloatingPoint {
    // TODO: Docs
    func debugQuickLookObject() -> NSView {
        let thumbnailView = TensorThumbnail<Scalar>(tensor: self).padding(5)
        let window = invisibleHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }

    /// TODO: Docs
    ///
    /// - Parameters:
    ///   - batched: Treat the first dimension as batch size and effectively ignore it for visualization.
    ///
    /// - Remark:
    ///   The returned view must be a part of some view hierarchy. So a dummy window is created just for this purpose.
    @discardableResult
    func thumbnail(batched: Bool = false) -> NSView {
        let thumbnailView = TensorThumbnail<Scalar>(tensor: self, batched: batched).padding(5)
        let window = thumbnailHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }
}

// MARK: - Thumbnails for tensors with integer scalars

public extension Tensor where Scalar: TensorFlowScalar & BinaryInteger {
    // TODO: Docs
    func debugQuickLookObject() -> NSView {
        let thumbnailView = TensorThumbnail<Scalar>(tensor: self).padding(5)
        let window = invisibleHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }

    /// TODO: Docs
    ///
    /// - Parameters:
    ///   - batched: Treat the first dimension as batch size and effectively ignore it for visualization.
    ///
    /// - Remark:
    ///   The returned view must be a part of some view hierarchy. So a dummy window is created just for this purpose.
    @discardableResult
    func thumbnail(batched: Bool = false) -> NSView {
        let thumbnailView = TensorThumbnail<Scalar>(tensor: self, batched: batched).padding(5)
        let window = thumbnailHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }
}

// MARK: - Thumbnails for tensor shapes

public extension TensorShape {
    // TODO: Docs
    func debugQuickLookObject() -> NSView {
        let thumbnailView = PrismView(
            height: count > 0 ? self[0] : nil,
            width: count > 1 ? self[1] : nil,
            depth: count > 2 ? self[2] : nil
        )
        let window = invisibleHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }

    /// TODO: Docs
    ///
    /// - Remark:
    ///   The returned view must be a part of some view hierarchy. So a dummy window is created just for this purpose.
    @discardableResult
    func thumbnail() -> NSView {
        let thumbnailView = PrismView(
            height: count > 0 ? self[0] : nil,
            width: count > 1 ? self[1] : nil,
            depth: count > 2 ? self[2] : nil
        )
        let window = thumbnailHostingWindow(rootView: thumbnailView)
        return window.contentView!
    }
}

// MARK: - Window utilities

/// Returns a visible window displaying the SwiftUI `rootView`.
fileprivate func thumbnailHostingWindow<T: View>(rootView view: T) -> NSWindow {
    let window = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize.zero),
                          styleMask: [.titled, .closable, .utilityWindow],
                          backing: .buffered, defer: false)
    window.contentView = NSHostingView(rootView: view)
    window.standardWindowButton(.zoomButton)?.isHidden = true
    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
    window.makeKeyAndOrderFront(nil)
    window.center()
    return window
}

/// Returns an invisible window containing the SwiftUI `rootView`.
fileprivate func invisibleHostingWindow<T: View>(rootView view: T) -> NSWindow {
    let window = NSWindow(contentRect: NSRect(origin: CGPoint.zero, size: CGSize.zero),
                          styleMask: [.borderless], backing: .buffered, defer: false)
    window.contentView = NSHostingView(rootView: view)
    return window
}
