import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 15
        
        let armadillo = Armadillo()
        addChild(armadillo)
    }
    
}
