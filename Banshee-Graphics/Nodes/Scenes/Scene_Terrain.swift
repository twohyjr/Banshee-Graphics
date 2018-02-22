import MetalKit

class Scene_Terrain: Scene {

    override func buildScene() {
        Camera.position.z = 9
        
        let terrain = Primitive(textureName: "stallTexture.png")
        terrain.position.y = -2
        addChild(terrain)
    }
    
}
