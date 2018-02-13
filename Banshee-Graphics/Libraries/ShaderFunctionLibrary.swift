import MetalKit

enum ShaderFunctionTypes: String{
    //Vertex Shader Types
    case Basic_Vertex = "basic_vertex_shader"
    
    //Fragment Shader Types
    case Basic_Fragment = "basic_fragment_shader"
}

class ShaderFunctionLibrary {
    
    private static var shaderFunctions:[ShaderFunctionTypes:ShaderFunction] = [:]

    public static func initialize(){
        setUpAllShaders()
    }
    
    private static func setUpAllShaders(){
        setUpVertexShaders()
        setUpFragmentShaders()
    }
    
    private static func setUpVertexShaders(){
        shaderFunctions.updateValue(ShaderFunction(.Basic_Vertex), forKey: .Basic_Vertex)
    }
    
    private static func setUpFragmentShaders(){
         shaderFunctions.updateValue(ShaderFunction(.Basic_Fragment), forKey: .Basic_Fragment)
    }
    
    public static func shaderFunction(_ shaderType: ShaderFunctionTypes)->MTLFunction{
        return (shaderFunctions[shaderType]?.function)!
    }
}

class ShaderFunction{
    var name: String!
    var function: MTLFunction!
    
    init(_ type: ShaderFunctionTypes){
        name = type.rawValue
        function = Engine.library.makeFunction(name: name)!
    }
}


