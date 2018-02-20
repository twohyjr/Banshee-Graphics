import MetalKit

class GameView: MTKView {

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.device = MTLCreateSystemDefaultDevice()

        Engine.startup(device: device!, mtkView: self)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.depthStencilPixelFormat = Preferences.MainDepthStencilFormat
        
        self.delegate = Engine.renderer
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    //-------KEY EVENTS SECTION-------
    
    override func keyDown(with event: NSEvent) {
        Keyboard.setKeyPressed(key: event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.setKeyPressed(key: event.keyCode, isOn: false)
    }
    
    //-------MOUSE EVENTS SECTION-------
    
    override func mouseMoved(with event: NSEvent) {
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        Mouse.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func scrollWheel(with event: NSEvent) {
        Mouse.scrollMouse(deltaY: Float(event.deltaY))
    }
    
    //Left Mouse Button Clicked
    override func mouseDown(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func mouseDragged(with event: NSEvent) {
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        Mouse.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func mouseUp(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    //Right Mouse Button Clicked
    override func rightMouseDown(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
        
    }
    
    override func rightMouseDragged(with event: NSEvent) {
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        Mouse.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        Mouse.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
}
