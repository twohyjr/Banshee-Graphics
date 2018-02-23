import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 9
        
        let fruitStand = FruitStand()
        fruitStand.position.y = -2
        addChild(fruitStand)
    }
    
    override func update(){
       
    }
    
}
