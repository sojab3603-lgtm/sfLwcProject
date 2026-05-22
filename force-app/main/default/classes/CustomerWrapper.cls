/**
 * CustomerWrapper
 *
 * Brief: Simple data transfer object used to encapsulate customer information
 * for serialization/deserialization when communicating with external systems.
 * Responsibilities:
 *  - Hold primitive customer fields and nested address wrapper
 *  - Provide lightweight constructors for mapping from SObjects
 *
 * Note: This class is designed for JSON (de)serialization via JSON.serialize/deserialize.
 */
public class CustomerWrapper {
    public Integer id;
    public String name;
    public String email;
    public String phone;
    public AddressWrapper address;

    // Default no-arg constructor
    public CustomerWrapper() {}

    // Construct wrapper from a Contact SObject for integration calls
    public CustomerWrapper(Contact c) {
        this.id = (Integer) null; // map appropriately if using custom Id mapping
        this.name = c.Name;
        this.email = c.Email;
        this.phone = c.Phone;
        this.address = new AddressWrapper();
        // Map address fields if present on Contact (example)
        this.address.city = '';
    }

    // Nested wrapper for address details
    public class AddressWrapper {
        public String city;
        public AddressWrapper() {}
    }
}