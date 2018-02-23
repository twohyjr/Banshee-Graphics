import MetalKit

class Renderer: NSObject{
    var scene: Scene = Scene()
    
    override init(){
        super.init()
        updateTrackingArea()
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        Preferences.camera_aspectRatio = Float(size.width) / Float(size.height)
        updateTrackingArea()
    }
    
    func updateTrackingArea(){
        let area = NSTrackingArea(rect: Engine.mtkView.bounds, options: [NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.enabledDuringMouseDrag], owner: Engine.mtkView, userInfo: nil)
        Engine.mtkView.addTrackingArea(area)
    }

    func draw(in view: MTKView) {
        GameManager.tick()
        GameManager.render()
    }
    
}
