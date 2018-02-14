import MetalKit

class Scene : Node{
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() {
        addChild(Quad(textureName: "colors.png"))
    }
    
    private func updateScene(){
        //Update the scene here (ex: camera position)
    }
    
    private func setSceneConstants(_ renderCommandEncoder: MTLRenderCommandEncoder){
        //Set the scene constants here (ex: viewMatrix, projectionMatrix)
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
        updateScene()
        
        setSceneConstants(renderCommandEncoder)
        
        super.render(renderCommandEncoder)
    }
}
