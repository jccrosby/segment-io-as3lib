package com.jccrosby.analytics.segmentio
{
	import flash.utils.describeType;
	import flash.xml.XMLNode;

	public class Context
	{
		private var _providers:Object
		private var _all:Boolean;
		public var bitdeli:Boolean;
		public var chartbeat:Boolean;
		public var clicky:Boolean;
		public var comScore:Boolean;
		public var crazyEgg:Boolean;
		public var customerIO:Boolean;
		public var errorception:Boolean;
		public var foxMetrics:Boolean;
		public var gauges:Boolean;
		public var googleAnalytics:Boolean;
		public var goSquared:Boolean;
		public var hitTail:Boolean;
		public var hubSpot:Boolean;
		public var intercom:Boolean;
		public var keenIO:Boolean;
		public var kissMetrics:Boolean;
		public var klaviyo:Boolean;
		public var liveChat:Boolean;
		public var marketo:Boolean;
		public var mixpanel:Boolean;
		public var olark:Boolean;
		public var pardot:Boolean;
		public var perfectAudience:Boolean;
		public var quantcast:Boolean;
		public var salesforce:Boolean;
		public var segmentIO:Boolean;
		public var snapEngage:Boolean;
		public var userCycle:Boolean;
		public var userVoice:Boolean;
		public var vero:Boolean;
		public var woopra:Boolean;
		
		public function get all():Boolean
		{
			return _all;
		}

		public function set all(value:Boolean):void
		{
			if(_all != value)
			{
				_all = value;
				for(var prop:String in this) 
				{
					this[prop] = _all;
				}
			}
		}

		public function get providers():Object
		{
			if(!_providers)
				_providers = {};
			
			var objXML:XML = describeType(this);
			var propList:XMLList = objXML..variable;
			for each(var node:XML in propList)
			{
				var providerName:String = node.@name;
				
				switch(providerName)
				{
					case "customerIO": 
					{
						providerName = "Customer.io";
						break;
					}
					case "googleAnalytics":
					{
						providerName = "Google Analytics";
						break;
					}
					case "keenIO":
					{
						providerName = "Keen IO";
						break;
					}
					case "kissMetrics":
					{
						providerName = "KISSmetrics";
						break;
					}
					case "perfectAudience":
					{
						providerName = "Perfect Audience";
						break;
					}
					case "segmentIO":
					{
						providerName = "Segment.io";
						break;
					}
					case "comScore":
					{
						providerName = "comScore";
						break;
					}
					case "salesForce":
					{
						providerName = "Salesforce";
						break;
					}
					case "userCycle":
					{
						providerName = "USERcycle";
						break;
					}
					default:
					{
						var firstChar:String = providerName.substr(0, 1);
						var restOfString:String = providerName.substr(1, providerName.length);
						providerName = firstChar.toUpperCase() + restOfString;		
					}
				}
				_providers[providerName] = this[node.@name];
			}
			return _providers;
		}


	}
}