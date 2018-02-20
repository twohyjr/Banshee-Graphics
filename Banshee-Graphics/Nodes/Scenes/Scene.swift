import MetalKit

class Scene : Node{

    var sceneConstants = SceneConstants()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() {
        //Add all of the scenes current entities
    }
    
    private func updateScene(){
        //Update the scene here (ex: camera position)
        Camera.yaw += 0.004
    }
    
    func doRender(renderCommandEncoder: MTLRenderCommandEncoder){
        sceneConstants.projection_matrix = Camera.projectionMatrix
        sceneConstants.view_matrix = Camera.viewMatrix
        
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

