package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_23_23_Equipment extends ActorScript
{
	public var _movedY:Float;
	public var _moveUp:Bool;
	public var _drawText:Bool;
	public var _slotX:Float;
	public var _SlotY:Float;
	public var _slotsCreated:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("movedY", "_movedY");
		_movedY = 0.0;
		nameMap.set("moveUp", "_moveUp");
		_moveUp = true;
		nameMap.set("drawText", "_drawText");
		_drawText = false;
		nameMap.set("slotX", "_slotX");
		_slotX = 30.0;
		nameMap.set("SlotY", "_SlotY");
		_SlotY = 30.0;
		nameMap.set("slotsCreated", "_slotsCreated");
		_slotsCreated = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 0.04, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((_moveUp == true))
				{
					actor.setY((actor.getY() + 1));
					_movedY += 1;
					propertyChanged("_movedY", _movedY);
					if((_movedY == 20))
					{
						_moveUp = false;
						propertyChanged("_moveUp", _moveUp);
					}
				}
				else
				{
					actor.setY((actor.getY() - 1));
					_movedY -= 1;
					propertyChanged("_movedY", _movedY);
					if((_movedY == -20))
					{
						_moveUp = true;
						propertyChanged("_moveUp", _moveUp);
					}
				}
			}
		}, actor);
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(0),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((_drawText == false))
				{
					_drawText = true;
					propertyChanged("_drawText", _drawText);
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_drawText)
				{
					g.setFont(getFont(40));
					g.drawString("" + "Press \"Space\" to pickup", -((getFont(40).font.getTextWidth("Press \"Space\" to pickup")/Engine.SCALE / 4)), -30);
				}
				runLater(1000 * 2, function(timeTask:TimedTask):Void
				{
					_drawText = false;
					propertyChanged("_drawText", _drawText);
				}, actor);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}