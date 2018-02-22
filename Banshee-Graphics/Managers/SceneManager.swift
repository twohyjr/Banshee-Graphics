import MetalKit

public enum SceneTypes{
    case Basic
    case Terrain
}

class SceneManager {

    public static var CurrentScene: Scene!
    
    public static func initialize(startingSceneType: SceneTypes){
        Preferences.camera_aspectRatio = Float(Engine.mtkView.drawableSize.width) / Float(Engine.mtkView.drawableSize.height)
        setScene(sceneType: startingSceneType)
    }
    
    public static func setScene(sceneType: SceneTypes){
        switch sceneType {
        case .Basic:
            CurrentScene = Scene_Basic()
        case .Terrain:
            CurrentScene = Scene_Terrain()
        }
    }
    
}
