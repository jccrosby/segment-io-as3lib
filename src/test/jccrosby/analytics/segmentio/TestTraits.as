package test.jccrosby.analytics.segmentio
{
	import com.jccrosby.analytics.segmentio.Traits;
	
	import flexunit.framework.Assert;

	public class TestTraits
	{		
		private var _traits:Traits;
		
		[Before]
		public function setUp():void
		{
			_traits = new Traits();
		}
		
		[After]
		public function tearDown():void
		{
			_traits = null;
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
		public function testAddDynamicProperty():void
		{
			Assert.assertNull(_traits.newProperty);
			_traits.newProperty = "tested";
			Assert.assertNotNull(_traits.newProperty);
		}
		
		[Test]
		public function testToJSON():void
		{
			_traits.created = new Date();
			_traits.email = "test@domain.com";
			_traits.firstName = "John";
			_traits.lastName = "Doe";
			_traits.dynamicVariable = "dynamicValue";
			
			var traitJSON:String = _traits.stringify();
			
			Assert.assertNotNull(traitJSON);
			
			var obj:Object = JSON.parse(traitJSON);
			Assert.assertTrue("Email", obj.email == "test@domain.com");
			Assert.assertTrue("First name", obj.firstName == "John");
			Assert.assertTrue("Last name", obj.lastName == "Doe");
			Assert.assertTrue("Dynamic variable", obj.dynamicVariable == "dynamicValue");
		}
	}
}