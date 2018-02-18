import MetalKit

class Camera: Node{
    

    var projectionMatrix:matrix_float4x4{
        return matrix_float4x4(perspectiveDegreesFov: Preferences.camera_fov,
                               aspectRatio: Preferences.camera_aspectRatio,
                               nearZ: Preferences.camera_nearZ,
                               farZ: Preferences.camera_farZ)
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
