/**
 * WrapperTest
 *
 * Brief: Unit tests for CustomerWrapper serialization/deserialization.
 * Responsibilities:
 *  - Validate that CustomerWrapper can be deserialized from JSON and retains expected fields
 *  - Provide simple assertions for nested AddressWrapper mapping
 *
 * Note: Keep test data inline and deterministic.
 */
@isTest
public class WrapperTest {
    public static void testWrapper() {
        String jsonData = '{"id":123,"name":"Ravi","email":"ravi@example.com","address":{"city":"Delhi"}}';
        CustomerWrapper customer = (CustomerWrapper) JSON.deserialize(jsonData, CustomerWrapper.class);
        System.assertEquals('Ravi', customer.name);
        System.assertEquals('Delhi', customer.address.city);
    }
}