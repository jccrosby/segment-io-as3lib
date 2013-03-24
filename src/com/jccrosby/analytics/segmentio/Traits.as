package com.jccrosby.analytics.segmentio
{
	public dynamic class Traits
	{
		public var created:Date;
		public var email:String;
		public var firstName:String;
		public var lastName:String;
		public var name:String;
		public var username:String;
		
		public function stringify():String
		{
			return JSON.stringify(this);
		}
	}
}