package test.jccrosby.analytics.segmentio
{
	import com.jccrosby.analytics.segmentio.AnalyticsClient;
	import com.jccrosby.analytics.segmentio.Traits;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	
	public class TestAnalyticsClient
	{		
		private var _client:AnalyticsClient;
		private var _secret:String = "qjicu7iwubdcvax5uca8";
		
		[Before]
		public function setUp():void
		{
			_client = new AnalyticsClient(_secret);
		}
		
		[After]
		public function tearDown():void
		{
			_client = null;
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
		
		[Test]
		public function testUserIDIdentify():void
		{
			var userID:String = "testUser";
			var traits:Traits = new Traits();
			traits.created = new Date();
			traits.email = "test@domain.com";
			try 
			{
				_client.identify(userID, null, traits, null, new Date());
				Assert.assertTrue("testUserIDIdentify", true);
			}
			catch(e:Error)
			{
				Assert.fail("testUserIDIdentify: " + e.message);
			}
		}
		
		[Test]
		public function testTrack():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}