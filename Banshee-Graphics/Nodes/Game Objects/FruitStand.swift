import MetalKit

class FruitStand: Primitive {

    init(){
        super.init(baseMeshType: .FRUIT_STAND, textureName: "stallTexture.png")
        addChild(Sun())
        rotation = float3(0.15, 4.05, 0.0)
    }
    
    override func tick() {
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Left)){
            rotation.y += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Right)){
            rotation.y -= 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Up)){
            rotation.x += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Down)){
            rotation.x -= 0.05
        }
    }
    
}
