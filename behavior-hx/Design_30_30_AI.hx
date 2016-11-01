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



class Design_30_30_AI extends ActorScript
{
	public var _EnemySpeed:Float;
	public var _test:Bool;
	public var _time:Float;
	public var _speed:Actor;
	public var _Health:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("EnemySpeed", "_EnemySpeed");
		_EnemySpeed = 0.0;
		nameMap.set("test", "_test");
		_test = false;
		nameMap.set("time", "_time");
		_time = 0.0;
		nameMap.set("speed", "_speed");
		nameMap.set("Health", "_Health");
		_Health = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		Engine.engine.setGameAttribute("enemyDMG", 8);
		
		/* ======================= After N seconds ======================== */
		runLater(1000 * _time, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((_test == false))
				{
					actor.setXVelocity(_EnemySpeed);
					_test = true;
					propertyChanged("_test", _test);
				}
				if((_test == false))
				{
					actor.setYVelocity(_EnemySpeed);
					_test = true;
					propertyChanged("_test", _test);
				}
				else if((_test == true))
				{
					actor.setXVelocity(-(_EnemySpeed));
					_test = false;
					propertyChanged("_test", _test);
				}
				else if((_test == true))
				{
					actor.setYVelocity(-(_EnemySpeed));
					_test = false;
					propertyChanged("_test", _test);
				}
			}
		}, actor);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((actor.getX() == Engine.engine.getGameAttribute("bulletX")) && (actor.getY() == Engine.engine.getGameAttribute("bulletY"))))
				{
					_Health = asNumber((_Health - Engine.engine.getGameAttribute("bulletDMG")));
					propertyChanged("_Health", _Health);
				}
				if((_Health < 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((Engine.engine.getGameAttribute("playerY") >= actor.getY()))
				{
					actor.setY((actor.getY() - -1));
				}
				if((Engine.engine.getGameAttribute("playerY") <= actor.getY()))
				{
					actor.setY((actor.getY() - 1));
				}
				if((Engine.engine.getGameAttribute("playerX") >= actor.getX()))
				{
					actor.setX((actor.getX() - -1));
				}
				if((Engine.engine.getGameAttribute("playerX") <= actor.getX()))
				{
					actor.setX((actor.getX() - 1));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}