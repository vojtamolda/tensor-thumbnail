#  `TensorFraud` - TensorFlow Mockup

<p align="center">
  <img src="https://github.com/tensorflow/swift/blob/master/images/logo.png">
</p>

These files provide a "fake" `TensorFlow` module that doesn't require [Swift for TensorFlow](https://github.com/tensorflow/swift) toolchain to run. Obviously the coolest and most useful features like the differentiability and building blocks for neural networks are missing. But this package is only intended intended to make debugging work and Xcode Playground because.

Eventually, once all the differentiability features are upstreamed into the Swift compiler and [`swift-apis`]() becomes a "regular" SPM package this will be obsolete.


## Installation
Swift package manager.
```
TODO:
```

```swift
import TensorFraud // Instead of TensorFlow
```

## Usage

### LLDB in Xcode
At the moment Xcode always uses built-in LLVM instead of the one shipped in the S4TF toolchain which make the debug symbols invisible.

```
TODO: Warning
```

### Xcode Playgrounds

Using TensorFlow in Playgrounds isn't possible because the `libTensorFlow.dylib` doesn't have digital signature that seems to be mandatory in Playgrounds.

```
TODO: Warning
```



## License

Files in this module were adapted from [`swift-apis`](https://github.com/tensorflow/swift-apis) repository and are licensed under  the Apache 2.0 license. See the [license text](License.txt) file for more details.

