import MetalKit

class Scene : Node{
    
    var camera = Camera()
    var sceneConstants = SceneConstants()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() {
        addChild(Quad(textureName: "colors.png"))
        camera.position.z = 5
    }
    
    private func updateScene(){
        //Update the scene here (ex: camera position)
    }
    
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder){
        sceneConstants.projection_matrix = camera.projectionMatrix
        sceneConstants.view_matrix = camera.viewMatrix
        
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.depthStencilState(DepthStencilStateType.BASIC))
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride(1), index: 1)
        for child in children{
            child.render(renderCommandEncoder)
        }
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
        updateScene()
        
        doRender(renderCommandEncoder: renderCommandEncoder)
        
    }
}

