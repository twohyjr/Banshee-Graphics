import MetalKit

class Sun: Instance {
    
    init(){
        super.init(meshData: MeshLibrary.mesh(.FRUIT_STAND), instanceCount: 1, textureName: "stallTexture.png")
        rotation = float3(0.15, 4.05, 0.0)
    }
    
}

