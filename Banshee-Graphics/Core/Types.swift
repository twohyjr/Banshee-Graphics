import MetalKit

struct Vertex{
    var position: float3
    var color: float4
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Vertex>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Vertex>.stride * count
    }
}

struct ModelConstants{
    
    
    static var size: Int{
        return MemoryLayout<ModelConstants>.size
    }
    
    static var stride: Int{
        return MemoryLayout<ModelConstants>.stride
    }
}

struct SceneConstants{
    
    
    static var size: Int{
        return MemoryLayout<ModelConstants>.size
    }
    
    static var stride: Int{
        return MemoryLayout<ModelConstants>.stride
    }
}
