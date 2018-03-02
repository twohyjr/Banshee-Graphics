import MetalKit

class Sun: Instance {
    
    init(){
        super.init(meshData: MeshLibrary.mesh(.SPHERE_APPLE), instanceCount: 1000, textureName: "stallTexture.png")
        var count: Float = 0.0
        for i in self.nodes{
            i.rotation.y = count
            count += 0.03
        }
        rotation = float3(0.15, 4.05, 0.0)
    }
}

