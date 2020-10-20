/*:
 # Tensor Thumbnail Playground
 
 - Important:
   This playground **doesn't yet work** with real [TensorFlow](https://tensorflow.org/swift). Instead, it uses a mockup [TensorFraud](https://github.com/vojtamolda/tensor-thumbnail/tree/master/Sources/TensorFraud) module that has an identical API but lacks any useful computational functionality. This means that you can experiment with visualization of `Tensor`s but there's way to do any meaningful computation.
 */
import TensorFraud
import TensorThumbnail


let scalar = Tensor<Float>(shape: [1], scalars: [1])
let vector = Tensor<Float>(randomUniform: [25])
let matrix = Tensor<Float>(randomUniform: [50, 50])
let image = Tensor<Float>(randomUniform: [240, 320, 3])
let tensor = Tensor<Float>(randomUniform: [32, 8, 64, 64])
