import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 4
        
        let circle = Armadillo()
        addChild(circle)
    }
    
}
