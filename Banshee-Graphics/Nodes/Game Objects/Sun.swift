import MetalKit

class Sun: Primitive {
    
    init(){
        super.init(baseMeshType: .SPHERE_APPLE, textureName: "stallTexture.png")
        rotation = float3(0.15, 4.05, 0.0)
    }
    
}

