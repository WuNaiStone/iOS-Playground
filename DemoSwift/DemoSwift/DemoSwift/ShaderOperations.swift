//
//  ShaderOperations.swift
//  DemoSwift
//
//  Created by zj－db0465 on 15/11/17.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ShaderOperations: NSObject {
    class func compileShader(shaderName: String, shaderType: GLenum) -> GLuint {
        // 1,查找shader文件
        let shaderPath: String! = NSBundle.mainBundle().pathForResource(shaderName, ofType: "glsl")
        var shaderString: NSString?
        do {
            shaderString = try NSString(contentsOfFile: shaderPath, encoding: NSUTF8StringEncoding)
        } catch {
        }
    
        // 2,创建shader对象，指定type
        var shaderHandle: GLuint = glCreateShader(shaderType)
        
        // 3,获取并编译shader源码
        var shaderStringUTF8 = shaderString!.UTF8String
        var shaderStringLength: GLint = GLint(Int32(shaderString!.length))
        glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength)
        glCompileShader(shaderHandle)
        
        // 4,查询shader对象的编译信息
        var compileSuccess: GLint = GLint()
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess)
     
        return shaderHandle
    }
}
