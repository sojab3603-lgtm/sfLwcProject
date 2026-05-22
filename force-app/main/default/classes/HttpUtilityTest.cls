public class HttpUtilityTest {

    public static void testCallout() {

        HttpResponse response =
            HttpUtility.sendRequest(
                'callout:CustomerAPI/users',
                'GET'
            );

        System.debug(
            response.getBody()
        );
    }
}