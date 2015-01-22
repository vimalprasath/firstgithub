public class MockHttpResponseGenerator_xmldom {
    // Implement this interface method
    public static HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
         
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('D1234567<');
        res.setStatusCode(404);
        return res;
    }
}