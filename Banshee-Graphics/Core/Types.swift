import MetalKit

protocol sizeable{
    static func size(_ count: Int)->Int
    static func stride(_ count: Int)->Int
}

extension sizeable{
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

struct Vertex: sizeable {
    var position: float3
    var color: float3
    var normal: float3
    var textureCoordinate: float2
}

struct ModelConstants: sizeable{
    var model_matrix: matrix_float4x4 = matrix_identity_float4x4
}

struct SceneConstants: sizeable{
    var projection_matrix: matrix_float4x4 = matrix_identity_float4x4
    var view_matrix: matrix_float4x4  = matrix_identity_float4x4
}
