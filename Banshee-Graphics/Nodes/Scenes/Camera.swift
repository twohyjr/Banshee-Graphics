import MetalKit

class Camera: Node{
    
    var fov: Float = 45
    var aspectRatio: Float = 1
    var nearZ: Float = 0.1
    var farZ: Float = 1000
    var projectionMatrix:matrix_float4x4{
        return matrix_float4x4(perspectiveDegreesFov: fov, aspectRatio: aspectRatio, nearZ: nearZ, farZ: farZ)
    }
    
    var pitch: Float = 0
    var yaw: Float = 0
    var roll: Float = 0
    var viewMatrix: matrix_float4x4{
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.rotate(angle: pitch, axis: X_AXIS)
        viewMatrix.rotate(angle: yaw, axis: Y_AXIS)
        viewMatrix.rotate(angle: roll, axis: Z_AXIS)
        viewMatrix.translate(direction: -self.position)
        return viewMatrix
    }
    
}
