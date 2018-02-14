import MetalKit

protocol Texturable {
    var texture: MTLTexture! { get }
}

extension Texturable{
    func generateTexture(textureName: String)->MTLTexture?{
        var texture: MTLTexture? = nil
        
        if(textureName != String.Empty){
            let textureLoader = MTKTextureLoader(device: Engine.device)
            let url = Bundle.main.url(forResource: textureName, withExtension: nil)
            
            //Put options on the image here
            let originOption = [MTKTextureLoader.Option.origin:MTKTextureLoader.Origin.topLeft]
            
            do{
                texture = try textureLoader.newTexture(URL: url!, options: originOption)
            }catch let textureLoadError as NSError{
                print("ERROR::TEXTURE_LOADING::\(textureLoadError)")
            }
        }
        
        return texture
    }
}


