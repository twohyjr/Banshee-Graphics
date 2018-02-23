import MetalKit

class GameManager {
    
    public static func initialize(){
        
    }
    
    public static func tick(){
        Camera.update()
        
        SceneManager.CurrentScene.tick()
    }
    
    public static func render(){
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: Engine.mtkView.currentRenderPassDescriptor!)
        
        //Do Main Render Encoding Pass Here
        SceneManager.CurrentScene.render(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(Engine.mtkView.currentDrawable!)
        commandBuffer?.commit()
    }
    
}
