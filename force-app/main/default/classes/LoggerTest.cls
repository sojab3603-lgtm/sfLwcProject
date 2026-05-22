public class LoggerTest {

    public static void testLogger() {

        IntegrationLogger.log(
            'Success',
            'Test Request',
            'Test Response',
            null,
            'callout:CustomerAPI/users'
        );
    }
}