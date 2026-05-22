public class WrapperTest {

    public static void testWrapper() {

        String jsonData =
        '{"id":1,"name":"John",' +
        '"email":"john@test.com",' +
        '"phone":"99999",' +
        '"address":{"city":"Delhi"}}';

        CustomerWrapper customer =
            (CustomerWrapper)
            JSON.deserialize(
                jsonData,
                CustomerWrapper.class
            );

        System.debug(customer.name);

        System.debug(customer.address.city);
    }
}