package test.jccrosby.analytics.segmentio
{
	import com.jccrosby.analytics.segmentio.Context;
	
	import flexunit.framework.Assert;
	
	import mx.utils.ObjectUtil;
	
	public class TestContext
	{		
		private var _context:Context;
		private var _nameList:String = "Bitdeli,Chartbeat,Clicky,comScore,CrazyEgg,Customer.io,Errorception,FoxMetrics,Gauges,Google Analytics,GoSquared,HitTail,HubSpot,Intercom,Keen IO,KISSmetrics,Klaviyo,LiveChat,Marketo,Mixpanel,Olark,Pardot,Perfect Audience,Quantcast,Salesforce,Segment.io,SnapEngage,USERcycle,UserVoice,Vero,Woopra";
		private var _providerList:Array;
		
		[Before]
		public function setUp():void
		{
			_context = new Context();
			_providerList = _nameList.split(",");
		}
		
		[After]
		public function tearDown():void
		{
			_context = null;
			_providerList = null;
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
		public function testGet_providers():void
		{
			Assert.assertTrue(_context.providers is Object);
			
			// Google Analytics
			Assert.assertFalse(_context.providers["Google Analytics"]);
			
			_context.googleAnalytics = true;
			Assert.assertTrue(_context.providers["Google Analytics"]);
			
			// GoSquared
			Assert.assertFalse(_context.providers["GoSquared"]);
			
			// All provider types
			_context.goSquared = true;
			Assert.assertTrue(_context.providers["GoSquared"]);
			
			for(var providerName:String in _context.providers)
			{
				Assert.assertTrue(providerName, _providerList.indexOf(providerName) > -1);
			}
		}
	}
}