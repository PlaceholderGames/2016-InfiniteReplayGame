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



class Design_29_29_spawnInventoryItems extends ActorScript
{
	public var _slotX:Float;
	public var _SlotY:Float;
	public var _slotsCreated:Float;
	public var _LastSlotX:Float;
	public var _lastSlotY:Float;
	public var _slotsToMake:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("slotX", "_slotX");
		_slotX = 30.0;
		nameMap.set("SlotY", "_SlotY");
		_SlotY = 30.0;
		nameMap.set("slotsCreated", "_slotsCreated");
		_slotsCreated = 0.0;
		nameMap.set("LastSlotX", "_LastSlotX");
		_LastSlotX = 0.0;
		nameMap.set("lastSlotY", "_lastSlotY");
		_lastSlotY = 0.0;
		nameMap.set("slotsToMake", "_slotsToMake");
		_slotsToMake = 4.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if((Engine.engine.getGameAttribute("backpackEquipped") == 0))
		{
			_slotsToMake = asNumber(4);
			propertyChanged("_slotsToMake", _slotsToMake);
		}
		else if((Engine.engine.getGameAttribute("backpackEquipped") == 1))
		{
			_slotsToMake = asNumber(6);
			propertyChanged("_slotsToMake", _slotsToMake);
		}
		else
		{
			_slotsToMake = asNumber(8);
			propertyChanged("_slotsToMake", _slotsToMake);
		}
		for(index0 in 0...Std.int(8))
		{
			if((_slotsToMake > 0))
			{
				createRecycledActor(getActorType(12), (60 + _slotX), (50 + _SlotY), Script.MIDDLE);
			}
			else
			{
				createRecycledActor(getActorType(14), (60 + _slotX), (50 + _SlotY), Script.MIDDLE);
			}
			_LastSlotX = asNumber(getLastCreatedActor().getX());
			propertyChanged("_LastSlotX", _LastSlotX);
			_lastSlotY = asNumber(getLastCreatedActor().getY());
			propertyChanged("_lastSlotY", _lastSlotY);
			getLastCreatedActor().anchorToScreen();
			getLastCreatedActor().moveToTop();
			if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] > -1))
			{
				if((Engine.engine.getGameAttribute("equipItemQuality")[Std.int(index0)] == 1))
				{
					createRecycledActor(getActorType(68), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemQuality")[Std.int(index0)] == 2))
				{
					createRecycledActor(getActorType(70), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemQuality")[Std.int(index0)] == 3))
				{
					createRecycledActor(getActorType(72), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemQuality")[Std.int(index0)] == 4))
				{
					createRecycledActor(getActorType(74), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemQuality")[Std.int(index0)] == 5))
				{
					createRecycledActor(getActorType(76), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				getLastCreatedActor().anchorToScreen();
				getLastCreatedActor().moveToTop();
				if((Engine.engine.getGameAttribute("equipItemType")[Std.int(index0)] == 0))
				{
					createRecycledActor(getActorType(48), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemType")[Std.int(index0)] == 1))
				{
					createRecycledActor(getActorType(48), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemType")[Std.int(index0)] == 2))
				{
					createRecycledActor(getActorType(48), _LastSlotX, _lastSlotY, Script.FRONT);
				}
				else if((Engine.engine.getGameAttribute("equipItemType")[Std.int(index0)] == 3))
				{
					if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 0))
					{
						createRecycledActor(getActorType(62), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 1))
					{
						createRecycledActor(getActorType(94), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 2))
					{
						createRecycledActor(getActorType(98), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 3))
					{
						createRecycledActor(getActorType(92), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 4))
					{
						createRecycledActor(getActorType(48), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 5))
					{
						createRecycledActor(getActorType(104), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 6))
					{
						createRecycledActor(getActorType(102), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 7))
					{
						createRecycledActor(getActorType(100), _LastSlotX, _lastSlotY, Script.FRONT);
					}
					else if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == 8))
					{
						createRecycledActor(getActorType(96), _LastSlotX, _lastSlotY, Script.FRONT);
					}
				}
				getLastCreatedActor().anchorToScreen();
				getLastCreatedActor().moveToTop();
			}
			_slotsCreated += 1;
			propertyChanged("_slotsCreated", _slotsCreated);
			_slotX += 160;
			propertyChanged("_slotX", _slotX);
			_slotsToMake -= 1;
			propertyChanged("_slotsToMake", _slotsToMake);
			if((_slotsCreated == 4))
			{
				_SlotY += 240;
				propertyChanged("_SlotY", _SlotY);
				_slotX = asNumber(30);
				propertyChanged("_slotX", _slotX);
			}
		}
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}