import MetalKit

class Sun: Primitive {
    
    init(){
        super.init(baseMeshType: .CONE_APPLE)
        scale = float3(0.95)
    }
}

