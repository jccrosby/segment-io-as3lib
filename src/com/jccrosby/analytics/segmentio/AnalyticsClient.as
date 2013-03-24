package com.jccrosby.analytics.segmentio
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	
	public class AnalyticsClient extends EventDispatcher
	{
		private var _secret:String;
		private var _requestQueue:ArrayCollection;
		private var _activeRequest:Boolean;
		private var _loader:URLLoader;
		
		public function AnalyticsClient(secret:String)
		{
			if(_secret == "")
				throw new Error("Secret is required.");
			
			_secret = secret;
			_requestQueue = new ArrayCollection();
			_loader = new URLLoader();
			
			_loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderSecurityError);
		}
		
		public function identify(userID:String=null, sessionID:String=null, traits:Traits=null, context:Context=null, timestamp:Date=null):void
		{
			if(!userID && !sessionID)
				throw new Error("Either userID or sessionID is required.");
			
			var req:URLRequest = _buildIdentifyRequest(userID, sessionID, traits, context, timestamp);
			_requestQueue.addItem(req);
			_checkQueue();
		}
		
		public function track(event:String,  properties:Object=null, userID:String=null, sessionID:String=null, context:Context=null, timestamp:Date=null):void
		{
			if(!userID && !sessionID)
				throw new Error("Either userID or sessionID is required.");
			
			var req:URLRequest = _buildTrackRequest(event, properties, userID, sessionID, context, timestamp);
			_requestQueue.addItem(req);
			_checkQueue();
		}
		
		private function _buildIdentifyRequest(userID:String=null, sessionID:String=null, traits:Traits=null, context:Context=null, timestamp:Date=null):URLRequest
		{
			var data:Object = {};
			data.secret = _secret;
			
			if(!userID && !sessionID)
				throw new Error("Either userID or sessionID is required.");
			
			if(userID)
				data.userID = userID
				
			if(traits)
				data.traits = traits;
			
			if(timestamp)
				data.timestamp = timestamp;
			
			if(sessionID)
				data.sessionID = sessionID;
			
			if(context)
				data.context = context;
			
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.POST;
			var contentType:URLRequestHeader = new URLRequestHeader("Content-Type", "application/json");
			req.requestHeaders.push(contentType);
			req.data = JSON.stringify(data);
			req.url = "https://api.segment.io/v1/identify";
			
			return req; 
		}
		
		private function _buildTrackRequest(event:String, properties:Object=null, userID:String=null, sessionID:String=null, context:Context=null, timestamp:Date=null):URLRequest
		{
			var data:Object = {};
			data.secret = _secret;
			
			if(!userID && !sessionID)
				throw new Error("Either userID or sessionID is required.");
			
			if(userID)
				data.userID = userID
			
			if(properties)
				data.traits = properties;
			
			if(timestamp)
				data.timestamp = timestamp;
			
			if(sessionID)
				data.sessionID = sessionID;
			
			if(context)
				data.context = context;
			
			var req:URLRequest = new URLRequest();
			req.method = URLRequestMethod.POST;
			var contentType:URLRequestHeader = new URLRequestHeader("Content-Type", "application/json");
			req.requestHeaders.push(contentType);
			req.data = JSON.stringify(data);
			req.url = "https://api.segment.io/v1/track";
			
			return req; 
		}
		
		private function _checkQueue():void
		{
			if(!_activeRequest && _requestQueue.length)
			{
				_activeRequest = true;
				_loader.load(_requestQueue.removeItemAt(0) as URLRequest);
			}
		}
		
		
		// ==========================================
		// Event Handlers
		// ==========================================
		
		protected function onLoaderComplete(event:Event):void
		{
			trace("Call complete");
			_checkQueue();	
		}
		
		protected function onLoaderIOError(event:IOErrorEvent):void
		{
			trace("IOErrorEvent", event.errorID, event.text);
			_checkQueue();	
		}
		
		protected function onLoaderSecurityError(event:SecurityErrorEvent):void
		{
			trace("SecurityErrorEvent", event.errorID, event.text);
			_checkQueue();	
		}
	}
}