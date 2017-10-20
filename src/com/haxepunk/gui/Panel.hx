package com.haxepunk.gui;
import com.haxepunk.gui.event.ControlEvent;
import com.haxepunk.gui.graphic.NineSlice;
import flash.events.Event;
import flash.geom.Rectangle;

/**
 * Generic container to group Controls.
 * @author Lythom
 */
class Panel extends Control
{

	static public inline var ADDED_TO_CONTAINER:String = "added_to_container";
	static public inline var REMOVED_FROM_CONTAINER:String = "removed_from_container";
	static public inline var ADDED_TO_WORLD:String = "added_to_world";
	static public inline var REMOVED_FROM_WORLD:String = "removed_from_world";
	static public inline var HIDDEN:String = "hidden";
	static public inline var SHOWN:String = "shown";
	static public inline var MOUSE_HOVER:String = "mouseHover";
	static public inline var MOUSE_OUT:String = "mouseOut";
	static public inline var RESIZED:String = "resized";

	private var background:NineSlice;

	/**
	 * Create a new panel
	 * @param	x
	 * @param	y
	 * @param	width
	 * @param	height
	 * @param	displayBackground	transparent background if false, skin background if true.
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, displayBackground:Bool=true)
	{
		super(x, y, width, height);
		_enabled = true;
		// 24x24 squares composed of 9 8x8 slices
		if (background == null) {
			var slice:Int = Control.skinSliceSize;
			background = new NineSlice(this.width, this.height, new Rectangle(slice*3*3, 0, slice, slice));
		}
		if (displayBackground) {
			this.graphic = background;
		}

		updateSize();
	}

	/**
	 * Update the button to be displyed properly after it has been resized.
	 * Automatically called
	 */
	public function updateSize(?e:Event):Void
	{
		// update the graphics display
		if (background != null) {
			cast(background,NineSlice).width = this.width;
			cast(background,NineSlice).height = this.height;
		}

		dispatchEvent(new ControlEvent(this, RESIZED));
	}

	override public function update()
	{
		if (width != _lastWidth || height != _lastHeight) {
			updateSize();
		}

		super.update();
	}


	override function set_myEnabled(value:Bool):Bool
	{
		for (c in children) {
			c.enabled = value;
		}
		return super.set_myEnabled(value);
	}

}