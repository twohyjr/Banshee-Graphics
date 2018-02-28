import MetalKit

protocol BaseMeshData {
    var meshType: MeshTypes! { get set }
    var vertices: [Vertex]! { get set }
    var indices: [UInt32]! { get set }
}
