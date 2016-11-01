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



class Design_42_42_pickupItems extends ActorScript
{
	public var _qualityChance:Float;
	public var _qualityValue:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("qualityChance", "_qualityChance");
		_qualityChance = 0.0;
		nameMap.set("qualityValue", "_qualityValue");
		_qualityValue = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(7),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(isKeyPressed("space"))
				{
					for(index0 in 0...Std.int(8))
					{
						if((Engine.engine.getGameAttribute("equipItemID")[Std.int(index0)] == -1))
						{
							_qualityChance = asNumber(randomInt(Math.floor(1), Math.floor(100)));
							propertyChanged("_qualityChance", _qualityChance);
							if(((_qualityChance >= 1) && (_qualityChance <= 40)))
							{
								Engine.engine.getGameAttribute("equipItemQuality").insert(Std.int(index0), 1);
								_qualityValue = asNumber(1);
								propertyChanged("_qualityValue", _qualityValue);
							}
							else if(((_qualityChance >= 41) && (_qualityChance <= 70)))
							{
								Engine.engine.getGameAttribute("equipItemQuality").insert(Std.int(index0), 2);
								_qualityValue = asNumber(2);
								propertyChanged("_qualityValue", _qualityValue);
							}
							else if(((_qualityChance >= 71) && (_qualityChance <= 90)))
							{
								Engine.engine.getGameAttribute("equipItemQuality").insert(Std.int(index0), 3);
								_qualityValue = asNumber(3);
								propertyChanged("_qualityValue", _qualityValue);
							}
							else if(((_qualityChance >= 91) && (_qualityChance <= 96)))
							{
								Engine.engine.getGameAttribute("equipItemQuality").insert(Std.int(index0), 4);
								_qualityValue = asNumber(4);
								propertyChanged("_qualityValue", _qualityValue);
							}
							else if(((_qualityChance >= 97) && (_qualityChance <= 100)))
							{
								Engine.engine.getGameAttribute("equipItemQuality").insert(Std.int(index0), 5);
								_qualityValue = asNumber(5);
								propertyChanged("_qualityValue", _qualityValue);
							}
							if((event.otherActor.getAnimation() == "trainers"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 0) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 0);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
									Engine.engine.setGameAttribute("playerSpeed", (Engine.engine.getGameAttribute("playerSpeed") * (1.20 + ((_qualityValue * 5) / 100))));
								}
							}
							else if((event.otherActor.getAnimation() == "bandages"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 1) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 1);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							else if((event.otherActor.getAnimation() == "glasses"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 2) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 2);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							else if((event.otherActor.getAnimation() == "ammo"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 3) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 3);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							else if((event.otherActor.getAnimation() == "backpack"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 4) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 4);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
									Engine.engine.setGameAttribute("backpackEquipped", 1);
								}
							}
							else if((event.otherActor.getAnimation() == "militaryBackpack"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 5) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 5);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
									Engine.engine.setGameAttribute("backpackEquipped", 2);
								}
							}
							else if((event.otherActor.getAnimation() == "helmet"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 6) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 6);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							else if((event.otherActor.getAnimation() == "gloves"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 7) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 7);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							else if((event.otherActor.getAnimation() == "filterExtender"))
							{
								for(index1 in 0...Std.int(8))
								{
									if(((Engine.engine.getGameAttribute("equipItemID")[Std.int(index1)] == 8) && (Engine.engine.getGameAttribute("equipItemType")[Std.int(index1)] == 3)))
									{
										Engine.engine.setGameAttribute("itemAlreadyEquipped", true);
									}
								}
								if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
								{
									Engine.engine.getGameAttribute("equipItemID").insert(Std.int(index0), 8);
									Engine.engine.getGameAttribute("equipItemType").insert(Std.int(index0), 3);
								}
							}
							if((Engine.engine.getGameAttribute("itemAlreadyEquipped") == false))
							{
								recycleActor(event.otherActor);
							}
							else
							{
								Engine.engine.setGameAttribute("itemAlreadyEquipped", false);
							}
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