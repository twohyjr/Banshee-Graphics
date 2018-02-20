import MetalKit

class Scene_Basic : Scene{
    override func buildScene() {
        Camera.position.z = 5
        
        let quad1 = Quad(textureName: "colors.png")
        quad1.position.y = 1.2
        addChild(quad1)
        
        let quad2 = Triangle(textureName: "colors.png")
        quad2.position.y = -1.2
        addChild(quad2)

    }
}
