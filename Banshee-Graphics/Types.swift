import MetalKit

protocol Sizeable{

}

struct Vertex: Sizeable{
    var position: float3
    var color: float4
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Vertex>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Vertex>.stride * count
    }
}
