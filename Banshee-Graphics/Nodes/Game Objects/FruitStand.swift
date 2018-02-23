import MetalKit

class FruitStand: Primitive {

    init(){
        super.init(modelDataType: .STALL, textureName: "stallTexture.png")
        self.rotation.y = 3.5
        self.rotation.x = 0.4
        self.position.y = -2
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
