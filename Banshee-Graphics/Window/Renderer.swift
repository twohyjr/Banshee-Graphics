import MetalKit

class Renderer: NSObject{
    var scene: Scene = Scene()
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        Preferences.camera_aspectRatio = Float(size.width) / Float(size.height)
    }
    
    func draw(in view: MTKView) {
        let commandBuffer = Engine.commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: view.currentRenderPassDescriptor!)
        
        //Do Main Render Encoding Pass Here
        scene.render(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
    
}
