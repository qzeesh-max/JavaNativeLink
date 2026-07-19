public class Main {
    public static void main(String[] args) {
        System.out.println("Starting MyClass test...");

        // The try-with-resources block ensures the C++ destructor is called
        try (MyClass obj = new MyClass(42, "Example")) {
            obj.print();

            int result = obj.add(8);
            System.out.println("add(8) = " + result);

            String greeting = obj.greet("World");
            System.out.println(greeting);

            // Access fields via generated getters/setters
            System.out.println("value = " + obj.get_value());
            obj.set_value(100);
            System.out.println("value after set = " + obj.get_value());
            System.out.println("name = " + obj.get_name());
        }

        System.out.println("Test finished!");
    }
}
