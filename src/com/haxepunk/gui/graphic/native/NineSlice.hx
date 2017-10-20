package com.haxepunk.gui.graphic.native;

import haxepunk.Graphic;
import haxepunk.graphics.Image;
import haxepunk.HXP;
import haxepunk.graphics.atlas.AtlasRegion;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.geom.Point;


/**
 * ...
 * @author AClockWorkLemon
 * @author Lythom
 */
class NineSlice extends Graphic
{
	private var _skin:AtlasRegion;

	private var _topLeft:AtlasRegion;
	private var _topCenter:AtlasRegion;
	private var _topRight:AtlasRegion;
	private var _centerLeft:AtlasRegion;
	private var _centerCenter:AtlasRegion;
	private var _centerRight:AtlasRegion;
	private var _bottomLeft:AtlasRegion;
	private var _bottomCenter:AtlasRegion;
	private var _bottomRight:AtlasRegion;
	
	private var _showTopRow:Bool;

	private var _xScale:Float;
	private var _yScale:Float;

	private var _clipRect:Rectangle;

	private var _width:Float;
	private var _height:Float;
	private var _camera:Point;
	var _topCenterScaleX:Float;
	var _centerLeftScaleY:Float;
	var _centerCenterScaleX:Float;
	var _centerCenterScaleY:Float;
	var _centerRightScaleY:Float;
	var _bottomCenterScaleX:Float;
	
	var _topCenterX:Float;
	var _topRightX:Float;
	var _centerLeftY:Float;
	var _centerCenterX:Float;
	var _centerCenterY:Float;
	var _centerRightX:Float;
	var _centerRightY:Float;
	var _bottomLeftY:Float;
	var _bottomCenterX:Float;
	var _bottomCenterY:Float;
	var _bottomRightX:Float;
	var _bottomRightY:Float;

	/**
	 * Create an Image setting its width, height and the position and size of the first slice.
	 * A slice is 1/3 of the source image ("skin" if not null, else defaultGuiSkin).
	 * @param	width		Initial Width of the 9slice
	 * @param	height		Initial Height of the 9slice
	 * @param	clipRect	Rectangle of the first slice area on the skin
	 * @param	skin		optional custom skin
	 */
	public function new(width:Float, height:Float, ?clipRect:Rectangle, ?skin:AtlasRegion)
	{
		super();
		
		_showTopRow = true;
		
		_camera = new Point();
		
		_skin = (skin != null) ? skin : Control.currentSkin;
		
		this.width = width;
		this.height = height;

		//blit = false;

		if (clipRect == null) clipRect = new Rectangle(0, 0, 1, 1);
		_clipRect = clipRect;

		_topLeft      = _skin.clip(new Rectangle(clipRect.x                     , clipRect.y                      , clipRect.width, clipRect.height));
		_topCenter    = _skin.clip(new Rectangle(clipRect.x + clipRect.width    , clipRect.y                      , clipRect.width, clipRect.height));
		_topRight     = _skin.clip(new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y                      , clipRect.width, clipRect.height));
		_centerLeft   = _skin.clip(new Rectangle(clipRect.x                     , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerCenter = _skin.clip(new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerRight  = _skin.clip(new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_bottomLeft   = _skin.clip(new Rectangle(clipRect.x                     , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomCenter = _skin.clip(new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomRight  = _skin.clip(new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
	}

	// TODO: No longer applicable, need to refactor this to new format..
	/*
	public function renderAtlas(layer:Int, point:Point, camera:Point)
	{
		calculateRendering();
		_camera.x = Math.round(camera.x);
		_camera.y = Math.round(camera.y);
		doRenderAtlas(layer, point, _camera);
	}

	
	private function calculateRendering():Void
	{
		_xScale = (width - _clipRect.width * 2) / _clipRect.width;
		_yScale = (height - _clipRect.height * 2) / _clipRect.height;

		_topCenterScaleX = _xScale;
		_centerLeftScaleY = _yScale;
		_centerCenterScaleX = _xScale;
		_centerCenterScaleY = _yScale;
		_centerRightScaleY = _yScale;
		_bottomCenterScaleX = _xScale;

		// width and height
		var hw = _clipRect.width;
		var hh = _clipRect.height;
		// scaled width and height
		var hsw = (_clipRect.width + (_xScale * _clipRect.width));
		var hsh = (_clipRect.height + (_yScale * _clipRect.height));

		_topCenterX    = hw;
		_topRightX     = hsw;
		_centerLeftY   = hh;
		_centerCenterX = hw;
		_centerCenterY = hh;
		_centerRightX  = hsw;
		_centerRightY  = hh;
		_bottomLeftY   = hsh;
		_bottomCenterX = hw;
		_bottomCenterY = hsh;
		_bottomRightX  = hsw;
		_bottomRightY  = hsh;
	}
	
	private function doRenderAtlas(layer:Int, point:Point, camera:Point):Void
	{
		_point.x = Math.round((point.x + this.x - camera.x * scrollX) * HXP.screen.fullScaleX);
		_point.y = Math.round((point.y + this.y - camera.y * scrollY) * HXP.screen.fullScaleY);

		if (_showTopRow) {
			_topLeft.draw(_point.x, _point.y, layer, 1 * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
			_topCenter.draw(_point.x + _topCenterX * HXP.screen.fullScaleX, _point.y, layer, _topCenterScaleX * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
			_topRight.draw(_point.x + _topRightX * HXP.screen.fullScaleX, _point.y, layer, 1 * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
		}

		_centerLeft.draw(_point.x, _point.y + _centerLeftY * HXP.screen.fullScaleY, layer, 1 * HXP.screen.fullScaleX, _centerLeftScaleY * HXP.screen.fullScaleY);
		_centerCenter.draw(_point.x + _centerCenterX * HXP.screen.fullScaleX, _point.y + _centerCenterY * HXP.screen.fullScaleY, layer, _centerCenterScaleX * HXP.screen.fullScaleX, _centerCenterScaleY * HXP.screen.fullScaleY);
		_centerRight.draw(_point.x + _centerRightX * HXP.screen.fullScaleX, _point.y + _centerRightY * HXP.screen.fullScaleY, layer, 1 * HXP.screen.fullScaleX, _centerRightScaleY * HXP.screen.fullScaleY);

		_bottomLeft.draw(_point.x, _point.y + _bottomLeftY * HXP.screen.fullScaleY, layer, 1 * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
		_bottomCenter.draw(_point.x + _bottomCenterX * HXP.screen.fullScaleX, _point.y + _bottomCenterY * HXP.screen.fullScaleY, layer, _bottomCenterScaleX * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
		_bottomRight.draw(_point.x + _bottomRightX * HXP.screen.fullScaleX, _point.y + _bottomRightY * HXP.screen.fullScaleY, layer, 1 * HXP.screen.fullScaleX, 1 * HXP.screen.fullScaleY);
	}
	*/

	public function hideTop():Void
	{
		_showTopRow = false;
	}


	private function get_width():Float
	{
		return _width;
	}

	private function set_width(value:Float):Float
	{
		return _width = value;
	}

	public var width(get_width, set_width):Float;

	private function get_height():Float
	{
		return _height;
	}

	private function set_height(value:Float):Float
	{
		return _height = value;
	}
	public var height(get_height, set_height):Float;

	private function get_topLeft():AtlasRegion
	{
		return _topLeft;
	}

	private function set_topLeft(value:AtlasRegion):AtlasRegion
	{
		return _topLeft = value;
	}

	public var topLeft(get_topLeft, set_topLeft):AtlasRegion;

	private function get_topCenter():AtlasRegion
	{
		return _topCenter;
	}

	private function set_topCenter(value:AtlasRegion):AtlasRegion
	{
		return _topCenter = value;
	}

	public var topCenter(get_topCenter, set_topCenter):AtlasRegion;

	private function get_topRight():AtlasRegion
	{
		return _topRight;
	}

	private function set_topRight(value:AtlasRegion):AtlasRegion
	{
		return _topRight = value;
	}

	public var topRight(get_topRight, set_topRight):AtlasRegion;

	private function get_centerLeft():AtlasRegion
	{
		return _centerLeft;
	}

	private function set_centerLeft(value:AtlasRegion):AtlasRegion
	{
		return _centerLeft = value;
	}

	public var centerLeft(get_centerLeft, set_centerLeft):AtlasRegion;

	private function get_centerCenter():AtlasRegion
	{
		return _centerCenter;
	}

	private function set_centerCenter(value:AtlasRegion):AtlasRegion
	{
		return _centerCenter = value;
	}

	public var centerCenter(get_centerCenter, set_centerCenter):AtlasRegion;

	private function get_centerRight():AtlasRegion
	{
		return _centerRight;
	}

	private function set_centerRight(value:AtlasRegion):AtlasRegion
	{
		return _centerRight = value;
	}

	public var centerRight(get_centerRight, set_centerRight):AtlasRegion;


	private function get_bottomLeft():AtlasRegion
	{
		return _bottomLeft;
	}

	private function set_bottomLeft(value:AtlasRegion):AtlasRegion
	{
		return _bottomLeft = value;
	}

	public var bottomLeft(get_bottomLeft, set_bottomLeft):AtlasRegion;

	private function get_bottomCenter():AtlasRegion
	{
		return _bottomCenter;
	}

	private function set_bottomCenter(value:AtlasRegion):AtlasRegion
	{
		return _bottomCenter = value;
	}

	public var bottomCenter(get_bottomCenter, set_bottomCenter):AtlasRegion;

	private function get_bottomRight():AtlasRegion
	{
		return _bottomRight;
	}

	private function set_bottomRight(value:AtlasRegion):AtlasRegion
	{
		return _bottomRight = value;
	}

	public var bottomRight(get_bottomRight, set_bottomRight):AtlasRegion;


}