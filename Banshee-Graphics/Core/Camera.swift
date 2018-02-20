import MetalKit

class Camera{

    static var projectionMatrix:matrix_float4x4{
        return matrix_float4x4(perspectiveDegreesFov: Preferences.camera_fov,
                               aspectRatio: Preferences.camera_aspectRatio,
                               nearZ: Preferences.camera_nearZ,
                               farZ: Preferences.camera_farZ)
    }
    
    static var pitch: Float = 0
    static var yaw: Float = 0
    static var roll: Float = 0
    static var position: float3 = float3(0)
    static var viewMatrix: matrix_float4x4{
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.rotate(angle: pitch, axis: X_AXIS)
        viewMatrix.rotate(angle: yaw, axis: Y_AXIS)
        viewMatrix.rotate(angle: roll, axis: Z_AXIS)
        viewMatrix.translate(direction: -self.position)
        return viewMatrix
    }

}
