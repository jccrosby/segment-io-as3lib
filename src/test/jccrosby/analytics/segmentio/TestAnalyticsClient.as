package test.jccrosby.analytics.segmentio
{
	import com.jccrosby.analytics.segmentio.AnalyticsClient;
	import com.jccrosby.analytics.segmentio.Traits;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Utils3D;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	
	public class TestAnalyticsClient
	{		
		private var _client:AnalyticsClient;
		private var _secret:String = "qjicu7iwubdcvax5uca8";
		private var _sessionID:String;
		private var _callCount:int = 0;
		
		[Before]
		public function setUp():void
		{
			_client = new AnalyticsClient(_secret);
			_sessionID = new Date().dateUTC.toString();
		}
		
		[After]
		public function tearDown():void
		{
			_client = null;
			_sessionID = null;
			_callCount = 0;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testAnalyticsClient():void
		{
			var client:AnalyticsClient = new AnalyticsClient(_secret);
			assertThat(client is AnalyticsClient);
		}
		
		private function _handleTimeout(data:Object):void
		{
			Assert.fail("Async Timeout on " + data.name);
		}
		
		// ======================================
		// Test UserID Identify
		// ======================================
		
		[Test(async, description="UserID Identify Async")]
		public function testUserIDIdentify():void
		{
			var userID:String = "testUser";
			var traits:Traits = new Traits();
			traits.created = new Date();
			traits.email = "test@domain.com";
			try 
			{
				var completeHandler:Function = Async.asyncHandler(this, _onUserIDIdentifyComplete, 1000, {name:"testUserIDIdentify"}, _handleTimeout);
				_client.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
				
				_client.identify(userID, null, traits, null, new Date());
			}
			catch(e:Error)
			{
				Assert.fail("testUserIDIdentify: " + e.message);
			}
		}
		
		private function _onUserIDIdentifyComplete(event:Event, data:Object):void
		{
			_client.removeEventListener(Event.COMPLETE, _onUserIDIdentifyComplete);
			Assert.assertTrue("testUserIDIdentify", true);
		}
		
		[Test(async, description="SessionID Identify Async")]
		public function testSessionIDIdentify():void
		{
			var traits:Traits = new Traits();
			traits.created = new Date();
			traits.email = "test@domain.com";
			try 
			{
				var completeHandler:Function = Async.asyncHandler(this, _onSessionIDIdentifyComplete, 1000, {name:"testSessionIDIdentify"}, _handleTimeout);
				_client.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
				
				_client.identify(_sessionID, null, traits, null, new Date());
			}
			catch(e:Error)
			{
				Assert.fail("testSessionIDIdentify: " + e.message);
			}
		}
		
		private function _onSessionIDIdentifyComplete(event:Event, data:Object):void
		{
			_client.removeEventListener(Event.COMPLETE, _onSessionIDIdentifyComplete);
			Assert.assertTrue("testSessionIDIdentify", true);
		}
		
		
		// ======================================
		// Test Track
		// ======================================
		
		[Test(async, description="UserID Track Async")]
		public function testUserIDTrack():void
		{
			var userID:String = "testUser";
			var properties:Object = {
				unitTest: true,
				testName: "testSessionIDTrack",
				timeStamp: new Date()
			};
			
			try 
			{
				var completeHandler:Function = Async.asyncHandler(this, _onUserIDTrackComplete, 1000, {name:"testUserIDTrack"}, _handleTimeout);
				_client.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
				
				_client.track("unitTest", properties, userID, null, null, new Date());
			}
			catch(e:Error)
			{
				Assert.fail("testSessionIDIdentify: " + e.message);
			}
		}
		
		private function _onUserIDTrackComplete(event:Event, data:Object):void
		{
			_client.removeEventListener(Event.COMPLETE, _onUserIDTrackComplete);
			Assert.assertTrue("testUserIDTrack", true);
		}
		
		[Test(async, description="SessionID Track Async")]
		public function testSessionIDTrack():void
		{
			var properties:Object = {
				unitTest: true,
				testName: "testSessionIDTrack",
				timeStamp: new Date()
			};
			
			try 
			{
				var completeHandler:Function = Async.asyncHandler(this, _onSessionIDTrackComplete, 1000, {name:"testSessionIDTrack"}, _handleTimeout);
				_client.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
				
				_client.track("unitTest", properties, null, _sessionID, null, new Date());
			}
			catch(e:Error)
			{
				Assert.fail("testSessoionIDTrack: " + e.message);
			}
		}
		
		private function _onSessionIDTrackComplete(event:Event, data:Object):void
		{
			_client.removeEventListener(Event.COMPLETE, _onSessionIDTrackComplete);
			Assert.assertTrue("testSessionIDTrack", true);
		}
		
		// TODO: Figure out how to test the call queue
	}
}