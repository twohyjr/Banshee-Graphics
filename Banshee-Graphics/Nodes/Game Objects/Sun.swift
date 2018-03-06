import MetalKit

class Sun: Primitive {
    
    init(){
        super.init(baseMeshType: .CONE_APPLE)
        scale = float3(0.95)
        
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
        super.tick()
    }
}

