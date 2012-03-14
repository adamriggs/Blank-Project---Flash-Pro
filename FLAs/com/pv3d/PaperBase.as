/**
* ...
* @author Luke Mitchell
* @version 1.8.0
*/

package com.pv3d {
	// These lines make different 'pieces' available in your code.
	import flash.display.Sprite; // To extend this class
	import flash.events.Event; // To work out when a frame is entered.
	import org.papervision3d.core.proto.CameraObject3D;
	
	import org.papervision3d.view.Viewport3D; // We need a viewport
	import org.papervision3d.cameras.*; // Import all types of camera
	import org.papervision3d.scenes.Scene3D; // We'll need at least one scene
	import org.papervision3d.render.BasicRenderEngine; // And we need a renderer
	
	import com.dave.events.*;
	
	public class PaperBase extends Sprite { //Must be "extends Sprite"
		
		public var viewport:Viewport3D; // The Viewport
		public var renderer:BasicRenderEngine; // Rendering engine
		
		public var current_scene:Scene3D;
		public var current_camera:CameraObject3D;
		public var current_viewport:Viewport3D;
		// -- Scenes -- //
		public var default_scene:Scene3D; // A Scene
		// -- Cameras --//
		public var default_camera:Camera3D; // A Camera
		
		public var scenePaused:Boolean = false;
		public var inTransition:Boolean = false;
		public var uiFrozen:Boolean = false;
		
		public function PaperBase(){
			super();
			this.tabChildren = false;
			
			EventCenter.subscribe("onFreeze3D", onFreeze3D);
			EventCenter.subscribe("onThaw3D", onThaw3D);
			EventCenter.subscribe("onUIFreeze3D", onFreeze3D);
			EventCenter.subscribe("onUIThaw3D", onThaw3D);
		}
		
		public function init(vpWidth:Number = 0, vpHeight:Number = 0):void {
			initPapervision(vpWidth, vpHeight); // Initialise papervision
			init3d(); // Initialise the 3d stuff..
			init2d(); // Initialise the interface..
			initEvents(); // Set up any event listeners..
		}
		
		protected function initPapervision(vpWidth:Number, vpHeight:Number):void {
			// Here is where we initialise everything we need to
			// render a papervision scene.
			if (vpWidth == 0) {
				viewport = new Viewport3D(stage.width, stage.height, true, true);
			}else{
				viewport = new Viewport3D(vpWidth, vpHeight, false, true);
			}
			// The viewport is the object added to the flash scene.
			// You 'look at' the papervision scene through the viewport
			// window, which is placed on the flash stage.
			addChild(viewport); // Add the viewport to the stage.
			// Initialise the rendering engine.
			renderer = new BasicRenderEngine();
			// -- Initialise the Scenes -- //
			default_scene = new Scene3D();
			// -- Initialise the Cameras -- //
			default_camera = new Camera3D();
			
			current_camera = default_camera;
			current_scene = default_scene;
			current_viewport = viewport;
			
		}
		
		protected function init3d():void {
			// This function should hold all of the stages needed
			// to initialise everything used for papervision.
			// Models, materials, cameras etc.
		}
		
		protected function init2d():void {
			// This function should create all of the 2d items
			// that will be overlayed on your papervision project.
			// User interfaces, Heads up displays etc.
		}
		
		protected function initEvents():void {
			// This function makes the onFrame function get called for
			// every frame.
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			// This line of code makes the onEnterFrame function get
			// called when every frame is entered.
		}
		
		protected function processFrame():void {
			// Process any movement or animation here.
		}
		
		protected function onEnterFrame( ThisEvent:Event ):void {
			//We need to render the scene and update anything here.
			//processFrame();
			renderer.renderScene(current_scene, current_camera, current_viewport);
		}
		
		public function renderOneFrame(){
			//processFrame();
			renderer.renderScene(current_scene, current_camera, current_viewport);
		}
		
		public function pauseScene(){
			scenePaused = true;
			try {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			} catch (e:Error){}
		}
		
		public function resumeScene(){
			scenePaused = false;
			uiFrozen = false;
			try {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			} catch (e:Error){}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function updateScene(){
			//if (scenePaused){
				renderOneFrame();
			//}
		}
		
		private function onFreeze3D(e:ApplicationEvent){
			try {
				if (!inTransition){
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			} catch (e:Error){}
		}
		
		private function onThaw3D(e:ApplicationEvent){
			if (!scenePaused && !uiFrozen){
				try {
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				} catch (e:Error){}
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private function onUIFreeze3D(e:ApplicationEvent){
			try {
				if (!inTransition){
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
				uiFrozen = true;
			} catch (e:Error){}
		}
		
		private function onUIThaw3D(e:ApplicationEvent){
			if (!scenePaused){
				try {
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				} catch (e:Error){}
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				uiFrozen = false;
			}
		}
		
		protected function destroy(){
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
	}
	
}