import MetalKit

class MeshData {
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var vertexDescriptor: MTLVertexDescriptor!
    var primitiveType: MTLPrimitiveType!
    var indexCount: Int!
    var vertexCount: Int!
    var indexType: MTLIndexType!
    var boundingBox: MDLAxisAlignedBoundingBox!
    var boundingSphere: BoundingSphere!
    var depth: Float{
        return boundingBox.maxBounds.z - boundingBox.minBounds.z
    }
    var width: Float{
        return boundingBox.maxBounds.x - boundingBox.minBounds.x
    }
    var height: Float{
        return boundingBox.maxBounds.y - boundingBox.minBounds.y
    }
}
