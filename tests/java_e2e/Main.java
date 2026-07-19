public class Main {
    public static void main(String[] args) {
        System.out.println("Java: Starting advanced test...");
        try (Point p = new Point(100, 200)) {
            p.print();
            
            // Test unsigned
            long uRes = p.multiplyUnsigned(4294967295L, 2L);
            System.out.println("Java: p.multiplyUnsigned(0xFFFFFFFF, 2) = " + uRes + " (expected 4294967294 or 0xFFFFFFFE)");
            
            // Test references
            int[] refVal = new int[]{ 5 };
            p.incReference(refVal);
            System.out.println("Java: p.incReference(5) -> " + refVal[0] + " (expected 15)");
            
            // Test Exception
            try {
                p.set_x(500);
        System.out.println("Java: p.get_x() = " + p.get_x() + " (expected 500)");
        
        System.out.println("Java: Calling crashMe()...");
                p.crashMe();
                System.out.println("Java: ERROR, crashMe() did not throw!");
            } catch (RuntimeException e) {
                System.out.println("Java: Caught expected exception: " + e.getMessage());
            }
        }
        System.out.println("Java: Test finished!");
    }
}
