/**
 * HttpUtilityTest
 *
 * Brief: Unit tests for HttpUtility helper methods.
 * Responsibilities:
 *  - Provide coverage for request construction and execution logic
 *  - Use HttpCalloutMock to simulate external responses
 *
 * Note: Keep tests deterministic and avoid real callouts.
 */
@isTest
private class HttpUtilityTest {
    // Test that buildRequest sets common headers and timeout
    public static void testBuildRequest() {
        HttpRequest req = HttpUtility.buildRequest('https://example.com', 'GET');
        System.assertEquals('https://example.com', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        System.assertEquals('application/json', req.getHeader('Content-Type'));
        System.assertEquals(20000, req.getTimeout());
    }

    // Test execute method using a mock callout
    public static void testExecuteCallout() {
        // Register named mock implementation to avoid anonymous-class parsing issues
        Test.setMock(HttpCalloutMock.class, new MockHttpCallout());

        HttpRequest req = HttpUtility.buildRequest('https://example.com', 'GET');
        HttpResponse res = HttpUtility.execute(req);
        System.assertEquals(200, res.getStatusCode());
    }

    // Named mock class for HTTP callouts
    private class MockHttpCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HTTPResponse res = new HTTPResponse();
            res.setStatusCode(200);
            res.setBody('{"ok":true}');
            return res;
        }
    }
}