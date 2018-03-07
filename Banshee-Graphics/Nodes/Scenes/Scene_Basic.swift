import MetalKit

class Scene_Basic : Scene{
    let circle = Sun()
    
    override func buildScene() {
        Camera.position.z = 5

        
        circle.position.x = -1.5
        addChild(circle)
        
        let circle2 = Sun()
        circle2.position.x = 1.5
        addChild(circle2)
        
        let circle3 = Sun()
        circle3.position.x = 1
        circle3.position.y = 1.2
        addChild(circle3)
    }
    
    override func tick(){
        super.tick()
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Left)){
            circle.position.x -= 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Right)){
            circle.position.x += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Up)){
            circle.position.y += 0.05
        }
        
        if(Keyboard.isKeyPressed(key: KEY_CODES.Key_Arrow_Down)){
            circle.position.y -= 0.05
        }
        for child1 in children{
            if let c1 = child1 as? Primitive{
                if(circle.id != c1.id){
                    if(checkCollision(circle.boundingSphere!, c1.boundingSphere!)){
                        c1.modelConstants.materialColor = float3(1,0,0)
                    }else{
                        c1.modelConstants.materialColor = float3(0.2)
                    }
                }
            }
        }
    }
    
    private func checkCollision(_ sphere1: BoundingSphere, _ sphere2: BoundingSphere)->Bool{
        let d = distance(sphere1.centerPoint, sphere2.centerPoint)
        return d < sphere1.radius + sphere2.radius
    }
    
}
