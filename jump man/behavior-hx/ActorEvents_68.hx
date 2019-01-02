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



class ActorEvents_68 extends ActorScript
{
	public var _touchfloor:Bool;
	public var _level1:Scene;
	public var _facingright:Bool;
	public var _facingleft:Bool;
	public var _facingup:Bool;
	public var _facingdown:Bool;
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_dies():Void
	{
		switchScene(GameModel.get().scenes.get(6).getID(), null, createCrossfadeTransition(1));
	}
	
	/* ========================= Custom Event ========================= */
	public function _customEvent_Death():Void
	{
		actor.setX(320);
		actor.setY(392);
		Engine.engine.setGameAttribute("Health Points", (Engine.engine.getGameAttribute("Health Points") - 1));
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("touchfloor", "_touchfloor");
		_touchfloor = false;
		nameMap.set("level 1", "_level1");
		nameMap.set("facing right", "_facingright");
		_facingright = false;
		nameMap.set("facing left", "_facingleft");
		_facingleft = false;
		nameMap.set("facing up", "_facingup");
		_facingup = false;
		nameMap.set("facing down", "_facingdown");
		_facingdown = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		engine.cameraFollow(actor);
		runLater(1000 * 1.1, function(timeTask:TimedTask):Void
		{
			Engine.engine.setGameAttribute("scene transitioning", false);
		}, actor);
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(isKeyDown("right"))
				{
					actor.setXVelocity(13);
					actor.setAnimation("" + "walking right");
				}
				else if(isKeyDown("left"))
				{
					actor.setXVelocity(-13);
					actor.setAnimation("" + "walking left");
				}
				else
				{
					actor.setXVelocity(0);
					actor.setAnimation("" + "idle");
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				Engine.engine.setGameAttribute("x of hero", actor.getX());
				Engine.engine.setGameAttribute("y of hero", actor.getY());
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("action1", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if((Engine.engine.getGameAttribute("level") == 2.5))
				{
					if(isKeyDown("right"))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(30);
						getLastCreatedActor().setAnimation("" + "right");
						_facingright = true;
						propertyChanged("_facingright", _facingright);
						_facingleft = false;
						propertyChanged("_facingleft", _facingleft);
						_facingup = false;
						propertyChanged("_facingup", _facingup);
						_facingdown = false;
						propertyChanged("_facingdown", _facingdown);
					}
					else if(isKeyDown("left"))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(-30);
						getLastCreatedActor().setAnimation("" + "left");
						_facingright = false;
						propertyChanged("_facingright", _facingright);
						_facingleft = true;
						propertyChanged("_facingleft", _facingleft);
						_facingup = false;
						propertyChanged("_facingup", _facingup);
						_facingdown = false;
						propertyChanged("_facingdown", _facingdown);
					}
					else if((isKeyDown("right") && isKeyDown("up")))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(30);
						getLastCreatedActor().setAnimation("" + "right");
						_facingright = true;
						propertyChanged("_facingright", _facingright);
						_facingleft = false;
						propertyChanged("_facingleft", _facingleft);
						_facingup = false;
						propertyChanged("_facingup", _facingup);
						_facingdown = false;
						propertyChanged("_facingdown", _facingdown);
					}
					else if((isKeyDown("left") && isKeyDown("up")))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(-30);
						getLastCreatedActor().setAnimation("" + "left");
						_facingright = false;
						propertyChanged("_facingright", _facingright);
						_facingleft = true;
						propertyChanged("_facingleft", _facingleft);
						_facingup = false;
						propertyChanged("_facingup", _facingup);
						_facingdown = false;
						propertyChanged("_facingdown", _facingdown);
					}
					else if(isKeyDown("down"))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setYVelocity(30);
						getLastCreatedActor().setAnimation("" + "down");
						_facingright = false;
						propertyChanged("_facingright", _facingright);
						_facingleft = false;
						propertyChanged("_facingleft", _facingleft);
						_facingup = false;
						propertyChanged("_facingup", _facingup);
						_facingdown = true;
						propertyChanged("_facingdown", _facingdown);
					}
					else if(isKeyDown("up"))
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setYVelocity(-30);
						getLastCreatedActor().setAnimation("" + "up");
						_facingright = false;
						propertyChanged("_facingright", _facingright);
						_facingleft = false;
						propertyChanged("_facingleft", _facingleft);
						_facingup = true;
						propertyChanged("_facingup", _facingup);
						_facingdown = false;
						propertyChanged("_facingdown", _facingdown);
					}
					else if(_facingright)
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(30);
						getLastCreatedActor().setAnimation("" + "right");
					}
					else if(_facingleft)
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setXVelocity(-30);
						getLastCreatedActor().setAnimation("" + "left");
					}
					else if(_facingup)
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setYVelocity(-30);
						getLastCreatedActor().setAnimation("" + "up");
					}
					else if(_facingdown)
					{
						createRecycledActor(getActorType(66), (Engine.engine.getGameAttribute("x of hero") + 10), (Engine.engine.getGameAttribute("y of hero") + 20), Script.MIDDLE);
						getLastCreatedActor().setYVelocity(30);
						getLastCreatedActor().setAnimation("" + "down");
					}
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(54), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(event.otherActor);
				Engine.engine.setGameAttribute("Health Points", (Engine.engine.getGameAttribute("Health Points") - 1));
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(isKeyDown("up"))
				{
					actor.setAnimation("" + "jumping");
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(23), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((Engine.engine.getGameAttribute("level") == .5))
				{
					switchScene(GameModel.get().scenes.get(5).getID(), null, createCrossfadeTransition(1));
				}
				else if((Engine.engine.getGameAttribute("level") == 2.5))
				{
					switchScene(GameModel.get().scenes.get(7).getID(), null, createCrossfadeTransition(1));
				}
				else
				{
					actor.shout("_customEvent_" + "Death");
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(25), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((Engine.engine.getGameAttribute("level") == .5))
				{
					switchScene(GameModel.get().scenes.get(5).getID(), null, createCrossfadeTransition(1));
				}
				else
				{
					actor.shout("_customEvent_" + "Death");
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((Engine.engine.getGameAttribute("Health Points") <= 0))
				{
					actor.shout("_customEvent_" + "dies");
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(52), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.shout("_customEvent_" + "Death");
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(72), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(((Engine.engine.getGameAttribute("level") == 1) && (Engine.engine.getGameAttribute("scene transitioning") == false)))
				{
					Engine.engine.setGameAttribute("scene transitioning", true);
					switchScene(GameModel.get().scenes.get(3).getID(), null, createCrossfadeTransition(1));
					Engine.engine.setGameAttribute("level", 2);
					Engine.engine.setGameAttribute("level 2 unlocked", true);
				}
				else if(((Engine.engine.getGameAttribute("level") == 2) && (Engine.engine.getGameAttribute("scene transitioning") == false)))
				{
					Engine.engine.setGameAttribute("scene transitioning", true);
					switchScene(GameModel.get().scenes.get(7).getID(), null, createCrossfadeTransition(1));
					Engine.engine.setGameAttribute("level", 2.5);
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				engine.cameraFollow(actor);
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((isKeyDown("up") && (_touchfloor == true)))
				{
					actor.setAnimation("" + "jumping");
					actor.setYVelocity(-35);
					_touchfloor = false;
					propertyChanged("_touchfloor", _touchfloor);
					actor.setFriction(0);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(27), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((Engine.engine.getGameAttribute("level") == .5))
				{
					switchScene(GameModel.get().scenes.get(5).getID(), null, createCrossfadeTransition(1));
				}
				else if((Engine.engine.getGameAttribute("level") == 2.5))
				{
					switchScene(GameModel.get().scenes.get(7).getID(), null, createCrossfadeTransition(1));
				}
				else
				{
					actor.shout("_customEvent_" + "Death");
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(1),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				Engine.engine.setGameAttribute("debug log", actor.getFriction());
				if(event.otherFromTop)
				{
					_touchfloor = true;
					propertyChanged("_touchfloor", _touchfloor);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}