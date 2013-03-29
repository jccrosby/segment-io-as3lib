# ActionScript 3 Library for the [Segment.io](http://segment.io) [REST API](https://segment.io/api/rest)

## Installation and setup  
* Project Type: Flex Library
* Flex SDK: 4.6

## Usage  
The library mirrors the segment.io [REST API](https://segment.io/api/rest), but doesn't yet implement "import"

### Identify  
	var secret:String = "MY_SEGMENT_IO_SECRET";
	var client:AnalyticsCLient = new AnalyticsClient(secret);
	
	var traits:Traits = new Traits();
	traits.created = new Date();
	traits.email = "test@domain.com";
	
	var context:Context = new Context();
	context.googleAnalytics = true;
	
	// For userId
	client.identify("userID", traits, context, new Date());

### Track  
	var secret:String = "MY_SEGMENT_IO_SECRET";
	var client:AnalyticsCLient = new AnalyticsClient(secret);
	
	var userID:String = "testUser";
	var properties:Object = {
		unitTest: true,
		testName: "testSessionIDTrack",
		timeStamp: new Date()
	};
	var context:Context = new Context();
	context.googleAnalytics = true;
	
	client.track(userID, "myEvent", properties, context, new Date());

## Context & Selecting Providers 
[Segment.io Context documentation](https://segment.io/docs/methods/identify#choosing-providers)
 
	var context:Context = new Context();

	// Turn on specific providers
	context.googleAnalytics = true;
	
	context.all = true; // "Turns on" all providers (Default is false)
	
	// Turn off specific providers
	context.clicky = false;
	context.kissMetrics = false;

## To Do
[ ] Implement "import"  
[ ] Add additional unit tests  

## License  
Author: John Crosby  
[http://thekuroko.com](http://thekuroko.com)  
Copyright &copy; 2013 John Crosby  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
