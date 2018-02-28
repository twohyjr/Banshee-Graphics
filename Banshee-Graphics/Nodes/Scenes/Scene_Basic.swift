import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 15
        
        let fruitStand = FruitStand()
        fruitStand.position.y = -3
        addChild(fruitStand)
    }
    
}
