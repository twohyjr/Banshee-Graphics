import MetalKit

class FruitStand: Primitive {

    init(){
        super.init(modelDataType: .STALL, textureName: "stallTexture.png")
        self.rotation.y = 10
        self.rotation.x = 0.4
        self.position.z = -6
    }
    
}
