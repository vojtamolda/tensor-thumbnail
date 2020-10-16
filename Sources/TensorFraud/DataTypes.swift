// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


public protocol TensorFlowScalar {}
public typealias TensorFlowNumeric = TensorFlowScalar & Numeric
public typealias TensorFlowSignedNumeric = TensorFlowScalar & SignedNumeric
public typealias TensorFlowInteger = TensorFlowScalar & BinaryInteger

public protocol TensorFlowIndex: TensorFlowInteger {}

extension Int32: TensorFlowIndex {}
extension Int64: TensorFlowIndex {}

public protocol TensorFlowFloatingPoint: TensorFlowScalar & BinaryFloatingPoint
    where Self.RawSignificand: FixedWidthInteger { }

extension Float: TensorFlowFloatingPoint { }
extension Double: TensorFlowFloatingPoint { }

extension Bool: TensorFlowScalar { }
extension Int8: TensorFlowScalar { }
extension Int16: TensorFlowScalar { }
extension Int32: TensorFlowScalar { }
extension Int64: TensorFlowScalar { }
extension UInt8: TensorFlowScalar { }
extension UInt16: TensorFlowScalar { }
extension UInt32: TensorFlowScalar { }
extension UInt64: TensorFlowScalar { }
extension Float: TensorFlowScalar { }
extension Double: TensorFlowScalar { }
