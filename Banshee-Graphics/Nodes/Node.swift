import MetalKit

class Node {

    public var children: [Node] = []
    
    public func addChild(_ child: Node){
        children.append(child)
    }
    
    public func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        for child in children{
            child.render(renderCommandEncoder)
        }
        if let drawable = self as? Renderable{
            drawable.doRender(renderCommandEncoder)
        }
    }
}
