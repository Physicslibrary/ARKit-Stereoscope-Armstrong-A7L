/*

ARKit-Stereoscope-Armstrong-A7L

https://physicslibrary.github.io/ARKit-Stereoscope-Armstrong-A7L/

MIT License

Copyright (c) 2019 Hartwell Fong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


July 31, 2019.

Explore Neil Armstrong's A7-L spacesuit from Smithsonian Institution with a 6DOF tracking stereoscope

Hardware:

Tested Apple 2018 9.7" iPad (A9 CPU or higher for ARKit)

The OWL Stereoscope Viewer is from The London Stereoscopic Ltd

https://www.londonstereo.com

Thank to Dr. Brian May for developing an amazingly simple tool that can be used with the 9.7" iPad.

Software:

Apple iOS Swift Playgrounds (3.0)
ARKit and SceneKit (set up scene, read 3D files, attact a virtual camera for lefteye to ARKit iPad
camera righteye to make a stereoscope, 6DOF tracking)

https://www.apple.com/ca/swift/playgrounds/

Download armstrong_suit-ar_model.zip from Smithsonian Institution 3d.si.edu/armstrong

This is the "AR Ready Model Suit - .OBJ and .JPG (23.6 MB)" in the "Other Models" section of the webpage.

This playground uses the following files:
ar_low_piece1.obj
ar_low_piece2.obj
ar_low_piece3.obj
piece1_ao.jpg
piece1_basecolor.jpg
piece2_ao.jpg
piece2_basecolor.jpg
piece3_ao.jpg
piece3_basecolor.jpg
 
Add the files in Swift Playgrounds by tap "+", tap paper icon, and "Insert From...".

Tips:

If frame rate <60Hz, hold iPad still, swipe up from bottom edge of screen for HOME screen
(or press HOME button), return to Swift Playgrounds

This playground doesn't look for a flat plane to put virtual objects on, instead the initial
position of the iPad is the world origin when "Run My Code" is pressed. Hold iPad near floor
before "Run My Code" with "Enable Results" off.

All virtual objects are positioned and oriented according to this world origin
(with righteye.debugOptions on, the world origin is an XYZ or RGB axis)

References:

armstrong_suit-ar_model.zip
The Smithsonian Institution
https://3d.si.edu/armstrong

https://airandspace.si.edu/collection-objects/pressure-suit-a7-l-armstrong-apollo-11-flown

https://en.wikipedia.org/wiki/Apollo/Skylab_A7L

https://nasa3d.arc.nasa.gov/models

https://en.wikipedia.org/wiki/Ambient_occlusion

*/

import ARKit
import PlaygroundSupport

var righteye = ARSCNView()
righteye.scene = SCNScene()
righteye.scene.background.contents = UIColor.black
righteye.automaticallyUpdatesLighting = false
righteye.showsStatistics = true  // comment out to turn off

var lefteye = SCNView()
lefteye.scene = righteye.scene
lefteye.showsStatistics = true  // comment out to turn off

let config = ARWorldTrackingConfiguration()
righteye.session.run(config)

righteye.debugOptions = [
    ARSCNDebugOptions.showFeaturePoints,
    ARSCNDebugOptions.showWorldOrigin  // comment out to turn off
]

// Scenekit in Playgrounds is not able to load textures for
// Physically based rendering (with "Enable Results" off).
// However, it works with one AO ambient occlusion
// or one basecolor texture per 3D mesh.
// Textures for physically based rendering are commented out
// may work in future Swift Playgrounds.

var box = SCNScene(named: "suit_ext-part_01-high.obj")!
let node = box.rootNode.childNodes[0]
node.position = SCNVector3(0,0,0)
node.eulerAngles = SCNVector3(0,1.57,0)
node.scale = SCNVector3(0.001,0.001,0.001)
righteye.scene.rootNode.addChildNode(node)

let material = node.geometry?.firstMaterial
//material?.lightingModel = SCNMaterial.LightingModel.physicallyBased
//material?.ambientOcclusion.contents = UIImage(named: "piece1_ao.jpg")
material?.diffuse.contents = UIImage(named: "piece1_basecolor.jpg")
//material?.roughness.contents = UIImage(named: "piece1_roughness.jpg")
//material?.metalness.contents = UIImage(named: "piece1_metallic.jpg")
//material2?.normal.contents = UIImage(named: "piece2_normal.jpg")

var box2 = SCNScene(named: "suit_ext-part_02-high.obj")!
let node2 = box2.rootNode.childNodes[0]
node2.position = SCNVector3(0,0,0)
node2.eulerAngles = SCNVector3(0,1.57,0)
node2.scale = SCNVector3(0.001,0.001,0.001)
righteye.scene.rootNode.addChildNode(node2)

let material2 = node2.geometry?.firstMaterial
//material?.lightingModel = SCNMaterial.LightingModel.physicallyBased
material2?.ambientOcclusion.contents = UIImage(named: "piece2_ao.jpg")
//material2?.diffuse.contents = UIImage(named: "piece2_basecolor.jpg")
//material2?.roughness.contents = UIImage(named: "piece2_roughness.jpg")
//material2?.metalness.contents = UIImage(named: "piece2_metallic.jpg")
//material2?.normal.contents = UIImage(named: "piece2_normal.jpg")

var box3 = SCNScene(named: "suit_ext-part_03-high.obj")!
let node3 = box3.rootNode.childNodes[0]
node3.position = SCNVector3(0,0,0)
node3.eulerAngles = SCNVector3(0,1.57,0)
node3.scale = SCNVector3(0.001,0.001,0.001)
righteye.scene.rootNode.addChildNode(node3)

let material3 = node3.geometry?.firstMaterial
//material3?.lightingModel = SCNMaterial.LightingModel.physicallyBased
material3?.ambientOcclusion.contents = UIImage(named: "piece3_ao.jpg")
//material3?.diffuse.contents = UIImage(named: "piece3_basecolor.jpg")
//material3?.roughness.contents = UIImage(named: "piece3_roughness.jpg")
//material3?.metalness.contents = UIImage(named: "piece3_metallic.jpg")
//material3?.normal.contents = UIImage(named: "piece3_normal.jpg")

var light = SCNLight()
light.type = SCNLight.LightType.ambient
var lightNode = SCNNode()
lightNode.light = light
light.color = UIColor.gray
light.intensity = 1000
righteye.scene.rootNode.addChildNode(lightNode)

var ipd = -0.064  // interpupillary distance (meter)
var cameraNode = SCNNode()  // make a camera for left eye
let camera = SCNCamera()
camera.xFov = 39  // camera.* depends on righteye.frame
camera.yFov = 50
camera.zFar = 100
camera.zNear = 0.1
cameraNode.camera = camera
cameraNode.position = SCNVector3(ipd,0,0)
righteye.pointOfView?.addChildNode(cameraNode)

lefteye.pointOfView = cameraNode

lefteye.isPlaying = true

var imageView = UIImageView()

lefteye.frame = CGRect(x: 0, y: 0, width: 344, height: 380)
imageView.addSubview(lefteye)

righteye.frame = CGRect(x: 344, y: 0, width: 344, height: 380)
imageView.addSubview(righteye)

PlaygroundPage.current.wantsFullScreenLiveView = true
PlaygroundPage.current.liveView = imageView

// in last line, change imageView to righteye for mono view
