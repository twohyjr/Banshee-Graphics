import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 9
        
        let terrain = FruitStand()
        terrain.position.y = -2
        addChild(terrain)
    }
    
    override func update(){
       
    }
    
}
