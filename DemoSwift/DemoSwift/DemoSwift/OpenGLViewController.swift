//
//  OpenGLViewController.swift
//  DemoSwift
//
//  Created by zj－db0465 on 15/11/17.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit
import GLKit

struct Vertex {
    var Position: (CFloat, CFloat, CFloat)
    var Color: (CFloat, CFloat, CFloat, CFloat)
}

var Vertices = [
    Vertex(Position: (1, -1, 0) , Color: (1, 0, 0, 1)),
    Vertex(Position: (1, 1, 0)  , Color: (0, 1, 0, 1)),
    Vertex(Position: (-1, 1, 0) , Color: (0, 0, 1, 1)),
    Vertex(Position: (-1, -1, 0), Color: (0, 0, 0, 1))
]

var Indices: [GLubyte] = [
    0, 1, 2,
    2, 3, 0
]


//helper extensions to pass arguments to GL land
extension Array {
    func size () -> Int {
        return self.count * sizeofValue(self[0])
    }
}

class OpenGLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
        
        self.drawSimpleShader()
        
        let btn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50))
        btn.setTitle("Go back to ViewController", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: Selector("actionButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tearDownOpenGLBuffers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    
    func drawSimpleShader() {
        self.setupEAGLContext()
        // self.setupCAEAGLLayer()
        self.setupRenderBuffer()
        self.setupFrameBuffer()
        self.compileShaders("SimpleVertex", shaderFragment: "SimpleFragment")
        self.setupVBOs()
        // self.renderViaGLViewport()
        self.renderViaGLKView()
    }
    
    // MARK - OpenGL related
    
    var eaglContext: EAGLContext!
    func setupEAGLContext() {
        // 渲染context，管理所有绘制状态，命令及资源信息
        self.eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        // 设置为当前context
        EAGLContext.setCurrentContext(self.eaglContext)
    }

    var eaglLayer: CAEAGLLayer!
    func setupCAEAGLLayer() {
        // 如果是在UIViewController中，要单独创建一个CAEAGLLayer
        // 如果是在UIView中，重写layerClass方法如下:
        // override class func layerClass() -> AnyClass { return CAEAGLLayer.self }
        self.eaglLayer = CAEAGLLayer()
        self.eaglLayer.frame = self.view.frame
        self.eaglLayer.opaque = true
        // 描述属性：不维持渲染内容，颜色格式
        self.eaglLayer.drawableProperties = [
            kEAGLDrawablePropertyRetainedBacking: 1,
            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8,
        ]
        self.view.layer.addSublayer(self.eaglLayer)
    }
    
    // 先renderBuffer，再frameBuffer，顺序不能互换
    var colorRenderBuffer: GLuint = GLuint()
    func setupRenderBuffer() {
        glGenRenderbuffers(1, &self.colorRenderBuffer)
        // 设为当前renderBuffer
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), self.colorRenderBuffer)
        // 分配存储空间
        self.eaglContext.renderbufferStorage(Int(GL_RENDERBUFFER), fromDrawable: self.eaglLayer)
    }
    
    var frameBufer: GLuint = GLuint()
    func setupFrameBuffer() {
        glGenFramebuffers(1, &self.frameBufer)
        // 设为当前frameBuffer
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), self.frameBufer)
        // 将colorRenderBuffer装配到GL_COLOR_ATTACHMENT0这个装配点上。
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), self.colorRenderBuffer)
    }
    
    func tearDownOpenGLBuffers() {
        if self.colorRenderBuffer != 0 {
            glDeleteRenderbuffers(1, &self.colorRenderBuffer)
            self.colorRenderBuffer = 0
        }
        if self.frameBufer != 0 {
            glDeleteFramebuffers(1, &self.frameBufer)
            self.frameBufer = 0
        }
    }
    
    var positionSlot: GLuint = GLuint()
    var colorSlot: GLuint = GLuint()
    func compileShaders(shaderVertex: String, shaderFragment: String) {
        // 先编译vertex和fragment两个shader
        let vertexShader: GLuint = ShaderOperations.compileShader(shaderVertex, shaderType: GLenum(GL_VERTEX_SHADER))
        let fragmentShader: GLuint = ShaderOperations.compileShader(shaderFragment, shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        // 连接两个shader成一个完整的program
        let programHandle: GLuint = glCreateProgram()
        glAttachShader(programHandle, vertexShader)
        glAttachShader(programHandle, fragmentShader)
        glLinkProgram(programHandle)
        
        // 查看link状态
        var linkSuccess: GLint = GLint()
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &linkSuccess)
        
        // 使用该program
        glUseProgram(programHandle)
        
        // 绑定program中的slot（即变量）
        self.positionSlot = GLuint(glGetAttribLocation(programHandle, "Position"))
        self.colorSlot = GLuint(glGetAttribLocation(programHandle, "SourceColor"))
        // 绑定时要启用这些数据
    }
    
    var vertexBuffer: GLuint = GLuint()
    var indexBuffer: GLuint = GLuint()
    func setupVBOs() {
        // 使用VBO：索引数据在VBO中的偏移量；不使用VBO：指向CPU内存中的索引数据数组。
        // 创建VBO
        glGenBuffers(1, &vertexBuffer)
        // 绑定到一个缓冲区对象（也可视为切换到该缓冲区）
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        // 将数据传到OpenGL
        glBufferData(GLenum(GL_ARRAY_BUFFER), Vertices.size(), Vertices, GLenum(GL_STATIC_DRAW))
        
        // 给position和color传递参数
        glVertexAttribPointer(positionSlot, 3, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(sizeof(Vertex)), nil)
        // Vertex结构体，偏移3个float的位置后，即是color的值
        glVertexAttribPointer(colorSlot, 4, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(sizeof(Vertex)), nil)
        // 绑定时要启用这些数据
        glEnableVertexAttribArray(positionSlot)
        glEnableVertexAttribArray(colorSlot)
        
        // 使用顶点索引Buffer
        glGenBuffers(1, &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), Indices.size(), Indices, GLenum(GL_STATIC_DRAW))
    }
    
    func renderViaGLViewport() {
        glViewport(0, 0, GLsizei(self.view.frame.size.width), GLsizei(self.view.frame.size.height))
        // 在每个vertex上调用vertex shader，在每个像素上调用fragment shader，最终绘制
        // 相比glDrawArrays, 使用顶点索引数组结合glDrawElements来渲染，可减少存储重复顶点的消耗
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        // 最终记得调用presentRenderBuffer
        self.eaglContext.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }

    func renderViaGLKView() {
        let glkView: GLKView = GLKView(frame: self.view.frame, context: self.eaglContext)
        glkView.bindDrawable()
        self.view.addSubview(glkView)
        glkView.display()
        
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        self.eaglContext.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }
}
