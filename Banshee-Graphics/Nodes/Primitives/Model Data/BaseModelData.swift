import MetalKit

protocol BaseModelData {
    var modelDataType: ModelDataTypes! { get set }
    var vertices: [Vertex]! { get set }
    var indices: [UInt32]! { get set }
}
