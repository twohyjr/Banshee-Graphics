import MetalKit

class Node {

    public var children: [Node] = []
    
    public var position: float3 = float3(0)
    public var rotation: float3 = float3(0)
    public var scale: float3 = float3(1)
    
    var modelMatrix: matrix_float4x4{
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        modelMatrix.rotate(angle: rotation.x, axis: X_AXIS)
        modelMatrix.rotate(angle: rotation.y, axis: Y_AXIS)
        modelMatrix.rotate(angle: rotation.z, axis: Z_AXIS)
        modelMatrix.scale(axis: scale)
        return modelMatrix
    }
    
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
