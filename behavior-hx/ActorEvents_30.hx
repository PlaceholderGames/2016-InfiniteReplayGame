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



class ActorEvents_30 extends ActorScript
{
	public var _IncreaseSize:Bool;
	public var _sizeChange:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("IncreaseSize", "_IncreaseSize");
		_IncreaseSize = false;
		nameMap.set("sizeChange", "_sizeChange");
		_sizeChange = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.alpha = 50 / 100;
		actor.moveDown();
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 0.04, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((_IncreaseSize == true))
				{
					scripts.Design_25_25_SetActorSize._customBlock_setActorWidth(actor, (cast(scripts.Design_25_25_SetActorSize._customBlock_getTrueWidth(actor), Float) + 1));
					scripts.Design_25_25_SetActorSize._customBlock_setActorHeight(actor, (cast(scripts.Design_25_25_SetActorSize._customBlock_getTrueHeight(actor), Float) + 1));
					_sizeChange += 1;
					propertyChanged("_sizeChange", _sizeChange);
					if((_sizeChange == 20))
					{
						_IncreaseSize = false;
						propertyChanged("_IncreaseSize", _IncreaseSize);
					}
				}
				else
				{
					scripts.Design_25_25_SetActorSize._customBlock_setActorWidth(actor, (cast(scripts.Design_25_25_SetActorSize._customBlock_getTrueWidth(actor), Float) - 1));
					scripts.Design_25_25_SetActorSize._customBlock_setActorHeight(actor, (cast(scripts.Design_25_25_SetActorSize._customBlock_getTrueHeight(actor), Float) - 1));
					_sizeChange -= 1;
					propertyChanged("_sizeChange", _sizeChange);
					if((_sizeChange == -20))
					{
						_IncreaseSize = true;
						propertyChanged("_IncreaseSize", _IncreaseSize);
					}
				}
			}
		}, actor);
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(0),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(isKeyPressed("space"))
				{
					for(index0 in 0...Std.int(8))
					{
						if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == -1))
						{
							recycleActor(actor);
							break;
						}
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}